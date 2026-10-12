cwlVersion: v1.2
class: CommandLineTool
baseCommand: mk_pegs_intervals
label: pegs_mk_pegs_intervals
doc: "Make a BED file of gene intervals for PEGS from refGene annotation data.\n\nTool
  homepage: https://github.com/fls-bioinformatics-core/pegs"
inputs:
  - id: refgene_file
    type: File
    doc: refGene annotation data for the genome of interest
    inputBinding:
      position: 1
  - id: gene_interval_file
    type: string
    default: gene_intervals.bed
    doc: "destination for output BED file with gene interval data (the tool default
      writes beside the input file, so a name is always passed)"
    inputBinding:
      position: 2
outputs:
  - id: gene_intervals
    type: File
    doc: BED file with gene interval data
    outputBinding:
      glob: $(inputs.gene_interval_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pegs:0.6.6--pyhdfd78af_0
