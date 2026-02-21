cwlVersion: v1.2
class: CommandLineTool
baseCommand: ndex2
label: ndex2
doc: "The provided text does not contain help information for the ndex2 tool; it contains
  system error messages related to a container runtime (Apptainer/Singularity) failing
  to build the image due to insufficient disk space.\n\nTool homepage: https://github.com/ndexbio/ndex2-client"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ndex2:3.11.0--pyhdfd78af_0
stdout: ndex2.out
