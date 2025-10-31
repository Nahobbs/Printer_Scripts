#!/bin/zsh

## Variable Initialization/Declaration
PRINTER_NAME="Delta - Math Mailroom[434A]"
PRINTER_DESCRIPTION="Math_Mailroom_Printer[Delta]"
PRINTER_URI="ipp://delta.math.uga.edu"
DRIVER_ARGS="printer-is-shared=false"

# Early exit: if a printer named "CopyCat" or "CS Mailroom" (case-insensitive)
# already exists according to `lpstat -p`, print message and exit.
if command -v lpstat >/dev/null 2>&1; then
  if lpstat -p 2>/dev/null | grep -i -E 'Delta|Math Mailroom' >/dev/null 2>&1; then
    echo "Delta Printer already installed..."
    exit 0
  fi
fi

## No Driver check needed because using 'everywhere' driver selects the proper driver.

# Add the printer
lpadmin -p "$PRINTER_DESCRIPTION" \
    -D "$PRINTER_NAME" \
    -E \
    -v "$PRINTER_URI" \
    -m everywhere \
    -o "$DRIVER_ARGS"