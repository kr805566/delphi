unit Unit1; interface uses Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls; type TForm1 = class(TForm)Button1: TButton; procedure Button1Click(Sender: TObject); private public end; var Form1: TForm1; implementation{$R *.dfm}procedure TForm1.Button1Click(Sender: TObject); begin ShowMessage('����'); ShowMessage('����2'); end; end.

