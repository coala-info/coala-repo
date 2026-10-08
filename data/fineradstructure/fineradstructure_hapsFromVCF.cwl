cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - RADpainter
  - hapsFromVCF
label: fineradstructure_hapsFromVCF
doc: "(experimental) Get the haplotype format input for RADpainter paint from a
  VCF file. For now this only works for some VCF formats. The haplotype file is
  written to standard output.\n\nTool homepage: https://github.com/millanek/fineRADstructure"
inputs:
  - id: input_vcf
    type: File
    doc: Input VCF file (INPUT.vcf, plain or gzip)
    inputBinding:
      position: 2
  - id: het_treatment
    type:
      - 'null'
      - string
    doc: "Treatment of heterozygous bases: r assigns het bases randomly (default); p
      uses the phase information in the VCF"
    inputBinding:
      position: 1
      prefix: -H
  - id: min_f
    type:
      - 'null'
      - float
    doc: Minimum acceptable inbreeding coefficient (default F >= -0.3)
    inputBinding:
      position: 1
      prefix: -F
outputs:
  - id: haplotypes
    type: stdout
    doc: Haplotype file for RADpainter paint (sample names, then one line per locus)
stdout: haplotypes.txt
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fineradstructure:0.3.2r109--h76b9af2_7
