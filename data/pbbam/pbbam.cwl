cwlVersion: v1.2
class: CommandLineTool
baseCommand: pbbam
label: pbbam
doc: "The provided text is a system error log indicating a failure to build or run
  a Singularity container due to insufficient disk space ('no space left on device').
  It does not contain CLI help text, usage instructions, or argument definitions.\n\
  \nTool homepage: https://github.com/PacificBiosciences/pbbam"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pbbam:2.4.0--h077b44d_2
stdout: pbbam.out
