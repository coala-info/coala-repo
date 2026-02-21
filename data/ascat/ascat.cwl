cwlVersion: v1.2
class: CommandLineTool
baseCommand: ascat
label: ascat
doc: "ASCAT (Allele-Specific Copy Number Analysis of Tumors) is a tool for deriving
  copy number profiles of tumor cells. (Note: The provided input text is a container
  build error log and does not contain CLI help documentation.)\n\nTool homepage:
  https://www.crick.ac.uk/research/a-z-researchers/researchers-v-y/peter-van-loo/software/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ascat:3.2.0--r44hdfd78af_1
stdout: ascat.out
