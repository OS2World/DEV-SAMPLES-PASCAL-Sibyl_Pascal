UNIT ObjectPM;

{**************************************************************************
 *                                                                        *
 *    General definitions for Object-PM                                   *
 *    (C) 1993,94 SpeedSoft                                               *
 *                                                                        *
 *    Last modified: 4.8.1995                                             *
 *                                                                        *
 **************************************************************************}

{$R-,S-}

INTERFACE

USES PMWin,PMHelp,PmStdDlg,PmDev,PmGpi,Os2Def;

TYPE
    { TObject base object }
    POPMLObject = ^TOPMLObject;
    TOPMLObject = OBJECT
                   CONSTRUCTOR Init;
                   PROCEDURE Free;
                   DESTRUCTOR Done;VIRTUAL;
              END;

PROCEDURE Abstract;
FUNCTION NewStr(S:STRING):PString;
PROCEDURE DisposeStr(ps:PString);

CONST
     {General Notification Message constants}
     WM_FIRST    = WM_NULL;          {General Window messages starting at 0}
     WM_LAST     = WM_SPEED_USER-1;  {Last PM window message at $1002}
     WM_USERLAST = $2FFF;            {Last user defined window message}
     CM_FIRST    = $3000;            {Start of internal command messages}
     CM_LAST     = $3FFF;            {Last internal command messages}
     CM_USER     = $4000;            {Start of user defined command messages}
     CM_USERLAST = $4FFF;            {Last user defined command message}

CONST
     {Common command constants}
     CM_TILE         =0;
     CM_CASCADE      =1;
     CM_CLOSE        =2;
     CM_CLOSEALL     =3;
     CM_NEXT         =4;
     CM_OPEN         =5;
     CM_SAVEAS       =6;
     CM_NEW          =7;
     CM_SAVE         =8;
     CM_SAVEALL      =9;
     CM_ABOUT        =10;
     CM_QUIT         =11;
     CM_FILE         =12;
     CM_EDIT         =13;
     CM_SEARCH       =14;
     CM_WINDOW       =15;
     CM_HELP         =16;
     CM_DEBUG        =17;
     CM_OPTIONS      =18;
     CM_LIST         =19;
     CM_HELPONHELP   =20;
     CM_EXTENDEDHELP =21;
     CM_KEYSHELP     =22;
     CM_HELPINDEX    =23;
     CM_HELPCONTENTS =24;
     CM_FIND         =25;
     CM_REPLACE      =26;
     CM_GOTO         =27;
     CM_SEARCHAGAIN  =28;
     CM_CUT          =29;
     CM_COPY         =30;
     CM_PASTE        =31;
     CM_UNDO         =32;
     CM_REDO         =33;
     CM_CONTEXTHELP  =34;
     CM_PREVIOUS     =35;
     CM_OK           =36;
     CM_CANCEL       =37;

CONST
     {Window data values}
     QWL_SELF       =0;   {Points to SELF (LONGWORD)}

CONST
     {Constants for Maximizing window. Set Attr.w or Attr.h
     to this values for maximizing}
     Width_Max      = 65535;
     Height_Max     = 65535;

CONST
     {Absolute positions of methods in the VMT}
     TWindowsObject_HandleEvent    :WORD      = 5;       {_VMT_}
     TWindowsObject_DefWndProc     :WORD      = 6;
     TWindowsObject_FrameWndProc   :WORD      = 7;
     TWindowsObject_FrameDefProc   :WORD      = 8;

CONST
     {Flags for TWindowsObject}
     WF_AUTOFILL         = 1;   {Auto fill background}
     WF_AUTOCREATE       = 2;   {Automatically create Window}
     WF_ISDESKTOP        = 4;   {Window is a desktop window (internally created)}
     WF_ISMAINWINDOW     = 8;   {Window is main application window}
     WF_TILEONSIZE       = 16;  {Tile child windows on size}
     WF_WITHDESKTOP      = 32;  {Force desktop creation}
     WF_DELETEDOUBLESCAN = 64;  {double scan events to repeat count}
     WF_DELETEDOUBLECHAR = 128; {double char events to repeat count}
     WF_SCALECHILDS      = 256; {Scale Childs at WMSIZE}

     {Run Error codes}
     RF_NOMAINWINDOW    = 1;  {No main window defined or failed to create it}
     RF_NODESKTOPWINDOW = 2;  {No Desktop window defined or failed to create it}

CONST
     kbVK               = 256;
     kb_Alt             = 512;
     kb_Ctrl            = 1024;
     kb_Shift           = 2048;

     {Keyboardcodes}
     kbF1               = kbVK + VK_F1;
     kbF2               = kbVK + VK_F2;
     kbF3               = kbVK + VK_F3;
     kbF4               = kbVK + VK_F4;
     kbF5               = kbVK + VK_F5;
     kbF6               = kbVK + VK_F6;
     kbF7               = kbVK + VK_F7;
     kbF8               = kbVK + VK_F8;
     kbF9               = kbVK + VK_F9;
     kbF10              = kbVK + VK_F10;
     kbF11              = kbVK + VK_F11;
     kbF12              = kbVK + VK_F12;
     kbCLeft            = kbVK + VK_LEFT;
     kbCRight           = kbVK + VK_RIGHT;
     kbCUp              = kbVK + VK_UP;
     kbCDown            = kbVK + VK_DOWN;
     kbDel              = kbVK + VK_DELETE;
     kbInsert           = kbVK + VK_INSERT;
     kbEnd              = kbVK + VK_END;
     kbPos1             = kbVK + VK_HOME;
     kbPageDown         = kbVK + VK_PAGEDOWN;
     kbPageUp           = kbVK + VK_PAGEUP;
     kbBS               = kbVK + VK_BACKSPACE;
     kbCR               = kbVK + VK_NEWLINE;
     kbESC              = kbVK + VK_ESC;
     kbTab              = kbVK + VK_TAB;
     kbCapsLock         = kbVK + VK_CAPSLOCK;
     kbNumLock          = kbVK + VK_NUMLOCK;
     kbScrollLock       = kbVK + VK_SCRLLOCK;
     kbSpace            = kbVK + VK_SPACE;
     kbBreak            = kbVK + VK_BREAK;
     kbBackTab          = kbVK + VK_BACKTAB;
     kbAltGraf          = kbVK + VK_ALTGRAF;
     kbPause            = kbVK + VK_PAUSE;
     kbPrintScrn        = kbVK + VK_PRINTSCRN;
     kbEnter            = kbVK + VK_ENTER;
     kbSysRq            = kbVK + VK_SYSRQ;
     kbAlt              = kbVK + VK_ALT + kb_Alt;
     kbCtrl             = kbVK + VK_CTRL + kb_Ctrl;
     kbShift            = kbVK + VK_SHIFT + kb_Shift;

     {Shift Codes are basic codes + kb_Shift}
     kbShiftF1          = kb_Shift + kbF1;
     kbShiftF2          = kb_Shift + kbF2;
     kbShiftF3          = kb_Shift + kbF3;
     kbShiftF4          = kb_Shift + kbF4;
     kbShiftF5          = kb_Shift + kbF5;
     kbShiftF6          = kb_Shift + kbF6;
     kbShiftF7          = kb_Shift + kbF7;
     kbShiftF8          = kb_Shift + kbF8;
     kbShiftF9          = kb_Shift + kbF9;
     kbShiftF10         = kb_Shift + kbF10;
     kbShiftCLeft       = kb_Shift + kbCLeft;
     kbShiftCRight      = kb_Shift + kbCRight;
     kbShiftCUp         = kb_Shift + kbCUp;
     kbShiftCDown       = kb_Shift + kbCDown;
     kbShiftDel         = kb_Shift + kbDel;
     kbShiftInsert      = kb_Shift + kbInsert;
     kbShiftEnd         = kb_Shift + kbEnd;
     kbShiftPos1        = kb_Shift + kbPos1;
     kbShiftPageDown    = kb_Shift + kbPageDown;
     kbShiftPageUp      = kb_Shift + kbPageUp;
     kbShiftBS          = kb_Shift + kbBS;
     kbShiftCR          = kb_Shift + kbCR;

     {Alt Codes are basic codes + kb_Alt}
     kbAlt0             = kb_Alt + 48;
     kbAlt1             = kb_Alt + 49;
     kbAlt2             = kb_Alt + 50;
     kbAlt3             = kb_Alt + 51;
     kbAlt4             = kb_Alt + 52;
     kbAlt5             = kb_Alt + 53;
     kbAlt6             = kb_Alt + 54;
     kbAlt7             = kb_Alt + 55;
     kbAlt8             = kb_Alt + 56;
     kbAlt9             = kb_Alt + 57;
     kbAltA             = kb_Alt + 65;
     kbAltB             = kb_Alt + 66;
     kbAltC             = kb_Alt + 67;
     kbAltD             = kb_Alt + 68;
     kbAltE             = kb_Alt + 69;
     kbAltF             = kb_Alt + 70;
     kbAltG             = kb_Alt + 71;
     kbAltH             = kb_Alt + 72;
     kbAltI             = kb_Alt + 73;
     kbAltJ             = kb_Alt + 74;
     kbAltK             = kb_Alt + 75;
     kbAltL             = kb_Alt + 76;
     kbAltM             = kb_Alt + 77;
     kbAltN             = kb_Alt + 78;
     kbAltO             = kb_Alt + 79;
     kbAltP             = kb_Alt + 80;
     kbAltQ             = kb_Alt + 81;
     kbAltR             = kb_Alt + 82;
     kbAltS             = kb_Alt + 83;
     kbAltT             = kb_Alt + 84;
     kbAltU             = kb_Alt + 85;
     kbAltV             = kb_Alt + 86;
     kbAltW             = kb_Alt + 87;
     kbAltX             = kb_Alt + 88;
     kbAltY             = kb_Alt + 89;
     kbAltZ             = kb_Alt + 90;
     kbAltF1            = kb_Alt + kbF1;
     kbAltF2            = kb_Alt + kbF2;
     kbAltF3            = kb_Alt + kbF3;
     kbAltF4            = kb_Alt + kbF4;
     kbAltF5            = kb_Alt + kbF5;
     kbAltF6            = kb_Alt + kbF6;
     kbAltF7            = kb_Alt + kbF7;
     kbAltF8            = kb_Alt + kbF8;
     kbAltF9            = kb_Alt + kbF9;
     kbAltF10           = kb_Alt + kbF10;
     kbAltCLeft         = kb_Alt + kbCLeft;
     kbAltCRight        = kb_Alt + kbCRight;
     kbAltCUp           = kb_Alt + kbCUp;
     kbAltCDown         = kb_Alt + kbCDown;
     kbAltDel           = kb_Alt + kbDel;
     kbAltInsert        = kb_Alt + kbInsert;
     kbAltEnd           = kb_Alt + kbEnd;
     kbAltPos1          = kb_Alt + kbPos1;
     kbAltPageDown      = kb_Alt + kbPageDown;
     kbAltPageUp        = kb_Alt + kbPageUp;
     kbAltBS            = kb_Alt + kbBS;
     kbAltCR            = kb_Alt + kbCR;

     {Ctrl codes are basic codes + kbCtrl}
     kbCtrl0            = kb_Ctrl + 48;
     kbCtrl1            = kb_Ctrl + 49;
     kbCtrl2            = kb_Ctrl + 50;
     kbCtrl3            = kb_Ctrl + 51;
     kbCtrl4            = kb_Ctrl + 52;
     kbCtrl5            = kb_Ctrl + 53;
     kbCtrl6            = kb_Ctrl + 54;
     kbCtrl7            = kb_Ctrl + 55;
     kbCtrl8            = kb_Ctrl + 56;
     kbCtrl9            = kb_Ctrl + 57;
     kbCtrlA            = kb_Ctrl + 65;
     kbCtrlB            = kb_Ctrl + 66;
     kbCtrlC            = kb_Ctrl + 67;
     kbCtrlD            = kb_Ctrl + 68;
     kbCtrlE            = kb_Ctrl + 69;
     kbCtrlF            = kb_Ctrl + 70;
     kbCtrlG            = kb_Ctrl + 71;
     kbCtrlH            = kb_Ctrl + 72;
     kbCtrlI            = kb_Ctrl + 73;
     kbCtrlJ            = kb_Ctrl + 74;
     kbCtrlK            = kb_Ctrl + 75;
     kbCtrlL            = kb_Ctrl + 76;
     kbCtrlM            = kb_Ctrl + 77;
     kbCtrlN            = kb_Ctrl + 78;
     kbCtrlO            = kb_Ctrl + 79;
     kbCtrlP            = kb_Ctrl + 80;
     kbCtrlQ            = kb_Ctrl + 81;
     kbCtrlR            = kb_Ctrl + 82;
     kbCtrlS            = kb_Ctrl + 83;
     kbCtrlT            = kb_Ctrl + 84;
     kbCtrlU            = kb_Ctrl + 85;
     kbCtrlV            = kb_Ctrl + 86;
     kbCtrlW            = kb_Ctrl + 87;
     kbCtrlX            = kb_Ctrl + 88;
     kbCtrlY            = kb_Ctrl + 89;
     kbCtrlZ            = kb_Ctrl + 90;
     kbCtrlF1           = kb_Ctrl + kbF1;
     kbCtrlF2           = kb_Ctrl + kbF2;
     kbCtrlF3           = kb_Ctrl + kbF3;
     kbCtrlF4           = kb_Ctrl + kbF4;
     kbCtrlF5           = kb_Ctrl + kbF5;
     kbCtrlF6           = kb_Ctrl + kbF6;
     kbCtrlF7           = kb_Ctrl + kbF7;
     kbCtrlF8           = kb_Ctrl + kbF8;
     kbCtrlF9           = kb_Ctrl + kbF9;
     kbCtrlF10          = kb_Ctrl + kbF10;
     kbCtrlCLeft        = kb_Ctrl + kbCLeft;
     kbCtrlCRight       = kb_Ctrl + kbCRight;
     kbCtrlCUp          = kb_Ctrl + kbCUp;
     kbCtrlCDown        = kb_Ctrl + kbCDown;
     kbCtrlDel          = kb_Ctrl + kbDel;
     kbCtrlInsert       = kb_Ctrl + kbInsert;
     kbCtrlEnd          = kb_Ctrl + kbEnd;
     kbCtrlPos1         = kb_Ctrl + kbPos1;
     kbCtrlPageDown     = kb_Ctrl + kbPageDown;
     kbCtrlPageUp       = kb_Ctrl + kbPageUp;
     kbCtrlBS           = kb_Ctrl + kbBS;
     kbCtrlCR           = kb_Ctrl + kbCR;

VAR
   {Anchor block handle}
   HInstance:HAB;
   ScalX : Extended;
   ScalY : Extended;

TYPE
  {Window class record used in GetWindowClass}
  TWndClass=RECORD
                  ClassName:STRING;
                  ClassNameUlong:LONGWORD;
                  ClassStyle:LONGWORD;
                  ClassWndProc:FUNCTION(Win:HWND;msg:LONGWORD;
                                        para1,para2:LONGWORD):LONGWORD;
                  cbWindowData:LONGWORD;
            END;

