cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - crispritz.py
  - add-variants
label: crispritz_add-variants
doc: "Add variants data to a FASTA genome. FASTA files must be unzipped and one per
  chromosome; VCF files must be gzipped and one per chromosome (file names contain
  .chrN.).\n\nTool homepage: https://github.com/InfOmics/CRISPRitz"
inputs:
  - id: vcf_dir
    type: Directory
    doc: Directory containing VCF files, need to be separated into single 
      chromosome files (multi-sample files will be collapsed into one fake 
      individual)
    inputBinding:
      position: 1
  - id: genome_dir
    type: Directory
    doc: Directory containing a genome in .fa or .fasta format, need to be 
      separated into single chromosome files.
    inputBinding:
      position: 2
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use. Default uses 1 thread
    inputBinding:
      position: 3
      prefix: -th
outputs:
  - id: variants_genome
    type: Directory
    doc: Enriched genome (variants_genome/SNPs_genome/<genome>_enriched/*.enriched.fa)
    outputBinding:
      glob: variants_genome
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/crispritz:2.7.0--py38h9948957_2
