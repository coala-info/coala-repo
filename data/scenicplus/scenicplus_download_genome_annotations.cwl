cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - scenicplus
  - prepare_data
  - download_genome_annotations
label: scenicplus_download_genome_annotations
doc: "Download genome annotation and chromosome sizes from BioMart.\n\nTool homepage: https://github.com/aertslab/scenicplus"
inputs:
  - id: species
    type: string
    doc: "Species name (e.g. hsapies)."
    inputBinding:
      position: 101
      prefix: --species
  - id: genome_annotation_out_fname_path
    type: string
    doc: "Out file name for genome annotation (tsv)."
    inputBinding:
      position: 102
      prefix: --genome_annotation_out_fname
  - id: chromsizes_out_fname_path
    type: string
    doc: "Out file name for chromosome sizes (tsv)."
    inputBinding:
      position: 102
      prefix: --chromsizes_out_fname
  - id: biomart_host
    type:
      - 'null'
      - string
    doc: "Biomart host name"
    inputBinding:
      position: 101
      prefix: --biomart_host
  - id: do_not_use_ucsc_chromosome_style
    type:
      - 'null'
      - boolean
    doc: "Do not use UCSC chromosome style names."
    inputBinding:
      position: 101
      prefix: --do_not_use_ucsc_chromosome_style
outputs:
  - id: genome_annotation_out_fname
    type:
      - 'null'
      - File
    doc: "Out file name for genome annotation (tsv)."
    outputBinding:
      glob: "$(inputs.genome_annotation_out_fname_path)"
  - id: chromsizes_out_fname
    type:
      - 'null'
      - File
    doc: "Out file name for chromosome sizes (tsv)."
    outputBinding:
      glob: "$(inputs.chromsizes_out_fname_path)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scenicplus:1.0a2--pyhdfd78af_0
