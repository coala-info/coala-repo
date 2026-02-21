cwlVersion: v1.2
class: CommandLineTool
baseCommand: vgorient_cut_and_rot_rebuild.py
label: vgorient_cut_and_rot_rebuild.py
doc: "vgorient_cut_and_rot_rebuild.py (Note: The provided text contains container
  build logs and error messages rather than command-line help documentation; therefore,
  no arguments could be extracted.)\n\nTool homepage: https://github.com/whelixw/vgOrient"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vgorient:0.1.1--pyhdfd78af_0
stdout: vgorient_cut_and_rot_rebuild.py.out
