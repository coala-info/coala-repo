cwlVersion: v1.2
class: CommandLineTool
baseCommand: mudirac
label: mudirac
doc: "The provided text does not contain help information for the tool; it contains
  container runtime error messages regarding a lack of disk space during image conversion.\n
  \nTool homepage: https://github.com/muon-spectroscopy-computational-project/mudirac"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mudirac:1.0.1
stdout: mudirac.out
