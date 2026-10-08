cwlVersion: v1.2
class: CommandLineTool
baseCommand: dos2unix
label: dos2unix
doc: "DOS/Mac to Unix and vice versa text file format converter. The input files
  are staged writable in the working directory and converted in place (old-file
  mode).\n\nTool homepage: https://waterlan.home.xs4all.nl/dos2unix.html"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: Files to convert in-place
    inputBinding:
      position: 2
      valueFrom: $(self.map(function(f){ return f.basename; }))
  - id: allow_chown
    type:
      - 'null'
      - boolean
    doc: allow file ownership change
    inputBinding:
      position: 1
      prefix: --allow-chown
  - id: ascii
    type:
      - 'null'
      - boolean
    doc: default conversion mode
    inputBinding:
      position: 1
      prefix: -ascii
  - id: iso
    type:
      - 'null'
      - boolean
    doc: conversion between DOS and ISO-8859-1 character set
    inputBinding:
      position: 1
      prefix: -iso
  - id: code_page
    type:
      - 'null'
      - string
    doc: 'DOS/Windows code page used with -iso: 1252, 437 (default), 850, 860, 863
      or 865 (given without the dash)'
    inputBinding:
      position: 1
      valueFrom: -$(self)
  - id: seven_bit
    type:
      - 'null'
      - boolean
    doc: convert 8 bit characters to 7 bit space
    inputBinding:
      position: 1
      prefix: '-7'
  - id: keep_bom
    type:
      - 'null'
      - boolean
    doc: keep Byte Order Mark
    inputBinding:
      position: 1
      prefix: --keep-bom
  - id: convmode
    type:
      - 'null'
      - string
    doc: 'Conversion mode: ascii, 7bit, iso, mac (default: ascii)'
    inputBinding:
      position: 1
      prefix: --convmode
  - id: add_eol
    type:
      - 'null'
      - boolean
    doc: add a line break to the last line if there isn't one
    inputBinding:
      position: 1
      prefix: --add-eol
  - id: no_add_eol
    type:
      - 'null'
      - boolean
    doc: don't add a line break to the last line if there isn't one (default)
    inputBinding:
      position: 1
      prefix: --no-add-eol
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force conversion of binary files
    inputBinding:
      position: 1
      prefix: --force
  - id: keepdate
    type:
      - 'null'
      - boolean
    doc: Keep output file date
    inputBinding:
      position: 1
      prefix: --keepdate
  - id: newline
    type:
      - 'null'
      - boolean
    doc: add additional newline
    inputBinding:
      position: 1
      prefix: --newline
  - id: add_bom
    type:
      - 'null'
      - boolean
    doc: add Byte Order Mark (default UTF-8)
    inputBinding:
      position: 1
      prefix: --add-bom
  - id: oldfile
    type:
      - 'null'
      - boolean
    doc: Write to old file (default)
    inputBinding:
      position: 1
      prefix: --oldfile
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Quiet mode, suppress all warnings
    inputBinding:
      position: 1
      prefix: --quiet
  - id: remove_bom
    type:
      - 'null'
      - boolean
    doc: remove Byte Order Mark (default)
    inputBinding:
      position: 1
      prefix: --remove-bom
  - id: safe
    type:
      - 'null'
      - boolean
    doc: skip binary files (default)
    inputBinding:
      position: 1
      prefix: --safe
  - id: keep_utf16
    type:
      - 'null'
      - boolean
    doc: keep UTF-16 encoding
    inputBinding:
      position: 1
      prefix: --keep-utf16
  - id: assume_utf16le
    type:
      - 'null'
      - boolean
    doc: assume that the input format is UTF-16LE
    inputBinding:
      position: 1
      prefix: --assume-utf16le
  - id: assume_utf16be
    type:
      - 'null'
      - boolean
    doc: assume that the input format is UTF-16BE
    inputBinding:
      position: 1
      prefix: --assume-utf16be
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: verbose operation
    inputBinding:
      position: 1
      prefix: --verbose
outputs:
  - id: converted_files
    type:
      type: array
      items: File
    doc: The converted files (same names as the inputs)
    outputBinding:
      glob: $(inputs.input_files.map(function(f){ return f.basename; }))
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: |
      ${ return inputs.input_files.map(function(f){ return {entry: f, writable: true}; }); }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dos2unix:7.5.3
stdout: dos2unix.out
