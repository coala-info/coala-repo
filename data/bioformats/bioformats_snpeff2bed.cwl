cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bioformats
  - snpeff2bed
label: bioformats_snpeff2bed
doc: "Convert SnpEff VCF files to BED format.\n\nTool homepage: https://github.com/gtamazian/bioformats"
inputs:
  - id: vcf_file
    type: File
    doc: Input VCF file
    inputBinding:
      position: 1
  - id: bed3
    type:
      - 'null'
      - boolean
    doc: Output in BED3 format
    inputBinding:
      position: 102
      prefix: --bed3
outputs:
  - id: bed_file
    type: File
    doc: Output BED file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bioformats:0.1.15--py27_0
