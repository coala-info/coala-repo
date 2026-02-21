cwlVersion: v1.2
class: CommandLineTool
baseCommand: plasmidhawk
label: plasmidhawk
doc: "A tool for plasmid identification and analysis. (Note: The provided input text
  contains container build error logs and does not list command-line arguments.)\n
  \nTool homepage: https://gitlab.com/treangenlab/plasmidhawk"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plasmidhawk:1.0.3--hdfd78af_0
stdout: plasmidhawk.out
