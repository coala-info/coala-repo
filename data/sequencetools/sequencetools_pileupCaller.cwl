cwlVersion: v1.2
class: CommandLineTool
baseCommand: pileupCaller
label: sequencetools_pileupCaller
doc: "The provided text is an error log indicating a failure to build or run the container
  (no space left on device) and does not contain the tool's help documentation or
  argument definitions.\n\nTool homepage: https://github.com/stschiff/sequenceTools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sequencetools:1.6.0.0--hebebf5b_0
stdout: sequencetools_pileupCaller.out
