#!/bin/zsh

## Variable Initialization/Declaration
PRINTER_NAME="CopyCat CS MailRoom"
PRINTER_DESCRIPTION="Computer_Science_Mailroom_Printer"
PRINTER_URI="lpd://copycat.cs.uga.edu"
PRINTER_DRIVER_PPD="/Library/Printers/PPDs/Contents/Resources/TOSHIBA_ColorMFP.gz"
DRIVER_ARGS="ConfirmDepartmentCode=true"

# Check if the driver PPD exists otherwise try and install it
if [ -f "$PRINTER_DRIVER_PPD" ]; then
  echo "Driver found. Adding printer..."
else
  echo "Driver not found. Installing..."
  cd /tmp/
  curl -o TOSHIBA_ColorMFP.dmg.gz https://business.toshiba.com/downloads/KB/f1Ulds/20758/TOSHIBA_ColorMFP.dmg.gz
  gunzip TOSHIBA_ColorMFP.dmg.gz
  hdiutil attach TOSHIBA_ColorMFP.dmg
  sudo installer -pkg "/Volumes/TOSHIBA ColorMFP/TOSHIBA ColorMFP.pkg" -target /
  hdiutil detach "/Volumes/TOSHIBA ColorMFP"
  rm TOSHIBA_ColorMFP.dmg

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
