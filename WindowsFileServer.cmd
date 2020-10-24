@echo off
echo USERNAME=
set /p USERNAME=
echo PASSWORD=
set /p PASSWORD=
echo %PASSWORD%
echo Please type department number and press enter.
echo 1-) Department1
echo 2-) Department2
echo 3-) Department3
set /p DEPARTMENT=

net user %USERNAME% %PASSWORD% /add /comment:"Automatically Created" /passwordchg:NO
wmic useraccount where "name='%USERNAME%'" set passwordexpires=FALSE
net localgroup Users %USERNAME% /delete

IF /i "%DEPARTMENT%"=="1" goto dep1
IF /i "%DEPARTMENT%"=="2" goto dep2
IF /i "%DEPARTMENT%"=="3" goto dep3

:dep1
net localgroup Department1 %USERNAME% /add
net localgroup Public %USERNAME% /add
md "C:\FileServer\Department1\%USERNAME%"
CMD /c Echo Y| cacls C:\FileServer\Department1\%USERNAME%  /t /e /c /p "%USERNAME%":f
CMD /c Echo Y| cacls C:\FileServer\Department1\%USERNAME%  /t /e /c /p "dep1.manager":f
goto commonexit


:dep2
net localgroup Department2 %USERNAME% /add
net localgroup Public %USERNAME% /add
md "C:\FileServer\Department3\%USERNAME%"
CMD /c Echo Y| cacls C:\FileServer\Department2\%USERNAME%  /t /e /c /p "%USERNAME%":f
CMD /c Echo Y| cacls C:\FileServer\Department2\%USERNAME%  /t /e /c /p "dep2.manager":f
goto commonexit


:dep3
net localgroup Department3 %USERNAME% /add
net localgroup Public %USERNAME% /add
md "C:\FileServer\Department2\%USERNAME%"
CMD /c Echo Y| cacls C:\FileServer\Department3\%USERNAME%  /t /e /c /p "%USERNAME%":f
CMD /c Echo Y| cacls C:\FileServer\Department3\%USERNAME%  /t /e /c /p "dep3.manager":f
goto commonexit


:commonexit
pause