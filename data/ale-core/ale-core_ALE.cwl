cwlVersion: v1.2
class: CommandLineTool
baseCommand: ALE
label: ale-core_ALE
doc: "Assembly Likelihood Estimator for evaluating genome assemblies using read alignments.\n\
  \nTool homepage: https://github.com/sc932/ALE"
inputs:
  - id: alignments
    type: File
    doc: Input alignments in SAM or BAM format
    inputBinding:
      position: 1
  - id: assembly
    type: File
    doc: Assembly fasta file (can be gzipped)
    inputBinding:
      position: 2
  - id: kmer
    type:
      - 'null'
      - float
    doc: Kmer depth for kmer stats
    inputBinding:
      position: 103
      prefix: --kmer
  - id: library_parameter_file
    type:
      - 'null'
      - string
    doc: library parameter file (auto outputs .param)
    inputBinding:
      position: 103
      prefix: --pm
  - id: metagenome
    type:
      - 'null'
      - boolean
    doc: Evaluate each contig independently for depth & kmer metrics
    inputBinding:
      position: 103
      prefix: --metagenome
  - id: min_log_likelihood
    type:
      - 'null'
      - int
    doc: the minimum log Likelihood
    inputBinding:
      position: 103
      prefix: --minLL
  - id: min_quality
    type:
      - 'null'
      - int
    doc: Minimum quality score to use in Z-normalization. Illumina quality 
      scores can be unreliable below this threshold
    inputBinding:
      position: 103
      prefix: --minQual
  - id: no_per_base_output
    type:
      - 'null'
      - boolean
    doc: only output meta information (no per base)
    inputBinding:
      position: 103
      prefix: --nout
  - id: placement_output_bam
    type:
      - 'null'
      - string
    doc: placementOutputBAM
    inputBinding:
      position: 103
      prefix: --pl
  - id: quality_offset
    type:
      - 'null'
      - int
    doc: Quality ascii offset (illumina) 33 or 64 (or 0)
    inputBinding:
      position: 103
      prefix: --qOff
  - id: realign
    type:
      - 'null'
      - string
    doc: 'Realign reads with Striped-Smith-Waterman honoring ambiguous reference bases
      and stacking homo-polymer indels. Format: matchScore,misMatchPenalty,gapOpenPenalty,gapExtPenalty,minimumSoftClip'
    inputBinding:
      position: 103
      prefix: --realign
outputs:
  - id: output_file
    type: File
    doc: ALE output text file
    outputBinding:
      glob: '*.out'
  - id: snp_report
    type:
      - 'null'
      - File
    doc: Creates a new text file reporting all SNP phasing observed by a read 
      against ambiguous bases in the reference
    outputBinding:
      glob: $(inputs.snp_report)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ale-core:20220503--h577a1d6_1
