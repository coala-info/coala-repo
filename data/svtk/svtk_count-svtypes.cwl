cwlVersion: v1.2
class: CommandLineTool
baseCommand: svtk_count-svtypes
label: svtk_count-svtypes
doc: "Count the instances of each SVTYPE observed in each sample in a VCF.\n\nTool
  homepage: https://github.com/talkowski-lab/svtk"
inputs:
  - id: vcf
    type: File
    doc: Input VCF file
    inputBinding:
      position: 1
  - id: no_header
    type:
      - 'null'
      - boolean
    doc: Don't include header in output
    inputBinding:
      position: 102
      prefix: --no-header
  - id: total_obs
    type:
      - 'null'
      - boolean
    doc: Sum variant counts across samples
    inputBinding:
      position: 102
      prefix: --total-obs
  - id: total_variants
    type:
      - 'null'
      - boolean
    doc: Sum variant counts across samples
    inputBinding:
      position: 102
      prefix: --total-variants
outputs:
  - id: fout
    type:
      - 'null'
      - File
    doc: Output file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svtk:0.0.20190615--py39hbcbf7aa_7
