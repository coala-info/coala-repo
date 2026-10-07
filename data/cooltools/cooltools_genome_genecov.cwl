cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cooltools
  - genome
  - genecov
label: cooltools_genome_genecov
doc: "BINS_PATH is the path to bintable. DB is the name of the genome assembly. The
  gene locations will be automatically downloaded from the UCSC goldenPath.\n\nTool
  homepage: https://github.com/mirnylab/cooltools"
inputs:
  - id: bins_path
    type: File
    doc: Bin table with a header (chrom, start, end, ...).
    inputBinding:
      position: 1
  - id: db
    type: string
    doc: Name of the genome assembly (UCSC name, e.g. hg38); gene locations are
      downloaded from the UCSC goldenPath.
    inputBinding:
      position: 2
  - id: output_name
    type:
      - 'null'
      - string
    doc: Name of the file that captures the table printed to standard output.
    default: bins_genecov.tsv
outputs:
  - id: bins_genecov
    type: stdout
    doc: Bin table with gene coverage columns.
stdout: $(inputs.output_name)
requirements:
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cooltools:0.7.1--py311h93dcfea_3
