cwlVersion: v1.2
class: CommandLineTool
baseCommand: xmatchview
label: xmatchview
doc: "A tool for visualizing cross-match alignments. (Note: The provided text contains
  error logs from a container runtime and does not include the tool's help documentation
  or argument definitions.)\n\nTool homepage: http://www.bcgsc.ca/platform/bioinfo/software/xmatchview"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/xmatchview:1.2.5--hdfd78af_1
stdout: xmatchview.out
