cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cooltools
  - genome
  - fetch-chromsizes
label: cooltools_genome_fetch-chromsizes
doc: "Download the chromosome sizes of a genome assembly from UCSC and print them.\n  \nTool homepage: https://github.com/mirnylab/cooltools"
inputs:
  - id: db
    type: string
    doc: UCSC genome assembly name (e.g. hg38, mm10, sacCer3).
    inputBinding:
      position: 1
  - id: output_name
    type:
      - 'null'
      - string
    doc: Name of the file that captures the chrom sizes printed to standard 
      output.
    default: chromsizes.tsv
outputs:
  - id: chromsizes
    type: stdout
    doc: Chromosome sizes table.
stdout: $(inputs.output_name)
requirements:
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cooltools:0.7.1--py311h93dcfea_3
