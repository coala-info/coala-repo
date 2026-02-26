cwlVersion: v1.2
class: CommandLineTool
baseCommand: cyvcf2
label: cyvcf2
doc: "fast vcf parsing with cython + htslib\n\nTool homepage: https://github.com/brentp/cyvcf2"
inputs:
  - id: vcf_file
    type: File
    doc: vcf file or - for stdin
    inputBinding:
      position: 1
  - id: chrom
    type:
      - 'null'
      - string
    doc: Specify what chromosome to include.
    inputBinding:
      position: 102
      prefix: --chrom
  - id: end
    type:
      - 'null'
      - int
    doc: Specify the end of the region.
    inputBinding:
      position: 102
      prefix: --end
  - id: exclude_info_field
    type:
      - 'null'
      - string
    doc: Specify what info field to exclude.
    inputBinding:
      position: 102
      prefix: --exclude
  - id: include_info_field
    type:
      - 'null'
      - string
    doc: Specify what info field to include.
    inputBinding:
      position: 102
      prefix: --include
  - id: individual
    type:
      - 'null'
      - string
    doc: Only print genotype call for individual.
    inputBinding:
      position: 102
      prefix: --individual
  - id: loglevel
    type:
      - 'null'
      - string
    doc: Set the level of log output.
    default: INFO
    inputBinding:
      position: 102
      prefix: --loglevel
  - id: no_individuals
    type:
      - 'null'
      - boolean
    doc: Do not print genotypes.
    inputBinding:
      position: 102
      prefix: --no-inds
  - id: silent
    type:
      - 'null'
      - boolean
    doc: Skip printing of vcf.
    inputBinding:
      position: 102
      prefix: --silent
  - id: start
    type:
      - 'null'
      - int
    doc: Specify the start of region.
    inputBinding:
      position: 102
      prefix: --start
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cyvcf2:0.31.4--py310h4de444c_1
stdout: cyvcf2.out
