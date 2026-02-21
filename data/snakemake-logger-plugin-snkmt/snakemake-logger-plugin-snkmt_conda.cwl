cwlVersion: v1.2
class: CommandLineTool
baseCommand: snakemake-logger-plugin-snkmt_conda
label: snakemake-logger-plugin-snkmt_conda
doc: "A Snakemake logger plugin (Note: The provided text appears to be execution logs
  rather than help documentation, so no arguments could be extracted).\n\nTool homepage:
  https://github.com/cademirch/snakemake-logger-plugin-snkmt"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snakemake-logger-plugin-snkmt:0.1.6--pyhdfd78af_0
stdout: snakemake-logger-plugin-snkmt_conda.out
