cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phyluce_snp_prep_interval_list_file_for_picard
label: phyluce_phyluce_snp_prep_interval_list_file_for_picard
doc: "Given an input BED file and BAM file, output an interval.list file\n\nTool homepage: https://github.com/faircloth-lab/phyluce"
inputs:
  - id: bed
    type: File
    doc: "The BED file to filter."
    inputBinding:
      position: 1
      prefix: --bed
  - id: bam
    type: File
    doc: "The BED file to filter."
    inputBinding:
      position: 2
      prefix: --bam
  - id: output
    type: string
    doc: "The output BED file. The program prints to standard output when this is not set; this wrapper always needs a file name so that the result is collected."
    inputBinding:
      position: 3
      prefix: --output
outputs:
  - id: interval_list
    type: File
    doc: "The Picard interval list (written to --output)."
    outputBinding:
      glob: "$(inputs.output)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyluce:1.6.8--py_0
