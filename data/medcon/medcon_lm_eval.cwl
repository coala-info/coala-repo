cwlVersion: v1.2
class: CommandLineTool
baseCommand: medcon_lm_eval
label: medcon_lm_eval
doc: "The provided text does not contain help information for the tool; it is an error
  log from a container runtime (Apptainer/Singularity) indicating a failure to pull
  or build the container image due to insufficient disk space.\n\nTool homepage: https://github.com/nadavlab/MedConceptsQA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/medcon:v0.16.1dfsg-1-deb_cv1
stdout: medcon_lm_eval.out
