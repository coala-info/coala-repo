cwlVersion: v1.2
class: CommandLineTool
baseCommand: fusion-inspector
label: fusion-inspector
doc: "FusionInspector is a component of the Trinity Cancer Transcriptome Analysis
  Toolkit, designed to perform an in-depth analysis of a specific set of candidate
  fusion genes.\n\nTool homepage: https://github.com/FusionInspector/FusionInspector"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fusion-inspector:2.10.0--py313pl5321hdfd78af_1
stdout: fusion-inspector.out
