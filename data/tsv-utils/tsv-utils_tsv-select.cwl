cwlVersion: v1.2
class: CommandLineTool
baseCommand: tsv-select
label: tsv-utils_tsv-select
doc: "The provided text is an error log from a container build process (Apptainer/Singularity)
  and does not contain the help text or usage information for the tsv-select tool.\n
  \nTool homepage: https://github.com/eBay/tsv-utils"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tsv-utils:2.2.0--h9ee0642_0
stdout: tsv-utils_tsv-select.out
