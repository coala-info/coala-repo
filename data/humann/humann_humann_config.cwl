cwlVersion: v1.2
class: CommandLineTool
baseCommand: humann_config
label: humann_humann_config
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a container runtime (Apptainer/Singularity) failing
  to build an image due to insufficient disk space.\n\nTool homepage: http://huttenhower.sph.harvard.edu/humann"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/humann:3.9--py312hdfd78af_0
stdout: humann_humann_config.out
