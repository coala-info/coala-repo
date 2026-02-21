cwlVersion: v1.2
class: CommandLineTool
baseCommand: shmlast
label: shmlast
doc: "The provided text does not contain help information for the tool 'shmlast'.
  It appears to be a fatal error log from a container runtime (Singularity/Apptainer)
  attempting to fetch the tool's image.\n\nTool homepage: https://github.com/camillescott/shmlast"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/shmlast:1.6--py_0
stdout: shmlast.out
