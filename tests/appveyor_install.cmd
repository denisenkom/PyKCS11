SET PATH=%PYTHON%;%PYTHON%\Scripts;%PATH%;c:\SoftHSM2\bin;c:\SoftHSM2\lib
set SOFTHSM2_CONF=c:\SoftHSM2\etc\softhsm2.conf
echo %CD%
python --version
python -c "import struct; print(struct.calcsize('P') * 8)"
pip install -r dev-requirements.txt
REM Use Chocolatey to install SWIG.
REM Only install swig if it isn't present (as a result of AppVeyor's caching).
REM SWIG 3.0.8 is the minimum required version, but it does not yet exist in
REM Chocolatey.
IF NOT EXIST C:\ProgramData\chocolatey\bin\swig.exe choco install swig --version 2.0.11 --allow-empty-checksums --yes --limit-output #> $null
curl -Lo softhsm.zip https://github.com/disig/SoftHSM2-for-Windows/releases/download/v2.3.0/SoftHSM2-2.3.0-portable.zip
7z -bb3 -oc:\\ x softhsm.zip
softhsm2-util --init-token --slot 0 --label "A token" --pin 1234 --so-pin 123456
