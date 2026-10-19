cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ribotish
  - tisdiff
label: ribotish_tisdiff
doc: "Differential translation initiation site (TIS) analysis between two groups of TIS ribosome profiling data.\n\nTool homepage: https://github.com/zhpn1024/ribotish"
inputs:
  - id: tis1_paths
    type:
      type: array
      items: File
    doc: "Prediction results of group 1 TIS data (comma seperated on the command line)"
    inputBinding:
      position: 101
      prefix: '-1'
      itemSeparator: ','
  - id: tis2_paths
    type:
      type: array
      items: File
    doc: "Prediction results of group 2 TIS data (comma seperated on the command line)"
    inputBinding:
      position: 101
      prefix: '-2'
      itemSeparator: ','
  - id: tis1_bam_paths
    type:
      type: array
      items: File
    secondaryFiles:
      - .bai
    doc: "Group 1 TIS enriched riboseq bam files (comma seperated on the command line)"
    inputBinding:
      position: 101
      prefix: '-a'
      itemSeparator: ','
  - id: tis2_bam_paths
    type:
      type: array
      items: File
    secondaryFiles:
      - .bai
    doc: "Group 2 TIS enriched riboseq bam files (comma seperated on the command line)"
    inputBinding:
      position: 101
      prefix: '-b'
      itemSeparator: ','
  - id: gene_path
    type: File
    doc: "Gene annotation file"
    inputBinding:
      position: 101
      prefix: '-g'
  - id: tis1_para
    type:
      - 'null'
      - type: array
        items: File
    doc: "Input offset parameter files for group 1 bam files"
    inputBinding:
      position: 101
      prefix: '--tis1para'
      itemSeparator: ','
  - id: tis2_para
    type:
      - 'null'
      - type: array
        items: File
    doc: "Input offset parameter files for group 2 bam files"
    inputBinding:
      position: 101
      prefix: '--tis2para'
      itemSeparator: ','
  - id: gene_format
    type:
      - 'null'
      - string
    doc: "Gene annotation file format (gtf, bed, gpd, gff, default: auto)"
    inputBinding:
      position: 101
      prefix: '--geneformat'
  - id: max_nh
    type:
      - 'null'
      - int
    doc: "Max NH value allowed for bam alignments (default: 5)"
    inputBinding:
      position: 101
      prefix: '--maxNH'
  - id: min_map_q
    type:
      - 'null'
      - int
    doc: "Min MapQ value required for bam alignments (default: 1)"
    inputBinding:
      position: 101
      prefix: '--minMapQ'
  - id: secondary_alignments
    type:
      - 'null'
      - boolean
    doc: "Use bam secondary alignments"
    inputBinding:
      position: 101
      prefix: '--secondary'
  - id: paired_end
    type:
      - 'null'
      - boolean
    doc: "Reads are paired end"
    inputBinding:
      position: 101
      prefix: '--paired'
  - id: tis1_labels
    type:
      - 'null'
      - string
    doc: "Labels for group 1 TIS data"
    inputBinding:
      position: 101
      prefix: '--l1'
  - id: tis2_labels
    type:
      - 'null'
      - string
    doc: "Labels for group 2 TIS data"
    inputBinding:
      position: 101
      prefix: '--l2'
  - id: no_compatible_junctions
    type:
      - 'null'
      - boolean
    doc: "Do not require reads compatible with transcript splice junctions"
    inputBinding:
      position: 101
      prefix: '--nocompatible'
  - id: compatible_mis
    type:
      - 'null'
      - int
    doc: "Missed bases allowed in reads compatibility check"
    inputBinding:
      position: 101
      prefix: '--compatiblemis'
  - id: chr_map
    type:
      - 'null'
      - File
    doc: "Input chromosome id mapping table file if annotation chr ids are not same as chr ids in bam/fasta files"
    inputBinding:
      position: 101
      prefix: '--chrmap'
  - id: norm_comm
    type:
      - 'null'
      - boolean
    doc: "Use common TISs instead of union TISs for normalization"
    inputBinding:
      position: 101
      prefix: '--normcomm'
  - id: norm_anno
    type:
      - 'null'
      - boolean
    doc: "Use only annotated TISs for normalization"
    inputBinding:
      position: 101
      prefix: '--normanno'
  - id: rnaseq
    type:
      - 'null'
      - File
    doc: "RNASeq count input"
    inputBinding:
      position: 101
      prefix: '--rnaseq'
  - id: scale_factor
    type:
      - 'null'
      - string
    doc: "Input TIS scale factor of 2/1 (default: auto)"
    inputBinding:
      position: 101
      prefix: '--scalefactor'
  - id: rna_scale
    type:
      - 'null'
      - string
    doc: "Input RNASeq scale factor of 2/1 (default: auto)"
    inputBinding:
      position: 101
      prefix: '--rnascale'
  - id: chi2
    type:
      - 'null'
      - boolean
    doc: "Use chisquare test instead of Fisher's exact test for mRNA referenced test"
    inputBinding:
      position: 101
      prefix: '--chi2'
  - id: beta_binom
    type:
      - 'null'
      - boolean
    doc: "Use beta-binom test instead of Fisher's exact test for mRNA referenced test"
    inputBinding:
      position: 101
      prefix: '--betabinom'
  - id: export
    type:
      - 'null'
      - string
    doc: "Export count table for differential analysis with other tools"
    inputBinding:
      position: 101
      prefix: '--export'
  - id: plot_out
    type:
      - 'null'
      - string
    doc: "Scatter plot output pdf file"
    inputBinding:
      position: 101
      prefix: '--plotout'
  - id: fig_size
    type:
      - 'null'
      - string
    doc: "Scatter plot figure size (default: 8,8)"
    inputBinding:
      position: 101
      prefix: '--figsize'
  - id: plot_ma
    type:
      - 'null'
      - string
    doc: "TIS normalization MA plot output pdf file"
    inputBinding:
      position: 101
      prefix: '--plotma'
  - id: qi
    type:
      - 'null'
      - int
    doc: "Index of TIS q value, 0 based (default: 15)"
    inputBinding:
      position: 101
      prefix: '--qi'
  - id: fold_change
    type:
      - 'null'
      - float
    doc: "Minimum fold change threshold (default: 1.5)"
    inputBinding:
      position: 101
      prefix: '-f'
  - id: ipth
    type:
      - 'null'
      - float
    doc: "Input TIS p value threshold (default: 0.05)"
    inputBinding:
      position: 101
      prefix: '--ipth'
  - id: iqth
    type:
      - 'null'
      - float
    doc: "Input TIS q value threshold (default: 0.05)"
    inputBinding:
      position: 101
      prefix: '--iqth'
  - id: opth
    type:
      - 'null'
      - float
    doc: "Output TIS diff p value threshold (default: 0.05)"
    inputBinding:
      position: 101
      prefix: '--opth'
  - id: oqth
    type:
      - 'null'
      - float
    doc: "Output TIS diff q value threshold (default: 0.05)"
    inputBinding:
      position: 101
      prefix: '--oqth'
  - id: num_processes
    type:
      - 'null'
      - int
    doc: "Number of processes"
    inputBinding:
      position: 101
      prefix: '-p'
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Increase output verbosity"
    inputBinding:
      position: 101
      prefix: '-v'
  - id: output_path
    type: string
    doc: "Output result file"
    inputBinding:
      position: 102
      prefix: '-o'
outputs:
  - id: output
    type: File
    doc: "Differential TIS result file"
    outputBinding:
      glob: $(inputs.output_path)
  - id: exported_counts
    type:
      - 'null'
      - File
    doc: "Count table (--export)"
    outputBinding:
      glob: $(inputs.export)
  - id: scatter_plot
    type:
      - 'null'
      - File
    doc: "Scatter plot (--plotout)"
    outputBinding:
      glob: $(inputs.plot_out)
  - id: ma_plot
    type:
      - 'null'
      - File
    doc: "MA plot (--plotma)"
    outputBinding:
      glob: $(inputs.plot_ma)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ribotish:0.2.8--pyhdfd78af_0
stdout: ribotish_tisdiff.out
