cwlVersion: v1.2
class: CommandLineTool
baseCommand: scallop-umi
label: scallop-umi
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain help information, usage instructions, or argument definitions
  for the scallop-umi tool.\n\nTool homepage: https://github.com/Shao-Group/scallop-umi"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scallop-umi:1.1.0--hbce0939_0
stdout: scallop-umi.out
