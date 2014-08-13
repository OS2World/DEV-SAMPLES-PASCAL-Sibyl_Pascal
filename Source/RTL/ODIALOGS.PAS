UNIT ODialogs;

{**************************************************************************
 *                                                                        *
 *    Dialog box definitions for Object-PM                                *
 *    (C) 1993,94 Vision Software Chemnitz                                *
 *                                                                        *
 *    Last modified: 30.10.1994                                           *
 *                                                                        *
 **************************************************************************}

{$R-,D-,S-}


INTERFACE

USES ObjectPM,PmWin,PmStdDlg;

TYPE
     {List for List boxes}
     PListBoxItems=^TListBoxItems;
     TListBoxItems=RECORD
                         item:STRING;
                         aindex:WORD;
                         Data:POINTER; {Private data}
                         cbData:LONGWORD; {Count of private data}
                         Next:PListBoxItems;
                   END;

CONST
   {VMT Indices}
   TDialog_HandleEvent    :WORD      = 5;        {_VMT_}
   TDialog_DefDlgProc     :WORD      = 6;

TYPE
    PDialog=^TDialog;
    TDialog=OBJECT(TOPMLObject)
                   HwndDlg:Hwnd;
                   {*******Do not change this location -- its hard coded***}
                   FUNCTION DialogHandleEvent(Dlg:HWND;Msg:LONGWORD; {_VMT_}
                            Para1,Para2:LONGWORD):LONGWORD;VIRTUAL  {index 5};
                   PROCEDURE DefDlgProc(VAR Msg: TMessage);VIRTUAL  {index 6};
                   {*******************************************************}
                   CONSTRUCTOR Init(Parent,Owner:HWND;hmod:HModule;idDlg:LONGWORD;
                                    pCreateParams:Pointer);
                   DESTRUCTOR Done;VIRTUAL;
                   FUNCTION ExecDialog:LONGWORD;VIRTUAL;
                   PROCEDURE GetDlg(VAR Dlg:HWND);VIRTUAL;
                   PROCEDURE CenterDlgBox(Dlg:HWND);VIRTUAL;

                   PROCEDURE WMInitDlg(VAR Msg:TMessage);
                                           VIRTUAL WM_FIRST+WM_INITDLG;
                   PROCEDURE WMControl(VAR Msg:TMessage);
                                           VIRTUAL WM_FIRST+WM_CONTROL;
                   PROCEDURE WMCommand(VAR Msg:TMessage);
                                           VIRTUAL WM_FIRST+WM_COMMAND;
             END;


    PNoteBookPages=^TNoteBookPages;
    TNoteBookPages=RECORD
                         Dlg:PDialog;
                         id:ULONG;
                         next:PNoteBookPages;
                   END;

    PNoteBookDialog=^TNoteBookDialog;
    TNoteBookDialog=OBJECT(TDialog)
                        NotebookID:LONGWORD;
                        Notebook:HWND;
                        ActualPageID:ULONG;
                        Pages:PNoteBookPages;
                        CONSTRUCTOR Init(Parent,Owner:HWND;hmod:HModule;
                                         idDlg,idNotebook:LONGWORD;
                                         pCreateParams:Pointer);
                        DESTRUCTOR Done;VIRTUAL;
                        FUNCTION InsertPage(id:ULONG;Dlg:PDialog;
                                            Order,Options:WORD;
                                            TabText,StatusText:STRING):ULONG;VIRTUAL;
                        PROCEDURE PageOpened(id:ULONG;Dlg:PDialog);VIRTUAL;
                        PROCEDURE PageClosed(id:ULONG;Dlg:PDialog);VIRTUAL;
                        FUNCTION GetDlgFromID(id:ULONG):PDialog;VIRTUAL;
                        FUNCTION GetIDFromDlg(Dlg:PDialog):ULONG;VIRTUAL;
                        PROCEDURE SelectPage(id:ULONG);VIRTUAL;

                        PROCEDURE SetMajorTabDimensions(W,H:WORD);VIRTUAL;
                        PROCEDURE SetMinorTabDimensions(W,H:WORD);VIRTUAL;
                        PROCEDURE SetPageButtonDimensions(W,H:WORD);VIRTUAL;
                        PROCEDURE InitializeNoteBookPages;VIRTUAL;
                        PROCEDURE DestroyNoteBookPages;VIRTUAL;
                        PROCEDURE SetColors(typ:WORD;value:LONGINT);VIRTUAL;

                        PROCEDURE WMInitDlg(VAR Msg:TMessage);
                                           VIRTUAL WM_FIRST+WM_INITDLG;
                        PROCEDURE WMControl(VAR Msg:TMessage);
                                           VIRTUAL WM_FIRST+WM_CONTROL;
                        PROCEDURE WMClose(VAR msg:TMessage);
                                           VIRTUAL WM_FIRST+WM_CLOSE;
             END;

