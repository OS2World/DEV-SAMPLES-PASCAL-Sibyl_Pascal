UNIT Controls;

{$R-,D-,S-}

INTERFACE

USES Os2Def,ObjectPM,Crt,PmBitmap,PmWin,PmStdDlg;

TYPE
    __MyPARAM=RECORD
                aindex:LONGWORD;   {PP_XXXX index}
                cb:LONGWORD;   {total bytes in data fields below}
                CASE Integer OF {This field is 4 bytes in length}
                  1:(along:LONGINT);
                  2:(apsz:PChar);
                  3:(argb:RGB);
              END;

    __PMyPRESPARAMS=^__TMyPRESPARAMS;
    __TMyPRESPARAMS=RECORD
                     cb:LONGWORD;  {total bytes of __MyParam (Count*12)}
                     aparam:ARRAY[1..43] OF __MyPARAM;
               END;

    { TControl creation attributes }
     TControlAttr = RECORD
                       Title:STRING;
                       WinClass:LONGWORD;
                       Flags:LONGWORD;
                       X, Y, W, H: LONGINT;
                       ResourceId:LONGWORD;
                       ResourceModule:HModule;
                       WindowId:LONGWORD;
                       PresParamCount:BYTE;
                       ThePresParams:__TMyPRESPARAMS;
                       TheCtlData:POINTER;
                   END;

    PControl=^TControl;
    TControl=OBJECT(TWindowsObject)
                  OldWndProc:POINTER;
                  Title:STRING;
                  Attr:TControlAttr;
                  QuietMode:BOOLEAN; {All Controls like Bitmaps}
                  CONSTRUCTOR Init(AParent:PWindowsObject;ATitle:STRING);
                  FUNCTION Create:BOOLEAN;VIRTUAL;
                  PROCEDURE CloseWindow;VIRTUAL;
                  PROCEDURE SendMouseEventToOwner(VAR Msg:TMessage);
                  PROCEDURE SetPresentationParameter(aindex:BYTE;
                                                     aValue:LONGINT);

                  PROCEDURE DefWndProc(var Msg: TMessage); VIRTUAL {index 1};

                  PROCEDURE WMPaint(VAR Msg:TMessage);
                                  VIRTUAL WM_FIRST+WM_PAINT;
                  PROCEDURE WMButton1Down(VAR Msg:TMessage);
                                   VIRTUAL WM_FIRST+WM_BUTTON1DOWN;
                  PROCEDURE WMButton1Up(VAR Msg:TMessage);
                                   VIRTUAL WM_FIRST+WM_BUTTON1UP;
                  PROCEDURE WMButton1CLICK(VAR Msg:TMessage);
                                   VIRTUAL WM_FIRST+WM_BUTTON1CLICK;
                  PROCEDURE WMButton1DBLCLK(VAR Msg:TMessage);
                                   VIRTUAL WM_FIRST+WM_BUTTON1DBLCLK;
                  PROCEDURE WMMouseMove(VAR Msg:TMessage);
                                   VIRTUAL WM_FIRST+WM_MOUSEMOVE;
             END;

    PButton=^TButton;
    TButton=OBJECT(TControl)
                  CONSTRUCTOR Init(AParent:PWindowsObject;ATitle:STRING);
            END;

    PGroupBox=^TGroupBox;
    TGroupBox=OBJECT(TControl)
                  CONSTRUCTOR Init(AParent:PWindowsObject;ATitle:STRING);
            END;

    PRadioBox=^TRadioBox;
    TRadioBox=OBJECT(TControl)
                  CONSTRUCTOR Init(AParent:PWindowsObject;ATitle:STRING);
            END;

    PCheckBox=^TCheckBox;
    TCheckBox=OBJECT(TControl)
                  CONSTRUCTOR Init(AParent:PWindowsObject;ATitle:STRING);
            END;

    PListBox=^TListBox;
    TListBox=OBJECT(TControl)
                  CONSTRUCTOR Init(AParent:PWindowsObject;ATitle:STRING);
            END;

    PEntryField=^TEntryField;
    TEntryField=OBJECT(TControl)
                  CONSTRUCTOR Init(AParent:PWindowsObject;ATitle:STRING);
            END;

    PText=^TText;
    TText=OBJECT(TControl)
                  CONSTRUCTOR Init(AParent:PWindowsObject;ATitle:STRING);
            END;

    PHScrollBar=^THScrollBar;
    THScrollBar=OBJECT(TControl)
                  CONSTRUCTOR Init(AParent:PWindowsObject;ATitle:STRING);
            END;

    PMLE=^TMLE;
    TMLE=OBJECT(TControl)
                  CONSTRUCTOR Init(AParent:PWindowsObject;ATitle:STRING);
            END;

    PNOTEBOOK=^TNOTEBOOK;
    TNOTEBOOK=OBJECT(TControl)
                  CONSTRUCTOR Init(AParent:PWindowsObject;ATitle:STRING);
            END;

    PVScrollBar=^TVScrollBar;
    TVScrollBar=OBJECT(TControl)
                  CONSTRUCTOR Init(AParent:PWindowsObject;ATitle:STRING);
            END;

    PIcon=^TIcon;
    TIcon=OBJECT(TControl)
                  CONSTRUCTOR Init(AParent:PWindowsObject;ATitle:STRING);
            END;

    PBitmap=^TBitmap;
    TBitmap=OBJECT(TControl)
                  CONSTRUCTOR Init(AParent:PWindowsObject;ATitle:STRING);
            END;

    PValueSet=^TValueSet;
    TValueSet=OBJECT(TControl)
                  rows,columns:WORD;
                  CONSTRUCTOR Init(AParent:PWindowsObject;ATitle:STRING;
                                   TheRows,TheColumns:WORD);
                  FUNCTION Create:BOOLEAN;VIRTUAL;
            END;

    PSpinButton=^TSpinButton;
    TSpinButton=OBJECT(TControl)
                  CONSTRUCTOR Init(AParent:PWindowsObject;ATitle:STRING);
            END;

    PSlider=^TSlider;
    TSlider=OBJECT(TControl)
                  Scale1,Scale2:LONGINT;
                  CONSTRUCTOR Init(AParent:PWindowsObject;ATitle:STRING;
                                   TheScale1,TheScale2:LONGINT);
                  FUNCTION Create:BOOLEAN;VIRTUAL;
            END;

    PRectangle=^TRectangle;
    TRectangle=OBJECT(TControl)
                  CONSTRUCTOR Init(AParent:PWindowsObject;ATitle:STRING);
            END;

    PFrame=^TFrame;
    TFrame=OBJECT(TControl)
                  CONSTRUCTOR Init(AParent:PWindowsObject;ATitle:STRING);
            END;

    PContainer=^TContainer;
    TContainer=OBJECT(TControl)
                  CONSTRUCTOR Init(AParent:PWindowsObject;ATitle:STRING);
            END;

    PUserDef=^TUserDef;
    TUserDef=OBJECT(TControl)
                  CONSTRUCTOR Init(AParent:PWindowsObject;ATitle:STRING);
            END;

    PComboBox=^TComboBox;
    TComboBox=OBJECT(TControl)
                  aEntryField:PEntryField;
                  aListBox:PListBox;
                  CONSTRUCTOR Init(AParent:PWindowsObject;ATitle:STRING);
                  DESTRUCTOR Done;VIRTUAL;
                  FUNCTION Create:BOOLEAN;VIRTUAL;
            END;

