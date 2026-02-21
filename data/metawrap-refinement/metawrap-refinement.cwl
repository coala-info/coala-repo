cwlVersion: v1.2
class: CommandLineTool
baseCommand: metawrap-refinement
label: metawrap-refinement
doc: "The provided text is a system error message indicating a failure to build or
  run the container (no space left on device) and does not contain help documentation
  or argument definitions.\n\nTool homepage: https://github.com/bxlab/metaWRAP"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metawrap-refinement:1.3.0--hdfd78af_3
stdout: metawrap-refinement.out
