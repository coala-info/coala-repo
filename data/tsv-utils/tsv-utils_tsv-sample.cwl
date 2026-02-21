cwlVersion: v1.2
class: CommandLineTool
baseCommand: tsv-sample
label: tsv-utils_tsv-sample
doc: "The provided text is an Apptainer/Singularity error log indicating a failure
  to build or fetch the container image due to insufficient disk space. It does not
  contain the help text or usage instructions for the 'tsv-sample' tool.\n\nTool homepage:
  https://github.com/eBay/tsv-utils"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tsv-utils:2.2.0--h9ee0642_0
stdout: tsv-utils_tsv-sample.out
