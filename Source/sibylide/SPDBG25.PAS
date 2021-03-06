
{浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
 �                                                                          �
 �     Sibyl Visual Development Environment                                 �
 �                                                                          �
 �     Copyright (C) 1995,99 SpeedSoft Germany,   All rights reserved.      �
 �                                                                          �
 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕}

{浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
 �                                                                          �
 � Sibyl Integrated Development Environment (IDE)                           �
 � Object-oriented development system.                                      �
 �                                                                          �
 � Copyright (C) 1995,99 SpeedSoft GbR, Germany                             �
 �                                                                          �
 � This program is free software; you can redistribute it and/or modify it  �
 � under the terms of the GNU General Public License (GPL) as published by  �
 � the Free Software Foundation; either version 2 of the License, or (at    �
 � your option) any later version. This program is distributed in the hope  �
 � that it will be useful, but WITHOUT ANY WARRANTY; without even the       �
 � implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR          �
 � PURPOSE.                                                                 �
 � See the GNU General Public License for more details. You should have     �
 � received a copy of the GNU General Public License along with this        �
 � program; if not, write to the Free Software Foundation, Inc., 59 Temple  �
 � Place - Suite 330, Boston, MA 02111-1307, USA.                           �
 �                                                                          �
 � In summary the original copyright holders (SpeedSoft) grant you the      �
 � right to:                                                                �
 �                                                                          �
 � - Freely modify and publish the sources provided that your modification  �
 �   is entirely free and you also make the modified source code available  �
 �   to all for free (except a fee for disk/CD production etc).             �
 �                                                                          �
 � - Adapt the sources to other platforms and make the result available     �
 �   for free.                                                              �
 �                                                                          �
 � Under this licence you are not allowed to:                               �
 �                                                                          �
 � - Create a commercial product on whatever platform that is based on the  �
 �   whole or parts of the sources covered by the license agreement. The    �
 �   entire program or development environment must also be published       �
 �   under the GNU General Public License as entirely free.                 �
 �                                                                          �
 � - Remove any of the copyright comments in the source files.              �
 �                                                                          �
 � - Disclosure any content of the source files or use parts of the source  �
 �   files to create commercial products. You always must make available    �
 �   all source files whether modified or not.                              �
 �                                                                          �
 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕}

LIBRARY SPDbg25;

{$M 128000,8388608}     {256K Stack,0,12MB Heap}

USES DbgHelp;

{$IFDEF OS2}
EXPORTS
       DebugLoad                   Index 1,
       DebugUnload                 Index 2,
       CreateEventSem              Index 3,
       PostEventSem                Index 4,
       SetNextAction               Index 5,
       GetDebugReturn              Index 6,
       MainLoop                    Index 7,
       Dummy                       Index 8,
       GetModulesLoaded            Index 9,
       GetModuleInfo               Index 10,
       GetRegisterSet              Index 11,
       PutRegisterSet              Index 12,
       DeleteWorkThread            Index 13,
       SetStartBreakPoint          Index 14,
       SetBreakPoint               Index 15,
       UnsetBreakPoint             Index 16,
       SetBreakPointLine           Index 17,
       SetBreakAtStartAddr         Index 18,
       GetAdressFromLine           Index 19,
       SetNextDbgBrk               Index 20,
       GetNextDbgBrk               Index 21,
       GetValueFromExpr            Index 22,
       SetValueFromExpr            Index 23,
       SetWatchHwnd                Index 24,
       SetRegHwnd                  Index 25,
       SetProjectHwnd              Index 26,
       GetProcTermResult           Index 27,
       IsBreakPointLine            Index 28,
       GetDump                     Index 29,
       SetDump                     Index 30,
       LockInput                   Index 31,
       UnlockInput                 Index 32,
       IssueDebugCommand           Index 33,
       GetLineFromEIP              Index 34,
       GetBreakPointOp             Index 35,
       GetNameFromAddr             Index 36,
       SearchLineNum               Index 37,
       GetNearestProc              Index 38,
       GetTypeInfoFromExpr         Index 39,
       FreeTypeList                Index 40,
       SetWatchPoint               Index 41,
       ClearWatchPoint             Index 42,
       GetCoproRegisterSet         Index 43,
       PutCoproRegisterSet         Index 44,
       DbgLineAvail                Index 45,
       DbgSetExceptions            Index 46,
       GetBreakPoints              Index 47,
       GetNextDbgBrkInfo           Index 48,
       GetLocalVars                Index 49,
       FreeLocalVars               Index 50,
       GetAdressFromName           Index 51,
       SetOptions                  Index 52;
{$ENDIF}

