cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bioformats
  - vcf2bed
label: bioformats_vcf2bed
doc: "Convert VCF files to BED format using the bioformats toolset.\n\nTool homepage:
  https://github.com/gtamazian/bioformats"
inputs:
  - id: vcf_file
    type: File
    doc: Input VCF file to be converted
    inputBinding:
      position: 1
outputs:
  - id: bed_file
    type: File
    doc: Output BED file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bioformats:0.1.15--py27_0
