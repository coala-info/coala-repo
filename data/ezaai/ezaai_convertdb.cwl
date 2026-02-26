cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ezaai
  - convertdb
label: ezaai_convertdb
doc: "Convert protein DB into FASTA file\n\nTool homepage: http://leb.snu.ac.kr/ezaai"
inputs:
  - id: input_db
    type: File
    doc: Input protein DB
    inputBinding:
      position: 101
      prefix: -i
  - id: mmseqs_path
    type:
      - 'null'
      - File
    doc: Custom path to MMSeqs2 binary
    default: mmseqs
    inputBinding:
      position: 101
      prefix: -mmseqs
  - id: temp_dir
    type:
      - 'null'
      - Directory
    doc: Custom temporary directory
    default: /tmp/ezaai
    inputBinding:
      position: 101
      prefix: -tmp
outputs:
  - id: output_fasta
    type: File
    doc: Output FASTA file
    outputBinding:
      glob: $(inputs.output_fasta)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ezaai:1.2.4--hdfd78af_0
