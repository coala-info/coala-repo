cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pbsv
  - call
label: pbsv_call
doc: "Call structural variants from SV signatures and assign genotypes (SVSIG to VCF).\n
  \nTool homepage: https://github.com/PacificBiosciences/pbsv"
inputs:
  - id: ref_fasta
    type: File
    doc: Reference genome assembly against which to call variants.
    inputBinding:
      position: 1
  - id: input_svsig
    type: File
    doc: SV signatures from one or more samples (svsig.gz or fofn).
    inputBinding:
      position: 2
  - id: annotation_min_perc_sim
    type:
      - 'null'
      - int
    doc: Annotate variant if sequence similarity > P%.
    inputBinding:
      position: 103
      prefix: --annotation-min-perc-sim
  - id: annotations
    type:
      - 'null'
      - File
    doc: Annotate variants by comparing with sequences in fasta. Default annotations
      are ALU, L1, SVA.
    inputBinding:
      position: 103
      prefix: --annotations
  - id: call_min_bnd_reads_all_samples
    type:
      - 'null'
      - int
    doc: Ignore BND calls supported by < N reads total across samples
    inputBinding:
      position: 103
      prefix: --call-min-bnd-reads-all-samples
  - id: call_min_read_perc_one_sample
    type:
      - 'null'
      - int
    doc: Ignore calls supported by < P% of reads in every sample.
    inputBinding:
      position: 103
      prefix: --call-min-read-perc-one-sample
  - id: call_min_reads_all_samples
    type:
      - 'null'
      - int
    doc: Ignore calls supported by < N reads total across samples.
    inputBinding:
      position: 103
      prefix: --call-min-reads-all-samples
  - id: call_min_reads_one_sample
    type:
      - 'null'
      - int
    doc: Ignore calls supported by < N reads in every sample.
    inputBinding:
      position: 103
      prefix: --call-min-reads-one-sample
  - id: call_min_reads_per_strand_all_samples
    type:
      - 'null'
      - int
    doc: Ignore calls supported by < N reads per strand total across samples
    inputBinding:
      position: 103
      prefix: --call-min-reads-per-strand-all-samples
  - id: ccs
    type:
      - 'null'
      - boolean
    doc: 'Use options optimized for HiFi reads: -S 0 -P 10.'
    inputBinding:
      position: 103
      prefix: --ccs
  - id: cluster_max_length_perc_diff
    type:
      - 'null'
      - int
    doc: Do not cluster signatures with difference in length > P%.
    inputBinding:
      position: 103
      prefix: --cluster-max-length-perc-diff
  - id: cluster_max_ref_pos_diff
    type:
      - 'null'
      - string
    doc: Do not cluster signatures > N bp apart in reference.
    inputBinding:
      position: 103
      prefix: --cluster-max-ref-pos-diff
  - id: cluster_min_basepair_perc_id
    type:
      - 'null'
      - int
    doc: Do not cluster signatures with basepair identity < P%.
    inputBinding:
      position: 103
      prefix: --cluster-min-basepair-perc-id
  - id: filter_near_contig_end
    type:
      - 'null'
      - string
    doc: Flag variants < N bp from a contig end as "NearContigEnd".
    inputBinding:
      position: 103
      prefix: --filter-near-contig-end
  - id: filter_near_reference_gap
    type:
      - 'null'
      - string
    doc: Flag variants < N bp from a gap as "NearReferenceGap".
    inputBinding:
      position: 103
      prefix: --filter-near-reference-gap
  - id: gt_min_reads
    type:
      - 'null'
      - int
    doc: Minimum supporting reads to assign a sample a non-reference genotype.
    inputBinding:
      position: 103
      prefix: --gt-min-reads
  - id: hifi
    type:
      - 'null'
      - boolean
    doc: 'Use options optimized for HiFi reads: -S 0 -P 10.'
    inputBinding:
      position: 103
      prefix: --hifi
  - id: log_file
    type:
      - 'null'
      - File
    doc: Log to a file, instead of stderr.
    inputBinding:
      position: 103
      prefix: --log-file
  - id: log_level
    type:
      - 'null'
      - string
    doc: 'Set log level. Valid choices: (TRACE, DEBUG, INFO, WARN, FATAL).'
    inputBinding:
      position: 103
      prefix: --log-level
  - id: max_consensus_coverage
    type:
      - 'null'
      - int
    doc: Limit to N reads for variant consensus.
    inputBinding:
      position: 103
      prefix: --max-consensus-coverage
  - id: max_dup_length
    type:
      - 'null'
      - string
    doc: Ignore duplications with length > N bp.
    inputBinding:
      position: 103
      prefix: --max-dup-length
  - id: max_ins_length
    type:
      - 'null'
      - string
    doc: Ignore insertions with length > N bp.
    inputBinding:
      position: 103
      prefix: --max-ins-length
  - id: min_n_in_gap
    type:
      - 'null'
      - string
    doc: Consider >= N consecutive "N" bp as a reference gap.
    inputBinding:
      position: 103
      prefix: --min-N-in-gap
  - id: min_realign_length
    type:
      - 'null'
      - string
    doc: Consider segments with > N length for re-alignment.
    inputBinding:
      position: 103
      prefix: --min-realign-length
  - id: min_sv_length
    type:
      - 'null'
      - string
    doc: Ignore variants with length < N bp.
    inputBinding:
      position: 103
      prefix: --min-sv-length
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Number of threads to use, 0 means autodetection.
    inputBinding:
      position: 103
      prefix: --num-threads
  - id: poa_scores
    type:
      - 'null'
      - string
    doc: Score POA alignment with triplet match,mismatch,gap.
    inputBinding:
      position: 103
      prefix: --poa-scores
  - id: preserve_non_acgt
    type:
      - 'null'
      - boolean
    doc: Preserve non-ACGT in REF allele instead of replacing with N.
    inputBinding:
      position: 103
      prefix: --preserve-non-acgt
  - id: region
    type:
      - 'null'
      - string
    doc: 'Limit discovery to this reference region: CHR|CHR:START-END.'
    inputBinding:
      position: 103
      prefix: --region
  - id: types
    type:
      - 'null'
      - string
    doc: 'Call these SV types: "DEL", "INS", "INV", "DUP", "BND".'
    inputBinding:
      position: 103
      prefix: --types
outputs:
  - id: output_vcf
    type: File
    doc: Variant call format (VCF) output.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pbsv:2.11.0--h9ee0642_0
