cwlVersion: v1.2
class: CommandLineTool
baseCommand: lemur
label: lemur
doc: "The provided text does not contain help information or usage instructions for
  the tool 'lemur'. It consists of error logs from a container runtime (Apptainer/Singularity)
  indicating a failure to pull or build the container image due to insufficient disk
  space.\n\nTool homepage: https://github.com/treangenlab/lemur"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lemur:1.0.1--hdfd78af_0
stdout: lemur.out
