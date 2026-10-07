cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - clearCNV
  - coverage
label: clearcnv_coverage
doc: "wrapper for bedtools multicov. Creates an .rtbed file which contains the read depth coverage per target.\n\nTool homepage: https://github.com/bihealth/clear-cnv"
inputs:
  - id: inbam
    type: File
    doc: "Path to the .bam file of the sample."
    secondaryFiles:
      - pattern: ".bai"
        required: true
    inputBinding:
      position: 101
      prefix: --inbam
  - id: bedfile
    type: File
    doc: "Path to the merged .bed file."
    inputBinding:
      position: 101
      prefix: --bedfile
  - id: rtbed
    type: string
    doc: "Output file in .rtbed format."
    inputBinding:
      position: 101
      prefix: --rtbed
outputs:
  - id: rtbed_file
    type: File
    doc: "Read depth coverage per target (.rtbed)"
    outputBinding:
      glob: "$(inputs.rtbed)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clearcnv:0.306--pyhdfd78af_0
