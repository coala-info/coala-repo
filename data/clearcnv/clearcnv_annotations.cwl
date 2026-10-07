cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - clearCNV
  - annotations
label: clearcnv_annotations
doc: "Creates annotations file.\n\nTool homepage: https://github.com/bihealth/clear-cnv"
inputs:
  - id: reference
    type: File
    doc: "Path to the genomic reference."
    secondaryFiles:
      - pattern: ".fai"
        required: true
    inputBinding:
      position: 101
      prefix: --reference
  - id: bedfile
    type: File
    doc: "Path to the merged .bed file."
    inputBinding:
      position: 101
      prefix: --bedfile
  - id: kmer_align
    type: File
    doc: "Path to aligned k-mers (mappability) file in .bed format."
    inputBinding:
      position: 101
      prefix: --kmer_align
  - id: annotations
    type: string
    doc: "Output file in .bed format."
    inputBinding:
      position: 101
      prefix: --annotations
outputs:
  - id: annotations_bed
    type: File
    doc: "Annotations (BED with size, mappability and GC content)"
    outputBinding:
      glob: "$(inputs.annotations)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clearcnv:0.306--pyhdfd78af_0