TYPE
    {Toolbar elements}
    PWndProc=FUNCTION(Win:HWND;Msg:ULONG;para1,para2:ULONG):ULONG;CDECL;

    PToolBarInterior=^TToolBarInterior;
    TToolBarInterior=RECORD
                           Win:HWND;
                           OldWndProc:PWndProc;
                           id:LONGWORD;
                           x,y,cx,cy:LONGWORD;
                           Next:PToolBarInterior;
                     END;

    {Statusbar elements}
    PStatusBarInterior=^TStatusBarInterior;
    TStatusBarInterior=RECORD
                           id:WORD;
                           x,y,cx,cy:LONGWORD;
                           item:String;
                           Col:LONGINT;
                           Exclusive:BOOLEAN;
                           Next:PStatusBarInterior;
                     END;

     {Menuhelp elements}
     PMenuHelpItems=^TMenuHelpItems;
     TMenuHelpItems=RECORD
                          StatusID:WORD;
                          MenuID:WORD;
                          HelpText:String;
                          Col:LONGWORD;
                          Next:PMenuHelpItems;
                    END;

VAR
  {Procedue addresses}
  StartHandlerAddr:POINTER;
  MessageHandlerAddr:POINTER;

TYPE
  { TMessage windows message record }
  TMessage = RECORD
    Receiver: HWND;
    Message:  LONGWORD;
    Handled:  BOOLEAN;  {True if the message was handled}
    CASE Integer OF
      0: ( Param1: LONGWORD;
           Param2: LONGWORD;
           Result: LONGWORD);
      1: ( Param1Lo: WORD;
           Param1Hi: WORD;
           Param2Lo: WORD;
           Param2Hi: WORD;
           ResultLo: WORD;
           ResultHi: WORD);
      2: ( Param1LoByteLo:BYTE;
           Param1LoByteHi:BYTE;
           Param1HiByteLo:BYTE;
           Param1HiByteHi:BYTE;
           Param2LoByteLo:BYTE;
           Param2LoByteHi:BYTE;
           Param2HiByteLo:BYTE;
           Param2HiByteHi:BYTE;
           ResultLoByteLo:BYTE;
           ResultLoByteHi:BYTE;
           ResultHiByteLo:BYTE;
           ResultHiByteHi:BYTE);
    END;

