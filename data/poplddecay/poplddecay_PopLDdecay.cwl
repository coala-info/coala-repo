cwlVersion: v1.2
class: CommandLineTool
baseCommand: ./bin/PopLDdecay
label: poplddecay_PopLDdecay
doc: "Calculates and visualizes Linkage Disequilibrium (LD) decay from VCF files.\n\
  \nTool homepage: https://github.com/BGI-shenzhen/PopLDdecay"
inputs:
  - id: ehh
    type:
      - 'null'
      - string
    doc: 'Calculate EHH decay for a specific site (format: chr:site).'
    inputBinding:
      position: 101
      prefix: -EHH
  - id: input_vcf
    type: File
    doc: Input VCF file (compressed or uncompressed).
    inputBinding:
      position: 101
      prefix: -InVCF
  - id: method
    type:
      - 'null'
      - int
    doc: Algorithm method for LD calculation. 1 is faster, 2 may use more 
      memory.
    inputBinding:
      position: 101
      prefix: -Method
  - id: out_type
    type:
      - 'null'
      - int
    doc: Type of output statistics. Can be 1-8. (1-3) are recommended. See 
      manual for details.
    inputBinding:
      position: 101
      prefix: -OutType
  - id: subpop
    type:
      - 'null'
      - File
    doc: File containing sample names for a subpopulation.
    inputBinding:
      position: 101
      prefix: -SubPop
outputs:
  - id: output_stat
    type:
      - 'null'
      - File
    doc: Output file for LD statistics (e.g., LDDecay.stat.gz).
    outputBinding:
      glob: $(inputs.output_stat)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/poplddecay:3.43--hdcf5f25_1
