cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - metawrap
  - read_qc
label: metawrap-read-qc_metawrap
doc: "The provided text is an error message indicating a failure to build or run the
  container image (no space left on device) and does not contain the help documentation
  for the tool.\n\nTool homepage: https://github.com/bxlab/metaWRAP"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metawrap-read-qc:1.3.0--hdfd78af_3
stdout: metawrap-read-qc_metawrap.out
