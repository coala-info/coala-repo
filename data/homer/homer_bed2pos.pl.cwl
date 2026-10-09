cwlVersion: v1.2
class: CommandLineTool
baseCommand: bed2pos.pl
label: homer_bed2pos.pl
doc: "Convert a BED file to a HOMER position/peak file (written to standard output)\n\nTool homepage: http://homer.ucsd.edu/homer/index.html"
inputs:
  - id: bed_file
    type: File
    doc: 'BED file'
    inputBinding:
      position: 2
      valueFrom: $(inputs.bed_file.basename)
  - id: check
    type:
      - 'null'
      - boolean
    doc: 'check if the file is already peak/pos formatted'
    inputBinding:
      position: 1
      prefix: '-check'
  - id: unique
    type:
      - 'null'
      - boolean
    doc: 'make peak names unique by adding numbers to replicate names'
    inputBinding:
      position: 1
      prefix: '-unique'
  - id: o
    type:
      - 'null'
      - string
    doc: 'send output to this file (default: standard output)'
    inputBinding:
      position: 1
      prefix: '-o'
  - id: pos
    type:
      - 'null'
      - boolean
    doc: 'send output to a file with the same name as the input file with a .pos extension'
    inputBinding:
      position: 1
      prefix: '-pos'
outputs:
  - id: pos_stdout
    type: stdout
    doc: 'Position file (standard output)'
  - id: pos_file
    type:
      - 'null'
      - File
    doc: 'Position file written with -o'
    outputBinding:
      glob: $(inputs.o)
  - id: pos_named
    type:
      - 'null'
      - File
    doc: 'Position file written with -pos (input name with .pos extension)'
    outputBinding:
      glob: $(inputs.bed_file.nameroot).pos
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.bed_file)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/homer:5.1--pl5262h9948957_0
stdout: homer_bed2pos.out
