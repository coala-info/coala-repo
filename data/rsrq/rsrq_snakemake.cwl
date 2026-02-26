cwlVersion: v1.2
class: CommandLineTool
baseCommand: rsrq snakemake
label: rsrq_snakemake
doc: "Commands that can be issued by Snakemake for cluster execution\n\nTool homepage:
  https://github.com/aaronmussig/rsrq"
inputs:
  - id: command
    type:
      - 'null'
      - string
    doc: The Snakemake command to execute (submit, status, cancel, config, help)
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rsrq:1.1.0--h4349ce8_0
stdout: rsrq_snakemake.out
