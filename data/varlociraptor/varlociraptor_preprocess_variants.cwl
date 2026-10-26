cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - varlociraptor
  - preprocess
  - variants
label: varlociraptor_preprocess_variants
doc: 'Preprocess given variants by obtaining internal observations (allele likelihoods,
  strand information, ...) for each fragment. The observations are written in BCF
  format.


  Tool homepage: https://varlociraptor.github.io'
inputs:
  - id: reference
    type: File
    secondaryFiles:
      - .fai
    doc: FASTA file with reference genome. Has to be indexed with samtools faidx.
    inputBinding:
      position: 1
  - id: alignment_properties
    type:
      - 'null'
      - File
    doc: Alignment properties JSON file for sample. If not provided, properties will
      be estimated from the given BAM file.
    inputBinding:
      position: 100
      prefix: --alignment-properties
  - id: candidates
    type:
      - 'null'
      - File
    doc: sorted VCF/BCF file to process (if omitted, read from STDIN).
    inputBinding:
      position: 100
      prefix: --candidates
  - id: bam
    type:
      - 'null'
      - File
    doc: BAM file with aligned reads from a single sample. BAM file must be indexed
      (e.g. with samtools index).
    secondaryFiles:
      - .bai
    inputBinding:
      position: 100
      prefix: --bam
  - id: atomic_candidate_variants
    type:
      - 'null'
      - boolean
    doc: Assume that candidate variants are given in atomic form (unlike e.g. provided
      by freebayes which combines adjacent variants that appear to be in phase into
      longer haplotypes).
    inputBinding:
      position: 100
      prefix: --atomic-candidate-variants
  - id: omit_insert_size
    type:
      - 'null'
      - boolean
    doc: Do not consider insert size when calculating support for a variant. Use this
      flag when processing amplicon data, where indels do not impact the observed
      insert size
    inputBinding:
      position: 100
      prefix: --omit-insert-size
  - id: omit_mapq_adjustment
    type:
      - 'null'
      - boolean
    doc: Do not adjust mapping quality (MAPQ). By default Varlociraptor will adjust
      mapping qualities in order to avoid false positive hits caused by inflated MAPQ
      values at ambiguous loci.
    inputBinding:
      position: 100
      prefix: --omit-mapq-adjustment
  - id: report_fragment_ids
    type:
      - 'null'
      - boolean
    doc: Report fragment IDs in output BCF. This information can be used for phasing.
    inputBinding:
      position: 100
      prefix: --report-fragment-ids
  - id: log_mode
    type:
      - 'null'
      - string
    doc: 'Specify how progress should be logged: default or each-record'
    inputBinding:
      position: 100
      prefix: --log-mode
  - id: max_depth
    type:
      - 'null'
      - int
    doc: 'Maximum number of observations to use for calling. If locus is exceeding
      this number, downsampling is performed. [default: 200]'
    inputBinding:
      position: 100
      prefix: --max-depth
  - id: methylation_read_type
    type:
      - 'null'
      - string
    doc: 'Type of methylation information encoded in the reads: annotated or converted.'
    inputBinding:
      position: 100
      prefix: --methylation-read-type
  - id: min_bam_refetch_distance
    type:
      - 'null'
      - int
    doc: 'Base pair distance to last fetched BAM interval such that a refetching is
      performed instead of reading through until the next interval is reached. [default:
      1]'
    inputBinding:
      position: 100
      prefix: --min-bam-refetch-distance
  - id: output_path
    type:
      - 'null'
      - string
    doc: BCF file that shall contain the results (if omitted, write to STDOUT).
    inputBinding:
      position: 100
      prefix: --output
  - id: output_raw_observations
    type:
      - 'null'
      - string
    doc: Output raw observations as TSV files at the given prefix. Only use this for
      debugging when processing a single variant.
    inputBinding:
      position: 100
      prefix: --output-raw-observations
  - id: pairhmm_mode
    type:
      - 'null'
      - string
    doc: 'PairHMM computation mode (fast, exact or homopolymer). [default: exact]'
    inputBinding:
      position: 100
      prefix: --pairhmm-mode
  - id: propagate_info_fields
    type:
      - 'null'
      - type: array
        items: string
    doc: Additional INFO fields in the input BCF that shall be propagated to the output
      BCF (not supported for variants connected via EVENT tags except breakends).
    inputBinding:
      position: 100
      prefix: --propagate-info-fields
  - id: indel_window
    type:
      - 'null'
      - int
    doc: 'Number of bases to consider left and right of breakpoint when calculating
      read support. Currently implemented maximum value is 64. [default: 64]'
    inputBinding:
      position: 100
      prefix: --indel-window
  - id: reference_buffer_size
    type:
      - 'null'
      - int
    doc: 'Number of reference sequences to keep in buffer. [default: 10]'
    inputBinding:
      position: 100
      prefix: --reference-buffer-size
  - id: variant_heterozygosity_field
    type:
      - 'null'
      - string
    doc: Name of INFO field containing an expected heterozygosity per variant allele
      (can be e.g. a population allele frequency).
    inputBinding:
      position: 100
      prefix: --variant-heterozygosity-field
  - id: variant_somatic_effective_mutation_rate_field
    type:
      - 'null'
      - string
    doc: Name of INFO field containing an expected somatic effective mutation rate
      per variant allele.
    inputBinding:
      position: 100
      prefix: --variant-somatic-effective-mutation-rate-field
outputs:
  - id: observations_bcf
    type:
      - 'null'
      - File
    doc: Observations in BCF format
    outputBinding:
      glob: $(inputs.output_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/varlociraptor:8.9.5--h24073b4_0
