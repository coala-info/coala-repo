cwlVersion: v1.2
class: CommandLineTool
baseCommand: jccirc
label: jccirc
doc: "The provided text contains container runtime error messages (Singularity/Apptainer)
  rather than the help documentation for the jccirc tool. As a result, no arguments
  or tool descriptions could be extracted.\n\nTool homepage: https://github.com/cbbzhang/JCcirc"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jccirc:1.0.0--hdfd78af_1
stdout: jccirc.out
