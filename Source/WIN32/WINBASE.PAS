UNIT WinBase;

{****************************************************************************
 *                                                                          *
 * Win32 KERNEL32 Imports definition file                                   *
 *                                                                          *
 ****************************************************************************}


INTERFACE

USES WinNT,WinDef;



CONST
     INVALID_HANDLE_VALUE        = -1;
     INVALID_FILE_SIZE           =$FFFFFFFF;

     FILE_BEGIN                  =0;
     FILE_CURRENT                =1;
     FILE_END                    =2;

     TIME_ZONE_ID_INVALID        =$FFFFFFFF;
     WAIT_FAILED                 =$FFFFFFFF;
     WAIT_OBJECT_0               =STATUS_WAIT_0;
     WAIT_ABANDONED              =STATUS_ABANDONED_WAIT_0;
     WAIT_ABANDONED_0            =STATUS_ABANDONED_WAIT_0;
     WAIT_TIMEOUT                =STATUS_TIMEOUT;
     WAIT_IO_COMPLETION          =STATUS_USER_APC;
     STILL_ACTIVE                =STATUS_PENDING;

     {Exception constants}
     EXCEPTION_ACCESS_VIOLATION     =STATUS_ACCESS_VIOLATION;
     EXCEPTION_DATATYPE_MISALIGNMENT=STATUS_DATATYPE_MISALIGNMENT;
     EXCEPTION_BREAKPOINT           =STATUS_BREAKPOINT;
     EXCEPTION_SINGLE_STEP          =STATUS_SINGLE_STEP;
     EXCEPTION_ARRAY_BOUNDS_EXCEEDED=STATUS_ARRAY_BOUNDS_EXCEEDED;
     EXCEPTION_FLT_DENORMAL_OPERAND =STATUS_FLOAT_DENORMAL_OPERAND;
     EXCEPTION_FLT_DIVIDE_BY_ZERO   =STATUS_FLOAT_DIVIDE_BY_ZERO;
     EXCEPTION_FLT_INEXACT_RESULT   =STATUS_FLOAT_INEXACT_RESULT;
     EXCEPTION_FLT_INVALID_OPERATION=STATUS_FLOAT_INVALID_OPERATION;
     EXCEPTION_FLT_OVERFLOW         =STATUS_FLOAT_OVERFLOW;
     EXCEPTION_FLT_STACK_CHECK      =STATUS_FLOAT_STACK_CHECK;
     EXCEPTION_FLT_UNDERFLOW        =STATUS_FLOAT_UNDERFLOW;
     EXCEPTION_INT_DIVIDE_BY_ZERO   =STATUS_INTEGER_DIVIDE_BY_ZERO;
     EXCEPTION_INT_OVERFLOW         =STATUS_INTEGER_OVERFLOW;
     EXCEPTION_PRIV_INSTRUCTION     =STATUS_PRIVILEGED_INSTRUCTION;
     EXCEPTION_IN_PAGE_ERROR        =STATUS_IN_PAGE_ERROR;
     EXCEPTION_ILLEGAL_INSTRUCTION  =STATUS_ILLEGAL_INSTRUCTION;
     EXCEPTION_NONCONTINUABLE_EXCEPTION=STATUS_NONCONTINUABLE_EXCEPTION;
     EXCEPTION_STACK_OVERFLOW       =STATUS_STACK_OVERFLOW;
     EXCEPTION_INVALID_DISPOSITION  =STATUS_INVALID_DISPOSITION;
     EXCEPTION_GUARD_PAGE           =STATUS_GUARD_PAGE_VIOLATION;
     CONTROL_C_EXIT                 =STATUS_CONTROL_C_EXIT;

CONST
     FILE_FLAG_WRITE_THROUGH         =$80000000;
     FILE_FLAG_OVERLAPPED            =$40000000;
     FILE_FLAG_NO_BUFFERING          =$20000000;
     FILE_FLAG_RANDOM_ACCESS         =$10000000;
     FILE_FLAG_SEQUENTIAL_SCAN       =$08000000;
     FILE_FLAG_DELETE_ON_CLOSE       =$04000000;
     FILE_FLAG_BACKUP_SEMANTICS      =$02000000;
     FILE_FLAG_POSIX_SEMANTICS       =$01000000;

CONST
     CREATE_NEW           =1;
     CREATE_ALWAYS        =2;
     OPEN_EXISTING        =3;
     OPEN_ALWAYS          =4;
     TRUNCATE_EXISTING    =5;



{dwOpenMode values for CreateNamedPipe}
CONST
     PIPE_ACCESS_INBOUND         =$00000001;
     PIPE_ACCESS_OUTBOUND        =$00000002;
     PIPE_ACCESS_DUPLEX          =$00000003;

{Named Pipe End flags for GetNamedPipeInfo}
CONST
     PIPE_CLIENT_END             =$00000000;
     PIPE_SERVER_END             =$00000001;

{dwPipeMode values for CreateNamedPipe}
CONST
     PIPE_WAIT                   =$00000000;
     PIPE_NOWAIT                 =$00000001;
     PIPE_READMODE_BYTE          =$00000000;
     PIPE_READMODE_MESSAGE       =$00000002;
     PIPE_TYPE_BYTE              =$00000000;
     PIPE_TYPE_MESSAGE           =$00000004;

{CreateNamedPipe nMaxInstances}
CONST
     PIPE_UNLIMITED_INSTANCES    =255;

{Bits for CreateFile}
CONST
     SECURITY_CONTEXT_TRACKING   =$00040000;
     SECURITY_EFFECTIVE_ONLY     =$00080000;

     SECURITY_SQOS_PRESENT       =$00100000;
     SECURITY_VALID_SQOS_FLAGS   =$001F0000;


{File structures}
TYPE
    POVERLAPPED=^OVERLAPPED;
    OVERLAPPED=RECORD
                     Internal:LONGWORD;
                     InternalHigh:LONGWORD;
                     Offset:LONGWORD;
                     OffsetHigh:LONGWORD;
                     hEvent:HANDLE;
    END;

    PSECURITY_ATTRIBUTES=^SECURITY_ATTRIBUTES;
    SECURITY_ATTRIBUTES=RECORD
                              nLength:LONGWORD;
                              lpSecurityDescriptor:POINTER;
                              bInheritHandle:BOOL;
                        END;

    PPROCESS_INFORMATION=^PROCESS_INFORMATION;
    PROCESS_INFORMATION=RECORD
                              hProcess:HANDLE;
                              hThread:HANDLE;
                              dwProcessId:LONGWORD;
                              dwThreadId:LONGWORD;
    END;

    PFILETIME=^FILETIME;
    FILETIME=RECORD
                   dwLowDateTime:LONGWORD;
                   dwHighDateTime:LONGWORD;
    END;

    PSYSTEMTIME=^SYSTEMTIME;
    SYSTEMTIME=RECORD
                     wYear:WORD;
                     wMonth:WORD;
                     wDayOfWeek:WORD;
                     wDay:WORD;
                     wHour:WORD;
                     wMinute:WORD;
                     wSecond:WORD;
                     wMilliseconds:WORD;
     END;

     {Thread start proc}
     LPTHREAD_START_ROUTINE=FUNCTION(lpThreadParameter:POINTER):ULONG;


CONST
     SP_SERIALCOMM    =$00000001;

     PST_UNSPECIFIED  =$00000000;
     PST_RS232        =$00000001;
     PST_PARALLELPORT =$00000002;
     PST_RS422        =$00000003;
     PST_RS423        =$00000004;
     PST_RS449        =$00000005;
     PST_MODEM        =$00000006;
     PST_FAX          =$00000021;
     PST_SCANNER      =$00000022;
     PST_NETWORK_BRIDGE=$00000100;
     PST_LAT          =$00000101;
     PST_TCPIP_TELNET =$00000102;
     PST_X25          =$00000103;

     PCF_DTRDSR       =$0001;
     PCF_RTSCTS       =$0002;
     PCF_RLSD         =$0004;
     PCF_PARITY_CHECK =$0008;
     PCF_XONXOFF      =$0010;
     PCF_SETXCHAR     =$0020;
     PCF_TOTALTIMEOUTS=$0040;
     PCF_INTTIMEOUTS  =$0080;
     PCF_SPECIALCHARS =$0100;
     PCF_16BITMODE    =$0200;

     SP_PARITY        =$0001;
     SP_BAUD          =$0002;
     SP_DATABITS      =$0004;
     SP_STOPBITS      =$0008;
     SP_HANDSHAKING   =$0010;
     SP_PARITY_CHECK  =$0020;
     SP_RLSD          =$0040;

     BAUD_075         =$00000001;
     BAUD_110         =$00000002;
     BAUD_134_5       =$00000004;
     BAUD_150         =$00000008;
     BAUD_300         =$00000010;
     BAUD_600         =$00000020;
     BAUD_1200        =$00000040;
     BAUD_1800        =$00000080;
     BAUD_2400        =$00000100;
     BAUD_4800        =$00000200;
     BAUD_7200        =$00000400;
     BAUD_9600        =$00000800;
     BAUD_14400       =$00001000;
     BAUD_19200       =$00002000;
     BAUD_38400       =$00004000;
     BAUD_56K         =$00008000;
     BAUD_128K        =$00010000;
     BAUD_115200      =$00020000;
     BAUD_57600       =$00040000;
     BAUD_USER        =$10000000;

     DATABITS_5       =$0001;
     DATABITS_6       =$0002;
     DATABITS_7       =$0004;
     DATABITS_8       =$0008;
     DATABITS_16      =$0010;
     DATABITS_16X     =$0020;

     STOPBITS_10      =$0001;
     STOPBITS_15      =$0002;
     STOPBITS_20      =$0004;
     PARITY_NONE      =$0100;
     PARITY_ODD       =$0200;
     PARITY_EVEN      =$0400;
     PARITY_MARK      =$0800;
     PARITY_SPACE     =$1000;

TYPE
    LPCOMMPROP=^COMMPROP;
    COMMPROP=RECORD
                   wPacketLength:WORD;
                   wPacketVersion:WORD;
                   dwServiceMask:ULONG;
                   dwReserved1:ULONG;
                   dwMaxTxQueue:ULONG;
                   dwMaxRxQueue:ULONG;
                   dwMaxBaud:ULONG;
                   dwProvSubType:ULONG;
                   dwProvCapabilities:ULONG;
                   dwSettableParams:ULONG;
                   dwSettableBaud:ULONG;
                   wSettableData:WORD;
                   wSettableStopParity:WORD;
                   dwCurrentTxQueue:ULONG;
                   dwCurrentRxQueue:ULONG;
                   dwProvSpec1:ULONG;
                   dwProvSpec2:ULONG;
                   wcProvChar:CHAR;
    END;

CONST
     COMMPROP_INITIALIZED =$E73CF52E;

CONST
     DTR_CONTROL_DISABLE    =$00;
     DTR_CONTROL_ENABLE     =$01;
     DTR_CONTROL_HANDSHAKE  =$02;

     RTS_CONTROL_DISABLE    =$00;
     RTS_CONTROL_ENABLE     =$01;
     RTS_CONTROL_HANDSHAKE  =$02;
     RTS_CONTROL_TOGGLE     =$03;

TYPE
    LPCOMMRTIMEOUTS=^COMMTIMEOUTS;
    COMMTIMEOUTS=RECORD
                       ReadIntervalTimeout:ULONG;
                       ReadTotalTimeoutMultiplier:ULONG;
                       ReadTotalTimeoutConstant:ULONG;
                       WriteTotalTimeoutMultiplier:ULONG;
                       WriteTotalTimeoutConstant:ULONG;
    END;


TYPE
    LPSYSTEM_INFO=^SYSTEM_INFO;
    SYSTEM_INFO=RECORD
                      dwOemId:ULONG;
                      dwPageSize:ULONG;
                      lpMinimumApplicationAddress:POINTER;
                      lpMaximumApplicationAddress:POINTER;
                      dwActiveProcessorMask:ULONG;
                      dwNumberOfProcessors:ULONG;
                      dwProcessorType:ULONG;
                      dwAllocationGranularity:ULONG;
                      dwReserved:ULONG;
     END;

CONST
     {Memory Flags}
     GMEM_FIXED          =$0000;
     GMEM_MOVEABLE       =$0002;
     GMEM_NOCOMPACT      =$0010;
     GMEM_NODISCARD      =$0020;
     GMEM_ZEROINIT       =$0040;
     GMEM_MODIFY         =$0080;
     GMEM_DISCARDABLE    =$0100;
     GMEM_NOT_BANKED     =$1000;
     GMEM_SHARE          =$2000;
     GMEM_DDESHARE       =$2000;
     GMEM_NOTIFY         =$4000;
     GMEM_LOWER          =GMEM_NOT_BANKED;
     GMEM_VALID_FLAGS    =$7F72;
     GMEM_INVALID_HANDLE =$8000;
     GHND                =GMEM_MOVEABLE OR GMEM_ZEROINIT;
     GPTR                =GMEM_FIXED OR GMEM_ZEROINIT;

     {GlobalFlags return values}
     GMEM_DISCARDED      =$4000;
     GMEM_LOCKCOUNT      =$00FF;

TYPE
    LPMEMORYTSTATUS=^MEMORYSTATUS;
    MEMORYSTATUS=RECORD
                       dwLength:ULONG;
                       dwMemoryLoad:ULONG;
                       dwTotalPhys:ULONG;
                       dwAvailPhys:ULONG;
                       dwTotalPageFile:ULONG;
                       dwAvailPageFile:ULONG;
                       dwTotalVirtual:ULONG;
                       dwAvailVirtual:ULONG;
    END;

CONST
    {Local Memory Flags}
    LMEM_FIXED          =$0000;
    LMEM_MOVEABLE       =$0002;
    LMEM_NOCOMPACT      =$0010;
    LMEM_NODISCARD      =$0020;
    LMEM_ZEROINIT       =$0040;
    LMEM_MODIFY         =$0080;
    LMEM_DISCARDABLE    =$0F00;
    LMEM_VALID_FLAGS    =$0F72;
    LMEM_INVALID_HANDLE =$8000;
    LHND                =LMEM_MOVEABLE OR LMEM_ZEROINIT;
    LPTR                =LMEM_FIXED OR LMEM_ZEROINIT;
    NONZEROLHND         =LMEM_MOVEABLE;
    NONZEROLPTR         =LMEM_FIXED;

    {LocalFlags return values}
    LMEM_DISCARDED      =$4000;
    LMEM_LOCKCOUNT      =$00FF;


    {Process creation flags}
    DEBUG_PROCESS               =$00000001;
    DEBUG_ONLY_THIS_PROCESS     =$00000002;
    CREATE_SUSPENDED            =$00000004;
    DETACHED_PROCESS            =$00000008;
    CREATE_NEW_CONSOLE          =$00000010;
    NORMAL_PRIORITY_CLASS       =$00000020;
    IDLE_PRIORITY_CLASS         =$00000040;
    HIGH_PRIORITY_CLASS         =$00000080;
    REALTIME_PRIORITY_CLASS     =$00000100;
    CREATE_NEW_PROCESS_GROUP    =$00000200;
    CREATE_UNICODE_ENVIRONMENT  =$00000400;
    CREATE_SEPARATE_WOW_VDM     =$00000800;
    CREATE_DEFAULT_ERROR_MODE   =$04000000;
    CREATE_NO_WINDOW            =$08000000;
    PROFILE_USER                =$10000000;
    PROFILE_KERNEL              =$20000000;
    PROFILE_SERVER              =$40000000;

    {Thread priority constants}
    THREAD_PRIORITY_LOWEST      =THREAD_BASE_PRIORITY_MIN;
    THREAD_PRIORITY_BELOW_NORMAL=THREAD_PRIORITY_LOWEST+1;
    THREAD_PRIORITY_NORMAL      =0;
    THREAD_PRIORITY_HIGHEST     =THREAD_BASE_PRIORITY_MAX;
    THREAD_PRIORITY_ABOVE_NORMAL=THREAD_PRIORITY_HIGHEST-1;
    THREAD_PRIORITY_ERROR_RETURN=MAXLONG;
    THREAD_PRIORITY_TIME_CRITICAL=THREAD_BASE_PRIORITY_LOWRT;
    THREAD_PRIORITY_IDLE        =THREAD_BASE_PRIORITY_IDLE;

CONST
     {Debug API}
     EXCEPTION_DEBUG_EVENT       =1;
     CREATE_THREAD_DEBUG_EVENT   =2;
     CREATE_PROCESS_DEBUG_EVENT  =3;
     EXIT_THREAD_DEBUG_EVENT     =4;
     EXIT_PROCESS_DEBUG_EVENT    =5;
     LOAD_DLL_DEBUG_EVENT        =6;
     UNLOAD_DLL_DEBUG_EVENT      =7;
     OUTPUT_DEBUG_STRING_EVENT   =8;
     RIP_EVENT                   =9;

TYPE
    {$IFDEF OS2}
    CONST
     SIZE_OF_80387_REGISTERS      = 80;

TYPE
    PFLOATING_SAVE_AREA=^FLOATING_SAVE_AREA;
    FLOATING_SAVE_AREA=RECORD
                             ControlWord:LONGWORD;
                             StatusWord:LONGWORD;
                             TagWord:LONGWORD;
                             ErrorOffset:LONGWORD;
                             ErrorSelector:LONGWORD;
                             DataOffset:LONGWORD;
                             DataSelector:LONGWORD;
                             RegisterArea:ARRAY[0..SIZE_OF_80387_REGISTERS-1] OF BYTE;
                             Cr0NpxState:LONGWORD;
    END;

TYPE
    PCONTEXT=^CONTEXT;
    CONTEXT=RECORD
                  ContextFlags:LONGWORD;
                  Dr0:LONGWORD;
                  Dr1:LONGWORD;
                  Dr2:LONGWORD;
                  Dr3:LONGWORD;
                  Dr6:LONGWORD;
                  Dr7:LONGWORD;

                  FloatSave:FLOATING_SAVE_AREA;

                  SegGs:LONGWORD;
                  SegFs:LONGWORD;
                  SegEs:LONGWORD;
                  SegDs:LONGWORD;

                  Edi:LONGWORD;
                  Esi:LONGWORD;
                  Ebx:LONGWORD;
                  Edx:LONGWORD;
                  Ecx:LONGWORD;
                  Eax:LONGWORD;

                  Ebp:LONGWORD;
                  Eip:LONGWORD;
                  SegCs:LONGWORD;
                  EFlags:LONGWORD;
                  Esp:LONGWORD;
                  SegSs:LONGWORD;
    END;

CONST
     EXCEPTION_CONTINUABLE         = 0; // Continuable exception
     EXCEPTION_NONCONTINUABLE      = 1; // Noncontinuable exception
     EXCEPTION_MAXIMUM_PARAMETERS  =15; // maximum number of exception parameters

TYPE
    PEXCEPTION_RECORD=^EXCEPTION_RECORD;
    EXCEPTION_RECORD=RECORD
                           ExceptionCode:LONGWORD;
                           ExceptionFlags:LONGWORD;
                           ExceptionRecord:PEXCEPTION_RECORD;
                           ExceptionAddress:POINTER;
                           NumberParameters:LONGWORD;
                           ExceptionInformation:ARRAY[0..EXCEPTION_MAXIMUM_PARAMETERS-1] OF LONGWORD;
    END;

TYPE
    PEXCEPTION_POINTERS=^EXCEPTION_POINTERS;
    EXCEPTION_POINTERS=RECORD
                             ExceptionRecord:PEXCEPTION_RECORD;
                             ContextRecord:PCONTEXT;
    END;
    {$ENDIF}


    {$IFDEF Win95}
    LPEXCEPTION_DEBUG_INFO=^EXCEPTION_DEBUG_INFO;
    EXCEPTION_DEBUG_INFO=RECORD
                               ExceptionRecord:SYSTEM.EXCEPTION_RECORD;
                               dwFirstChance:ULONG;
    END;
    {$ENDIF}
    {$IFDEF OS2}
    LPEXCEPTION_DEBUG_INFO=^EXCEPTION_DEBUG_INFO;
    EXCEPTION_DEBUG_INFO=RECORD
                               ExceptionRecord:EXCEPTION_RECORD;
                               dwFirstChance:ULONG;
    END;
    {$ENDIF}

    LPCREATE_THREAD_DEBUG_INFO=^CREATE_THREAD_DEBUG_INFO;
    CREATE_THREAD_DEBUG_INFO=RECORD
                                   hThread:HANDLE;
                                   lpThreadLocalBase:POINTER;
                                   lpStartAddress:LPTHREAD_START_ROUTINE;
    END;

    LPCREATE_PROCESS_DEBUG_INFO=^CREATE_PROCESS_DEBUG_INFO;
    CREATE_PROCESS_DEBUG_INFO=RECORD
                                    hFile:HANDLE;
                                    hProcess:HANDLE;
                                    hThread:HANDLE;
                                    lpBaseOfImage:POINTER;
                                    dwDebugInfoFileOffset:ULONG;
                                    nDebugInfoSize:ULONG;
                                    lpThreadLocalBase:POINTER;
                                    lpStartAddress:LPTHREAD_START_ROUTINE;
                                    lpImageName:POINTER;
                                    fUnicode:WORD;
    END;

    LPEXIT_THREAD_DEBUG_INFO=^EXIT_THREAD_DEBUG_INFO;
    EXIT_THREAD_DEBUG_INFO=RECORD
                                 dwExitCode:ULONG;
    END;

    LPEXIT_PROCESS_DEBUG_INFO=^EXIT_PROCESS_DEBUG_INFO;
    EXIT_PROCESS_DEBUG_INFO=RECORD
                                  dwExitCode:ULONG;
    END;

    LPLOAD_DLL_DEBUG_INFO=^LOAD_DLL_DEBUG_INFO;
    LOAD_DLL_DEBUG_INFO=RECORD
                              hFile:HANDLE;
                              lpBaseOfDll:POINTER;
                              dwDebugInfoFileOffset:ULONG;
                              nDebugInfoSize:ULONG;
                              lpImageName:POINTER;
                              fUnicode:WORD;
    END;

    LPUNLOAD_DLL_DEBUG_INFO=^UNLOAD_DLL_DEBUG_INFO;
    UNLOAD_DLL_DEBUG_INFO=RECORD
                                lpBaseOfDll:POINTER;
    END;

    LPOUTPUT_DEBUG_STRING_INFO=^OUTPUT_DEBUG_STRING_INFO;
    OUTPUT_DEBUG_STRING_INFO=RECORD
                                   lpDebugStringData:LPStr;
                                   fUnicode:WORD;
                                   nDebugStringLength:WORD;
    END;

    LPRIP_INFO=^RIP_INFO;
    RIP_INFO=RECORD
                   dwError:ULONG;
                   dwType:ULONG;
    END;

    LPDEBUG_EVENT=^DEBUG_EVENT;
    DEBUG_EVENT=RECORD
                      dwDebugEventCode:ULONG;
                      dwProcessId:ULONG;
                      dwThreadId:ULONG;
                      CASE Integer OF
                        1:(Exception:EXCEPTION_DEBUG_INFO);
                        2:(CreateThread:CREATE_THREAD_DEBUG_INFO);
                        3:(CreateProcessInfo:CREATE_PROCESS_DEBUG_INFO);
                        4:(ExitThread:EXIT_THREAD_DEBUG_INFO);
                        5:(ExitProcess:EXIT_THREAD_DEBUG_INFO);
                        6:(LoadDll:LOAD_DLL_DEBUG_INFO);
                        7:(UnloadDll:UNLOAD_DLL_DEBUG_INFO);
                        8:(DebugString:OUTPUT_DEBUG_STRING_INFO);
                        9:(RipInfo:RIP_INFO);
    END;

CONST
     DRIVE_UNKNOWN     =0;
     DRIVE_NO_ROOT_DIR =1;
     DRIVE_REMOVABLE   =2;
     DRIVE_FIXED       =3;
     DRIVE_REMOTE      =4;
     DRIVE_CDROM       =5;
     DRIVE_RAMDISK     =6;

     FILE_TYPE_UNKNOWN   =$0000;
     FILE_TYPE_DISK      =$0001;
     FILE_TYPE_CHAR      =$0002;
     FILE_TYPE_PIPE      =$0003;
     FILE_TYPE_REMOTE    =$8000;

CONST
     {Standard handles}
     STD_INPUT_HANDLE    =-10;
     STD_OUTPUT_HANDLE   =-11;
     STD_ERROR_HANDLE    =-12;

CONST
     NOPARITY            =0;
     ODDPARITY           =1;
     EVENPARITY          =2;
     MARKPARITY          =3;
     SPACEPARITY         =4;

     ONESTOPBIT          =0;
     ONE5STOPBITS        =1;
     TWOSTOPBITS         =2;

     IGNORE              =0;
     INFINITE            =$FFFFFFFF;

CONST
     {Baud rates}
     CBR_110             =110;
     CBR_300             =300;
     CBR_600             =600;
     CBR_1200            =1200;
     CBR_2400            =2400;
     CBR_4800            =4800;
     CBR_9600            =9600;
     CBR_14400           =14400;
     CBR_19200           =19200;
     CBR_38400           =38400;
     CBR_56000           =56000;
     CBR_57600           =57600;
     CBR_115200          =115200;
     CBR_128000          =128000;
     CBR_256000          =256000;

CONST
    {Error Flags}
    CE_RXOVER            =$0001;  // Receive Queue overflow
    CE_OVERRUN           =$0002;  // Receive Overrun Error
    CE_RXPARITY          =$0004;  // Receive Parity Error
    CE_FRAME             =$0008;  // Receive Framing error
    CE_BREAK             =$0010;  // Break Detected
    CE_TXFULL            =$0100;  // TX Queue is full
    CE_PTO               =$0200;  // LPTx Timeout
    CE_IOE               =$0400;  // LPTx I/O Error
    CE_DNS               =$0800;  // LPTx Device not selected
    CE_OOP               =$1000;  // LPTx Out-Of-Paper
    CE_MODE              =$8000;  // Requested mode unsupported

    IE_BADID             =-1;     // Invalid or unsupported id
    IE_OPEN              =-2;     // Device Already Open
    IE_NOPEN             =-3;     // Device Not Open
    IE_MEMORY            =-4;     // Unable to allocate queues
    IE_DEFAULT           =-5;     // Error in default parameters
    IE_HARDWARE          =-10;    // Hardware Not Present
    IE_BYTESIZE          =-11;    // Illegal Byte Size
    IE_BAUDRATE          =-12;    // Unsupported BaudRate

CONST
    {Events}
    EV_RXCHAR           =$0001;  // Any Character received
    EV_RXFLAG           =$0002;  // Received certain character
    EV_TXEMPTY          =$0004;  // Transmitt Queue Empty
    EV_CTS              =$0008;  // CTS changed state
    EV_DSR              =$0010;  // DSR changed state
    EV_RLSD             =$0020;  // RLSD changed state
    EV_BREAK            =$0040;  // BREAK received
    EV_ERR              =$0080;  // Line status error occurred
    EV_RING             =$0100;  // Ring signal detected
    EV_PERR             =$0200;  // Printer error occured
    EV_RX80FULL         =$0400;  // Receive buffer is 80 percent full
    EV_EVENT1           =$0800;  // Provider specific event 1
    EV_EVENT2           =$1000;  // Provider specific event 2

    {Escape Functions}
    SETXOFF             =1;       // Simulate XOFF received
    SETXON              =2;       // Simulate XON received
    SETRTS              =3;       // Set RTS high
    CLRRTS              =4;       // Set RTS low
    SETDTR              =5;       // Set DTR high
    CLRDTR              =6;       // Set DTR low
    RESETDEV            =7;       // Reset device if possible
    SETBREAK            =8;       // Set the device break line.
    CLRBREAK            =9;       // Clear the device break line.

    PURGE_TXABORT       =$0001;
    PURGE_RXABORT       =$0002;
    PURGE_TXCLEAR       =$0004;
    PURGE_RXCLEAR       =$0008;

    LPTx                =$80;    // Set if ID is for LPT device

    {Modem Status Flags}
    MS_CTS_ON           =$0010;
    MS_DSR_ON           =$0020;
    MS_RING_ON          =$0040;
    MS_RLSD_ON          =$0080;

    S_QUEUEEMPTY        =0;
    S_THRESHOLD         =1;
    S_ALLTHRESHOLD      =2;

    S_NORMAL      =0;
    S_LEGATO      =1;
    S_STACCATO    =2;

    S_PERIOD512   =0;
    S_PERIOD1024  =1;
    S_PERIOD2048  =2;
    S_PERIODVOICE =3;
    S_WHITE512    =4;
    S_WHITE1024   =5;
    S_WHITE2048   =6;
    S_WHITEVOICE  =7;

    S_SERDVNA     =-1;  // Device not available
    S_SEROFM      =-2;  // Out of memory
    S_SERMACT     =-3;  // Music active
    S_SERQFUL     =-4;  // Queue full
    S_SERBDNT     =-5;  // Invalid note
    S_SERDLN      =-6;  // Invalid note length
    S_SERDCC      =-7;  // Invalid note count
    S_SERDTP      =-8;  // Invalid tempo
    S_SERDVL      =-9;  // Invalid volume
    S_SERDMD      =-10; // Invalid mode
    S_SERDSH      =-11; // Invalid shape
    S_SERDPT      =-12; // Invalid pitch
    S_SERDFQ      =-13; // Invalid frequency
    S_SERDDR      =-14; // Invalid duration
    S_SERDSR      =-15; // Invalid source
    S_SERDST      =-16; // Invalid state

    NMPWAIT_WAIT_FOREVER       =$ffffffff;
    NMPWAIT_NOWAIT             =$00000001;
    NMPWAIT_USE_DEFAULT_WAIT   =$00000000;

    FS_CASE_IS_PRESERVED       =FILE_CASE_PRESERVED_NAMES;
    FS_CASE_SENSITIVE          =FILE_CASE_SENSITIVE_SEARCH;
    FS_UNICODE_STORED_ON_DISK  =FILE_UNICODE_ON_DISK;
    FS_PERSISTENT_ACLS         =FILE_PERSISTENT_ACLS;
    FS_VOL_IS_COMPRESSED       =FILE_VOLUME_IS_COMPRESSED;
    FS_FILE_COMPRESSION        =FILE_FILE_COMPRESSION;


