cwlVersion: v1.2
class: CommandLineTool
baseCommand: FusionInspector
label: fusion-inspector_FusionInspector
doc: "FusionInspector is a component of the STAR-Fusion suite used for in-silico validation
  of fusion transcripts. (Note: The provided help text contains only system error
  logs and no usage information; arguments could not be extracted from the input.)\n
  \nTool homepage: https://github.com/FusionInspector/FusionInspector"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fusion-inspector:2.10.0--py313pl5321hdfd78af_1
stdout: fusion-inspector_FusionInspector.out
