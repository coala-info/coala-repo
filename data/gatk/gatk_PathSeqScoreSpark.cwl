cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gatk
  - PathSeqScoreSpark
label: gatk_PathSeqScoreSpark
doc: |-
  Classify reads and estimate abundances of each taxon in the reference. This is the third and final step of the PathSeq pipeline.

  Tool homepage: https://gatk.broadinstitute.org/
inputs:
  - id: scores_output
    type: string
    inputBinding:
      position: 101
      prefix: --scores-output
    doc: URI for the taxonomic scores output
  - id: taxonomy_file
    type: File
    inputBinding:
      position: 101
      prefix: --taxonomy-file
    doc: URI to the microbe reference taxonomy database built using PathSeqBuildReferenceTaxonomy
  - id: disable_sequence_dictionary_validation
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 101
      prefix: --disable-sequence-dictionary-validation
    doc: 'If specified, do not check the sequence dictionaries from our inputs for
      compatibility. Use at your own risk! Default value: false. Possible values:
      {true, false}'
  - id: divide_by_genome_length
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 101
      prefix: --divide-by-genome-length
    doc: 'Divide abundance scores by each taxon''s reference genome length (in millions)
      Default value: false. Possible values: {true, false}'
  - id: exclude_intervals
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --exclude-intervals
    inputBinding:
      position: 101
    doc: One or more genomic intervals to exclude from processing This argument may
      be specified 0 or more times.
  - id: identity_margin
    type:
      - 'null'
      - float
    inputBinding:
      position: 101
      prefix: --identity-margin
    doc: 'Identity margin, as a fraction of the best hit (between 0 and 1). Default
      value: 0.02.'
  - id: input
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: --input
    inputBinding:
      position: 101
    doc: BAM/SAM/CRAM file containing reads This argument may be specified 0 or more
      times.
    secondaryFiles:
      - pattern: .bai
        required: false
      - pattern: ^.bai
        required: false
      - pattern: .crai
        required: false
      - pattern: ^.crai
        required: false
      - pattern: .sbi
        required: false
  - id: intervals
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --intervals
    inputBinding:
      position: 101
    doc: One or more genomic intervals over which to operate This argument may be
      specified 0 or more times.
  - id: min_score_identity
    type:
      - 'null'
      - float
    inputBinding:
      position: 101
      prefix: --min-score-identity
    doc: 'Alignment identity score threshold, as a fraction of the read length (between
      0 and 1). Default value: 0.9.'
  - id: not_normalized_by_kingdom
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 101
      prefix: --not-normalized-by-kingdom
    doc: 'If true, normalized abundance scores will be reported as a percentage within
      their kingdom. Default value: false. Possible values: {true, false}'
  - id: output
    type:
      - 'null'
      - string
    inputBinding:
      position: 101
      prefix: --output
    doc: Output BAM
  - id: paired_input
    type:
      - 'null'
      - File
    inputBinding:
      position: 101
      prefix: --paired-input
    doc: Input queryname-sorted BAM containing only paired reads
  - id: reference
    type:
      - 'null'
      - File
    inputBinding:
      position: 101
      prefix: --reference
    doc: Reference sequence
    secondaryFiles:
      - pattern: .fai
        required: false
      - pattern: ^.dict
        required: false
      - pattern: .gzi
        required: false
      - pattern: ^^.dict
        required: false
  - id: score_metrics
    type:
      - 'null'
      - string
    inputBinding:
      position: 101
      prefix: --score-metrics
    doc: Log counts of mapped and unmapped reads to this file
  - id: score_warnings
    type:
      - 'null'
      - string
    inputBinding:
      position: 101
      prefix: --score-warnings
    doc: Write accessions found in the reads header but not the taxonomy database
      to this file
  - id: unpaired_input
    type:
      - 'null'
      - File
    inputBinding:
      position: 101
      prefix: --unpaired-input
    doc: Input BAM containing only unpaired reads
  - id: score_reads_per_partition_estimate
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --score-reads-per-partition-estimate
    doc: 'Estimated reads per Spark partition for scoring Default value: 200000.'
outputs:
  - id: scores_output_out
    type: File
    doc: URI for the taxonomic scores output
    outputBinding:
      glob: $(inputs.scores_output)
  - id: output_output
    type:
      - 'null'
      - File
    doc: Output BAM
    outputBinding:
      glob: $(inputs.output)
  - id: score_metrics_out
    type:
      - 'null'
      - File
    doc: Log counts of mapped and unmapped reads to this file
    outputBinding:
      glob: $(inputs.score_metrics)
  - id: score_warnings_out
    type:
      - 'null'
      - File
    doc: Write accessions found in the reads header but not the taxonomy database
      to this file
    outputBinding:
      glob: $(inputs.score_warnings)
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: broadinstitute/gatk:4.7.0.0
s:url: https://gatk.broadinstitute.org/
$namespaces:
  s: https://schema.org/
