cwlVersion: v1.2
class: CommandLineTool
baseCommand: hgvsToVcf
label: ucsc-hgvstovcf_hgvsToVcf
doc: "Convert HGVS terms to VCF format.\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs:
  - id: db
    type: string
    doc: Genome database (e.g., hg19, hg38)
    inputBinding:
      position: 1
  - id: hgvs_in
    type: File
    doc: Input file containing HGVS terms
    inputBinding:
      position: 2
  - id: out_vcf
    type: string
    doc: Output VCF file name
    inputBinding:
      position: 3
  - id: no_left_shift
    type:
      - 'null'
      - boolean
    doc: Don't do the VCF-conventional left shifting of ambiguous placements
    inputBinding:
      position: 101
      prefix: -noLeftShift
outputs:
  - id: vcf_out
    type: File
    doc: Output VCF file
    outputBinding:
      glob: $(inputs.out_vcf)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-hgvstovcf:377--h199ee4e_0
