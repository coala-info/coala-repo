cwlVersion: v1.2
class: CommandLineTool
baseCommand: tsv-pretty
label: tsv-utils_tsv-pretty
doc: "The provided text does not contain help documentation for the tool, but rather
  system error messages related to a failed container build (Apptainer/Singularity).
  No arguments could be extracted.\n\nTool homepage: https://github.com/eBay/tsv-utils"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tsv-utils:2.2.0--h9ee0642_0
stdout: tsv-utils_tsv-pretty.out
