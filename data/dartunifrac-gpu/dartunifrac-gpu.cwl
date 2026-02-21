cwlVersion: v1.2
class: CommandLineTool
baseCommand: dartunifrac-gpu
label: dartunifrac-gpu
doc: "A tool for calculating UniFrac distances using GPU acceleration. (Note: The
  provided text contains container build error logs rather than the tool's help documentation,
  so specific arguments could not be extracted.)\n\nTool homepage: https://github.com/jianshu93/DartUniFrac"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dartunifrac-gpu:0.2.9--hd7384ae_0
stdout: dartunifrac-gpu.out
