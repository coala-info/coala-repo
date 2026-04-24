cwlVersion: v1.2
class: CommandLineTool
baseCommand: ucsc-bedcoverage
label: ucsc-bedcoverage
doc: "Calculates the coverage of a BED file across a genome.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: input_bed
    type: File
    doc: Input BED file
    inputBinding:
      position: 1
  - id: input_chromsizes
    type: File
    doc: 'File containing chromosome sizes (two columns: chromosome name and size)'
    inputBinding:
      position: 2
  - id: bins
    type:
      - 'null'
      - int
    doc: Number of bins to divide the genome into for coverage calculation
    inputBinding:
      position: 103
      prefix: --bins
  - id: genome_file
    type:
      - 'null'
      - File
    doc: A FASTA file of the genome (alternative to chromsizes)
    inputBinding:
      position: 103
      prefix: --genome-file
  - id: max_coverage
    type:
      - 'null'
      - int
    doc: 'Maximum coverage to report (default: unlimited)'
    inputBinding:
      position: 103
      prefix: --max-coverage
  - id: min_coverage
    type:
      - 'null'
      - int
    doc: 'Minimum coverage to report (default: 1)'
    inputBinding:
      position: 103
      prefix: --min-coverage
  - id: no_header
    type:
      - 'null'
      - boolean
    doc: Do not print a header line in the output
    inputBinding:
      position: 103
      prefix: --no-header
outputs:
  - id: output_coverage
    type:
      - 'null'
      - File
    doc: 'Output file for coverage data (default: stdout)'
    outputBinding:
      glob: $(inputs.output_coverage)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-bedcoverage:482--h0b57e2e_0
