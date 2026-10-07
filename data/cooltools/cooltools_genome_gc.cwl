cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cooltools
  - genome
  - gc
label: cooltools_genome_gc
doc: "Add the GC fraction of each bin of a bin table, computed from a genome FASTA,
  and print the table.\n\nTool homepage: https://github.com/mirnylab/cooltools"
inputs:
  - id: bins_path
    type: File
    doc: Bin table with a header (chrom, start, end, ...), e.g. from cooltools 
      genome binnify.
    inputBinding:
      position: 1
  - id: fasta_path
    type: File
    doc: Genome FASTA file that contains every chromosome of the bin table (needs its .fai index beside it).
    secondaryFiles:
      - .fai
    inputBinding:
      position: 2
  - id: mapped_only
    type:
      - 'null'
      - boolean
    doc: Compute GC only over mapped (non-N) bases.
    inputBinding:
      position: 101
      prefix: --mapped-only
  - id: output_name
    type:
      - 'null'
      - string
    doc: Name of the file that captures the table printed to standard output.
    default: bins_gc.tsv
outputs:
  - id: bins_gc
    type: stdout
    doc: Bin table with a GC column.
stdout: $(inputs.output_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cooltools:0.7.1--py311h93dcfea_3
