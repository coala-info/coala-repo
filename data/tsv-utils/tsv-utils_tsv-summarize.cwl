cwlVersion: v1.2
class: CommandLineTool
baseCommand: tsv-summarize
label: tsv-utils_tsv-summarize
doc: "The provided text does not contain help information for the tool. It is an error
  log from a failed container build (Apptainer/Singularity) due to insufficient disk
  space.\n\nTool homepage: https://github.com/eBay/tsv-utils"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tsv-utils:2.2.0--h9ee0642_0
stdout: tsv-utils_tsv-summarize.out
