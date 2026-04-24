cwlVersion: v1.2
class: CommandLineTool
baseCommand: popins2 place-splitalign
label: popins2_place-splitalign
doc: "Contig placing by split-read alignment.\n\nTool homepage: https://github.com/kehrlab/PopIns2"
inputs:
  - id: sample_id
    type: string
    doc: SAMPLE_ID
    inputBinding:
      position: 1
  - id: contigs
    type:
      - 'null'
      - File
    doc: 'Name of supercontigs file. Valid filetypes are: fa, fna, and fasta.'
    inputBinding:
      position: 102
      prefix: --contigs
  - id: max_insert_size
    type:
      - 'null'
      - int
    doc: The maximum expected insert size of the read pairs.
    inputBinding:
      position: 102
      prefix: --maxInsertSize
  - id: prefix
    type:
      - 'null'
      - Directory
    doc: Path to the sample directories.
    inputBinding:
      position: 102
      prefix: --prefix
  - id: read_length
    type:
      - 'null'
      - int
    doc: The length of the reads.
    inputBinding:
      position: 102
      prefix: --readLength
  - id: reference
    type:
      - 'null'
      - File
    doc: 'Name of reference genome file. Valid filetypes are: fa, fna, and fasta.'
    inputBinding:
      position: 102
      prefix: --reference
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/popins2:0.13.0--h077b44d_0
stdout: popins2_place-splitalign.out
