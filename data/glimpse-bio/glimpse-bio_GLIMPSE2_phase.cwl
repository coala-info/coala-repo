cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - GLIMPSE2_phase
label: glimpse-bio_GLIMPSE2_phase
doc: "The provided text does not contain help information for the tool, but rather
  system error messages related to a container runtime (Apptainer/Singularity) failing
  to pull the image due to insufficient disk space.\n\nTool homepage: https://odelaneau.github.io/GLIMPSE/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/glimpse-bio:2.0.1--ha5d29c5_3
stdout: glimpse-bio_GLIMPSE2_phase.out