CONST
     {Open file flags}
     OF_READ             =$00000000;
     OF_WRITE            =$00000001;
     OF_READWRITE        =$00000002;
     OF_SHARE_COMPAT     =$00000000;
     OF_SHARE_EXCLUSIVE  =$00000010;
     OF_SHARE_DENY_WRITE =$00000020;
     OF_SHARE_DENY_READ  =$00000030;
     OF_SHARE_DENY_NONE  =$00000040;
     OF_PARSE            =$00000100;
     OF_DELETE           =$00000200;
     OF_VERIFY           =$00000400;
     OF_CANCEL           =$00000800;
     OF_CREATE           =$00001000;
     OF_PROMPT           =$00002000;
     OF_EXIST            =$00004000;
     OF_REOPEN           =$00008000;

     OFS_MAXPATHNAME     =128;

TYPE
    {Open file structure}
    POFSTRUCT=^OFSTRUCT;
    OFSTRUCT=RECORD
                   cBytes:BYTE;
                   fFixedDisk:BYTE;
                   nErrCode:WORD;
                   Reserved1:WORD;
                   Reserved2:WORD;
                   szPathName:ARRAY[0..OFS_MAXPATHNAME-1] OF CHAR;
    END;

    PPROCESS_HEAP_ENTRY=^PROCESS_HEAP_ENTRY;
    PROCESS_HEAP_ENTRY=RECORD
                             lpData:POINTER;
                             cbData:ULONG;
                             cbOverhead:BYTE;
                             iRegionIndex:BYTE;
                             wFlags:WORD;
                             CASE Integer OF
                               1:(Block:RECORD
                                              hMem:HANDLE;
                                              dwReserved:ARRAY[0..2] OF ULONG;
                                        END);
                               2:(Region:RECORD
                                              dwCommittedSize:ULONG;
                                              dwUnCommittedSize:ULONG;
                                              lpFirstBlock:POINTER;
                                              lpLastBlock:POINTER;
                                         END);
    END;
    LPPROCESS_HEAP_ENTRY=PPROCESS_HEAP_ENTRY;

CONST
     PROCESS_HEAP_REGION             =$0001;
     PROCESS_HEAP_UNCOMMITTED_RANGE  =$0002;
     PROCESS_HEAP_ENTRY_BUSY         =$0004;
     PROCESS_HEAP_ENTRY_MOVEABLE     =$0010;
     PROCESS_HEAP_ENTRY_DDESHARE     =$0020;

CONST
     SCS_32BIT_BINARY    =0;
     SCS_DOS_BINARY      =1;
     SCS_WOW_BINARY      =2;
     SCS_PIF_BINARY      =3;
     SCS_POSIX_BINARY    =4;
     SCS_OS216_BINARY    =5;

CONST
     SEM_FAILCRITICALERRORS      =$0001;
     SEM_NOGPFAULTERRORBOX       =$0002;
     SEM_NOALIGNMENTFAULTEXCEPT  =$0004;
     SEM_NOOPENFILEERRORBOX      =$8000;

CONST
     LOCKFILE_FAIL_IMMEDIATELY   =$00000001;
     LOCKFILE_EXCLUSIVE_LOCK     =$00000002;

TYPE
    PBY_HANDLE_FILE_INFORMATION=^BY_HANDLE_FILE_INFORMATION;
    BY_HANDLE_FILE_INFORMATION=RECORD
                                     dwFileAttributes:ULONG;
                                     ftCreationTime:FILETIME;
                                     ftLastAccessTime:FILETIME;
                                     ftLastWriteTime:FILETIME;
                                     dwVolumeSerialNumber:ULONG;
                                     nFileSizeHigh:ULONG;
                                     nFileSizeLow:ULONG;
                                     nNumberOfLinks:ULONG;
                                     nFileIndexHigh:ULONG;
                                     nFileIndexLow:ULONG;
    END;
    LPBY_HANDLE_FILE_INFORMATION=PBY_HANDLE_FILE_INFORMATION;

CONST
     HANDLE_FLAG_INHERIT             =$00000001;
     HANDLE_FLAG_PROTECT_FROM_CLOSE  =$00000002;

     HINSTANCE_ERROR                 =32;

CONST
     GET_TAPE_MEDIA_INFORMATION      =0;
     GET_TAPE_DRIVE_INFORMATION      =1;

     SET_TAPE_MEDIA_INFORMATION      =0;
     SET_TAPE_DRIVE_INFORMATION      =1;

TYPE
    PTIME_ZONE_INFORMATION=^TIME_ZONE_INFORMATION;
    TIME_ZONE_INFORMATION=RECORD
                                Bias:LONG;
                                StandardName:ARRAY[0..31] OF WCHAR;
                                StandardDate:SYSTEMTIME;
                                StandardBias:LONG;
                                DaylightName:ARRAY[0..31] OF WCHAR;
                                DaylightDate:SYSTEMTIME;
                                DaylightBias:LONG;
    END;
    LPTIME_ZONE_INFORMATION=PTIME_ZONE_INFORMATION;

CONST
     FORMAT_MESSAGE_ALLOCATE_BUFFER =$00000100;
     FORMAT_MESSAGE_IGNORE_INSERTS  =$00000200;
     FORMAT_MESSAGE_FROM_STRING     =$00000400;
     FORMAT_MESSAGE_FROM_HMODULE    =$00000800;
     FORMAT_MESSAGE_FROM_SYSTEM     =$00001000;
     FORMAT_MESSAGE_ARGUMENT_ARRAY  =$00002000;
     FORMAT_MESSAGE_MAX_WIDTH_MASK  =$000000FF;

CONST
     TLS_OUT_OF_INDEXES             =$FFFFFFFF;

TYPE
    LPWIN32_STREAM_ID=^WIN32_STREAM_ID;
    WIN32_STREAM_ID=RECORD
                          dwStreamId:ULONG ;
                          dwStreamAttributes:ULONG ;
                          Size:LARGE_INTEGER;
                          dwStreamNameSize:ULONG ;
                          cStreamName:ARRAY[0..ANYSIZE_ARRAY-1] OF WCHAR ;
    END;

CONST
     {Stream Ids}
     BACKUP_INVALID          =$00000000;
     BACKUP_DATA             =$00000001;
     BACKUP_EA_DATA          =$00000002;
     BACKUP_SECURITY_DATA    =$00000003;
     BACKUP_ALTERNATE_DATA   =$00000004;
     BACKUP_LINK             =$00000005;
     BACKUP_PROPERTY_DATA    =$00000006;

     {Stream Attributes}
     STREAM_NORMAL_ATTRIBUTE    =$00000000;
     STREAM_MODIFIED_WHEN_READ  =$00000001;
     STREAM_CONTAINS_SECURITY   =$00000002;
     STREAM_CONTAINS_PROPERTIES =$00000004;

     STARTF_USESHOWWINDOW    =$00000001;
     STARTF_USESIZE          =$00000002;
     STARTF_USEPOSITION      =$00000004;
     STARTF_USECOUNTCHARS    =$00000008;
     STARTF_USEFILLATTRIBUTE =$00000010;
     STARTF_RUNFULLSCREEN    =$00000020;
     STARTF_FORCEONFEEDBACK  =$00000040;
     STARTF_FORCEOFFFEEDBACK =$00000080;
     STARTF_USESTDHANDLES    =$00000100;

TYPE
    PSTARTUPINFO=^STARTUPINFO;
    STARTUPINFO=RECORD
                      cb:ULONG;
                      lpReserved:LPSTR;
                      lpDesktop:LPSTR;
                      lpTitle:LPSTR;
                      dwX:ULONG;
                      dwY:ULONG;
                      dwXSize:ULONG;
                      dwYSize:ULONG;
                      dwXCountChars:ULONG;
                      dwYCountChars:ULONG;
                      dwFillAttribute:ULONG;
                      dwFlags:ULONG;
                      wShowWindow:WORD;
                      cbReserved2:WORD;
                      lpReserved2:LPBYTE;
                      hStdInput:HANDLE;
                      hStdOutput:HANDLE;
                      hStdError:HANDLE;
    END;
    LPSTARTUPINFO=PSTARTUPINFO;

CONST
     SHUTDOWN_NORETRY                =$00000001;

TYPE
     PWIN32_FIND_DATA=^WIN32_FIND_DATA;
     WIN32_FIND_DATA=RECORD
                           dwFileAttributes:ULONG;
                           ftCreationTime:FILETIME;
                           ftLastAccessTime:FILETIME;
                           ftLastWriteTime:FILETIME;
                           nFileSizeHigh:ULONG;
                           nFileSizeLow:ULONG;
                           dwReserved0:ULONG;
                           dwReserved1:ULONG;
                           cFileName:ARRAY[0..MAX_PATH-1] OF CHAR;
                           cAlternateFileName:ARRAY[0..14] OF CHAR;
     END;
     LPWIN32_FIND_DATA=PWIN32_FIND_DATA;

CONST
     DONT_RESOLVE_DLL_REFERENCES     =$00000001;
     LOAD_LIBRARY_AS_DATAFILE        =$00000002;
     LOAD_WITH_ALTERED_SEARCH_PATH   =$00000008;

TYPE
    ENUMRESTYPEPROC=FUNCTION(hModule:HINSTANCE;lpType:LPTSTR;lParam:LONG):BOOL;
    ENUMRESNAMEPROC=FUNCTION(hModule:HINSTANCE;lpType:LPCTSTR;lpName:LPTSTR;lParam:LONG):BOOL;
    ENUMRESLANGPROC=FUNCTION(hModule:HINSTANCE;lpType:LPCTSTR;lpName:LPCTSTR;wLanguage:WORD;
                             lParam:LONG):BOOL;

CONST
     DDD_RAW_TARGET_PATH         =$00000001;
     DDD_REMOVE_DEFINITION       =$00000002;
     DDD_EXACT_MATCH_ON_REMOVE   =$00000004;

     MOVEFILE_REPLACE_EXISTING   =$00000001;
     MOVEFILE_COPY_ALLOWED       =$00000002;
     MOVEFILE_DELAY_UNTIL_REBOOT =$00000004;

CONST
     MAX_COMPUTERNAME_LENGTH =15;

TYPE
    POSVERSIONINFO=^OSVERSIONINFO;
    OSVERSIONINFO=RECORD
                        dwOSVersionInfoSize:ULONG;
                        dwMajorVersion:ULONG;
                        dwMinorVersion:ULONG;
                        dwBuildNumber:ULONG;
                        dwPlatformId:ULONG;
                        szCSDVersion:ARRAY[0..127] OF CHAR;
    END;
    LPOSVERSIONINFO=POSVERSIONINFO;

CONST
     VER_PLATFORM_WIN32s         =0;
     VER_PLATFORM_WIN32_NT       =2;

CONST
     {Termination codes}
     TC_NORMAL       =0;
     TC_HARDERR      =1;
     TC_GP_TRAP      =2;
     TC_SIGNAL       =3;

CONST
    EXCEPTION_EXECUTE_HANDLER       = 1;
    EXCEPTION_CONTINUE_SEARCH       = 0;
    EXCEPTION_CONTINUE_EXECUTION    =-1;

TYPE
    PTOP_LEVEL_EXCEPTION_FILTER=FUNCTION(VAR ExceptionInfo:EXCEPTION_POINTERS):LONG;APIENTRY;
    LPTOP_LEVEL_EXCEPTION_FILTER=PTOP_LEVEL_EXCEPTION_FILTER;

    LPOVERLAPPED_COMPLETION_ROUTINE=PROCEDURE(dwErrorCode:ULONG;
                                              dwNumberOfBytesTransfered:ULONG;
                                              VAR lpOverlapped:OVERLAPPED);APIENTRY;

    CRITICAL_SECTION=RECORD
                           ulReserved:ARRAY[0..7] OF LONGWORD;
    END;
    PCRITICAL_SECTION=^CRITICAL_SECTION;

TYPE
  SECURITY_CONTEXT_TRACKING_MODE = Boolean;

  TSecurityImpersonationLevel = (SecurityAnonymous,
                                 SecurityIdentification,
                                 SecurityImpersonation,
                                 SecurityDelegation);

  PSecurityQualityOfService = ^TSecurityQualityOfService;
  TSecurityQualityOfService=RECORD
    Length: DWORD;
    ImpersonationLevel: TSecurityImpersonationLevel;
    ContextTrackingMode: SECURITY_CONTEXT_TRACKING_MODE;
    EffectiveOnly: Boolean;
  End;


