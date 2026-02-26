cwlVersion: v1.2
class: CommandLineTool
baseCommand: svtk_rdtest2vcf
label: svtk_rdtest2vcf
doc: "Convert an RdTest-formatted bed to the standard VCF format.\n\nTool homepage:
  https://github.com/talkowski-lab/svtk"
inputs:
  - id: bed
    type: File
    doc: RdTest-formatted bed file. (chrom, start, end, name, samples, svtype)
    inputBinding:
      position: 1
  - id: samples
    type: string
    doc: List of all samples present in variant callset.
    inputBinding:
      position: 2
  - id: contigs
    type:
      - 'null'
      - File
    doc: Reference fasta index (.fai). If provided, contigs in index will be 
      used in VCF header. Otherwise all GRCh37 contigs will be used in header.
    inputBinding:
      position: 103
      prefix: --contigs
outputs:
  - id: fout
    type: File
    doc: Standardized VCF. Will be compressed with bgzip and tabix indexed if 
      filename ends with .gz
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svtk:0.0.20190615--py39hbcbf7aa_7