VAR
    FileOpenDlgWildCards:STRING;
    FileOpenDlgTitle:String[40];
    FileOpenDlgOkName:String[40];
    FileSaveDlgWildCards:STRING;
    FileSaveDlgTitle:String[40];
    FileSaveDlgOkName:String[40];

    StdDlgProcAddr:POINTER;
    StartDlgProcAddr:POINTER;

FUNCTION FileOpenDialog(Win:HWND;VAR result:STRING):Boolean;
FUNCTION FileSaveDialog(Win:HWND;VAR result:STRING):Boolean;

FUNCTION ListBoxInsertString(Dlg:HWND;where:LONGINT;s:STRING):WORD;
PROCEDURE FillListBox(Dlg:HWND;id:LONGWORD;List:PListBoxItems);
PROCEDURE NewListBoxItem(VAR List:PListBoxItems;item:STRING;Data:POINTER;
                         cbData:LONGWORD;Sort:BOOLEAN);
PROCEDURE DialogGetText(Dlg:HWND;id:LONGWORD;VAR s:STRING;cb:BYTE);
PROCEDURE DialogSetText(Dlg:HWND;id:LONGWORD;s:STRING);
PROCEDURE ListBoxGetSelItem(Dlg:HWND;id:LONGWORD;VAR result:TListBoxItems;
                            VAR List:PListBoxItems;Erase:BOOLEAN);
PROCEDURE DeleteListBox(VAR List:PListBoxItems);
PROCEDURE SetTextLimit(Dlg:HWND;id:LONGWORD;Limit:BYTE);
PROCEDURE SetMenuText(Frame:HWND;Id:LONGWORD;s:STRING);
PROCEDURE InsertMainMenu(Frame:HWND;pos:INTEGER;id:WORD;s:STRING);
PROCEDURE InsertSubMenu(Frame:HWND;MainMenuID:WORD;pos:INTEGER;id:WORD;s:STRING);
PROCEDURE RemoveSubMenu(Frame:HWND;id:WORD);
PROCEDURE RemoveSubMenuByPos(Frame:HWND;MainMenuID:WORD;pos:Integer);
PROCEDURE SetCheckBoxState(Dlg:HWND;Id:LONGWORD;Setit:LONGWORD);
FUNCTION GetCheckBoxState(Dlg:HWND;Id:LONGWORD):LONGWORD;
FUNCTION GetRadioButtonState(Dlg:HWND;Id:LONGWORD):LONGWORD;
PROCEDURE SetRadioButtonState(Dlg:HWND;Id:LONGWORD;Setit:LONGWORD);


IMPLEMENTATION

VAR
   DialogVMT:POINTER;

{***************************************************************************
*                                                                          *
*                 Common functions                                         *
*                                                                          *
****************************************************************************}

FUNCTION GetCheckBoxState(Dlg:HWND;Id:LONGWORD):LONGWORD;
BEGIN
     GetCheckBoxState:=WinSendDlgItemMsg(Dlg,id,BM_QUERYCHECK,0,0);
END;

PROCEDURE SetCheckBoxState(Dlg:HWND;Id:LONGWORD;Setit:LONGWORD);
VAR  para1:LONGWORD;
BEGIN
     IF Setit<>0 THEN Para1:=1
     ELSE Para1:=0;
     WinSendDlgItemMsg(Dlg,id,BM_SETCHECK,para1,0);
END;

FUNCTION GetRadioButtonState(Dlg:HWND;Id:LONGWORD):LONGWORD;
BEGIN
     GetRadioButtonState:=WinSendDlgItemMsg(Dlg,id,BM_QUERYCHECK,0,0);
END;

PROCEDURE SetRadioButtonState(Dlg:HWND;Id:LONGWORD;Setit:LONGWORD);
VAR  para1:LONGWORD;
BEGIN
     IF Setit<>0 THEN Para1:=1
     ELSE Para1:=0;
     WinSendDlgItemMsg(Dlg,id,BM_SETCHECK,para1,0);
END;

PROCEDURE SetMenuText(Frame:HWND;Id:LONGWORD;s:STRING);
VAR  HwndMenu:HWND;
     cs:CSTRING;
