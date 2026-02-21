cwlVersion: v1.2
class: CommandLineTool
baseCommand: recognizer
label: recognizer
doc: "The provided text appears to be a system log or error message from a container
  runtime (Apptainer/Singularity) rather than CLI help text. As a result, no functional
  arguments, flags, or descriptions could be extracted.\n\nTool homepage: https://github.com/iquasere/reCOGnizer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/recognizer:1.11.1--hdfd78af_0
stdout: recognizer.out
