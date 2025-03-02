#!/bin/bash

brochure_signature=20
#~ brochure_signature=32

if [[ -n $1 ]]; then
    document=$1
else
    echo "Error! Not enough args, usage: ./make_printable.sh <input file> [--no-pdf2ps]"
    exit
fi

if [[ $2 == "--no-pdf2ps" ]]
then
    echo "Skipping step 1: pdf2ps conversion"
else 
    echo "Step 1: pdf2ps $document tmp_document.ps"
    pdf2ps $document tmp_document.ps
fi

echo "Step 2: psbook -s${brochure_signature} tmp_document.ps tmp_booklet.ps"
psbook -s${brochure_signature} tmp_document.ps tmp_booklet.ps

echo "Step 3: psnup -pa4 -PA5 -l -2 tmp_booklet.ps tmp_psnuped.ps"
psnup -pa4 -PA5 -l -2 tmp_booklet.ps tmp_psnuped.ps

echo "Ready to print!"
