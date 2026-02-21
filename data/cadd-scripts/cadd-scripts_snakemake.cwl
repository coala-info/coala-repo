cwlVersion: v1.2
class: CommandLineTool
baseCommand: cadd-scripts
label: cadd-scripts_snakemake
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a log of a failed container build/execution due to insufficient disk
  space.\n\nTool homepage: https://github.com/kircherlab/CADD-scripts"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cadd-scripts:1.7.3--hdfd78af_0
stdout: cadd-scripts_snakemake.out
