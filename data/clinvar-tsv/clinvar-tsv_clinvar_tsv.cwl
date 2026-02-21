cwlVersion: v1.2
class: CommandLineTool
baseCommand: clinvar-tsv
label: clinvar-tsv_clinvar_tsv
doc: "The provided text does not contain help information for the tool. It is a system
  error log indicating a failure to build or extract the container image due to insufficient
  disk space ('no space left on device').\n\nTool homepage: https://github.com/bihealth/clinvar-tsv"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clinvar-tsv:0.6.3--pyhdfd78af_0
stdout: clinvar-tsv_clinvar_tsv.out