TYPE
    { TWindowsObject object}
    PWindowsObject = ^TWindowsObject;
    TWindowsObject = OBJECT(TOPMLObject)
          id:LONGINT;
          HWindow:HWND;
          HWindowFrame:HWND;
          Parent,FirstChild,LastChild:PWindowsObject;
          Previous,Next:PWindowsObject;
          AutoCreate:BOOLEAN;
          WinColor,WinBackColor:LONGINT;
          WinFlags:LONGWORD;
          OldFrameProc:POINTER;
          ObjectPtr:PWindowsObject;
          ActiveChild:PWindowsObject;
          MaxDoubleChars,MaxDoubleScans:WORD;

          {Fixed procedures - Don't change positions of the following.....}
          {****************************************************************}
          FUNCTION HandleEvent(Win:HWND;Msg:LONGWORD;           {_VMT_}
                          para1,para2:POINTER):LONGWORD;VIRTUAL {index 5};
          PROCEDURE DefWndProc(var Msg: TMessage); VIRTUAL      {index 6};
          FUNCTION FrameHandleEvent(Win:HWND;Msg:LONGWORD;
                          para1,para2:POINTER):LONGWORD;VIRTUAL {index 7};
          PROCEDURE FrameDefProc(VAR Msg:TMessage);VIRTUAL;     {index 8}
          {****************************************************************}

          CONSTRUCTOR Init(AParent: PWindowsObject);
          DESTRUCTOR Done;VIRTUAL;
          PROCEDURE FrameHandler(VAR Msg:TMessage);VIRTUAL;
          PROCEDURE HandleCharEvent(Win:HWND;param,Rep:WORD);VIRTUAL;
          PROCEDURE HandleScanEvent(Win:HWND;param,Rep:WORD);VIRTUAL;
          FUNCTION FirstThat(Test:FUNCTION(achild:PWindowsObject):BOOLEAN):
                             PWindowsObject;
          FUNCTION LastThat(Test:FUNCTION(achild:PWindowsObject):BOOLEAN):
                             PWindowsObject;
          PROCEDURE ForEach(Action:PROCEDURE(P:PWindowsObject));
          PROCEDURE AddChild(AChild: PWindowsObject);VIRTUAL;
          PROCEDURE RemoveChild(AChild: PWindowsObject);VIRTUAL;
          PROCEDURE GetWindowClass(VAR AWndClass: TWndClass);VIRTUAL;
          FUNCTION GetClassName:STRING;VIRTUAL;
          FUNCTION Register: BOOLEAN;VIRTUAL;
          PROCEDURE SetupWindow;VIRTUAL;
          FUNCTION Create:BOOLEAN;VIRTUAL;
          FUNCTION Enable: BOOLEAN;VIRTUAL;
          FUNCTION Disable: BOOLEAN;VIRTUAL;
          PROCEDURE Focus;VIRTUAL;
          PROCEDURE Capture(Clear:BOOLEAN);VIRTUAL;
          PROCEDURE CloseNotify;VIRTUAL;
          PROCEDURE CloseWindow;VIRTUAL;
          PROCEDURE SetFlags(Mask:LONGWORD;OnOff:BOOLEAN);
          FUNCTION IsFlagSet(Mask:LONGWORD):BOOLEAN;
          PROCEDURE EnableAutoFill;
          PROCEDURE DisableAutoFill;
          PROCEDURE EnableAutoCreate;
          PROCEDURE DisableAutoCreate;
          FUNCTION CanClose:BOOLEAN;VIRTUAL;
          PROCEDURE Redraw(VAR ahps:HPS;VAR rc:RECTL);VIRTUAL;
          PROCEDURE NoMoreChildWindows;VIRTUAL;
          PROCEDURE FirstChildWindow;VIRTUAL;
          PROCEDURE WindowToTop;VIRTUAL;
          FUNCTION  GetActiveChild:PWindowsObject;VIRTUAL;
          PROCEDURE SetActiveChild(NewChild:PWindowsObject);VIRTUAL;
          FUNCTION  IsAChild(w:PWindowsObject):BOOLEAN;VIRTUAL;
          PROCEDURE WindowDestroyed;VIRTUAL;
          FUNCTION GetID:LONGINT;
          FUNCTION ChildWithId(aId: LongInt): PWindowsObject;
          FUNCTION IndexOf(P: PWindowsObject): Integer;
          FUNCTION At(I: Integer): PWindowsObject;
          PROCEDURE CreateChildren;
          FUNCTION CreateMemoryDC: HDC;

          PROCEDURE WMCommand(var Msg: TMessage);
                                   VIRTUAL WM_FIRST+WM_COMMAND;
          PROCEDURE WMActivate(var Msg: TMessage);
                                   VIRTUAL WM_FIRST+WM_ACTIVATE;
          PROCEDURE WMClose(var Msg: TMessage);
                                   VIRTUAL WM_FIRST+WM_CLOSE;
          PROCEDURE WMDestroy(var Msg: TMessage);
                                   VIRTUAL WM_FIRST+WM_DESTROY;
          PROCEDURE WMEraseBackGround(VAR Msg:TMessage);
                                   VIRTUAL WM_FIRST+WM_ERASEBACKGROUND;
          PROCEDURE WMPaint(VAR Msg:TMessage);
                                   VIRTUAL WM_FIRST+WM_PAINT;
          PROCEDURE WMSize(VAR Msg:TMessage);
                                   VIRTUAL WM_FIRST+WM_SIZE;
          PROCEDURE WMMove(VAR Msg:TMessage);
                                   VIRTUAL WM_FIRST+WM_MOVE;
          PROCEDURE WMChar(VAR Msg:TMessage);
                                   VIRTUAL WM_FIRST+WM_CHAR;
          PROCEDURE WMButton1Down(VAR Msg:TMessage);
                                   VIRTUAL WM_FIRST+WM_BUTTON1DOWN;
          PROCEDURE WMButton2Down(VAR Msg:TMessage);
                                   VIRTUAL WM_FIRST+WM_BUTTON2DOWN;
          PROCEDURE WMButton1Up(VAR Msg:TMessage);
                                   VIRTUAL WM_FIRST+WM_BUTTON1UP;
          PROCEDURE WMButton2Up(VAR Msg:TMessage);
                                   VIRTUAL WM_FIRST+WM_BUTTON2UP;
          PROCEDURE WMButton1CLICK(VAR Msg:TMessage);
                                   VIRTUAL WM_FIRST+WM_BUTTON1CLICK;
          PROCEDURE WMButton2CLICK(VAR Msg:TMessage);
                                   VIRTUAL WM_FIRST+WM_BUTTON2CLICK;
          PROCEDURE WMButton1DBLCLK(VAR Msg:TMessage);
                                   VIRTUAL WM_FIRST+WM_BUTTON1DBLCLK;
          PROCEDURE WMButton2DBLCLK(VAR Msg:TMessage);
                                   VIRTUAL WM_FIRST+WM_BUTTON2DBLCLK;
          PROCEDURE WMMouseMove(VAR Msg:TMessage);
                                   VIRTUAL WM_FIRST+WM_MOUSEMOVE;
     END;

     { TWindow creation attributes }
     TWindowAttr = RECORD
                       Title:STRING;
                       Style:LONGWORD;
                       FrameFlags:LONGWORD;
                       X, Y, W, H:LONGINT;
                       ResourceId:LONGWORD;
                       ResourceModule:HModule;
                       WindowId:LONGWORD;
                       HasMenu:BOOLEAN;
                       Menu:HWND;
                       HasIcon:BOOLEAN;
                       HasAccelTable:BOOLEAN;
                       HasHelp:BOOLEAN;
                       HelpFileName:CSTRING;
                       HelpWindowTitle:CSTRING;
                       FontName:CSTRING;
                       FontWidth,FontHeight:BYTE;
                       FontNameSize:CSTRING;
                   END;

     { TWindow object }
     PWindow = ^TWindow;
     TWindow = OBJECT(TWindowsObject)
                   DesktopWin:PWindow;
                   Attr:TWindowAttr;
                   StatusBarSize,ToolBarSize:WORD;
                   LeftToolBarSize,RightToolBarSize:WORD;
                   ToolBarColor,StatusBarColor:LONGINT;
                   ToolBarInterior:PToolBarInterior;
                   StatusBarInterior:PStatusBarInterior;
                   StatusBarFontName:CSTRING;
                   StatusBarFontWidth,StatusBarFontHeight:WORD;
                   StatusBarFontFlags:LONGWORD;
                   MenuHelpItems:PMenuHelpItems;
                   HelpWindow:HWND;
                   StatusBarTextBaseLine:BYTE;
                   RedrawExclusive:BOOLEAN;

                   CONSTRUCTOR Init(AParent:PWindowsObject; ATitle:STRING);
                   FUNCTION InitializeDesktop(ParentWin:PWindowsObject):
                                        PWindow;VIRTUAL;
                   PROCEDURE HelpInitError(err:LONGWORD);VIRTUAL;
                   FUNCTION Create:BOOLEAN;VIRTUAL;
                   PROCEDURE Show(ShowCmd:LONGWORD);VIRTUAL;
                   PROCEDURE SetPosition;VIRTUAL;
                   PROCEDURE SetupWindow;VIRTUAL;
                   PROCEDURE GetDesktopLimits(VAR aswp:SWP);VIRTUAL;
                   PROCEDURE SetupDesktop;VIRTUAL;
                   PROCEDURE CloseNotify;VIRTUAL;
                   PROCEDURE CreateToolBar(Size:WORD);
                   PROCEDURE CreateStatusBar(Size:WORD);
                   PROCEDURE Redraw(VAR ahps:HPS;VAR rc:RECTL);VIRTUAL;
                   PROCEDURE RedrawToolBar(ahps:HPS);VIRTUAL;
                   PROCEDURE ToolBarSetButtonState(id:LONGWORD;Enabled:BOOLEAN);
                   PROCEDURE ToolBarSetButtonText(id:LONGWORD;name:STRING);
                   FUNCTION  GetToolBarControl(id:LONGWORD):PToolBarInterior;
                   PROCEDURE HandleToolBarEvent(VAR Msg:TMessage;Control:PToolBarInterior);
                   PROCEDURE RedrawStatusBar(ahps:HPS);VIRTUAL;
                   PROCEDURE ToolBarInsertButton(id,res,x,y,
                                                 cx,cy:LONGWORD);
                   PROCEDURE ToolBarInsertControl(id,x,y,cx,cy,
                                                  flag,aclass:LONGWORD;
                                                  title:STRING);
                   FUNCTION StatusBarInsertItem(id:WORD;x,y,cx,cy:LONGWORD;
                                    Exclusive:BOOLEAN):PStatusBarInterior;
                   PROCEDURE StatusBarSetText(id:WORD;item:STRING;Col:LONGINT);

                   PROCEDURE InsertMenuHelp(StatusID,MenuID:WORD;
                                            HelpText:String;Col:LONGWORD);
                   PROCEDURE SetupMenu;VIRTUAL;
                   PROCEDURE SetMenuState(id:WORD;State:BOOLEAN);
                   PROCEDURE InvalidateWindow;VIRTUAL;
                   PROCEDURE FirstChildWindow;VIRTUAL;
                   PROCEDURE NoMoreChildWindows;VIRTUAL;
                   PROCEDURE InitWindowHelp(HelpFileName,HelpTitle:STRING);

                   PROCEDURE WMSize(VAR Msg:TMessage);
                                   VIRTUAL WM_FIRST+WM_SIZE;
                   PROCEDURE WMMenuSelect(VAR Msg:TMessage);
                                   VIRTUAL WM_FIRST+WM_MENUSELECT;
                   PROCEDURE WMMenuend(VAR Msg:TMessage);
                                   VIRTUAL WM_FIRST+WM_MENUEND;
                   PROCEDURE WMMove(VAR Msg:TMessage);
                                   VIRTUAL WM_FIRST+WM_MOVE;
                   PROCEDURE WMDestroy(var Msg: TMessage);
                                   VIRTUAL WM_FIRST+WM_DESTROY;
                   PROCEDURE WMTranslateAccel(VAR Msg:TMessage);
                                   VIRTUAL WM_FIRST+WM_TRANSLATEACCEL;

                   PROCEDURE CMTile(VAR Msg:TMessage);
                                   VIRTUAL CM_FIRST+CM_TILE;
                   PROCEDURE CMCascade(VAR Msg:TMessage);
                                   VIRTUAL CM_FIRST+CM_CASCADE;
                   PROCEDURE CMClose(VAR Msg:TMessage);
                                   VIRTUAL CM_FIRST+CM_CLOSE;
                   PROCEDURE CMCloseAll(VAR Msg:TMessage);
                                   VIRTUAL CM_FIRST+CM_CLOSEALL;
                   PROCEDURE CMNext(VAR Msg:TMessage);
                                   VIRTUAL CM_FIRST+CM_NEXT;
                   PROCEDURE CMPrevious(VAR Msg:TMessage);
                                   VIRTUAL CM_FIRST+CM_PREVIOUS;
                   PROCEDURE CMQuit(VAR Msg:TMessage);
                                   VIRTUAL CM_FIRST+CM_QUIT;
                   PROCEDURE CMHelpOnHelp(VAR Msg:TMessage);
                                   VIRTUAL CM_FIRST+CM_HELPONHELP;
                   PROCEDURE CMExtendedHelp(VAR Msg:TMessage);
                                   VIRTUAL CM_FIRST+CM_EXTENDEDHELP;
                   PROCEDURE CMKeysHelp(VAR Msg:TMessage);
                                   VIRTUAL CM_FIRST+CM_KEYSHELP;
                   PROCEDURE CMHelpIndex(VAR Msg:TMessage);
                                   VIRTUAL CM_FIRST+CM_HELPINDEX;
                   PROCEDURE CMHelpContents(VAR Msg:TMessage);
                                   VIRTUAL CM_FIRST+CM_HELPCONTENTS;
              END;

     { TApplication object }
     PApplication = ^TApplication;
     TApplication = OBJECT
                      ApplicationName: STRING;
                      MainWindow: PWindow;
                      CONSTRUCTOR Init(AName:STRING);
                      DESTRUCTOR Done;VIRTUAL;
                      PROCEDURE InitMainWindow;VIRTUAL;
                      PROCEDURE Run;VIRTUAL;
                      PROCEDURE MessageLoop;
                      PROCEDURE SetupRun;VIRTUAL;
                      PROCEDURE RunFailed(Code:BYTE);VIRTUAL;
                    END;


VAR
   Application:PApplication;  {Main Application window}
   Button1Down:BOOLEAN;
   Button2Down:BOOLEAN;

FUNCTION  ConfirmBox(Options:LONGWORD;title,msg:STRING):BOOLEAN;
PROCEDURE MessageBox(title,msg:STRING);
PROCEDURE ErrorBox(Options:LONGWORD;title,err:STRING);
PROCEDURE PerformDMTMsg(W: PWindowsObject; var M: TMessage; DVMTIndex: LONGWORD;
                        FailureProc:LONGWORD);
PROCEDURE DrawStringXY(ahps:HPS;VAR pt:POINTL;VAR s:STRING;start,Len:LONGWORD;
                       Color,BackColor:LONGWORD);
FUNCTION  IsWindowMinimized(Win:HWND):BOOLEAN;
FUNCTION  IsWindowMaximized(Win:HWND):BOOLEAN;
PROCEDURE GetWindowPos(Win:HWND;VAR x,y,cx,cy:LONGINT);
PROCEDURE PopupMenu(VAR Menu:HWND;id:LONGWORD;x,y:LONGWORD;Parent:HWND);
PROCEDURE CreateLogFont(_HPS:LONGWORD;CONST facename:CSTRING;
                        hei,len,SelAttr:LONGWORD);

IMPLEMENTATION

IMPORTS
       FUNCTION GpiCharStringAt(ahps:HPS;VAR pptlPoint:POINTL;lCount:LONG;
                                VAR pchString):LONG;
                    APIENTRY;                PMGPI index 359;
       FUNCTION GpiSetColor(ahps:HPS;lColor:LONG):BOOL;
                    APIENTRY;                PMGPI index 517;
       FUNCTION GpiSetBackColor(ahps:HPS;lColor:LONG):BOOL;
                    APIENTRY;                PMGPI index 504;
       FUNCTION GpiSetBackMix(ahps:HPS;lMixMode:LONG):BOOL;
                    APIENTRY;                PMGPI index 505;
END;

PROCEDURE Abstract;
BEGIN
     RunError(211);
END;

FUNCTION NewStr(S:STRING):PString;
VAR
   p:PString;
BEGIN
     IF s='' THEN NewStr:=NIL
     ELSE
     BEGIN
          getmem(p,length(s)+1);
          p^:=s;
          NewStr:=p;
     END;
END;

PROCEDURE DisposeStr(ps:PString);
BEGIN
     IF ps<>NIL THEN freemem(ps,length(ps^)+1);
END;


{*************************************************************************
 *                                                                       *
 *  Object TObject                                                       *
 *                                                                       *
 *************************************************************************}


CONSTRUCTOR TOPMLObject.Init;
BEGIN
END;

PROCEDURE TOPMLObject.Free;
BEGIN
     SELF.Done;
END;

DESTRUCTOR TOPMLObject.Done;
BEGIN
END;


{*************************************************************************
 *                                                                       *
 *   Generic functions                                                   *
 *                                                                       *
 *************************************************************************}

PROCEDURE CreateLogFont(_hps:LONGWORD;CONST facename:CSTRING;hei,len,
                        SelAttr:LONGWORD);
VAR  fa:FATTRS;
BEGIN
     fa.szFaceName:=facename;
     fa.usRecordLength:=sizeof(FATTRS);
     fa.fsSelection:=SelAttr;
     fa.lMatch:=1;
     fa.idRegistry:=0;
     fa.usCodePage:=0; {default}
     fa.lMaxbaseLineExt:=hei;
     fa.lAveCharWidth:=len;
     fa.fsType:=0;
     fa.fsFontUse:=0;
     GpiCreateLogFont(_hps,NIL,1,fa);
     GpiSetCharSet(_hps,1);
END;


PROCEDURE PopupMenu(VAR Menu:HWND;id:LONGWORD;x,y:LONGWORD;Parent:HWND);
BEGIN
     IF Menu=0 THEN Menu:=WinLoadMenu(HWND_OBJECT,0,id);
     WinPopupMenu(Parent,Parent,Menu,x,y,0,
                  PU_HCONSTRAIN OR PU_VCONSTRAIN OR PU_KEYBOARD OR
                  PU_MOUSEBUTTON2 OR PU_MOUSEBUTTON1);
END;

PROCEDURE GetWindowPos(Win:HWND;VAR x,y,cx,cy:LONGINT);
VAR
   aswp:SWP;
BEGIN
     WinQueryWindowPos(Win,aswp);
     x:=aswp.x;
     y:=aswp.y;
     cx:=aswp.cx;
     cy:=aswp.cy;
END;

FUNCTION ConfirmBox(Options:LONGWORD;title,msg:String):BOOLEAN;
VAR
    result:LONGWORD;
    Parent:HWND;
    cmsg,ctitle:CSTRING;
BEGIN
     cmsg:=msg;
     ctitle:=title;
     Parent:=HWND_DESKTOP;
     IF Application<>NIL THEN IF Application^.MainWindow<>NIL THEN
       IF Application^.MainWindow^.HWindow<>0 THEN
        Parent:=Application^.MainWindow^.HWindow;
     result:=WinMessageBox(HWND_DESKTOP,Parent,cmsg,ctitle,0,
                           MB_APPLMODAL OR MB_QUERY OR MB_YESNO OR MB_MOVEABLE
                           OR Options);
     ConfirmBox:=result=MBID_YES;
END;

FUNCTION IsWindowMinimized(Win:HWND):BOOLEAN;
VAR  r:LONGWORD;
BEGIN
     IF Win=0 THEN
     BEGIN
          IsWindowMinimized:=FALSE;
          exit;
     END;
     IF WinQueryWindowUShort(Win,QWS_ID)=FID_CLIENT THEN
        Win:=WinQueryWindow(Win,QW_PARENT);
     r:=WinQueryWindowULong(Win,QWL_STYLE) AND WS_MINIMIZED;
     IF r<>0 THEN IsWindowMinimized:=TRUE
     ELSE IsWindowMinimized:=FALSE;
END;

FUNCTION IsWindowMaximized(Win:HWND):BOOLEAN;
VAR r:LONGWORD;
BEGIN
     IF Win=0 THEN
     BEGIN
          IsWindowMaximized:=FALSE;
          exit;
     END;
     IF WinQueryWindowUShort(Win,QWS_ID)=FID_CLIENT THEN
        Win:=WinQueryWindow(Win,QW_PARENT);
     r:=WinQueryWindowULong(Win,QWL_STYLE) AND WS_MAXIMIZED;
     IF r<>0 THEN IsWindowMaximized:=TRUE
     ELSE IsWindowMaximized:=FALSE;
END;


PROCEDURE MessageBox(title,msg:String);
VAR
   Parent:HWND;
   cmsg,ctitle:CSTRING;
BEGIN
     cmsg:=msg;
     ctitle:=title;
     Parent:=HWND_DESKTOP;
     IF Application<>NIL THEN IF Application^.MainWindow<>NIL THEN
       IF Application^.MainWindow^.HWindow<>0 THEN
        Parent:=Application^.MainWindow^.HWindow;
     WinMessageBox(HWND_DESKTOP,Parent,cmsg,ctitle,0,
                  MB_APPLMODAL OR MB_OK OR MB_MOVEABLE OR MB_QUERY);
END;

PROCEDURE ErrorBox(Options:LONGWORD;title,err:String);
VAR Parent:HWND;
    ctitle,cerr:CSTRING;
BEGIN
     ctitle:=title;
     cerr:=err;
     Parent:=HWND_DESKTOP;
     IF Application<>NIL THEN IF Application^.MainWindow<>NIL THEN
       IF Application^.MainWindow^.HWindow<>0 THEN
        Parent:=Application^.MainWindow^.HWindow;
     WinMessageBox(HWND_DESKTOP,Parent,cerr,ctitle,0,
                   MB_APPLMODAL OR MB_OK OR MB_MOVEABLE OR Options);
END;

PROCEDURE DrawStringXY(ahps:HPS;VAR pt:POINTL;VAR s:string;start,Len:LONGWORD;
                       Color,BackColor:LONGWORD);
BEGIN
     GpiSetColor(ahps,Color);
     GpiSetBackColor(ahps,BackColor);
     GpiCharStringAt(ahps,pt,Len,s[Start]);
END;



{ Calls a procedure in the TWindowsObject's DVMT indicated by DVMTIndex,
  if found.  Else calls the passed FailureProc - This is normaly
  TWindowsObject_DefWndProc}
PROCEDURE PerformDMTMsg(W: PWindowsObject; var M: TMessage; DVMTIndex: LONGWORD;
                        FailureProc:LONGWORD);
VAR DMTFound:BOOLEAN;
LABEL l;
BEGIN
     DMTFound:=FALSE;
     {Try to call DMT method}
     ASM
        MOV EDI,$W         //Pointer to Object
        //MOV EDI,[EDI+0]    //SELF Pointer             EDI = SELF
        MOV EDI,[EDI+0]    //Get VMT Pointer
        MOV ESI,[EDI+0]    //Get DMT Pointer
        MOV ECX,[ESI+0]    //number of DMT entries
        CMP ECX,0
        JE !NoDMT1         //no dynamic methods
        ADD ESI,4          //onto first DMT entry
        MOV EAX,$DVMTIndex
!DMTLoop1:
        CMP [ESI+0],EAX
        JE !DMTHere1       //Message found
        ADD ESI,8          //next DMT entry
        LOOP !DMTLoop1
        JMP !NoDMT1
!DMTHere1:
        MOVB $DMTFound,1
        MOV EAX,$M
        PUSH EAX           //Parameter for dynamic method call
        MOV EAX,[ESI+4]    //Get VMT index
        MOV ESI,$W
        //MOV ESI,[ESI+0]    //SELF pointer
        PUSH ESI           //VMT for dynamic method
        CALLN32 [EDI+EAX*4]  //--> Call VMT method
!NoDMT1:
      END;
l:
      IF not DMTFound THEN {Call FailureProc in VMT}
      BEGIN
           ASM
              MOV EAX,$M
              PUSH EAX          //Push Parameter TMessage
              MOV EDI,$W        //Get Pointer to Object
              //MOV EDI,[EDI+0]   //SELF pointer
              PUSH EDI
              MOV EDI,[EDI+0]   //VMT table address
              MOV EAX,$FailureProc  //Add failure Offset
              CALLN32 [EDI+EAX*4]   //--> Call VMT method
           END;
      END;
END;

{*************************************************************************
 *                                                                       *
 *  Object TWindowsObject                                                *
 *                                                                       *
 *************************************************************************}

{Creates and initializes the object}
CONSTRUCTOR TWindowsObject.Init(AParent: PWindowsObject);
BEGIN
     id:=-1;
     WinFlags:=0;  {No flags created}
     HWindow:=0; {No window created}
     HWindowFrame:=0; {No window created}
     Parent:=AParent;  {Set parent window}
     FirstChild:=NIL; {No child windows}
     LastChild:=NIL; {No child windows}
     Previous:=NIL; {No child windows}
     Next:=NIL; {No child windows}
     SetActiveChild(NIL);
     {Getmem(ObjectPtr,4);
     POINTER(ObjectPtr^):=POINTER(SELF); ??}
     {}POINTER(ObjectPtr):=POINTER(SELF);{}
     IF Parent<>NIL THEN Parent^.AddChild(ObjectPtr); {create child in parent}
     AutoCreate:=TRUE;  {Create this window automatically}
     WinColor:=CLR_BLACK;
     WinBackColor:=CLR_WHITE;
     Register;  {Register the Window Class}
     EnableAutoCreate;  {Enable auto creation}
     EnableAutoFill;    {Fill the background with the current color}
     MaxDoubleChars:=10;
     MaxDoubleScans:=10;
END;

FUNCTION TWindowsObject.GetID:LONGINT;
BEGIN
     GetID:=id;
END;

{This Method is called when the first child of a window is created via
 TWindowsObject.Init. This can be used to enable/disable Menu-entries
 for the child windows}
PROCEDURE TWindowsObject.FirstChildWindow;
BEGIN
END;

{This Method is called whenever no childs of the current window exists.
 This is when the the last of the child windows is closed via
 TWindowsObject.CloseWindow.
 This can be used to enable/disable Menu-entries for the child windows}
PROCEDURE TWindowsObject.NoMoreChildWindows;
BEGIN
END;

FUNCTION TWindowsObject.IndexOf(P: PWindowsObject): Integer;
VAR dummy:PWindowsObject;
    result:INTEGER;
LABEL l;
BEGIN
     result:=1;
     dummy:=FirstChild;
     WHILE dummy<>NIL DO
     BEGIN
          IF dummy=P THEN goto l;
          inc(result);
          dummy:=dummy^.Next;
     END;
     result:=0;
l:
     IndexOf:=result;
END;

FUNCTION TWindowsObject.At(I: Integer): PWindowsObject;
VAR dummy:PWindowsObject;
    result:PWindowsObject;
    count:Integer;
LABEL l;
BEGIN
     dummy:=FirstChild;
     count:=1;
     WHILE dummy<>NIL DO
     BEGIN
          IF count=I THEN
          BEGIN
               result:=dummy;
               goto l;
          END;
          inc(count);
          dummy:=dummy^.next;
     END;
     result:=NIL;
l:
     At:=result;
END;

{Deletes the Object}
DESTRUCTOR TWindowsObject.Done;
VAR
   Win:HWND;
BEGIN
     IF Parent<>NIL THEN
     BEGIN
          Parent^.RemoveChild(ObjectPtr);
          IF Parent^.FirstChild=NIL THEN Parent^.SetActiveChild(NIL);
          Parent:=NIL;
     END;
     IF HWindow=0 THEN exit;
     Win:=WinQueryWindow(HWindow,QW_PARENT);
     IF Win=0 THEN exit;
     WinDestroyWindow(Win);
     HWindow:=0;
     HWindowFrame:=0;
END;

FUNCTION TWindowsObject.CreateMemoryDC: HDC;
VAR
   s,c:CSTRING;
   dop:DEVOPENSTRUC;
BEGIN
     FillChar(dop,sizeof(DEVOPENSTRUC),0);
     s:='*';
     c:='DISPLAY';
     dop.pszDriverName:=@c;
     CreateMemoryDC := DevOpenDC(AppHandle,OD_MEMORY,s,3,dop,0);
END;

PROCEDURE TWindowsObject.SetFlags(Mask:LONGWORD;OnOff:BOOLEAN);
BEGIN
     IF OnOff THEN WinFlags:=WinFlags OR Mask
     ELSE WinFlags:=WinFlags AND (Not Mask);
END;

FUNCTION TWindowsObject.IsFlagSet(Mask:LONGWORD):BOOLEAN;
BEGIN
     IF WinFlags AND Mask=Mask THEN IsFlagSet:=TRUE
     ELSE IsFlagSet:=FALSE;
END;

FUNCTION TWindowsObject.GetActiveChild:PWindowsObject;
BEGIN
     GetActiveChild:=ActiveChild;
END;

FUNCTION TWindowsObject.IsAChild(w:PWindowsObject):BOOLEAN;
VAR dummy:PWindowsObject;
    result:BOOLEAN;
LABEL l;
BEGIN
     result:=FALSE;
     dummy:=FirstChild;
     WHILE dummy<>NIL DO
     BEGIN
          IF dummy=w THEN
          BEGIN
               result:=TRUE;
               goto l;
          END;
          dummy:=dummy^.next;
     END;
l:
     IsAChild:=result;
END;


PROCEDURE TWindowsObject.SetActiveChild(NewChild:PWindowsObject);
BEGIN
     ActiveChild:=NewChild;
END;


PROCEDURE TWindowsObject.EnableAutoFill;
BEGIN
     SetFlags(WF_AUTOFILL,TRUE);
END;

PROCEDURE TWindowsObject.DisableAutoFill;
BEGIN
     SetFlags(WF_AUTOFILL,FALSE);
END;

PROCEDURE TWindowsObject.EnableAutoCreate;
BEGIN
    SetFlags(WF_AUTOCREATE,TRUE);
END;

PROCEDURE TWindowsObject.DisableAutoCreate;
BEGIN
     SetFlags(WF_AUTOCREATE,FALSE);
END;

{Get the Standard ClassName}
FUNCTION TWindowsObject.GetClassName:STRING;
BEGIN
     GetClassName:='SpeedWindow';
END;


{This is the default window procedure for all objects called by PM.
 It is only called when the window is created and then redefined.}
FUNCTION TheStartHandler(Win:HWND;msg:LONGWORD;para1,para2:LONGWORD):
                         LONGWORD;CDECL;
BEGIN
     TheStartHandler:=WinDefWindowProc(Win,Msg,Para1,Para2);
END;

{This is the window procedure called by PM.
 As it has to be fast and low level programmed it is written in assembler...
 It will call HandleEvent VIRTUAL in the VMT}
FUNCTION TheMessageHandler(Win:HWND;Msg:LONGWORD;para1,para2:POINTER):
                           LONGWORD;CDECL;
BEGIN
     ASM
        //Prepare the parameters for a call to HandleEvent
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

        PUSH EDI             //VMT Pointer      SELF
        MOV EDI,[EDI+0]      //get VMT pointer for HandleEvent
        MOV EAX,5            //TWindowsObject_HandleEvent = 5     {_VMT_}
        CALLN32 [EDI+EAX*4]  //call method
        MOV $!FUNCRESULT,EAX //result value
     END;
END;

FUNCTION TWindowsObject.ChildWithId(aId: LongInt): PWindowsObject;
VAR
   dummy:PWindowsObject;
   result:PWindowsObject;
LABEL l;
BEGIN
     result:=NIL;
     dummy:=FirstChild;
     WHILE dummy<>NIL DO
     BEGIN
          IF dummy^.GetID=aId THEN
          BEGIN
               result:=dummy;
               goto l;
          END;
          dummy:=dummy^.next;
     END;
l:
     ChildWithID:=result;
END;

PROCEDURE TWindowsObject.HandleCharEvent(Win:HWND;param,Rep:WORD);
BEGIN
END;

PROCEDURE TWindowsObject.HandleScanEvent(Win:HWND;param,Rep:WORD);
BEGIN
END;


PROCEDURE TWindowsObject.WindowToTop;
BEGIN
     WinSetWindowPos(HWindowFrame,HWND_TOP,0,0,0,0,SWP_ZORDER OR SWP_ACTIVATE
                     OR SWP_SHOW);
     WinSetActiveWindow(HWND_DESKTOP,HWindowFrame);
     IF Parent<>NIL THEN Parent^.SetActiveChild(ObjectPtr);
END;


PROCEDURE TWindowsObject.WMChar(VAR Msg:TMessage);
VAR  fsflags : WORD;
     ascii : WORD;
     virtkey : WORD;
     rep : BYTE;
     scan : WORD;
     param : WORD;
     Queue : QMSG;
LABEL lsc;

FUNCTION DeleteDoubles(VAR M : TMessage; MaxDoubles : BYTE) : BYTE;
VAR  rep : BYTE;
LABEL q;
BEGIN
     rep := 1;
     WHILE WinPeekMsg(HInstance,Queue,0,WM_CHAR,WM_CHAR,0) DO
     BEGIN
          IF (LONGWORD(Queue.mp1) = M.Param1) AND
             (LONGWORD(Queue.mp2) = M.Param2) THEN
          BEGIN
               WinGetMsg(HInstance,Queue,0,WM_CHAR,WM_CHAR);
               inc(rep);
               IF rep >= MaxDoubles THEN goto q;
          END
          ELSE goto q;
     END;
q:
     DeleteDoubles:=rep;
END;

BEGIN
     fsflags := Msg.Param1Lo;
     rep := Msg.Param1HiByteLo;
     scan := Msg.Param1HiByteHi;
     ascii := Msg.Param2LoByteLo;
     virtkey := Msg.Param2Hi;

     IF fsflags AND KC_KEYUP <> 0 THEN exit;

     IF fsflags AND KC_CHAR <> 0 THEN
     BEGIN
          IF (ascii < 32) OR  (fsflags AND KC_CTRL <> 0) THEN goto lsc;
          IF (fsflags AND KC_VIRTUALKEY <> 0) AND (fsflags AND KC_SHIFT <> 0)
          THEN goto lsc;    {numerical block}
          IF IsFlagSet(WF_DELETEDOUBLECHAR) THEN rep := DeleteDoubles(Msg,MaxDoubleChars);
          param := ascii;
          HandleCharEvent(Msg.Receiver,param,rep);
     END
     ELSE
     BEGIN
lsc:
          IF IsFlagSet(WF_DELETEDOUBLESCAN) THEN rep := DeleteDoubles(Msg,MaxDoubleScans);
          IF fsflags AND KC_VIRTUALKEY <> 0 THEN
          BEGIN
               param := virtkey OR kbVK;
               IF fsflags AND KC_SHIFT <> 0 THEN param := param OR kb_Shift;
          END
          ELSE param := ord(Upcase(chr(ascii)));       {e.g. Ctrl-J}

          IF fsflags AND KC_ALT <> 0 THEN param := param OR kb_Alt;
          IF fsflags AND KC_CTRL <> 0 THEN param := param OR kb_Ctrl;
          HandleScanEvent(Msg.Receiver,param,rep);
     END;
END;


PROCEDURE TWindowsObject.WMSize(VAR Msg:TMessage);
BEGIN
END;

PROCEDURE TWindowsObject.WMMove(VAR Msg:TMessage);
BEGIN
END;

{Register the desired window procedure if it is not always}
FUNCTION TWindowsObject.Register: BOOLEAN;
VAR
  aClass:CLASSINFO;
  WindowClass:TWndClass;
  cs:CSTRING;
BEGIN
  cs:=GetClassName;
  IF WinQueryClassInfo(HInstance,cs,aClass)=FALSE then
  BEGIN  {Class not registered}
      GetWindowClass(WindowClass);
      Register := BOOLEAN(WinRegisterClass(HInstance,cs,
                                           @WindowClass.ClassWndProc,
                                           WindowClass.ClassStyle,
                                           WindowClass.cbWindowData));
  END
  ELSE Register:=TRUE; {Class always registered}
END;


PROCEDURE TWindowsObject.GetWindowClass(VAR AWndClass: TWndClass);
BEGIN
     WITH AWndClass DO
     BEGIN
          ClassName:=GetClassName;
          ClassNameUlong:=0;   {for WC_Name Constants}
          ClassStyle:=CS_SIZEREDRAW OR CS_MOVENOTIFY;
          ClassWndProc:=@TheStartHandler;
          cbWindowData:=4;  {4 Byte window data for SELF pointer}
     END;
END;

{add an object to the childs list}
PROCEDURE TWindowsObject.AddChild(AChild: PWindowsObject);
BEGIN
     IF AChild=NIL THEN exit;
     IF FirstChild=NIL THEN
     BEGIN
          IF IsFlagSet(WF_ISDESKTOP) THEN  {route to parent}
          BEGIN
               IF Parent<>NIL THEN Parent^.FirstChildWindow
               ELSE FirstChildWindow;
          END
          ELSE FirstChildWindow;
          FirstChild:=AChild;
          FirstChild^.Previous:=NIL;
     END
     ELSE
     BEGIN
          AChild^.Previous:=LastChild;
          LastChild^.Next:=AChild;
     END;
     LastChild:=AChild;
     LastChild^.Next:=NIL;
END;

{removes a Object from the childs list}
PROCEDURE TWindowsObject.RemoveChild(AChild: PWindowsObject);
VAR List:PWindowsObject;
BEGIN
     IF AChild=NIL THEN exit;
     IF AChild=FirstChild THEN
     BEGIN
          FirstChild:=AChild^.Next;
          IF FirstChild<>NIL THEN FirstChild^.Previous:=NIL
          ELSE
          BEGIN
               IF IsFlagSet(WF_ISDESKTOP) THEN {route to parent}
               BEGIN
                    IF Parent<>NIL THEN Parent^.NoMoreChildWindows
                    ELSE NoMoreChildWindows;
               END
               ELSE NoMoreChildWindows;
          END;
          exit;
     END;
     IF AChild=LastChild THEN
     BEGIN
          LastChild:=AChild^.Previous;
          IF LastChild<>NIL THEN LastChild^.Next:=NIL;
          exit;
     END;
     List:=FirstChild;
     WHILE List<>NIL DO
     BEGIN
          IF List=AChild THEN
          BEGIN
               AChild^.Previous^.Next:=AChild^.Next;
               AChild^.Next^.Previous:=AChild^.Previous;
               exit;
          END;
          List:=List^.Next;
     END;
END;

{Perform the action for each child window beginning with the first added
 child window}
PROCEDURE TWindowsObject.ForEach(Action:PROCEDURE(P:PWindowsObject));
VAR
   aChild:PWindowsObject;
BEGIN
     aChild:=FirstChild;
     WHILE aChild<>NIL DO
     BEGIN
          Action(aChild);  {Do Action}
          aChild:=aChild^.Next;
     END;
END;


{ Returns a pointer to the first TWindowsObject in the ChildList
  that meets some specified criteria returned by a function defined
  by Test. This Function has a PWindowsObject as the only parameter
  and must return a boolean value)}
