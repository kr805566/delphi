//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
#include "Unit1.h"
#include <stdio.h>
#include <iostream>
#include <string>
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TForm1 *Form1;
enum {
	SKYPECONTROLAPI_ATTACH_SUCCESS=0,		// Client is successfully attached and API window handle can be found in wParam parameter
	SKYPECONTROLAPI_ATTACH_PENDING_AUTHORIZATION=1,	// Skype has acknowledged connection request and is waiting for confirmation from the user.
							// The client is not yet attached and should wait for SKYPECONTROLAPI_ATTACH_SUCCESS message
	SKYPECONTROLAPI_ATTACH_REFUSED=2,		// User has explicitly denied access to client
	SKYPECONTROLAPI_ATTACH_NOT_AVAILABLE=3,		// API is not available at the moment. For example, this happens when no user is currently logged in.
                                                        // Client should wait for SKYPECONTROLAPI_ATTACH_API_AVAILABLE broadcast before making any further
                  					// connection attempts.
	SKYPECONTROLAPI_ATTACH_API_AVAILABLE=0x8001
};
//---------------------------------------------------------------------------
__fastcall TForm1::TForm1(TComponent* Owner)
        : TForm(Owner)
{
    //Register
    uiGlobal_MsgID_SkypeControlAPIAttach = RegisterWindowMessage("SkypeControlAPIAttach");
    uiGlobal_MsgID_SkypeControlAPIDiscover = RegisterWindowMessage("SkypeControlAPIDiscover");

    /// Broadcast!
    SendMessage( HWND_BROADCAST, uiGlobal_MsgID_SkypeControlAPIDiscover, (WPARAM)Form1->Handle, 0);
}


void __fastcall TForm1::WndProc(TMessage & msg){

    TForm::WndProc(msg);//¥Î°ò¥»ªºWndProc¨ç‡ÛÅýWindows¨ä¥Lµ{¦¡¥h³B²z~

    if( msg.Msg == uiGlobal_MsgID_SkypeControlAPIAttach ){
        switch(msg.LParam)
            {
            case SKYPECONTROLAPI_ATTACH_SUCCESS:
                MessageBox(this->Handle,"!!! Connected; to terminate issue #disconnect\n",
                            "Skype Processing",
                            MB_OK | MB_ICONINFORMATION);
                hGlobal_SkypeAPIWindowHandle=(HWND)msg.WParam;
                break;
            case SKYPECONTROLAPI_ATTACH_PENDING_AUTHORIZATION:
                MessageBox(this->Handle,"!!! Pending authorization\n",
                            "Skype Processing",
                            MB_OK | MB_ICONINFORMATION);
                break;
            case SKYPECONTROLAPI_ATTACH_REFUSED:
                MessageBox(this->Handle,"!!! Connection refused\n",
                            "Skype Processing",
                            MB_OK | MB_ICONINFORMATION);
                break;
            case SKYPECONTROLAPI_ATTACH_NOT_AVAILABLE:
                MessageBox(this->Handle,"!!! Skype API not available\n",
                            "Skype Processing",
                            MB_OK | MB_ICONINFORMATION);
                break;
            case SKYPECONTROLAPI_ATTACH_API_AVAILABLE:
                MessageBox(this->Handle,"!!! Try connect now (API available); issue #connect\n",
                            "Skype Processing",
                            MB_OK | MB_ICONINFORMATION);
                break;
            }
    }
    else if( msg.Msg==WM_COPYDATA ){
        if( hGlobal_SkypeAPIWindowHandle==(HWND)msg.WParam )
	{
	    PCOPYDATASTRUCT poCopyData = (PCOPYDATASTRUCT)msg.LParam;
	    CHAR szMsg[1000];
	    UINT nSize = poCopyData->cbData > 1000 ? 1000 : poCopyData->cbData;
	    strncpy(szMsg, (LPCSTR)poCopyData->lpData, nSize);

            if( poCopyData!=NULL )
                MessageBox(this->Handle, (LPCSTR)poCopyData->lpData, szMsg, MB_OK | MB_ICONINFORMATION);
        }
        msg.Result = 1;//must return 1, or Skype will disconnect!!!!
    }
}


//---------------------------------------------------------------------------
void __fastcall TForm1::Button1Click(TObject *Sender)
{
    if( hGlobal_SkypeAPIWindowHandle==NULL )
        return;

    PCOPYDATASTRUCT oCopyData = new COPYDATASTRUCT;

    // send command to skype
    char cmd[] = "PING";
    oCopyData->dwData=0;
    oCopyData->lpData=cmd;
    oCopyData->cbData=strlen(cmd)+1;

    if( SendMessage( hGlobal_SkypeAPIWindowHandle, WM_COPYDATA, (WPARAM)Form1->Handle, (LPARAM)oCopyData)<=0 )
        MessageBox(this->Handle, "Error", "Skype Processing", MB_OK | MB_ICONINFORMATION);
}
//---------------------------------------------------------------------------