BEGIN
     cs:=s;
     HwndMenu:=WinWindowFromID(Frame,FID_MENU);
     IF HwndMenu=0 THEN exit;
     WinSendMsg(HwndMenu,MM_SETITEMTEXT,id,LONGWORD(@cs));
END;

PROCEDURE RemoveSubMenuByPos(Frame:HWND;MainMenuID:WORD;pos:INTEGER);
VAR  HwndMenu:HWND;
     p,p1,p2:LONGWORD;
     mi:MENUITEM;
     Menu:HWND;
BEGIN
    HwndMenu:=WinWindowFromID(Frame,FID_MENU);
    IF HwndMenu=0 THEN exit;
    p1:=LONGWORD(@mi);
    p2:=MPFROM2SHORT(MainMenuID,1);
    IF WinSendMsg(HwndMenu,MM_QUERYITEM,p2,p1)=0 THEN exit;
    Menu:=mi.hwndSubMenu;
    WinSendMsg(Menu,MM_DELETEITEMBYPOS,pos,0);
END;


PROCEDURE InsertMainMenu(Frame:HWND;pos:INTEGER;id:WORD;s:STRING);
VAR  HwndMenu:HWND;
     p1,p2:LONGWORD;
     mi:MENUITEM;
     cs:CSTRING;
BEGIN
    HwndMenu:=WinWindowFromID(Frame,FID_MENU);
    IF HwndMenu=0 THEN exit;
    IF id=65535 THEN mi.afStyle:=MIS_SEPARATOR
    ELSE mi.afStyle:=MIS_TEXT;
    mi.afStyle:=mi.afStyle OR MIS_SUBMENU;
    mi.iPosition:=pos;
    mi.afAttribute:=0;
    mi.hwndSubMenu:=WinCreateMenu(HwndMenu, NIL);;
    mi.hitem:=0;
    mi.id:=id;
    cs:=s;
    p1:=LONGWORD(@mi);
    p2:=LONGWORD(@cs);
    WinSendMsg(HwndMenu,MM_INSERTITEM,p1,p2);
END;


PROCEDURE InsertSubMenu(Frame:HWND;MainMenuID:WORD;pos:INTEGER;id:WORD;s:STRING);
VAR  HwndMenu:HWND;
     p,p1,p2:LONGWORD;
     mi:MENUITEM;
     Menu:HWND;
     cs:CSTRING;
BEGIN
    HwndMenu:=WinWindowFromID(Frame,FID_MENU);
    IF HwndMenu=0 THEN exit;
    cs:=s;
    p:=LONGWORD(@cs);
    p1:=LONGWORD(@mi);
    p2:=MPFROM2SHORT(MainMenuID,1);
    IF WinSendMsg(HwndMenu,MM_QUERYITEM,p2,p1)=0 THEN exit;
    Menu:=mi.hwndSubMenu;
    IF Menu=0 THEN exit;
    mi.iPosition:=pos;
    IF id=65535 THEN mi.afStyle:=MIS_SEPARATOR
    ELSE mi.afStyle:=MIS_TEXT;
    mi.afAttribute:=0;
    mi.id:=id;
    mi.hwndSubMenu:=0;
    mi.hitem:=0;
    p1:=LONGWORD(@mi);
    WinSendMsg(Menu,MM_INSERTITEM,p1,p);
END;

PROCEDURE RemoveSubMenu(Frame:HWND;id:WORD);
VAR  HwndMenu:HWND;
     p:LONGWORD;
BEGIN
    HwndMenu:=WinWindowFromID(Frame,FID_MENU);
    IF HwndMenu=0 THEN exit;
    p:=MPFROM2SHORT(id,1);
    WinSendMsg(HwndMenu,MM_DELETEITEM,p,0);
END;


PROCEDURE DeleteListBox(VAR List:PListBoxItems);
VAR  Help:PListBoxItems;
BEGIN
     WHILE List<>NIL DO
     BEGIN
          Help:=List^.Next;
          IF List^.cbData<>0 THEN IF List^.Data<>NIL
          THEN FreeMem(List^.Data,List^.cbData);
          Dispose(List);
          List:=Help;
     END;
END;

PROCEDURE ListBoxGetSelItem(Dlg:HWND;id:LONGWORD;VAR result:TListBoxItems;
                            VAR List:PListBoxItems;Erase:BOOLEAN);
VAR  HwndElement:HWND;
     aindex:WORD;
     Help,HList:PListBoxItems;
     pbSource,pbDest:^Byte;
