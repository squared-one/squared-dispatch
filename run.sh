#!/bin/bash

# service cups start

# lpadmin -p Honeywell \
#   -v usb://Honeywell/PC42d-203-FP?serial=22235B54CB \
#   -E \
#   -o Resolution=203dpi \
#   -m drv:///sample.drv/zebra.ppd

# lpadmin -p FedexPrinter \
#   -v socket://$FEDEX_PRINTER_IP \
#   -E \
#   -o Resolution=203dpi

inotifywait -m /home/squaredlab2/Stažené -e moved_to |
  while read dir action file; do
    echo "$file appeared in $dir via $action"

    path="$dir$file"

    # convert PNG file to ZPL
    if [[ $path =~ .+_default\.png?$ ]]; then
      path=$(java ZPLConveter "$path")
    fi

    # print ZPL file to designated printer
    if [[ $path =~ .+_default\.zpl(ii)?$ ]]; then
      printer=DefaultPrinter
      lp -d Honeywell_2 -o media=Custom.10x15cm -o raw /home/squaredlab2/Stažené/$file
    elif [[ $path =~ .+_fedex\.zpl(ii)?$ ]]; then
      printer=FedexPrinter
      lp -d $printer /home/squaredlab2/Stažené/$file
    elif [[ $path =~ .+_pdf\.pdf?$ ]]; then
      printer=DefaultPrinter
      lp -d Honeywell_2 -o media=Custom.10x15cm /home/squaredlab2/Stažené/$file
    fi

    if [[ -v printer ]]; then
      
      sleep 1
      rm "$path"
      echo "removed file"

      unset printer
    fi
  done
