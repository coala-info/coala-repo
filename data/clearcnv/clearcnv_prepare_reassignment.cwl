cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - clearCNV
  - prepare_reassignment
label: clearcnv_prepare_reassignment
doc: "Prepares the necessary files to perform panel reassignment on a set of .bed files and corresponding .bam file data sets.\n\nTool homepage: https://github.com/bihealth/clear-cnv"
inputs:
  - id: metafile
    type: File
    doc: "Path to the file containing the meta information. It is a .tsv of the scheme -panel bams.txt bed.bed. It aligns each desired panel name with the corresponding .bam files and the .bed file."
    inputBinding:
      position: 101
      prefix: --metafile
  - id: bamsfile
    type: string
    doc: "Output .txt file. It will contain the distinct set of all given .bam file paths."
    inputBinding:
      position: 101
      prefix: --bamsfile
  - id: bedfile
    type: string
    doc: "Output .bed file. It will contain the merged union of all given .bed files."
    inputBinding:
      position: 101
      prefix: --bedfile
  - id: meta_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "The bams.txt and .bed files named in the metafile, staged in the working directory so that relative names in the metafile resolve"
outputs:
  - id: bams_txt
    type: File
    doc: "Distinct set of all given .bam file paths"
    outputBinding:
      glob: "$(inputs.bamsfile)"
  - id: union_bed
    type: File
    doc: "Merged union of all given .bed files"
    outputBinding:
      glob: "$(inputs.bedfile)"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.meta_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clearcnv:0.306--pyhdfd78af_0
