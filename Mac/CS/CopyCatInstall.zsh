#!/bin/zsh

## Variable Initialization/Declaration
PRINTER_NAME="CopyCat CS MailRoom"
PRINTER_DESCRIPTION="Computer_Science_Mailroom_Printer"
PRINTER_URI="lpd://copycat.cs.uga.edu"
PRINTER_DRIVER_PPD="/Library/Printers/PPDs/Contents/Resources/TOSHIBA_ColorMFP.gz"
DRIVER_ARGS="ConfirmDepartmentCode=true"
DRIVER_URL="https://github.com/Nahobbs/Printer_Scripts/blob/main/Mac/Drivers/Drivers-CopyCat.dmg.gz"

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
