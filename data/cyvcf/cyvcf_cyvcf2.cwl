cwlVersion: v1.2
class: CommandLineTool
baseCommand: cyvcf2
label: cyvcf_cyvcf2
doc: "fast vcf parsing with cython + htslib\n\nTool homepage: https://github.com/brentp/cyvcf2"
inputs:
  - id: vcf_file
    type: File
    doc: VCF/BCF file to parse
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
  - id: start
    type:
      - 'null'
      - int
    doc: Specify the start of region.
    inputBinding:
      position: 102
      prefix: --start
  - id: end
    type:
      - 'null'
      - int
    doc: Specify the end of the region.
    inputBinding:
      position: 102
      prefix: --end
  - id: include_info_field
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --include
    doc: Specify what info field to include.
    inputBinding:
      position: 102
  - id: exclude_info_field
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --exclude
    doc: Specify what info field to exclude.
    inputBinding:
      position: 102
  - id: loglevel
    type:
      - 'null'
      - string
    doc: Set the level of log output (DEBUG, INFO, WARNING, ERROR, CRITICAL).
    inputBinding:
      position: 102
      prefix: --loglevel
  - id: silent
    type:
      - 'null'
      - boolean
    doc: Skip printing of vcf.
    inputBinding:
      position: 102
      prefix: --silent
outputs:
  - id: stdout
    type: stdout
    doc: Parsed VCF records
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cyvcf:0.8.0--py36_0
stdout: cyvcf_cyvcf2.out
