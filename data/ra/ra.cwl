cwlVersion: v1.2
class: CommandLineTool
baseCommand: ra
label: ra
doc: "A de novo DNA assembler for long reads.\n\nTool homepage: https://github.com/2dust/v2rayN"
inputs:
  - id: sequences
    type: File
    doc: Input file in FASTA/FASTQ format (can be compressed with gzip)
    inputBinding:
      position: 1
  - id: consensus_type
    type:
      - 'null'
      - string
    doc: consensus type (none, simple, partial)
    default: none
    inputBinding:
      position: 102
      prefix: --consensus-type
  - id: layout_type
    type:
      - 'null'
      - string
    doc: layout type (unitig, contig)
    default: unitig
    inputBinding:
      position: 102
      prefix: --layout-type
  - id: overlap_type
    type:
      - 'null'
      - string
    doc: overlap type (ovl, ava)
    default: ovl
    inputBinding:
      position: 102
      prefix: --overlap-type
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    default: 1
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ra:0.9--h503566f_8
stdout: ra.out
