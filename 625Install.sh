#!/bin/zsh

## Variable Initialization/Declaration
PRINTER_NAME="625 Printer"
PRINTER_DESCRIPTION="6th Floor Math Printer (625)"
PRINTER_URI="ipp://128.192.134.134"
DRIVER_ARGS="printer-is-shared=false"

# Add the printer
lpadmin -p "$PRINTER_DESCRIPTION" \
    -D "$PRINTER_NAME" \
    -E \
    -v "$PRINTER_URI" \
    -m everywhere \
    -o "$DRIVER_ARGS"