{ Presentation parameter types. }
CONST
   DPP_FOREGROUNDCOLOR                      =1;
   DPP_FOREGROUNDCOLORINDEX                 =2;
   DPP_BACKGROUNDCOLOR                      =3;
   DPP_BACKGROUNDCOLORINDEX                 =4;
   DPP_HILITEFOREGROUNDCOLOR                =5;
   DPP_HILITEFOREGROUNDCOLORINDEX           =6;
   DPP_HILITEBACKGROUNDCOLOR                =7;
   DPP_HILITEBACKGROUNDCOLORINDEX           =8;
   DPP_DISABLEDFOREGROUNDCOLOR              =9;
   DPP_DISABLEDFOREGROUNDCOLORINDEX         =10;
   DPP_DISABLEDBACKGROUNDCOLOR              =11;
   DPP_DISABLEDBACKGROUNDCOLORINDEX         =12;
   DPP_BORDERCOLOR                          =13;
   DPP_BORDERCOLORINDEX                     =14;
   DPP_FONTNAMESIZE                         =15;
   DPP_FONTHANDLE                           =16;
   DPP_RESERVED                             =17;
   DPP_ACTIVECOLOR                          =18;
   DPP_ACTIVECOLORINDEX                     =19;
   DPP_INACTIVECOLOR                        =20;
   DPP_INACTIVECOLORINDEX                   =21;
   DPP_ACTIVETEXTFGNDCOLOR                  =22;
   DPP_ACTIVETEXTFGNDCOLORINDEX             =23;
   DPP_ACTIVETEXTBGNDCOLOR                  =24;
   DPP_ACTIVETEXTBGNDCOLORINDEX             =25;
   DPP_INACTIVETEXTFGNDCOLOR                =26;
   DPP_INACTIVETEXTFGNDCOLORINDEX           =27;
   DPP_INACTIVETEXTBGNDCOLOR                =28;
   DPP_INACTIVETEXTBGNDCOLORINDEX           =29;
   DPP_SHADOW                               =30;
   DPP_MENUFOREGROUNDCOLOR                  =31;
   DPP_MENUFOREGROUNDCOLORINDEX             =32;
   DPP_MENUBACKGROUNDCOLOR                  =33;
   DPP_MENUBACKGROUNDCOLORINDEX             =34;
   DPP_MENUHILITEFGNDCOLOR                  =35;
   DPP_MENUHILITEFGNDCOLORINDEX             =36;
   DPP_MENUHILITEBGNDCOLOR                  =37;
   DPP_MENUHILITEBGNDCOLORINDEX             =38;
   DPP_MENUDISABLEDFGNDCOLOR                =39;
   DPP_MENUDISABLEDFGNDCOLORINDEX           =40;
   DPP_MENUDISABLEDBGNDCOLOR                =41;
   DPP_MENUDISABLEDBGNDCOLORINDEX           =42;


