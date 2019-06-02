@if -%1-==-- goto all
@if not -%1-==-- goto dependencies

:dependencies
@echo | set /p="[Resilience] Installing dependencies..."
@go get -u github.com/sqweek/dialog
@go get -u github.com/getlantern/systray
@go get -u golang.org/x/crypto/blake2b
@go get -u github.com/elazarl/goproxy
@go get -u github.com/josephspurrier/goversioninfo/cmd/goversioninfo
@echo   OK
@exit /b

:all
@echo | set /p="[Resilience] Building Resilience..."
@cd internal\app\resilience
@copy ..\..\..\assets\windows\versioninfo.json versioninfo.json >nul
@go generate
@go build -ldflags="-s -w -H=windowsgui" -o ..\..\..\cmd\resilience\resilience.exe
@del versioninfo.json resource.syso
@cd ..\..\..
@echo       OK
@exit /b