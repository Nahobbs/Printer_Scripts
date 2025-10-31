#!/bin/zsh

## Variable Initialization/Declaration
PRINTER_NAME="6th Floor Printer[625]"
PRINTER_DESCRIPTION="6th_Floor_Math_Printer[625]"
PRINTER_URI="ipp://128.192.134.134"
DRIVER_ARGS="printer-is-shared=false"

# Early exit: if a printer named "CopyCat" or "CS Mailroom" (case-insensitive)
# already exists according to `lpstat -p`, print message and exit.
if command -v lpstat >/dev/null 2>&1; then
  if lpstat -p 2>/dev/null | grep -i -E '625|6th Floor' >/dev/null 2>&1; then
    echo "625 Printer already installed..."
    exit 0
  fi
fi

## No Driver check needed as none exists for download using 'everywhere' driver selects the proper driver. 

# Add the printer
lpadmin -p "$PRINTER_DESCRIPTION" \
    -D "$PRINTER_NAME" \
    -E \
    -v "$PRINTER_URI" \
    -m everywhere \
    -o "$DRIVER_ARGS"