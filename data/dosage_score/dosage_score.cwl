cwlVersion: v1.2
class: CommandLineTool
baseCommand: dosage_score
label: dosage_score
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a container runtime (Apptainer/Singularity) failing
  to pull the image due to insufficient disk space.\n\nTool homepage: https://github.com/SegawaTenta/Dosage-score"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dosage_score:1.0.0--pyhdfd78af_0
stdout: dosage_score.out
