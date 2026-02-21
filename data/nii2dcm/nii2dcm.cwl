cwlVersion: v1.2
class: CommandLineTool
baseCommand: nii2dcm
label: nii2dcm
doc: "NIfTI to DICOM converter (Note: The provided text contains container runtime
  error messages rather than tool help text; no arguments could be extracted from
  the input).\n\nTool homepage: https://github.com/tomaroberts/nii2dcm"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nii2dcm:0.1.2--pyhdfd78af_0
stdout: nii2dcm.out