FUNCTION TWindowsObject.FirstThat(Test:FUNCTION(achild:PWindowsObject):
                                  BOOLEAN ): PWindowsObject;
VAR
   aChild:PWindowsObject;
LABEL l;
BEGIN
     aChild:=FirstChild;
     WHILE aChild<>NIL DO
     BEGIN
          IF test(aChild) THEN goto l;
          aChild:=aChild^.Next;
     END;
l:
     FirstThat:=aChild;
END;

{ Returns a pointer to the last TWindowsObject in the ChildList
  that meets some specified criteria returned by a function defined
  by Test. This Function has a PWindowsObject as the only parameter
  and must return a boolean value)}
FUNCTION TWindowsObject.LastThat(Test:FUNCTION(achild:PWindowsObject):
                                  BOOLEAN ): PWindowsObject;
VAR
   aChild:PWindowsObject;
LABEL l;
BEGIN
     aChild:=LastChild;
     WHILE aChild<>NIL DO
     BEGIN
          IF test(aChild) THEN goto l;
          aChild:=aChild^.Previous;
     END;
l:
     LastThat:=aChild;
END;


FUNCTION TWindowsObject.Create:BOOLEAN;
BEGIN
     Create:=FALSE;
END;


PROCEDURE CreateIt(P:PWindowsObject);
BEGIN
     P^.Create;
END;

PROCEDURE TWindowsObject.CreateChildren;
BEGIN
     ForEach(@CreateIt);  {Create all children}
END;

PROCEDURE TWindowsObject.SetupWindow;
BEGIN
     CreateChildren;
END;


PROCEDURE TWindowsObject.Redraw(VAR ahps:HPS;VAR rc:RECTL);
BEGIN
END;

PROCEDURE TWindowsObject.WMButton1Down(VAR Msg:TMessage);
BEGIN
     Button1Down:=TRUE;
END;

PROCEDURE TWindowsObject.WMButton2Down(VAR Msg:TMessage);
BEGIN
     Button2Down:=TRUE;
END;

PROCEDURE TWindowsObject.WMButton1Up(VAR Msg:TMessage);
BEGIN
     Button1Down:=FALSE;
END;

PROCEDURE TWindowsObject.WMButton2Up(VAR Msg:TMessage);
BEGIN
     Button2Down:=FALSE;
END;

PROCEDURE TWindowsObject.WMButton1CLICK(VAR Msg:TMessage);
BEGIN
     Button1Down:=FALSE;
END;

PROCEDURE TWindowsObject.WMButton2CLICK(VAR Msg:TMessage);
BEGIN
     Button2Down:=FALSE;
END;

PROCEDURE TWindowsObject.WMButton1DBLCLK(VAR Msg:TMessage);
BEGIN
     Button1Down:=FALSE;
END;

PROCEDURE TWindowsObject.WMButton2DBLCLK(VAR Msg:TMessage);
BEGIN
     Button2Down:=FALSE;
END;

PROCEDURE TWindowsObject.WMMouseMove(VAR Msg:TMessage);
VAR
   state:LONGWORD;
BEGIN
     IF Button1Down THEN
     BEGIN
          state:=WinGetKeyState(HWND_DESKTOP,VK_BUTTON1);
          IF state AND $8000=$8000 THEN
            WinSendMsg(Msg.Receiver,WM_MOUSEDRAG1,
                       Msg.Param1,Msg.Param2)
          ELSE Button1Down:=FALSE;
     END;
     IF Button2Down THEN
     BEGIN
          state:=WinGetKeyState(HWND_DESKTOP,VK_BUTTON2);
          IF state AND $8000=$8000 THEN
            WinSendMsg(Msg.Receiver,WM_MOUSEDRAG2,
                       Msg.Param1,Msg.Param2)
          ELSE Button2Down:=FALSE;
     END;
