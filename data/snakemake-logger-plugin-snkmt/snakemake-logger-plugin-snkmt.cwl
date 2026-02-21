cwlVersion: v1.2
class: CommandLineTool
baseCommand: snakemake-logger-plugin-snkmt
label: snakemake-logger-plugin-snkmt
doc: "A Snakemake logger plugin (Note: The provided text is a container build log
  and does not contain CLI help documentation; no arguments could be extracted).\n
  \nTool homepage: https://github.com/cademirch/snakemake-logger-plugin-snkmt"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snakemake-logger-plugin-snkmt:0.1.6--pyhdfd78af_0
stdout: snakemake-logger-plugin-snkmt.out