IMPLEMENTATION

{**************************************************************************
 *                                                                        *
 *  Object TControl                                                       *
 *                                                                        *
 **************************************************************************}

CONSTRUCTOR TControl.Init(AParent:PWindowsObject;ATitle:STRING);
BEGIN
     Inherited.Init(AParent);
     Title:=ATitle;
     OldWndProc:=NIL;
     Attr.Title:=ATitle;
     Attr.WinClass:=WC_STATIC;
     Attr.Flags:=0;
     Attr.X:=50;
     Attr.Y:=50;
     Attr.W:=100;
     Attr.H:=100;
     Attr.ResourceId:=0;
     Attr.ResourceModule:=0;
     Attr.WindowId:=0;
     QuietMode:=FALSE;
     Attr.PresParamCount:=0;   {No PreParams at all}
     Attr.ThePresParams.cb:=0;  {No PresParams at all}
     Attr.TheCtlData:=NIL;
END;


PROCEDURE TControl.CloseWindow;
BEGIN
     IF CanClose THEN
     BEGIN
          WinDestroyWindow(HWindow);
          IF Parent<>NIL THEN
          BEGIN
              Parent^.RemoveChild(ObjectPtr);
              IF Parent^.FirstChild=NIL THEN Parent^.ActiveChild:=NIL;
          END;
     END;
END;


PROCEDURE TControl.SetPresentationParameter(aindex:BYTE;aValue:LONGINT);
VAR
   t:BYTE;
LABEL l;
BEGIN
     {Seach if the index is alwas present}
     FOR t:=1 TO Attr.PresParamCount DO
     BEGIN
          IF Attr.ThePresParams.aparam[t].aindex=aindex THEN goto l; {found}
     END;
     {not found --> new one}
     inc(Attr.PresParamCount);
     t:=Attr.PresParamCount;
