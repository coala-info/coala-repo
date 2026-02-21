cwlVersion: v1.2
class: CommandLineTool
baseCommand: gerp
label: gerp
doc: "Genomic Evolutionary Rate Profiling (GERP) is a method for identifying evolutionarily
  constrained elements in multiple alignments by comparing observed substitutions
  to the number of substitutions expected under neutrality.\n\nTool homepage: http://mendel.stanford.edu/SidowLab/downloads/gerp/index.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gerp:2.1--hfc679d8_0
stdout: gerp.out
