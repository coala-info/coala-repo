cwlVersion: v1.2
class: CommandLineTool
baseCommand: strainy
label: strainy
doc: "strainy\n\nTool homepage: https://github.com/katerinakazantseva/strainy"
inputs:
  - id: allele_frequency
    type:
      - 'null'
      - float
    doc: Set allele frequency for internal caller only (pileup)
    default: 0.2
    inputBinding:
      position: 101
      prefix: --allele-frequency
  - id: bam
    type:
      - 'null'
      - File
    doc: path to indexed alignment in bam format
    default: None
    inputBinding:
      position: 101
      prefix: --bam
  - id: cluster_divergence
    type:
      - 'null'
      - float
    doc: cluster divergence
    default: 0
    inputBinding:
      position: 101
      prefix: --cluster-divergence
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Generate extra output for debugging
    default: false
    inputBinding:
      position: 101
      prefix: --debug
  - id: fasta_ref
    type:
      - 'null'
      - File
    doc: input reference fasta to phase
    default: None
    inputBinding:
      position: 101
      prefix: --fasta_ref
  - id: fastq
    type: File
    doc: fastq file with reads to phase / assemble
    inputBinding:
      position: 101
      prefix: --fastq
  - id: gfa_ref
    type: File
    doc: input reference gfa to uncollapse
    inputBinding:
      position: 101
      prefix: --gfa_ref
  - id: link_simplify
    type:
      - 'null'
      - boolean
    doc: Enable agressive graph simplification
    default: false
    inputBinding:
      position: 101
      prefix: --link-simplify
  - id: max_unitig_coverage
    type:
      - 'null'
      - int
    doc: The maximum coverage threshold for phasing unitigs, unitigs with higher
      coverage will not be phased
    default: 500
    inputBinding:
      position: 101
      prefix: --max-unitig-coverage
  - id: min_unitig_coverage
    type:
      - 'null'
      - int
    doc: The minimum coverage threshold for phasing unitigs, unitigs with lower 
      coverage will not be phased
    default: 20
    inputBinding:
      position: 101
      prefix: --min-unitig-coverage
  - id: min_unitig_length
    type:
      - 'null'
      - int
    doc: The length (in kb) which the unitigs that are shorter will not be 
      phased
    default: 1
    inputBinding:
      position: 101
      prefix: --min-unitig-length
  - id: mode
    type: string
    doc: type of reads
    inputBinding:
      position: 101
      prefix: --mode
  - id: only_split
    type:
      - 'null'
      - boolean
    doc: Do not run stRainy, only split long gfa unitigs
    default: false
    inputBinding:
      position: 101
      prefix: --only-split
  - id: output_dir
    type: Directory
    doc: output directory
    inputBinding:
      position: 101
      prefix: --output
  - id: snp
    type:
      - 'null'
      - File
    doc: path to vcf file with SNP calls to use
    default: None
    inputBinding:
      position: 101
      prefix: --snp
  - id: stage
    type:
      - 'null'
      - string
    doc: 'stage to run: either phase, transform or e2e (phase + transform)'
    default: e2e
    inputBinding:
      position: 101
      prefix: --stage
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads to use
    default: 4
    inputBinding:
      position: 101
      prefix: --threads
  - id: unitig_split_length
    type:
      - 'null'
      - int
    doc: The length (in kb) which the unitigs that are longer will be split, set
      0 to disable
    default: 50
    inputBinding:
      position: 101
      prefix: --unitig-split-length
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/strainy:1.2--pyhdfd78af_1
stdout: strainy.out
