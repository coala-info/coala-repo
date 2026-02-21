cwlVersion: v1.2
class: CommandLineTool
baseCommand: snakemake
label: snakemake-logger-plugin-snkmt_snakemake
doc: "A Snakemake logger plugin. (Note: The provided text contains execution logs
  and error messages rather than a help menu; therefore, no command-line arguments
  could be extracted.)\n\nTool homepage: https://github.com/cademirch/snakemake-logger-plugin-snkmt"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snakemake-logger-plugin-snkmt:0.1.6--pyhdfd78af_0
stdout: snakemake-logger-plugin-snkmt_snakemake.out