l:
     Attr.ThePresParams.cb:=Attr.PresParamCount*12;

     Attr.ThePresParams.aparam[t].aindex:=aindex;
     Attr.ThePresParams.aparam[t].cb:=4;
     Attr.ThePresParams.aparam[t].along:=avalue;
END;


FUNCTION TControl.Create:BOOLEAN;
VAR
   ParentWin:HWND;
   params:__PMyPresParams;
   CtlData:^LONGWORD;
   cTitle:CSTRING;
BEGIN
     IF Parent=NIL THEN ParentWin:=HWND_DESKTOP
     ELSE ParentWin:=Parent^.HWindow;

     {Set Presentation Parameter}
     IF Attr.PresParamCount=0 THEN Params:=NIL
     ELSE Params:=@Attr.ThePresParams;

     CtlData:=Attr.TheCtlData;

     cTitle:=Attr.Title;
     HWindowFrame:=WinCreateWCWindow(ParentWin,Attr.WinClass,cTitle,
                                     Attr.Flags,Attr.x,Attr.y,
                                     Attr.w,Attr.h,ParentWin,HWND_TOP,
                                     Attr.WindowID,CtlData,Params);
     HWindow:=HWindowFrame;
     IF HWindow=0 THEN
     BEGIN
          Create:=FALSE;
          exit;
     END;
     WinSetWindowPos(HWindow,HWND_TOP,Attr.x,Attr.y,Attr.w,Attr.h,
                     SWP_ZORDER OR SWP_SHOW OR SWP_MOVE);
     WinSetWindowULong(HWindow,QWL_USER,LONGWORD(SELF));
     OldWndProc:=WinSubClassWindow(HWindow,MessageHandlerAddr);
     Create:=TRUE;
END;

PROCEDURE TControl.WMPaint(VAR Msg:TMessage);
BEGIN
END;

PROCEDURE TControl.SendMouseEventToOwner(VAR Msg:TMessage);
VAR
   po:POINTS;
   x,y:INTEGER;
   aswp:SWP;
BEGIN
     IF Parent=NIL THEN exit;
     po:=POINTS(Msg.Param1);
     x:=po.x;
     y:=po.y;
     WinQueryWindowPos(HWindow,aswp);
     po.x:=aswp.x+x;
     po.y:=aswp.y+y;
     WinSendMsg(Parent^.HWindow,Msg.Message,LONGWORD(po),0);
END;


PROCEDURE TControl.WMButton1DBLCLK(VAR Msg:TMessage);
BEGIN
     Inherited.WMButton1DBLCLK(Msg);
     IF QuietMode THEN
     BEGIN
          SendMouseEventToOwner(Msg);
          Msg.handled:=TRUE;
     END;
END;


PROCEDURE TControl.WMMouseMove(VAR Msg:TMessage);
BEGIN
     IF QuietMode THEN
     BEGIN
          SendMouseEventToOwner(Msg);
          Msg.handled:=TRUE;
     END;
END;

PROCEDURE TControl.WMButton1Down(VAR Msg:TMessage);
BEGIN
     Inherited.WMButton1Down(Msg);
     IF QuietMode THEN
     BEGIN
          SendMouseEventToOwner(Msg);
          Msg.Handled:=TRUE;
     END;
END;

PROCEDURE TControl.WMButton1Up(VAR Msg:TMessage);
BEGIN
     Inherited.WMButton1Up(Msg);
     IF QuietMode THEN
     BEGIN
         SendMouseEventToOwner(Msg);
         Msg.Handled:=TRUE;
     END;
END;

PROCEDURE TControl.WMButton1CLICK(VAR Msg:TMessage);
BEGIN
     Inherited.WMButton1CLICK(Msg);
     IF QuietMode THEN
     BEGIN
         SendMouseEventToOwner(Msg);
         Msg.Handled:=TRUE;
     END;
END;

PROCEDURE TControl.DefWndProc(var Msg: TMessage);
VAR
   DefProc:FUNCTION(Win,Msg,Param1,Param2:LONGWORD):LONGWORD;CDECL;
BEGIN
     DefProc:=OldWndProc;
     Msg.Result:=DefProc(Msg.Receiver,Msg.Message,Msg.Param1,Msg.Param2);
     Msg.Handled:=TRUE;
