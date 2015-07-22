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
REM Nastavenie mena suboru
set year=%date:~-4%
set month=%date:~6,2%
set day=%date:~3,2%
set "fullname=%~3_%year%_%month%_%day%"
echo Meno suboru bude: %fullname%.zip

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
