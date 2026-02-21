cwlVersion: v1.2
class: CommandLineTool
baseCommand: hardklor
label: hardklor
doc: "Hardklor is a tool for identifying peptide features in high-resolution mass
  spectrometry data. (Note: The provided text appears to be a container runtime error
  log rather than help text, so no arguments could be extracted.)\n\nTool homepage:
  https://github.com/mhoopmann/hardklor"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hardklor:2.3.2--h503566f_6
stdout: hardklor.out
