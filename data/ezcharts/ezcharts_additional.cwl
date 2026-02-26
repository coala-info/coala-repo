cwlVersion: v1.2
class: CommandLineTool
baseCommand: ezcharts
label: ezcharts_additional
doc: "ezcharts: A tool for generating plots and reports from various bioinformatics
  tool outputs.\n\nTool homepage: https://github.com/epi2me-labs/ezcharts"
inputs:
  - id: command
    type: string
    doc: 'The subcommand to execute (choices: params, nextclade, fastcat, dss, modkit,
      mosdepth, clinvar, bcfstats, status, demo, plots, ideogram)'
    inputBinding:
      position: 1
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Enable debug logging
    inputBinding:
      position: 102
      prefix: --debug
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Suppress output messages
    inputBinding:
      position: 102
      prefix: --quiet
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Increase output verbosity
    inputBinding:
      position: 102
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ezcharts:0.15.2--pyhdfd78af_0
stdout: ezcharts_additional.out
