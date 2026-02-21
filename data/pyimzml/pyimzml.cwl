cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyimzml
label: pyimzml
doc: "The provided text does not contain help information for the tool. It appears
  to be a container runtime error log (Apptainer/Singularity) indicating a failure
  to fetch or build the image.\n\nTool homepage: https://github.com/alexandrovteam/pyimzML"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyimzml:1.5.1--pyh5e36f6f_0
stdout: pyimzml.out
