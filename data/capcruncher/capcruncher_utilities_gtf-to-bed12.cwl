cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - capcruncher
  - utilities
  - gtf-to-bed12
label: capcruncher_utilities_gtf-to-bed12
doc: "Convert a GTF file to BED12 format.\n\nTool homepage: https://github.com/sims-lab/CapCruncher.git"
inputs:
  - id: gtf
    type: File
    doc: "GTF file"
    inputBinding:
      position: 1
  - id: output
    type: string
    default: genes.bed12
    doc: "Output file name"
    inputBinding:
      position: 2
      prefix: -o
outputs:
  - id: bed12
    type: File
    doc: "BED12 file"
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/capcruncher:0.3.14--pyhdfd78af_1
