#!/bin/zsh

## Variable Initialization/Declaration
PRINTER_NAME="CopyCat CS MailRoom"
PRINTER_DESCRIPTION="Computer_Science_Mailroom_Printer[CopyCat]"
PRINTER_URI="lpd://copycat.cs.uga.edu"
PRINTER_DRIVER_PPD="/Library/Printers/PPDs/Contents/Resources/TOSHIBA_ColorMFP.gz"
DRIVER_ARGS="ConfirmDepartmentCode=true"
DRIVER_URL="https://github.com/Nahobbs/Printer_Scripts/blob/main/Mac/Drivers/Drivers-CopyCat.dmg.gz"

# Early exit: if a printer named "CopyCat" or "CS Mailroom" (case-insensitive)
# already exists according to `lpstat -p`, print message and exit.
if command -v lpstat >/dev/null 2>&1; then
  if lpstat -p 2>/dev/null | grep -i -E 'CopyCat|CS Mailroom|CS_Mailroom|CS-Mailroom' >/dev/null 2>&1; then
    echo "CopyCat printer already installed..."
    exit 0
  fi
fi

# Check if the driver PPD exists otherwise try and install it
if [ -f "$PRINTER_DRIVER_PPD" ]; then
  echo "Driver found. Adding printer..."
else
  echo "Driver not found. Installing..."
  cd /tmp/
  curl -L -o Drivers-CopyCat.dmg https://github.com/Nahobbs/Printer_Scripts/releases/download/Alpha/Drivers-CopyCat.dmg
  #gunzip Drivers-CopyCat.dmg.gz
  hdiutil attach Drivers-CopyCat.dmg
  sudo installer -pkg "/Volumes/TOSHIBA ColorMFP/TOSHIBA ColorMFP.pkg" -target /
  hdiutil detach "/Volumes/TOSHIBA ColorMFP"
  rm Drivers-CopyCat.dmg

  # Verify install
  if [ ! -f "$PRINTER_DRIVER_PPD" ]; then
    echo "Drivers not installed properly."
    exit 1
  fi
fi

# Add the printer
sudo lpadmin -p "$PRINTER_DESCRIPTION" \
  -D "$PRINTER_NAME" \
  -E \
  -v "$PRINTER_URI" \
  -P "$PRINTER_DRIVER_PPD" \
  -o "$DRIVER_ARGS"

echo "Printer '$PRINTER_NAME' installed successfully."
