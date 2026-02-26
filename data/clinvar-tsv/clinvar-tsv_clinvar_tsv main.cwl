cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - clinvar-tsv
  - main
label: clinvar-tsv_clinvar_tsv main
doc: "Main command for clinvar-tsv\n\nTool homepage: https://github.com/bihealth/clinvar-tsv"
inputs:
  - id: b37_path
    type: File
    doc: Path to GRCh37 FAI-indexed FASTA file.
    inputBinding:
      position: 101
      prefix: --b37-path
  - id: b38_path
    type: File
    doc: Path to GRCh38 FAI-indexed FASTA file.
    inputBinding:
      position: 101
      prefix: --b38-path
  - id: clinvar_version
    type: string
    doc: String to put as clinvar version
    inputBinding:
      position: 101
      prefix: --clinvar-version
  - id: cores
    type:
      - 'null'
      - int
    doc: Number of cores to use
    inputBinding:
      position: 101
      prefix: --cores
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Enables debugging helps
    inputBinding:
      position: 101
      prefix: --debug
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output
    inputBinding:
      position: 101
      prefix: --verbose
  - id: work_dir
    type:
      - 'null'
      - Directory
    doc: Path to working directory
    inputBinding:
      position: 101
      prefix: --work-dir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clinvar-tsv:0.6.3--pyhdfd78af_0
stdout: clinvar-tsv_clinvar_tsv main.out
