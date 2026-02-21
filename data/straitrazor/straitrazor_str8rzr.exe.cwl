cwlVersion: v1.2
class: CommandLineTool
baseCommand: straitrazor_str8rzr.exe
label: straitrazor_str8rzr.exe
doc: "The provided text does not contain help information or a description of the
  tool; it is a container engine error log. No arguments could be extracted.\n\nTool
  homepage: https://github.com/Ahhgust/STRaitRazor"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/straitrazor:3.0.1--h9948957_7
stdout: straitrazor_str8rzr.exe.out
