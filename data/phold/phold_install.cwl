cwlVersion: v1.2
class: CommandLineTool
baseCommand: phold_install
label: phold_install
doc: "Installs ProstT5 model and phold database\n\nTool homepage: https://github.com/gbouras13/phold"
inputs:
  - id: database
    type:
      - 'null'
      - Directory
    doc: Specific path to install the phold database
    inputBinding:
      position: 101
      prefix: --database
  - id: extended_db
    type:
      - 'null'
      - boolean
    doc: Download the extended Phold DB 3.16M including 1.8M efam and enVhog 
      proteins without functional labels instead of the default Phold Search 
      1.36M. Using the extended database will likely marginally reduce 
      functional annotation sensitivity and increase runtime, but may find more 
      hits overall i.e. including to efam and enVhog proteins that have no 
      functional labels.
    inputBinding:
      position: 101
      prefix: --extended_db
  - id: foldseek_gpu
    type:
      - 'null'
      - boolean
    doc: Use this to enable compatibility with Foldseek-GPU acceleration
    inputBinding:
      position: 101
      prefix: --foldseek_gpu
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phold:1.2.2--pyhdfd78af_0
stdout: phold_install.out
