#!/bin/bash
while read filename; do
    if ! [[ -r "$filename" ]]; then
        echo "Skipping '$filename' because not readable"
        continue
    fi
    tempfile="$(mktemp)"
    if perl -ne '$_ =~ s|^((    )+)|"  " x (length($1)/4)|eg; print $_' < "$filename" > "$tempfile"; then
        #mv "$filename" "$filename".orig
        mv "$tempfile" "$filename"
        echo "Success processing '$filename'"
    else
        echo "Failure processing '$filename'"
    fi
done < "$1"
