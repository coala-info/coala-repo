cwlVersion: v1.2
class: CommandLineTool
baseCommand: jarvis3
label: jarvis3
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain the tool's help documentation or argument definitions.\n\n
  Tool homepage: https://github.com/cobilab/jarvis3"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jarvis3:3.7--h7b50bb2_3
stdout: jarvis3.out
