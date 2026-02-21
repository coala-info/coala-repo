cwlVersion: v1.2
class: CommandLineTool
baseCommand: ushuffle
label: ushuffle
doc: "A tool for shuffling biological sequences while preserving k-let counts. (Note:
  The provided text contains error logs from a container runtime and does not include
  the actual help documentation for the tool.)\n\nTool homepage: http://digital.cs.usu.edu/~mjiang/ushuffle/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ushuffle:1.2.2--py36h91eb985_5
stdout: ushuffle.out
