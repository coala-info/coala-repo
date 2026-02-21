cwlVersion: v1.2
class: CommandLineTool
baseCommand: proteomiqon-mzmltomzlite
label: proteomiqon-mzmltomzlite
doc: "The provided text does not contain help information or a description of the
  tool. It appears to be a log of a failed container build process.\n\nTool homepage:
  https://csbiology.github.io/ProteomIQon/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/proteomiqon-mzmltomzlite:0.0.8--hdfd78af_0
stdout: proteomiqon-mzmltomzlite.out
