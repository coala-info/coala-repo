cwlVersion: v1.2
class: CommandLineTool
baseCommand: mirfix_testMIRfix.sh
label: mirfix_testMIRfix.sh
doc: "A script for testing MIRfix. (Note: The provided input text contains container
  runtime error messages and does not include usage instructions or argument definitions.)\n
  \nTool homepage: https://github.com/Bierinformatik/MIRfix"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mirfix:2.1.1--hdfd78af_0
stdout: mirfix_testMIRfix.sh.out