IMPORTS
       {$IFDEF Win95}
       FUNCTION InterlockedIncrement(VAR lpAppend:LONG):LONG;
                  APIENTRY;  'KERNEL32' name 'InterlockedIncrement';
       FUNCTION InterlockedDecrement(VAR lpAddend:LONG):LONG;
                  APIENTRY;  'KERNEL32' name 'InterlockedDecrement';
       FUNCTION InterlockedExchange(VAR Target:LONG;Value:LONG):LONG;
                  APIENTRY;  'KERNEL32' name 'InterlockedExchange';
       FUNCTION FreeResource(hResData:HGLOBAL):BOOL;
                  APIENTRY;  'KERNEL32' name 'FreeResource';
       FUNCTION LockResource(hResData:HGLOBAL):POINTER;
                  APIENTRY;  'KERNEL32' name 'LockResource';
       FUNCTION FreeLibrary(hLibModule:HINSTANCE):BOOL;
                  APIENTRY;  'KERNEL32' name 'FreeLibrary';
       PROCEDURE FreeLibraryAndExitThread(hLibModule:HMODULE;dwExitCode:ULONG);
                  APIENTRY;  'KERNEL32' name 'FreeLibraryAndExitThread';
       FUNCTION DisableThreadLibraryCalls(hLibModule:HMODULE):BOOL;
                  APIENTRY;  'KERNEL32' name 'DisableThreadLibraryCalls';
       FUNCTION GetProcAddress(hModule:HINSTANCE;CONST lpProcName:CSTRING):POINTER;
                  APIENTRY;  'KERNEL32' name 'GetProcAddress';
       FUNCTION GetVersion:ULONG;
                  APIENTRY;  'KERNEL32' name 'GetVersion';
       FUNCTION GlobalAlloc(uFlags:ULONG;dwBytes:ULONG):HGLOBAL;
                  APIENTRY;  'KERNEL32' name 'GlobalAlloc';
       FUNCTION GlobalReAlloc(hMem:HGLOBAL;dwBytes:ULONG;uFlags:ULONG):HGLOBAL;
                  APIENTRY;  'KERNEL32' name 'GlobalReAlloc';
       FUNCTION GlobalSize(hMem:HGLOBAL):ULONG;
                  APIENTRY;  'KERNEL32' name 'GlobalSize';
       FUNCTION GlobalFlags(hMem:HGLOBAL):ULONG;
                  APIENTRY;  'KERNEL32' name 'GlobalFlags';
       FUNCTION GlobalLock(hMem:HGLOBAL):POINTER;
                  APIENTRY;  'KERNEL32' name 'GlobalLock';
       FUNCTION GlobalHandle(pMem:POINTER):HGLOBAL;
                  APIENTRY;  'KERNEL32' name 'GlobalHandle';
       FUNCTION GlobalUnlock(hMem:HGLOBAL):BOOL;
                  APIENTRY;  'KERNEL32' name 'GlobalUnlock';
       FUNCTION GlobalFree(hMem:HGLOBAL):HGLOBAL;
                  APIENTRY;  'KERNEL32' name 'GlobalFree';
       FUNCTION GlobalCompact(dwMinFree:ULONG):ULONG;
                  APIENTRY;  'KERNEL32' name 'GlobalCompact';
       PROCEDURE GlobalFix(hMem:HGLOBAL);
                  APIENTRY;  'KERNEL32' name 'GlobalFix';
       PROCEDURE GlobalUnfix(hMem:HGLOBAL);
                  APIENTRY;  'KERNEL32' name 'GlobalUnfix';
       FUNCTION GlobalWire(hMem:HGLOBAL):POINTER;
                  APIENTRY;  'KERNEL32' name 'GlobalWire';
       FUNCTION GlobalUnWire(hMem:HGLOBAL):BOOL;
                  APIENTRY;  'KERNEL32' name 'GlobalUnWire';
       PROCEDURE GlobalMemoryStatus(VAR lpBuffer:MEMORYSTATUS);
                  APIENTRY;  'KERNEL32' name 'GlobalMemoryStatus';
       FUNCTION LocalAlloc(uFlags:ULONG;uBytes:ULONG):HLOCAL;
                  APIENTRY;  'KERNEL32' name 'LocalAlloc';
       FUNCTION LocalReAlloc(hMem:HLOCAL;uBytes:ULONG;uFlags:ULONG):HLOCAL;
                  APIENTRY;  'KERNEL32' name 'LocalReAlloc';
       FUNCTION LocalLock(hMem:HLOCAL):POINTER;
                  APIENTRY;  'KERNEL32' name 'LocalLock';
       FUNCTION LocalHandle(pMem:POINTER):HLOCAL;
                  APIENTRY;  'KERNEL32' name 'LocalHandle';
       FUNCTION LocalUnlock(hMem:HLOCAL):BOOL;
                  APIENTRY;  'KERNEL32' name 'LocalUnlock';
       FUNCTION LocalSize(hMem:HLOCAL):ULONG;
                  APIENTRY;  'KERNEL32' name 'LocalSize';
       FUNCTION LocalFlags(hMem:HLOCAL):ULONG;
                  APIENTRY;  'KERNEL32' name 'LocalFlags';
       FUNCTION LocalFree(hMem:HLOCAL):HLOCAL;
                  APIENTRY;  'KERNEL32' name 'LocalFree';
       FUNCTION LocalShrink(hMem:HLOCAL;cbNewSize:ULONG):ULONG;
                  APIENTRY;  'KERNEL32' name 'LocalShrink';
       FUNCTION LocalCompact(uMinFree:ULONG):ULONG;
                  APIENTRY;  'KERNEL32' name 'LocalCompact';
       FUNCTION FlushInstructionCache(hProcess:HANDLE;lpBaseAddress:POINTER;
                                      dwSize:ULONG):BOOL;
                  APIENTRY;  'KERNEL32' name 'FlushInstructionCache';
       FUNCTION VirtualAlloc(lpAddress:POINTER;dwSize:ULONG;flAllocationType:ULONG;
                             flProtect:ULONG):POINTER;
                  APIENTRY;  'KERNEL32' name 'VirtualAlloc';
       FUNCTION VirtualFree(lpAddress:POINTER;dwSize:ULONG;dwFreeType:ULONG):BOOL;
                  APIENTRY;  'KERNEL32' name 'VirtualFree';
       FUNCTION VirtualProtect(lpAddress:POINTER;dwSize:ULONG;flNewProtect:ULONG;
                               VAR lpflOldProtect:ULONG):BOOL;
                  APIENTRY;  'KERNEL32' name 'VirtualProtect';
       FUNCTION VirtualQuery(lpAddress:POINTER;VAR lpBuffer:MEMORY_BASIC_INFORMATION;
                             dwLength:ULONG):ULONG;
                  APIENTRY;  'KERNEL32' name 'VirtualQuery';
       FUNCTION VirtualProtectEx(hProcess:HANDLE;lpAddress:POINTER;dwSize:ULONG;
                                 flNewProtect:ULONG;VAR lpflOldProtect:ULONG):BOOL;
                  APIENTRY;  'KERNEL32' name 'VirtualProtectEx';
       FUNCTION VirtualQueryEx(hProcess:HANDLE;lpAddress:POINTER;
                               VAR lpBuffer:MEMORY_BASIC_INFORMATION;
                               dwLength:ULONG):ULONG;
                  APIENTRY;  'KERNEL32' name 'VirtualQueryEx';
       FUNCTION HeapCreate(flOptions:ULONG;dwInitialSize:ULONG;
                           dwMaximumSize:ULONG):HANDLE;
                  APIENTRY;  'KERNEL32' name 'HeapCreate';
       FUNCTION HeapDestroy(hHeap:HANDLE):BOOL;
                  APIENTRY;  'KERNEL32' name 'HeapDestroy';
       FUNCTION HeapAlloc(hHeap:HANDLE;dwFlags,dwBytes:ULONG):POINTER;
                  APIENTRY;  'KERNEL32' name 'HeapAlloc';
       FUNCTION HeapReAlloc(hHeap:HANDLE;dwFlags:ULONG;lpMem:POINTER;
                            dwBytes:ULONG):POINTER;
                  APIENTRY;  'KERNEL32' name 'HeapReAlloc';
       FUNCTION HeapFree(hHeap:HANDLE;dwFlags:ULONG;lpMem:POINTER):BOOL;
                  APIENTRY;  'KERNEL32' name 'HeapFree';
       FUNCTION HeapSize(hHeap:HANDLE;dwFlags:ULONG;lpMem:POINTER):ULONG;
                  APIENTRY;  'KERNEL32' name 'HeapSize';
       FUNCTION HeapValidate(hHeap:HANDLE;dwFlags:ULONG;lpMem:POINTER):BOOL;
                  APIENTRY;  'KERNEL32' name 'HeapValidate';
       FUNCTION HeapCompact(hHeap:HANDLE;dwFlags:ULONG):ULONG;
                  APIENTRY;  'KERNEL32' name 'HeapCompact';
       FUNCTION GetProcessHeap:HANDLE;
                  APIENTRY;  'KERNEL32' name 'GetProcessHeap';
       FUNCTION GetProcessHeaps(NumberOfHeaps:ULONG;VAR ProcessHeaps:HANDLE):ULONG;
                  APIENTRY;  'KERNEL32' name 'GetProcessHeaps';
       FUNCTION HeapLock(hHeap:HANDLE):BOOL;
                  APIENTRY;  'KERNEL32' name 'HeapLock';
       FUNCTION HeapUnlock(hHeap:HANDLE):BOOL;
                  APIENTRY;  'KERNEL32' name 'HeapUnlock';
       FUNCTION HeapWalk(hHeap:HANDLE;VAR lpEntry:PROCESS_HEAP_ENTRY):BOOL;
                  APIENTRY;  'KERNEL32' name 'HeapWalk';
       FUNCTION GetBinaryType(CONST lpApplicationName:CSTRING;
                              VAR lpBinaryType:ULONG):BOOL;
                  APIENTRY;  'KERNEL32' name 'GetBinaryTypeA';
       FUNCTION GetShortPathName(CONST lpszLongPath:CSTRING;
                                 VAR lpszShortPath:CSTRING;cchBuffer:ULONG):ULONG;
                  APIENTRY;  'KERNEL32' name 'GetShortPathNameA';
       FUNCTION GetProcessAffinityMask(hProcess:HANDLE;VAR lpProcessAffinityMask,
                                       lpSystemAffinityMask:ULONG):BOOL;
                  APIENTRY;  'KERNEL32' name 'GetProcessAffinityMask';
       FUNCTION GetProcessTimes(hProcess:HANDLE;VAR lpCreationTime,
                                lpExitTime,lpKernelTime,lpUserTime:FILETIME):BOOL;
                  APIENTRY;  'KERNEL32' name 'GetProcessTimes';
       FUNCTION GetProcessWorkingSetSize(hProcess:HANDLE;VAR Min,Max:ULONG):BOOL;
                  APIENTRY;  'KERNEL32' name 'GetProcessWorkingSetSize';
       FUNCTION SetProcessWorkingSetSize(hProcess:HANDLE;Min,Max:ULONG):BOOL;
                  APIENTRY;  'KERNEL32' name 'SetProcessWorkingSetSize';
       FUNCTION OpenProcess(dwDesiredAccess:ULONG;bInheritHandle:BOOL;
                            dwProcessId:ULONG):HANDLE;
                  APIENTRY;  'KERNEL32' name 'OpenProcess';
       FUNCTION GetCurrentProcess:HANDLE;
                  APIENTRY;  'KERNEL32' name 'GetCurrentProcess';
       FUNCTION GetCurrentProcessId:ULONG;
                  APIENTRY;  'KERNEL32' name 'GetCurrentProcessId';
       PROCEDURE ExitProcess(uExitCode:ULONG);
                  APIENTRY;  'KERNEL32' name 'ExitProcess';
       FUNCTION TerminateProcess(hProcess:HANDLE;uExitCode:ULONG):BOOL;
                  APIENTRY;  'KERNEL32' name 'TerminateProcess';
       FUNCTION GetExitCodeProcess(hProcess:HANDLE;VAR lpExitCode:ULONG):BOOL;
                  APIENTRY;  'KERNEL32' name 'GetExitCodeProcess';
       PROCEDURE FatalExit(ExitCode:LONGINT);
                  APIENTRY;  'KERNEL32' name 'FatalExit';
       FUNCTION GetEnvironmentStrings:PChar;
                  APIENTRY;  'KERNEL32' name 'GetEnvironmentStrings'; {A ??}
       FUNCTION FreeEnvironmentStrings(p:PChar):BOOL;
                  APIENTRY;  'KERNEL32' name 'FreeEnvironmentStringsA';
       PROCEDURE RaiseException(dwExceptionCode,dwExceptionFlags:ULONG;
                                nNumberOfArguments:ULONG;VAR lpArguments);
                  APIENTRY;  'KERNEL32' name 'RaiseException';
       FUNCTION UnhandledExceptionFilter(VAR ExceptionInfo:EXCEPTION_POINTERS):LONG;
                  APIENTRY;  'KERNEL32' name 'UnhandledExceptionFilter';
       FUNCTION SetUnhandledExceptionFilter(lpTopLevelFilter:PTOP_LEVEL_EXCEPTION_FILTER):
                                LPTOP_LEVEL_EXCEPTION_FILTER;
                  APIENTRY;  'KERNEL32' name 'SetUnhandledExceptionFilter';
       FUNCTION CreateThread(VAR ThreadAttrs:SECURITY_ATTRIBUTES;Stack:ULONG;
                             lpStartAddress:LPTHREAD_START_ROUTINE;
                             lpParameter:POINTER;dwCreationFlags:ULONG;
                             VAR lpThreadId:ULONG):HANDLE;
                  APIENTRY;  'KERNEL32' name 'CreateThread';
       FUNCTION CreateRemoteThread(hProcess:HANDLE;VAR Attrs:SECURITY_ATTRIBUTES;
                                   dwStack:ULONG;lpStartAddr:LPTHREAD_START_ROUTINE;
                                   lpParameter:POINTER;dwCreationFlags:ULONG;
                                   VAR lpThreadId:ULONG):HANDLE;
                  APIENTRY;  'KERNEL32' name 'CreateRemoteThread';
       FUNCTION GetCurrentThread:HANDLE;
                  APIENTRY;  'KERNEL32' name 'GetCurrentThread';
       FUNCTION GetCurrentThreadId:ULONG;
                  APIENTRY;  'KERNEL32' name 'GetCurrentThreadId';
       FUNCTION SetThreadAffinityMask(hThread:HANDLE;dwMask:ULONG):ULONG;
                  APIENTRY;  'KERNEL32' name 'SetThreadAffinityMask';
       FUNCTION SetThreadPriority(hThread:HANDLE;nPriority:LONGINT):BOOL;
                  APIENTRY;  'KERNEL32' name 'SetThreadPriority';
       FUNCTION GetThreadPriority(hThread:HANDLE):LONGINT;
                  APIENTRY;  'KERNEL32' name 'GetThreadPriority';
       FUNCTION GetThreadTimes(hThread:HANDLE;VAR lpCreationTime,
                               lpExitTime,lpKernelTime,lpUserTime:FILETIME):BOOL;
                  APIENTRY;  'KERNEL32' name 'GetThreadTimes';
       PROCEDURE ExitThread(ExitCode:ULONG);
                  APIENTRY;  'KERNEL32' name 'ExitThread';
       FUNCTION TerminateThread(hThread:HANDLE;dwExitCode:ULONG):BOOL;
                  APIENTRY;  'KERNEL32' name 'TerminateThread';
       FUNCTION GetExitCodeThread(hThread:HANDLE;VAR lpExitCode:ULONG):BOOL;
                  APIENTRY;  'KERNEL32' name 'GetExitCodeThread';
       FUNCTION GetLastError:ULONG;
                  APIENTRY;  'KERNEL32' name 'GetLastError';
       PROCEDURE SetLastError(dwErrCode:ULONG);
                  APIENTRY;  'KERNEL32' name 'SetLastError';
       FUNCTION GetOverlappedResult(hFile:HANDLE;VAR lpOverlapped:OVERLAPPED;
                                    VAR lpNumberBytes:ULONG;bWait:BOOL):BOOL;
                  APIENTRY;  'KERNEL32' name 'GetOverlappedResult';
       FUNCTION CreateIoCompletionPort(FileHandle:HANDLE;ExistingPort:HANDLE;
                                       CompletionKey,NumberConcThreads:ULONG):HANDLE;
                  APIENTRY;  'KERNEL32' name 'CreateIoCompletionPort';
       FUNCTION GetQueuedCompletionStatus(CompletionPort:HANDLE;
                                          VAR lpNumber,lpKey:ULONG;
                                          VAR lpOverlapped:OVERLAPPED;
                                          dwMillisecs:ULONG):BOOL;
                  APIENTRY;  'KERNEL32' name 'GetQueuedCompletionStatus';
       FUNCTION SetErrorMode(uMode:ULONG):ULONG;
                  APIENTRY;  'KERNEL32' name 'SetErrorMode';
       FUNCTION ReadProcessMemory(hProcess:HANDLE;lpBaseAddress:POINTER;
                                  VAR lpBuffer;nSize:ULONG;
                                  VAR lpNumberOfBytesRead:ULONG):BOOL;
                  APIENTRY;  'KERNEL32' name 'ReadProcessMemory';
       FUNCTION WriteProcessMemory(hProcess:HANDLE;lpBaseAddress:POINTER;
                                   VAR lpBuffer;nSize:ULONG;
                                   VAR lpNumberOfBytesWritten:ULONG):BOOL;
                  APIENTRY;  'KERNEL32' name 'WriteProcessMemory';
       FUNCTION GetThreadContext(hThread:HANDLE;VAR lpContext:CONTEXT):BOOL;
                  APIENTRY;  'KERNEL32' name 'GetThreadContext';
       FUNCTION SetThreadContext(hThread:HANDLE;CONST lpContext:CONTEXT):BOOL;
                  APIENTRY;  'KERNEL32' name 'SetThreadContext';
       FUNCTION SuspendThread(hThread:HANDLE):ULONG;
                  APIENTRY;  'KERNEL32' name 'SuspendThread';
       FUNCTION ResumeThread(hThread:HANDLE):ULONG;
                  APIENTRY;  'KERNEL32' name 'ResumeThread';
       PROCEDURE DebugBreak;
                  APIENTRY;  'KERNEL32' name 'DebugBreak';
       FUNCTION WaitForDebugEvent(VAR lpDebugEvent:DEBUG_EVENT;
                                  dwMilliseconds:ULONG):BOOL;
                  APIENTRY;  'KERNEL32' name 'WaitForDebugEvent';
       FUNCTION ContinueDebugEvent(dwProcessId,dwThreadId,dwStatus:ULONG):BOOL;
                  APIENTRY;  'KERNEL32' name 'ContinueDebugEvent';
       FUNCTION DebugActiveProcess(dwProcessId:ULONG):BOOL;
                  APIENTRY;  'KERNEL32' name 'DebugActiveProcess';
       PROCEDURE InitializeCriticalSection(VAR CritSec:CRITICAL_SECTION);
                  APIENTRY;  'KERNEL32' name 'InitializeCriticalSection';
       PROCEDURE EnterCriticalSection(VAR CritSec:CRITICAL_SECTION);
                  APIENTRY;  'KERNEL32' name 'EnterCriticalSection';
       PROCEDURE LeaveCriticalSection(VAR CritSec:CRITICAL_SECTION);
                  APIENTRY;  'KERNEL32' name 'LeaveCriticalSection';
       PROCEDURE DeleteCriticalSection(VAR CritSec:CRITICAL_SECTION);
                  APIENTRY;  'KERNEL32' name 'DeleteCriticalSection';
       FUNCTION SetEvent(hEvent:HANDLE):BOOL;
                  APIENTRY;  'KERNEL32' name 'SetEvent';
       FUNCTION ResetEvent(hEvent:HANDLE):BOOL;
                  APIENTRY;  'KERNEL32' name 'ResetEvent';
       FUNCTION PulseEvent(hEvent:HANDLE):BOOL;
                  APIENTRY;  'KERNEL32' name 'PulseEvent';
       FUNCTION ReleaseSemaphore(hSemaphore:HANDLE;lReleaseCount:LONG;
                                 VAR lpPreviousCount:LONG):BOOL;
                  APIENTRY;  'KERNEL32' name 'ReleaseSemaphore';
       FUNCTION ReleaseMutex(hMutex:HANDLE):BOOL;
                  APIENTRY;  'KERNEL32' name 'ReleaseMutex';
       FUNCTION WaitForSingleObject(hHandle:HANDLE;dwMilliseconds:ULONG):ULONG;
                  APIENTRY;  'KERNEL32' name 'WaitForSingleObject';
       FUNCTION WaitForMultipleObjects(nCount:ULONG;VAR lpHandle:HANDLE;
                                       bWaitAll:BOOL;dwMilliseconds:ULONG):ULONG;
                  APIENTRY;  'KERNEL32' name 'WaitForMultipleObjects';
       PROCEDURE Sleep(dwMilliseconds:ULONG);
                  APIENTRY;  'KERNEL32' name 'Sleep';
       FUNCTION LoadResource(hModule:HINSTANCE;hResInfo:HRSRC):HGLOBAL;
                  APIENTRY;  'KERNEL32' name 'LoadResource';
       FUNCTION SizeofResource(hModule:HINSTANCE;hResInfo:HRSRC):ULONG;
                  APIENTRY;  'KERNEL32' name 'SizeofResource';
       FUNCTION GlobalDeleteAtom(nAtom:ATOM):ATOM;
                  APIENTRY;  'KERNEL32' name 'GlobalDeleteAtom';
       FUNCTION InitAtomTable(nSize:ULONG):BOOL;
                  APIENTRY;  'KERNEL32' name 'InitAtomTable';
       FUNCTION DeleteAtom(nAtom:ATOM):ATOM;
                  APIENTRY;  'KERNEL32' name 'DeleteAtom';
       FUNCTION SetHandleCount(uNumber:ULONG):ULONG;
                  APIENTRY;  'KERNEL32' name 'SetHandleCount';
       FUNCTION GetLogicalDrives:ULONG;
                  APIENTRY;  'KERNEL32' name 'GetLogicalDrives';
       FUNCTION LockFile(hFile:HANDLE;dwFileOffsetLow,dwFileOffsetHigh:ULONG;
                         dwNumbersToLockLow,dwNumbersToLockHigh:ULONG):BOOL;
                  APIENTRY;  'KERNEL32' name 'LockFile';
       FUNCTION UnlockFile (hFile:HANDLE;dwFileOffsetLow,dwFileOffsetHigh:ULONG;
                         dwNumbersToUnlockLow,dwNumbersToUnlockHigh:ULONG):BOOL;
                  APIENTRY;  'KERNEL32' name 'UnlockFile';
       FUNCTION LockFileEx(hFile:HANDLE;dwFlags,dwReserved:ULONG;
                           nNumberOfBytesToLockLow,nNumberOfBytesToLockHigh:ULONG;
                           VAR lpOverlapped:OVERLAPPED):BOOL;
                  APIENTRY;  'KERNEL32' name 'LockFileEx';
       FUNCTION UnlockFileEx(hFile:HANDLE;dwFlags,dwReserved:ULONG;
                           nNumberOfBytesToUnlockLow,nNumberOfBytesToUnlockHigh:ULONG;
                           VAR lpOverlapped:OVERLAPPED):BOOL;
                  APIENTRY;  'KERNEL32' name 'UnlockFileEx';
       FUNCTION GetFileInformationByHandle(hFile:HANDLE;
                             VAR lpFileInformation:BY_HANDLE_FILE_INFORMATION):BOOL;
                  APIENTRY;  'KERNEL32' name 'GetFileInformationByHandle';
       FUNCTION GetFileType(hFile:HANDLE):ULONG;
                  APIENTRY;  'KERNEL32' name 'GetFileType';
       FUNCTION GetFileSize(hFile:HANDLE;VAR lpFileSizeHigh:ULONG):ULONG;
                  APIENTRY;  'KERNEL32' name 'GetFileSize';
       FUNCTION GetStdHandle(nStdHandle:ULONG):HANDLE;
                  APIENTRY;  'KERNEL32' name 'GetStdHandle';
       FUNCTION SetStdHandle(nStdHandle:ULONG;hHandle:HANDLE):BOOL;
                  APIENTRY;  'KERNEL32' name 'SetStdHandle';
       FUNCTION WriteFile(hFile:HANDLE;CONST lpBuffer;nNumberOfBytesToWrite:ULONG;
                          VAR lpNumberOfBytesWritten:ULONG;
                          VAR lpOverlapped:OVERLAPPED):BOOL;
                  APIENTRY;  'KERNEL32' name 'WriteFile';
       FUNCTION ReadFile(hFile:HANDLE;VAR lpBuffer;nNumberOfBytesToRead:ULONG;
                         VAR lpNumberOfBytesRead:ULONG;
                         VAR lpOverlapped:OVERLAPPED):BOOL;
                  APIENTRY;  'KERNEL32' name 'ReadFile';
       FUNCTION FlushFileBuffers(hFile:HANDLE):BOOL;
                  APIENTRY;  'KERNEL32' name 'FlushFileBuffers';
       FUNCTION DeviceIoControl(hDevice:HANDLE;dwloControlCode:ULONG;
                                VAR lpInBuffer;nInBufferSize:ULONG;
                                VAR lpOutBuffer;nOutBufferSize:ULONG;
                                VAR lpBytesReturned:ULONG;
                                VAR lpOverlapped:OVERLAPPED):BOOL;
                  APIENTRY;  'KERNEL32' name 'DeviceIoControl';
       FUNCTION SetEndOfFile(hFile:HANDLE):BOOL;
                  APIENTRY;  'KERNEL32' name 'SetEndOfFile';
       FUNCTION SetFilePointer(hFile:HANDLE;lDistanceToMove:LONG;
                               VAR lpDistanceToMoveHigh:LONG;
                               dwMoveMethod:ULONG):ULONG;
                  APIENTRY;  'KERNEL32' name 'SetFilePointer';
       FUNCTION FindClose(hFindFile:HANDLE):BOOL;
                  APIENTRY;  'KERNEL32' name 'FindClose';
       FUNCTION GetFileTime(hFile:HANDLE;VAR lpCreationTime,lpLastAccessTime,
                            lpLastWriteTime:FILETIME):BOOL;
                  APIENTRY;  'KERNEL32' name 'GetFileTime';
       FUNCTION SetFileTime(hFile:HANDLE;VAR lpCreationTime,lpLastAccessTime,
                            lpLastWriteTime:FILETIME):BOOL;
                  APIENTRY;  'KERNEL32' name 'SetFileTime';
       FUNCTION CloseHandle(hObject:HANDLE):BOOL;
                  APIENTRY;  'KERNEL32' name 'CloseHandle';
       FUNCTION DuplicateHandle(hSourceProcessHandle,hSourceHandle:HANDLE;
                                hTargetProcessHandle:HANDLE;VAR lpTargetHandle:HANDLE;
                                dwDesiredAccess:ULONG;bInheritHandle:BOOL;
                                dwOptions:ULONG):BOOL;
                  APIENTRY;  'KERNEL32' name 'DuplicateHandle';
       FUNCTION GetHandleInformation(hObject:HANDLE;VAR lpdwFlags:ULONG):BOOL;
                  APIENTRY;  'KERNEL32' name 'GetHandleInformation';
       FUNCTION SetHandleInformation(hObject:HANDLE;dwMask,dwFlags:ULONG):BOOL;
                  APIENTRY;  'KERNEL32' name 'SetHandleInformation';
       FUNCTION LoadModule(CONST lpModuleName:CSTRING;lpParameterBlock:POINTER):ULONG;
                  APIENTRY;  'KERNEL32' name 'LoadModule';
       FUNCTION WinExec(CONST lpCmdLine:CSTRING;uCmdShow:ULONG):ULONG;
                  APIENTRY;  'KERNEL32' name 'WinExec';
       {FUNCTION BuildCommDCB(VAR lpDef:CSTRING;VAR lpDCB:DCB):BOOL;
                  APIENTRY;  'KERNEL32' name 'BuildCommDCB';
       FUNCTION BuildCommDCBAndTimeouts(VAR lpDef:CSTRING;VAR lpDCB:DCB;
                                        VAR lpCommTimeouts:COMMTIMEOUTS):BOOL;
                  APIENTRY;  'KERNEL32' name 'BuildCommDCBAndTimeouts';}
       FUNCTION ClearCommBreak(hFile:HANDLE):BOOL;
                  APIENTRY;  'KERNEL32' name 'ClearCommBreak';
       {FUNCTION ClearCommError(hFile:HANDLE;VAR lpErrors:ULONG;
                               VAR lpStat:COMSTAT):BOOL;
                  APIENTRY;  'KERNEL32' name 'ClearCommError';}
       FUNCTION SetupComm(hFile:HANDLE;dwInQueue,dwOutQueue:ULONG):BOOL;
                  APIENTRY;  'KERNEL32' name 'SetupComm';
       FUNCTION EscapeCommFunction(hFile:HANDLE;dwFunc:ULONG):BOOL;
                  APIENTRY;  'KERNEL32' name 'EscapeCommFunction';
       {FUNCTION GetCommConfig(hCommDev:HANDLE;VAR lpCC:COMMCONFIG;
                              VAR lpdwSize:ULONG):BOOL;
                  APIENTRY;  'KERNEL32' name 'GetCommConfig';}
       FUNCTION GetCommMask(hFile:HANDLE;VAR lpEvtMask:ULONG):BOOL;
                  APIENTRY;  'KERNEL32' name 'GetCommMask';
       FUNCTION GetCommProperties(hFile:HANDLE;VAR lpCommProp:COMMPROP):BOOL;
                  APIENTRY;  'KERNEL32' name 'GetCommProperties';
       FUNCTION GetCommModemStatus(hFile:HANDLE;VAR lpModemStat:ULONG):BOOL;
                  APIENTRY;  'KERNEL32' name 'GetCommModemStatus';
       {FUNCTION GetCommState(hFile:HANDLE;VAR lpDCB:DCB):BOOL;
                  APIENTRY;  'KERNEL32' name 'GetCommState';
       FUNCTION GetCommTimeouts(hFile:HANDLE;VAR lpCommTimeouts:COMMTIMEOUTS):BOOL;
                  APIENTRY;  'KERNEL32' name 'GetCommTimeouts';
       FUNCTION PurgeComm(hFile:HANDLE;dwFlags:ULONG):BOOL;
                  APIENTRY;  'KERNEL32' name 'PurgeComm';
       FUNCTION SetCommBreak(hFile:HANDLE):BOOL;
                  APIENTRY;  'KERNEL32' name 'SetCommBreak';
       FUNCTION SetCommConfig(hCommDev:HANDLE;VAR lpCC:COMMCONFIG;
                              dwSize:ULONG):BOOL;
                  APIENTRY;  'KERNEL32' name 'SetCommConfig';}
       FUNCTION SetCommMask(hFile:HANDLE;dwEvtMask:ULONG):BOOL;
                  APIENTRY;  'KERNEL32' name 'SetCommMask';
       {FUNCTION SetCommState(hFile:HANDLE;VAR lpDCB:DCB):BOOL;
                  APIENTRY;  'KERNEL32' name 'SetCommState';
       FUNCTION SetCommTimeouts(hFile:HANDLE;VAR lpCommTimeouts:COMMTIMEOUTS):BOOL;
                  APIENTRY;  'KERNEL32' name 'SetCommTimeouts';}
       FUNCTION TransmitCommChar(hFile:HANDLE;cChar:CHAR):BOOL;
                  APIENTRY;  'KERNEL32' name 'TransmitCommChar';
       FUNCTION WaitCommEvent(hFile:HANDLE;VAR lpEvtMask:ULONG;
                              VAR lpOverlapped:OVERLAPPED):BOOL;
                  APIENTRY;  'KERNEL32' name 'WaitCommEvent';
       FUNCTION SetTapePosition(hDevice:HANDLE;dwPositionMethod,dwPartition:ULONG;
                                dwOffsetLow,dwOffsetHigh:ULONG;bImmediate:BOOL):ULONG;
                  APIENTRY;  'KERNEL32' name 'SetTapePosition';
       FUNCTION GetTapePosition(hDevice:HANDLE;dwPositionType:ULONG;
                                VAR lpdwPartition,lpdwOffsetLow,lpdwOffsetHigh:ULONG):ULONG;
                  APIENTRY;  'KERNEL32' name 'GetTapePosition';
       FUNCTION PrepareTape(hDevice:HANDLE;dwOperation:ULONG;bImmediate:BOOL):ULONG;
                  APIENTRY;  'KERNEL32' name 'PrepareTape';
       FUNCTION EraseTape(hDevice:HANDLE;dwEraseType:ULONG;bImmediate:BOOL):ULONG;
                  APIENTRY;  'KERNEL32' name 'EraseTape';
       FUNCTION CreateTapePartition(hDevice:HANDLE;dwPartitionMethod:ULONG;
                                    dwCount,dwSize:ULONG):ULONG;
                  APIENTRY;  'KERNEL32' name 'CreateTapePartition';
       FUNCTION WriteTapemark(hDevice:HANDLE;dwTapemarkType,dwTapeMarkCount:ULONG;
                              bImmediate:BOOL):ULONG;
                  APIENTRY;  'KERNEL32' name 'WriteTapemark';
       FUNCTION GetTapeStatus(hDevice:HANDLE):ULONG;
                  APIENTRY;  'KERNEL32' name 'GetTapeStatus';
       FUNCTION GetTapeParameters(hDevice:HANDLE;dwOperation:ULONG;
                                  VAR lpdwSize:ULONG;VAR lpTapeInformation):ULONG;
                  APIENTRY;  'KERNEL32' name 'GetTapeParameters';
       FUNCTION SetTapeParameters(hDevice:HANDLE;dwOperation:ULONG;
                                  VAR lpTapeInformation):ULONG;
                  APIENTRY;  'KERNEL32' name 'SetTapeParameters';
       FUNCTION Beep(dwFreq,dwDuration:ULONG):BOOL;
                  APIENTRY;  'KERNEL32' name 'Beep';
       PROCEDURE OpenSound;
                  APIENTRY;  'KERNEL32' name 'OpenSound';
       PROCEDURE CloseSound;
                  APIENTRY;  'KERNEL32' name 'CloseSound';
       PROCEDURE StartSound;
                  APIENTRY;  'KERNEL32' name 'StartSound';
       PROCEDURE StopSound;
                  APIENTRY;  'KERNEL32' name 'StopSound';
       FUNCTION WaitSoundState(nState:ULONG):ULONG;
                  APIENTRY;  'KERNEL32' name 'WaitSoundState';
       FUNCTION SyncAllVoices:ULONG;
                  APIENTRY;  'KERNEL32' name 'SyncAllVoices';
       FUNCTION CountVoiceNotes(nVoice:ULONG):ULONG;
                  APIENTRY;  'KERNEL32' name 'CountVoiceNotes';
       FUNCTION GetThresholdEvent:LPDWORD;
                  APIENTRY;  'KERNEL32' name 'GetThresholdEvent';
       FUNCTION GetThresholdStatus:ULONG;
                  APIENTRY;  'KERNEL32' name 'GetThresholdStatus';
       FUNCTION SetSoundNoise(nSource,nDuration:ULONG):ULONG;
                  APIENTRY;  'KERNEL32' name 'SetSoundNoise';
       FUNCTION SetVoiceAccent(nVoice,nTempo,nVolume,nMode,nPitch:ULONG):ULONG;
                  APIENTRY;  'KERNEL32' name 'SetVoiceAccent';
       FUNCTION SetVoiceEnvelope(nVoice,nShape,nRepeat:ULONG):ULONG;
                  APIENTRY;  'KERNEL32' name 'SetVoiceEnvelope';
       FUNCTION SetVoiceNote(nVoice,nValue,nLength,nCdots:ULONG):ULONG;
                  APIENTRY;  'KERNEL32' name 'SetVoiceNote';
       FUNCTION SetVoiceQueueSize(nVoice,nBytes:ULONG):ULONG;
                  APIENTRY;  'KERNEL32' name 'SetVoiceQueueSize';
       FUNCTION SetVoiceSound(nVoice,Frequency,nDuration:ULONG):ULONG;
                  APIENTRY;  'KERNEL32' name 'SetVoiceSound';
       FUNCTION SetVoiceThreshold(nVoice,nNotes:ULONG):ULONG;
                  APIENTRY;  'KERNEL32' name 'SetVoiceThreshold';
       FUNCTION MulDiv(nNumber,nNumerator,nDenominator:LONGINT):LONGINT;
                  APIENTRY;  'KERNEL32' name 'MulDiv';
       PROCEDURE GetSystemTime(VAR lpSystemTime:SYSTEMTIME);
                  APIENTRY;  'KERNEL32' name 'GetSystemTime';
       FUNCTION SetSystemTime(CONST lpSystemTime:SYSTEMTIME):BOOL;
                  APIENTRY;  'KERNEL32' name 'SetSystemTime';
       PROCEDURE GetLocalTime(VAR lpSystemTime:SYSTEMTIME);
                  APIENTRY;  'KERNEL32' name 'GetLocalTime';
       FUNCTION SetLocalTime(CONST lpSystemTime:SYSTEMTIME):BOOL;
                  APIENTRY;  'KERNEL32' name 'SetLocalTime';
       PROCEDURE GetSystemInfo(VAR lpSystemInfo:SYSTEM_INFO);
                  APIENTRY;  'KERNEL32' name 'GetSystemInfo';
       FUNCTION SystemTimeToTzSpecificLocalTime(VAR lpTimeZoneInfo:TIME_ZONE_INFORMATION;
                        VAR lpUniversalTime,lpLocalTime:SYSTEMTIME):BOOL;
                  APIENTRY;  'KERNEL32' name 'SystemTimeToTzSpecificLocalTime';
       FUNCTION GetTimeZoneInformation(VAR lpTimeZoneInfo:TIME_ZONE_INFORMATION):ULONG;
                  APIENTRY;  'KERNEL32' name 'GetTimeZoneInformation';
       FUNCTION SetTimeZoneInformation(CONST lpTimeZoneInfo:TIME_ZONE_INFORMATION):BOOL;
                  APIENTRY;  'KERNEL32' name 'SetTimeZoneInformation';
       FUNCTION SystemTimeToFileTime(CONST lpSystemTime:SYSTEMTIME;
                                     VAR lpFileTime:FILETIME):BOOL;
                  APIENTRY;  'KERNEL32' name 'SystemTimeToFileTime';
       FUNCTION FileTimeToLocalFileTime(CONST lpFileTime:FILETIME;
                                        VAR lpLocalFileTime:FILETIME):BOOL;
                  APIENTRY;  'KERNEL32' name 'FileTimeToLocalFileTime';
       FUNCTION LocalFileTimeToFileTime(CONST lpLocalFileTime:FILETIME;
                                        VAR lpFileTime:FILETIME):BOOL;
                  APIENTRY;  'KERNEL32' name 'LocalFileTimeToFileTime';
       FUNCTION FileTimeToSystemTime(CONST lpFileTime:FILETIME;
                                     VAR lpSystemTime:SYSTEMTIME):BOOL;
                  APIENTRY;  'KERNEL32' name 'FileTimeToSystemTime';
       FUNCTION CompareFileTime(CONST lpFileTime1,lpFileTime2:FILETIME):LONG;
                  APIENTRY;  'KERNEL32' name 'CompareFileTime';
       FUNCTION FileTimeToDosDateTime(CONST lpFileTime:FILETIME;
                                      VAR lpFatDate,lpFatTime:WORD):BOOL;
                  APIENTRY;  'KERNEL32' name 'FileTimeToDosDateTime';
       FUNCTION DosDateTimeToFileTime(wFatDate,wFatTime:WORD;VAR lpFileTime:FILETIME):BOOL;
                  APIENTRY;  'KERNEL32' name 'DosDateTimeToFileTime';
       FUNCTION GetTickCount:ULONG;
                  APIENTRY;  'KERNEL32' name 'GetTickCount';
       FUNCTION SetSystemTimeAdjustment(dwTimeAdjustment:ULONG;
                                        bTimeAdjustmentDisabled:BOOL):BOOL;
                  APIENTRY;  'KERNEL32' name 'SetSystemTimeAdjustment';
       FUNCTION GetSystemTimeAdjustment(VAR lpTimeAdjustment,lpTimeIncrement:ULONG;
                                        VAR lpTimeAdjustmentDisabled:BOOL):BOOL;
                  APIENTRY;  'KERNEL32' name 'GetSystemTimeAdjustment';
       FUNCTION FormatMessage(dwFlags:ULONG;VAR lpSource;
                              dwMessageId,dwLanguageId:ULONG;
                              VAR lpBuffer:CSTRING;nSize:ULONG;
                              Arguments:POINTER):ULONG;
                  APIENTRY;  'KERNEL32' name 'FormatMessageA';
       FUNCTION CreatePipe(VAR hReadPipe,hWritePipe:HANDLE;
                           VAR lpPipeAttributes:SECURITY_ATTRIBUTES;
                           nSize:ULONG):BOOL;
                  APIENTRY;  'KERNEL32' name 'CreatePipe';
       FUNCTION ConnectNamedPipe(hNamedPipe:HANDLE;VAR lpOverlapped:OVERLAPPED):BOOL;
                  APIENTRY;  'KERNEL32' name 'ConnectNamedPipe';
       FUNCTION DisconnectNamedPipe(hNamedPipe:HANDLE):BOOL;
                  APIENTRY;  'KERNEL32' name 'DisconnectNamedPipe';
       FUNCTION SetNamedPipeHandleState(hNamedPipe:HANDLE;
                        VAR lpMode,lpMaxCollectionCount:ULONG;
                        VAR lpCollectDataTimeOut:ULONG):BOOL;
                  APIENTRY;  'KERNEL32' name 'SetNamedPipeHandleState';
       FUNCTION GetNamedPipeInfo(hNamedPipe:HANDLE;
                           VAR lpFlags,lpOutBufferSize:ULONG;
                           VAR lpInBufferSize,lpMaxInstances:ULONG):BOOL;
                  APIENTRY;  'KERNEL32' name 'GetNamedPipeInfo';
       FUNCTION PeekNamedPipe(hNamedPipe:HANDLE;VAR lpBuffer;nBufferSize:ULONG;
                              VAR lpBytesRead,lpTotalBytesAvail:ULONG;
                              VAR lpBytesLeftThisMessage:ULONG):BOOL;
                  APIENTRY;  'KERNEL32' name 'PeekNamedPipe';
       FUNCTION TransactNamedPipe(hNamedPipe:HANDLE;VAR lpInBuffer;nInBufferSize:ULONG;
                                  VAR lpOutBuffer;nOutBufferSize:ULONG;
                                  VAR lpBytesRead:ULONG;
                                  VAR lpOverlapped:OVERLAPPED):BOOL;
                  APIENTRY;  'KERNEL32' name 'TransactNamedPipe';
       FUNCTION CreateMailslot(CONST lpName:CSTRING;nMaxMessageSize:ULONG;
                               lReadTimeOut:ULONG;
                               VAR lpSecurityAttributes:SECURITY_ATTRIBUTES):HANDLE;
                  APIENTRY;  'KERNEL32' name 'CreateMailslotA';
       FUNCTION GetMailslotInfo(hMailslot:HANDLE;VAR lpMaxMessageSize:ULONG;
                                VAR lpNextSize,lpMessageCount:ULONG;
                                VAR lpReadTimeout:ULONG):BOOL;
                  APIENTRY;  'KERNEL32' name 'GetMailslotInfo';
       FUNCTION SetMailslotInfo(hMailslot:HANDLE;lReadTimeOut:ULONG):BOOL;
                  APIENTRY;  'KERNEL32' name 'SetMailslotInfo';
       FUNCTION MapViewOfFile(hFileMappingObject:HANDLE;dwDesiredAccess:ULONG;
                              dwFileOffsetHigh,dwFileOffsetLow:ULONG;
                              dwNumberOfBytesToMap:ULONG):POINTER;
                  APIENTRY;  'KERNEL32' name 'MapViewOfFile';
       FUNCTION FlushViewOfFile(lpBasAddress:POINTER;dwNumberOfBytesToFlush:ULONG):BOOL;
                  APIENTRY;  'KERNEL32' name 'FlushViewOfFile';
       FUNCTION UnmapViewOfFile(lpBaseAddress:POINTER):BOOL;
                  APIENTRY;  'KERNEL32' name 'UnmapViewOfFile';
       FUNCTION lstrcmp(CONST lpString1,lpString2:CSTRING):LONGINT;
                  APIENTRY;  'KERNEL32' name 'lstrcmpA';
       FUNCTION lstrcmpi(CONST lpString1,lpString2:CSTRING):LONGINT;
                  APIENTRY;  'KERNEL32' name 'lstrcmpiA';
       FUNCTION lstrcpyn(VAR lpString1:CSTRING;CONST lpString2:CSTRING;
                         iMaxLength:LONGINT):PChar;
                  APIENTRY;  'KERNEL32' name 'lstrcpynA';
       FUNCTION lstrcpy(VAR lpString1:CSTRING;CONST lpString2:CSTRING):PChar;
                  APIENTRY;  'KERNEL32' name 'lstrcpyA';
       FUNCTION lstrcat(VAR lpString1:CSTRING;CONST lpString2:CSTRING):PChar;
                  APIENTRY;  'KERNEL32' name 'lstrcatA';
       FUNCTION lstrlen(CONST lpString:CSTRING):LONGINT;
                  APIENTRY;  'KERNEL32' name 'lstrlenA';
       FUNCTION OpenFile(CONST lpFileName:CSTRING;VAR lpReOpenBuf:OFSTRUCT;
                         uStyle:ULONG):HFILE;
                  APIENTRY;  'KERNEL32' name 'OpenFile';
       FUNCTION _lopen(CONST lpPathName:CSTRING;iReadWrite:LONGINT):HFILE;
                  APIENTRY;  'KERNEL32' name '_lopen';
       FUNCTION _lcreat(CONST lpPathName:CSTRING;iAttribute:LONGINT):HFILE;
                  APIENTRY;  'KERNEL32' name '_lcreat';
       FUNCTION _lread(ahFile:HFILE;VAR lpBuffer;uBytes:ULONG):ULONG;
                  APIENTRY;  'KERNEL32' name '_lread';
       FUNCTION _lwrite(ahFile:HFILE;CONST Buffer;uBytes:ULONG):ULONG;
                  APIENTRY;  'KERNEL32' name '_lwrite';
       FUNCTION _hread(ahFile:HFILE;VAR lpBuffer;lBytes:LONGINT):LONGINT;
                  APIENTRY;  'KERNEL32' name '_hread';
       FUNCTION _hwrite(ahFile:HFILE;CONST lpBuffer;lBytes:LONGINT):LONGINT;
                  APIENTRY;  'KERNEL32' name '_hwrite';
       FUNCTION _lclose(ahFile:HFILE):HFILE;
                  APIENTRY;  'KERNEL32' name '_lclose';
       FUNCTION _llseek(ahFile:HFILE;lOffset:LONG;iOrigin:LONGINT):LONG;
                  APIENTRY;  'KERNEL32' name '_llseek';
       FUNCTION IsTextUnicode(CONST lpBuffer;cb:LONGINT;VAR lpi:LONGINT):BOOL;
                  APIENTRY;  'KERNEL32' name 'IsTextUnicode';
       FUNCTION TlsAlloc:ULONG;
                  APIENTRY;  'KERNEL32' name 'TlsAlloc';
       FUNCTION TlsGetValue(dwTlsIndex:ULONG):POINTER;
                  APIENTRY;  'KERNEL32' name 'TlsGetValue';
       FUNCTION TlsSetValue(dwTlsIndex:ULONG;lpTlsValue:POINTER):BOOL;
                  APIENTRY;  'KERNEL32' name 'TlsSetValue';
       FUNCTION TlsFree(dwTlsIndex:ULONG):BOOL;
                  APIENTRY;  'KERNEL32' name 'TlsFree';
       FUNCTION SleepEx(dwMilliseconds:ULONG;bAlertable:BOOL):ULONG;
                  APIENTRY;  'KERNEL32' name 'SleepEx';
       FUNCTION WaitForSingleObjectEx(hHandle:HANDLE;dwMillieconds:ULONG;
                                      bAlertable:BOOL):ULONG;
                  APIENTRY;  'KERNEL32' name 'WaitForSingleObjectEx';
       FUNCTION WaitForMultipleObjectsEx(nCount:ULONG;VAR lpHandles:HANDLE;
                                         bWaitAll:BOOL;dwMilliseconds:ULONG;
                                         bAlertable:BOOL):ULONG;
                  APIENTRY;  'KERNEL32' name 'WaitForMultipleObjectsEx';
       FUNCTION ReadFileEx(hFile:HANDLE;VAR lpBuffer;nNumberOfBytesToRead:ULONG;
                           VAR lpOverlapped:OVERLAPPED;
                           lpCompletionRoutine:LPOVERLAPPED_COMPLETION_ROUTINE):BOOL;
                  APIENTRY;  'KERNEL32' name 'ReadFileEx';
       FUNCTION WriteFileEx(hFile:HANDLE;CONST lpBuffer;nNumberOfBytesToWrite:ULONG;
                            VAR lpOverlapped:OVERLAPPED;
                            lpCompletionRoutine:LPOVERLAPPED_COMPLETION_ROUTINE):BOOL;
                  APIENTRY;  'KERNEL32' name 'WriteFileEx';
       FUNCTION BackupRead(hFile:HANDLE;VAR lpBuffer;nNumberOfBytesToRead:ULONG;
                           VAR lpNumberOfBytesRead:ULONG;bAbort:BOOL;
                           bProcessSecurity:BOOL;VAR lpContext:POINTER):BOOL;
                  APIENTRY;  'KERNEL32' name 'BackupRead';
       FUNCTION BackupSeek(hFile:HANDLE;dwLowBytesToSeek,dwHighBytesToSeek:ULONG;
                           VAR lpdwLowByteSeeked,lpdwHighByteSeeked:ULONG;
                           VAR lpContext:POINTER):BOOL;
                  APIENTRY;  'KERNEL32' name 'BackupSeek';
       FUNCTION BackupWrite(hFile:HANDLE;VAR lpBuffer;nNumberOfBytesToWrite:ULONG;
                            VAR lpNumberOfBytesWritten:ULONG;bAbort:BOOL;
                            bProcessSecurity:BOOL;VAR lpContext:POINTER):BOOL;
                  APIENTRY;  'KERNEL32' name 'BackupWrite';
       FUNCTION CreateMutex(VAR lpMutexAttributes:SECURITY_ATTRIBUTES;
                            bInitialOwner:BOOL;CONST lpName:CSTRING):HANDLE;
                  APIENTRY;  'KERNEL32' name 'CreateMutexA';
       FUNCTION OpenMutex(dwDesiredAccess:ULONG;bInheritHandle:BOOL;
                          CONST lpName:CSTRING):HANDLE;
                  APIENTRY;  'KERNEL32' name 'OpenMutexA';
       FUNCTION CreateEvent(VAR lpEventAttributes:SECURITY_ATTRIBUTES;
                            bManualReset,bInitialState:BOOL;
                            CONST lpName:CSTRING):HANDLE;
                  APIENTRY;  'KERNEL32' name 'CreateEventA';
       FUNCTION OpenEvent(dwDesiredAccess:ULONG;bInheritHandle:BOOL;
                          CONST lpName:CSTRING):HANDLE;
                  APIENTRY;  'KERNEL32' name 'OpenEventA';
       FUNCTION CreateSemaphore(VAR lpSemaphoreAttributes:SECURITY_ATTRIBUTES;
                                lInitialCount,lMaximumCount:LONG;
                                CONST lpName:CSTRING):HANDLE;
                  APIENTRY;  'KERNEL32' name 'CreateSemaphoreA';
       FUNCTION OpenSemaphore(dwDesiredAccess:ULONG;bInheritHandle:BOOL;
                              CONST lpName:CSTRING):HANDLE;
                  APIENTRY;  'KERNEL32' name 'OpenSemaphoreA';
       FUNCTION CreateFileMapping(hFile:HANDLE;
                                  VAR lpFileMappingAttributes:SECURITY_ATTRIBUTES;
                                  flProtect,dwMaximumSizeHigh,dwMaximumSizeLow:ULONG;
                                  CONST lpName:CSTRING):HANDLE;
                  APIENTRY;  'KERNEL32' name 'CreateFileMappingA';
       FUNCTION OpenFileMapping(dwDesiredAccess:ULONG;bInheritHandle:BOOL;
                                CONST lpName:CSTRING):HANDLE;
                  APIENTRY;  'KERNEL32' name 'OpenFileMappingA';
       FUNCTION GetLogicalDriveStrings(nBufferLength:ULONG;
                                       VAR lpBuffer:CSTRING):ULONG;
                  APIENTRY;  'KERNEL32' name 'GetLogicalDriveStringsA';
       FUNCTION LoadLibrary(CONST lpLibFileName:CSTRING):HINSTANCE;
                  APIENTRY;  'KERNEL32' name 'LoadLibraryA';
       FUNCTION LoadLibraryEx(CONST lpLibFileName:CSTRING;hFile:HANDLE;
                              dwFlags:ULONG):HINSTANCE;
                  APIENTRY;  'KERNEL32' name 'LoadLibraryExA';
       FUNCTION GetModuleFileName(hModule:HINSTANCE;VAR lpFileName;
                                  nSize:ULONG):ULONG;
                  APIENTRY;  'KERNEL32' name 'GetModuleFileNameA';
       FUNCTION GetModuleHandle(CONST lpModuleName:CSTRING):HMODULE;
                  APIENTRY;  'KERNEL32' name 'GetModuleHandleA';
       FUNCTION CreateProcess(CONST lpApplicationName:CSTRING;VAR lpCommandLine:CSTRING;
                              VAR lpProcessAttributes,lpThreadAttributes:SECURITY_ATTRIBUTES;
                              bInheritHandles:BOOL;dwCreationFlags:ULONG;
                              lpEnvironment:POINTER;CONST lpCurrentDir:CSTRING;
                              VAR lpStartupInfo:STARTUPINFO;
                              VAR lpProcessInformation:PROCESS_INFORMATION):BOOL;
                  APIENTRY;  'KERNEL32' name 'CreateProcessA';
       FUNCTION SetProcessShutdownParameters(dwLevel,dwFlags:ULONG):BOOL;
                  APIENTRY;  'KERNEL32' name 'SetProcessShutdownParameters';
       FUNCTION GetProcessShutdownParameters(VAR lpdwLevel,lpdwFlags:ULONG):BOOL;
                  APIENTRY;  'KERNEL32' name 'GetProcessShutdownParameters';
       PROCEDURE FatalAppExit(uAction:ULONG;CONST lpMessageText:CSTRING);
                  APIENTRY;  'KERNEL32' name 'FatalAppExitA';
       PROCEDURE GetStartupInfo(VAR lpStartupInfo:STARTUPINFO);
                  APIENTRY;  'KERNEL32' name 'GetStartupInfoA';
       FUNCTION GetCommandLine:PChar;
                  APIENTRY;  'KERNEL32' name 'GetCommandLineA';
       FUNCTION GetEnvironmentVariable(CONST lpName:CSTRING;VAR lpBuffer:CSTRING;
                                       nSize:ULONG):ULONG;
                  APIENTRY;  'KERNEL32' name 'GetEnvironmentVariableA';
       FUNCTION SetEnvironmentVariable(CONST lpName,lpValue:CSTRING):BOOL;
                  APIENTRY;  'KERNEL32' name 'SetEnvironmentVariableA';
       FUNCTION ExpandEnvironmentStrings(CONST lpSrc:CSTRING;VAR lpDst:CSTRING;
                                         nSize:ULONG):ULONG;
                  APIENTRY;  'KERNEL32' name 'ExpandEnvironmentStringsA';
       PROCEDURE OutputDebugString(CONST lpOutputString:CSTRING);
                  APIENTRY;  'KERNEL32' name 'OutputDebugStringA';
       FUNCTION FindResource(hModule:HINSTANCE;CONST lpName,lpType:CSTRING):HRSRC;
                  APIENTRY;  'KERNEL32' name 'FindResourceA';
       FUNCTION FindResourceEx(hModule:HINSTANCE;CONST lpType,lpName:CSTRING;
                               wLanguage:WORD):HRSRC;
                  APIENTRY;  'KERNEL32' name 'FindResourceExA';
       FUNCTION EnumResourceTypes(hModule:HINSTANCE;lpEnumFunc:ENUMRESTYPEPROC;
                                  lParam:LONG):BOOL;
                  APIENTRY;  'KERNEL32' name 'EnumResourceTypesA';
       FUNCTION EnumResourceNames(hModule:HINSTANCE;CONST lpType:CSTRING;
                                  lpEnumFunc:ENUMRESNAMEPROC;lParam:LONG):BOOL;
                  APIENTRY;  'KERNEL32' name 'EnumResourceNamesA';
       FUNCTION EnumResourceLanguages(hModule:HINSTANCE;CONST lpType,lpName:CSTRING;
                                      lpEnumFunc:ENUMRESLANGPROC;lParam:LONG):BOOL;
                  APIENTRY;  'KERNEL32' name 'EnumResourceLanguagesA';
       FUNCTION BeginUpdateResource(CONST pFileName:CSTRING;
                                    bDeleteExistingResources:BOOL):HANDLE;
                  APIENTRY;  'KERNEL32' name 'BeginUpdateResourceA';
       FUNCTION UpdateResource(hUpdate:HANDLE;CONST lpType,lpName:CSTRING;
                               wLanguage:WORD;lpData:POINTER;
                               cbData:ULONG):BOOL;
                  APIENTRY;  'KERNEL32' name 'UpdateResourceA';
       FUNCTION EndUpdateResource(hUpdate:HANDLE;fDiscard:BOOL):BOOL;
                  APIENTRY;  'KERNEL32' name 'EndUpdateResourceA';
       FUNCTION GlobalAddAtom(CONST lpString:CSTRING):ATOM;
                  APIENTRY;  'KERNEL32' name 'GlobalAddAtomA';
       FUNCTION GlobalFindAtom(CONST lpString:CSTRING):ATOM;
                  APIENTRY;  'KERNEL32' name 'GlobalFindAtomA';
       FUNCTION GlobalGetAtomName(nAtom:ATOM;VAR lpBuffer:CSTRING;
                                  nSize:LONGINT):ULONG;
                  APIENTRY;  'KERNEL32' name 'GlobalGetAtomNameA';
       FUNCTION AddAtom(CONST lpString:CSTRING):ATOM;
                  APIENTRY;  'KERNEL32' name 'AddAtomA';
       FUNCTION FindAtom(CONST lpString:CSTRING):ATOM;
                  APIENTRY;  'KERNEL32' name 'FindAtomA';
       FUNCTION GetAtomName(nAtom:ATOM;VAR lpBuffer:CSTRING;nSize:LONG):ULONG;
                  APIENTRY;  'KERNEL32' name 'GetAtomNameA';
       FUNCTION GetProfileInt(CONST lpAppName,lpKeyName:CSTRING;
                              nDefault:LONGINT):ULONG;
                  APIENTRY;  'KERNEL32' name 'GetProfileIntA';
       FUNCTION GetProfileString(CONST lpAppName,lpKeyName,lpDefault:CSTRING;
                                 VAR lpReturnedString:CSTRING;nSize:ULONG):ULONG;
                  APIENTRY;  'KERNEL32' name 'GetProfileStringA';
       FUNCTION WriteProfileString(CONST lpAppName,lpKeyName,lpString:CSTRING):BOOL;
                  APIENTRY;  'KERNEL32' name 'WriteProfileStringA';
       FUNCTION GetProfileSection(CONST lpAppName:CSTRING;VAR lpReturnedString:CSTRING;
                                  nSize:ULONG):ULONG;
                  APIENTRY;  'KERNEL32' name 'GetProfileSectionA';
       FUNCTION WriteProfileSection(CONST lpAppName,lpString:CSTRING):BOOL;
                  APIENTRY;  'KERNEL32' name 'WriteProfileSectionA';
       FUNCTION GetPrivateProfileInt(CONST lpAppName,lpKeyName:CSTRING;
                                     nDefault:LONGINT;CONST lpFileName:CSTRING):ULONG;
                  APIENTRY;  'KERNEL32' name 'GetPrivateProfileIntA';
       FUNCTION GetPrivateProfileString(CONST lpAppName,lpKeyName:CSTRING;
                                        CONST lpDefault:CSTRING;
                                        VAR lpReturnedString:CSTRING;
                                        nSize:ULONG;CONST lpFileName:CSTRING):ULONG;
                  APIENTRY;  'KERNEL32' name 'GetPrivateProfileStringA';
       FUNCTION WritePrivateProfileString(CONST lpAppName,lpKeyName:CSTRING;
                                          CONST lpString,lpFileName:CSTRING):BOOL;
                  APIENTRY;  'KERNEL32' name 'WritePrivateProfileStringA';
       FUNCTION GetPrivateProfileSection(CONST lpAppName:CSTRING;
                                         VAR lpReturnedString:CSTRING;
                                         nSize:ULONG;CONST lpFileName:CSTRING):ULONG;
                  APIENTRY;  'KERNEL32' name 'GetPrivateProfileSectionA';
       FUNCTION WritePrivateProfileSection(CONST lpAppName,lpString:CSTRING;
                                           CONST lpFileName:CSTRING):BOOL;
                  APIENTRY;  'KERNEL32' name 'WritePrivateProfileSectionA';
       FUNCTION GetDriveType(CONST lpRootPathName:CSTRING):ULONG;
                  APIENTRY;  'KERNEL32' name 'GetDriveTypeA';
       FUNCTION GetSystemDirectory(VAR lpBuffer:CSTRING;uSize:ULONG):ULONG;
                  APIENTRY;  'KERNEL32' name 'GetSystemDirectoryA';
       FUNCTION GetTempPath(nBufferLength:ULONG;VAR lpBuffer:CSTRING):ULONG;
                  APIENTRY;  'KERNEL32' name 'GetTempPathA';
       FUNCTION GetTempFileName(CONST lpPathName,lpPrefixString:CSTRING;
                                uUnique:ULONG;VAR lpTempFileName:CSTRING):ULONG;
                  APIENTRY;  'KERNEL32' name 'GetTempFileNameA';
       FUNCTION GetWindowsDirectory(VAR lpBuffer:CSTRING;uSize:ULONG):ULONG;
                  APIENTRY;  'KERNEL32' name 'GetWindowsDirectoryA';
       FUNCTION SetCurrentDirectory(CONST lpPathName:CSTRING):BOOL;
                  APIENTRY;  'KERNEL32' name 'SetCurrentDirectoryA';
       FUNCTION GetCurrentDirectory(nBufferLength:ULONG;VAR lpBuffer):ULONG;
                  APIENTRY;  'KERNEL32' name 'GetCurrentDirectoryA';
       FUNCTION GetDiskFreeSpace(CONST lpRootPathName:CSTRING;
                                 VAR lpSectorsPerCluster,lpBytesPerSector:ULONG;
                                 VAR lpNumberOfFreeClusters,lpTotalClusters:ULONG):BOOL;
                  APIENTRY;  'KERNEL32' name 'GetDiskFreeSpaceA';
       FUNCTION CreateDirectory(CONST lpPathName:CSTRING;
                                VAR lpSecurityAttributes:SECURITY_ATTRIBUTES):BOOL;
                  APIENTRY;  'KERNEL32' name 'CreateDirectoryA';
       FUNCTION CreateDirectoryEx(CONST lpTemplateDir,lpNewDir:CSTRING;
                                  VAR lpSecurityAttribtes:SECURITY_ATTRIBUTES):BOOL;
                  APIENTRY;  'KERNEL32' name 'CreateDirectoryExA';
       FUNCTION RemoveDirectory(CONST lpPathName:CSTRING):BOOL;
                  APIENTRY;  'KERNEL32' name 'RemoveDirectoryA';
       FUNCTION GetFullPathName(CONST lpFileName:CSTRING;nBufferLength:ULONG;
                                VAR lpBuffer;VAR lpFilePart:PChar):ULONG;
                  APIENTRY;  'KERNEL32' name 'GetFullPathNameA';
       FUNCTION DefineDosDevice(dwFlags:ULONG;CONST lpDeviceName:CSTRING;
                                CONST lpTargetPath:CSTRING):BOOL;
                  APIENTRY;  'KERNEL32' name 'DefineDosDeviceA';
       FUNCTION QueryDosDevice(CONST lpDeviceName:CSTRING;VAR lpTargetPath:CSTRING;
                               ucchMax:ULONG):ULONG;
                  APIENTRY;  'KERNEL32' name 'QueryDosDeviceA';
       FUNCTION CreateFile(CONST lpFileName:CSTRING;dwDesiredAccess:ULONG;
                           dwShareMode:ULONG;VAR lpSecurityAttributes:SECURITY_ATTRIBUTES;
                           deCreationDisposition,dwFlagsAndAttributes:ULONG;
                           hTemplateFile:HANDLE):HANDLE;
                  APIENTRY;  'KERNEL32' name 'CreateFileA';
       FUNCTION SetFileAttributes(CONST lpFileName:CSTRING;
                                  dwFileAttributes:ULONG):BOOL;
                  APIENTRY;  'KERNEL32' name 'SetFileAttributesA';
       FUNCTION GetFileAttributes(CONST lpFileName:CSTRING):ULONG;
                  APIENTRY;  'KERNEL32' name 'GetFileAttributesA';
       FUNCTION GetCompressedFileSize(CONST lpFileName:CSTRING;
                                      VAR lpFileSizeHigh:ULONG):ULONG;
                  APIENTRY;  'KERNEL32' name 'GetCompressedFileSizeA';
       FUNCTION DeleteFile(CONST lpFileName:CSTRING):BOOL;
                  APIENTRY;  'KERNEL32' name 'DeleteFileA';
       FUNCTION FindFirstFile(CONST lpFileName:CSTRING;
                              VAR lpFindFileData:WIN32_FIND_DATA):HANDLE;
                  APIENTRY;  'KERNEL32' name 'FindFirstFileA';
       FUNCTION FindNextFile(hFindFile:HANDLE;
                             VAR lpFindFileData:WIN32_FIND_DATA):BOOL;
                  APIENTRY;  'KERNEL32' name 'FindNextFileA';
       FUNCTION SearchPath(CONST lpPath,lpFileName,lpExtension:CSTRING;
                           nBufferLength:ULONG;VAR lpBuffer:CSTRING;
                           VAR lpFilePart:PChar):ULONG;
                  APIENTRY;  'KERNEL32' name 'SearchPathA';
       FUNCTION CopyFile(CONST lpExistingFileName,lpNewFileName:CSTRING;
                         bFailIfExists:BOOL):BOOL;
                  APIENTRY;  'KERNEL32' name 'CopyFileA';
       FUNCTION MoveFile(CONST lpExistingFileName,lpNewFileName:CSTRING):BOOL;
                  APIENTRY;  'KERNEL32' name 'MoveFileA';
       FUNCTION MoveFileEx(CONST lpExistingFileName,lpNewFileName:CSTRING;
                           dwFlags:ULONG):BOOL;
                  APIENTRY;  'KERNEL32' name 'MoveFileExA';
       FUNCTION CreateNamedPipe(CONST lpName:CSTRING;dwOpenMode:ULONG;
                                dwPipeMode,nMaxInstances,nOutBufferSize:ULONG;
                                nInBufferSize,nDefaultTimeOut:ULONG;
                                VAR lpSecurityAttributes:SECURITY_ATTRIBUTES):HANDLE;
                  APIENTRY;  'KERNEL32' name 'CreateNamedPipeA';
       FUNCTION GetNamedPipeHandleState(hNamedPipe:HANDLE;VAR lpState:ULONG;
                              VAR lpCurInstances,lpMaxCollectionCount:ULONG;
                              VAR lpCollectDataTimeOut:ULONG;
                              VAR lpUserName:CSTRING;nMaxUserNameSize:ULONG):BOOL;
                  APIENTRY;  'KERNEL32' name 'GetNamedPipeHandleStateA';
       FUNCTION CallNamedPipe(CONST lpNamedPipeName:CSTRING;
                              VAR lpInBuffer;nInBufferSize:ULONG;
                              VAR lpOutBuffer;nOutBufferSize:ULONG;
                              VAR lpBytesRead:ULONG;nTimeOut:ULONG):BOOL;
                  APIENTRY;  'KERNEL32' name 'CallNamedPipeA';
       FUNCTION WaitNamedPipe(CONST lpNamedPipeName:CSTRING;
                              nTimeOut:ULONG):BOOL;
                  APIENTRY;  'KERNEL32' name 'WaitNamedPipeA';
       FUNCTION SetVolumeLabel(CONST lpRootPathName,lpVolumeName:CSTRING):BOOL;
                  APIENTRY;  'KERNEL32' name 'SetVolumeLabelA';
       PROCEDURE SetFileApisToOEM;
                  APIENTRY;  'KERNEL32' name 'SetFileApisToOEM';
       PROCEDURE SetFileApisToANSI;
                  APIENTRY;  'KERNEL32' name 'SetFileApisToANSI';
       FUNCTION AreFileApisANSI:BOOL;
                  APIENTRY;  'KERNEL32' name 'AreFileApisANSI';
       FUNCTION GetVolumeInformation(CONST lpRootPathName:CSTRING;
                                     VAR lpVolumeNameBuffer:CSTRING;
                                     nVolumeNameSize:ULONG;
                                     VAR lpVolumeSerialNumber:ULONG;
                                     VAR lpMaximumComponentLength:ULONG;
                                     VAR lpFileSystemFlags:ULONG;
                                     VAR lpFileSystemNameBuffer:CSTRING;
                                     nFileSystemNameSize:ULONG):BOOL;
                  APIENTRY;  'KERNEL32' name 'GetVolumeInformationA';
       FUNCTION ClearEventLog(hEventLog:HANDLE;CONST lpBackupFileName:CSTRING):BOOL;
                  APIENTRY;  'KERNEL32' name 'ClearEventLogA';
       FUNCTION BackupEventLog(hEventLog:HANDLE;CONST lpBackupFileName:CSTRING):BOOL;
                  APIENTRY;  'KERNEL32' name 'BackupEventLogA';
       FUNCTION CloseEventLog(hEventLog:HANDLE):BOOL;
                  APIENTRY;  'KERNEL32' name 'CloseEventLog';
       FUNCTION DeregisterEventSource(hEventLog:HANDLE):BOOL;
                  APIENTRY;  'KERNEL32' name 'DeregisterEventSource';
       FUNCTION NotifyChangeEventLog(hEventLog,hEvent:HANDLE):BOOL;
                  APIENTRY;  'KERNEL32' name 'NotifyChangeEventLog';
       FUNCTION GetNumberOfEventLogRecords(hEventLog:HANDLE;VAR NumberOfRecords:WORD):BOOL;
                  APIENTRY;  'KERNEL32' name 'GetNumberOfEventLogRecords';
       FUNCTION GetOldestEventLogRecord(hEventLog:HANDLE;VAR OldestRecord:ULONG):BOOL;
                  APIENTRY;  'KERNEL32' name 'GetOldestEventLogRecord';
       FUNCTION OpenEventLog(CONST lpUNCServerName:CSTRING;
                             CONST lpSourceName:CSTRING):HANDLE;
                  APIENTRY;  'KERNEL32' name 'OpenEventLogA';
       FUNCTION RegisterEventSource(CONST lpUNCServerName:CSTRING;
                                    CONST lpSourceName:CSTRING):HANDLE;
                  APIENTRY;  'KERNEL32' name 'RegisterEventSourceA';
       FUNCTION OpenBackupEventLog(CONST lpUNCServerName:CSTRING;
                                   CONST lpFileName:CSTRING):HANDLE;
                  APIENTRY;  'KERNEL32' name 'OpenBackupEventLogA';
       FUNCTION ReadEventLog(hEventLog:HANDLE;dwReadFlags,dwRecordOffset:ULONG;
                             VAR lpBuffer;nNumberOfBytesToRead:ULONG;
                             VAR pnBytesRead,pnMinNumberOfBytesNeeded:ULONG):BOOL;
                  APIENTRY;  'KERNEL32' name 'ReadEventLogA';
       {FUNCTION ReportEvent(hEventLog:HANDLE;wType,wCategory:WORD;
                            dwEventID:ULONG;VAR lpUserSid:SID;
                            wNumStrings:WORD;VAR lpStrings:PChar;
                            VAR lpRawData):BOOL;
                  APIENTRY;  'KERNEL32' name 'ReportEventA';
       FUNCTION DuplicateToken(ExistingTokenHandle:HANDLE;
                               Impoersonation_Level:SECURITY_IMPERSONATION_LEVEL;
                               VAR DuplicateTokenHandle:HANDLE):BOOL;
                  APIENTRY;  'KERNEL32' name 'DuplicateToken';
       FUNCTION GetKernelObjectSecurity(Handle:HANDLE;Requested_Information:SECURITY_INFORMATION;
                                        VAR pSecurityDescriptor:SECURITY_DESCRIPTOR;
                                        nLength:ULONG;VAR lpnLengthNeeded:ULONG):BOOL;
                  APIENTRY;  'KERNEL32' name 'GetKernelObjectSecurity';
       FUNCTION ImpersonateNamedPipeClient(hNamedPipe:HANDLE):BOOL;
                  APIENTRY;  'KERNEL32' name 'ImpersonateNamedPipeClient';
       FUNCTION ImpersonateSelf(ImpoersonationLevel:SECURITY_IMPOERSONATION_LEVEL):BOOL;
                  APIENTRY;  'KERNEL32' name 'ImpersonateSelf';
       FUNCTION RevertToSelf:BOOL;
                  APIENTRY;  'KERNEL32' name 'RevertToSelf';
       FUNCTION SetThreadToken(VAR Thread:HANDLE;Token:HANDLE):BOOL;
                  APIENTRY;  'KERNEL32' name 'SetThreadToken';
       FUNCTION AccessCheck(VAR pSecurityDescriptor:SECURITY_DESCRIPTOR;
                            ClientToken:HANDLE;DesiredAccess:ULONG;
                            VAR GenericMapping:GENERIC_MAPPING;
                            VAR PrivilegeSet:PRIVILEGE_SET;
                            VAR PrivilegeSetLength:ULONG;
                            VAR GrantedAccess:ULONG;VAR AccessStatus:BOOL):BOOL;
                  APIENTRY;  'KERNEL32' name 'AccessCheck';
       FUNCTION OpenProcessToken(ProcessHandle:HANDLE;DesiredAccess:ULONG;
                                 VAR TokenHandle:HANDLE):BOOL;
                  APIENTRY;  'KERNEL32' name 'OpenProcessToken';
       FUNCTION OpenThreadToken(ThreadHandle:HANDLE;DesiredAccess:ULONG;
                                OpenAsSelf:BOOL;VAR TokenHandle:HANDLE):BOOL;
                  APIENTRY;  'KERNEL32' name 'OpenThreadToken';
       FUNCTION GetTokenInformation(TokenHandle:HANDLE;
                               TokenInformationClass:TOKEN_INFORMATION_CLASS;
                               VAR TokenInformation;TokenInformationLength:ULONG;
                               VAR ReturnLength:ULONG):BOOL;
                  APIENTRY;  'KERNEL32' name 'GetTokenInformation';
       FUNCTION SetTokenInformation(TokenHandle:HANDLE;
                               TokenInformationClass:TOKEN_INFORMATION_CLASS;
                               VAR TokenInformation;TokenInformationLength:ULONG):BOOL;
                  APIENTRY;  'KERNEL32' name 'SetTokenInformation';
       FUNCTION AdjustTokenPrivileges(TokenHandle:HANDLE;DisableAllPrivileges:BOOL;
                                      VAR NewState:TOKEN_PRIVILEGES;
                                      BufferLength:ULONG;
                                      VAR PreviousState:TOKEN_PRIVILEGES;
                                      VAR ReturnLength:ULONG):BOOL;
                  APIENTRY;  'KERNEL32' name 'AdjustTokenPrivileges';
       FUNCTION AdjustTokenGroups(TokenHandle:HANDLE;ResetToDefault:BOOL;
                                  VAR NewState:TOKEN_GROUPS;BufferLength:ULONG;
                                  VAR PreviousState:TOKEN_GROUPS;
                                  VAR ReturnLength:ULONG):BOOL;
                  APIENTRY;  'KERNEL32' name 'AdjustTokenGroups';
       FUNCTION PrivilegeCheck(ClientToken:HANDLE;
                               VAR RequiredPrivileges:PRIVILEGE_SET;
                               VAR pfResult:BOOL):BOOL;
                  APIENTRY;  'KERNEL32' name 'PrivilegeCheck';
       FUNCTION AccessCheckAndAuditAlarm(CONST SubsystemName:CSTRING;
                                         VAR HandleId;
                                         VAR ObjectTypeName,ObjectName:CSTRING;
                                         VAR SecurityDescriptor:SECURITY_DESCRIPTOR;
                                         DesiredAccess:ULONG;
                                         VAR GenericMapping:GENERIC_MAPPING;
                                         ObjectCreation:BOOL;
                                         VAR GrantedAccess:ULONG;
                                         VAR AccessStatus,pfGenerateOnClose:BOOL):BOOL;
                  APIENTRY;  'KERNEL32' name 'AccessCheckAndAuditAlarmA';
       FUNCTION ObjectOpenAuditAlarm(CONST SubSystemName:CSTRING;VAR HandleId;
                                     VAR ObjectTypeName,ObjectName:CSTRING;
                                     VAR pSecurityDescriptor:SECURITY_DESCRIPTOR;
                                     ClientToken:HANDLE;
                                     DesiredAccess,GrantedAccess:ULONG;
                                     VAR Privileges:PRIVILEGE_SET;
                                     ObjectCreation,AccessGranted:BOOL;
                                     VAR GenerateOnClose:BOOL):BOOL;
                  APIENTRY;  'KERNEL32' name 'ObjectOpenAuditAlarmA';
       FUNCTION ObjectPrivilegeAuditAlarm(CONST SubsystemName:CSTRING;
                                          VAR HandleId;ClientToken:HANDLE;
                                          DesiredAccess:ULONG;
                                          VAR Privileges:PRIVILEGE_SET;
                                          AccessGranted:BOOL):BOOL;
                  APIENTRY;  'KERNEL32' name 'ObjectPrivilegeAuditAlarmA';
       FUNCTION ObjectCloseAuditAlarm(CONST SubsystemName:CSTRING;
                                      VAR HandleId;GenerateOnClose:BOOL):BOOL;
                  APIENTRY;  'KERNEL32' name 'ObjectCloseAuditAlarmA';
       FUNCTION PrivilegedServiceAuditAlarm(CONST SubsystemName,ServiceName:CSTRING;
                                    ClientToken:HANDLE;
                                    VAR Privileges:PRIVILEGE_SET;
                                    AccessGranted:BOOL):BOOL;
                  APIENTRY;  'KERNEL32' name 'PrivilegedServiceAuditAlarmA';
       FUNCTION IsValidSid(VAR pSid:SID):BOOL;
                  APIENTRY;  'KERNEL32' name 'IsValidSid';
       FUNCTION EqualSid(VAR pSid1,pSid2:SID):BOOL;
                  APIENTRY;  'KERNEL32' name 'EqualSid';
       FUNCTION EqualPrefixSid(VAR pSid1,pSid2:SID):BOOL;
                  APIENTRY;  'KERNEL32' name 'EqualPrefixSid';
       FUNCTION GetSidLengthRequired(nSubAuthorityCount:BYTE):ULONG;
                  APIENTRY;  'KERNEL32' name 'GetSidLengthRequired';
       FUNCTION AllocateAndInitializeSid(VAR pIdentifierAuthority:SID_IDENTIFIER_AUTHORITY;
                        nSubAuthorityCount:BYTE;
                        nSubAuthority0,nSubAuthority1,nSubAuthority2:ULONG;
                        nSubAuthority3,nSubAuthority4,nSubAuthority5:ULONG;
                        nSubAuthority6,nSubAuthority7:ULONG;
                        VAR pSid:PSID):BOOL;
                  APIENTRY;  'KERNEL32' name 'AllocateAndInitializeSid';
       FUNCTION FreeSid(VAR pSid:SID):POINTER;
                  APIENTRY;  'KERNEL32' name 'FreeSid';
       FUNCTION InitializeSid(VAR pIdentifierAuthority:SID_IDENTIFIER_AUTHORITY;
                              nSubAuthorityCount:BYTE):BOOL;
                  APIENTRY;  'KERNEL32' name 'InitializeSid';
       FUNCTION GetSidIdentifierAuthority(VAR pSid:SID):PSID_IDENTIFIER_AUTHORITY;
                  APIENTRY;  'KERNEL32' name 'GetSidIdentifierAuthority';
       FUNCTION GetSidSubAuthority(VAR pSid:SID;nSubAuthority:ULONG):PULONG;
                  APIENTRY;  'KERNEL32' name 'GetSidSubAuthority';
       FUNCTION GetSidSubAuthorityCount(VAR pSid:SID):PBYTE;
                  APIENTRY;  'KERNEL32' name 'GetSidSubAuthorityCount';
       FUNCTION GetLengthSid(VAR pSid:SID):ULONG;
                  APIENTRY;  'KERNEL32' name 'GetLengthSid';
       FUNCTION CopySid(nDestinationSidLength:ULONG;
                        VAR pDestinationSid,pSourceSid:SID):BOOL;
                  APIENTRY;  'KERNEL32' name 'CopySid';
       FUNCTION AreAllAccessesGranted(GrantedAccess,DesiredAccess:ULONG):BOOL;
                  APIENTRY;  'KERNEL32' name 'AreAllAccessesGranted';
       FUNCTION AreAnyAccessesGranted(GrantedAccess,DesiredAccess:ULONG):BOOL;
                  APIENTRY;  'KERNEL32' name 'AreAnyAccessesGranted';
       PROCEDURE MapGenericMask(VAR AccessMask:ULONG;VAR GenericMapping:GENERIC_MAPPING);
                  APIENTRY;  'KERNEL32' name 'MapGenericMask';
       FUNCTION IsValidAcl(VAR pAcl:ACL):BOOL;
                  APIENTRY;  'KERNEL32' name 'IsValidAcl';
       FUNCTION InitializeAcl(VAR pAcl:ACL;nAclLength,deAclRevision:ULONG):BOOL;
                  APIENTRY;  'KERNEL32' name 'InitializeAcl';
       FUNCTION GetAclInformation(VAR pAcl:ACL;VAR pAclInformation;
                                  nAclInformationlength:ULONG;
                                  dwAclInformationClass:ACL_INFORMATION_CLASS):BOOL;
                  APIENTRY;  'KERNEL32' name 'GetAclInformation';
       FUNCTION SetAclInformation(VAR pAcl:ACL;VAR pAclInformation;
                                  nAclInformationLength:ULONG;
                                  dwAclInformationClass:ACL_INFORMATION_CLASS):BOOL;
                  APIENTRY;  'KERNEL32' name 'SetAclInformation';
       FUNCTION AddAce(VAR pACL:ACL;dwAceRevision,dwStartingAceIndex:ULONG;
                       VAR pAceList;nAceListLength:ULONG):BOOL;
                  APIENTRY;  'KERNEL32' name 'AddAce';
       FUNCTION DeleteAce(VAR pAcl:ACL;deAceIndex:ULONG):BOOL;
                  APIENTRY;  'KERNEL32' name 'DeleteAce';
       FUNCTION GetAce(VAR pAcl:ACL;dwAceIndex:ULONG;VAR pAce:POINTER):BOOL;
                  APIENTRY;  'KERNEL32' name 'GetAce';
       FUNCTION AddAccessAllowedAce(VAR pAcl:ACL;dwAceRevision,AcessMask:ULONG;
                                    VAR pSid:SID):BOOL;
                  APIENTRY;  'KERNEL32' name 'AddAccessAllowedAce';
       FUNCTION AddAccessDeniedAce(VAR pAcl:ACL;dwAceRevision,dwAccessMask:ULONG;
                                   VAR pSid:SID):BOOL;
                  APIENTRY;  'KERNEL32' name 'AddAccessDeniedAce';
       FUNCTION AddAuditAccessAce(VAR pAcl:ACL;dwAceRevision,dwAccessMask:ULONG;
                                  VAR pSid:SID):BOOL;
                  APIENTRY;  'KERNEL32' name 'AddAuditAccessAce';
       FUNCTION FindFirstFreeAce(VAR pAcl:ACL;VAR pAce:POINTER):BOOL;
                  APIENTRY;  'KERNEL32' name 'FindFirstFreeAce';
       FUNCTION InitializeSecurityDescriptor(VAR pSecurityDescriptor:SECURITY_DESCRIPTOR;
                              dwRevision:ULONG):BOOL;
                  APIENTRY;  'KERNEL32' name 'InitializeSecurityDescriptor';
       FUNCTION IsValidSecurityDescriptor(VAR pSecurityDescriptor:SECURITY_DESCRIPTOR):BOOL;
                  APIENTRY;  'KERNEL32' name 'IsValidSecurityDescriptor';
       FUNCTION GetSecurityDescriptorLength(VAR pSecurityDesciptor:SECURITY_DESCRIPTOR):ULONG;
                  APIENTRY;  'KERNEL32' name 'GetSecurityDescriptorLength';
       FUNCTION GetSecurityDescriptorControl(VAR pSecurityDescriptor:SECURITY_DESCRIPTOR;
                                VAR pControl:SECURITY_DESCRITOR_CONTROL;
                                VAR lpdwRevision:ULONG):BOOL;
                  APIENTRY;  'KERNEL32' name 'GetSecurityDescriptorControl';
       FUNCTION SetSecurityDescriptorDacl(VAR pSecurityDescriptor:SECURITY_DESCRIPTOR;
                                           bDaclPresent:BOOL;VAR pDacl:ACL;
                                           bDaclDefaulted:BOOL):BOOL;
                  APIENTRY;  'KERNEL32' name 'SetSecurityDescriptorDacl';
       FUNCTION GetSecurityDescriptorDacl(VAR pSecurityDescriptor:SECURITY_DESCRIPTOR;
                                          VAR lpbDaclPresent:BOOL;
                                          VAR pDacl:PACL;VAR lpbDaclDefaulted:BOOL):BOOL;
                  APIENTRY;  'KERNEL32' name 'GetSecurityDescriptorDacl';
       FUNCTION SetSecurityDescriptorSacl(VAR pSecurityDescriptor:SECURITY_DESCRIPTOR;
                                          bSaclPresent:BOOL;VAR pSacl:ACL;
                                          bSaclDefaulted:BOOL):BOOL;
                  APIENTRY;  'KERNEL32' name 'SetSecurityDescriptorSacl';
       FUNCTION GetSecurityDescriptorSacl(VAR pSecurityDescriptor:SECURITY_DESCRIPTOR;
                                          VAR lpbSaclPresent:BOOL;VAR pSacl:PACL;
                                          VAR lpbSaclDefaulted:BOOL):BOOL;
                  APIENTRY;  'KERNEL32' name 'GetSecurityDescriptorSacl';
       FUNCTION SetSecurityDescriptorOwner(VAR pSecurityDescriptor:SECURITY_DESCRIPTOR;
                                           VAR pOwner:SID;bOwnerDefaulted:BOOL):BOOL;
                  APIENTRY;  'KERNEL32' name 'SetSecurityDescriptorOwner';
       FUNCTION GetSecurityDescriptorOwner(VAR pSecurityDescriptor:SECURITY_DESCRIPTOR;
                                           VAR pOwner:PSID;VAR lpbOwnerDefaulted:BOOL):BOOL;
                  APIENTRY;  'KERNEL32' name 'GetSecurityDescriptorOwner';
       FUNCTION SetSecurityDescriptorGroup(VAR pSecurityDescriptor:SECURITY_DESCRIPTOR;
                                           VAR pGroup:SID;bGroupDefaulted:BOOL):BOOL;
                  APIENTRY;  'KERNEL32' name 'SetSecurityDescriptorGroup';
        FUNCTION GetSecurityDescriptorGroup(VAR pSecurityDescriptor:SECURITY_DESCRIPTOR;
                                            VAR pGroup:SID;VAR lpGroupDefaulted:BOOL):BOOL;
                  APIENTRY;  'KERNEL32' name 'GetSecurityDescriptorGroup';
        FUNCTION CreatePrivateObjectSecurity(VAR ParentDescriptor,CreatorDescritor:SECURITY_DESCRIPTOR;
                                             VAR NewDescriptor:PSECURITY_DESCRIPTOR;
                                             IsDirectoryObject:BOOL;Token:HANDLE;
                                             VAR GenericMapping:GENERIC_MAPPING):BOOL;
                  APIENTRY;  'KERNEL32' name 'CreatePrivateObjectSecurity';
        FUNCTION SetPrivateObjectSecurity(SecurityInformation:SECURITY_INFORMATION;
                                          VAR ModificationDescriptor:SECURITY_DESCRIPTOR;
                                          VAR ObjectsSecurityDescriptor:PSECURITY_DESCRIPTOR;
                                          VAR GenericMapping:GENERIC_MAPPING;
                                          Token:HANDLE):BOOL;
                  APIENTRY;  'KERNEL32' name 'SetPrivateObjectSecurity';
        FUNCTION GetPrivateObjectSecurity(VAR ObjectDescriptor:SECURITY_DESCRIPTOR;
                                          SecurityInformation:SECURITY_INFORMATION;
                                          VAR ResultantDescriptor:SECURITY_DESCRIPTOR;
                                          DescriptorLength:LONGWORD;VAR ReturnLength:LONGWORD):BOOL;
                  APIENTRY;  'KERNEL32' name 'GetPrivateObjectSecurity';
        FUNCTION DestroyPrivateObjectSecurity(VAR ObjectDescriptor:PSECURITY_DESCRIPTOR):BOOL;
                  APIENTRY;  'KERNEL32' name 'DestroyPrivateObjectSecurity';
        FUNCTION MakeSelfRelativeSD(VAR pAbsoluteSecurityDescriptor,pSelfRelativeSecurityDescriptor:SECURITY_DESCRIPTOR;
                                    VAR lpdwBufferLength:LONGWORD):BOOL;
                  APIENTRY;  'KERNEL32' name 'MakeSelfRelativeSD';
        FUNCTION MakeAbsoluteSD(VAR pSelfRelativeSecurityDescriptor,pAbsoluteSecurityDescriptor:SECURITY_DESCRIPTOR;
                                VAR lpdwAbsoluteSecurityDescriptorSize:LONGWORD;VAR pDacl:ACL;
                                VAR lpdwDaclSize:LONGWORD;VAR pSacl:ACL;VAR lpdwSaclSize:LONGWORD;
                                VAR pOwner:SID;VAR lpdwOwnerSize:LONGWORD;VAR pPrimaryGroup:SID;
                                VAR lpdwPrimaryGroupSize:LONGWORD):BOOL;
                  APIENTRY;  'KERNEL32' name 'MakeAbsoluteSD';
        FUNCTION SetFileSecurity(CONST lpFileName:CSTRING;SecurityInformation:SECURITY_INFORMATION;
                                 VAR pSecurityDescriptor:SECURITY_DESCRIPTOR):BOOL;
                  APIENTRY;  'KERNEL32' name 'SetFileSecurityA';
        FUNCTION GetFileSecurity(CONST lpFileName:CSTRING;SecurityInformation:SECURITY_INFORMATION;
                                 VAR pSecurityDescriptor:SECURITY_DESCRIPTOR;nLength:LONGWORD;
                                 VAR lpnLengthNeeded:LONGWORD):BOOL;
                  APIENTRY;  'KERNEL32' name 'GetFileSecurityA';
        FUNCTION SetKernelObjectSecurity(aHandle:HANDLE;SecurityInformation:SECURITY_INFORMATION;
                                         VAR pSecurityDescriptor:SECURITY_DESCRIPTOR):BOOL;
                  APIENTRY;  'KERNEL32' name 'SetKernelObjectSecurity';
        FUNCTION FindFirstChangeNotification(CONST lpPathName:CSTRING;bWatchSubTree:BOOL;
                                             dwNotifyFilter:LONGWORD):HANDLE;
                  APIENTRY;  'KERNEL32' name 'FindFirstChangeNotificationA';
        FUNCTION FindNextChangeNotification(hChangeHandle:HANDLE):BOOL;
                  APIENTRY;  'KERNEL32' name 'FindNextChangeNotification';
        FUNCTION FindCloseChangeNotification(hChangeHandle:HANDLE):BOOL;
                  APIENTRY;  'KERNEL32' name 'FindCloseChangeNotification';}
        FUNCTION VirtualLock(VAR lpAdress;dwSize:LONGWORD):BOOL;
                  APIENTRY;  'KERNEL32' name 'VirtualLock';
        FUNCTION VirtualUnlock(VAR lpAdress;dwSize:LONGWORD):BOOL;
                  APIENTRY;  'KERNEL32' name 'VirtualUnlock';
        FUNCTION MapViewOfFileEx(hFileMappingObject:HANDLE;dwDesiredAccess,dwFileOffsetHigh,
                                 dwFileOffsetLow,dwNumberOfBytesToMap:LONGWORD;
                                 VAR lpBaseAddress):POINTER;
                  APIENTRY;  'KERNEL32' name 'MapViewOfFileEx';
        FUNCTION SetPriorityClass(hProcess:HANDLE;dwPriorityClass:LONGWORD):BOOL;
                  APIENTRY;  'KERNEL32' name 'SetPriorityClass';
        FUNCTION GetPriorityClass(hProcess:HANDLE):LONGWORD;
                  APIENTRY;  'KERNEL32' name 'GetPriorityClass';
        FUNCTION IsBadReadPtr(lp:POINTER;ucb:LONGWORD):BOOL;
                  APIENTRY;  'KERNEL32' name 'IsBadReadPtr';
        FUNCTION IsBadWritePtr(lp:POINTER;ucb:LONGWORD):BOOL;
                  APIENTRY;  'KERNEL32' name 'IsBadWritePtr';
        FUNCTION IsBadHugeReadPtr(lp:POINTER;ucb:LONGWORD):BOOL;
                  APIENTRY;  'KERNEL32' name 'IsBadHugeReadPtr';
        FUNCTION IsBadHugeWritePtr(lp:POINTER;ucb:LONGWORD):BOOL;
                  APIENTRY;  'KERNEL32' name 'IsBadHugeWritePtr';
        FUNCTION IsBadCodePtr(lpfn:POINTER):BOOL;
                  APIENTRY;  'KERNEL32' name 'IsBadCodePtr';
        FUNCTION IsBadStringPtr(CONST lpsz:CSTRING;ucchMax:LONGWORD):BOOL;
                  APIENTRY;  'KERNEL32' name 'IsBadStringPtrA';
        {FUNCTION LookupAccountSid(CONST lpSystemName:CSTRING;VAR aSid:SID;VAR Name:CSTRING;
                                   VAR cbName:LONGWORD;VAR ReferencedDomainName:CSTRING;
                                   VAR cbReferencedDomainName:LONGWORD;VAR peUse:SID_NAME_USE):BOOL;
                  APIENTRY;  'KERNEL32' name 'LookupAccountSidA';
        FUNCTION LookupAccountName(CONST lpSystemName:CSTRING;lpAccountName:CSTRING;VAR aSid:SID;
                                   VAR cbSid:LONGWORD;VAR ReferencedDomainName:CSTRING;
                                   VAR cbReferencedDomainName:LONGWORD;VAR peUse:SID_NAME_USE):BOOL;
                  APIENTRY;  'KERNEL32' name 'LookupAccountNameA';
        FUNCTION LookupPrivilegeValue(CONST lpSystemName:CSTRING;CONST lpName:CSTRING;VAR alpLuid:LUID):BOOL;
                  APIENTRY;  'KERNEL32' name 'LookupPrivilegeValueA';
        FUNCTION LookupPrivilegeName(CONST lpSystemName:CSTRING;VAR alpLuid:LUID;VAR lpName:CSTRING;
                                      VAR cbName:LONGWORD):BOOL;
                  APIENTRY;  'KERNEL32' name 'LookupPrivilegeNameA';
        FUNCTION LookupPrivilegeDisplayName(CONST lpSystemName,lpName:CSTRING;VAR lpDisplayName:CSTRING;
                                            VAR cbDisplayName,lpLanguageId:LONGWORD):BOOL;
                  APIENTRY;  'KERNEL32' name 'LookupPrivilegeDisplayNameA';
        FUNCTION AllocateLocallyUniqueId(VAR aLuid:LUID):BOOL;
                  APIENTRY;  'KERNEL32' name 'AllocateLocallyUniqueId';
        FUNCTION BuildCommDCB(CONST lpDef:CSTRING;VAR alpDCB:DCB):BOOL;
                  APIENTRY;  'KERNEL32' name 'BuildCommDCBA';
        FUNCTION BuildCommDCBAndTimeouts(CONST lpDef:CSTRING;VAR alpDCB:DCB;VAR alpCommTimeOuts:COMMTIMEOUTS):BOOL;
                  APIENTRY;  'KERNEL32' name 'BuildCommDCBAndTimeoutsA';
        FUNCTION CommConfigDialog(CONST lpszName:CSTRING;ahWnd:HWND;VAR lpCC:COMMCONFIG):BOOL;
                  APIENTRY;  'KERNEL32' name 'CommConfigDialogA';
        FUNCTION GetDefaultCommConfig(CONST lpszName:CSTRING;VAR lpCC:COMMCONFIG;VAR lpdwSize:LONGWORD):BOOL;
                  APIENTRY;  'KERNEL32' name 'GetDefaultCommConfigA';
        FUNCTION SetDefaultCommConfig(CONST lpszName:CSTRING;VAR lpCC:COMMCONFIG;dwSize:LONGWORD):BOOL;
                  APIENTRY;  'KERNEL32' name 'SetDefaultCommConfigA';}
        FUNCTION GetComputerName(VAR lpBuffer:CSTRING;VAR nSize:LONGWORD):BOOL;
                  APIENTRY;  'KERNEL32' name 'GetComputerNameA';
        FUNCTION SetComputerName(CONST lpComputerName:CSTRING):BOOL;
                  APIENTRY;  'KERNEL32' name 'SetComputerNameA';
        FUNCTION GetUserName(VAR lpBuffer:CSTRING;VAR nSize:LONGWORD):BOOL;
                  APIENTRY;  'KERNEL32' name 'GetUserNameA';
        FUNCTION QueryPerformanceCounter(VAR lpPerformanceCount:LARGE_INTEGER):BOOL;
                  APIENTRY;  'KERNEL32' name 'QueryPerformanceCounter';
        FUNCTION QueryPerformanceFrequency(VAR lpFrequency:LARGE_INTEGER):BOOL;
                  APIENTRY;  'KERNEL32' name 'QueryPerformanceFrequency';
        FUNCTION GetVersionEx(lpVersionInformation:OSVERSIONINFO):BOOL;
                  APIENTRY;  'KERNEL32' name 'GetVersionExA';
        {$ENDIF}




        {$IFDEF Os2}
        FUNCTION InterlockedIncrement(VAR lpAppend:LONG):LONG;
                   APIENTRY;  'PMWINX' index 423;
        FUNCTION InterlockedDecrement(VAR lpAddend:LONG):LONG;
                   APIENTRY;  'PMWINX' index 421;
        FUNCTION InterlockedExchange(VAR Target:LONG;Value:LONG):LONG;
                   APIENTRY;  'PMWINX' index 422;
        {FUNCTION FreeResource(hResData:HGLOBAL):BOOL;
                   APIENTRY;  'PMWINX' index'FreeResource'; not supported}
        FUNCTION LockResource(hResData:HGLOBAL):POINTER;
                   APIENTRY;  'PMWINX' index 476;
        FUNCTION FreeLibrary(hLibModule:HINSTANCE):BOOL;
                   APIENTRY;  'PMWINX' index 223;
        {PROCEDURE FreeLibraryAndExitThread(hLibModule:HMODULE;dwExitCode:ULONG);
                   APIENTRY;  'PMWINX' index'FreeLibraryAndExitThread'; not supported}
        {FUNCTION DisableThreadLibraryCalls(hLibModule:HMODULE):BOOL;
                   APIENTRY;  'PMWINX' index'DisableThreadLibraryCalls'; not supported}
        FUNCTION GetProcAddress(hModule:HINSTANCE;CONST lpProcName:CSTRING):POINTER;
                   APIENTRY;  'PMWINX' index 341;
        {FUNCTION GetVersion:ULONG;
                   APIENTRY;  'PMWINX' index'GetVersion'; not supported}
        FUNCTION GlobalAlloc(uFlags:ULONG;dwBytes:ULONG):HGLOBAL;
                   APIENTRY;  'PMWINX' index 396;
        FUNCTION GlobalReAlloc(hMem:HGLOBAL;dwBytes:ULONG;uFlags:ULONG):HGLOBAL;
                   APIENTRY;  'PMWINX' index 406;
        FUNCTION GlobalSize(hMem:HGLOBAL):ULONG;
                   APIENTRY;  'PMWINX' index 407;
        FUNCTION GlobalFlags(hMem:HGLOBAL):ULONG;
                   APIENTRY;  'PMWINX' index 400;
        FUNCTION GlobalLock(hMem:HGLOBAL):POINTER;
                   APIENTRY;  'PMWINX' index 404;
        FUNCTION GlobalHandle(pMem:POINTER):HGLOBAL;
                   APIENTRY;  'PMWINX' index 403;
        FUNCTION GlobalUnlock(hMem:HGLOBAL):BOOL;
                   APIENTRY;  'PMWINX' index 408;
        FUNCTION GlobalFree(hMem:HGLOBAL):HGLOBAL;
                   APIENTRY;  'PMWINX' index 401;
        {FUNCTION GlobalCompact(dwMinFree:ULONG):ULONG;
                   APIENTRY;  'PMWINX' index'GlobalCompact'; not supported}
        {PROCEDURE GlobalFix(hMem:HGLOBAL);
                   APIENTRY;  'PMWINX' index'GlobalFix'; not supported}
        {PROCEDURE GlobalUnfix(hMem:HGLOBAL);
                   APIENTRY;  'PMWINX' index'GlobalUnfix'; not supported}
        {FUNCTION GlobalWire(hMem:HGLOBAL):POINTER;
                   APIENTRY;  'PMWINX' index'GlobalWire'; not supported}
        {FUNCTION GlobalUnWire(hMem:HGLOBAL):BOOL;
                   APIENTRY;  'PMWINX' index'GlobalUnWire'; not supported}
        PROCEDURE GlobalMemoryStatus(VAR lpBuffer:MEMORYSTATUS);
                   APIENTRY;  'PMWINX' index 405;
        FUNCTION LocalAlloc(uFlags:ULONG;uBytes:ULONG):HLOCAL;
                   APIENTRY;  'PMWINX' index 465;
        FUNCTION LocalReAlloc(hMem:HLOCAL;uBytes:ULONG;uFlags:ULONG):HLOCAL;
                   APIENTRY;  'PMWINX' index 472;
        FUNCTION LocalLock(hMem:HLOCAL):POINTER;
                   APIENTRY;  'PMWINX' index 471;
        FUNCTION LocalHandle(pMem:POINTER):HLOCAL;
                   APIENTRY;  'PMWINX' index 470;
        FUNCTION LocalUnlock(hMem:HLOCAL):BOOL;
                   APIENTRY;  'PMWINX' index 474;
        FUNCTION LocalSize(hMem:HLOCAL):ULONG;
                   APIENTRY;  'PMWINX' index 473;
        FUNCTION LocalFlags(hMem:HLOCAL):ULONG;
                   APIENTRY;  'PMWINX' index 468;
        FUNCTION LocalFree(hMem:HLOCAL):HLOCAL;
                   APIENTRY;  'PMWINX' index 469;
        {FUNCTION LocalShrink(hMem:HLOCAL;cbNewSize:ULONG):ULONG;
                   APIENTRY;  'PMWINX' index'LocalShrink'; not supported}
        {FUNCTION LocalCompact(uMinFree:ULONG):ULONG;
                   APIENTRY;  'PMWINX' index'LocalCompact'; not supported}
        {FUNCTION FlushInstructionCache(hProcess:HANDLE;lpBaseAddress:POINTER;
                                       dwSize:ULONG):BOOL;
                   APIENTRY;  'PMWINX' index'FlushInstructionCache'; not supprted}
        {FUNCTION VirtualAlloc(lpAddress:POINTER;dwSize:ULONG;flAllocationType:ULONG;
                              flProtect:ULONG):POINTER;
                   APIENTRY;  'PMWINX' index'VirtualAlloc'; not supported}
        {FUNCTION VirtualFree(lpAddress:POINTER;dwSize:ULONG;dwFreeType:ULONG):BOOL;
                   APIENTRY;  'PMWINX' index'VirtualFree'; not supported}
        {FUNCTION VirtualProtect(lpAddress:POINTER;dwSize:ULONG;flNewProtect:ULONG;
                                VAR lpflOldProtect:ULONG):BOOL;
                   APIENTRY;  'PMWINX' index'VirtualProtect'; not supported}
        {FUNCTION VirtualQuery(lpAddress:POINTER;VAR lpBuffer:MEMORY_BASIC_INFORMATION;
                              dwLength:ULONG):ULONG;
                   APIENTRY;  'PMWINX' index'VirtualQuery'; not supported}
        {FUNCTION VirtualProtectEx(hProcess:HANDLE;lpAddress:POINTER;dwSize:ULONG;
                                  flNewProtect:ULONG;VAR lpflOldProtect:ULONG):BOOL;
                   APIENTRY;  'PMWINX' index'VirtualProtectEx'; not supported}
        {FUNCTION VirtualQueryEx(hProcess:HANDLE;lpAddress:POINTER;
                                VAR lpBuffer:MEMORY_BASIC_INFORMATION;
                                dwLength:ULONG):ULONG;
                   APIENTRY;  'PMWINX' index'VirtualQueryEx'; not supported}
        FUNCTION HeapCreate(flOptions:ULONG;dwInitialSize:ULONG;
                            dwMaximumSize:ULONG):HANDLE;
                   APIENTRY;  'PMWINX' index 410;
        FUNCTION HeapDestroy(hHeap:HANDLE):BOOL;
                   APIENTRY;  'PMWINX' index 411;
        FUNCTION HeapAlloc(hHeap:HANDLE;dwFlags,dwBytes:ULONG):POINTER;
                   APIENTRY;  'PMWINX' index 409;
        FUNCTION HeapReAlloc(hHeap:HANDLE;dwFlags:ULONG;lpMem:POINTER;
                             dwBytes:ULONG):POINTER;
                   APIENTRY;  'PMWINX' index 413;
        FUNCTION HeapFree(hHeap:HANDLE;dwFlags:ULONG;lpMem:POINTER):BOOL;
                   APIENTRY;  'PMWINX' index 412;
        FUNCTION HeapSize(hHeap:HANDLE;dwFlags:ULONG;lpMem:POINTER):ULONG;
                   APIENTRY;  'PMWINX' index 13; {?}
        {FUNCTION HeapValidate(hHeap:HANDLE;dwFlags:ULONG;lpMem:POINTER):BOOL;
                   APIENTRY;  'PMWINX' index'HeapValidate'; not supported}
        {FUNCTION HeapCompact(hHeap:HANDLE;dwFlags:ULONG):ULONG;
                   APIENTRY;  'PMWINX' index'HeapCompact'; not supported}
        {FUNCTION GetProcessHeap:HANDLE;
                   APIENTRY;  'PMWINX' index'GetProcessHeap'; not supported}
        {FUNCTION GetProcessHeaps(NumberOfHeaps:ULONG;VAR ProcessHeaps:HANDLE):ULONG;
                   APIENTRY;  'PMWINX' index'GetProcessHeaps'; not supported}
        {FUNCTION HeapLock(hHeap:HANDLE):BOOL;
                   APIENTRY;  'PMWINX' index'HeapLock'; not supported}
        {FUNCTION HeapUnlock(hHeap:HANDLE):BOOL;
                   APIENTRY;  'PMWINX' index'HeapUnlock'; not supported}
        {FUNCTION HeapWalk(hHeap:HANDLE;VAR lpEntry:PROCESS_HEAP_ENTRY):BOOL;
                   APIENTRY;  'PMWINX' index'HeapWalk'; not supported}
        {FUNCTION GetBinaryType(CONST lpApplicationName:CSTRING;
                               VAR lpBinaryType:ULONG):BOOL;
                   APIENTRY;  'PMWINX' index'GetBinaryTypeA'; not supported}
        {FUNCTION GetShortPathName(CONST lpszLongPath:CSTRING;
                                  VAR lpszShortPath:CSTRING;cchBuffer:ULONG):ULONG;
                   APIENTRY;  'PMWINX' index'GetShortPathNameA'; not supported}
        {FUNCTION GetProcessAffinityMask(hProcess:HANDLE;VAR lpProcessAffinityMask,
                                        lpSystemAffinityMask:ULONG):BOOL;
                   APIENTRY;  'PMWINX' index'GetProcessAffinityMask'; not supported}
        {FUNCTION GetProcessTimes(hProcess:HANDLE;VAR lpCreationTime,
                                 lpExitTime,lpKernelTime,lpUserTime:FILETIME):BOOL;
                   APIENTRY;  'PMWINX' index'GetProcessTimes'; not supported}
        {FUNCTION GetProcessWorkingSetSize(hProcess:HANDLE;VAR Min,Max:ULONG):BOOL;
                   APIENTRY;  'PMWINX' index'GetProcessWorkingSetSize'; not supported}
        {FUNCTION SetProcessWorkingSetSize(hProcess:HANDLE;Min,Max:ULONG):BOOL;
                   APIENTRY;  'PMWINX' index'SetProcessWorkingSetSize'; not supported}
        FUNCTION OpenProcess(dwDesiredAccess:ULONG;bInheritHandle:BOOL;
                             dwProcessId:ULONG):HANDLE;
                   APIENTRY;  'PMWINX' index 506;
        FUNCTION GetCurrentProcess:HANDLE;
                   APIENTRY;  'PMWINX' index 256;
        FUNCTION GetCurrentProcessId:ULONG;
                   APIENTRY;  'PMWINX' index 257;
        PROCEDURE ExitProcess(uExitCode:ULONG);
                   APIENTRY;  'PMWINX' index 192;
        FUNCTION TerminateProcess(hProcess:HANDLE;uExitCode:ULONG):BOOL;
                   APIENTRY;  'PMWINX' index 687;
        FUNCTION GetExitCodeProcess(hProcess:HANDLE;VAR lpExitCode:ULONG):BOOL;
                   APIENTRY;  'PMWINX' index 1005;
        PROCEDURE FatalExit(ExitCode:LONGINT);
                   APIENTRY;  'PMWINX' index 202;
        FUNCTION GetEnvironmentStrings:PChar;
                   APIENTRY;  'PMWINX' index 282;
        {FUNCTION FreeEnvironmentStrings(p:PChar):BOOL;
                   APIENTRY;  'PMWINX' index'FreeEnvironmentStringsA'; not supported}
        {PROCEDURE RaiseException(dwExceptionCode,dwExceptionFlags:ULONG;
                                 nNumberOfArguments:ULONG;VAR lpArguments);
                   APIENTRY;  'PMWINX' index'RaiseException'; not supported}
        {FUNCTION UnhandledExceptionFilter(VAR ExceptionInfo:EXCEPTION_POINTERS):LONG;
                   APIENTRY;  'PMWINX' index'UnhandledExceptionFilter'; not supported}
        {FUNCTION SetUnhandledExceptionFilter(lpTopLevelFilter:PTOP_LEVEL_EXCEPTION_FILTER):
                                 LPTOP_LEVEL_EXCEPTION_FILTER;
                   APIENTRY;  'PMWINX' index'SetUnhandledExceptionFilter'; not supported}
        FUNCTION CreateThread(VAR ThreadAttrs:SECURITY_ATTRIBUTES;Stack:ULONG;
                              lpStartAddress:LPTHREAD_START_ROUTINE;
                              lpParameter:POINTER;dwCreationFlags:ULONG;
                              VAR lpThreadId:ULONG):HANDLE;
                   APIENTRY;  'PMWINX' index 98;
        {FUNCTION CreateRemoteThread(hProcess:HANDLE;VAR Attrs:SECURITY_ATTRIBUTES;
                                    dwStack:ULONG;lpStartAddr:LPTHREAD_START_ROUTINE;
                                    lpParameter:POINTER;dwCreationFlags:ULONG;
                                    VAR lpThreadId:ULONG):HANDLE;
                   APIENTRY;  'PMWINX' index'CreateRemoteThread'; not supported}
        FUNCTION GetCurrentThread:HANDLE;
                   APIENTRY;  'PMWINX' index 258;
        FUNCTION GetCurrentThreadId:ULONG;
                   APIENTRY;  'PMWINX' index 259;
        {FUNCTION SetThreadAffinityMask(hThread:HANDLE;dwMask:ULONG):ULONG;
                   APIENTRY;  'PMWINX' index'SetThreadAffinityMask'; not supported}
        FUNCTION SetThreadPriority(hThread:HANDLE;nPriority:LONGINT):BOOL;
                   APIENTRY;  'PMWINX' index 651;
        FUNCTION GetThreadPriority(hThread:HANDLE):LONGINT;
                   APIENTRY;  'PMWINX' index 372;
        {FUNCTION GetThreadTimes(hThread:HANDLE;VAR lpCreationTime,
                                lpExitTime,lpKernelTime,lpUserTime:FILETIME):BOOL;
                   APIENTRY;  'PMWINX' index'GetThreadTimes'; not supported}
        PROCEDURE ExitThread(ExitCode:ULONG);
                   APIENTRY;  'PMWINX' index 193;
        FUNCTION TerminateThread(hThread:HANDLE;dwExitCode:ULONG):BOOL;
                   APIENTRY;  'PMWINX' index 688;
        FUNCTION GetExitCodeThread(hThread:HANDLE;VAR lpExitCode:ULONG):BOOL;
                   APIENTRY;  'PMWINX' index 1006;
        FUNCTION GetLastError:ULONG;
                   APIENTRY;  'PMWINX' index 300;
        PROCEDURE SetLastError(dwErrCode:ULONG);
                   APIENTRY;  'PMWINX' index 624;
        FUNCTION GetOverlappedResult(hFile:HANDLE;VAR lpOverlapped:OVERLAPPED;
                                     VAR lpNumberBytes:ULONG;bWait:BOOL):BOOL;
                   APIENTRY;  'PMWINX' index 331;
        {FUNCTION CreateIoCompletionPort(FileHandle:HANDLE;ExistingPort:HANDLE;
                                        CompletionKey,NumberConcThreads:ULONG):HANDLE;
                   APIENTRY;  'PMWINX' index'CreateIoCompletionPort'; not supported}
        {FUNCTION GetQueuedCompletionStatus(CompletionPort:HANDLE;
                                           VAR lpNumber,lpKey:ULONG;
                                           VAR lpOverlapped:OVERLAPPED;
                                           dwMillisecs:ULONG):BOOL;
                   APIENTRY;  'PMWINX' index'GetQueuedCompletionStatus'; not supported}
        {FUNCTION SetErrorMode(uMode:ULONG):ULONG;
                   APIENTRY;  'PMWINX' index'SetErrorMode'; not supported}
        {FUNCTION ReadProcessMemory(hProcess:HANDLE;lpBaseAddress:POINTER;
                                   VAR lpBuffer;nSize:ULONG;
                                   VAR lpNumberOfBytesRead:ULONG):BOOL;
                   APIENTRY;  'PMWINX' index'ReadProcessMemory'; not supported}
        {FUNCTION WriteProcessMemory(hProcess:HANDLE;lpBaseAddress:POINTER;
                                    VAR lpBuffer;nSize:ULONG;
                                    lpNumberOfBytesWritten:ULONG):BOOL;
                   APIENTRY;  'PMWINX' index'WriteProcessMemory'; not supported}
        {FUNCTION GetThreadContext(hThread:HANDLE;VAR lpContext:CONTEXT):BOOL;
                   APIENTRY;  'PMWINX' index'GetThreadContext'; not supported}
        {FUNCTION SetThreadContext(hThread:HANDLE;CONST lpContext:CONTEXT):BOOL;
                   APIENTRY;  'PMWINX' index'SetThreadContext'; not supported}
        FUNCTION SuspendThread(hThread:HANDLE):ULONG;
                   APIENTRY;  'PMWINX' index 681;
        FUNCTION ResumeThread(hThread:HANDLE):ULONG;
                   APIENTRY;  'PMWINX' index 573;
        {PROCEDURE DebugBreak;
                   APIENTRY;  'PMWINX' index'DebugBreak'; not supported}
        {FUNCTION WaitForDebugEvent(VAR lpDebugEvent:DEBUG_EVENT;
                                   dwMilliseconds:ULONG):BOOL;
                   APIENTRY;  'PMWINX' index'WaitForDebugEvent'; not supported}
        {FUNCTION ContinueDebugEvent(dwProcessId,dwThreadId,dwStatus:ULONG):BOOL;
                   APIENTRY;  'PMWINX' index'ContinueDebugEvent'; not supported}
        {FUNCTION DebugActiveProcess(dwProcessId:ULONG):BOOL;
                   APIENTRY;  'PMWINX' index'DebugActiveProcess'; not supported}

        PROCEDURE InitializeCriticalSection(VAR CritSec:CRITICAL_SECTION);
                   APIENTRY;  'PMWINX' index 419;
        PROCEDURE EnterCriticalSection(VAR CritSec:CRITICAL_SECTION);
                   APIENTRY;  'PMWINX' index 175;
        PROCEDURE LeaveCriticalSection(VAR CritSec:CRITICAL_SECTION);
                   APIENTRY;  'PMWINX' index 454;
        PROCEDURE DeleteCriticalSection(VAR CritSec:CRITICAL_SECTION);
                   APIENTRY;  'PMWINX' index 134;
        FUNCTION SetEvent(hEvent:HANDLE):BOOL;
                   APIENTRY;  'PMWINX' index 616;
        FUNCTION ResetEvent(hEvent:HANDLE):BOOL;
                   APIENTRY;  'PMWINX' index 570;
        FUNCTION PulseEvent(hEvent:HANDLE):BOOL;
                   APIENTRY;  'PMWINX' index 534;
        FUNCTION ReleaseSemaphore(hSemaphore:HANDLE;lReleaseCount:LONG;
                                  VAR lpPreviousCount:LONG):BOOL;
                   APIENTRY;  'PMWINX' index 562;
        FUNCTION ReleaseMutex(hMutex:HANDLE):BOOL;
                   APIENTRY;  'PMWINX' index 561;
        FUNCTION WaitForSingleObject(hHandle:HANDLE;dwMilliseconds:ULONG):ULONG;
                   APIENTRY;  'PMWINX' index 711;
        FUNCTION WaitForMultipleObjects(nCount:ULONG;CONST lpHandle:HANDLE;
                                        bWaitAll:BOOL;dwMilliseconds:ULONG):ULONG;
                   APIENTRY;  'PMWINX' index 710;
        PROCEDURE Sleep(dwMilliseconds:ULONG);
                   APIENTRY;  'PMWINX' index 673;
        FUNCTION LoadResource(hModule:HINSTANCE;hResInfo:HRSRC):HGLOBAL;
                   APIENTRY;  'PMWINX' index 5007;
        FUNCTION SizeofResource(hModule:HINSTANCE;hResInfo:HRSRC):ULONG;
                   APIENTRY;  'PMWINX' index 672;
        FUNCTION GlobalDeleteAtom(nAtom:ATOM):ATOM;
                   APIENTRY;  'PMWINX' index 397;
        FUNCTION InitAtomTable(nSize:ULONG):BOOL;
                   APIENTRY;  'PMWINX' index 418;
        FUNCTION DeleteAtom(nAtom:ATOM):ATOM;
                   APIENTRY;  'PMWINX' index 133;
        FUNCTION SetHandleCount(uNumber:ULONG):ULONG;
                   APIENTRY;  'PMWINX' index 623;
        FUNCTION GetLogicalDrives:ULONG;
                   APIENTRY;  'PMWINX' index 303;
        FUNCTION LockFile(hFile:HANDLE;dwFileOffsetLow,dwFileOffsetHigh:ULONG;
                          dwNumbersToLockLow,dwNumbersToLockHigh:ULONG):BOOL;
                   APIENTRY;  'PMWINX' index 475;
        FUNCTION UnlockFile (hFile:HANDLE;dwFileOffsetLow,dwFileOffsetHigh:ULONG;
                          dwNumbersToUnlockLow,dwNumbersToUnlockHigh:ULONG):BOOL;
                   APIENTRY;  'PMWINX' index 702;
        {FUNCTION LockFileEx(hFile:HANDLE;dwFlags,dwReserved:ULONG;
                            nNumberOfBytesToLockLow,nNumberOfBytesToLockHigh:ULONG;
                            VAR lpOverlapped:OVERLAPPED):BOOL;
                   APIENTRY;  'PMWINX' index'LockFileEx'; not supported}
        {FUNCTION UnlockFileEx(hFile:HANDLE;dwFlags,dwReserved:ULONG;
                            nNumberOfBytesToUnlockLow,nNumberOfBytesToUnlockHigh:ULONG;
                            VAR lpOverlapped:OVERLAPPED):BOOL;
                   APIENTRY;  'PMWINX' index'UnlockFileEx'; not supported}
        FUNCTION GetFileInformationByHandle(hFile:HANDLE;
                              VAR lpFileInformation:BY_HANDLE_FILE_INFORMATION):BOOL;
                   APIENTRY;  'PMWINX' index 285;
        FUNCTION GetFileType(hFile:HANDLE):ULONG;
                   APIENTRY;  'PMWINX' index 289;
        FUNCTION GetFileSize(hFile:HANDLE;VAR lpFileSizeHigh:ULONG):ULONG;
                   APIENTRY;  'PMWINX' index 286;
        FUNCTION GetStdHandle(nStdHandle:ULONG):HANDLE;
                   APIENTRY;  'PMWINX' index 1001;
        FUNCTION SetStdHandle(nStdHandle:ULONG;hHandle:HANDLE):BOOL;
                   APIENTRY;  'PMWINX' index 1002;
        FUNCTION WriteFile(hFile:HANDLE;CONST lpBuffer;nNumberOfBytesToWrite:ULONG;
                           VAR lpNumberOfBytesWritten:ULONG;
                           VAR lpOverlapped:OVERLAPPED):BOOL;
                   APIENTRY;  'PMWINX' index 717;
        FUNCTION ReadFile(hFile:HANDLE;VAR lpBuffer;nNumberOfBytesToRead:ULONG;
                          VAR lpNumberOfBytesRead:ULONG;
                          VAR lpOverlapped:OVERLAPPED):BOOL;
                   APIENTRY;  'PMWINX' index 535;
        FUNCTION FlushFileBuffers(hFile:HANDLE):BOOL;
                   APIENTRY;  'PMWINX' index 219;
        {FUNCTION DeviceIoControl(hDevice:HANDLE;dwloControlCode:ULONG;
                                 VAR lpInBuffer;nInBufferSize:ULONG;
                                 VAR lpOutBuffer;nOutBufferSize:ULONG;
                                 VAR lpBytesReturned:ULONG;
                                 VAR lpOverlapped:OVERLAPPED):BOOL;
                   APIENTRY;  'PMWINX' index'DeviceIoControl'; not supported}
        FUNCTION SetEndOfFile(hFile:HANDLE):BOOL;
                   APIENTRY;  'PMWINX' index 613;
        FUNCTION SetFilePointer(hFile:HANDLE;lDistanceToMove:LONG;
                                VAR lpDistanceToMoveHigh:LONG;
                                dwMoveMethod:ULONG):ULONG;
                   APIENTRY;  'PMWINX' index 618;
        FUNCTION FindClose(hFindFile:HANDLE):BOOL;
                   APIENTRY;  'PMWINX' index 210;
        FUNCTION GetFileTime(hFile:HANDLE;VAR lpCreationTime,lpLastAccessTime,
                             lpLastWriteTime:FILETIME):BOOL;
                   APIENTRY;  'PMWINX' index 287;
        FUNCTION SetFileTime(hFile:HANDLE;VAR lpCreationTime,lpLastAccessTime,
                             lpLastWriteTime:FILETIME):BOOL;
                   APIENTRY;  'PMWINX' index 619;
        FUNCTION CloseHandle(hObject:HANDLE):BOOL;
                   APIENTRY;  'PMWINX' index 44;
        FUNCTION DuplicateHandle(hSourceProcessHandle,hSourceHandle:HANDLE;
                                 hTargetProcessHandle:HANDLE;VAR lpTargetHandle:HANDLE;
                                 dwDesiredAccess:ULONG;bInheritHandle:BOOL;
                                 dwOptions:ULONG):BOOL;
                   APIENTRY;  'PMWINX' index 163;
        {FUNCTION GetHandleInformation(hObject:HANDLE;VAR lpdwFlags:ULONG):BOOL;
                   APIENTRY;  'PMWINX' index'GetHandleInformation'; not supported}
        {FUNCTION SetHandleInformation(hObject:HANDLE;dwMask,dwFlags:ULONG):BOOL;
                   APIENTRY;  'PMWINX' index'SetHandleInformation'; not supported}
        FUNCTION LoadModule(CONST lpModuleName:CSTRING;lpParameterBlock:POINTER):ULONG;
                   APIENTRY;  'PMWINX' index 463;
        FUNCTION WinExec(CONST lpCmdLine:CSTRING;uCmdShow:ULONG):ULONG;
                   APIENTRY;  'PMWINX' index 714;
        {FUNCTION BuildCommDCB(VAR lpDef:CSTRING;VAR lpDCB:DCB):BOOL;
                   APIENTRY;  'PMWINX' index'BuildCommDCB';
        FUNCTION BuildCommDCBAndTimeouts(VAR lpDef:CSTRING;VAR lpDCB:DCB;
                                         VAR lpCommTimeouts:COMMTIMEOUTS):BOOL;
                   APIENTRY;  'PMWINX' index'BuildCommDCBAndTimeouts';}
        {FUNCTION ClearCommBreak(hFile:HANDLE):BOOL;
                   APIENTRY;  'PMWINX' index'ClearCommBreak'; not supported}
        {FUNCTION ClearCommError(hFile:HANDLE;VAR lpErrors:ULONG;
                                VAR lpStat:COMSTAT):BOOL;
                   APIENTRY;  'PMWINX' index'ClearCommError';}
        {FUNCTION SetupComm(hFile:HANDLE;dwInQueue,dwOutQueue:ULONG):BOOL;
                   APIENTRY;  'PMWINX' index'SetupComm'; not supported}
        {FUNCTION EscapeCommFunction(hFile:HANDLE;dwFunc:ULONG):BOOL;
                   APIENTRY;  'PMWINX' index'EscapeCommFunction'; not supported}
        {FUNCTION GetCommConfig(hCommDev:HANDLE;VAR lpCC:COMMCONFIG;
                               VAR lpdwSize:ULONG):BOOL;
                   APIENTRY;  'PMWINX' index'GetCommConfig';}
        {FUNCTION GetCommMask(hFile:HANDLE;VAR lpEvtMask:ULONG):BOOL;
                   APIENTRY;  'PMWINX' index'GetCommMask'; not supported}
        {FUNCTION GetCommProperties(hFile:HANDLE;VAR lpCommProp:COMMPROP):BOOL;
                   APIENTRY;  'PMWINX' index'GetCommProperties'; not supported}
        {FUNCTION GetCommModemStatus(hFile:HANDLE;VAR lpModemStat:ULONG):BOOL;
                   APIENTRY;  'PMWINX' index'GetCommModemStatus'; not supported}
        {FUNCTION GetCommState(hFile:HANDLE;VAR lpDCB:DCB):BOOL;
                   APIENTRY;  'PMWINX' index'GetCommState';
        FUNCTION GetCommTimeouts(hFile:HANDLE;VAR lpCommTimeouts:COMMTIMEOUTS):BOOL;
                   APIENTRY;  'PMWINX' index'GetCommTimeouts';
        FUNCTION PurgeComm(hFile:HANDLE;dwFlags:ULONG):BOOL;
                   APIENTRY;  'PMWINX' index'PurgeComm';
        FUNCTION SetCommBreak(hFile:HANDLE):BOOL;
                   APIENTRY;  'PMWINX' index'SetCommBreak';
        FUNCTION SetCommConfig(hCommDev:HANDLE;VAR lpCC:COMMCONFIG;
                               dwSize:ULONG):BOOL;
                   APIENTRY;  'PMWINX' index'SetCommConfig';}
        {FUNCTION SetCommMask(hFile:HANDLE;dwEvtMask:ULONG):BOOL;
                   APIENTRY;  'PMWINX' index'SetCommMask'; not supported}
        {FUNCTION SetCommState(hFile:HANDLE;VAR lpDCB:DCB):BOOL;
                   APIENTRY;  'PMWINX' index'SetCommState';
        FUNCTION SetCommTimeouts(hFile:HANDLE;VAR lpCommTimeouts:COMMTIMEOUTS):BOOL;
                   APIENTRY;  'PMWINX' index'SetCommTimeouts';}
        {FUNCTION TransmitCommChar(hFile:HANDLE;cChar:CHAR):BOOL;
                   APIENTRY;  'PMWINX' index'TransmitCommChar'; not supported}
        {FUNCTION WaitCommEvent(hFile:HANDLE;VAR lpEvtMask:ULONG;
                               VAR lpOverlapped:OVERLAPPED):BOOL;
                   APIENTRY;  'PMWINX' index'WaitCommEvent'; not supported}
        {FUNCTION SetTapePosition(hDevice:HANDLE;dwPositionMethod,dwPartition:ULONG;
                                 dwOffsetLow,dwOffsetHigh:ULONG;bImmediate:BOOL):ULONG;
                   APIENTRY;  'PMWINX' index'SetTapePosition'; not supported}
        {FUNCTION GetTapePosition(hDevice:HANDLE;dwPositionType:ULONG;
                                 VAR lpdwPartition,lpdwOffsetLow,lpdwOffsetHigh:ULONG):ULONG;
                   APIENTRY;  'PMWINX' index'GetTapePosition'; not supported}
        {FUNCTION PrepareTape(hDevice:HANDLE;dwOperation:ULONG;bImmediate:BOOL):ULONG;
                   APIENTRY;  'PMWINX' index'PrepareTape'; not supported}
        {FUNCTION EraseTape(hDevice:HANDLE;dwEraseType:ULONG;bImmediate:BOOL):ULONG;
                   APIENTRY;  'PMWINX' index'EraseTape'; not supported}
        {FUNCTION CreateTapePartition(hDevice:HANDLE;dwPartitionMethod:ULONG;
                                     dwCount,dwSize:ULONG):ULONG;
                   APIENTRY;  'PMWINX' index'CreateTapePartition'; not supported}
        {FUNCTION WriteTapemark(hDevice:HANDLE;dwTapemarkType,dwTapeMarkCount:ULONG;
                               bImmediate:BOOL):ULONG;
                   APIENTRY;  'PMWINX' index'WriteTapemark'; not supported}
        {FUNCTION GetTapeStatus(hDevice:HANDLE):ULONG;
                   APIENTRY;  'PMWINX' index'GetTapeStatus'; not supported}
        {FUNCTION GetTapeParameters(hDevice:HANDLE;dwOperation:ULONG;
                                   VAR lpdwSize:ULONG;VAR lpTapeInformation):ULONG;
                   APIENTRY;  'PMWINX' index'GetTapeParameters'; not supported}
        {FUNCTION SetTapeParameters(hDevice:HANDLE;dwOperation:ULONG;
                                   VAR lpTapeInformation):ULONG;
                   APIENTRY;  'PMWINX' index'SetTapeParameters'; not supported}
        FUNCTION Beep(dwFreq,dwDuration:ULONG):BOOL;
                   APIENTRY;  'PMWINX' index 14;
        {PROCEDURE OpenSound;
                   APIENTRY;  'PMWINX' index'OpenSound'; not supported}
        {PROCEDURE CloseSound;
                   APIENTRY;  'PMWINX' index'CloseSound'; not supported}
        {PROCEDURE StartSound;
                   APIENTRY;  'PMWINX' index'StartSound'; not supported}
        {PROCEDURE StopSound;
                   APIENTRY;  'PMWINX' index'StopSound'; not supported}
        {FUNCTION WaitSoundState(nState:ULONG):ULONG;
                   APIENTRY;  'PMWINX' index'WaitSoundState'; not supported}
        {FUNCTION SyncAllVoices:ULONG;
                   APIENTRY;  'PMWINX' index'SyncAllVoices'; not supported}
        {FUNCTION CountVoiceNotes(nVoice:ULONG):ULONG;
                   APIENTRY;  'PMWINX' index'CountVoiceNotes'; not supported}
        {FUNCTION GetThresholdEvent:LPDWORD;
                   APIENTRY;  'PMWINX' index'GetThresholdEvent'; not supported}
        {FUNCTION GetThresholdStatus:ULONG;
                   APIENTRY;  'PMWINX' index'GetThresholdStatus'; not supported}
        {FUNCTION SetSoundNoise(nSource,nDuration:ULONG):ULONG;
                   APIENTRY;  'PMWINX' index'SetSoundNoise'; not supported}
        {FUNCTION SetVoiceAccent(nVoice,nTempo,nVolume,nMode,nPitch:ULONG):ULONG;
                   APIENTRY;  'PMWINX' index'SetVoiceAccent'; not supported}
        {FUNCTION SetVoiceEnvelope(nVoice,nShape,nRepeat:ULONG):ULONG;
                   APIENTRY;  'PMWINX' index'SetVoiceEnvelope'; not supported}
        {FUNCTION SetVoiceNote(nVoice,nValue,nLength,nCdots:ULONG):ULONG;
                   APIENTRY;  'PMWINX' index'SetVoiceNote'; not supported}
        {FUNCTION SetVoiceQueueSize(nVoice,nBytes:ULONG):ULONG;
                   APIENTRY;  'PMWINX' index'SetVoiceQueueSize'; not supported}
        {FUNCTION SetVoiceSound(nVoice,Frequency,nDuration:ULONG):ULONG;
                   APIENTRY;  'PMWINX' index'SetVoiceSound'; not supported}
        {FUNCTION SetVoiceThreshold(nVoice,nNotes:ULONG):ULONG;
                   APIENTRY;  'PMWINX' index'SetVoiceThreshold'; not supported}
        FUNCTION MulDiv(nNumber,nNumerator,nDenominator:LONGINT):LONGINT;
                   APIENTRY;  'PMWINX' index 494;
        PROCEDURE GetSystemTime(VAR lpSystemTime:SYSTEMTIME);
                   APIENTRY;  'PMWINX' index 361;
        FUNCTION SetSystemTime(CONST lpSystemTime:SYSTEMTIME):BOOL;
                   APIENTRY;  'PMWINX' index 646;
        PROCEDURE GetLocalTime(VAR lpSystemTime:SYSTEMTIME);
                   APIENTRY;  'PMWINX' index 301;
        FUNCTION SetLocalTime(CONST lpSystemTime:SYSTEMTIME):BOOL;
                   APIENTRY;  'PMWINX' index 625;
        {PROCEDURE GetSystemInfo(VAR lpSystemInfo:SYSTEM_INFO);
                   APIENTRY;  'PMWINX' index'GetSystemInfo'; not supported}
        FUNCTION SystemTimeToTzSpecificLocalTime(VAR lpTimeZoneInfo:TIME_ZONE_INFORMATION;
                         VAR lpUniversalTime,lpLocalTime:SYSTEMTIME):BOOL;
                   APIENTRY;  'PMWINX' index 685;
        FUNCTION GetTimeZoneInformation(VAR lpTimeZoneInfo:TIME_ZONE_INFORMATION):ULONG;
                   APIENTRY;  'PMWINX' index 374;
        FUNCTION SetTimeZoneInformation(CONST lpTimeZoneInfo:TIME_ZONE_INFORMATION):BOOL;
                   APIENTRY;  'PMWINX' index 652;
        FUNCTION SystemTimeToFileTime(CONST lpSystemTime:SYSTEMTIME;
                                      VAR lpFileTime:FILETIME):BOOL;
                   APIENTRY;  'PMWINX' index 684;
        FUNCTION FileTimeToLocalFileTime(CONST lpFileTime:FILETIME;
                                         VAR lpLocalFileTime:FILETIME):BOOL;
                   APIENTRY;  'PMWINX' index 204;
        FUNCTION LocalFileTimeToFileTime(CONST lpLocalFileTime:FILETIME;
                                         VAR lpFileTime:FILETIME):BOOL;
                   APIENTRY;  'PMWINX' index 467;
        FUNCTION FileTimeToSystemTime(CONST lpFileTime:FILETIME;
                                      VAR lpSystemTime:SYSTEMTIME):BOOL;
                   APIENTRY;  'PMWINX' index 205;
        FUNCTION CompareFileTime(CONST lpFileTime1,lpFileTime2:FILETIME):LONG;
                   APIENTRY;  'PMWINX' index 49;
        FUNCTION FileTimeToDosDateTime(CONST lpFileTime:FILETIME;
                                       VAR lpFatDate,lpFatTime:WORD):BOOL;
                   APIENTRY;  'PMWINX' index 203;
        FUNCTION DosDateTimeToFileTime(wFatDate,wFatTime:WORD;VAR lpFileTime:FILETIME):BOOL;
                   APIENTRY;  'PMWINX' index 154;
        FUNCTION GetTickCount:ULONG;
                   APIENTRY;  'PMWINX' index 373;
        {FUNCTION SetSystemTimeAdjustment(dwTimeAdjustment:ULONG;
                                         bTimeAdjustmentDisabled:BOOL):BOOL;
                   APIENTRY;  'PMWINX' index'SetSystemTimeAdjustment'; not supported}
        {FUNCTION GetSystemTimeAdjustment(VAR lpTimeAdjustment,lpTimeIncrement:ULONG;
                                         VAR lpTimeAdjustmentDisabled:BOOL):BOOL;
                   APIENTRY;  'PMWINX' index'GetSystemTimeAdjustment'; not supported}
        {FUNCTION FormatMessage(dwFlags:ULONG;VAR lpSource;
                               dwMessageId,dwLanguageId:ULONG;
                               VAR lpBuffer:CSTRING;nSize:ULONG;
                               Arguments:POINTER):ULONG;
                   APIENTRY;  'PMWINX' index'FormatMessageA'; not supported}
        {FUNCTION CreatePipe(VAR hReadPipe,hWritePipe:HANDLE;
                            VAR lpPipeAttributes:SECURITY_ATTRIBUTES;
                            nSize:ULONG):BOOL;
                   APIENTRY;  'PMWINX' index'CreatePipe'; not supported}
        {FUNCTION ConnectNamedPipe(hNamedPipe:HANDLE;VAR lpOverlapped:OVERLAPPED):BOOL;
                   APIENTRY;  'PMWINX' index'ConnectNamedPipe'; not supported}
        {FUNCTION DisconnectNamedPipe(hNamedPipe:HANDLE):BOOL;
                   APIENTRY;  'PMWINX' index'DisconnectNamedPipe'; not supported}
        {FUNCTION SetNamedPipeHandleState(hNamedPipe:HANDLE;
                         VAR lpMode,lpMaxCollectionCount:ULONG;
                         VAR lpCollectDataTimeOut:ULONG):BOOL;
                   APIENTRY;  'PMWINX' index'SetNamedPipeHandleState'; not supported}
        {FUNCTION GetNamedPipeInfo(hNamedPipe:HANDLE;
                            VAR lpFlags,lpOutBufferSize:ULONG;
                            VAR lpInBufferSize,lpMaxInstances:ULONG):BOOL;
                   APIENTRY;  'PMWINX' index'GetNamedPipeInfo'; not supported}
        {FUNCTION PeekNamedPipe(hNamedPipe:HANDLE;VAR lpBuffer;nBufferSize:ULONG;
                               VAR lpBytesRead,lpTotalBytesAvail:ULONG;
                               VAR lpBytesLeftThisMessage:ULONG):BOOL;
                   APIENTRY;  'PMWINX' index'PeekNamedPipe'; not supported}
        {FUNCTION TransactNamedPipe(hNamedPipe:HANDLE;VAR lpInBuffer;nInBufferSize:ULONG;
                                   VAR lpOutBuffer;nOutBufferSize:ULONG;
                                   VAR lpBytesRead:ULONG;
                                   VAR lpOverlapped:OVERLAPPED):BOOL;
                   APIENTRY;  'PMWINX' index'TransactNamedPipe'; not supported}
        {FUNCTION CreateMailslot(CONST lpName:CSTRING;nMaxMessageSize:ULONG;
                                lReadTimeOut:ULONG;
                                VAR lpSecurityAttributes:SECURITY_ATTRIBUTES):HANDLE;
                   APIENTRY;  'PMWINX' index'CreateMailslotA'; not supported}
        {FUNCTION GetMailslotInfo(hMailslot:HANDLE;VAR lpMaxMessageSize:ULONG;
                                 VAR lpNextSize,lpMessageCount:ULONG;
                                 VAR lpReadTimeout:ULONG):BOOL;
                   APIENTRY;  'PMWINX' index'GetMailslotInfo'; not supported}
        {FUNCTION SetMailslotInfo(hMailslot:HANDLE;lReadTimeOut:ULONG):BOOL;
                   APIENTRY;  'PMWINX' index'SetMailslotInfo'; not supported}
        {FUNCTION MapViewOfFile(hFileMappingObject:HANDLE;dwDesiredAccess:ULONG;
                               dwFileOffsetHigh,dwFileOffsetLow:ULONG;
                               dwNumberOfBytesToMap:ULONG):POINTER;
                   APIENTRY;  'PMWINX' index'MapViewOfFile'; not supported}
        {FUNCTION FlushViewOfFile(lpBasAddress:POINTER;dwNumberOfBytesToFlush:ULONG):BOOL;
                   APIENTRY;  'PMWINX' index'FlushViewOfFile'; not supported}
        {FUNCTION UnmapViewOfFile(lpBaseAddress:POINTER):BOOL;
                   APIENTRY;  'PMWINX' index'UnmapViewOfFile'; not supported}
        FUNCTION lstrcmp(CONST lpString1,lpString2:CSTRING):LONGINT;
                   APIENTRY;  'PMWINX' index 479;
        FUNCTION lstrcmpi(CONST lpString1,lpString2:CSTRING):LONGINT;
                   APIENTRY;  'PMWINX' index 480;
        {FUNCTION lstrcpyn(VAR lpString1:CSTRING;CONST lpString2:CSTRING;
                          iMaxLength:LONGINT):PChar;
                   APIENTRY;  'PMWINX' index'lstrcpynA'; not supported}
        FUNCTION lstrcpy(VAR lpString1:CSTRING;CONST lpString2:CSTRING):PChar;
                   APIENTRY;  'PMWINX' index 481;
        FUNCTION lstrcat(VAR lpString1:CSTRING;CONST lpString2:CSTRING):PChar;
                   APIENTRY;  'PMWINX' index 478;
        FUNCTION lstrlen(CONST lpString:CSTRING):LONGINT;
                   APIENTRY;  'PMWINX' index 482;
        FUNCTION OpenFile(CONST lpFileName:CSTRING;VAR lpReOpenBuf:OFSTRUCT;
                          uStyle:ULONG):HFILE;
                   APIENTRY;  'PMWINX' index 504;
        FUNCTION _lopen(CONST lpPathName:CSTRING;iReadWrite:LONGINT):HFILE;
                   APIENTRY;  'PMWINX' index 726;
        FUNCTION _lcreat(CONST lpPathName:CSTRING;iAttribute:LONGINT):HFILE;
                   APIENTRY;  'PMWINX' index 724;
        FUNCTION _lread(ahFile:HFILE;VAR lpBuffer;uBytes:ULONG):ULONG;
                   APIENTRY;  'PMWINX' index 727;
        FUNCTION _lwrite(ahFile:HFILE;CONST Buffer;uBytes:ULONG):ULONG;
                   APIENTRY;  'PMWINX' index 728;
        {FUNCTION _hread(ahFile:HFILE;VAR lpBuffer;lBytes:LONGINT):LONGINT;
                   APIENTRY;  'PMWINX' index'_hread'; not supported}
        {FUNCTION _hwrite(ahFile:HFILE;CONST lpBuffer;lBytes:LONGINT):LONGINT;
                   APIENTRY;  'PMWINX' index'_hwrite'; not supported}
        FUNCTION _lclose(ahFile:HFILE):HFILE;
                   APIENTRY;  'PMWINX' index 723;
        FUNCTION _llseek(ahFile:HFILE;lOffset:LONG;iOrigin:LONGINT):LONG;
                   APIENTRY;  'PMWINX' index 725;
        {FUNCTION IsTextUnicode(CONST lpBuffer;cb:LONGINT;VAR lpi:LONGINT):BOOL;
                   APIENTRY;  'PMWINX' index'IsTextUnicode'; not supported}
        FUNCTION TlsAlloc:ULONG;
                   APIENTRY;  'PMWINX' index 692;
        FUNCTION TlsGetValue(dwTlsIndex:ULONG):POINTER;
                   APIENTRY;  'PMWINX' index 694;
        FUNCTION TlsSetValue(dwTlsIndex:ULONG;lpTlsValue:POINTER):BOOL;
                   APIENTRY;  'PMWINX' index 695;
        FUNCTION TlsFree(dwTlsIndex:ULONG):BOOL;
                   APIENTRY;  'PMWINX' index 693;
        {FUNCTION SleepEx(dwMilliseconds:ULONG;bAlertable:BOOL):ULONG;
                   APIENTRY;  'PMWINX' index'SleepEx'; not supported}
        {FUNCTION WaitForSingleObjectEx(hHandle:HANDLE;dwMillieconds:ULONG;
                                       bAlertable:BOOL):ULONG;
                   APIENTRY;  'PMWINX' index'WaitForSingleObjectEx'; not supported}
        {FUNCTION WaitForMultipleObjectsEx(nCount:ULONG;CONST lpHandles:HANDLE;
                                          bWaitAll:BOOL;dwMilliseconds:ULONG;
                                          bAlertable:BOOL):ULONG;
                   APIENTRY;  'PMWINX' index'WaitForMultipleObjectsEx'; not supported}
        {FUNCTION ReadFileEx(hFile:HANDLE;VAR lpBuffer;nNumberOfBytesToRead:ULONG;
                            VAR lpOverlapped:OVERLAPPED;
                            lpCompletionRoutine:LPOVERLAPPED_COMPLETION_ROUTINE):BOOL;
                   APIENTRY;  'PMWINX' index'ReadFileEx'; not supported}
        {FUNCTION WriteFileEx(hFile:HANDLE;CONST lpBuffer;nNumberOfBytesToWrite:ULONG;
                             VAR lpOverlapped:OVERLAPPED;
                             lpCompletionRoutine:LPOVERLAPPED_COMPLETION_ROUTINE):BOOL;
                   APIENTRY;  'PMWINX' index'WriteFileEx'; not supported}
        {FUNCTION BackupRead(hFile:HANDLE;VAR lpBuffer;nNumberOfBytesToRead:ULONG;
                            VAR lpNumberOfBytesRead:ULONG;bAbort:BOOL;
                            bProcessSecurity:BOOL;VAR lpContext:POINTER):BOOL;
                   APIENTRY;  'PMWINX' index'BackupRead'; not supported}
        {FUNCTION BackupSeek(hFile:HANDLE;dwLowBytesToSeek,dwHighBytesToSeek:ULONG;
                            VAR lpdwLowByteSeeked,lpdwHighByteSeeked:ULONG;
                            VAR lpContext:POINTER):BOOL;
                   APIENTRY;  'PMWINX' index'BackupSeek'; not supported}
        {FUNCTION BackupWrite(hFile:HANDLE;VAR lpBuffer;nNumberOfBytesToWrite:ULONG;
                             VAR lpNumberOfBytesWritten:ULONG;bAbort:BOOL;
                             bProcessSecurity:BOOL;VAR lpContext:POINTER):BOOL;
                   APIENTRY;  'PMWINX' index'BackupWrite'; not supported}
        FUNCTION CreateMutex(VAR lpMutexAttributes:SECURITY_ATTRIBUTES;
                             bInitialOwner:BOOL;CONST lpName:CSTRING):HANDLE;
                   APIENTRY;  'PMWINX' index 84;
        FUNCTION OpenMutex(dwDesiredAccess:ULONG;bInheritHandle:BOOL;
                           CONST lpName:CSTRING):HANDLE;
                   APIENTRY;  'PMWINX' index 505;
        FUNCTION CreateEvent(VAR lpEventAttributes:SECURITY_ATTRIBUTES;
                             bManualReset,bInitialState:BOOL;
                             CONST lpName:CSTRING):HANDLE;
                   APIENTRY;  'PMWINX' index 73;
        FUNCTION OpenEvent(dwDesiredAccess:ULONG;bInheritHandle:BOOL;
                           CONST lpName:CSTRING):HANDLE;
                   APIENTRY;  'PMWINX' index 503;
        FUNCTION CreateSemaphore(VAR lpSemaphoreAttributes:SECURITY_ATTRIBUTES;
                                 lInitialCount,lMaximumCount:LONG;
                                 CONST lpName:CSTRING):HANDLE;
                   APIENTRY;  'PMWINX' index 96;
        FUNCTION OpenSemaphore(dwDesiredAccess:ULONG;bInheritHandle:BOOL;
                               CONST lpName:CSTRING):HANDLE;
                   APIENTRY;  'PMWINX' index 507;
        {FUNCTION CreateFileMapping(hFile:HANDLE;
                                   VAR lpFileMappingAttributes:SECURITY_ATTRIBUTES;
                                   flProtect,dwMaximumSizeHigh,dwMaximumSizeLow:ULONG;
                                   CONST lpName:CSTRING):HANDLE;
                   APIENTRY;  'PMWINX' index'CreateFileMappingA'; not supported}
        {FUNCTION OpenFileMapping(dwDesiredAccess:ULONG;bInheritHandle:BOOL;
                                 CONST lpName:CSTRING):HANDLE;
                   APIENTRY;  'PMWINX' index'OpenFileMappingA'; not supported}
        FUNCTION GetLogicalDriveStrings(nBufferLength:ULONG;
                                        VAR lpBuffer:CSTRING):ULONG;
                   APIENTRY;  'PMWINX' index 302;
        FUNCTION LoadLibrary(CONST lpLibFileName:CSTRING):HINSTANCE;
                   APIENTRY;  'PMWINX' index 461;
        {FUNCTION LoadLibraryEx(CONST lpLibFileName:CSTRING;hFile:HANDLE;
                               dwFlags:ULONG):HINSTANCE;
                   APIENTRY;  'PMWINX' index'LoadLibraryExA'; not supported}
        FUNCTION GetModuleFileName(hModule:HINSTANCE;VAR lpFileName;
                                   nSize:ULONG):ULONG;
                   APIENTRY;  'PMWINX' index 318;
        FUNCTION GetModuleHandle(CONST lpModuleName:CSTRING):HMODULE;
                   APIENTRY;  'PMWINX' index 319;
        FUNCTION CreateProcess(CONST lpApplicationName:CSTRING;VAR lpCommandLine:CSTRING;
                               VAR lpProcessAttributes,lpThreadAttributes:SECURITY_ATTRIBUTES;
                               bInheritHandles:BOOL;dwCreationFlags:ULONG;
                               lpEnvironment:POINTER;CONST lpCurrentDir:CSTRING;
                               VAR lpStartupInfo:STARTUPINFO;
                               VAR lpProcessInformation:PROCESS_INFORMATION):BOOL;
                   APIENTRY;  'PMWINX' index 92;
        {FUNCTION SetProcessShutdownParameters(dwLevel,dwFlags:ULONG):BOOL;
                   APIENTRY;  'PMWINX' index'SetProcessShutdownParameters'; not supported}
        {FUNCTION GetProcessShutdownParameters(VAR lpdwLevel,lpdwFlags:ULONG):BOOL;
                   APIENTRY;  'PMWINX' index'GetProcessShutdownParameters'; not supported}
        PROCEDURE FatalAppExit(uAction:ULONG;CONST lpMessageText:CSTRING);
                   APIENTRY;  'PMWINX' index 201;
        {PROCEDURE GetStartupInfo(VAR lpStartupInfo:STARTUPINFO);
                   APIENTRY;  'PMWINX' index'GetStartupInfoA'; not supported}
        FUNCTION GetCommandLine:PChar;
                   APIENTRY;  'PMWINX' index 252;
        FUNCTION GetEnvironmentVariable(CONST lpName:CSTRING;VAR lpBuffer:CSTRING;
                                        nSize:ULONG):ULONG;
                   APIENTRY;  'PMWINX' index 283;
        FUNCTION SetEnvironmentVariable(CONST lpName,lpValue:CSTRING):BOOL;
                   APIENTRY;  'PMWINX' index 615;
        {FUNCTION ExpandEnvironmentStrings(CONST lpSrc:CSTRING;VAR lpDst:CSTRING;
                                          nSize:ULONG):ULONG;
                   APIENTRY;  'PMWINX' index'ExpandEnvironmentStringsA'; not supported}
        PROCEDURE OutputDebugString(CONST lpOutputString:CSTRING);
                   APIENTRY;  'PMWINX' index 508;
        FUNCTION FindResource(hModule:HINSTANCE;CONST lpName,lpType:CSTRING):HRSRC;
                   APIENTRY;  'PMWINX' index 213;
        {FUNCTION FindResourceEx(hModule:HINSTANCE;CONST lpType,lpName:CSTRING;
                                wLanguage:WORD):HRSRC;
                   APIENTRY;  'PMWINX' index'FindResourceExA'; not supported}
        {FUNCTION EnumResourceTypes(hModule:HINSTANCE;lpEnumFunc:ENUMRESTYPEPROC;
                                   lParam:LONG):BOOL;
                   APIENTRY;  'PMWINX' index'EnumResourceTypesA'; not supported}
        {FUNCTION EnumResourceNames(hModule:HINSTANCE;CONST lpType:CSTRING;
                                   lpEnumFunc:ENUMRESNAMEPROC;lParam:LONG):BOOL;
                   APIENTRY;  'PMWINX' index'EnumResourceNamesA'; not supported}
        {FUNCTION EnumResourceLanguages(hModule:HINSTANCE;CONST lpType,lpName:CSTRING;
                                       lpEnumFunc:ENUMRESLANGPROC;lParam:LONG):BOOL;
                   APIENTRY;  'PMWINX' index'EnumResourceLanguagesA'; not supported}
        {FUNCTION BeginUpdateResource(CONST pFileName:CSTRING;
                                     bDeleteExistingResources:BOOL):HANDLE;
                   APIENTRY;  'PMWINX' index'BeginUpdateResourceA'; not supported}
        {FUNCTION UpdateResource(hUpdate:HANDLE;CONST lpType,lpName:CSTRING;
                                wLanguage:WORD;lpData:POINTER;
                                cbData:ULONG):BOOL;
                   APIENTRY;  'PMWINX' index'UpdateResourceA'; not supported}
        {FUNCTION EndUpdateResource(hUpdate:HANDLE;fDiscard:BOOL):BOOL;
                   APIENTRY;  'PMWINX' index'EndUpdateResourceA'; not supported}
        FUNCTION GlobalAddAtom(CONST lpString:CSTRING):ATOM;
                   APIENTRY;  'PMWINX' index 395;
        FUNCTION GlobalFindAtom(CONST lpString:CSTRING):ATOM;
                   APIENTRY;  'PMWINX' index 399;
        FUNCTION GlobalGetAtomName(nAtom:ATOM;VAR lpBuffer:CSTRING;
                                   nSize:LONGINT):ULONG;
                   APIENTRY;  'PMWINX' index 402;
        FUNCTION AddAtom(CONST lpString:CSTRING):ATOM;
                   APIENTRY;  'PMWINX' index 3;
        FUNCTION FindAtom(CONST lpString:CSTRING):ATOM;
                   APIENTRY;  'PMWINX' index 209;
        FUNCTION GetAtomName(nAtom:ATOM;VAR lpBuffer:CSTRING;nSize:LONG):ULONG;
                   APIENTRY;  'PMWINX' index 228;
        FUNCTION GetProfileInt(CONST lpAppName,lpKeyName:CSTRING;
                               nDefault:LONGINT):ULONG;
                   APIENTRY;  'PMWINX' index 342;
        FUNCTION GetProfileString(CONST lpAppName,lpKeyName,lpDefault:CSTRING;
                                  VAR lpReturnedString:CSTRING;nSize:ULONG):ULONG;
                   APIENTRY;  'PMWINX' index 343;
        FUNCTION WriteProfileString(CONST lpAppName,lpKeyName,lpString:CSTRING):BOOL;
                   APIENTRY;  'PMWINX' index 719;
        {FUNCTION GetProfileSection(CONST lpAppName:CSTRING;VAR lpReturnedString:CSTRING;
                                   nSize:ULONG):ULONG;
                   APIENTRY;  'PMWINX' index'GetProfileSectionA'; not supported}
        {FUNCTION WriteProfileSection(CONST lpAppName,lpString:CSTRING):BOOL;
                   APIENTRY;  'PMWINX' index'WriteProfileSectionA'; not supported}
        FUNCTION GetPrivateProfileInt(CONST lpAppName,lpKeyName:CSTRING;
                                      nDefault:LONGINT;CONST lpFileName:CSTRING):ULONG;
                   APIENTRY;  'PMWINX' index 339;
        FUNCTION GetPrivateProfileString(CONST lpAppName,lpKeyName:CSTRING;
                                         CONST lpDefault:CSTRING;
                                         VAR lpReturnedString:CSTRING;
                                         nSize:ULONG;CONST lpFileName:CSTRING):ULONG;
                   APIENTRY;  'PMWINX' index 340;
        FUNCTION WritePrivateProfileString(CONST lpAppName,lpKeyName:CSTRING;
                                           CONST lpString,lpFileName:CSTRING):BOOL;
                   APIENTRY;  'PMWINX' index 718;
        {FUNCTION GetPrivateProfileSection(CONST lpAppName:CSTRING;
                                          VAR lpReturnedString:CSTRING;
                                          nSize:ULONG;CONST lpFileName:CSTRING):ULONG;
                   APIENTRY;  'PMWINX' index'GetPrivateProfileSectionA'; not supported}
        {FUNCTION WritePrivateProfileSection(CONST lpAppName,lpString:CSTRING;
                                            CONST lpFileName:CSTRING):BOOL;
                   APIENTRY;  'PMWINX' index'WritePrivateProfileSectionA'; not supported}
        FUNCTION GetDriveType(CONST lpRootPathName:CSTRING):ULONG;
                   APIENTRY;  'PMWINX' index 277;
        FUNCTION GetSystemDirectory(VAR lpBuffer:CSTRING;uSize:ULONG):ULONG;
                   APIENTRY;  'PMWINX' index 357;
        FUNCTION GetTempPath(nBufferLength:ULONG;VAR lpBuffer:CSTRING):ULONG;
                   APIENTRY;  'PMWINX' index 364;
        FUNCTION GetTempFileName(CONST lpPathName,lpPrefixString:CSTRING;
                                 uUnique:ULONG;VAR lpTempFileName:CSTRING):ULONG;
                   APIENTRY;  'PMWINX' index 363;
        FUNCTION GetWindowsDirectory(VAR lpBuffer:CSTRING;uSize:ULONG):ULONG;
                   APIENTRY;  'PMWINX' index 393;
        FUNCTION SetCurrentDirectory(CONST lpPathName:CSTRING):BOOL;
                   APIENTRY;  'PMWINX' index 604;
        FUNCTION GetCurrentDirectory(nBufferLength:ULONG;VAR lpBuffer):ULONG;
                   APIENTRY;  'PMWINX' index 253;
        FUNCTION GetDiskFreeSpace(CONST lpRootPathName:CSTRING;
                                  VAR lpSectorsPerCluster,lpBytesPerSector:ULONG;
                                  VAR lpNumberOfFreeClusters,lpTotalClusters:ULONG):BOOL;
                   APIENTRY;  'PMWINX' index 271;
        FUNCTION CreateDirectory(CONST lpPathName:CSTRING;
                                 VAR lpSecurityAttributes:SECURITY_ATTRIBUTES):BOOL;
                   APIENTRY;  'PMWINX' index 69;
        {FUNCTION CreateDirectoryEx(CONST lpTemplateDir,lpNewDir:CSTRING;
                                   VAR lpSecurityAttribtes:SECURITY_ATTRIBUTES):BOOL;
                   APIENTRY;  'PMWINX' index'CreateDirectoryExA'; not supported}
        FUNCTION RemoveDirectory(CONST lpPathName:CSTRING):BOOL;
                   APIENTRY;  'PMWINX' index 563;
        FUNCTION GetFullPathName(CONST lpFileName:CSTRING;nBufferLength:ULONG;
                                 VAR lpBuffer;VAR lpFilePart:PChar):ULONG;
                   APIENTRY;  'PMWINX' index 292;
        {FUNCTION DefineDosDevice(dwFlags:ULONG;CONST lpDeviceName:CSTRING;
                                 CONST lpTargetPath:CSTRING):BOOL;
                   APIENTRY;  'PMWINX' index'DefineDosDeviceA'; not supported}
        {FUNCTION QueryDosDevice(CONST lpDeviceName:CSTRING;VAR lpTargetPath:CSTRING;
                                ucchMax:ULONG):ULONG;
                   APIENTRY;  'PMWINX' index'QueryDosDeviceA'; not supported}
        FUNCTION CreateFile(CONST lpFileName:CSTRING;dwDesiredAccess:ULONG;
                            dwShareMode:ULONG;VAR lpSecurityAttributes:SECURITY_ATTRIBUTES;
                            deCreationDisposition,dwFlagsAndAttributes:ULONG;
                            hTemplateFile:HANDLE):HANDLE;
                   APIENTRY;  'PMWINX' index 74;
        FUNCTION SetFileAttributes(CONST lpFileName:CSTRING;
                                   dwFileAttributes:ULONG):BOOL;
                   APIENTRY;  'PMWINX' index 617;
        FUNCTION GetFileAttributes(CONST lpFileName:CSTRING):ULONG;
                   APIENTRY;  'PMWINX' index 284;
        {FUNCTION GetCompressedFileSize(CONST lpFileName:CSTRING;
                                       VAR lpFileSizeHigh:ULONG):ULONG;
                   APIENTRY;  'PMWINX' index'GetCompressedFileSizeA'; not supported}
        FUNCTION DeleteFile(CONST lpFileName:CSTRING):BOOL;
                   APIENTRY;  'PMWINX' index 137;
        FUNCTION FindFirstFile(CONST lpFileName:CSTRING;
                               VAR lpFindFileData:WIN32_FIND_DATA):HANDLE;
                   APIENTRY;  'PMWINX' index 211;
        FUNCTION FindNextFile(hFindFile:HANDLE;
                              VAR lpFindFileData:WIN32_FIND_DATA):BOOL;
                   APIENTRY;  'PMWINX' index 212;
        FUNCTION SearchPath(CONST lpPath,lpFileName,lpExtension:CSTRING;
                            nBufferLength:ULONG;VAR lpBuffer:CSTRING;
                            VAR lpFilePart:PChar):ULONG;
                   APIENTRY;  'PMWINX' index 583;
        FUNCTION CopyFile(CONST lpExistingFileName,lpNewFileName:CSTRING;
                          bFailIfExists:BOOL):BOOL;
                   APIENTRY;  'PMWINX' index 52;
        FUNCTION MoveFile(CONST lpExistingFileName,lpNewFileName:CSTRING):BOOL;
                   APIENTRY;  'PMWINX' index 490;
        {FUNCTION MoveFileEx(CONST lpExistingFileName,lpNewFileName:CSTRING;
                            dwFlags:ULONG):BOOL;
                   APIENTRY;  'PMWINX' index'MoveFileExA'; not supported}
        {FUNCTION CreateNamedPipe(CONST lpName:CSTRING;dwOpenMode:ULONG;
                                 dwPipeMode,nMaxInstances,nOutBufferSize:ULONG;
                                 nInBufferSize,nDefaultTimeOut:ULONG;
                                 VAR lpSecurityAttributes:SECURITY_ATTRIBUTES):HANDLE;
                   APIENTRY;  'PMWINX' index'CreateNamedPipeA'; not supported}
        {FUNCTION GetNamedPipeHandleState(hNamedPipe:HANDLE;VAR lpState:ULONG;
                               VAR lpCurInstances,lpMaxCollectionCount:ULONG;
                               VAR lpCollectDataTimeOut:ULONG;
                               VAR lpUserName:CSTRING;nMaxUserNameSize:ULONG):BOOL;
                   APIENTRY;  'PMWINX' index'GetNamedPipeHandleStateA'; not supported}
        {FUNCTION CallNamedPipe(CONST lpNamedPipeName:CSTRING;
                               VAR lpInBuffer;nInBufferSize:ULONG;
                               VAR lpOutBuffer;nOutBufferSize:ULONG;
                               VAR lpBytesRead:ULONG;nTimeOut:ULONG):BOOL;
                   APIENTRY;  'PMWINX' index'CallNamedPipeA'; not supported}
        {FUNCTION WaitNamedPipe(CONST lpNamedPipeName:CSTRING;
                               nTimeOut:ULONG):BOOL;
                   APIENTRY;  'PMWINX' index'WaitNamedPipeA'; not supported}
        FUNCTION SetVolumeLabel(CONST lpRootPathName,lpVolumeName:CSTRING):BOOL;
                   APIENTRY;  'PMWINX' index 656;
        {PROCEDURE SetFileApisToOEM;
                   APIENTRY;  'PMWINX' index'SetFileApisToOEM'; not supported}
        {PROCEDURE SetFileApisToANSI;
                   APIENTRY;  'PMWINX' index'SetFileApisToANSI'; not supported}
        {FUNCTION AreFileApisANSI:BOOL;
                   APIENTRY;  'PMWINX' index'AreFileApisANSI'; not supported}
        FUNCTION GetVolumeInformation(CONST lpRootPathName:CSTRING;
                                      VAR lpVolumeNameBuffer:CSTRING;
                                      nVolumeNameSize:ULONG;
                                      VAR lpVolumeSerialNumber:ULONG;
                                      VAR lpMaximumComponentLength:ULONG;
                                      VAR lpFileSystemFlags:ULONG;
                                      VAR lpFileSystemNameBuffer:CSTRING;
                                      nFileSystemNameSize:ULONG):BOOL;
                   APIENTRY;  'PMWINX' index 380;
        {FUNCTION ClearEventLog(hEventLog:HANDLE;CONST lpBackupFileName:CSTRING):BOOL;
                   APIENTRY;  'PMWINX' index'ClearEventLogA'; not supported}
        {FUNCTION BackupEventLog(hEventLog:HANDLE;CONST lpBackupFileName:CSTRING):BOOL;
                   APIENTRY;  'PMWINX' index'BackupEventLogA'; not supported}
        {FUNCTION CloseEventLog(hEventLog:HANDLE):BOOL;
                   APIENTRY;  'PMWINX' index'CloseEventLog'; not supported}
        {FUNCTION DeregisterEventSource(hEventLog:HANDLE):BOOL;
                   APIENTRY;  'PMWINX' index'DeregisterEventSource'; not supported}
        {FUNCTION NotifyChangeEventLog(hEventLog,hEvent:HANDLE):BOOL;
                   APIENTRY;  'PMWINX' index'NotifyChangeEventLog'; not supported}
        {FUNCTION GetNumberOfEventLogRecords(hEventLog:HANDLE;VAR NumberOfRecords:WORD):BOOL;
                   APIENTRY;  'PMWINX' index'GetNumberOfEventLogRecords'; not supported}
        {FUNCTION GetOldestEventLogRecord(hEventLog:HANDLE;VAR OldestRecord:ULONG):BOOL;
                   APIENTRY;  'PMWINX' index'GetOldestEventLogRecord'; not supported}
        {FUNCTION OpenEventLog(CONST lpUNCServerName:CSTRING;
                              CONST lpSourceName:CSTRING):HANDLE;
                   APIENTRY;  'PMWINX' index'OpenEventLogA'; not supported}
        {FUNCTION RegisterEventSource(CONST lpUNCServerName:CSTRING;
                                     CONST lpSourceName:CSTRING):HANDLE;
                   APIENTRY;  'PMWINX' index'RegisterEventSourceA'; not supported}
        {FUNCTION OpenBackupEventLog(CONST lpUNCServerName:CSTRING;
                                    CONST lpFileName:CSTRING):HANDLE;
                   APIENTRY;  'PMWINX' index'OpenBackupEventLogA'; not supported}
        {FUNCTION ReadEventLog(hEventLog:HANDLE;dwReadFlags,dwRecordOffset:ULONG;
                              VAR lpBuffer;nNumberOfBytesToRead:ULONG;
                              VAR pnBytesRead,pnMinNumberOfBytesNeeded:ULONG):BOOL;
                   APIENTRY;  'PMWINX' index'ReadEventLogA'; not supported}
        {FUNCTION ReportEvent(hEventLog:HANDLE;wType,wCategory:WORD;
                             dwEventID:ULONG;VAR lpUserSid:SID;
                             wNumStrings:WORD;VAR lpStrings:PChar;
                             VAR lpRawData):BOOL;
                   APIENTRY;  'PMWINX' index'ReportEventA';
        FUNCTION DuplicateToken(ExistingTokenHandle:HANDLE;
                                Impoersonation_Level:SECURITY_IMPERSONATION_LEVEL;
                                VAR DuplicateTokenHandle:HANDLE):BOOL;
                   APIENTRY;  'PMWINX' index'DuplicateToken';
        FUNCTION GetKernelObjectSecurity(Handle:HANDLE;Requested_Information:SECURITY_INFORMATION;
                                         VAR pSecurityDescriptor:SECURITY_DESCRIPTOR;
                                         nLength:ULONG;VAR lpnLengthNeeded:ULONG):BOOL;
                   APIENTRY;  'PMWINX' index'GetKernelObjectSecurity';
        FUNCTION ImpersonateNamedPipeClient(hNamedPipe:HANDLE):BOOL;
                   APIENTRY;  'PMWINX' index'ImpersonateNamedPipeClient';
        FUNCTION ImpersonateSelf(ImpoersonationLevel:SECURITY_IMPOERSONATION_LEVEL):BOOL;
                   APIENTRY;  'PMWINX' index'ImpersonateSelf';
        FUNCTION RevertToSelf:BOOL;
                   APIENTRY;  'PMWINX' index'RevertToSelf';
        FUNCTION SetThreadToken(VAR Thread:HANDLE;Token:HANDLE):BOOL;
                   APIENTRY;  'PMWINX' index'SetThreadToken';
        FUNCTION AccessCheck(VAR pSecurityDescriptor:SECURITY_DESCRIPTOR;
                             ClientToken:HANDLE;DesiredAccess:ULONG;
                             VAR GenericMapping:GENERIC_MAPPING;
                             VAR PrivilegeSet:PRIVILEGE_SET;
                             VAR PrivilegeSetLength:ULONG;
                             VAR GrantedAccess:ULONG;VAR AccessStatus:BOOL):BOOL;
                   APIENTRY;  'PMWINX' index'AccessCheck';
        FUNCTION OpenProcessToken(ProcessHandle:HANDLE;DesiredAccess:ULONG;
                                  VAR TokenHandle:HANDLE):BOOL;
                   APIENTRY;  'PMWINX' index'OpenProcessToken';
        FUNCTION OpenThreadToken(ThreadHandle:HANDLE;DesiredAccess:ULONG;
                                 OpenAsSelf:BOOL;VAR TokenHandle:HANDLE):BOOL;
                   APIENTRY;  'PMWINX' index'OpenThreadToken';
        FUNCTION GetTokenInformation(TokenHandle:HANDLE;
                                TokenInformationClass:TOKEN_INFORMATION_CLASS;
                                VAR TokenInformation;TokenInformationLength:ULONG;
                                VAR ReturnLength:ULONG):BOOL;
                   APIENTRY;  'PMWINX' index'GetTokenInformation';
        FUNCTION SetTokenInformation(TokenHandle:HANDLE;
                                TokenInformationClass:TOKEN_INFORMATION_CLASS;
                                VAR TokenInformation;TokenInformationLength:ULONG):BOOL;
                   APIENTRY;  'PMWINX' index'SetTokenInformation';
        FUNCTION AdjustTokenPrivileges(TokenHandle:HANDLE;DisableAllPrivileges:BOOL;
                                       VAR NewState:TOKEN_PRIVILEGES;
                                       BufferLength:ULONG;
                                       VAR PreviousState:TOKEN_PRIVILEGES;
                                       VAR ReturnLength:ULONG):BOOL;
                   APIENTRY;  'PMWINX' index'AdjustTokenPrivileges';
        FUNCTION AdjustTokenGroups(TokenHandle:HANDLE;ResetToDefault:BOOL;
                                   VAR NewState:TOKEN_GROUPS;BufferLength:ULONG;
                                   VAR PreviousState:TOKEN_GROUPS;
                                   VAR ReturnLength:ULONG):BOOL;
                   APIENTRY;  'PMWINX' index'AdjustTokenGroups';
        FUNCTION PrivilegeCheck(ClientToken:HANDLE;
                                VAR RequiredPrivileges:PRIVILEGE_SET;
                                VAR pfResult:BOOL):BOOL;
                   APIENTRY;  'PMWINX' index'PrivilegeCheck';
        FUNCTION AccessCheckAndAuditAlarm(CONST SubsystemName:CSTRING;
                                          VAR HandleId;
                                          VAR ObjectTypeName,ObjectName:CSTRING;
                                          VAR SecurityDescriptor:SECURITY_DESCRIPTOR;
                                          DesiredAccess:ULONG;
                                          VAR GenericMapping:GENERIC_MAPPING;
                                          ObjectCreation:BOOL;
                                          VAR GrantedAccess:ULONG;
                                          VAR AccessStatus,pfGenerateOnClose:BOOL):BOOL;
                   APIENTRY;  'PMWINX' index'AccessCheckAndAuditAlarmA';
        FUNCTION ObjectOpenAuditAlarm(CONST SubSystemName:CSTRING;VAR HandleId;
                                      VAR ObjectTypeName,ObjectName:CSTRING;
                                      VAR pSecurityDescriptor:SECURITY_DESCRIPTOR;
                                      ClientToken:HANDLE;
                                      DesiredAccess,GrantedAccess:ULONG;
                                      VAR Privileges:PRIVILEGE_SET;
                                      ObjectCreation,AccessGranted:BOOL;
                                      VAR GenerateOnClose:BOOL):BOOL;
                   APIENTRY;  'PMWINX' index'ObjectOpenAuditAlarmA';
        FUNCTION ObjectPrivilegeAuditAlarm(CONST SubsystemName:CSTRING;
                                           VAR HandleId;ClientToken:HANDLE;
                                           DesiredAccess:ULONG;
                                           VAR Privileges:PRIVILEGE_SET;
                                           AccessGranted:BOOL):BOOL;
                   APIENTRY;  'PMWINX' index'ObjectPrivilegeAuditAlarmA';
        FUNCTION ObjectCloseAuditAlarm(CONST SubsystemName:CSTRING;
                                       VAR HandleId;GenerateOnClose:BOOL):BOOL;
                   APIENTRY;  'PMWINX' index'ObjectCloseAuditAlarmA';
        FUNCTION PrivilegedServiceAuditAlarm(CONST SubsystemName,ServiceName:CSTRING;
                                     ClientToken:HANDLE;
                                     VAR Privileges:PRIVILEGE_SET;
                                     AccessGranted:BOOL):BOOL;
                   APIENTRY;  'PMWINX' index'PrivilegedServiceAuditAlarmA';
        FUNCTION IsValidSid(VAR pSid:SID):BOOL;
                   APIENTRY;  'PMWINX' index'IsValidSid';
        FUNCTION EqualSid(VAR pSid1,pSid2:SID):BOOL;
                   APIENTRY;  'PMWINX' index'EqualSid';
        FUNCTION EqualPrefixSid(VAR pSid1,pSid2:SID):BOOL;
                   APIENTRY;  'PMWINX' index'EqualPrefixSid';
        FUNCTION GetSidLengthRequired(nSubAuthorityCount:BYTE):ULONG;
                   APIENTRY;  'PMWINX' index'GetSidLengthRequired';
        FUNCTION AllocateAndInitializeSid(VAR pIdentifierAuthority:SID_IDENTIFIER_AUTHORITY;
                         nSubAuthorityCount:BYTE;
                         nSubAuthority0,nSubAuthority1,nSubAuthority2:ULONG;
                         nSubAuthority3,nSubAuthority4,nSubAuthority5:ULONG;
                         nSubAuthority6,nSubAuthority7:ULONG;
                         VAR pSid:PSID):BOOL;
                   APIENTRY;  'PMWINX' index'AllocateAndInitializeSid';
        FUNCTION FreeSid(VAR pSid:SID):POINTER;
                   APIENTRY;  'PMWINX' index'FreeSid';
        FUNCTION InitializeSid(VAR pIdentifierAuthority:SID_IDENTIFIER_AUTHORITY;
                               nSubAuthorityCount:BYTE):BOOL;
                   APIENTRY;  'PMWINX' index'InitializeSid';
        FUNCTION GetSidIdentifierAuthority(VAR pSid:SID):PSID_IDENTIFIER_AUTHORITY;
                   APIENTRY;  'PMWINX' index'GetSidIdentifierAuthority';
        FUNCTION GetSidSubAuthority(VAR pSid:SID;nSubAuthority:ULONG):PULONG;
                   APIENTRY;  'PMWINX' index'GetSidSubAuthority';
        FUNCTION GetSidSubAuthorityCount(VAR pSid:SID):PBYTE;
                   APIENTRY;  'PMWINX' index'GetSidSubAuthorityCount';
        FUNCTION GetLengthSid(VAR pSid:SID):ULONG;
                   APIENTRY;  'PMWINX' index'GetLengthSid';
        FUNCTION CopySid(nDestinationSidLength:ULONG;
                         VAR pDestinationSid,pSourceSid:SID):BOOL;
                   APIENTRY;  'PMWINX' index'CopySid';
        FUNCTION AreAllAccessesGranted(GrantedAccess,DesiredAccess:ULONG):BOOL;
                   APIENTRY;  'PMWINX' index'AreAllAccessesGranted';
        FUNCTION AreAnyAccessesGranted(GrantedAccess,DesiredAccess:ULONG):BOOL;
                   APIENTRY;  'PMWINX' index'AreAnyAccessesGranted';
        PROCEDURE MapGenericMask(VAR AccessMask:ULONG;VAR GenericMapping:GENERIC_MAPPING);
                   APIENTRY;  'PMWINX' index'MapGenericMask';
        FUNCTION IsValidAcl(VAR pAcl:ACL):BOOL;
                   APIENTRY;  'PMWINX' index'IsValidAcl';
        FUNCTION InitializeAcl(VAR pAcl:ACL;nAclLength,deAclRevision:ULONG):BOOL;
                   APIENTRY;  'PMWINX' index'InitializeAcl';
        FUNCTION GetAclInformation(VAR pAcl:ACL;VAR pAclInformation;
                                   nAclInformationlength:ULONG;
                                   dwAclInformationClass:ACL_INFORMATION_CLASS):BOOL;
                   APIENTRY;  'PMWINX' index'GetAclInformation';
        FUNCTION SetAclInformation(VAR pAcl:ACL;VAR pAclInformation;
                                   nAclInformationLength:ULONG;
                                   dwAclInformationClass:ACL_INFORMATION_CLASS):BOOL;
                   APIENTRY;  'PMWINX' index'SetAclInformation';
        FUNCTION AddAce(VAR pACL:ACL;dwAceRevision,dwStartingAceIndex:ULONG;
                        VAR pAceList;nAceListLength:ULONG):BOOL;
                   APIENTRY;  'PMWINX' index'AddAce';
        FUNCTION DeleteAce(VAR pAcl:ACL;deAceIndex:ULONG):BOOL;
                   APIENTRY;  'PMWINX' index'DeleteAce';
        FUNCTION GetAce(VAR pAcl:ACL;dwAceIndex:ULONG;VAR pAce:POINTER):BOOL;
                   APIENTRY;  'PMWINX' index'GetAce';
        FUNCTION AddAccessAllowedAce(VAR pAcl:ACL;dwAceRevision,AcessMask:ULONG;
                                     VAR pSid:SID):BOOL;
                   APIENTRY;  'PMWINX' index'AddAccessAllowedAce';
        FUNCTION AddAccessDeniedAce(VAR pAcl:ACL;dwAceRevision,dwAccessMask:ULONG;
                                    VAR pSid:SID):BOOL;
                   APIENTRY;  'PMWINX' index'AddAccessDeniedAce';
        FUNCTION AddAuditAccessAce(VAR pAcl:ACL;dwAceRevision,dwAccessMask:ULONG;
                                   VAR pSid:SID):BOOL;
                   APIENTRY;  'PMWINX' index'AddAuditAccessAce';
        FUNCTION FindFirstFreeAce(VAR pAcl:ACL;VAR pAce:POINTER):BOOL;
                   APIENTRY;  'PMWINX' index'FindFirstFreeAce';
        FUNCTION InitializeSecurityDescriptor(VAR pSecurityDescriptor:SECURITY_DESCRIPTOR;
                               dwRevision:ULONG):BOOL;
                   APIENTRY;  'PMWINX' index'InitializeSecurityDescriptor';
        FUNCTION IsValidSecurityDescriptor(VAR pSecurityDescriptor:SECURITY_DESCRIPTOR):BOOL;
                   APIENTRY;  'PMWINX' index'IsValidSecurityDescriptor';
        FUNCTION GetSecurityDescriptorLength(VAR pSecurityDesciptor:SECURITY_DESCRIPTOR):ULONG;
                   APIENTRY;  'PMWINX' index'GetSecurityDescriptorLength';
        FUNCTION GetSecurityDescriptorControl(VAR pSecurityDescriptor:SECURITY_DESCRIPTOR;
                                 VAR pControl:SECURITY_DESCRITOR_CONTROL;
                                 VAR lpdwRevision:ULONG):BOOL;
                   APIENTRY;  'PMWINX' index'GetSecurityDescriptorControl';
        FUNCTION SetSecurityDescriptorDacl(VAR pSecurityDescriptor:SECURITY_DESCRIPTOR;
                                            bDaclPresent:BOOL;VAR pDacl:ACL;
                                            bDaclDefaulted:BOOL):BOOL;
                   APIENTRY;  'PMWINX' index'SetSecurityDescriptorDacl';
        FUNCTION GetSecurityDescriptorDacl(VAR pSecurityDescriptor:SECURITY_DESCRIPTOR;
                                           VAR lpbDaclPresent:BOOL;
                                           VAR pDacl:PACL;VAR lpbDaclDefaulted:BOOL):BOOL;
                   APIENTRY;  'PMWINX' index'GetSecurityDescriptorDacl';
        FUNCTION SetSecurityDescriptorSacl(VAR pSecurityDescriptor:SECURITY_DESCRIPTOR;
                                           bSaclPresent:BOOL;VAR pSacl:ACL;
                                           bSaclDefaulted:BOOL):BOOL;
                   APIENTRY;  'PMWINX' index'SetSecurityDescriptorSacl';
        FUNCTION GetSecurityDescriptorSacl(VAR pSecurityDescriptor:SECURITY_DESCRIPTOR;
                                           VAR lpbSaclPresent:BOOL;VAR pSacl:PACL;
                                           VAR lpbSaclDefaulted:BOOL):BOOL;
                   APIENTRY;  'PMWINX' index'GetSecurityDescriptorSacl';
        FUNCTION SetSecurityDescriptorOwner(VAR pSecurityDescriptor:SECURITY_DESCRIPTOR;
                                            VAR pOwner:SID;bOwnerDefaulted:BOOL):BOOL;
                   APIENTRY;  'PMWINX' index'SetSecurityDescriptorOwner';
        FUNCTION GetSecurityDescriptorOwner(VAR pSecurityDescriptor:SECURITY_DESCRIPTOR;
                                            VAR pOwner:PSID;VAR lpbOwnerDefaulted:BOOL):BOOL;
                   APIENTRY;  'PMWINX' index'GetSecurityDescriptorOwner';
        FUNCTION SetSecurityDescriptorGroup(VAR pSecurityDescriptor:SECURITY_DESCRIPTOR;
                                            VAR pGroup:SID;bGroupDefaulted:BOOL):BOOL;
                   APIENTRY;  'PMWINX' index'SetSecurityDescriptorGroup';
         FUNCTION GetSecurityDescriptorGroup(VAR pSecurityDescriptor:SECURITY_DESCRIPTOR;
                                             VAR pGroup:SID;VAR lpGroupDefaulted:BOOL):BOOL;
                   APIENTRY;  'PMWINX' index'GetSecurityDescriptorGroup';
         FUNCTION CreatePrivateObjectSecurity(VAR ParentDescriptor,CreatorDescritor:SECURITY_DESCRIPTOR;
                                              VAR NewDescriptor:PSECURITY_DESCRIPTOR;
                                              IsDirectoryObject:BOOL;Token:HANDLE;
                                              VAR GenericMapping:GENERIC_MAPPING):BOOL;
                   APIENTRY;  'PMWINX' index'CreatePrivateObjectSecurity';
         FUNCTION SetPrivateObjectSecurity(SecurityInformation:SECURITY_INFORMATION;
                                           VAR ModificationDescriptor:SECURITY_DESCRIPTOR;
                                           VAR ObjectsSecurityDescriptor:PSECURITY_DESCRIPTOR;
                                           VAR GenericMapping:GENERIC_MAPPING;
                                           Token:HANDLE):BOOL;
                   APIENTRY;  'PMWINX' index'SetPrivateObjectSecurity';
         FUNCTION GetPrivateObjectSecurity(VAR ObjectDescriptor:SECURITY_DESCRIPTOR;
                                           SecurityInformation:SECURITY_INFORMATION;
                                           VAR ResultantDescriptor:SECURITY_DESCRIPTOR;
                                           DescriptorLength:LONGWORD;VAR ReturnLength:LONGWORD):BOOL;
                   APIENTRY;  'PMWINX' index'GetPrivateObjectSecurity';
         FUNCTION DestroyPrivateObjectSecurity(VAR ObjectDescriptor:PSECURITY_DESCRIPTOR):BOOL;
                   APIENTRY;  'PMWINX' index'DestroyPrivateObjectSecurity';
         FUNCTION MakeSelfRelativeSD(VAR pAbsoluteSecurityDescriptor,pSelfRelativeSecurityDescriptor:SECURITY_DESCRIPTOR;
                                     VAR lpdwBufferLength:LONGWORD):BOOL;
                   APIENTRY;  'PMWINX' index'MakeSelfRelativeSD';
         FUNCTION MakeAbsoluteSD(VAR pSelfRelativeSecurityDescriptor,pAbsoluteSecurityDescriptor:SECURITY_DESCRIPTOR;
                                 VAR lpdwAbsoluteSecurityDescriptorSize:LONGWORD;VAR pDacl:ACL;
                                 VAR lpdwDaclSize:LONGWORD;VAR pSacl:ACL;VAR lpdwSaclSize:LONGWORD;
                                 VAR pOwner:SID;VAR lpdwOwnerSize:LONGWORD;VAR pPrimaryGroup:SID;
                                 VAR lpdwPrimaryGroupSize:LONGWORD):BOOL;
                   APIENTRY;  'PMWINX' index'MakeAbsoluteSD';
         FUNCTION SetFileSecurity(CONST lpFileName:CSTRING;SecurityInformation:SECURITY_INFORMATION;
                                  VAR pSecurityDescriptor:SECURITY_DESCRIPTOR):BOOL;
                   APIENTRY;  'PMWINX' index'SetFileSecurityA';
         FUNCTION GetFileSecurity(CONST lpFileName:CSTRING;SecurityInformation:SECURITY_INFORMATION;
                                  VAR pSecurityDescriptor:SECURITY_DESCRIPTOR;nLength:LONGWORD;
                                  VAR lpnLengthNeeded:LONGWORD):BOOL;
                   APIENTRY;  'PMWINX' index'GetFileSecurityA';
         FUNCTION SetKernelObjectSecurity(aHandle:HANDLE;SecurityInformation:SECURITY_INFORMATION;
                                          VAR pSecurityDescriptor:SECURITY_DESCRIPTOR):BOOL;
                   APIENTRY;  'PMWINX' index'SetKernelObjectSecurity';
         FUNCTION FindFirstChangeNotification(CONST lpPathName:CSTRING;bWatchSubTree:BOOL;
                                              dwNotifyFilter:LONGWORD):HANDLE;
                   APIENTRY;  'PMWINX' index'FindFirstChangeNotificationA';
         FUNCTION FindNextChangeNotification(hChangeHandle:HANDLE):BOOL;
                   APIENTRY;  'PMWINX' index'FindNextChangeNotification';
         FUNCTION FindCloseChangeNotification(hChangeHandle:HANDLE):BOOL;
                   APIENTRY;  'PMWINX' index'FindCloseChangeNotification';}
         {FUNCTION VirtualLock(VAR lpAdress;dwSize:LONGWORD):BOOL;
                   APIENTRY;  'PMWINX' index'VirtualLock'; not supported}
         {FUNCTION VirtualUnlock(VAR lpAdress;dwSize:LONGWORD):BOOL;
                   APIENTRY;  'PMWINX' index'VirtualUnlock'; not supported}
         {FUNCTION MapViewOfFileEx(hFileMappingObject:HANDLE;dwDesiredAccess,dwFileOffsetHigh,
                                  dwFileOffsetLow,dwNumberOfBytesToMap:LONGWORD;
                                  VAR lpBaseAddress):POINTER;
                   APIENTRY;  'PMWINX' index'MapViewOfFileEx'; not supported}
         FUNCTION SetPriorityClass(hProcess:HANDLE;dwPriorityClass:LONGWORD):BOOL;
                   APIENTRY;  'PMWINX' index 636;
         FUNCTION GetPriorityClass(hProcess:HANDLE):LONGWORD;
                   APIENTRY;  'PMWINX' index 337;
         FUNCTION IsBadReadPtr(lp:POINTER;ucb:LONGWORD):BOOL;
                   APIENTRY;  'PMWINX' index 433;
         FUNCTION IsBadWritePtr(lp:POINTER;ucb:LONGWORD):BOOL;
                   APIENTRY;  'PMWINX' index 435;
         FUNCTION IsBadHugeReadPtr(lp:POINTER;ucb:LONGWORD):BOOL;
                   APIENTRY;  'PMWINX' index 431;
         FUNCTION IsBadHugeWritePtr(lp:POINTER;ucb:LONGWORD):BOOL;
                   APIENTRY;  'PMWINX' index 432;
         FUNCTION IsBadCodePtr(lpfn:POINTER):BOOL;
                   APIENTRY;  'PMWINX' index 430;
         FUNCTION IsBadStringPtr(CONST lpsz:CSTRING;ucchMax:LONGWORD):BOOL;
                   APIENTRY;  'PMWINX' index 434;
         {FUNCTION LookupAccountSid(CONST lpSystemName:CSTRING;VAR aSid:SID;VAR Name:CSTRING;
                                    VAR cbName:LONGWORD;VAR ReferencedDomainName:CSTRING;
                                    VAR cbReferencedDomainName:LONGWORD;VAR peUse:SID_NAME_USE):BOOL;
                   APIENTRY;  'PMWINX' index'LookupAccountSidA';
         FUNCTION LookupAccountName(CONST lpSystemName:CSTRING;lpAccountName:CSTRING;VAR aSid:SID;
                                    VAR cbSid:LONGWORD;VAR ReferencedDomainName:CSTRING;
                                    VAR cbReferencedDomainName:LONGWORD;VAR peUse:SID_NAME_USE):BOOL;
                   APIENTRY;  'PMWINX' index'LookupAccountNameA';
         FUNCTION LookupPrivilegeValue(CONST lpSystemName:CSTRING;CONST lpName:CSTRING;VAR alpLuid:LUID):BOOL;
                   APIENTRY;  'PMWINX' index'LookupPrivilegeValueA';
         FUNCTION LookupPrivilegeName(CONST lpSystemName:CSTRING;VAR alpLuid:LUID;VAR lpName:CSTRING;
                                       VAR cbName:LONGWORD):BOOL;
                   APIENTRY;  'PMWINX' index'LookupPrivilegeNameA';
         FUNCTION LookupPrivilegeDisplayName(CONST lpSystemName,lpName:CSTRING;VAR lpDisplayName:CSTRING;
                                             VAR cbDisplayName,lpLanguageId:LONGWORD):BOOL;
                   APIENTRY;  'PMWINX' index'LookupPrivilegeDisplayNameA';
         FUNCTION AllocateLocallyUniqueId(VAR aLuid:LUID):BOOL;
                   APIENTRY;  'PMWINX' index'AllocateLocallyUniqueId';
         FUNCTION BuildCommDCB(CONST lpDef:CSTRING;VAR alpDCB:DCB):BOOL;
                   APIENTRY;  'PMWINX' index'BuildCommDCBA';
         FUNCTION BuildCommDCBAndTimeouts(CONST lpDef:CSTRING;VAR alpDCB:DCB;VAR alpCommTimeOuts:COMMTIMEOUTS):BOOL;
                   APIENTRY;  'PMWINX' index'BuildCommDCBAndTimeoutsA';
         FUNCTION CommConfigDialog(CONST lpszName:CSTRING;ahWnd:HWND;VAR lpCC:COMMCONFIG):BOOL;
                   APIENTRY;  'PMWINX' index'CommConfigDialogA';
         FUNCTION GetDefaultCommConfig(CONST lpszName:CSTRING;VAR lpCC:COMMCONFIG;VAR lpdwSize:LONGWORD):BOOL;
                   APIENTRY;  'PMWINX' index'GetDefaultCommConfigA';
         FUNCTION SetDefaultCommConfig(CONST lpszName:CSTRING;VAR lpCC:COMMCONFIG;dwSize:LONGWORD):BOOL;
                   APIENTRY;  'PMWINX' index'SetDefaultCommConfigA';}
         {FUNCTION GetComputerName(VAR lpBuffer:CSTRING;VAR nSize:LONGWORD):BOOL;
                   APIENTRY;  'PMWINX' index'GetComputerNameA'; not supported}
         {FUNCTION SetComputerName(CONST lpComputerName:CSTRING):BOOL;
                   APIENTRY;  'PMWINX' index'SetComputerNameA'; not supported}
         {FUNCTION GetUserName(VAR lpBuffer:CSTRING;VAR nSize:LONGWORD):BOOL;
                   APIENTRY;  'PMWINX' index'GetUserNameA'; not supported}
         {FUNCTION QueryPerformanceCounter(VAR lpPerformanceCount:LARGE_INTEGER):BOOL;
                   APIENTRY;  'PMWINX' index'QueryPerformanceCounter'; not supported}
         {FUNCTION QueryPerformanceFrequency(VAR lpFrequency:LARGE_INTEGER):BOOL;
                   APIENTRY;  'PMWINX' index'QueryPerformanceFrequency'; not supported}
         {FUNCTION GetVersionEx(lpVersionInformation:OSVERSIONINFO):BOOL;
                   APIENTRY;  'PMWINX' index'GetVersionExA'; not supported}
         {$ENDIF}
