@echo off
REM Build standalone mirror.exe on Windows 10/11 using MinGW-w64 GCC.
REM Run in a terminal where g++ and windres are in PATH.
cd /d "%~dp0"
where g++ >nul 2>nul
if errorlevel 1 (
  echo ERROR: MinGW-w64 g++ is not installed or not in PATH.
  pause
  exit /b 1
)
where windres >nul 2>nul
if errorlevel 1 (
  echo ERROR: windres is not installed or not in PATH.
  pause
  exit /b 1
)
windres app.rc -O coff -o app.res
if errorlevel 1 exit /b 1
g++ -std=c++17 -O2 -municode -mwindows -static -static-libgcc -static-libstdc++ mirror.cpp config_gui.cpp app.res -o mirror.exe -ld3d11 -ldxgi -ld3dcompiler -lgdi32 -ldwmapi -luuid -lole32 -lcomdlg32 -lwinmm -lcomctl32
if %ERRORLEVEL%==0 (echo BUILD OK -^> mirror.exe) else (echo BUILD FAILED)
exit /b %ERRORLEVEL%
