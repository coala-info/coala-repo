cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - preseq
  - lc_extrap
label: preseq_lc_extrap
doc: "The provided text does not contain help information for the tool; it contains
  error logs related to a failed container build (Singularity/Apptainer). No arguments
  could be extracted.\n\nTool homepage: https://github.com/smithlabcode/preseq"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/preseq:3.2.0--hdcf5f25_6
stdout: preseq_lc_extrap.out