Label l;
BEGIN
     HwndElement:=WinWindowFromID(Dlg,id);
     IF HwndElement=0 THEN exit;
     aindex:=WinSendMsg(HwndElement,LM_QUERYSELECTION,LIT_FIRST,0);
     Result.Item:='';
     Result.aindex:=65535;
     HList:=List;
     WHILE HList<>NIL DO
     BEGIN
          IF HList^.aindex=aIndex THEN
          BEGIN
               Result:=HList^;
               IF result.cbData>0 THEN if result.Data<>NIL THEN
               BEGIN
                    GetMem(result.Data,result.cbData);
                    pbsource:=HList^.Data;
                    pbDest:=result.Data;
                    move(pbSource^,pbDest^,result.cbData);
               END;
               goto l;
          END;
          HList:=HList^.Next;
     END;
l:
     Result.Next:=NIL;
     IF Erase THEN DeleteListBox(List);
END;

PROCEDURE NewListBoxItem(VAR List:PListBoxItems;item:STRING;Data:POINTER;
                         cbData:LONGWORD;Sort:BOOLEAN);
VAR  dummy:PListBoxItems;
     Prev:PListBoxItems;
LABEL l,l1;
BEGIN
     IF List=NIL THEN
     BEGIN
          New(List);
          dummy:=List;
          dummy^.Next:=NIL;
     END
     ELSE
     BEGIN
          IF Sort THEN
          BEGIN
               dummy:=List;
               Prev:=NIL;
               WHILE dummy<>NIL DO
               BEGIN
                    IF dummy^.Item>Item THEN goto l;
                    Prev:=dummy;
                    dummy:=dummy^.Next;
               END;
               {No Item found --> Append at end of List}
               New(Prev^.Next);
               dummy:=Prev^.Next;
               dummy^.Next:=NIL;
               goto l1;
l:
               {Insert the item at this position}
               IF Prev=NIL THEN {At start of the list}
               BEGIN
                    dummy:=List;
                    New(List);
                    List^.Next:=dummy;
                    dummy:=List;
               END
               ELSE {at position after Prev}
               BEGIN
                    dummy:=Prev^.Next;
                    New(Prev^.Next);
                    Prev:=Prev^.Next;
                    Prev^.Next:=dummy;
                    dummy:=Prev;
               END;
          END
          ELSE
          BEGIN
               dummy:=List;
               WHILE dummy^.Next<>NIL do dummy:=dummy^.Next;
               New(dummy^.Next);
               dummy:=dummy^.Next;
               dummy^.Next:=NIL;
          END;
     END;
l1:
     dummy^.item:=item;
     dummy^.aindex:=0;
     dummy^.Data:=Data;
     dummy^.cbData:=cbData;
END;

FUNCTION ListBoxInsertString(Dlg:HWND;where:LONGINT;s:STRING):WORD;
VAR  aindex:WORD;
     cs:CSTRING;
BEGIN
     cs:=s;
     aindex:=WinSendMsg(Dlg,LM_INSERTITEM,where,LONGWORD(@cs));
     ListBoxInsertString:=aIndex;
END;

PROCEDURE FillListBox(Dlg:HWND;id:LONGWORD;List:PListBoxItems);
VAR  HwndElement:HWND;
BEGIN
     HwndElement:=WinWindowFromID(Dlg,id);
     IF HwndElement=0 THEN exit;
     WinEnableWindowUpdate(hwndElement,FALSE);

     WHILE List<>NIL DO
     BEGIN
          List^.aIndex:=ListBoxInsertString(HwndElement,LIT_END,List^.item);
          List:=List^.Next;
     END;
     WinShowWindow(HwndElement,TRUE);
END;

PROCEDURE DialogSetText(Dlg:HWND;id:LONGWORD;s:STRING);
VAR  HwndElement:HWND;
     cs:CSTRING;
BEGIN
     HwndElement:=WinWindowFromID(Dlg,id);
     IF HwndElement=0 THEN exit;
     cs:=s;
     WinSetWindowText(HwndElement,cs);
END;

PROCEDURE DialogGetText(Dlg:HWND;id:LONGWORD;VAR s:STRING;cb:BYTE);
VAR  HwndElement:HWND;
     t:BYTE;
BEGIN
     HwndElement:=WinWindowFromID(Dlg,id);
     IF HwndElement=0 THEN exit;
     s[0] := #0;
     IF WinQueryWindowText(HwndElement,cb,s[1]) = 0 THEN exit;
     IF cb=0 THEN exit;
     FOR t:=1 TO cb-1 DO IF s[t]=#0 THEN {first #0 terminates the string}
     BEGIN
          s[0]:=chr(t-1);
          exit;
     END;
