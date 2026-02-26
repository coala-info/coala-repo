cwlVersion: v1.2
class: CommandLineTool
baseCommand: caspeak_align
label: caspeak_align
doc: "Aligns reads to a reference genome, considering MEI insertions.\n\nTool homepage:
  https://github.com/Rye-lxy/CasPeak"
inputs:
  - id: insert_file
    type: File
    doc: consensus sequence of the MEI FASTA file (required)
    inputBinding:
      position: 101
      prefix: --insert
  - id: read_file
    type: File
    doc: the read FASTA/FATSQ file (required)
    inputBinding:
      position: 101
      prefix: --read
  - id: ref_file
    type: File
    doc: the reference genome FASTA file (required)
    inputBinding:
      position: 101
      prefix: --ref
  - id: thread
    type:
      - 'null'
      - int
    doc: 'number of threads (default: 1)'
    default: 1
    inputBinding:
      position: 101
      prefix: --thread
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: show progress messages and data
    inputBinding:
      position: 101
      prefix: --verbose
  - id: workdir
    type:
      - 'null'
      - Directory
    doc: 'working directory (default: current directory)'
    default: current directory
    inputBinding:
      position: 101
      prefix: --workdir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/caspeak:1.1.5--pyhdfd78af_0
stdout: caspeak_align.out
