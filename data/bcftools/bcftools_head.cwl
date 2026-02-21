cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bcftools
  - head
label: bcftools_head
doc: "Displays VCF/BCF headers and optionally the first few variant records\n\nTool
  homepage: https://github.com/samtools/bcftools"
inputs:
  - id: input_file
    type:
      - 'null'
      - File
    doc: Input VCF/BCF file
    inputBinding:
      position: 1
  - id: headers
    type:
      - 'null'
      - int
    doc: Display INT header lines [all]
    inputBinding:
      position: 102
      prefix: --headers
  - id: records
    type:
      - 'null'
      - int
    doc: Display INT variant record lines [none]
    inputBinding:
      position: 102
      prefix: --records
  - id: samples
    type:
      - 'null'
      - int
    doc: 'Display INT records starting with the #CHROM header line [none]'
    inputBinding:
      position: 102
      prefix: --samples
  - id: verbosity
    type:
      - 'null'
      - int
    doc: Verbosity level
    inputBinding:
      position: 102
      prefix: --verbosity
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bcftools:1.23--h3a4d415_0
stdout: bcftools_head.out
