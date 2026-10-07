cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - clearCNV
  - merge_bed
label: clearcnv_merge_bed
doc: "Merges bed files to non-overlapping intervals.\n\nTool homepage: https://github.com/bihealth/clear-cnv"
inputs:
  - id: infile
    type: File
    doc: "Path to the original .bed file."
    inputBinding:
      position: 101
      prefix: --infile
  - id: outfile
    type: string
    doc: "Output path to the merged .bed file."
    inputBinding:
      position: 101
      prefix: --outfile
outputs:
  - id: merged_bed
    type: File
    doc: "Merged BED file"
    outputBinding:
      glob: "$(inputs.outfile)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clearcnv:0.306--pyhdfd78af_0
