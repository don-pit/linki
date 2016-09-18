@ECHO OFF
REM Converts all *.md files to .output/*.html.
REM Markdown package is installed into .venv virtual environment.
REM Requires Python3.

SETLOCAL

SET _venv=.venv

IF NOT EXIST %_venv% (
    py -3 -m venv --system-site-packages %_venv%
    CALL :PYTHONCALL pip install Markdown
)

SET _output=.output
IF NOT EXIST %_output% (
    MKDIR %_output%
) ELSE (
    DEL /F /Q %_output%\*
)

FOR /F "tokens=*" %%G IN ('dir /b *.md') DO (
    CALL :PYTHONCALL markdown -f %_output%\%%G.html %%G
)

ENDLOCAL

exit /b 0

REM Calls python 3 module from virtual environment.
:PYTHONCALL
SETLOCAL
%_venv%\Scripts\python.exe -m %*
ENDLOCAL
GOTO :EOF
