cwlVersion: v1.2
class: CommandLineTool
baseCommand: CanSNPer2-download
label: cansnper2_CanSNPer2-download
doc: "CanSNPer2-download\n\nTool homepage: https://github.com/FOI-Bioinformatics/CanSNPer2"
inputs:
  - id: database
    type: string
    doc: CanSNP database
    inputBinding:
      position: 101
      prefix: --database
  - id: logs
    type:
      - 'null'
      - boolean
    doc: Specify log directory
    inputBinding:
      position: 101
      prefix: --logs
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: reference genomes folder
    inputBinding:
      position: 101
      prefix: --outdir
  - id: source
    type:
      - 'null'
      - string
    doc: Source for download (genbank/refseq)
    inputBinding:
      position: 101
      prefix: --source
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose logging
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cansnper2:2.0.6--py_0
stdout: cansnper2_CanSNPer2-download.out
