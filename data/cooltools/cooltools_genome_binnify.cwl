cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cooltools
  - genome
  - binnify
label: cooltools_genome_binnify
doc: "Divide the chromosomes of a chrom sizes file into fixed-size bins and print
  the bin table (chrom, start, end).\n\nTool homepage: https://github.com/mirnylab/cooltools"
inputs:
  - id: chromsizes_path
    type: File
    doc: Chromosome sizes file (two columns, chrom and length).
    inputBinding:
      position: 1
  - id: binsize
    type: int
    doc: Bin size in base pairs.
    inputBinding:
      position: 2
  - id: all_names
    type:
      - 'null'
      - boolean
    doc: Parse all chromosome names from file, not only default r"^chr[0-9]+$",
      r"^chr[XY]$", r"^chrM$".
    inputBinding:
      position: 101
      prefix: --all-names
  - id: output_name
    type:
      - 'null'
      - string
    doc: Name of the file that captures the bin table printed to standard 
      output.
    default: bins.tsv
outputs:
  - id: bins
    type: stdout
    doc: Bin table in TSV format.
stdout: $(inputs.output_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cooltools:0.7.1--py311h93dcfea_3
