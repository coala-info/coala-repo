cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cnvetti
  - cmd
  - segment
label: cnvetti_cmd_segment
doc: "Segment normalized coverage. This command takes a normalized coverage BCF file and performs a segmentation of the coverage values found therein with the selected segmentation algorithm.\n\nTool homepage: https://github.com/bihealth/cnvetti"
inputs:
  - id: input
    type: File
    secondaryFiles:
      - .csi
    doc: "Path to indexed input BCF or VCF file from `cnvetti cmd coverage` output."
    inputBinding:
      position: 101
      prefix: --input
  - id: output
    type: string
    doc: "Path to output BCF file (will also write .csi file)"
    inputBinding:
      position: 101
      prefix: --output
  - id: output_segments
    type:
      - 'null'
      - string
    doc: "Path to output BCF file with the segment information (only)."
    inputBinding:
      position: 101
      prefix: --output-segments
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
  - id: xhmm_mean_target_count
    type:
      - 'null'
      - float
    doc: "Mean number of targets in a CNV for exome HMM segmentation. (default 6)"
    inputBinding:
      position: 101
      prefix: --xhmm-mean-target-count
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
    doc: "Path to output BCF file (will also write .csi file)"
    outputBinding:
      glob: $(inputs.output)
    secondaryFiles:
      - .csi
  - id: output_segments_file
    type:
      - 'null'
      - File
    doc: "Path to output BCF file with the segment information (only)."
    outputBinding:
      glob: $(inputs.output_segments)
    secondaryFiles:
      - .csi
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cnvetti:0.2.0--he4cf2ce_0
