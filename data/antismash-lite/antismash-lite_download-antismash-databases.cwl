cwlVersion: v1.2
class: CommandLineTool
baseCommand: download-antismash-databases
label: antismash-lite_download-antismash-databases
doc: "Base directory for the antiSMASH databases\n\nTool homepage: https://docs.antismash.secondarymetabolites.org/intro/"
inputs:
  - id: database_dir
    type:
      - 'null'
      - string
    doc: Base directory for the antiSMASH databases
    inputBinding:
      position: 101
      prefix: --database-dir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: databases
    type:
      - 'null'
      - Directory
    doc: Downloaded antiSMASH databases
    outputBinding:
      glob: $(inputs.database_dir)
requirements:
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/antismash-lite:8.0.1--pyhdfd78af_0
stdout: antismash-lite_download-antismash-databases.out
