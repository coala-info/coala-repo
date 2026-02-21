cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bioformats
  - snpeff2pph
label: bioformats_snpeff2pph
doc: "Convert SnpEff annotated VCF files to PolyPhen-2 format.\n\nTool homepage: https://github.com/gtamazian/bioformats"
inputs:
  - id: vcf_file
    type: File
    doc: Input VCF file
    inputBinding:
      position: 1
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output
    inputBinding:
      position: 102
      prefix: -v
outputs:
  - id: output_file
    type: File
    doc: Output file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bioformats:0.1.15--py27_0
