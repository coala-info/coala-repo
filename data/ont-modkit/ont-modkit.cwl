cwlVersion: v1.2
class: CommandLineTool
baseCommand: modkit
label: ont-modkit
doc: "A tool for analyzing and manipulating DNA/RNA modification data from Oxford
  Nanopore Technologies (ONT) sequencing.\n\nTool homepage: https://github.com/nanoporetech/modkit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ont-modkit:0.6.1--hcdda2d0_0
stdout: ont-modkit.out
