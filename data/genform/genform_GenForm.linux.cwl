cwlVersion: v1.2
class: CommandLineTool
baseCommand: genform_GenForm.linux
label: genform_GenForm.linux
doc: "GenForm is a tool for molecular formula generation from mass spectrometry data.
  (Note: The provided help text contains only system error messages and no usage information.)\n
  \nTool homepage: https://sourceforge.net/projects/genform/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genform:r8--h9948957_8
stdout: genform_GenForm.linux.out