END;

PROCEDURE SetTextLimit(Dlg:HWND;id:LONGWORD;Limit:BYTE);
VAR  HwndElement:HWND;
BEGIN
     HwndElement:=WinWindowFromID(Dlg,id);
     IF HwndElement=0 THEN exit;
     WinSendMsg(HwndElement,EM_SETTEXTLIMIT,Limit,0);
END;

{***************************************************************************
*                                                                          *
*  Object TDialog                                                          *
*                                                                          *
****************************************************************************}

PROCEDURE TDialog.GetDlg(VAR Dlg:HWND);
BEGIN
     Dlg:=hwnddlg;
END;

PROCEDURE TDialog.CenterDlgBox(Dlg:HWND);
VAR  swpParent:SWP;
     swpDialog:SWP;
     xDiv,yDiv,xdiv1,ydiv1:LONGWORD;
     DlgParent:HWND;
BEGIN
     DlgParent:=WinQueryWindow(Dlg,QW_PARENT);
     WinQueryWindowPos(DlgParent,SwpParent);
     WinQueryWindowPos(Dlg,SwpDialog);
     xDiv:=swpParent.cx DIV 2;
     yDiv:=swpParent.cy DIV 2;
     xdiv1:=swpDialog.cx DIV 2;
     ydiv1:=swpDialog.cy DIV 2;
     IF xdiv>xdiv1 THEN swpDialog.x:=xdiv-xdiv1;
     IF ydiv>ydiv1 THEN swpDialog.y:=ydiv-ydiv1;
     WinSetWindowPos(Dlg,swpDialog.HwndInsertBehind,swpDialog.x,
                     swpDialog.y,swpDialog.cx,swpDialog.cy,
                     swpDialog.fl OR SWP_ACTIVATE);
END;

PROCEDURE TDialog.WMInitDlg(VAR Msg:TMessage);
BEGIN
     CenterDlgBox(Msg.Receiver);
     Msg.Handled:=TRUE;
     Msg.Result:=1; {!!!} {Dont remove this - Radiobuttons wont work}
END;

PROCEDURE TDialog.WMControl(VAR Msg:TMessage);
BEGIN
END;

{Call the standard Dialog procedure}
PROCEDURE TDialog.DefDlgProc(var Msg: TMessage);
BEGIN
     Msg.Result:=WinDefDlgProc(Msg.Receiver,Msg.Message,Msg.Param1,Msg.Param2);
     Msg.Handled:=TRUE;
END;

{This function will be called as a result of the WM_COMMAND message
 It will call the Command procedure or DefCommandProc}
PROCEDURE TDialog.WMCommand(VAR Msg: TMessage);
BEGIN
     PerformDMTMsg(@SELF,Msg,Msg.Param1Lo,TDialog_DefDlgProc);   {_VMT_}
     {Handle it via DMT}
END;


FUNCTION TDialog.DialogHandleEvent(Dlg:HWND;Msg:LONGWORD;
                                   Para1,Para2:LONGWORD):LONGWORD;
VAR  aMsg:TMessage;
     DMTFound:BOOLEAN;
BEGIN
     aMsg.Receiver:=Dlg;
     aMsg.Param1:=LONGWORD(Para1);
     aMsg.Param2:=LONGWORD(Para2);
     aMsg.Message:=Msg;
     aMsg.Result:=0;
     aMsg.Handled:=FALSE;  {not handled yet}
     DMTFound:=FALSE;
     {Check for dynamic methods}
     ASM
        MOV EDI,$SELF
        MOV EDI,[EDI+0]      //Get VMT Pointer
        MOV ESI,[EDI+0]      //Get DMT Pointer
        MOV ECX,[ESI+0]      //number of DMT entries
        CMP ECX,0
        JE !NoDMT            //no dynamic methods
        ADD ESI,4            //onto first DMT entry
        MOV EAX,$Msg
!DMTLoop:
        CMP [ESI+0],EAX
        JE !DMTHere          //Message found
        ADD ESI,8            //next DMT entry
        LOOP !DMTLoop
        JMP !NoDMT
!DMTHere:
        MOVB $DMTFound,1
        LEA EAX,$aMsg
        PUSH EAX             //Parameter for dynamic method call
        MOV EAX,[ESI+4]      //Method index in VMT
        MOV ESI,$SELF
        PUSH ESI             //VMT for dynamic method
        CALLN32 [EDI+EAX*4]  //--> jump to method
