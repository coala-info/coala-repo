cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cnvetti
  - quick
  - wis-call
label: cnvetti_quick_wis-call
doc: "Perform CNV calling on germline or unmatched tumor using within-sample approach. This shortcut takes the within-sample model from `cnvetti quick wis-build-model` and a BAM file of one sample, generates on-target CNV analysis and performs CNV variant calling.\n\nTool homepage: https://github.com/bihealth/cnvetti"
inputs:
  - id: input
    type: File
    secondaryFiles:
      - .bai
    doc: "Path to indexed input BAM file."
    inputBinding:
      position: 1
  - id: input_model
    type: File
    secondaryFiles:
      - .csi
    doc: "Path to BCF file with the WIS model."
    inputBinding:
      position: 101
      prefix: --input-model
  - id: output
    type: string
    doc: "Path to output CNV call file."
    inputBinding:
      position: 101
      prefix: --output
  - id: output_targets
    type:
      - 'null'
      - string
    doc: "Optional path to BCF file with per-target coverage information."
    inputBinding:
      position: 101
      prefix: --output-targets
  - id: output_igv_cov
    type:
      - 'null'
      - string
    doc: "Optional path to IGV file to write (linear relative) coverage to."
    inputBinding:
      position: 101
      prefix: --output-igv-cov
  - id: output_igv_cov2
    type:
      - 'null'
      - string
    doc: "Optional path to IGV file to write log2-scaled coverage to."
    inputBinding:
      position: 101
      prefix: --output-igv-cov2
  - id: output_igv_covz
    type:
      - 'null'
      - string
    doc: "Optional path to IGV file to write coverage Z-score to."
    inputBinding:
      position: 101
      prefix: --output-igv-covz
  - id: output_igv_scov
    type:
      - 'null'
      - string
    doc: "Optional path to IGV file to write (linear relative) smoothed coverage to."
    inputBinding:
      position: 101
      prefix: --output-igv-scov
  - id: output_igv_scov2
    type:
      - 'null'
      - string
    doc: "Optional path to IGV file to write log2-scaled smoothed coverage to."
    inputBinding:
      position: 101
      prefix: --output-igv-scov2
  - id: output_igv_seg
    type:
      - 'null'
      - string
    doc: "Optional path to IGV file to write (linear relative) segmented coverage to."
    inputBinding:
      position: 101
      prefix: --output-igv-seg
  - id: output_igv_seg2
    type:
      - 'null'
      - string
    doc: "Optional path to IGV file to write log2-scaled segmented coverage to."
    inputBinding:
      position: 101
      prefix: --output-igv-seg2
  - id: segmentation
    type: string
    doc: "The method to use for the segmentation. Possible values: HaarSeg, CircularBinarySegmentation, GenomeHiddenMarkovModel, ExomeHiddenMarkovModel, WISExome"
    inputBinding:
      position: 101
      prefix: --segmentation
  - id: thresh_p_value
    type:
      - 'null'
      - float
    doc: "P-value threshold (default 0.05)"
    inputBinding:
      position: 101
      prefix: --thresh-p-value
  - id: haar_seg_l_min
    type:
      - 'null'
      - int
    doc: "HaarSeg minimal level (default 1)"
    inputBinding:
      position: 101
      prefix: --haar-seg-l-min
  - id: haar_seg_l_max
    type:
      - 'null'
      - int
    doc: "HaarSeg maximal level (default 5)"
    inputBinding:
      position: 101
      prefix: --haar-seg-l-max
  - id: haar_seg_fdr
    type:
      - 'null'
      - float
    doc: "HaarSeg FDR (default 0.001)"
    inputBinding:
      position: 101
      prefix: --haar-seg-fdr
  - id: wisexome_max_window_size
    type:
      - 'null'
      - int
    doc: "WISExome maximal window size (default 15)"
    inputBinding:
      position: 101
      prefix: --wisexome-max-window-size
  - id: wisexome_thresh_rel_cov
    type:
      - 'null'
      - float
    doc: "Threshold on relative coverage deviation. (default 0.35)"
    inputBinding:
      position: 101
      prefix: --wisexome-thresh-rel-cov
  - id: wisexome_thresh_z_score
    type:
      - 'null'
      - float
    doc: "Threshold on Z-score (default 5.64)"
    inputBinding:
      position: 101
      prefix: --wisexome-thresh-z-score
  - id: xhmm_z_score_threshold
    type:
      - 'null'
      - float
    doc: "Z-score threshold to use. (default 3.0)"
    inputBinding:
      position: 101
      prefix: --xhmm-z-score-threshold
  - id: xhmm_cnv_rate
    type:
      - 'null'
      - float
    doc: "Expected exome-wide CNV rate for exome HMM segmentation. (default 1e-08)"
    inputBinding:
      position: 101
      prefix: --xhmm-cnv-rate
  - id: xhmm_cnv_target_count
    type:
      - 'null'
      - float
    doc: "Mean number of targets in a CNV for exome HMM segmentation. (default 6)"
    inputBinding:
      position: 101
      prefix: --xhmm-cnv-target-count
  - id: xhmm_mean_target_dist
    type:
      - 'null'
      - float
    doc: "Mean distance of targets in a CNV for exome HMM segmentation. (default 70000)"
    inputBinding:
      position: 101
      prefix: --xhmm-mean-target-dist
  - id: io_threads
    type:
      - 'null'
      - int
    doc: "Number of additional threads to use for (de)compression in I/O."
    inputBinding:
      position: 101
      prefix: --io-threads
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: "Decrease verbosity"
    inputBinding:
      position: 101
      prefix: --quiet
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Increase verbosity"
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: "Path to output CNV call file."
    outputBinding:
      glob: $(inputs.output)
    secondaryFiles:
      - .csi
  - id: output_targets_file
    type:
      - 'null'
      - File
    doc: "Optional path to BCF file with per-target coverage information."
    outputBinding:
      glob: $(inputs.output_targets)
    secondaryFiles:
      - .csi
  - id: output_igv_cov_file
    type:
      - 'null'
      - File
    doc: "Optional path to IGV file to write (linear relative) coverage to."
    outputBinding:
      glob: $(inputs.output_igv_cov)
  - id: output_igv_cov2_file
    type:
      - 'null'
      - File
    doc: "Optional path to IGV file to write log2-scaled coverage to."
    outputBinding:
      glob: $(inputs.output_igv_cov2)
  - id: output_igv_covz_file
    type:
      - 'null'
      - File
    doc: "Optional path to IGV file to write coverage Z-score to."
    outputBinding:
      glob: $(inputs.output_igv_covz)
  - id: output_igv_scov_file
    type:
      - 'null'
      - File
    doc: "Optional path to IGV file to write (linear relative) smoothed coverage to."
    outputBinding:
      glob: $(inputs.output_igv_scov)
  - id: output_igv_scov2_file
    type:
      - 'null'
      - File
    doc: "Optional path to IGV file to write log2-scaled smoothed coverage to."
    outputBinding:
      glob: $(inputs.output_igv_scov2)
  - id: output_igv_seg_file
    type:
      - 'null'
      - File
    doc: "Optional path to IGV file to write (linear relative) segmented coverage to."
    outputBinding:
      glob: $(inputs.output_igv_seg)
  - id: output_igv_seg2_file
    type:
      - 'null'
      - File
    doc: "Optional path to IGV file to write log2-scaled segmented coverage to."
    outputBinding:
      glob: $(inputs.output_igv_seg2)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cnvetti:0.2.0--he4cf2ce_0
