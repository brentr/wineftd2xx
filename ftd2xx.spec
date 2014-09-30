 1 stdcall FT_Open(long ptr)
 2 stdcall FT_Close(ptr)
 3 stdcall FT_Read(ptr ptr long ptr)
 4 stdcall FT_Write(ptr ptr long ptr)
 5 stub FT_IoCtl
 6 stdcall FT_ResetDevice(ptr)
 7 stdcall FT_SetBaudRate(ptr long)
 8 stdcall FT_SetDataCharacteristics(ptr long long long)
 9 stdcall FT_SetFlowControl(ptr long long long)
10 stdcall FT_SetDtr(ptr)
11 stdcall FT_ClrDtr(ptr)
12 stdcall FT_SetRts(ptr)
13 stdcall FT_ClrRts(ptr)
14 stdcall FT_GetModemStatus(ptr ptr)
15 stdcall FT_SetChars(ptr long long long long)
16 stdcall FT_Purge(ptr long)
17 stdcall FT_SetTimeouts(ptr long long)
18 stdcall FT_GetQueueStatus(ptr ptr)
19 stdcall FT_SetEventNotification(ptr long ptr)
20 stub FT_GetEventStatus
21 stdcall FT_GetStatus(ptr ptr ptr ptr)
22 stdcall FT_SetBreakOn(ptr)
23 stdcall FT_SetBreakOff(ptr)
24 stub FT_SetWaitMask
25 stub FT_WaitOnMask
26 stdcall FT_SetDivisor(ptr long)
27 stdcall FT_OpenEx(ptr long ptr)
28 stdcall FT_ListDevices(ptr ptr long)
29 stdcall FT_SetLatencyTimer(ptr long)
30 stdcall FT_GetLatencyTimer(ptr ptr)
31 stdcall FT_SetBitMode(ptr long long)
32 stdcall FT_GetBitMode(ptr ptr)
33 stdcall FT_SetUSBParameters(ptr long long)
34 stdcall FT_EraseEE(ptr)
35 stdcall FT_ReadEE(ptr long ptr)
36 stdcall FT_WriteEE(ptr long long)
37 stdcall FT_EE_Program(ptr ptr)
38 stdcall FT_EE_Read(ptr ptr)
39 stdcall FT_EE_UARead(ptr ptr long ptr)
40 stdcall FT_EE_UASize(ptr ptr)
41 stdcall FT_EE_UAWrite(ptr ptr long)
42 stdcall FT_W32_CreateFile(ptr long long ptr long long ptr)
43 stdcall FT_W32_CloseHandle(ptr)
44 stdcall FT_W32_ReadFile(ptr ptr long ptr ptr)
45 stdcall FT_W32_WriteFile(ptr ptr long ptr ptr)
46 stdcall FT_W32_GetOverlappedResult(ptr ptr ptr long)
47 stdcall FT_W32_ClearCommBreak(ptr)
48 stdcall FT_W32_ClearCommError(ptr ptr ptr)
49 stdcall FT_W32_EscapeCommFunction(ptr long)
50 stdcall FT_W32_GetCommModemStatus(ptr ptr)
51 stdcall FT_W32_GetCommState(ptr ptr)
52 stdcall FT_W32_GetCommTimeouts(ptr ptr)
53 stdcall FT_W32_GetLastError(ptr)
54 stdcall FT_W32_PurgeComm(ptr long)
55 stdcall FT_W32_SetCommBreak(ptr)
56 stdcall FT_W32_SetCommMask(ptr long)
57 stdcall FT_W32_SetCommState(ptr ptr)
58 stdcall FT_W32_SetCommTimeouts(ptr ptr)
59 stdcall FT_W32_SetupComm(ptr long long)
60 stdcall FT_W32_WaitCommEvent(ptr ptr ptr)
61 stdcall FT_GetDeviceInfo(ptr ptr ptr ptr ptr ptr)
62 stub FT_W32_CancelIo
63 stdcall FT_StopInTask(ptr)
64 stdcall FT_RestartInTask(ptr)
65 stub FT_SetResetPipeRetryCount
66 stub FT_ResetPort
67 stdcall FT_EE_ProgramEx(ptr ptr ptr ptr ptr ptr)
68 stdcall FT_EE_ReadEx(ptr ptr ptr ptr ptr ptr)
69 stub FT_CyclePort
70 stdcall FT_CreateDeviceInfoList(ptr)
71 stdcall FT_GetDeviceInfoList(ptr ptr)
72 stdcall FT_GetDeviceInfoDetail(long ptr ptr ptr ptr ptr ptr ptr)
73 stub FT_SetDeadmanTimeout
74 stub FT_GetDriverVersion
75 stub FT_GetLibraryVersion
76 stub FT_W32_GetCommMask
77 stub FT_Rescan
78 stub FT_Reload
79 stub FT_GetComPortNumber
80 stub FT_EE_ReadConfig
81 stub FT_EE_WriteConfig
82 stub FT_EE_ReadECC
83 stub FT_GetQueueStatusEx
84 stub FT_EEPROM_Read
85 stub FT_EEPROM_Program
86 stub FT_ComPortIdle
87 stub FT_ComPortCancelIdel
