cwlVersion: v1.2
class: CommandLineTool
baseCommand: readItAndKeep
label: read-it-and-keep_readItAndKeep
doc: "A tool for filtering sequencing reads (Note: The provided help text contains
  only container runtime error messages and no usage information).\n\nTool homepage:
  https://github.com/GenomePathogenAnalysisService/read-it-and-keep"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/read-it-and-keep:0.3.0--h5ca1c30_3
stdout: read-it-and-keep_readItAndKeep.out
