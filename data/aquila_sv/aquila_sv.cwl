cwlVersion: v1.2
class: CommandLineTool
baseCommand: aquila_sv
label: aquila_sv
doc: "The provided text appears to be an error log from a Singularity/Apptainer container
  build process rather than the help text for the tool 'aquila_sv'. As a result, no
  command-line arguments could be extracted from the input.\n\nTool homepage: https://github.com/maiziezhoulab/AquilaSV"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/aquila:1.0.0--py_0
stdout: aquila_sv.out
