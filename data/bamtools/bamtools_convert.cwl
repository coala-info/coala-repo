cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bamtools
  - convert
label: bamtools_convert
doc: "converts BAM to a number of other formats.\n\nTool homepage: https://github.com/pezmaster31/bamtools"
inputs:
  - id: fasta
    type:
      - 'null'
      - File
    doc: FASTA reference file
    inputBinding:
      position: 101
      prefix: -fasta
  - id: format
    type: string
    doc: the output file format - see README for recognized formats
    inputBinding:
      position: 101
      prefix: -format
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: the input BAM file(s) [stdin]
    inputBinding:
      position: 101
      prefix: -in
  - id: input_list
    type:
      - 'null'
      - File
    doc: the input BAM file list, one line per file
    inputBinding:
      position: 101
      prefix: -list
  - id: mapqual
    type:
      - 'null'
      - boolean
    doc: print the mapping qualities
    inputBinding:
      position: 101
      prefix: -mapqual
  - id: no_header
    type:
      - 'null'
      - boolean
    doc: omit the SAM header from output
    inputBinding:
      position: 101
      prefix: -noheader
  - id: region
    type:
      - 'null'
      - string
    doc: genomic region. Index file is recommended for better performance, and is
      used automatically if it exists.
    inputBinding:
      position: 101
      prefix: -region
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: the output BAM file [stdout]
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bamtools:2.5.3--he132191_0
