cwlVersion: v1.2
class: CommandLineTool
baseCommand: fs
label: finestructure_fs
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a container runtime (Apptainer/Singularity) failing
  to pull a Docker image due to insufficient disk space.\n\nTool homepage: https://people.maths.bris.ac.uk/~madjl/finestructure/finestructure.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/finestructure:4.1.1--pl5321hdfd78af_0
stdout: finestructure_fs.out
