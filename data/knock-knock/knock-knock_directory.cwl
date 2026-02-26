cwlVersion: v1.2
class: CommandLineTool
baseCommand: knock-knock
label: knock-knock_directory
doc: "A tool for analyzing genomic data, with various subcommands for different tasks.\n\
  \nTool homepage: https://github.com/jeffhussmann/knock-knock"
inputs:
  - id: subcommand
    type: string
    doc: 'The subcommand to run. Available choices: process-sample, parallel, table,
      build-strategies, download-genome, build-indices, install-example-data, whos-there'
    inputBinding:
      position: 1
  - id: subcommand_args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for the chosen subcommand
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/knock-knock:0.8.0--pyhdfd78af_0
stdout: knock-knock_directory.out
