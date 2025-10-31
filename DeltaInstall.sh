#!/bin/zsh

## Variable Initialization/Declaration
PRINTER_NAME="Math_Delta"
PRINTER_DESCRIPTION="Math Mailroom Printer 'Delta'"
PRINTER_URI="ipp://delta.math.uga.edu"
DRIVER_ARGS="printer-is-shared=false"

# Add the printer
lpadmin -p "$PRINTER_DESCRIPTION" \
    -D "$PRINTER_NAME" \
    -E \
    -v "$PRINTER_URI" \
    -m everywhere \
    -o "$DRIVER_ARGS"