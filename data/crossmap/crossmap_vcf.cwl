cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - CrossMap.py
  - vcf
label: crossmap_vcf
doc: "CrossMap is a program for convenient conversion of genome coordinates and genome
  annotation files between assemblies (e.g. lift over from human hg18 to hg19 or vice
  versa). It supports VCF format.\n\nTool homepage: https://crossmap.sourceforge.net"
inputs:
  - id: chain_file
    type: File
    doc: Chain file in UCSC format.
    inputBinding:
      position: 1
  - id: input_vcf
    type: File
    doc: Input VCF file.
    inputBinding:
      position: 2
  - id: ref_genome
    type: File
    doc: Reference genome sequence file in FASTA format.
    inputBinding:
      position: 3
  - id: no_comp_header
    type:
      - 'null'
      - boolean
    doc: Whether to check if the reference genome is compatible with the VCF 
      file.
    inputBinding:
      position: 104
      prefix: --no-comp-header
outputs:
  - id: output_vcf
    type: File
    doc: Output VCF file.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/crossmap:0.7.3--pyhdfd78af_0
