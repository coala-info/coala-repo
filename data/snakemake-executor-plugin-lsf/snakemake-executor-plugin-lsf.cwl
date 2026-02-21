cwlVersion: v1.2
class: CommandLineTool
baseCommand: snakemake-executor-plugin-lsf
label: snakemake-executor-plugin-lsf
doc: "Snakemake executor plugin for LSF. (Note: The provided text is a container execution
  error log and does not contain help documentation or argument definitions.)\n\n
  Tool homepage: https://github.com/befh/snakemake-executor-plugin-lsf"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snakemake-executor-plugin-lsf:0.2.6--pyhdfd78af_0
stdout: snakemake-executor-plugin-lsf.out
