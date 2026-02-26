cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ezaai
  - extract
label: ezaai_extract
doc: "Extract protein DB from prokaryotic genome sequence(s) using Prodigal\n\nTool
  homepage: http://leb.snu.ac.kr/ezaai"
inputs:
  - id: input
    type: File
    doc: Input prokaryotic genome sequence or directory with prokaryotic genome 
      sequences
    inputBinding:
      position: 101
      prefix: -i
  - id: label
    type:
      - 'null'
      - string
    doc: Taxonomic label for phylogenetic tree or tab separated file with labels
    inputBinding:
      position: 101
      prefix: -l
  - id: mmseqs_path
    type:
      - 'null'
      - File
    doc: Custom path to MMSeqs2 binary
    default: mmseqs
    inputBinding:
      position: 101
      prefix: -mmseqs
  - id: prodigal_path
    type:
      - 'null'
      - File
    doc: Custom path to prodigal binary
    default: prodigal
    inputBinding:
      position: 101
      prefix: -prodigal
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of CPU threads to use
    default: 1
    inputBinding:
      position: 101
      prefix: -t
  - id: tmp_dir
    type:
      - 'null'
      - Directory
    doc: Custom temporary directory
    default: /tmp/ezaai
    inputBinding:
      position: 101
      prefix: -tmp
  - id: ufasta_path
    type:
      - 'null'
      - File
    doc: Custom path to ufasta binary
    default: ufasta
    inputBinding:
      position: 101
      prefix: -ufasta
outputs:
  - id: output
    type: File
    doc: Output protein database or output directory for protein databases
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ezaai:1.2.4--hdfd78af_0