!NoDMT:
     END;
     IF DMTFound THEN
     BEGIN
          IF not aMsg.Handled THEN DefDlgProc(aMsg);  {not handled}
     END
     ELSE
     BEGIN
          DefDlgProc(aMsg);  {Standard window handler}
     END;
     DialogHandleEvent:=aMsg.result;
END;


FUNCTION StdDlgProc(Win:HWND;Msg:LONGWORD;
                    para1,para2:POINTER):LONGWORD;CDECL;
BEGIN
     ASM
        //Prepare the parameters for a call to DialogHandleEvent
        PUSHL $Win
        PUSHL $Msg
        PUSHL $para1
        PUSHL $para2

        PUSHL 0             //Get VMT pointer
        PUSHL $Win
        MOV AL,2
        CALLDLL PMWIN,843   //WinQueryWindowUlong
        ADD ESP,8
        MOV EDI,EAX

        PUSH EDI            //SELF Pointer
        MOV EDI,[EDI+0]     //Get VMT pointer for HandleEvent
        MOV EAX,5           //TDialog_HandleEvent = 5     {_VMT_}
        CALLN32 [EDI+EAX*4] // --> Jump into method
        MOV $!FuncResult,EAX
     END;
END;

FUNCTION StartDlgProc(Win:HWND;msg:LONGWORD;
                      para1,para2:LONGWORD):LONGWORD;CDECL;
BEGIN
    ASM
        //Prepare the parameters for a call to DialogHandleEvent
        PUSHL $Win
        PUSHL $Msg
        PUSHL $para1
        PUSHL $para2

        MOV EDI,ODIALOGS.DialogVMT   //Get VMT Pointer

        PUSH EDI                     //VMT Pointer
        MOV EDI,[EDI+0]              //get VMT pointer for HandleEvent
        MOV EAX,5                    //TDialog_HandleEvent = 5     {_VMT_}
        CALLN32 [EDI+EAX*4]          // --> Jump into method
        MOV $!FuncResult,EAX
    END;
END;

CONSTRUCTOR TDialog.Init(Parent,Owner:HWND;hmod:HModule;idDlg:LONGWORD;
                         PCreateParams:POINTER);
BEGIN
     IF DialogVMT<>NIL THEN REPEAT UNTIL DialogVmT=NIL; {Block other threads}
     DialogVMT:=POINTER(SELF); {for StartHandler}
     hwnddlg:=0;
     hwnddlg:=WinLoadDlg(Parent,Owner,@StartDlgProc,hmod,idDlg,PCreateParams);
     IF HwndDlg<>0 THEN
     BEGIN
          WinSetWindowULong(hwndDlg,QWL_USER,LONGWORD(SELF));
          WinSubClassWindow(hwndDlg,@StdDlgProc);
     END;
     DialogVMT:=NIL;   {allow other threads to proceed}
END;

DESTRUCTOR TDialog.Done;
BEGIN
     IF HwndDlg<>0 THEN
     BEGIN
          WinDestroyWindow(hwnddlg);
          HwndDlg:=0;
     END;
END;

FUNCTION TDialog.ExecDialog:LONGWORD;
VAR  r:LONGWORD;
BEGIN
     r:=WinProcessDlg(hwnddlg);
     WinDestroyWindow(hwnddlg);
     HwndDlg:=0;
     ExecDialog:=r;
END;


{***************************************************************************
 *                                                                         *
 *  Object TNotebookDialog                                                 *
 *                                                                         *
 ***************************************************************************}


CONSTRUCTOR TNotebookDialog.Init(Parent,Owner:HWND;hmod:HModule;
                     idDlg,idNotebook:LONGWORD;pCreateParams:Pointer);
BEGIN
     NotebookID:=idNotebook;
     ActualPageID:=0;
     Pages:=NIL;
     Inherited Init(Parent,Owner,hmod,idDlg,pCreateParams);
     InitializeNoteBookPages;
END;

DESTRUCTOR TNoteBookDialog.Done;
VAR  dummy,next:PNoteBookPages;
BEGIN
     INHERITED.Done;
     dummy:=Pages;
     WHILE dummy<>NIL DO
     BEGIN
          next:=dummy^.next;
          dispose(dummy);
          dummy:=next;
     END;
END;

PROCEDURE TNoteBookDialog.SetColors(typ:WORD;value:LONGINT);
BEGIN
     WinSendMsg(NoteBook,BKM_SETNOTEBOOKCOLORS,value,typ);
END;

