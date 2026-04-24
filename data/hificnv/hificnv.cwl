cwlVersion: v1.2
class: CommandLineTool
baseCommand: hificnv
label: hificnv
doc: "Copy number variant caller and depth visualization utility for PacBio HiFi reads\n\
  \nTool homepage: https://github.com/PacificBiosciences/HiFiCNV"
inputs:
  - id: bam
    type: File
    doc: Alignment file for the query sample in BAM format. BAM file must be 
      indexed
    inputBinding:
      position: 101
      prefix: --bam
  - id: cov_regex
    type:
      - 'null'
      - string
    doc: Regex used to select chromosomes for mean haploid coverage estimation. 
      All selected chromosomes are assumed diploid
    inputBinding:
      position: 101
      prefix: --cov-regex
  - id: debug_gc_correction
    type:
      - 'null'
      - boolean
    doc: Output files for debugging GC-correction
    inputBinding:
      position: 101
      prefix: --debug-gc-correction
  - id: disable_vcf_filters
    type:
      - 'null'
      - boolean
    doc: Disables all FILTER flags in HiFiCNV output
    inputBinding:
      position: 101
      prefix: --disable-vcf-filters
  - id: exclude
    type:
      - 'null'
      - File
    doc: Regions of the genome to exclude from CNV analysis, in BED format
    inputBinding:
      position: 101
      prefix: --exclude
  - id: expected_cn
    type:
      - 'null'
      - File
    doc: Expected copy number values, in BED format
    inputBinding:
      position: 101
      prefix: --expected-cn
  - id: maf
    type:
      - 'null'
      - File
    doc: Variant file used to generate minor allele frequency track, in VCF or 
      BCF format
    inputBinding:
      position: 101
      prefix: --maf
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: Prefix used for all file output. If the prefix includes a directory, 
      the directory must already exist
    inputBinding:
      position: 101
      prefix: --output-prefix
  - id: ref
    type: File
    doc: Genome reference in FASTA format
    inputBinding:
      position: 101
      prefix: --ref
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use. Defaults to all logical cpus detected
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hificnv:1.0.1--h9ee0642_0
stdout: hificnv.out
