//---------------------------------------------------------------------------

#ifndef Unit1H
#define Unit1H
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>

//---------------------------------------------------------------------------
class TForm1 : public TForm
{
__published:	// IDE-managed Components
        TButton *Button1;
        void __fastcall Button1Click(TObject *Sender);
private:	// User declarations
        HWND hGlobal_SkypeAPIWindowHandle;
        UINT uiGlobal_MsgID_SkypeControlAPIAttach;
        UINT uiGlobal_MsgID_SkypeControlAPIDiscover;
protected:
        //overloading WndProc()處理registerWindowMessage所得的message
        virtual void __fastcall WndProc(TMessage&);
public:		// User declarations
        __fastcall TForm1(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TForm1 *Form1;
//---------------------------------------------------------------------------
#endif
 