PROCEDURE TNoteBookDialog.WMInitDlg(VAR Msg:TMessage);
BEGIN
     NoteBook:=WinWindowFromID(Msg.Receiver,NotebookID);
END;

PROCEDURE TNoteBookDialog.SelectPage(id:ULONG);
BEGIN
     WinSendMsg(Notebook,BKM_TURNTOPAGE,id,0);
END;

PROCEDURE TNoteBookDialog.PageOpened(id:ULONG;Dlg:PDialog);
BEGIN
     ActualPageID:=id;
END;

PROCEDURE TNoteBookDialog.PageClosed(id:ULONG;Dlg:PDialog);
BEGIN
END;

PROCEDURE TNoteBookDialog.WMControl(VAR Msg:TMessage);
VAR  notify:PPAGESELECTNOTIFY;
     dnotify:PDELETENOTIFY;
     p:PDialog;
     hwndPage:HWND;
     result:ULONG;
     dummy:PNoteBookPages;
BEGIN
     Inherited WMControl(msg);
     IF msg.param1lo=NoteBookID THEN
     BEGIN
          CASE msg.param1hi OF
            BKN_PAGESELECTED:
            BEGIN
               notify:=POINTER(msg.param2);
               IF notify<>NIL THEN
               BEGIN
                    p:=GetDlgFromID(notify^.ulPageIDCur);
                    PageClosed(notify^.ulPageIDCur,p);
                    p:=GetDlgFromID(notify^.ulPageIDNew);
                    PageOpened(notify^.ulPageIDNew,p);
               END;
            END;
            BKN_PAGEDELETED:
            BEGIN
                 dnotify:=POINTER(msg.param2);
                 IF dnotify<>NIL THEN
                 BEGIN
                      hwndPage:=dnotify^.hwndPage;
                      result:=0;
                      dummy:=Pages;
                      WHILE dummy<>NIL DO
                      BEGIN
                         IF dummy^.Dlg<>NIL THEN
                           IF dummy^.Dlg^.HwndDlg=hwndPage
                              THEN result:=dummy^.ID;
                         dummy:=dummy^.Next;
                      END;
                      IF result<>0 THEN
                        PageClosed(result,GetDlgFromID(result));
                 END;
            END;
          END; {case}
     END;
END;

PROCEDURE TNotebookDialog.SetMajorTabDimensions(W,H:WORD);
BEGIN
     WinSendMsg(Notebook,BKM_SETDIMENSIONS,MPFROM2SHORT(W,H),BKA_MAJORTAB);
END;

PROCEDURE TNotebookDialog.SetMinorTabDimensions(W,H:WORD);
BEGIN
     WinSendMsg(Notebook,BKM_SETDIMENSIONS,MPFROM2SHORT(W,H),BKA_MINORTAB);
END;

PROCEDURE TNotebookDialog.SetPageButtonDimensions(W,H:WORD);
BEGIN
     WinSendMsg(Notebook,BKM_SETDIMENSIONS,MPFROM2SHORT(W,H),BKA_PAGEBUTTON);
END;

FUNCTION TNoteBookDialog.GetDlgFromID(id:ULONG):PDialog;
VAR  result:PDialog;
     dummy:PNoteBookPages;
BEGIN
     result:=NIL;
     dummy:=Pages;
     WHILE dummy<>NIL DO
     BEGIN
          IF dummy^.ID=ID THEN result:=dummy^.Dlg;
          dummy:=dummy^.Next;
     END;
     GetDlgFromID:=result;
END;

FUNCTION TNoteBookDialog.GetIDFromDlg(Dlg:PDialog):ULONG;
VAR  result:ULONG;
     dummy:PNoteBookPages;
BEGIN
     result:=0;
     dummy:=Pages;
     WHILE dummy<>NIL DO
     BEGIN
          IF dummy^.Dlg=Dlg THEN result:=dummy^.ID;
          dummy:=dummy^.Next;
     END;
     GetIDFromDlg:=result;
END;

PROCEDURE TNoteBookDialog.InitializeNoteBookPages;
BEGIN
END;

PROCEDURE TNotebookDialog.DestroyNoteBookPages;
BEGIN
END;

PROCEDURE TNotebookDialog.WMClose(VAR msg:TMessage);
BEGIN
     PageClosed(ActualPageID,GetDlgFromID(ActualPageID));
     DestroyNoteBookPages;
END;

FUNCTION TNotebookDialog.InsertPage(id:ULONG;Dlg:PDialog;
                  Order,Options:WORD;TabText,StatusText:STRING):ULONG;
