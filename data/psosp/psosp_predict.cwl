cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - psosp
  - predict
label: psosp_predict
doc: "Predict virus-host interactions using psosp\n\nTool homepage: https://github.com/mujiezhang/PSOSP"
inputs:
  - id: checkv_db
    type:
      - 'null'
      - Directory
    doc: checkv reference database path (optional)
    inputBinding:
      position: 101
      prefix: --checkv_db
  - id: host_faa
    type:
      - 'null'
      - File
    doc: Host faa file path (optional, will run prodigal if not provided)
    inputBinding:
      position: 101
      prefix: --host_faa
  - id: host_fasta
    type: File
    doc: Host genome fasta file
    inputBinding:
      position: 101
      prefix: --host_fasta
  - id: virus_fasta
    type: File
    doc: Virus genome fasta file (can contain multiple viruses)
    inputBinding:
      position: 101
      prefix: --virus_fasta
outputs:
  - id: working_dir
    type: Directory
    doc: Output directory path
    outputBinding:
      glob: $(inputs.working_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/psosp:1.1.2--pyhdfd78af_2
