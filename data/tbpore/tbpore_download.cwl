cwlVersion: v1.2
class: CommandLineTool
baseCommand: tbpore_download
label: tbpore_download
doc: "Downloads and validates the decontamination database for TBpore.\n\nTool homepage:
  https://github.com/mbhall88/tbpore/"
inputs:
  - id: download_dir
    type:
      - 'null'
      - Directory
    doc: Directory to download the decontamination database to.
    default: /root/.tbpore/decontamination_db
    inputBinding:
      position: 101
      prefix: --download-dir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tbpore:0.7.1--pyhdfd78af_0
stdout: tbpore_download.out
