cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - igor
  - -compute_pgen
label: igor_vdj_igor-compute_pgen
doc: "The provided text is an error log indicating a failure to build or run the container
  image (no space left on device) and does not contain the help text for the tool.
  Based on the tool name hint, this command is part of the IGoR (Inference and Generation
  of Repertoires) suite used to compute the probability of generation (Pgen) for VDJ
  sequences.\n\nTool homepage: https://github.com/qmarcou/IGoR"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/igor:v1.3.0dfsg-1-deb_cv1
stdout: igor_vdj_igor-compute_pgen.out
