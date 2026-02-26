cwlVersion: v1.2
class: CommandLineTool
baseCommand: chainStitchId
label: ucsc-chainstitchid
doc: "A UCSC Genome Browser tool used to join chain fragments into larger chains and
  assign unique IDs. (Note: The provided help text was incomplete due to a system
  error, but the tool is part of the UCSC Genome Browser chain/net utility suite.)\n\
  \nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: input_chain
    type: File
    doc: Input chain file
    inputBinding:
      position: 1
outputs:
  - id: output_chain
    type: File
    doc: Output chain file with stitched IDs
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-chainstitchid:482--h0b57e2e_0
