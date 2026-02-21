cwlVersion: v1.2
class: CommandLineTool
baseCommand: tsv-utils
label: tsv-utils
doc: "The provided text does not contain help information for tsv-utils; it is a log
  of a failed container build (Apptainer/Singularity) due to insufficient disk space.\n
  \nTool homepage: https://github.com/eBay/tsv-utils"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tsv-utils:2.2.0--h9ee0642_0
stdout: tsv-utils.out
