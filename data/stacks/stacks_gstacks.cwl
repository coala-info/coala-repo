cwlVersion: v1.2
class: CommandLineTool
baseCommand: gstacks
label: stacks_gstacks
doc: "The provided text is a container runtime error log (Apptainer/Singularity) and
  does not contain help or usage information for the tool 'gstacks'.\n\nTool homepage:
  https://catchenlab.life.illinois.edu/stacks/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/stacks:2.68--h077b44d_3
stdout: stacks_gstacks.out
