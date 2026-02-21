cwlVersion: v1.2
class: CommandLineTool
baseCommand: aliview
label: aliview
doc: "AliView is a graphical alignment viewer and editor. (Note: The provided text
  contains system error logs regarding a container build failure and does not contain
  CLI help documentation.)\n\nTool homepage: https://ormbunkar.se/aliview/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/aliview:1.30--hdfd78af_0
stdout: aliview.out