END;


{**************************************************************************
 *                                                                        *
 *  Object TButton                                                        *
 *                                                                        *
 **************************************************************************}


CONSTRUCTOR TButton.Init(AParent:PWindowsObject;ATitle:STRING);
BEGIN
     Inherited.Init(AParent,ATitle);
     Attr.WinClass:=WC_BUTTON;
     Attr.Flags:=BS_PUSHBUTTON;
END;


{**************************************************************************
 *                                                                        *
 *  Object TGroupBox                                                      *
 *                                                                        *
 **************************************************************************}


CONSTRUCTOR TGroupBox.Init(AParent:PWindowsObject;ATitle:STRING);
BEGIN
     Inherited.Init(AParent,ATitle);
     Attr.WinClass:=WC_STATIC;
     Attr.Flags:=SS_GROUPBOX;
END;

{**************************************************************************
 *                                                                        *
 *  Object TRadioBox                                                      *
 *                                                                        *
 **************************************************************************}


CONSTRUCTOR TRadioBox.Init(AParent:PWindowsObject;ATitle:STRING);
BEGIN
     Inherited.Init(AParent,ATitle);
     Attr.WinClass:=WC_BUTTON;
     Attr.Flags:=BS_AUTORADIOBUTTON;
END;


{**************************************************************************
 *                                                                        *
 *  Object TCheckBox                                                      *
 *                                                                        *
 **************************************************************************}


CONSTRUCTOR TCheckBox.Init(AParent:PWindowsObject;ATitle:STRING);
BEGIN
     Inherited.Init(AParent,ATitle);
     Attr.WinClass:=WC_BUTTON;
     Attr.Flags:=BS_AUTOCHECKBOX;
END;


{**************************************************************************
 *                                                                        *
 *  Object TListBox                                                       *
 *                                                                        *
 **************************************************************************}


CONSTRUCTOR TListBox.Init(AParent:PWindowsObject;ATitle:STRING);
BEGIN
     Inherited.Init(AParent,ATitle);
     Attr.WinClass:=WC_LISTBOX;
     Attr.Flags:=0;
END;


{**************************************************************************
 *                                                                        *
 *  Object TEntryField                                                    *
 *                                                                        *
 **************************************************************************}


CONSTRUCTOR TEntryField.Init(AParent:PWindowsObject;ATitle:STRING);
BEGIN
     Inherited.Init(AParent,ATitle);
     Attr.WinClass:=WC_ENTRYFIELD;
     Attr.Flags:=ES_LEFT OR ES_MARGIN OR ES_AUTOSCROLL;
END;


{**************************************************************************
 *                                                                        *
 *  Object TText                                                          *
 *                                                                        *
 **************************************************************************}


CONSTRUCTOR TText.Init(AParent:PWindowsObject;ATitle:STRING);
BEGIN
     Inherited.Init(AParent,ATitle);
     Attr.WinClass:=WC_STATIC;
     Attr.Flags:=SS_TEXT OR DT_LEFT OR DT_TOP;
END;


{**************************************************************************
 *                                                                        *
 *  Object THScrollBar                                                    *
 *                                                                        *
 **************************************************************************}


CONSTRUCTOR THScrollBar.Init(AParent:PWindowsObject;ATitle:STRING);
BEGIN
     Inherited.Init(AParent,ATitle);
     Attr.WinClass:=WC_SCROLLBAR;
     Attr.Flags:=SBS_HORZ OR SBS_AUTOSIZE;
END;


{**************************************************************************
 *                                                                        *
 *  Object TVScrollBar                                                    *
 *                                                                        *
 **************************************************************************}


CONSTRUCTOR TVScrollBar.Init(AParent:PWindowsObject;ATitle:STRING);
BEGIN
     Inherited.Init(AParent,ATitle);
     Attr.WinClass:=WC_SCROLLBAR;
     Attr.Flags:=SBS_VERT OR SBS_AUTOSIZE;
END;


{**************************************************************************
 *                                                                        *
 *  Object TMLE                                                           *
 *                                                                        *
 **************************************************************************}


