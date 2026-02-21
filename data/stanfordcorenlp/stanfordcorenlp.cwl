cwlVersion: v1.2
class: CommandLineTool
baseCommand: stanfordcorenlp
label: stanfordcorenlp
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be a container build error log.\n\nTool homepage: https://github.com/elisa-aleman/StanfordCoreNLP_Chinese"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/stanfordcorenlp:3.9.1.1
stdout: stanfordcorenlp.out
