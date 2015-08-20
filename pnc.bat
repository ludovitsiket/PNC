REM doplnit if podmienky aby neukoncilo hned pri nezadani podmienok, "blbuvzdornost"
echo off
echo ________________________
echo  PNC (pack and copy)   
echo ________________________ 
IF NOT %3.==. (GOTO prg) else (GOTO No1)

:No1
echo Nezadal si potrebne parametre!
GOTO help
GOTO end
exit

:prg
@ECHO OFF
:: Check WMIC is available
WMIC.EXE Alias /? >NUL 2>&1 || GOTO s_error

:: Use WMIC to retrieve date and time
FOR /F "skip=1 tokens=1-6" %%G IN ('WMIC Path Win32_LocalTime Get Day^,Hour^,Minute^,Month^,Second^,Year /Format:table') DO (
   IF "%%~L"=="" goto s_done
      Set _yyyy=%%L
      Set _mm=00%%J
      Set _dd=00%%G
)
:s_done

:: Pad digits with leading zeros
      Set _mm=%_mm:~-2%
      Set _dd=%_dd:~-2%

Set logtimestamp=%_yyyy%_%_mm%_%_dd%
goto make_dump

:s_error
echo WMIC is not available, using default log filename
Set logtimestamp=_

:make_dump
set FILENAME=database_dump_%logtimestamp%.sql

REM Nastavenie mena suboru
set "fullname=%~3_%logtimestamp%
echo %logtimestamp%
echo Meno suboru bude: %fullname%.zip
set "fullname=%~3"

REM Samotna kompresia
echo -----> Komprimujem, cakaj prosim.
7za a -tzip %fullname%.zip %~s1

REM Presun suboru do urcenej zlozky
set export=%fullname%.zip
move %export% %~s2
echo Subor %fullname%.zip bol uspesne presunuty do zlozky %~s2
echo _______________
GOTO succes

:end
echo Nezadal si potrebne parametre. Koniec skriptu.

:No1
echo Nezadal si potrebne parametre!
GOTO help
GOTO end

:help
echo ---------------
echo NAPOVEDA:
echo Prikaz pnc.bat potrebuje mat zadane vsetky 3 parametre.
echo pnc.bat "cesta_k_adresaru" "cesta_k_cielovemu_adresaru" meno_suboru
echo "cesta_k_adresaru" - uplna cesta k adresaru na skomprimovanie (pisat v uvodzovkach)
echo "cesta_k_cielovemu_adresaru" - uplna cesta k adresaru do ktoreho bude skomprimovany subor presunuty (pisat v uvodzovkach)
echo meno_suboru - meno suboru ktore bude automaticky doplnene o aktualny datum v tvare rok_mesiac_den
echo ---------------

:succes
echo Koniec skriptu.
echo _______________
