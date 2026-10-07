cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cnvetti
  - cmd
  - genotype
label: cnvetti_cmd_genotype
doc: "Genotype calls from segmentation or calls and coverage BCF files. This command either creates genotype calls from a segmetation or from a call and a coverage BCF file. It will write out a variant call file.\n\nTool homepage: https://github.com/bihealth/cnvetti"
inputs:
  - id: input
    type: File
    secondaryFiles:
      - .csi
    doc: "Path to indexed input per-region segmentation or coverage file."
    inputBinding:
      position: 101
      prefix: --input
  - id: input_calls
    type:
      - 'null'
      - File
    secondaryFiles:
      - .csi
    doc: "Optional path to indexed call file."
    inputBinding:
      position: 101
      prefix: --input-calls
  - id: output
    type: string
    doc: "Path to output BCF file (will also write .csi file)"
    inputBinding:
      position: 101
      prefix: --output
  - id: genotyping
    type: string
    doc: "The method to use for the genotyping. Possible values: ExomeHiddenMarkovModel, SegmentOverlap"
    inputBinding:
      position: 101
      prefix: --genotyping
  - id: segmentation
    type: string
    doc: "The method to use for the segmentation when using SegmentOverlap genotyping. Possible values: HaarSeg"
    inputBinding:
      position: 101
      prefix: --segmentation
  - id: overlap
    type:
      - 'null'
      - float
    doc: "Overlap to require for calling a segment as called when using SegmentOverlap genotyping. (default 0.8)"
    inputBinding:
      position: 101
      prefix: --overlap
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
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cnvetti:0.2.0--he4cf2ce_0
