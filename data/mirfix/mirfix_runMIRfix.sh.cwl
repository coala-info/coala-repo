cwlVersion: v1.2
class: CommandLineTool
baseCommand: mirfix_runMIRfix.sh
label: mirfix_runMIRfix.sh
doc: "MIRfix is a tool for miRNA sequence analysis and fixing. Note: The provided
  help text contains only container runtime error messages and does not list specific
  command-line arguments.\n\nTool homepage: https://github.com/Bierinformatik/MIRfix"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mirfix:2.1.1--hdfd78af_0
stdout: mirfix_runMIRfix.sh.out
