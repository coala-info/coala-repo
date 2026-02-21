cwlVersion: v1.2
class: CommandLineTool
baseCommand: rfmix
label: rfmix
doc: "The provided text does not contain help information for the tool; it is a fatal
  error log from a container runtime (Apptainer/Singularity) failing to fetch the
  rfmix image.\n\nTool homepage: https://github.com/slowkoni/rfmix"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rfmix:2.03.r0.9505bfa--h503566f_8
stdout: rfmix.out
