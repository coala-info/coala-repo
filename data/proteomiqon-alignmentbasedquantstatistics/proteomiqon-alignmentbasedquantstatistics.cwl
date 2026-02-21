cwlVersion: v1.2
class: CommandLineTool
baseCommand: proteomiqon-alignmentbasedquantstatistics
label: proteomiqon-alignmentbasedquantstatistics
doc: "A tool for alignment-based quantification statistics within the Proteomiqon
  ecosystem.\n\nTool homepage: https://csbiology.github.io/ProteomIQon/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/proteomiqon-alignmentbasedquantstatistics:0.0.3--hdfd78af_0
stdout: proteomiqon-alignmentbasedquantstatistics.out