END;


PROCEDURE TWindowsObject.WMPaint(VAR Msg:TMessage);
VAR
     rc,rc1:RECTL;
     ahps:HPS;
BEGIN
     ahps:=WinBeginPaint(HWindow,0,rc);
     IF IsFlagSet(WF_AUTOFILL) THEN
     BEGIN
          WinQueryWindowRect(HWindow,rc1);  {Fill whole window}
          WinFillRect(ahps,rc1,WinBackColor);
     END;
     Redraw(ahps,rc);
     WinEndPaint(ahps);
END;



{This Message occured if the Background of a window has to be redrawn}
PROCEDURE TWindowsObject.WMEraseBackGround(VAR Msg:TMessage);
BEGIN
END;

{This function will be called as a result of the WM_COMMAND message
 It will call the Command procedure or DefCommandProc}
PROCEDURE TWindowsObject.WMCommand(var Msg: TMessage);
BEGIN
     PerformDMTMsg(@SELF, Msg, Msg.Param1Lo,
                   TWindowsObject_DefWndProc);  {Handle it via DMT}
END;

{Is invoked if a WM_ACTIVATE Message was occured}
PROCEDURE TWindowsObject.WMActivate(VAR Msg: TMessage);
VAR  PrevChild:PWindowsObject;
     PrevWin:HWND;
BEGIN
     IF Msg.Param1Lo = 1 THEN {Window is being activated}
     BEGIN
          IF Parent <> NIL THEN Parent^.SetActiveChild(ObjectPtr);
     END
     ELSE {Window is being deactivated}
     BEGIN
          PrevWin := WinQueryWindow(HWindowFrame,QW_NEXT);
          PrevWin := WinWindowFromID(PrevWin,FID_CLIENT);
          PrevChild := PWindowsObject(WinQueryWindowULong(PrevWin,QWL_SELF));
          IF Parent <> NIL THEN Parent^.SetActiveChild(PrevChild);
     END;
END;

PROCEDURE TWindowsObject.WMDestroy(VAR Msg:TMessage);
BEGIN
END;

{ Close the PM window by invoking CloseWindow }
PROCEDURE TWindowsObject.WMClose(var Msg: TMessage);
BEGIN
     Msg.Handled:=TRUE;
     CloseWindow;
END;


{This function returnes TRUE if window cannot be closed}
FUNCTION CannotCloseChild(achild:PWindowsObject):BOOLEAN;
BEGIN
     IF achild^.CanClose THEN CannotCloseChild:=FALSE
     ELSE CannotCloseChild:=TRUE;  {Do not close !!}
END;

FUNCTION TWindowsObject.CanClose:BOOLEAN;
VAR p:PWindowsObject;
BEGIN
     p:=FirstThat(@CannotCloseChild);
     IF p=NIL THEN CanClose:=TRUE
     ELSE CanClose:=FALSE;
END;

PROCEDURE TWindowsObject.WindowDestroyed;
BEGIN
END;

PROCEDURE TWindowsObject.CloseNotify;
BEGIN
END;

{Close the window}
PROCEDURE TWindowsObject.CloseWindow;
VAR
   Win:HWND;
BEGIN
     IF HWindow=0 THEN exit;
     Win:=WinQueryWindow(HWindow,QW_PARENT);
     IF Win=0 THEN exit;
     IF CanClose THEN
     BEGIN
          CloseNotify;
          WinDestroyWindow(Win);
          HWindow:=0;
          HWindowFrame:=0;
          WindowDestroyed;
          IF Parent<>NIL THEN
          BEGIN
               Parent^.RemoveChild(ObjectPtr);
               IF Parent^.FirstChild=NIL THEN Parent^.SetActiveChild(NIL);
               Parent:=NIL;
          END;
          IF Pointer(SELF) = Application^.MainWindow
          THEN WinPostMsg(HWindow,WM_QUIT,0,0);
     END;
END;

{Message Handler. All Messages come here first. Use aMsg.Handled to indicate
 whether the message was handled or not}
FUNCTION TWindowsObject.HandleEvent(Win:HWND;Msg:LONGWORD;
                                    para1,para2:POINTER):LONGWORD;
{Handles messages for the main window}
VAR
    aMsg:TMessage;
    DMTFound:BOOLEAN;
BEGIN
     aMsg.Receiver:=Win;
     aMsg.Param1:=LONGWORD(Para1);
     aMsg.Param2:=LONGWORD(Para2);
     aMsg.Message:=Msg;
     amsg.Result:=0;
     amsg.Handled:=FALSE;  {not handled yet}
     DMTFound:=FALSE;

     PerformDmtMsg(@SELF,amsg,Msg,TWindowsObject_DefWndProc);
     IF not aMsg.Handled THEN DefWndProc(aMsg);  {not handled}
     HandleEvent:=aMsg.result;
END;

{Frame Message Handler. All Messages associated with the frame window
 come here first. Use amsg.Handled to indicate if the standard handler
 should be activated }
PROCEDURE TWindowsObject.FrameHandler(VAR Msg:TMessage);
BEGIN
END;

PROCEDURE TWindowsObject.FrameDefProc(VAR msg:TMessage);
VAR
   p:POINTER;
   amsg:LONGWORD;
   aWin:HWND;
   apara1,apara2:LONGWORD;
   result:LONGWORD;
BEGIN
     p:=OldFrameProc;
     amsg:=msg.message;
     aWin:=msg.receiver;
     apara1:=msg.Param1;
     apara2:=msg.Param2;
     ASM
        //Call old frame handler
        PUSHL $apara2
        PUSHL $apara1
        PUSHL $aMsg
        PUSHL $aWin
        MOV AL,4
        LEA EDI,$p
        CALLN32 [EDI+0]   //--> jump to old FrameWndProc
        ADD ESP,16
        MOV $result,EAX
     END;
     msg.result:=Result;
     msg.Handled:=TRUE;
END;

FUNCTION TWindowsObject.FrameHandleEvent(Win:HWND;Msg:LONGWORD;
                                         para1,para2:POINTER):LONGWORD;
VAR
    result:LONGWORD;
    aMsg:TMessage;
BEGIN
     aMsg.Receiver:=Win;
     aMsg.Param1:=LONGWORD(Para1);
     aMsg.Param2:=LONGWORD(Para2);
     aMsg.Message:=Msg;
     amsg.Result:=0;
     amsg.Handled:=FALSE;  {not handled yet}
     FrameHandler(amsg);
     IF not amsg.Handled THEN FrameDefProc(amsg);
     FrameHandleEvent:=amsg.result;
END;

FUNCTION TheFrameHandler(Win:HWND;Msg:LONGWORD;
                         para1,para2:POINTER):LONGWORD;CDECL;
VAR p:POINTER;
    ClientWin:HWND;
    VMT:LONGWORD;
BEGIN
     ClientWin:=WinWindowFromID(Win,FID_CLIENT);
     IF ClientWin=0 THEN Exit;
     VMT:=WinQueryWindowULong(ClientWin,0);
     ASM
        //Call FrameWndProc Method
        PUSHL $Win
        PUSHL $Msg
        PUSHL $Para1
        PUSHL $Para2
        PUSHL $VMT
        MOV EDI,$VMT
        MOV EDI,[EDI+0]      //VMT Index for FrameHandleEvent
        MOV EAX,7            //FrameWndProc=7
        CALLN32 [EDI+EAX*4]  //--> jump to Method FrameHandle
        MOV $!FUNCRESULT,EAX //Function result
     END;
END;

{Call the standard window procedure}
PROCEDURE TWindowsObject.DefWndProc(var Msg: TMessage);
BEGIN
     Msg.Result:=WinDefWindowProc(Msg.Receiver,Msg.Message,
                                  Msg.Param1,Msg.Param2);
     Msg.Handled:=TRUE;
END;

{Enable the Window}
FUNCTION TWindowsObject.Enable: Boolean;
BEGIN
     IF HWindow <> 0 then Enable := BOOLEAN(WinEnableWindow(HWindow,TRUE))
     ELSE Enable := False;
END;

{ Disable the window }
FUNCTION TWindowsObject.Disable: Boolean;
BEGIN
     IF HWindow <> 0 THEN Disable := BOOLEAN(WinEnableWindow(HWindow,FALSE))
     ELSE Disable := False;
END;

{ Focus the window }
PROCEDURE TWindowsObject.Focus;
BEGIN
     IF HWindow <> 0 THEN
       IF HWindow<>WinQueryFocus(HWND_DESKTOP) THEN
          WinSetFocus(HWND_DESKTOP,HWindow);
END;


PROCEDURE TWindowsObject.Capture(Clear:BOOLEAN);
BEGIN
     IF Clear THEN WinSetCapture(HWND_DESKTOP,0)
     ELSE WinSetCapture(HWND_DESKTOP,HWindow);
END;

{*************************************************************************
 *                                                                       *
 *  Object TWindow                                                       *
 *                                                                       *
 *************************************************************************}

