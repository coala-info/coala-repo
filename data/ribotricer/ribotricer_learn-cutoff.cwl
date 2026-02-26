cwlVersion: v1.2
class: CommandLineTool
baseCommand: ribotricer learn-cutoff
label: ribotricer_learn-cutoff
doc: "Learn phase score cutoff from BAM/TSV file\n\nTool homepage: https://github.com/smithlabcode/ribotricer"
inputs:
  - id: filter_by_tx_annotation
    type:
      - 'null'
      - string
    doc: transcript_type to filter regions by
    default: protein_coding
    inputBinding:
      position: 101
      prefix: --filter_by_tx_annotation
  - id: min_valid_codons
    type: int
    doc: Minimum number of codons with non-zero reads for determining active 
      translation (required for BAM input)
    default: 5
    inputBinding:
      position: 101
      prefix: --min_valid_codons
  - id: n_bootstraps
    type:
      - 'null'
      - int
    doc: Number of bootstraps
    default: 20000
    inputBinding:
      position: 101
      prefix: --n_bootstraps
  - id: phase_score_cutoff
    type: float
    doc: Phase score cutoff for determining active translation (required for BAM
      input)
    default: 0.428571428571
    inputBinding:
      position: 101
      prefix: --phase_score_cutoff
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix to output file
    inputBinding:
      position: 101
      prefix: --prefix
  - id: ribo_bams
    type:
      - 'null'
      - type: array
        items: File
    doc: Path(s) to Ribo-seq BAM file separated by comma
    inputBinding:
      position: 101
      prefix: --ribo_bams
  - id: ribo_tsvs
    type:
      - 'null'
      - type: array
        items: File
    doc: Path(s) to Ribo-seq *_translating_ORFs.tsv file separated by comma
    inputBinding:
      position: 101
      prefix: --ribo_tsvs
  - id: ribotricer_index
    type: File
    doc: Path to the index file of ribotricer This file should be generated 
      using ribotricer prepare-orfs (required for BAM input)
    inputBinding:
      position: 101
      prefix: --ribotricer_index
  - id: rna_bams
    type:
      - 'null'
      - type: array
        items: File
    doc: Path(s) to RNA-seq BAM file separated by comma
    inputBinding:
      position: 101
      prefix: --rna_bams
  - id: rna_tsvs
    type:
      - 'null'
      - type: array
        items: File
    doc: Path(s) to RNA-seq *_translating_ORFs.tsv file separated by comma
    inputBinding:
      position: 101
      prefix: --rna_tsvs
  - id: sampling_ratio
    type:
      - 'null'
      - float
    doc: Number of protein coding regions to sample per bootstrap
    default: 0.33
    inputBinding:
      position: 101
      prefix: --sampling_ratio
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ribotricer:1.5.0--pyhdfd78af_0
stdout: ribotricer_learn-cutoff.out
