cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - java
  - -jar
  - topas.jar
  - ConsensusSeqFromVCFs
label: topas_consensusseqlfromvcfs
doc: "generate a consensus sequence from the SNPs of several VCF files\n\nTool homepage:
  https://github.com/subwaystation/TOPAS"
inputs:
  - id: vcf_files
    type:
      type: array
      items: File
    doc: Several VCF files to generate a consensus sequence from
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/topas:1.0.1--0
stdout: topas_consensusseqlfromvcfs.out
