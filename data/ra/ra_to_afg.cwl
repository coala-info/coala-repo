cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - to_afg
label: ra_to_afg
doc: "Converts reads from FASTA/FASTQ to AFG format (reads written to standard output\
  \ or --out).\n\nTool homepage: https://github.com/mariokostelac/ra"
inputs:
  - id: reads
    type: File
    doc: input fasta/fastq reads file
    inputBinding:
      position: 1
      prefix: -i
  - id: fastq
    type:
      - 'null'
      - boolean
    doc: format of the input reads file is FASTQ (default is FASTA)
    inputBinding:
      position: 102
      prefix: --fastq
  - id: out
    type:
      - 'null'
      - string
    doc: 'output afg reads file name (default: standard output)'
    inputBinding:
      position: 102
      prefix: -o
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: out_afg
    type:
      - 'null'
      - File
    doc: AFG reads file written with the out option
    outputBinding:
      glob: $(inputs.out || '__none__')
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ra:0.9--h503566f_8
stdout: ra_to_afg.out
