cwlVersion: v1.2
class: CommandLineTool
baseCommand: MoGAAAP
label: mogaaap_MoGAAAP
doc: "This is a wrapper script around the MoGAAAP Snakemake workflow.\n\nTool homepage:
  https://github.com/dirkjanvw/MoGAAAP"
inputs:
  - id: command
    type: string
    doc: The command to execute (init, download_databases, configure, run)
    inputBinding:
      position: 1
  - id: args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for the command
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mogaaap:1.1.0--pyhdfd78af_0
stdout: mogaaap_MoGAAAP.out
