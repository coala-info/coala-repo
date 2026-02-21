cwlVersion: v1.2
class: CommandLineTool
baseCommand: geomloss
label: geomloss
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a container runtime (Singularity/Apptainer) failing
  to pull the geomloss image due to insufficient disk space.\n\nTool homepage: https://github.com/jeanfeydy/geomloss"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/geomloss:0.2.6--pyh7e72e81_0
stdout: geomloss.out
