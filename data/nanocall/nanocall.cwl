cwlVersion: v1.2
class: CommandLineTool
baseCommand: nanocall
label: nanocall
doc: "Call bases in Oxford Nanopore reads.\n\nTool homepage: https://github.com/WGLab/NanoCaller"
inputs:
  - id: input_path
    type:
      type: array
      items: File
    doc: 'Inputs: directories, fast5 files, or files of fast5 file names (use "-"
      to read fofn from stdin).'
    inputBinding:
      position: 1
  - id: basecall
    type:
      - 'null'
      - boolean
    doc: Enable basecalling (default).
    inputBinding:
      position: 102
      prefix: --basecall
  - id: chunk_size
    type:
      - 'null'
      - int
    doc: Thread chunk size.
    default: 1
    inputBinding:
      position: 102
      prefix: --chunk-size
  - id: double_strand_scaling
    type:
      - 'null'
      - boolean
    doc: Train scaling parameters per read. (default)
    inputBinding:
      position: 102
      prefix: --double-strand-scaling
  - id: ed_group
    type:
      - 'null'
      - string
    doc: EventDetection group to use.
    default: smallest available
    inputBinding:
      position: 102
      prefix: --ed-group
  - id: fasta_line_width
    type:
      - 'null'
      - int
    doc: Maximum fasta line width.
    default: 80
    inputBinding:
      position: 102
      prefix: --fasta-line-width
  - id: ignore_rest
    type:
      - 'null'
      - boolean
    doc: Ignores the rest of the labeled arguments following this flag.
    inputBinding:
      position: 102
      prefix: --
  - id: log
    type:
      - 'null'
      - type: array
        items: string
    doc: Log level.
    default: info
    inputBinding:
      position: 102
      prefix: --log
  - id: max_ed_events
    type:
      - 'null'
      - int
    doc: Maximum EventDetection events.
    default: 100000
    inputBinding:
      position: 102
      prefix: --max-ed-events
  - id: min_ed_events
    type:
      - 'null'
      - int
    doc: Minimum EventDetection events.
    default: 10
    inputBinding:
      position: 102
      prefix: --min-ed-events
  - id: model
    type:
      - 'null'
      - type: array
        items: string
    doc: Custom pore model for strand (0=template, 1=complement, 2=both).
    inputBinding:
      position: 102
      prefix: --model
  - id: model_fofn
    type:
      - 'null'
      - File
    doc: File of pore models.
    inputBinding:
      position: 102
      prefix: --model-fofn
  - id: no_basecall
    type:
      - 'null'
      - boolean
    doc: Disable basecalling.
    inputBinding:
      position: 102
      prefix: --no-basecall
  - id: no_train
    type:
      - 'null'
      - boolean
    doc: Disable all training.
    inputBinding:
      position: 102
      prefix: --no-train
  - id: no_train_scaling
    type:
      - 'null'
      - boolean
    doc: Do not train pore model scaling.
    inputBinding:
      position: 102
      prefix: --no-train-scaling
  - id: no_train_transitions
    type:
      - 'null'
      - boolean
    doc: Do not train state transitions.
    inputBinding:
      position: 102
      prefix: --no-train-transitions
  - id: one_d
    type:
      - 'null'
      - boolean
    doc: Interpret entire read as 1D template only.
    inputBinding:
      position: 102
      prefix: --1d
  - id: pore
    type:
      - 'null'
      - string
    doc: Pore name, used to select builtin pore model.
    default: r9
    inputBinding:
      position: 102
      prefix: --pore
  - id: pr_skip
    type:
      - 'null'
      - float
    doc: Transition probability of skipping at least 1 state.
    default: 0.3
    inputBinding:
      position: 102
      prefix: --pr-skip
  - id: pr_stay
    type:
      - 'null'
      - float
    doc: Transition probability of staying in the same state.
    default: 0.1
    inputBinding:
      position: 102
      prefix: --pr-stay
  - id: scaling_max_rounds
    type:
      - 'null'
      - int
    doc: Maximum scaling rounds.
    default: 10
    inputBinding:
      position: 102
      prefix: --scaling-max-rounds
  - id: scaling_min_progress
    type:
      - 'null'
      - float
    doc: Minimum scaling fit progress.
    default: 1
    inputBinding:
      position: 102
      prefix: --scaling-min-progress
  - id: scaling_num_events
    type:
      - 'null'
      - int
    doc: Number of events used for model scaling.
    default: 200
    inputBinding:
      position: 102
      prefix: --scaling-num-events
  - id: scaling_select_threshold
    type:
      - 'null'
      - float
    doc: Select best model per strand during scaling if log score better by 
      threshold.
    default: 20
    inputBinding:
      position: 102
      prefix: --scaling-select-threshold
  - id: single_strand_scaling
    type:
      - 'null'
      - boolean
    doc: Train scaling parameters per strand.
    inputBinding:
      position: 102
      prefix: --single-strand-scaling
  - id: stats
    type:
      - 'null'
      - File
    doc: Stats.
    inputBinding:
      position: 102
      prefix: --stats
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of parallel threads.
    default: 1
    inputBinding:
      position: 102
      prefix: --threads
  - id: train
    type:
      - 'null'
      - boolean
    doc: Enable training. (default)
    inputBinding:
      position: 102
      prefix: --train
  - id: train_drift
    type:
      - 'null'
      - string
    doc: Train drift parameter.
    default: yes for R73, no for R9
    inputBinding:
      position: 102
      prefix: --train-drift
  - id: trans
    type:
      - 'null'
      - File
    doc: Custom initial state transitions.
    inputBinding:
      position: 102
      prefix: --trans
  - id: trim_ed_hp_end
    type:
      - 'null'
      - int
    doc: Number of events to trim after hairpin end.
    default: 50
    inputBinding:
      position: 102
      prefix: --trim-ed-hp-end
  - id: trim_ed_hp_start
    type:
      - 'null'
      - int
    doc: Number of events to trim before hairpin start.
    default: 50
    inputBinding:
      position: 102
      prefix: --trim-ed-hp-start
  - id: trim_ed_sq_end
    type:
      - 'null'
      - int
    doc: Number of events to trim before sequence end.
    default: 50
    inputBinding:
      position: 102
      prefix: --trim-ed-sq-end
  - id: trim_ed_sq_start
    type:
      - 'null'
      - int
    doc: Number of events to trim after sequence start.
    default: 50
    inputBinding:
      position: 102
      prefix: --trim-ed-sq-start
  - id: write_fast5
    type:
      - 'null'
      - boolean
    doc: Write basecalls to fast5 files.
    inputBinding:
      position: 102
      prefix: --write-fast5
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanocall:v0.7.4--0
