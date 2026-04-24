cwlVersion: v1.2
class: CommandLineTool
baseCommand: recontig convert
label: recontig_convert
doc: "remap contig names for different bioinformatics file types.\n\nTool homepage:
  https://github.com/blachlylab/recontig"
inputs:
  - id: input_file
    type: string
    doc: Input file
    inputBinding:
      position: 1
  - id: build
    type:
      - 'null'
      - string
    doc: Genome build i.e GRCh37 for using dpryan79's files
    inputBinding:
      position: 102
      prefix: --build
  - id: col
    type:
      - 'null'
      - int
    doc: if converting a generic file you can specify a column
    inputBinding:
      position: 102
      prefix: --col
  - id: comment
    type:
      - 'null'
      - string
    doc: "if converting a generic file you can specify what a comment line starts
      with (default: '#')"
    inputBinding:
      position: 102
      prefix: --comment
  - id: conversion
    type:
      - 'null'
      - string
    doc: Conversion string i.e UCSC2ensembl for using dpryan79's files
    inputBinding:
      position: 102
      prefix: --conversion
  - id: debug
    type:
      - 'null'
      - boolean
    doc: print extra debug information
    inputBinding:
      position: 102
      prefix: --debug
  - id: delimiter
    type:
      - 'null'
      - string
    doc: "if converting a generic file you can specify a delimiter (default: '\\t')"
    inputBinding:
      position: 102
      prefix: --delimiter
  - id: file_type
    type:
      - 'null'
      - string
    doc: Type of file to convert (vcf, bcf, bam, sam, bed, gff)
    inputBinding:
      position: 102
      prefix: --file-type
  - id: mapping
    type:
      - 'null'
      - File
    doc: If want to use your own remapping file instead of dpryan79's
    inputBinding:
      position: 102
      prefix: --mapping
  - id: output
    type:
      - 'null'
      - string
    doc: name of file out (default is - for stdout)
    inputBinding:
      position: 102
      prefix: --output
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: silence warnings
    inputBinding:
      position: 102
      prefix: --quiet
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: print extra information
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: ejected_output
    type:
      - 'null'
      - File
    doc: File to write ejected records to (records with unmapped contigs)
    outputBinding:
      glob: $(inputs.ejected_output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/recontig:1.5.0--h9ee0642_0
