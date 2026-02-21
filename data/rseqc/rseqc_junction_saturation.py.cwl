cwlVersion: v1.2
class: CommandLineTool
baseCommand: rseqc_junction_saturation.py
label: rseqc_junction_saturation.py
doc: "The provided text contains a container runtime error log rather than the tool's
  help text. Based on the tool name hint 'rseqc_junction_saturation.py', this tool
  typically checks if the current sequencing depth is sufficient to detect splice
  junctions by subsampling the total reads.\n\nTool homepage: https://rseqc.sourceforge.net"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rseqc:5.0.4--pyhdfd78af_1
stdout: rseqc_junction_saturation.py.out
