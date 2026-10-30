cwlVersion: v1.2
class: CommandLineTool
baseCommand: FastqMidParser
label: ngs-bits_FastqMidParser
doc: "Counts the number of occurances of each MID in a FASTQ file.\n\nTool homepage: https://github.com/imgag/ngs-bits"
inputs:
  - id: input_file
    type:
      - File
    doc: "Input gzipped FASTQ file."
    inputBinding:
      position: 1
      prefix: -in
  - id: output_file_path
    type:
      - 'null'
      - string
    doc: "Output TXT file. If unset, writes to STDOUT. Default value: ''"
    default: mids.txt
    inputBinding:
      position: 2
      prefix: -out
  - id: lines
    type:
      - 'null'
      - int
    doc: "The number of FASTQ entries in the input file to parse. 0 is unlimited. Default value: 1000"
    inputBinding:
      position: 3
      prefix: -lines
  - id: mids
    type:
      - 'null'
      - int
    doc: "The number of top-ranking MIDs to print. 0 is unlimited. Default value: 20"
    inputBinding:
      position: 4
      prefix: -mids
  - id: sheet
    type:
      - 'null'
      - File
    doc: "Optional sample sheet CSV file as provided to CASAVA. If given, the closest match in the sample sheet is printed after each MID."
    inputBinding:
      position: 5
      prefix: -sheet
  - id: settings
    type:
      - 'null'
      - File
    doc: "Settings override file (no other settings files are used)."
    inputBinding:
      position: 100
      prefix: --settings
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: "Text file with MID counts."
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
