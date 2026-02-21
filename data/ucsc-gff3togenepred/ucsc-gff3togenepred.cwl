cwlVersion: v1.2
class: CommandLineTool
baseCommand: gff3ToGenePred
label: ucsc-gff3togenepred
doc: "Convert a GFF3 file to a genePred file.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: in_gff3
    type: File
    doc: Input GFF3 file
    inputBinding:
      position: 1
  - id: allow_minimal_gff3
    type:
      - 'null'
      - boolean
    doc: Allow minimal GFF3 format
    inputBinding:
      position: 102
      prefix: -allowMinimalGff3
  - id: honor_stop_codons
    type:
      - 'null'
      - boolean
    doc: Honor stop codons in the GFF3 file
    inputBinding:
      position: 102
      prefix: -honorStopCodons
  - id: max_parse_errors
    type:
      - 'null'
      - int
    doc: Maximum number of parsing errors to ignore
    inputBinding:
      position: 102
      prefix: -maxParseErrors
  - id: process_all_gff3
    type:
      - 'null'
      - boolean
    doc: Process all GFF3 records
    inputBinding:
      position: 102
      prefix: -processAllGff3
  - id: warn_and_skip_on_invalid_stop
    type:
      - 'null'
      - boolean
    doc: Warn and skip on invalid stop codons
    inputBinding:
      position: 102
      prefix: -warnAndSkipOnInvalidStop
outputs:
  - id: out_genepred
    type: File
    doc: Output genePred file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-gff3togenepred:482--h0b57e2e_0
