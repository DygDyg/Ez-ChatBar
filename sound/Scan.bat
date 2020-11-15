@echo off
@chcp 1251
echo Dyg_Sound_PlayList_Message = { >temp1.txt

dir /b *.mp3, *.wav, *.ogg>temp0.txt
(for /f "delims=" %%i in (temp0.txt) do echo."%%i",)>temp2.txt
Find /I "ICE=0" "temp2.txt" 1>nul||Echo }>>"temp2.txt"

rem echo:>temp2.txt
copy /b temp1.txt + temp2.txt base.lua
del /q temp*.txt


cls
type base.lua
echo.
echo Плейлист создан, теперь это окно можно закрыть и зайти в игру.
echo.
echo The playlist has been created, now you can close this window and log in to the game.

rem pause>nul
TIMEOUT /T 10>nul