END;

FUNCTION FreeModule(hLibModule:HINSTANCE):BOOL;
FUNCTION MakeProcInstance(lpProc:POINTER;ahInstance:HINSTANCE):POINTER;
FUNCTION FreeProcInstance(lpProc:POINTER):POINTER;
FUNCTION GlobalLRUNewest(h:HGLOBAL):HANDLE;
FUNCTION GlobalLRUOldest(h:HGLOBAL):HANDLE;
FUNCTION GlobalDiscard(h:HGLOBAL):HGLOBAL;
FUNCTION LocalDiscard(h:HGLOBAL):HGLOBAL;
FUNCTION GetFreeSpace(w:LONGWORD):LONGWORD;

IMPLEMENTATION

FUNCTION FreeModule(hLibModule:HINSTANCE):BOOL;
BEGIN
     result:=FreeLibrary(hLibModule);
END;

FUNCTION MakeProcInstance(lpProc:POINTER;ahInstance:HINSTANCE):POINTER;
BEGIN
     result:=lpProc;
END;

FUNCTION FreeProcInstance(lpProc:POINTER):POINTER;
BEGIN
     result:=lpProc;
END;

FUNCTION GlobalLRUNewest(h:HGLOBAL):HANDLE;
BEGIN
     result:=h;
END;

FUNCTION GlobalLRUOldest(h:HGLOBAL):HANDLE;
BEGIN
     result:=h;
END;

FUNCTION GlobalDiscard(h:HGLOBAL):HGLOBAL;
BEGIN
     result:=GlobalReAlloc(h,0,GMEM_MOVEABLE);
END;

FUNCTION LocalDiscard(h:HGLOBAL):HGLOBAL;
BEGIN
     result:=LocalReAlloc(h,0,LMEM_MOVEABLE);
END;

FUNCTION GetFreeSpace(w:LONGWORD):LONGWORD;
BEGIN
     result:=$100000;
END;

END.