CONSTRUCTOR TMLE.Init(AParent:PWindowsObject;ATitle:STRING);
BEGIN
     Inherited.Init(AParent,ATitle);
     Attr.WinClass:=WC_MLE;
     Attr.Flags:=MLS_BORDER OR MLS_WORDWRAP OR MLS_VSCROLL OR MLS_HSCROLL;
END;



{**************************************************************************
 *                                                                        *
 *  Object TNoteBook                                                      *
 *                                                                        *
 **************************************************************************}


CONSTRUCTOR TNoteBook.Init(AParent:PWindowsObject;ATitle:STRING);
BEGIN
     Inherited.Init(AParent,ATitle);
     Attr.WinClass:=WC_NOTEBOOK;
     Attr.Flags:=BKS_BACKPAGESBR OR BKS_MAJORTABRIGHT OR
                 BKS_SQUARETABS OR BKS_STATUSTEXTLEFT OR BKS_TABTEXTLEFT;
END;


{**************************************************************************
 *                                                                        *
 *  Object TIcon                                                          *
 *                                                                        *
 **************************************************************************}


CONSTRUCTOR TIcon.Init(AParent:PWindowsObject;ATitle:STRING);
BEGIN
     Inherited.Init(AParent,ATitle);
     Attr.WinClass:=WC_STATIC;
     Attr.Flags:=SS_ICON OR SS_AUTOSIZE;
END;


{**************************************************************************
 *                                                                        *
 *  Object TBitmap                                                        *
 *                                                                        *
 **************************************************************************}


CONSTRUCTOR TBitmap.Init(AParent:PWindowsObject;ATitle:STRING);
BEGIN
     Inherited.Init(AParent,ATitle);
     Attr.WinClass:=WC_STATIC;
     Attr.Flags:=SS_BITMAP OR SS_AUTOSIZE;
END;


{**************************************************************************
 *                                                                        *
 *  Object TValueSet                                                      *
 *                                                                        *
 **************************************************************************}


CONSTRUCTOR TValueSet.Init(AParent:PWindowsObject;ATitle:STRING;
                           TheRows,TheColumns:WORD);
BEGIN
     Inherited.Init(AParent,ATitle);
     Attr.WinClass:=WC_VALUESET;
     Attr.Flags:=VS_TEXT OR VS_BORDER OR VS_ITEMBORDER;
     rows:=TheRows;
     columns:=TheColumns;
END;


FUNCTION TValueSet.Create:BOOLEAN;
VAR r:RECORD
            len:LONGWORD;
            rows,columns:WORD;
      END;
BEGIN
     r.len:=8;
     r.rows:=rows;
     r.columns:=columns;
     Attr.TheCtlData:=@r;
     Create:=Inherited.Create;
END;


{**************************************************************************
 *                                                                        *
 *  Object TSpinButton                                                    *
 *                                                                        *
 **************************************************************************}


CONSTRUCTOR TSpinButton.Init(AParent:PWindowsObject;ATitle:STRING);
BEGIN
     Inherited.Init(AParent,ATitle);
     Attr.WinClass:=WC_SPINBUTTON;
     Attr.Flags:=SPBS_ALLCHARACTERS OR SPBS_JUSTDEFAULT OR SPBS_SERVANT;
END;


{**************************************************************************
 *                                                                        *
 *  Object TSlider                                                        *
 *                                                                        *
 **************************************************************************}


CONSTRUCTOR TSlider.Init(AParent:PWindowsObject;ATitle:STRING;
                         TheScale1,TheScale2:LONGINT);
BEGIN
     Inherited.Init(AParent,ATitle);
     Attr.WinClass:=WC_SLIDER;
     Attr.Flags:=SLS_HORIZONTAL OR SLS_SNAPTOINCREMENT OR SLS_CENTER
                 OR SLS_HOMELEFT OR SLS_PRIMARYSCALE1;
     Scale1:=TheScale1;
     Scale2:=TheScale2;
END;

FUNCTION TSlider.Create:BOOLEAN;
VAR r:RECORD
            len:LONGWORD;
            Scale1,Scale2:LONGINT;
      END;
