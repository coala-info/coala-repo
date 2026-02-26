cwlVersion: v1.2
class: CommandLineTool
baseCommand: Genrich
label: genrich_Genrich
doc: "Call peaks from SAM/BAM files.\n\nTool homepage: https://github.com/jsh58/Genrich"
inputs:
  - id: atac_seq_cut_expand
    type:
      - 'null'
      - int
    doc: Expand cut sites to <int> bp
    default: 100
    inputBinding:
      position: 101
      prefix: -d
  - id: atac_seq_mode
    type:
      - 'null'
      - boolean
    doc: Use ATAC-seq mode
    default: false
    inputBinding:
      position: 101
      prefix: -j
  - id: call_peaks_from_log
    type:
      - 'null'
      - boolean
    doc: Call peaks directly from a log file (-f)
    inputBinding:
      position: 101
      prefix: -P
  - id: control_file
    type:
      - 'null'
      - File
    doc: Input SAM/BAM file(s) for control sample(s)
    inputBinding:
      position: 101
      prefix: -c
  - id: exclude_chromosomes
    type:
      - 'null'
      - string
    doc: Comma-separated list of chromosomes to exclude
    inputBinding:
      position: 101
      prefix: -e
  - id: exclude_regions_bed
    type:
      - 'null'
      - type: array
        items: File
    doc: Input BED file(s) of genomic regions to exclude
    inputBinding:
      position: 101
      prefix: -E
  - id: gzip_output
    type:
      - 'null'
      - boolean
    doc: Option to gzip-compress output(s)
    inputBinding:
      position: 101
      prefix: -z
  - id: input_file
    type: File
    doc: Input SAM/BAM file(s) for experimental sample(s)
    inputBinding:
      position: 101
      prefix: -t
  - id: keep_unpaired
    type:
      - 'null'
      - boolean
    doc: Keep unpaired alignments
    default: false
    inputBinding:
      position: 101
      prefix: -y
  - id: max_dist_signif_sites
    type:
      - 'null'
      - int
    doc: Maximum distance between signif. sites
    default: 100
    inputBinding:
      position: 101
      prefix: -g
  - id: max_pvalue
    type:
      - 'null'
      - float
    doc: Maximum p-value
    default: 0.01
    inputBinding:
      position: 101
      prefix: -p
  - id: max_qvalue
    type:
      - 'null'
      - float
    doc: Maximum q-value (FDR-adjusted p-value)
    default: 1.0
    inputBinding:
      position: 101
      prefix: -q
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: Minimum MAPQ to keep an alignment
    default: 0
    inputBinding:
      position: 101
      prefix: -m
  - id: min_peak_auc
    type:
      - 'null'
      - float
    doc: Minimum AUC for a peak
    default: 200.0
    inputBinding:
      position: 101
      prefix: -a
  - id: min_peak_length
    type:
      - 'null'
      - int
    doc: Minimum length of a peak
    default: 0
    inputBinding:
      position: 101
      prefix: -l
  - id: remove_pcr_duplicates
    type:
      - 'null'
      - boolean
    doc: Remove PCR duplicates
    inputBinding:
      position: 101
      prefix: -r
  - id: sec_aln_as_diff
    type:
      - 'null'
      - float
    doc: Keep sec alns with AS >= bestAS - <float>
    default: 0.0
    inputBinding:
      position: 101
      prefix: -s
  - id: skip_peak_calling
    type:
      - 'null'
      - boolean
    doc: Skip peak-calling
    inputBinding:
      position: 101
      prefix: -X
  - id: skip_tn5_adjustments
    type:
      - 'null'
      - boolean
    doc: Skip Tn5 adjustments of cut sites
    default: false
    inputBinding:
      position: 101
      prefix: -D
  - id: unpaired_len_fixed
    type:
      - 'null'
      - int
    doc: Keep unpaired alns, lengths changed to <int>
    inputBinding:
      position: 101
      prefix: -w
  - id: unpaired_len_paired_avg
    type:
      - 'null'
      - boolean
    doc: Keep unpaired alns, lengths changed to paired avg
    inputBinding:
      position: 101
      prefix: -x
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Option to print status updates/counts to stderr
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: output_file
    type: File
    doc: Output peak file (in ENCODE narrowPeak format)
    outputBinding:
      glob: $(inputs.output_file)
  - id: output_bedgraph_p_q
    type:
      - 'null'
      - File
    doc: Output bedgraph-ish file for p/q values
    outputBinding:
      glob: $(inputs.output_bedgraph_p_q)
  - id: output_bedgraph_pileups
    type:
      - 'null'
      - File
    doc: Output bedgraph-ish file for pileups and p-values
    outputBinding:
      glob: $(inputs.output_bedgraph_pileups)
  - id: output_bed
    type:
      - 'null'
      - File
    doc: Output BED file for reads/fragments/intervals
    outputBinding:
      glob: $(inputs.output_bed)
  - id: output_pcr_duplicates
    type:
      - 'null'
      - File
    doc: Output file for PCR duplicates (only with -r)
    outputBinding:
      glob: $(inputs.output_pcr_duplicates)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genrich:0.6.1--hed695b0_0
