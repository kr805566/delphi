�
 TC_FORM_MAIN 0^$  TPF0Tc_form_mainc_form_mainLeftUTop<BorderIconsbiSystemMenu
biMinimize CaptionVC 2.5 Pro - Talk Now DemoClientHeight�ClientWidth
Color	clBtnFaceConstraints.MinHeightrConstraints.MinWidth,DefaultMonitor
dmMainFormFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameTahoma
Font.Style Menu	MainMenu1OldCreateOrder
OnActivateFormActivateOnCloseQueryFormCloseQueryOnCreate
FormCreate	OnDestroyFormDestroyOnShowFormShowPixelsPerInch`
TextHeight 	TSplitterc_splitter_mainLeft Top� Width
HeightCursorcrVSplitAlignalTopBeveled	MinSizeFExplicitWidth  
TStatusBarc_statusBar_mainLeft Top�Width
HeightPanelsWidthd Text(c) 2012 Lake of SoftWidth2    TPanelc_panel_serverLeft Top Width
Height� AlignalTop
BevelOuter	bvLoweredFullRepaintTabOrder
DesignSize
�   TLabelLabel4Left� TopWidth?HeightCaptionSocket &Type:FocusControlc_comboBox_socketTypeServer  TLabelLabel1LeftpTopWidthHeightCaption&Port:FocusControlc_edit_serverPort  TLabelc_label_serverStatLeftTopWidth�HeightAnchorsakLeftakTopakRight AutoSizeCaptionServer:Font.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.StylefsBold 
ParentFontExplicitWidth�  TLabelLabel2LeftpTopDWidthSHeightCaption&Bind to interface:  TLabelc_label_srCodecInfoLeft(Top\Width;HeightCaptionsrCodecInfo  	TComboBoxc_comboBox_socketTypeServerLeft� Top$WidthMHeightStylecsDropDownListTabOrderOnChange!c_comboBox_socketTypeServerChangeItems.StringsUDPTCP   TEditc_edit_serverPortLeftpTop$Width]HeightTabOrderText17820  TProgressBarc_pb_serverInLeftTop� Width]HeightMax,Smooth	TabOrder   TButtonc_button_serverStopLeftTopHWidth]HeightActiona_server_stopTabOrder  TButtonc_button_serverStartLeftTop,Width]HeightActiona_server_startTabOrder  TButtonc_button_configAudioSrvLeftTop� Width]HeightCaption&Audio Options..TabOrderOnClickc_button_configAudioSrvClick  TCheckListBoxc_clb_serverLeft(TopWidth�HeightIAnchorsakLeftakTopakRight Font.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameLucida Console
Font.Style 
ItemHeightItems.StringswaveIncodecInipServercodecOutwaveOut 
ParentFontTabOrder  TProgressBarc_pb_serverOutLeftTop� Width]HeightMax,Smooth	TabOrder  TPanelc_panel_serverGraphLeftpToplWidthgHeightUAnchorsakLeftakTopakRightakBottom 
BevelInner	bvLowered
BevelOuterbvNoneTabOrder	  	TComboBoxc_cb_serverBindToLeftpTopTWidth� HeightTabOrder  	TCheckBoxc_cb_serverIOCPLeft� Top<WidthIHeightCaptionIOCPTabOrder
OnClickc_cb_serverIOCPClick  	TCheckBoxc_cb_monServerEnabledLeftoTop� WidthIHeightAnchorsakLeftakBottom CaptionEnabledChecked	State	cbCheckedTabOrderOnClickc_cb_monServerEnabledClick  TButtonc_button_kickLeftTopdWidth]HeightCaptionKick ClientEnabledTabOrderOnClickc_button_kickClick  TButtonSendLeft� Top� WidthKHeightCaptionSendTabOrderOnClick	SendClick   TPanelc_panel_clientLeft Top� Width
Height� AlignalClient
BevelOuter	bvLoweredTabOrder
DesignSize
�   TLabelLabel3Left$TopWidthBHeightCaptionRemote &Host:FocusControlc_edit_clientHost  TLabelLabel5Left� TopWidth?HeightCaptionSocket T&ype:FocusControlc_comboBox_socketTypeClient  TLabelc_label_clientStatLeftTopWidth�HeightAnchorsakLeftakTopakRight AutoSizeCaptionClient:Font.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.StylefsBold 
ParentFontExplicitWidth�  TLabelLabel6LeftpTopWidth@HeightCaptionRemote P&ort:FocusControlc_edit_clientPort  TLabelc_label_clCodecInfoLeft�TopXWidth9HeightCaptionclCodecInfo  TLabelLabel8Left$Top@WidthTHeightCaptionBind to local port:FocusControlc_cln_bindToPort  TLabelLabel9LeftpTop@WidthSHeightCaption&Bind to interface:  TProgressBarc_pb_clientInLeftTop� Width]HeightMax,Smooth	TabOrder   TProgressBarc_pb_clientOutLeftTop� Width]HeightMax,Smooth	TabOrder  TButtonc_button_clientStartLeftTop)Width]HeightActiona_client_startTabOrder  TButtonc_button_clientStopLeftTopHWidth]HeightActiona_client_stopTabOrder  TButtonc_button_configAudioClnLeftTopxWidth]HeightCaptionA&udio Options..TabOrderOnClickc_button_configAudioClnClick  TEditc_edit_clientHostLeft$Top$Width]HeightTabOrderText192.168.1.1  TEditc_edit_clientPortLeftpTop$Width]HeightTabOrderText17820  	TComboBoxc_comboBox_socketTypeClientLeft� Top$WidthIHeightStylecsDropDownListTabOrderOnChange!c_comboBox_socketTypeClientChangeItems.StringsUDPTCP   TCheckListBoxc_clb_clientLeft�TopWidthOHeightIAnchorsakLeftakTopakRight Font.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameLucida Console
Font.Style 
ItemHeightItems.StringswaveIncodecInipClientcodecOutwaveOut 
ParentFontTabOrder
  TPanelc_panel_clientGraphLeftpTophWidthgHeight!AnchorsakLeftakTopakRightakBottom 
BevelInner	bvLowered
BevelOuterbvNoneTabOrder  	TComboBoxc_cln_bindToIPLeftpTopPWidth� HeightTabOrder  TEditc_cln_bindToPortLeft$TopPWidth]HeightTabOrder	  	TCheckBoxc_cb_clientIOCPLeft� Top<WidthIHeightCaptionIOCPTabOrderOnClickc_cb_clientIOCPClick  	TCheckBoxc_cb_monClientEnabledLeftoTop� WidthMHeightAnchorsakLeftakBottom CaptionEnabledChecked	State	cbCheckedTabOrderOnClickc_cb_monClientEnabledClick   TunavclIPOutStreamipClientconsumercodecOut_clientbindTo0.0.0.0
onTextDataipClientTextDataonPacketEventipClientPacketEventonSocketEventipClientSocketEvent
onDataSentipClientDataSentisFormatProvider	
bindToPort0onClientDisconnectipClientClientDisconnectLeft�Toph  TunavclIPInStreamipServerconsumercodecOut_serverbindTo0.0.0.0
onTextDataipServerTextDataonPacketEventipServerPacketEventonSocketEventipServerSocketEvent
onDataSentipServerDataSentLeft�Top�   TunavclWaveOutDevicewaveOut_clientdeviceId�
calcVolume	playbackOptionsunapo_smoothStartupunapo_jitterRepeat LeftToph  TunavclWaveOutDevicewaveOut_serverdeviceId�
calcVolume	playbackOptionsunapo_smoothStartupunapo_jitterRepeat LeftTop�   TActionListc_actionList_mainLeft� Top�  TActiona_server_startCaption&Listen	OnExecutea_server_startExecute  TActiona_server_stopCaption&StopEnabled	OnExecutea_server_stopExecute  TActiona_client_startCaption&Connect	OnExecutea_client_startExecute  TActiona_client_stopCaption&DisconnectEnabled	OnExecutea_client_stopExecute   TTimerc_timer_updateInterval� OnTimerc_timer_updateTimerLeft Top�   TunavclWaveInDevicewaveIn_clientconsumercodecIn_clientonDataAvailablewaveIn_clientDataAvailabledeviceId�
calcVolume	Left�Toph  TunavclWaveInDevicewaveIn_serverconsumercodecIn_serverdeviceId�
calcVolume	Left�Top�   TunavclWaveCodecDevicecodecIn_clientconsumeripClient	formatTag1Left�Toph  TunavclWaveCodecDevicecodecOut_clientconsumerwaveOut_client
inputIsPcmformatTagImmunableLeft�Toph  TunavclWaveCodecDevicecodecIn_serverconsumeripServer	formatTag1Left�Top�   TunavclWaveCodecDevicecodecOut_serverconsumerwaveOut_server
inputIsPcmformatTagImmunableLeft�Top�   	TMainMenu	MainMenu1Left Top�  	TMenuItemmi_file_rootCaption&File 	TMenuItemmi_file_listenActiona_server_start  	TMenuItemmi_file_stopActiona_server_stop  	TMenuItemN1Caption-  	TMenuItemmi_file_connectActiona_client_start  	TMenuItemmi_file_disconnectActiona_client_stop  	TMenuItemN2Caption-  	TMenuItemmi_file_exitCaptionE&xitShortCutQ@OnClickmi_file_exitClick   	TMenuItemmi_options_rootCaptionOptio&ns 	TMenuItemmi_options_autoActivateSrvCaptionActivate Server on StartupOnClickmi_options_autoActivateSrvClick  	TMenuItemmi_options_LLNCaptionLong Latency NetworksOnClickmi_options_LLNClick  	TMenuItemmi_switch2RAWCaptionSwitch to RAWVisibleOnClickmi_switch2RAWClick  	TMenuItemN3Caption-  	TMenuItemmi_options_maxClientsCaptionMax. Number of Clients 	TMenuItemmi_options_maxClients_1TagCaption1Checked		RadioItem	OnClicknumClientsClick  	TMenuItemmi_options_maxClients_2TagCaption2	RadioItem	OnClicknumClientsClick  	TMenuItemmi_options_maxClients_10Tag
Caption10	RadioItem	OnClicknumClientsClick  	TMenuItemN4Caption-  	TMenuItemmi_options_maxClients_unlimitedTag�Caption	Unlimited	RadioItem	OnClicknumClientsClick    	TMenuItemmi_help_rootCaptionH&elp 	TMenuItemmi_help_aboutCaptionAboutOnClickmi_help_aboutClick    TTimerTimer1OnTimerTimer1TimerLeft� Top�   TTimerTimer2EnabledOnTimerTimer2TimerLeft(Top�    