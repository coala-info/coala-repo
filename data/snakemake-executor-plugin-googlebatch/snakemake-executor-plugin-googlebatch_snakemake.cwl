cwlVersion: v1.2
class: CommandLineTool
baseCommand: snakemake
label: snakemake-executor-plugin-googlebatch_snakemake
doc: "Snakemake executor plugin for Google Batch. (Note: The provided text appears
  to be a container build log/error rather than CLI help text; no arguments could
  be extracted from the input.)\n\nTool homepage: https://github.com/snakemake/snakemake-executor-plugin-googlebatch"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snakemake-executor-plugin-googlebatch:0.5.1--pyhdfd78af_0
stdout: snakemake-executor-plugin-googlebatch_snakemake.out
