cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - caspeak
  - align
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
      - string
    doc: 'working directory to create (default: current directory)'
    inputBinding:
      position: 101
      prefix: --workdir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: lastdb
    type:
      - 'null'
      - Directory
    doc: LAST databases of the reference and insert
    outputBinding:
      glob: "$((inputs.workdir ? inputs.workdir + '/' : '') + 'lastdb')"
  - id: lastal
    type:
      - 'null'
      - Directory
    doc: Read alignments (read_to_ref.maf, read_to_insert.maf)
    outputBinding:
      glob: "$((inputs.workdir ? inputs.workdir + '/' : '') + 'lastal')"
  - id: work_dir
    type:
      - 'null'
      - Directory
    doc: The whole working directory (only when workdir is set)
    outputBinding:
      glob: '$(inputs.workdir ? inputs.workdir : [])'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/caspeak:1.1.5--pyhdfd78af_0
stdout: caspeak_align.out