VAR  result:ULONG;
     r:ULONG;
     dummy:PNoteBookPages;
     cTabText,cStatusText:CSTRING;
LABEL l;
BEGIN
     cTabText:=TabText;
     cStatusText:=StatusText;
     result:=0;

     IF Notebook=0 THEN goto l;

     result:=WinSendMsg(NoteBook,BKM_INSERTPAGE,id,MPFROM2SHORT(Options,Order));
     IF result=0 THEN goto l;

     IF Options AND BKA_STATUSTEXTON=BKA_STATUSTEXTON THEN
     BEGIN
          r:=WinSendMsg(Notebook,BKM_SETSTATUSLINETEXT,result,
                        ULONG(@cStatusText));
          IF r<>1 THEN goto l;
     END;

     r:=WinSendMsg(Notebook,BKM_SETTABTEXT,result,ULONG(@cTabText));
     IF r<>1 THEN goto l;

     IF Dlg<>NIL THEN
     BEGIN
          r:=WinSendMsg(Notebook,BKM_SetPageWindowHWND,result,Dlg^.HwndDlg);
          IF r<>1 THEN goto l;
     END;

     IF Pages=NIL THEN
     BEGIN
          New(Pages);
          dummy:=Pages;
     END
     ELSE
     BEGIN
          dummy:=Pages;
          WHILE dummy^.next<>NIL DO dummy:=dummy^.Next;
          New(dummy^.Next);
          dummy:=dummy^.Next;
     END;

     dummy^.Dlg:=Dlg;
     dummy^.id:=result;
     dummy^.Next:=NIL;
l:
     InsertPage:=result;
END;


{***************************************************************************
*                                                                          *
*  File Open/File Save Standard Dialogs                                    *
*                                                                          *
****************************************************************************}

FUNCTION FileOpenDialog(Win:HWND;VAR result:STRING):BOOLEAN;
VAR  Dlg:FileDlg;
     cTitle,cOKName:CSTRING;
BEGIN
     FillChar(dlg,sizeof(FileDlg),0); {Clear Dialog structure}

     cTitle:=FileOpenDlgTitle;
     cOKName:=FileOpenDlgOKName;
     Dlg.pszTitle:=@cTitle;
     Dlg.pszOkButton:=@cOKName;
     Dlg.szFullFile:=FileOpenDlgWildCards;
     Dlg.cbSize:=sizeof(FileDlg);
     Dlg.fl:=FDS_OPEN_DIALOG | FDS_CENTER | FDS_ENABLEFILELB;
     WinFileDlg(HWND_DESKTOP,Win,Dlg);
     IF Dlg.lReturn=1 THEN {DID_OK}
     BEGIN
          result:=dlg.szFullFile;
          FileOpenDialog:=TRUE;
     END
     ELSE
     BEGIN
          result:='';
          FileOpenDialog:=FALSE;
     END;
     {UpcaseStr(result);}
END;


FUNCTION FileSaveDialog(Win:HWND;VAR result:STRING):BOOLEAN;
VAR  Dlg:FileDlg;
     cTitle,cOKName:CSTRING;
BEGIN
     FillChar(dlg,sizeof(FileDlg),0); {Clear Dialog structure}

     cTitle:=FileSaveDlgTitle;
     cOKName:=FileSaveDlgOKName;
     Dlg.pszTitle:=@cTitle;
     Dlg.pszOkButton:=@cOKName;
     Dlg.szFullFile:=FileSaveDlgWildCards;
     Dlg.cbSize:=sizeof(FileDlg);
     Dlg.fl:=FDS_SAVEAS_DIALOG | FDS_CENTER | FDS_ENABLEFILELB;
     WinFileDlg(HWND_DESKTOP,Win,Dlg);
     IF Dlg.lReturn=1 THEN {DID_OK}
     BEGIN
          result:=dlg.szFullFile;
          FileSaveDialog:=TRUE;
     END
     ELSE
     BEGIN
          result:='';
          FileSaveDialog:=FALSE;
     END;
     {UpcaseStr(result);}
END;


{$D+}

BEGIN
     FileOpenDlgTitle:='Open a file';
     FileOpenDlgWildcards:='*.*';
     FileOpenDlgOkname:='Open';
     FileSaveDlgTitle:='Save file as';
     FileSaveDlgWildcards:='*.*';
     FileSaveDlgOkname:='Save';
     StdDlgProcAddr:=@StdDlgProc;
     StartDlgProcAddr:=@StartDlgProc;
     DialogVMT:=NIL;
END. 
