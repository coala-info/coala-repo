cwlVersion: v1.2
class: CommandLineTool
baseCommand: clipandmerge
label: clipandmerge
doc: "A tool for clipping and merging sequencing reads (Note: The provided text contains
  container build errors rather than help documentation, so specific arguments could
  not be extracted).\n\nTool homepage: https://github.com/apeltzer/ClipAndMerge"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clipandmerge:1.7.9--hdfd78af_0
stdout: clipandmerge.out
