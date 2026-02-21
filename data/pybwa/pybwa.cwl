cwlVersion: v1.2
class: CommandLineTool
baseCommand: pybwa
label: pybwa
doc: "Python wrapper for BWA (Burrows-Wheeler Aligner)\n\nTool homepage: https://github.com/fulcrumgenomics/pybwa"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pybwa:2.2.0--py311hb456a96_0
stdout: pybwa.out