CONSTRUCTOR TWindow.Init(AParent: PWindowsObject; ATitle:STRING);
VAR rc:RECTL;
BEGIN
     TWindowsObject.Init(AParent);
     WITH Attr DO
     BEGIN
          FontName:=''; {Standard}
          FontWidth:=16;
          FontHeight:=16;
          FontNameSize:=''; {Standard}
          Title:=ATitle;
          Style:=0;
          FrameFlags:=FCF_TASKLIST OR FCF_MINMAX OR FCF_SIZEBORDER OR
                      FCF_TITLEBAR OR FCF_SYSMENU;
          IF Parent=NIL THEN {Shellposition}
          BEGIN
               FrameFlags:=FrameFlags OR FCF_SHELLPOSITION;
               X:=0;
               Y:=0;
               W:=0;
               H:=0;
          END
          ELSE
          BEGIN
               FrameFlags:=FrameFlags OR FCF_NOBYTEALIGN;
               WinQueryWindowRect(AParent^.HWindow,rc);
               X:=rc.XLeft;
               Y:=rc.YBottom;
               W:=rc.XRight-rc.XLeft;
               H:=rc.YTop-Rc.YBottom;
          END;
          ResourceId:=0;
          ResourceModule:=DllModule;
          WindowId:=0;
          HasMenu := FALSE;
          HasIcon := FALSE;
          HasAccelTable:= FALSE;
          HasHelp := FALSE;
          HelpFileName:='';
          HelpWindowTitle:='';
     END;
     StatusBarSize:=0; {We don't have any Statusbar}
     RedrawExclusive:=FALSE;
     ToolBarSize:=0;   {We don't have any Toolbar}
     LeftToolBarSize:=0;
     RightToolBarSize:=0;
     DesktopWin:=NIL;
     ToolBarInterior:=NIL;
     StatusBarInterior:=NIL;
     MenuHelpItems:=NIL;
     StatusBarFontName:='System Proportional';
     StatusBarFontHeight:=10;
     StatusBarFontWidth:=5;
     StatusBarFontFlags:=0;
     StatusBarTextBaseLine := 6;
     HelpWindow:=0;
     SetFlags(WF_TILEONSIZE,FALSE);
     SetFlags(WF_SCALECHILDS,TRUE);
END;

PROCEDURE TWindow.InitWindowHelp(HelpFileName,HelpTitle:STRING);
BEGIN
     Attr.HasHelp:=TRUE;
     Attr.HelpFileName:=HelpFileName;
     Attr.HelpWindowTitle:=HelpTitle;
     PmHelp.HelpFilename:=HelpFileName;
     PmHelp.HelpWindowTitle:=HelpTitle;
END;



PROCEDURE TWindow.CloseNotify;
BEGIN
     Inherited CloseNotify;
     IF HelpWindow<>0 THEN WinDestroyHelpInstance(HelpWindow);
END;

PROCEDURE TWindow.WMTranslateAccel(VAR msg:TMessage);
VAR apqmsg:^QMSG;
    fsflags:BYTE;
    virtkey:WORD;
BEGIN
     IF not IsFlagSet(WF_ISDESKTOP) THEN exit;
     IF Parent=NIL THEN exit;
     apqmsg:=POINTER(msg.param1);
     fsflags := lo(apqmsg^.mp1);
     virtkey := hi(apqmsg^.mp2);
     IF fsflags AND KC_VIRTUALKEY <> 0 THEN
     BEGIN
          IF virtkey=VK_F10 THEN
          BEGIN
               apqmsg^.hwnd:=Parent^.HWindow;
               msg.result:=WinSendMsg(Parent^.HWindow,WM_TRANSLATEACCEL,
                                      msg.param1,msg.param2);
               msg.handled:=TRUE;
          END
          ELSE DefWndProc(msg);
     END
     ELSE DefWndProc(msg);
END;

{Show the Window}
PROCEDURE TWindow.Show(ShowCmd:LONGWORD);
BEGIN
     IF HWindow <> 0 THEN WinShowWindow(HWindow, BOOLEAN(ShowCmd));
END;

PROCEDURE TWindow.SetPosition;
BEGIN
     IF HWindow<>0 THEN
     BEGIN
         IF ((Attr.W=Width_Max)OR(Attr.H=Height_Max)) THEN
            WinSetWindowPos(HWindowFrame,HWND_TOP,0,0,0,0,
                            SWP_MAXIMIZE OR SWP_ACTIVATE OR SWP_SHOW)
         ELSE WinSetWindowPos(HWindowFrame,HWND_TOP,Attr.X,Attr.Y,Attr.W,
                              Attr.H,SWP_SIZE OR SWP_MOVE OR SWP_ACTIVATE
                              OR SWP_SHOW);
     END;
END;


PROCEDURE TWindow.SetupWindow;
BEGIN
     Inherited.SetupWindow;
     IF Attr.w>0 THEN SetPosition
     ELSE WinShowWindow(HWindowFrame,TRUE);
     Focus;
END;


PROCEDURE TWindow.WMMove(VAR Msg:TMessage);
BEGIN
     IF NOT IsWindowMinimized(HWindowFrame)
     THEN GetWindowPos(HWindowFrame,Attr.X,Attr.Y,Attr.W,Attr.H);
END;


PROCEDURE PosChild(Child:PWindow);
VAR aswp : SWP;
    rec : SWP;
    nx,ny : LONGINT;
    ncx,ncy : LONGINT;
    locScalX,locScalY : Extended;
BEGIN
     IF IsWindowMinimized(Child^.HWindowFrame) THEN exit;
     IF (ScalX = 0) OR (ScalY = 0) THEN exit; {Restore from Minimize}

     locScalX := ScalX;    {Save global Scale_ because of recursion}
     locScalY := ScalY;
     IF Child^.Parent = NIL THEN
     BEGIN
          aswp.cx := WinQuerySysValue(HWND_DESKTOP,SV_CXSCREEN);
          aswp.cy := WinQuerySysValue(HWND_DESKTOP,SV_CYSCREEN);
     END
     ELSE WinQueryWindowPos(Child^.Parent^.HWindow,aswp);
     WinQueryWindowPos(Child^.HWindowFrame,rec);

     nx := round(ScalX * rec.x);
     ncx := round(ScalX * rec.cx);
     IF IsWindowMaximized(Child^.HWindowFrame)
     THEN inc(aswp.cx,WinQuerySysValue(HWND_DESKTOP,SV_CXSIZEBORDER));
     IF nx + ncx > aswp.cx THEN ncx := aswp.cx - nx;
     IF ncx <= 0 THEN ncx := aswp.cx;

     ny := round(ScalY * rec.y);
     ncy := round(ScalY * rec.cy);
     IF IsWindowMaximized(Child^.HWindowFrame)
     THEN inc(aswp.cy,WinQuerySysValue(HWND_DESKTOP,SV_CYSIZEBORDER));
     IF ny + ncy > aswp.cy THEN ncy := aswp.cy - ny;
     IF ncy <= 0 THEN ncy := aswp.cy;

     WinSetWindowPos(Child^.HWindowFrame,0, nx, ny, ncx, ncy,
                     SWP_SIZE OR SWP_MOVE);
     ScalX := locScalX;
     ScalY := locScalY;
END;


PROCEDURE TWindow.WMSize(VAR Msg:TMessage);
VAR aswp : SWP;
    scxold,scyold : LONGINT;
    scxnew,scynew : LONGINT;
BEGIN
     Inherited.WMSize(Msg);

     IF NOT IsFlagSet(WF_ISDESKTOP) THEN
     BEGIN
          {Window size itself}
          {Window can have at least a maximum size of its parent}
          ScalX := 1;
          ScalY := 1;
          PosChild(ObjectPtr);
     END;

     IF NOT IsWindowMinimized(HWindowFrame)
     THEN GetWindowPos(HWindowFrame,Attr.X,Attr.Y,Attr.W,Attr.H);

     IF NOT IsFlagSet(WF_TILEONSIZE) THEN
     BEGIN
          IF IsFlagSet(WF_SCALECHILDS) THEN
            IF NOT IsFlagSet(WF_WITHDESKTOP) THEN
              IF NOT IsWindowMinimized(HWindowFrame) THEN
              BEGIN
                   scxold := Msg.Param1Lo;
                   scyold := Msg.Param1Hi;
                   scxnew := Msg.Param2Lo;
                   scynew := Msg.Param2Hi;

                   IF scxold = 0 THEN ScalX := 0
                   ELSE ScalX := scxnew / scxold;

                   IF scyold = 0 THEN ScalY := 0
                   ELSE ScalY := scynew / scyold;
                   ForEach(@PosChild);
              END;
     END
     ELSE WinSendMsg(Msg.Receiver,WM_COMMAND,CM_FIRST+CM_TILE,0);

     IF IsFlagSet(WF_WITHDESKTOP) THEN
     BEGIN
          IF DesktopWin <> NIL THEN
          BEGIN
               GetDesktopLimits(aswp);
               WinSetWindowPos(DesktopWin^.HWindowFrame,0,
                               aswp.x,aswp.y,aswp.cx,aswp.cy,
                               SWP_SIZE OR SWP_MOVE OR SWP_SHOW);
          END;
     END;
END;


PROCEDURE TWindow.GetDesktopLimits(VAR aswp:SWP);
VAR rc:RECTL;
BEGIN
     WinQueryWindowRect(HWindow,rc);
     aswp.x:=rc.xleft;
     aswp.cx:=rc.xright-rc.xleft;
     aswp.y:=rc.yBottom;
     aswp.cy:=rc.yTop-rc.yBottom;

     dec(aswp.cy,ToolBarSize);
     inc(aswp.y,StatusBarSize);
     dec(aswp.cy,StatusBarSize);

     dec(aswp.cx,RightToolBarSize);
     inc(aswp.x,LeftToolBarSize);
     dec(aswp.cx,LeftToolBarSize);
END;


PROCEDURE TWindow.HandleToolBarEvent(VAR Msg:TMessage;Control:PToolBarInterior);
VAR
   mdummy:PMenuHelpItems;
   w,w1:LONGWORD;
   Status:PStatusBarInterior;
LABEL l;
BEGIN
     CASE Msg.Message OF
         WM_Button1Down:
         BEGIN
              IF StatusBarSize=0 THEN goto l;
              w:=Control^.id;
              w1:=0;
              mdummy:=MenuHelpItems;
              WHILE mdummy<>NIL DO
              BEGIN
                   IF mdummy^.MenuID=65535 THEN w1:=mdummy^.StatusID;
                   IF mdummy^.MenuID=w THEN
                   BEGIN
                        w1:=mdummy^.StatusID;
                        Status:=StatusBarInterior;
                        WHILE Status<>NIL DO
                        BEGIN
                            IF Status^.ID=w1 THEN
                            BEGIN
                                StatusBarSetText(w1,mdummy^.HelpText,
                                                 mdummy^.Col);
                                exit;
                            END;
                            Status:=Status^.Next;
                        END;
                        goto l;
                   END;
                   mdummy:=mdummy^.Next;
              END;
         END;
         WM_Button1Up:
         BEGIN
              IF StatusBarSize=0 THEN goto l;
              mdummy:=MenuHelpItems;
              WHILE mdummy<>NIL DO
              BEGIN
                   IF mdummy^.MenuID=65535 THEN  {Clear it}
                   BEGIN
                        StatusBarSetText(mdummy^.StatusID,mdummy^.HelpText,
                                         mdummy^.Col);
                        goto l;
                   END;
                   mdummy:=mdummy^.Next;
              END;
         END;
    END; {case}
l:
END;

FUNCTION ToolBarWndProc(Win:HWND;Msg:ULONG;Para1,Para2:ULONG):ULONG;CDECL;
VAR dummy:PToolBarInterior;
    Message:TMessage;
    ObjectWindow:PWindow;
    r:ULONG;
    p:POINTER;
LABEL l1,l2,ex,l3,l4;
BEGIN
     ObjectWindow:=POINTER(Application^.MainWindow);

     dummy:=NIL;
     IF ObjectWindow=NIL THEN goto l3;
     dummy:=ObjectWindow^.ToolBarInterior;
     WHILE dummy<>NIL DO
     BEGIN
          IF dummy^.Win=Win THEN goto l3;
          dummy:=dummy^.next;
     END;
l3:
     CASE Msg OF
         WM_Button1Down,WM_Button1Up:
         BEGIN
              IF dummy<>NIL THEN goto l1
              ELSE goto l2;
         END;
         ELSE
         BEGIN
l2:
              IF dummy=NIL THEN
              BEGIN
                  r:=WinDefWindowProc(Win,msg,para1,para2);
                  goto ex;
              END
              ELSE goto l4;
         END;
     END; {case}
l1:
     Message.Message:=msg;
     Message.Receiver:=Win;
     Message.Handled:=FALSE;
     Message.param1:=para1;
     Message.param2:=para2;
     Message.Result:=0;
     ObjectWindow^.HandleToolBarEvent(Message,dummy);
     IF Message.Handled THEN
     BEGIN
          r:=Message.result;
          goto ex;
     END;
l4:
     r:=dummy^.OldWndProc(Win,Msg,Para1,Para2);
ex:
     ToolBarWndProc:=r;
END;

PROCEDURE TWindow.ToolBarInsertControl(id,x,y,cx,cy,flag,aclass:LONGWORD;
                                       title:STRING);
VAR
    Win:HWND;
    dummy:PToolBarInterior;
    ctitle:CSTRING;
BEGIN
     ctitle:=title;
     Win:=WinCreateWCWindow(HWindow,aclass,ctitle,Flag,x,y,cx,cy,HWindow,
                            HWND_TOP,id,NIL,NIL);
     IF ToolBarInterior=NIL THEN
     BEGIN
          New(ToolBarInterior);
          dummy:=ToolBarInterior;
     END
     ELSE
     BEGIN
          dummy:=ToolBarInterior;
          WHILE dummy^.Next<>NIL do dummy:=dummy^.next;
          new(dummy^.next);
          dummy:=dummy^.next;
     END;
     dummy^.Win:=Win;
     dummy^.id:=id;
     dummy^.x:=x;
     dummy^.y:=y;
     dummy^.cx:=cx;
     dummy^.cy:=cy;
     dummy^.Next:=NIL;
     IF dummy^.Win<>0 THEN
     BEGIN
          {WinSetWindowULong(dummy^.Win,QWL_USER,LONGWORD(ObjectPtr));}
          dummy^.OldWndProc:=WinSubClassWindow(Dummy^.Win,@ToolBarWndProc);
     END;
END;

PROCEDURE TWindow.ToolBarSetButtonState(id:LONGWORD;Enabled:BOOLEAN);
VAR
    dummy:PToolBarInterior;
LABEL l;
BEGIN
     IF ToolBarSize=0 THEN exit;
     dummy:=ToolBarInterior;
     WHILE dummy<>NIL DO
     BEGIN
          IF dummy^.id=id THEN goto l;
          dummy:=dummy^.next;
     END;
     exit;
l:
     IF Enabled THEN WinEnableWindow(dummy^.Win,TRUE)
     ELSE WinEnableWindow(dummy^.Win,FALSE)
END;

PROCEDURE TWindow.ToolBarSetButtonText(id:LONGWORD;name:STRING);
VAR
    dummy:PToolBarInterior;
    title:Cstring;
    aclass:LONGWORD;
    flag:LONGWORD;
LABEL l;
BEGIN
     IF ToolBarSize=0 THEN exit;
     dummy:=ToolBarInterior;
     WHILE dummy<>NIL DO
     BEGIN
          IF dummy^.id=id THEN goto l;
          dummy:=dummy^.next;
     END;
     exit;
l:
     WinDestroyWindow(dummy^.Win);
     title:=Name;
     aClass:=WC_BUTTON;
     IF title[0]='#' THEN Flag:=BS_NOPOINTERFOCUS OR BS_BITMAP
     ELSE Flag:=0;
     Dummy^.Win:=WinCreateWCWindow(HWindow,aclass,title,Flag,dummy^.x,
                 dummy^.y,dummy^.cx,dummy^.cy,HWindow,
                 HWND_TOP,dummy^.id,NIL,NIL);
     IF dummy^.Win<>0 THEN
     BEGIN
          {WinSetWindowULong(dummy^.Win,QWL_USER,LONGWORD(ObjectPtr));}
          dummy^.OldWndProc:=WinSubClassWindow(Dummy^.Win,@ToolBarWndProc);
     END;
END;

FUNCTION TWindow.GetToolBarControl(id:LONGWORD):PToolBarInterior;
VAR dummy:PToolBarInterior;
    result:PToolBarInterior;
LABEL l;
BEGIN
     result:=NIL;
     dummy:=ToolBarInterior;
     WHILE dummy<>NIL DO
     BEGIN
          IF dummy^.id=id THEN
          BEGIN
               result:=dummy;
               goto l;
          END;
          dummy:=dummy^.next;
     END;
l:
     GetToolBarControl:=result;
END;

PROCEDURE TWindow.ToolBarInsertButton(id,res,x,y,cx,cy:LONGWORD);
VAR
    title:string;
    aclass:LONGWORD;
    flag:LONGWORD;
BEGIN
     IF res<>0 THEN title:='#'+tostr(res)
     ELSE title:='';
     aClass:=WC_BUTTON;
     IF res=0 THEN Flag:=0  {No Bitmap}
     ELSE Flag:=BS_NOPOINTERFOCUS OR BS_BITMAP;
     ToolBarInsertControl(id,x,y,cx,cy,Flag,aClass,title);
END;


PROCEDURE TWindow.CreateToolBar(Size:WORD);
BEGIN
     ToolBarSize:=Size;
     ToolBarColor:=CLR_PALEGRAY;
END;

PROCEDURE TWindow.CreateStatusBar(Size:WORD);
BEGIN
     StatusBarSize:=Size;
     StatusBarColor:=CLR_PALEGRAY;
END;

PROCEDURE TWindow.Redraw(VAR ahps:HPS;VAR rc:RECTL);
BEGIN
     Inherited.Redraw(ahps,rc);
     RedrawToolBar(ahps);
     RedrawStatusBar(ahps);
END;

PROCEDURE TWindow.RedrawToolBar(ahps:HPS);
VAR
   aswp:SWP;
   rc:RECTL;
   xpos,ypos:LONGINT;
   dummy:PToolBarInterior;
BEGIN
     IF ToolBarSize=0 THEN exit;
     GetDesktopLimits(aswp);
     rc.xleft:=aswp.x;
     rc.xright:=rc.xleft+aswp.cx;
     rc.yBottom:=aswp.y+aswp.cy;
     rc.yTop:=rc.yBottom+ToolBarSize;
     WinFillRect(ahps,rc,ToolBarColor);
     WinDrawBorder(ahps,rc,1,1,CLR_DARKGRAY,CLR_WHITE,$800);

     dummy:=ToolBarInterior;
     xpos:=rc.xleft;
     ypos:=rc.yBottom;
     WHILE dummy<>NIL DO
     BEGIN
         WinSetWindowPos(dummy^.Win,HWND_TOP,xpos+dummy^.X,ypos+Dummy^.y,
                       dummy^.cx,dummy^.cy,SWP_SIZE OR SWP_MOVE OR SWP_SHOW);
         dummy:=dummy^.next;
     END;
END;

FUNCTION TWindow.StatusBarInsertItem(id:WORD;x,y,cx,cy:LONGWORD;
                          Exclusive:BOOLEAN):PStatusBarInterior;
VAR
   dummy:PStatusBarInterior;
BEGIN
     IF StatusBarInterior=NIL THEN
     BEGIN
          New(StatusBarInterior);
          dummy:=StatusBarInterior;
     END
     ELSE
     BEGIN
          dummy:=StatusBarInterior;
          WHILE dummy^.Next<>NIL do dummy:=dummy^.next;
          new(dummy^.next);
          dummy:=dummy^.next;
     END;
     dummy^.id:=id;
     dummy^.x:=x;
     dummy^.y:=y;
     dummy^.cx:=cx;
     dummy^.cy:=cy;
     dummy^.item:='';
     dummy^.Next:=NIL;
     dummy^.Col:=CLR_BLACK;
     dummy^.Exclusive:=Exclusive;
     StatusBarInsertItem:=dummy;
END;

PROCEDURE TWindow.StatusBarSetText(id:WORD;item:STRING;Col:LONGINT);
VAR
   dummy:PStatusBarInterior;
   FaceName:String;
   ahps:HPS;
   rc:rectl;
   pt:POINTL;
   aswp:SWP;
LABEL l;
BEGIN
     dummy:=StatusBarInterior;
     WHILE dummy<>NIL DO
     BEGIN
          IF dummy^.id=id THEN
          BEGIN
               dummy^.Col:=Col;
               IF dummy^.item=item THEN exit;
               dummy^.item:=item;

               ahps:=WinGetPS(HWindow);

               IF RedrawExclusive THEN IF dummy^.Exclusive=FALSE THEN
               BEGIN
                    RedrawExclusive:=FALSE;
                    RedrawStatusBar(ahps);
                    goto l;
               END;

               IF dummy^.Exclusive THEN IF RedrawExclusive=FALSE THEN
               BEGIN
                    RedrawExclusive:=TRUE;
                    RedrawStatusBar(ahps);
                    goto l;
               END;

               IF dummy^.Exclusive THEN IF RedrawExclusive THEN
               IF dummy^.item='' THEN
               BEGIN
                    RedrawExclusive:=FALSE;
                    RedrawStatusBar(ahps);
                    goto l;
               END;

               CreateLogFont(ahps,StatusBarFontName,StatusBarFontHeight,
                             StatusBarFontWidth,StatusBarFontFlags);
               GpiSetBackMix(ahps,2);
               rc.xleft:=dummy^.x+2;
               rc.yBottom:=dummy^.y+2;
               rc.xright:=dummy^.x+dummy^.cx;
               IF dummy^.cx=0 THEN
               BEGIN
                    GetDesktopLimits(aswp);
                    IF dummy^.exclusive THEN rc.xleft:=7;
                    rc.xright:=aswp.cx-5;
               END;

               IF dummy^.Exclusive THEN RedrawExclusive:=TRUE
               ELSE RedrawExclusive:=FALSE;

               dec(rc.xright,2);
               rc.yTop:=dummy^.y+dummy^.cy;
               dec(rc.ytop,2);
               WinFillRect(ahps,rc,StatusBarColor);
               pt.x:=dummy^.x+2;
               pt.y:=dummy^.y + StatusBarTextBaseLine;
               IF dummy^.item<>'' THEN DrawStringXY(ahps,pt,dummy^.item,
                              1,length(dummy^.item),dummy^.Col,
                               StatusBarColor);
l:
               WinReleasePS(ahps);
               exit;
          END;
          dummy:=dummy^.next;
     END;
END;


PROCEDURE TWindow.InsertMenuHelp(StatusID,MenuID:WORD;
                                 HelpText:String;Col:LONGWORD);
VAR
   dummy:PMenuHelpItems;
BEGIN
     IF MenuHelpItems=NIL THEN
     BEGIN
          New(MenuHelpItems);
          dummy:=MenuHelpItems;
     END
     ELSE
     BEGIN
          dummy:=MenuHelpItems;
          WHILE dummy^.Next<>NIL DO dummy:=dummy^.next;
          New(dummy^.Next);
          dummy:=dummy^.Next;
     END;
     dummy^.StatusID:=StatusID;
     dummy^.MenuID:=MenuID;
     dummy^.Col:=Col;
     dummy^.HelpText:=Helptext;
     dummy^.Next:=NIL;
END;

PROCEDURE TWindow.SetMenuState(id:WORD;State:BOOLEAN);
VAR
   HwndMenu:HWND;
   w,w1:WORD;
   p,p1:LONGWORD;
BEGIN
     HwndMenu:=WinWindowFromID(HWindowFrame,FID_MENU);
     IF HwndMenu=0 THEN exit;
     p:=MPFROM2SHORT(id,1);
     w:=MIA_DISABLED;
     IF State=FALSE THEN w1:=MIA_DISABLED
     ELSE w1:=0;  {Enabled}
     p1:=MPFROM2SHORT(w,w1);
     WinSendMsg(HwndMenu,MM_SETITEMATTR,p,p1);
     ToolBarSetButtonState(id,State);
END;


PROCEDURE TWindow.SetupMenu;
BEGIN
     Attr.Menu:=WinWindowFromID(HWindowFrame,FID_MENU);
END;

PROCEDURE TWindow.RedrawStatusBar(ahps:HPS);
VAR
   aswp:SWP;
   rc,rc1:RECTL;
   pt:POINTL;
   dummy:PStatusBarInterior;
BEGIN
     IF StatusBarSize=0 THEN exit;
     GetDesktopLimits(aswp);
     rc.xleft:=aswp.x;
     rc.xright:=rc.xleft+aswp.cx;
     rc.yTop:=aswp.y;
     rc.yBottom:=rc.yTop-StatusBarSize;
     WinFillRect(ahps,rc,StatusBarColor);
     WinDrawBorder(ahps,rc,1,1,CLR_DARKGRAY,CLR_WHITE,$800);

     CreateLogFont(ahps,StatusBarFontName,StatusBarFontHeight,
                   StatusBarFontWidth,StatusBarFontFlags); {default font}
     GpiSetBackMix(ahps,2);  {BM_OverPaint}

     IF RedrawExclusive THEN
     BEGIN
          dummy:=StatusBarInterior;
          WHILE dummy<>NIL DO
          BEGIN
              IF dummy^.Exclusive THEN
              BEGIN
                  rc1.xleft:=5;
                  rc1.yBottom:=dummy^.y;
                  rc1.xright:=rc.xright-5;
                  rc1.yTop:=dummy^.y+dummy^.cy;
                     WinDrawBorder(ahps,rc1,1,1,CLR_DARKGRAY,CLR_WHITE,$800);

                  pt.x:=7;
                  pt.y:=dummy^.y + StatusBarTextBaseLine;
                  IF dummy^.item<>'' THEN DrawStringXY(ahps,pt,dummy^.item,
                                           1,length(dummy^.item),dummy^.Col,
                                           StatusBarColor);
                  exit;
              END;
              dummy:=dummy^.next;
          END;
     END;

     dummy:=StatusBarInterior;
     WHILE dummy<>NIL DO
     BEGIN
          IF dummy^.Exclusive=FALSE THEN
          BEGIN
              rc1.xleft:=dummy^.x;
              rc1.yBottom:=dummy^.y;
              rc1.xright:=dummy^.x+dummy^.cx;
              rc1.yTop:=dummy^.y+dummy^.cy;
              IF dummy^.cx=0 THEN rc1.xright:=rc.xright-5;
              WinDrawBorder(ahps,rc1,1,1,CLR_DARKGRAY,CLR_WHITE,$800);

              pt.x:=dummy^.x+2;
              pt.y:=dummy^.y + StatusBarTextBaseLine;
              IF dummy^.item<>'' THEN DrawStringXY(ahps,pt,dummy^.item,
                                  1,length(dummy^.item),dummy^.Col,
                                        StatusBarColor);
          END;
          dummy:=dummy^.next;
     END;
END;



{Call Constructor for the Desktop Window. Overwrite this method
 if you want to use a new object for the Desktop Window.
 This Object must be a child of TWindow}
FUNCTION TWindow.InitializeDesktop(ParentWin:PWindowsObject):PWindow;
BEGIN
     InitializeDesktop:=NIL;  {Standard}
END;

PROCEDURE TWindow.SetupDesktop;
VAR
   WndClass:TWndClass;
   fr:LONGWORD;
   name:CSTRING;
   cClassName:CSTRING;
   aswp:SWP;
   AParentWin:PWindowsObject;
LABEL l;
BEGIN
     IF ToolBarSize=0 THEN IF StatusBarSize=0 THEN
      IF LeftToolBarSize=0 THEN IF RightToolBarSize=0 THEN {No desktop ???}
      BEGIN
           DesktopWin:=InitializeDesktop(ObjectPtr);  {Call Constructor}
           IF DesktopWin=NIL THEN {No desktop at all !}
           BEGIN
                {GetMem(AParentWin,4);
                POINTER(AParentWin^):=POINTER(SELF);???}
                {}POINTER(AParentWin):=POINTER(SELF);{}
                DesktopWin:=AParentWin;
                exit;
           END;

           {Create Desktop window}
           DisableAutoFill; {We fill it via Desktopwin}
           GetWindowClass(WndClass);
           goto l; {proceed}
      END;
     {Create Desktop window}
     DisableAutoFill; {We fill it via Desktopwin}
     GetWindowClass(WndClass);
     DesktopWin:=InitializeDesktop(ObjectPtr);  {Call Constructor}
     IF DesktopWin=NIL THEN DesktopWin:=New(PWindow,Init(ObjectPtr,''));
l:
     SetFlags(WF_WITHDESKTOP,TRUE);  {with desktop}
     IF DesktopWin^.FirstChild=NIL THEN
       NoMoreChildWindows;  {No child windows exist}
     DesktopWin^.WinColor:=WinColor;
     DesktopWin^.WinBackColor:=WinBackColor;
     DesktopWin^.SetFlags(WF_ISDESKTOP,TRUE);
     DesktopWin^.DisableAutoCreate; {We create it ourselves !}
     fr:=0;
     name:='';
     cClassName:=WndClass.ClassName;
     DesktopWin^.HWindowFrame:=WinCreateStdWindow(HWindow,0,fr,
                                               cClassName,name,
                                               0,0,0,DesktopWin^.HWindow);
     WinSetWindowULong(DesktopWin^.HWindow,0,LONGWORD(DesktopWin)); {VMT pointer}
     WinSubClassWindow(DesktopWin^.HWindow,@TheMessageHandler);
     GetDesktopLimits(aswp);
     WinSetWindowPos(DesktopWin^.HWindowFrame,HWND_TOP,aswp.x,aswp.y,
                     aswp.cx,aswp.cy,SWP_SIZE OR SWP_MOVE OR SWP_SHOW);
END;

PROCEDURE TWindow.WMMenuEnd(VAR Msg:TMessage);
VAR
   dummy:PMenuHelpItems;
   Status:PStatusBarInterior;
BEGIN
     IF StatusBarSize=0 THEN exit;
     dummy:=MenuHelpItems;
     WHILE dummy<>NIL DO
     BEGIN
          IF dummy^.MenuID=65535 THEN  {Clear it}
          BEGIN
               StatusBarSetText(dummy^.StatusID,dummy^.HelpText,
                                dummy^.Col);
               exit;
          END;
          dummy:=dummy^.Next;
     END;
END;

PROCEDURE TWindow.WMMenuSelect(VAR Msg:TMessage);
VAR
   w,w1:WORD;
   dummy:PMenuHelpItems;
   Status:PStatusBarInterior;
BEGIN
     IF StatusBarSize=0 THEN exit;
     w:=msg.Param1Lo;
     w1:=0;
     dummy:=MenuHelpItems;
     WHILE dummy<>NIL DO
     BEGIN
          IF dummy^.MenuID=65535 THEN w1:=dummy^.StatusID;
          IF dummy^.MenuID=w THEN
          BEGIN
               w1:=dummy^.StatusID;
               Status:=StatusBarInterior;
               WHILE Status<>NIL DO
               BEGIN
                    IF Status^.ID=w1 THEN
                    BEGIN
                         StatusBarSetText(w1,dummy^.HelpText,dummy^.Col);
                         exit;
                    END;
                    Status:=Status^.Next;
               END;
               exit;
          END;
          dummy:=dummy^.Next;
     END;
     IF w1<>0 THEN
     BEGIN
          StatusBarSetText(w1,'',-1);
     END;
END;

PROCEDURE TWindow.HelpInitError(err:LONGWORD);
BEGIN
     ErrorBox(MB_ICONHAND,'Error',
              'Application failed to initialize help (Error:'+
                Tostr(err)+')');
END;


PROCEDURE TWindow.WMDestroy(var Msg: TMessage);
BEGIN
     Inherited.WMDestroy(msg);
     IF HelpWindow<>0 THEN
       WinAssociateHelpInstance( NULLHANDLE, HWindowFrame );
END;

FUNCTION TWindow.Create:BOOLEAN;
VAR
   ParentWin:HWND;
   WndClass:TWndClass;
   p:POINTER;
   aHelpInit:HelpInit;
   cTitle:CSTRING;
   cClassName:CSTRING;
   cFNS:CSTRING;
BEGIN
     IF HWindow<>0 THEN
     BEGIN
          Create:=TRUE;
          exit;  {Window always created}
     END;
     IF Parent<>NIL THEN ParentWin:=Parent^.HWindow
     ELSE ParentWin:=HWND_DESKTOP;

     IF Attr.HasMenu THEN
         Attr.FrameFlags:=Attr.FrameFlags OR FCF_MENU;
     IF Attr.HasIcon THEN
         Attr.FrameFlags:=Attr.FrameFlags OR FCF_ICON;
     IF Attr.HasAccelTable THEN
         Attr.FrameFlags:=Attr.FrameFlags OR FCF_ACCELTABLE;

     IF Attr.W>0 THEN IF Attr.H>0 THEN
       Attr.FrameFlags:=Attr.FrameFlags AND not FCF_SHELLPOSITION;

     GetWindowClass(WndClass);
     IF WndClass.ClassNameULong<>0 THEN {WC_Name Window}
     BEGIN
          cTitle:=Attr.Title;
          HWindow:=WinCreateWCWindow(ParentWin,WndClass.ClassNameULong,
                                     cTitle,Attr.Style,Attr.X,
                                     Attr.Y,Attr.W,Attr.H,ParentWin,HWND_TOP,
                                     Attr.WindowID,NIL,NIL);
          IF HWindow<>0 THEN HWindowFrame:=WinQueryWindow(HWindow,QW_PARENT);
     END
     ELSE {normal window}
     BEGIN
          cTitle:=Attr.Title;
          cClassName:=WndClass.ClassName;
          HWindowFrame:=WinCreateStdWindow(ParentWin,Attr.Style,
                                           Attr.FrameFlags,cClassName,
                                           cTitle,0,
                                           Attr.ResourceModule,
                                           Attr.ResourceId,
                                           HWindow);
     END;
     IF HWindow=0 THEN
     BEGIN
          Create:=FALSE;
          exit;
     END;
     WinSetPresParam(HWindow,PP_FOREGROUNDCOLORINDEX,4,WinColor);
     WinSetPresParam(HWindow,PP_BACKGROUNDCOLORINDEX,4,WinBackColor);
     cFNS:=Attr.FontNameSize;
     IF cFNS<>'' THEN
     BEGIN
          WinSetPresParam(HWindow,PP_FONTNAMESIZE,Length(cFNS)+1,cFNS);
          WinSetPresParam(HWindowFrame,PP_FONTNAMESIZE,Length(cFNS)+1,cFNS);
     END;
     WinSetWindowULong(HWindow,0,LONGWORD(SELF)); {VMT pointer}
     WinSubClassWindow(HWindow,@TheMessageHandler);
     OldFrameProc:=WinSubClassWindow(HWindowFrame,@TheFrameHandler);
     IF Attr.HasHelp THEN
     BEGIN
          aHelpInit.pszHelpWindowTitle:=@Attr.HelpWindowTitle;
          aHelpInit.pszHelpLibraryName:=@Attr.HelpFileName;
          aHelpInit.cb:=sizeof(HelpInit);
          aHelpInit.ulReturnCode:=0;
          aHelpInit.pszTutorialname:=NIL;
          aHelpInit.phtHelptable:=POINTER($FFFF0000 OR Attr.ResourceID);
          aHelpInit.hmodHelptableModule:=Attr.ResourceModule;
          aHelpInit.hmodAccelActionBarModule:=0;
          aHelpInit.idAcceltable:=0;
          aHelpInit.idActionBar:=0;
          aHelpInit.fShowPanelID:=0;
          HelpWindow:=WinCreateHelpInstance(HInstance,aHelpInit);
          HwndHelpInstance:=HelpWindow;
          fHelpEnabled:=TRUE;
          HELP_TABLE:=Attr.ResourceID;

          IF HelpWindow<>0 THEN
             WinAssociateHelpInstance(HelpWindow,HWindowFrame)
          ELSE HelpInitError(aHelpInit.ulReturnCode);
     END;

     SetupWindow;
     SetupDesktop;
     Create:=TRUE;
END;

PROCEDURE TWindow.CMTile(VAR Msg:TMessage);
VAR
    Buf:PSWPBUF;
    Square,Rows,Columns,ExtraCols,Width,Height:LONGWORD;
    rec:RECTL;
    Child:HWND;
    CurRow,CurCol:LONGWORD;
    ChildCnt,ChildCount:LONGWORD;
    t:LONGWORD;
    Win:HWND;
    TotalCount:BYTE;
    ChildList:PWindowsObject;
LABEL l;
BEGIN
     {Move active window to the end of the child list}
     IF DesktopWin=NIL THEN
     BEGIN
          ChildList:=GetActiveChild;
          RemoveChild(ChildList);
          AddChild(ChildList);
     END
     ELSE
     BEGIN
          ChildList:=DesktopWin^.GetActiveChild;
          DesktopWin^.RemoveChild(ChildList);
          DesktopWin^.AddChild(ChildList);
     END;

     IF DesktopWin=NIL THEN ChildList:=FirstChild
     ELSE ChildList:=DesktopWin^.FirstChild;
     ChildCnt:=0;
     ChildCount:=0;
     WHILE ChildList<>NIL DO
     BEGIN
          IF not IsWindowMinimized(ChildList^.HWindowFrame) THEN inc(ChildCnt);
          inc(ChildCount);
          ChildList:=ChildList^.next;
     END;
     TotalCount:=0;
     IF DesktopWin=NIL THEN Win:=HWindow
     ELSE Win:=DesktopWin^.HWindow;
     Square:=2;
     IF ChildCnt=0 THEN exit;
     WHILE Square*2<=ChildCnt DO inc(Square);
     IF ChildCnt=3 THEN Square:=3;

     Columns:=Square-1;
     Rows:=ChildCnt DIV Columns;
     ExtraCols:=ChildCnt MOD Columns;

     WinQueryWindowRect(Win,rec);
     IF rec.xRight>0 THEN IF rec.yBottom<rec.yTop THEN
     BEGIN
          IF DesktopWin=NIL THEN ChildList:=FirstChild
          ELSE ChildList:=DesktopWin^.FirstChild;
          IF ChildList=NIL THEN Child:=0
          ELSE Child:=ChildList^.HWindowFrame;
          IF Child<>0 THEN
          BEGIN
               GetMem(Buf,sizeof(TSWPBUF)*ChildCount);
               ChildCnt:=0;
               Height:=(rec.yTop-rec.yBottom) div Rows;

               FOR CurRow:=0 TO Rows-1 DO
               BEGIN
                    IF Rows-CurRow<=ExtraCols THEN inc(Columns);
                    FOR CurCol:=0 TO Columns-1 DO
                    BEGIN
                         Width:=rec.xRight div Columns;

                         {Skip minimized Windows}
l:
                         IF IsWindowMinimized(Child) THEN
                         BEGIN
                              ChildList:=ChildList^.Next;
                              IF ChildList=NIL THEN Child:=0
                              ELSE Child:=ChildList^.HWindowFrame;
                              If Child<>0 THEN goto l;
                         END;

                         IF Child<>0 THEN
                         BEGIN
                              inc(TotalCount);
                              IF IsWindowMaximized(Child) THEN
                                Buf^[ChildCnt].fl:= SWP_SIZE OR SWP_MOVE
                                                 OR SWP_ACTIVATE OR SWP_SHOW
                                                 OR SWP_RESTORE
                              ELSE Buf^[ChildCnt].fl:=SWP_SIZE OR SWP_MOVE
                                                   OR SWP_ACTIVATE OR SWP_SHOW;
                              buf^[ChildCnt].x:=Width*CurCol;
                              buf^[ChildCnt].y:=rec.yTop-(Height*(CurRow+1));
                              buf^[ChildCnt].cx:=Width;
                              buf^[ChildCnt].cy:=Height;
                              buf^[ChildCnt].hwnd:=Child;
                              inc(ChildCnt);

                              ChildList:=ChildList^.Next;
                              IF ChildList=NIL THEN Child:=0
                              ELSE Child:=ChildList^.HWindowFrame;
                         END; {IF Childy<>0}
                    END;
                    IF Rows-CurRow<=ExtraCols THEN
                    BEGIN
                         dec(Columns);
                         dec(ExtraCols);
                    END;
               END;

               IF TotalCount>0 THEN WinSetMultWindowPos(HInstance,Buf^[0],
                                                        TotalCount);
               FreeMem(Buf,sizeof(TSWPBUF)*ChildCount);
          END;  {IF Child<>0}
     END;
END;

PROCEDURE TWindow.CMCascade(VAR Msg:TMessage);
VAR
    xloc,yloc,xlen,ylen:LONGINT;
    XDiv,YDiv:LONGWORD;
    ChildList:PWindowsObject;
    rc:RECTL;
BEGIN
     {Move active window to the end of the child list}
     IF DesktopWin=NIL THEN
     BEGIN
          ChildList:=GetActiveChild;
          RemoveChild(ChildList);
          AddChild(ChildList);
     END
     ELSE
     BEGIN
          ChildList:=DesktopWin^.GetActiveChild;
          DesktopWin^.RemoveChild(ChildList);
          DesktopWin^.AddChild(ChildList);
     END;

     XDiv:=WinQuerySysValue(HWND_DESKTOP,SV_CXSIZEBORDER);
     inc(XDiv,WinQuerySysValue(HWND_DESKTOP,SV_CXMINMAXBUTTON) DIV 2);

     YDiv:=WinQuerySysValue(HWND_DESKTOP,SV_CYSIZEBORDER);
     inc(YDiv,WinQuerySysValue(HWND_DESKTOP,SV_CYMINMAXBUTTON));

     IF DesktopWin=NIL THEN
     BEGIN
          WinQueryWindowRect(HWindow,rc);
          ChildList:=FirstChild;
     END
     ELSE
     BEGIN
          WinQueryWindowRect(DesktopWin^.HWindow,rc);
          ChildList:=DesktopWin^.FirstChild;
     END;
     xloc:=rc.xleft;
     xlen:=rc.xright-rc.xleft;
     yloc:=rc.yBottom;
     ylen:=rc.yTop-rc.yBottom;
     WHILE ChildList<>NIL DO
     BEGIN
          IF not IsWindowMinimized(ChildList^.HWindowFrame) THEN
          BEGIN
               WinSetWindowPos(ChildList^.HWindowFrame,HWND_TOP,
                               xloc,yloc,xlen,ylen,SWP_SIZE OR SWP_MOVE
                               OR SWP_ACTIVATE OR SWP_SHOW);
               inc(xloc,XDiv);
               dec(xlen,XDiv);
               dec(ylen,YDiv);
          END;
          ChildList:=ChildList^.Next;
     END;
END;

PROCEDURE TWindow.CMClose(VAR Msg:TMessage);
VAR
   Child:PWindowsObject;
BEGIN
     IF DesktopWin=NIL THEN Child:=GetActiveChild
     ELSE Child:=DesktopWin^.GetActiveChild;
     IF Child<>NIL THEN
     BEGIN
         IF DesktopWin=NIL THEN SetActiveChild(NIL)
         ELSE DesktopWin^.SetActiveChild(NIL);
         WinSendMsg(Child^.HWindow,WM_CLOSE,0,0);
     END;
END;

PROCEDURE CloseAWin(p:PWindowsObject);
BEGIN
     WinSendMsg(p^.HWindowFrame,WM_CLOSE,0,0);
END;

PROCEDURE TWindow.CMCloseAll(VAR Msg:TMessage);
BEGIN
     IF DesktopWin=NIL THEN ForEach(@CloseAWin)  {Close all child windows}
     ELSE DesktopWin^.ForEach(@CloseAWin);
END;


PROCEDURE TWindow.CMNext(VAR Msg:TMessage);
VAR
   Childs:PWindowsObject;
BEGIN
     IF DesktopWin=NIL THEN Childs:=GetActiveChild
     ELSE Childs:=DesktopWin^.GetActiveChild;
     IF Childs=NIL THEN exit;
     Childs:=Childs^.Next;
     IF Childs=NIL THEN
     BEGIN
          IF DesktopWin=NIL THEN Childs:=FirstChild
          ELSE Childs:=DesktopWin^.FirstChild;
     END;
     IF Childs=NIL THEN Exit;
     Childs^.WindowToTop;
END;

PROCEDURE TWindow.CMPrevious(VAR Msg:TMessage);
VAR
   Childs:PWindowsObject;
BEGIN
     IF DesktopWin=NIL THEN Childs:=GetActiveChild
     ELSE Childs:=DesktopWin^.GetActiveChild;
     IF Childs=NIL THEN exit;
     Childs:=Childs^.Previous;
     IF Childs=NIL THEN
     BEGIN
          IF DesktopWin=NIL THEN Childs:=LastChild
          ELSE Childs:=DesktopWin^.LastChild;
     END;
     IF Childs=NIL THEN Exit;
     Childs^.WindowToTop;
END;


PROCEDURE TWindow.CMQuit(VAR Msg:TMessage);
BEGIN
     WinSendMsg(Msg.Receiver,WM_CLOSE,0,0);
END;

PROCEDURE TWindow.CMHelpOnHelp(VAR Msg:TMessage);
VAR
   HelpWin:HWND;
BEGIN
     IF Application=NIL THEN Exit;
     HelpWin:=Application^.MainWindow^.HelpWindow;
     IF HelpWin<>0 THEN
                WinSendMsg(HelpWin,HM_DISPLAY_HELP,0,0);
END;

PROCEDURE TWindow.CMExtendedHelp(VAR Msg:TMessage);
VAR
   HelpWin:HWND;
BEGIN
     IF Application=NIL THEN Exit;
     IF Application^.MainWindow=NIL THEN Exit;
     HelpWin:=Application^.MainWindow^.HelpWindow;
     IF HelpWin<>0 THEN
               WinSendMsg(HelpWin,HM_EXT_HELP,0,0);
END;

PROCEDURE TWindow.CMKeysHelp(VAR Msg:TMessage);
VAR
   HelpWin:HWND;
BEGIN
     IF Application=NIL THEN Exit;
     IF Application^.MainWindow=NIL THEN Exit;
     HelpWin:=Application^.MainWindow^.HelpWindow;
     IF HelpWin<>0 THEN
               WinSendMsg(HelpWin,HM_KEYS_HELP,0,0);
END;

PROCEDURE TWindow.CMHelpIndex(VAR Msg:TMessage);
VAR
   HelpWin:HWND;
BEGIN
     IF Application=NIL THEN Exit;
     IF Application^.MainWindow=NIL THEN Exit;
     HelpWin:=Application^.MainWindow^.HelpWindow;
     IF HelpWin<>0 THEN
               WinSendMsg(HelpWin,HM_HELP_INDEX,0,0);
END;

PROCEDURE TWindow.CMHelpContents(VAR Msg:TMessage);
VAR
   HelpWin:HWND;
BEGIN
     IF Application=NIL THEN Exit;
     IF Application^.MainWindow=NIL THEN Exit;
     HelpWin:=Application^.MainWindow^.HelpWindow;
     IF HelpWin<>0 THEN
         WinSendMsg(HelpWin,HM_HELP_CONTENTS,0,0);
END;

PROCEDURE TWindow.InvalidateWindow;
BEGIN
     WinInvalidateRect(HWindow,NIL,TRUE);
END;

PROCEDURE TWindow.FirstChildWindow;
BEGIN
     Inherited.FirstChildWindow;
     SetMenuState(CM_FIRST+CM_TILE,TRUE);
     SetMenuState(CM_FIRST+CM_LIST,TRUE);
     SetMenuState(CM_FIRST+CM_CASCADE,TRUE);
     SetMenuState(CM_FIRST+CM_NEXT,TRUE);
     SetMenuState(CM_FIRST+CM_PREVIOUS,TRUE);
     SetMenuState(CM_FIRST+CM_CLOSE,TRUE);
     SetMenuState(CM_FIRST+CM_CLOSEALL,TRUE);
END;

PROCEDURE TWindow.NoMoreChildWindows;
BEGIN
     Inherited.NoMoreChildWindows;
     SetMenuState(CM_FIRST+CM_TILE,FALSE);
     SetMenuState(CM_FIRST+CM_LIST,FALSE);
     SetMenuState(CM_FIRST+CM_CASCADE,FALSE);
     SetMenuState(CM_FIRST+CM_NEXT,FALSE);
     SetMenuState(CM_FIRST+CM_PREVIOUS,FALSE);
     SetMenuState(CM_FIRST+CM_CLOSE,FALSE);
     SetMenuState(CM_FIRST+CM_CLOSEALL,FALSE);
END;


{*************************************************************************
 *                                                                       *
 *  Object TApplication                                                  *
 *                                                                       *
 *************************************************************************}


CONSTRUCTOR TApplication.Init(AName:STRING);
BEGIN
     {GetMem(Application,4);
     POINTER(Application^):=POINTER(SELF);??}
     {}POINTER(Application):=POINTER(SELF);{}
     ApplicationName:=AName;
     MainWindow:=NIL;  {No Main-window specified}
END;

DESTRUCTOR TApplication.Done;
BEGIN
     {FreeMem(Application,4);}
     Application:=NIL;
END;

PROCEDURE TApplication.InitMainWindow;
BEGIN
END;

PROCEDURE TApplication.MessageLoop;
VAR
   Queue:QMSG;
BEGIN
     WHILE WinGetMsg(HInstance,Queue,0,0,0) DO
         WinDispatchMsg(HInstance,Queue);
END;


PROCEDURE TApplication.SetupRun;
BEGIN
END;

PROCEDURE TApplication.RunFailed(Code:BYTE);
BEGIN
END;

PROCEDURE TApplication.Run;
BEGIN
     InitMainWindow;
     IF MainWindow<>NIL THEN
     BEGIN
          MainWindow^.Create;  {ever create MainWindow Whatever is with
                                WF_AUTOCREATE}
          IF MainWindow^.HWindow<>0 THEN
          BEGIN
               IF MainWindow^.FirstChild=NIL THEN
                 MainWindow^.NoMoreChildWindows;  {No child windows exist}
               MainWindow^.SetupMenu;
               MainWindow^.SetFlags(WF_ISMAINWINDOW,TRUE);
               SetupRun;
               IF MainWindow^.DesktopWin=NIL THEN MessageLoop
               ELSE
               BEGIN
                    IF MainWindow^.DesktopWin^.HWindow<>0 THEN MessageLoop
                    ELSE RunFailed(RF_NODESKTOPWINDOW);
               END;
          END
          ELSE RunFailed(RF_NOMAINWINDOW);
     END
     ELSE RunFailed(RF_NOMAINWINDOW);
END;

{$D+}

BEGIN
     StartHandlerAddr:=@TheStartHandler;
     MessageHandlerAddr:=@TheMessageHandler;
     AppHandle:=WinInitialize(0);
     AppQueueHandle:=WinCreateMsgQueue(AppHandle,0);
     HInstance:=AppHandle;
END.

