cwlVersion: v1.2
class: CommandLineTool
baseCommand: deepmei
label: deepmei
doc: "Deep learning-based Mobile Element Insertion (MEI) detection tool.\n\nTool homepage:
  https://github.com/Kanglu123/deepmei"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepmei:1.6.24--hdfd78af_1
stdout: deepmei.out
