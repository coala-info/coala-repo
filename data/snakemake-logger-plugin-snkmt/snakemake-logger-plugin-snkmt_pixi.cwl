cwlVersion: v1.2
class: CommandLineTool
baseCommand: snakemake-logger-plugin-snkmt_pixi
label: snakemake-logger-plugin-snkmt_pixi
doc: "A Snakemake logger plugin (Note: The provided text contains execution logs rather
  than a help menu; no arguments could be parsed from the input).\n\nTool homepage:
  https://github.com/cademirch/snakemake-logger-plugin-snkmt"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snakemake-logger-plugin-snkmt:0.1.6--pyhdfd78af_0
stdout: snakemake-logger-plugin-snkmt_pixi.out