{$IFDEF WIN32}
EXPORTS
       DebugLoad                   Name 'DebugLoad',
       DebugUnload                 Name 'DebugUnload',
       CreateEventSem              Name 'CreateEventSem',
       PostEventSem                Name 'PostEventSem',
       SetNextAction               Name 'SetNextAction',
       GetDebugReturn              Name 'GetDebugReturn',
       MainLoop                    Name 'MainLoop',
       Dummy                       Name 'Dummy',
       GetModulesLoaded            Name 'GetModulesLoaded',
       GetModuleInfo               Name 'GetModuleInfo',
       GetRegisterSet              Name 'GetRegisterSet',
       PutRegisterSet              Name 'PutRegisterSet',
       DeleteWorkThread            Name 'DeleteWorkThread',
       SetStartBreakPoint          Name 'SetStartBreakPoint',
       SetBreakPoint               Name 'SetBreakPoint',
       UnsetBreakPoint             Name 'UnsetBreakPoint',
       SetBreakPointLine           Name 'SetBreakPointLine',
       SetBreakAtStartAddr         Name 'SetBreakAtStartAddr',
       GetAdressFromLine           Name 'GetAdressFromLine',
       SetNextDbgBrk               Name 'SetNextDbgBrk',
       GetNextDbgBrk               Name 'GetNextDbgBrk',
       GetValueFromExpr            Name 'GetValueFromExpr',
       SetValueFromExpr            Name 'SetValueFromExpr',
       SetWatchHwnd                Name 'SetWatchHwnd',
       SetRegHwnd                  Name 'SetRegHwnd',
       SetProjectHwnd              Name 'SetProjectHwnd',
       GetProcTermResult           Name 'GetProcTermResult',
       IsBreakPointLine            Name 'IsBreakPointLine',
       GetDump                     Name 'GetDump',
       SetDump                     Name 'SetDump',
       LockInput                   Name 'LockInput',
       UnlockInput                 Name 'UnlockInput',
       IssueDebugCommand           Name 'IssueDebugCommand',
       GetLineFromEIP              Name 'GetLineFromEIP',
       GetBreakPointOp             Name 'GetBreakPointOp',
       GetNameFromAddr             Name 'GetNameFromAddr',
       SearchLineNum               Name 'SearchLineNum',
       GetNearestProc              Name 'GetNearestProc',
       GetTypeInfoFromExpr         Name 'GetTypeInfoFromExpr',
       FreeTypeList                Name 'FreeTypeList',
       SetWatchPoint               Name 'SetWatchPoint',
       ClearWatchPoint             Name 'ClearWatchPoint',
       GetCoproRegisterSet         Name 'GetCoproRegisterSet',
       PutCoproRegisterSet         Name 'PutCoproRegisterSet',
       DbgLineAvail                Name 'DbgLineAvail',
       DbgSetExceptions            Name 'DbgSetExceptions',
       GetBreakPoints              Name 'GetBreakPoints',
       GetNextDbgBrkInfo           Name 'GetNextDbgBrkInfo',
       GetLocalVars                Name 'GetLocalVars',
       FreeLocalVars               Name 'FreeLocalVars',
       GetAdressFromName           Name 'GetAdressFromName',
       SetOptions                  Name 'SetOptions';
{$ENDIF}


BEGIN
END.

