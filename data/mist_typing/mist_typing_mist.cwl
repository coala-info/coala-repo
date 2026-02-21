cwlVersion: v1.2
class: CommandLineTool
baseCommand: mist_typing
label: mist_typing_mist
doc: "MIST (Multilocus sequence typing from In Silico Typing)\n\nTool homepage: https://github.com/BioinformaticsPlatformWIV-ISP/MiST"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mist_typing:1.1.0--pyhdfd78af_0
stdout: mist_typing_mist.out
