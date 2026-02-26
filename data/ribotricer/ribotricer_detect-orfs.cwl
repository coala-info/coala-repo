cwlVersion: v1.2
class: CommandLineTool
baseCommand: ribotricer detect-orfs
label: ribotricer_detect-orfs
doc: "Detect translating ORFs from BAM file\n\nTool homepage: https://github.com/smithlabcode/ribotricer"
inputs:
  - id: bam
    type: File
    doc: Path to BAM file
    inputBinding:
      position: 101
      prefix: --bam
  - id: meta_min_reads
    type:
      - 'null'
      - int
    doc: Minimum number of reads for a read length to be considered
    default: 100000
    inputBinding:
      position: 101
      prefix: --meta-min-reads
  - id: min_read_density
    type:
      - 'null'
      - float
    doc: Minimum read density (total_reads/length) over an ORF total codons for 
      determining active translation
    default: 0.0
    inputBinding:
      position: 101
      prefix: --min_read_density
  - id: min_reads_per_codon
    type:
      - 'null'
      - int
    doc: Minimum number of reads per codon for determining active translation
    default: 0
    inputBinding:
      position: 101
      prefix: --min_reads_per_codon
  - id: min_valid_codons
    type:
      - 'null'
      - int
    doc: Minimum number of codons with non-zero reads for determining active 
      translation
    default: 5
    inputBinding:
      position: 101
      prefix: --min_valid_codons
  - id: min_valid_codons_ratio
    type:
      - 'null'
      - float
    doc: Minimum ratio of codons with non-zero reads to total codons for 
      determining active translation
    default: 0.0
    inputBinding:
      position: 101
      prefix: --min_valid_codons_ratio
  - id: phase_score_cutoff
    type:
      - 'null'
      - float
    doc: Phase score cutoff for determining active translation
    default: 0.428571428571
    inputBinding:
      position: 101
      prefix: --phase_score_cutoff
  - id: prefix
    type: string
    doc: Prefix to output file
    inputBinding:
      position: 101
      prefix: --prefix
  - id: psite_offsets
    type:
      - 'null'
      - string
    doc: Comma separated P-site offsets for each read length matching the read 
      lengths provided. If not provided, reads from different read lengths will 
      be automatically aligned using cross-correlation
    inputBinding:
      position: 101
      prefix: --psite_offsets
  - id: read_lengths
    type:
      - 'null'
      - string
    doc: Comma separated read lengths to be used, such as 28,29,30 If not 
      provided, it will be automatically determined by assessing the metagene 
      periodicity
    inputBinding:
      position: 101
      prefix: --read_lengths
  - id: report_all
    type:
      - 'null'
      - boolean
    doc: Whether output all ORFs including those non-translating ones
    inputBinding:
      position: 101
      prefix: --report_all
  - id: ribotricer_index
    type: File
    doc: Path to the index file of ribotricer This file should be generated 
      using ribotricer prepare-orfs
    inputBinding:
      position: 101
      prefix: --ribotricer_index
  - id: stranded
    type:
      - 'null'
      - string
    doc: whether the data is from a strand-specific assay If not provided, the 
      experimental protocol will be automatically inferred
    inputBinding:
      position: 101
      prefix: --stranded
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ribotricer:1.5.0--pyhdfd78af_0
stdout: ribotricer_detect-orfs.out
