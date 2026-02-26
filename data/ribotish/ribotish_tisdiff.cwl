cwlVersion: v1.2
class: CommandLineTool
baseCommand: ribotish tisdiff
label: ribotish_tisdiff
doc: "Compares TIS usage between two groups of samples.\n\nTool homepage: https://github.com/zhpn1024/ribotish"
inputs:
  - id: chromosome_map
    type:
      - 'null'
      - File
    doc: Input chromosome id mapping table file if annotation chr ids are not 
      same as chr ids in bam/fasta files
    inputBinding:
      position: 101
      prefix: --chrmap
  - id: compatible_missed_bases
    type:
      - 'null'
      - int
    doc: Missed bases allowed in reads compatibility check
    inputBinding:
      position: 101
      prefix: --compatiblemis
  - id: export_counts
    type:
      - 'null'
      - string
    doc: Export count table for differential analysis with other tools
    inputBinding:
      position: 101
      prefix: --export
  - id: figure_size
    type:
      - 'null'
      - string
    doc: 'Scatter plot figure size (default: 8,8)'
    default: 8,8
    inputBinding:
      position: 101
      prefix: --figsize
  - id: fold_change
    type:
      - 'null'
      - float
    doc: 'Minimum fold change threshold (default: 1.5)'
    default: 1.5
    inputBinding:
      position: 101
      prefix: -f
  - id: gene_format
    type:
      - 'null'
      - string
    doc: 'Gene annotation file format (gtf, bed, gpd, gff, default: auto)'
    default: auto
    inputBinding:
      position: 101
      prefix: --geneformat
  - id: gene_path
    type: File
    doc: Gene annotation file
    inputBinding:
      position: 101
      prefix: --genepath
  - id: input_tis_p_threshold
    type:
      - 'null'
      - float
    doc: 'Input TIS p value threshold (default: 0.05)'
    default: 0.05
    inputBinding:
      position: 101
      prefix: --ipth
  - id: input_tis_q_threshold
    type:
      - 'null'
      - float
    doc: 'Input TIS q value threshold (default: 0.05)'
    default: 0.05
    inputBinding:
      position: 101
      prefix: --iqth
  - id: max_nh
    type:
      - 'null'
      - int
    doc: 'Max NH value allowed for bam alignments (default: 5)'
    default: 5
    inputBinding:
      position: 101
      prefix: --maxNH
  - id: min_map_q
    type:
      - 'null'
      - int
    doc: 'Min MapQ value required for bam alignments (default: 1)'
    default: 1
    inputBinding:
      position: 101
      prefix: --minMapQ
  - id: no_compatible_splice_junctions
    type:
      - 'null'
      - boolean
    doc: Do not require reads compatible with transcript splice junctions
    inputBinding:
      position: 101
      prefix: --nocompatible
  - id: normalize_annotated_tis
    type:
      - 'null'
      - boolean
    doc: Use only annotated TISs for normalization
    inputBinding:
      position: 101
      prefix: --normanno
  - id: normalize_common_tis
    type:
      - 'null'
      - boolean
    doc: Use common TISs instead of union TISs for normalization
    inputBinding:
      position: 101
      prefix: --normcomm
  - id: num_processes
    type:
      - 'null'
      - int
    doc: Number of processes
    inputBinding:
      position: 101
      prefix: -p
  - id: output_tis_diff_p_threshold
    type:
      - 'null'
      - float
    doc: 'Output TIS diff p value threshold (default: 0.05)'
    default: 0.05
    inputBinding:
      position: 101
      prefix: --opth
  - id: output_tis_diff_q_threshold
    type:
      - 'null'
      - float
    doc: 'Output TIS diff q value threshold (default: 0.05)'
    default: 0.05
    inputBinding:
      position: 101
      prefix: --oqth
  - id: paired_end
    type:
      - 'null'
      - boolean
    doc: Reads are paired end
    inputBinding:
      position: 101
      prefix: --paired
  - id: rnaseq_counts
    type:
      - 'null'
      - File
    doc: RNASeq count input
    inputBinding:
      position: 101
      prefix: --rnaseq
  - id: rnaseq_scale
    type:
      - 'null'
      - string
    doc: 'Input RNASeq scale factor of 2/1 (default: auto)'
    default: auto
    inputBinding:
      position: 101
      prefix: --rnascale
  - id: scale_factor
    type:
      - 'null'
      - string
    doc: 'Input TIS scale factor of 2/1 (default: auto)'
    default: auto
    inputBinding:
      position: 101
      prefix: --scalefactor
  - id: tis1_bam_paths
    type: string
    doc: Group 1 TIS enriched riboseq bam files, comma seperated
    inputBinding:
      position: 101
      prefix: --tis1bampaths
  - id: tis1_labels
    type:
      - 'null'
      - string
    doc: Labels for group 1 TIS data
    inputBinding:
      position: 101
      prefix: --l1
  - id: tis1_para
    type:
      - 'null'
      - string
    doc: Input offset parameter files for group 1 bam files
    inputBinding:
      position: 101
      prefix: --tis1para
  - id: tis1_paths
    type: string
    doc: Prediction results of group 1 TIS data
    inputBinding:
      position: 101
      prefix: --tis1paths
  - id: tis2_bam_paths
    type: string
    doc: Group 2 TIS enriched riboseq bam files, comma seperated
    inputBinding:
      position: 101
      prefix: --tis2bampaths
  - id: tis2_labels
    type:
      - 'null'
      - string
    doc: Labels for group 2 TIS data
    inputBinding:
      position: 101
      prefix: --l2
  - id: tis2_para
    type:
      - 'null'
      - string
    doc: Input offset parameter files for group 2 bam files
    inputBinding:
      position: 101
      prefix: --tis2para
  - id: tis2_paths
    type: string
    doc: Prediction results of group 2 TIS data
    inputBinding:
      position: 101
      prefix: --tis2paths
  - id: tis_q_value_index
    type:
      - 'null'
      - int
    doc: 'Index of TIS q value, 0 based (default: 15)'
    default: 15
    inputBinding:
      position: 101
      prefix: --qi
  - id: use_beta_binomial_test
    type:
      - 'null'
      - boolean
    doc: Use beta-binom test instead of Fisher's exact test for mRNA referenced 
      test
    inputBinding:
      position: 101
      prefix: --betabinom
  - id: use_chi2_test
    type:
      - 'null'
      - boolean
    doc: Use chisquare test instead of Fisher's exact test for mRNA referenced 
      test
    inputBinding:
      position: 101
      prefix: --chi2
  - id: use_secondary_alignments
    type:
      - 'null'
      - boolean
    doc: Use bam secondary alignments
    inputBinding:
      position: 101
      prefix: --secondary
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Increase output verbosity
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output
    type: File
    doc: Output result file
    outputBinding:
      glob: $(inputs.output)
  - id: plot_output
    type:
      - 'null'
      - File
    doc: Scatter plot output pdf file
    outputBinding:
      glob: $(inputs.plot_output)
  - id: plot_ma
    type:
      - 'null'
      - File
    doc: TIS normalization MA plot output pdf file
    outputBinding:
      glob: $(inputs.plot_ma)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ribotish:0.2.8--pyhdfd78af_0
