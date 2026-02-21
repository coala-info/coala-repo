cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - socru
  - create
label: socru_socru_create
doc: "The provided text does not contain help information for the tool; it appears
  to be a fatal error log from a container runtime (Apptainer/Singularity) failing
  to fetch the tool's image.\n\nTool homepage: https://github.com/quadram-institute-bioscience/socru"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/socru:2.2.5--pyhdfd78af_0
stdout: socru_socru_create.out
