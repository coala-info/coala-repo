cwlVersion: v1.2
class: CommandLineTool
baseCommand: phyluce_probe_get_genome_sequences_from_bed
label: phyluce_phyluce_probe_get_genome_sequences_from_bed
doc: "Given an input BED file for one taxon, slice out genomic sequence given coordinates\n\
  \nTool homepage: https://github.com/faircloth-lab/phyluce"
inputs:
  - id: bed
    type: File
    doc: The input BED file
    inputBinding:
      prefix: --bed
  - id: twobit
    type: File
    doc: The input genome to slice in UCSC 2bit format
    inputBinding:
      prefix: --twobit
  - id: output_path
    type: string
    doc: The output fasta file
    inputBinding:
      prefix: --output
  - id: filter_mask
    type:
      - 'null'
      - float
    doc: Filter strings with > X frequency of masked bases
    inputBinding:
      prefix: --filter-mask
  - id: max_n
    type:
      - 'null'
      - int
    doc: The maximum number of ambiguous bases ('N') to accept
    inputBinding:
      prefix: --max-n
  - id: buffer_to
    type:
      - 'null'
      - int
    doc: The length to which to buffer the extracted sequences
    inputBinding:
      prefix: --buffer-to
outputs:
  - id: output
    type: File
    doc: The FASTA file of sliced sequences.
    outputBinding:
      glob: $(inputs.output_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyluce:1.6.8--py_0
