cwlVersion: v1.2
class: CommandLineTool
baseCommand: pos2bed.pl
label: homer_pos2bed.pl
doc: "Convert a HOMER peak/position file to BED format (written to standard output)\n\nTool homepage: http://homer.ucsd.edu/homer/index.html"
inputs:
  - id: peak_file
    type: File
    doc: 'Peak or position file'
    inputBinding:
      position: 2
      valueFrom: $(inputs.peak_file.basename)
  - id: o
    type:
      - 'null'
      - string
    doc: 'output to this file instead of standard output'
    inputBinding:
      position: 1
      prefix: '-o'
  - id: bed
    type:
      - 'null'
      - boolean
    doc: 'output to a file with the same name as the input with a .bed extension'
    inputBinding:
      position: 1
      prefix: '-bed'
  - id: track
    type:
      - 'null'
      - string
    doc: 'include a track line with this name for uploading to the UCSC Genome Browser'
    inputBinding:
      position: 1
      prefix: '-track'
  - id: five
    type:
      - 'null'
      - boolean
    doc: 'set the 5th column to the value 1 instead of the value in the 6th column of the pos file'
    inputBinding:
      position: 1
      prefix: '-5'
  - id: float
    type:
      - 'null'
      - boolean
    doc: 'allow the 5th column to be a floating point number (default: integer)'
    inputBinding:
      position: 1
      prefix: '-float'
  - id: color
    type:
      - 'null'
      - string
    doc: 'color strands red and blue (value: strand); also adds a track line'
    inputBinding:
      position: 1
      prefix: '-color'
outputs:
  - id: bed_stdout
    type: stdout
    doc: 'BED output (standard output)'
  - id: bed_file
    type:
      - 'null'
      - File
    doc: 'BED file written with -o'
    outputBinding:
      glob: $(inputs.o)
  - id: bed_named
    type:
      - 'null'
      - File
    doc: 'BED file written with -bed (input name with .bed extension)'
    outputBinding:
      glob: $(inputs.peak_file.nameroot).bed
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.peak_file)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/homer:5.1--pl5262h9948957_0
stdout: homer_pos2bed.out
