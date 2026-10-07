cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cnvetti
  - cmd
  - build-model-wis
label: cnvetti_cmd_build-model-wis
doc: "Build within-sample model. This command takes a multi-sample coverage file and computes a model for the analysis using the WISExome approach by Straver et al. (2018).\n\nTool homepage: https://github.com/bihealth/cnvetti"
inputs:
  - id: input
    type: File
    secondaryFiles:
      - .csi
    doc: "Path to indexed input BCF file from wise count."
    inputBinding:
      position: 101
      prefix: --input
  - id: output
    type: string
    doc: "Path to output normalized counts BCF file."
    inputBinding:
      position: 101
      prefix: --output
  - id: num_threads
    type:
      - 'null'
      - int
    doc: "Number of threads to use, '0' to disable multi-threading. (default 0)"
    inputBinding:
      position: 101
      prefix: --num-threads
  - id: filter_z_score
    type:
      - 'null'
      - float
    doc: "Threshold on z score (default 5.64)"
    inputBinding:
      position: 101
      prefix: --filter-z-score
  - id: filter_rel
    type:
      - 'null'
      - float
    doc: "Relative threshold (default 0.35)"
    inputBinding:
      position: 101
      prefix: --filter-rel
  - id: min_ref_targets
    type:
      - 'null'
      - int
    doc: "Minimal number of targets before filtering (default 10)"
    inputBinding:
      position: 101
      prefix: --min-ref-targets
  - id: max_ref_targets
    type:
      - 'null'
      - int
    doc: "Number of targets to start out with. (default 100)"
    inputBinding:
      position: 101
      prefix: --max-ref-targets
  - id: max_samples_reliable
    type:
      - 'null'
      - int
    doc: "If a CNV is called for more than this many reference samples then ignore. (default 4)"
    inputBinding:
      position: 101
      prefix: --max-samples-reliable
  - id: min_samples_min_fragments
    type:
      - 'null'
      - int
    doc: "Minimal number of samples that must have a number of fragments above `--min-fragments` from `normalize`. (default 10)"
    inputBinding:
      position: 101
      prefix: --min-samples-min-fragments
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
    doc: "Path to output normalized counts BCF file."
    outputBinding:
      glob: $(inputs.output)
    secondaryFiles:
      - .csi
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cnvetti:0.2.0--he4cf2ce_0
