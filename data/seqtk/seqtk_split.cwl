cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seqtk
  - split
label: seqtk_split
doc: "Split a FASTA/FASTQ file into multiple files\n\nTool homepage: https://github.com/lh3/seqtk"
inputs:
  - id: prefix
    type: string
    doc: Prefix for the output files
    inputBinding:
      position: 1
  - id: input_file
    type: File
    doc: Input FASTA/FASTQ file
    inputBinding:
      position: 2
  - id: line_length
    type:
      - 'null'
      - int
    doc: line length
    inputBinding:
      position: 103
      prefix: -l
  - id: num_files
    type:
      - 'null'
      - int
    doc: number of files
    inputBinding:
      position: 103
      prefix: -n
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqtk:1.5--h577a1d6_1
stdout: seqtk_split.out
