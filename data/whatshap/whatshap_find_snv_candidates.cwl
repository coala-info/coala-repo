cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - whatshap
  - find_snv_candidates
label: whatshap_find_snv_candidates
doc: "Generate candidate SNP positions.\n\nTool homepage: https://whatshap.readthedocs.io"
inputs:
  - id: ref
    type: File
    doc: FASTA with reference genome
    inputBinding:
      position: 1
  - id: bam
    type: File
    doc: BAM file
    inputBinding:
      position: 2
  - id: chromosome
    type:
      - 'null'
      - string
    doc: Name of chromosome to process. If not given, all chromosomes are 
      processed.
    inputBinding:
      position: 103
      prefix: --chromosome
  - id: illumina
    type:
      - 'null'
      - boolean
    doc: Input is Illumina. Sets minrel=0.25 and minabs=3.
    inputBinding:
      position: 103
      prefix: --illumina
  - id: min_abs
    type:
      - 'null'
      - int
    doc: Minimum absolute ALT depth to call a SNP
    inputBinding:
      position: 103
      prefix: --minabs
  - id: min_rel
    type:
      - 'null'
      - float
    doc: Minimum relative ALT depth to call a SNP
    inputBinding:
      position: 103
      prefix: --minrel
  - id: multi_allelics
    type:
      - 'null'
      - boolean
    doc: Also output multi-allelic sites, if not given only the best ALT allele 
      is reported (if unique).
    inputBinding:
      position: 103
      prefix: --multi-allelics
  - id: nanopore
    type:
      - 'null'
      - boolean
    doc: Input is Nanopore. Sets minrel=0.4 and minabs=3.
    inputBinding:
      position: 103
      prefix: --nanopore
  - id: pacbio
    type:
      - 'null'
      - boolean
    doc: Input is PacBio. Sets minrel=0.25 and minabs=3.
    inputBinding:
      position: 103
      prefix: --pacbio
  - id: sample
    type:
      - 'null'
      - string
    doc: 'Put this sample column into VCF (default: output sites-only VCF).'
    inputBinding:
      position: 103
      prefix: --sample
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output VCF file.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/whatshap:2.8--py39h2de1943_0