BEGIN
     r.len:=12;
     r.Scale1:=Scale1;
     r.Scale2:=Scale2;
     Attr.TheCtlData:=@r;
     Create:=Inherited.Create;
END;


{**************************************************************************
 *                                                                        *
 *  Object TRectangle                                                     *
 *                                                                        *
 **************************************************************************}


CONSTRUCTOR TRectangle.Init(AParent:PWindowsObject;ATitle:STRING);
BEGIN
     Inherited.Init(AParent,ATitle);
     Attr.WinClass:=WC_STATIC;
     Attr.Flags:=SS_FGNDRECT;
END;


{**************************************************************************
 *                                                                        *
 *  Object TFrame                                                         *
 *                                                                        *
 **************************************************************************}


CONSTRUCTOR TFrame.Init(AParent:PWindowsObject;ATitle:STRING);
BEGIN
     Inherited.Init(AParent,ATitle);
     Attr.WinClass:=WC_STATIC;
     Attr.Flags:=SS_FGNDFRAME;
END;


{**************************************************************************
 *                                                                        *
 *  Object TContainer                                                     *
 *                                                                        *
 **************************************************************************}


CONSTRUCTOR TContainer.Init(AParent:PWindowsObject;ATitle:STRING);
BEGIN
     Inherited.Init(AParent,ATitle);
     Attr.WinClass:=WC_CONTAINER;
     Attr.Flags:=CCS_SINGLESEL;
END;


{**************************************************************************
 *                                                                        *
 *  Object TUserDef                                                       *
 *                                                                        *
 **************************************************************************}


CONSTRUCTOR TUserDef.Init(AParent:PWindowsObject;ATitle:STRING);
BEGIN
     Inherited.Init(AParent,ATitle);
     Attr.WinClass:=WC_STATIC;
     Attr.Flags:=0;
END;


{**************************************************************************
 *                                                                        *
 *  Object TComboBox                                                      *
 *                                                                        *
 **************************************************************************}


CONSTRUCTOR TComboBox.Init(AParent:PWindowsObject;ATitle:STRING);
BEGIN
     Inherited.Init(AParent,ATitle);
     Attr.WinClass:=WC_COMBOBOX;
     Attr.Flags:=CBS_SIMPLE;
     aEntryField:=NIL;
     aListBox:=NIL;
END;

FUNCTION TComboBox.Create:BOOLEAN;
VAR
   result:BOOLEAN;
   List,Entry:HWND;
BEGIN
     result:=Inherited.Create;
     IF result THEN
     BEGIN
          List:=WinWindowFromID(HWindow,CBID_LIST);
          IF List<>0 THEN
          BEGIN
               aListBox:=New(PListBox,Init(NIL,''));
               aListBox^.QuietMode:=Quietmode;
               aListBox^.HWindowFrame:=List;
               aListBox^.HWindow:=List;
               aListBox^.Parent:=ObjectPtr;
               WinSetWindowULong(aListBox^.HWindow,QWL_USER,
                                 LONGWORD(aListBox));
               aListBox^.OldWndProc:=WinSubClassWindow(aListBox^.HWindow,
                                                       MessageHandlerAddr);
          END;

          Entry:=WinWindowFromID(HWindow,CBID_EDIT);
          IF Entry<>0 THEN
          BEGIN
               aEntryField:=New(PEntryField,Init(NIL,''));
               aEntryField^.QuietMode:=QuietMode;
               aEntryField^.HWindowFrame:=Entry;
               aEntryField^.HWindow:=Entry;
               aEntryField^.Parent:=ObjectPtr;
               WinSetWindowULong(aEntryField^.HWindow,QWL_USER,
                                 LONGWORD(aEntryField));
               aEntryField^.OldWndProc:=WinSubClassWindow(aEntryField^.HWindow,
                                                          MessageHandlerAddr);
          END;
     END;
     Create:=result;
END;

DESTRUCTOR TComboBox.Done;
BEGIN
     aListBox^.Done;
     aEntryField^.Done;
     Inherited.Done;
END;

{$D+}

BEGIN
END.
