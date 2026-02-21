cwlVersion: v1.2
class: CommandLineTool
baseCommand: straitrazor_batchCstr8.bat
label: straitrazor_batchCstr8.bat
doc: "A batch processing tool for STRait Razor. Note: The provided text appears to
  be a container runtime error log rather than help documentation, so no specific
  arguments could be extracted.\n\nTool homepage: https://github.com/Ahhgust/STRaitRazor"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/straitrazor:3.0.1--h9948957_7
stdout: straitrazor_batchCstr8.bat.out
