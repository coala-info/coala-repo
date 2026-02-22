cwlVersion: v1.2
class: CommandLineTool
baseCommand: amplify
label: amplify
doc: "A tool for predicting antimicrobial peptides (Note: The provided text is a container
  build log and does not contain CLI help information).\n\nTool homepage: https://github.com/bcgsc/AMPlify"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/amplify:2.0.1--py36hdfd78af_0
stdout: amplify.out
