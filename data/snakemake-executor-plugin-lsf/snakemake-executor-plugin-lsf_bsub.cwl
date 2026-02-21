cwlVersion: v1.2
class: CommandLineTool
baseCommand: snakemake-executor-plugin-lsf_bsub
label: snakemake-executor-plugin-lsf_bsub
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be a log output from a failed container build process.\n
  \nTool homepage: https://github.com/befh/snakemake-executor-plugin-lsf"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snakemake-executor-plugin-lsf:0.2.6--pyhdfd78af_0
stdout: snakemake-executor-plugin-lsf_bsub.out
