cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tombo
  - model_resquiggle
label: tombo_model_resquiggle
doc: "Perform model-based re-squiggle of FAST5 files to refine signal-to-sequence
  alignment.\n\nTool homepage: https://github.com/nanoporetech/tombo"
inputs:
  - id: base_score_iterations
    type:
      - 'null'
      - int
    doc: Number of iterations through each read to perform (computationally 
      expensive) base space model re-squiggle algorithm.
    inputBinding:
      position: 101
      prefix: --base-score-iterations
  - id: base_score_max_bases_shift
    type:
      - 'null'
      - int
    doc: Maximum bases to shift raw signal from first round of model 
      re-squiggle.
    inputBinding:
      position: 101
      prefix: --base-score-max-bases-shift
  - id: base_score_region_context
    type:
      - 'null'
      - int
    doc: Number of context bases up and downstream of poorly fit regions to 
      perform iterative base-score model re-squiggle.
    inputBinding:
      position: 101
      prefix: --base-score-region-context
  - id: basecall_subgroups
    type:
      - 'null'
      - type: array
        items: string
    doc: FAST5 subgroup(s) (under Analyses/[corrected-group]) containing 
      basecalls.
    inputBinding:
      position: 101
      prefix: --basecall-subgroups
  - id: corrected_group
    type:
      - 'null'
      - string
    doc: FAST5 group created by resquiggle command.
    inputBinding:
      position: 101
      prefix: --corrected-group
  - id: fast5_basedirs
    type:
      type: array
      items: Directory
    doc: Directories containing fast5 files.
    inputBinding:
      position: 101
      prefix: --fast5-basedirs
  - id: include_event_stdev
    type:
      - 'null'
      - boolean
    doc: Include corrected event standard deviation in output FAST5 data.
    inputBinding:
      position: 101
      prefix: --include-event-stdev
  - id: max_bases_shift
    type:
      - 'null'
      - int
    doc: Maximum bases to shift raw signal from event_resquiggle assignment.
    inputBinding:
      position: 101
      prefix: --max-bases-shift
  - id: min_obs_per_base
    type:
      - 'null'
      - int
    doc: Minimum raw observations to assign to a genomic base.
    inputBinding:
      position: 101
      prefix: --min-obs-per-base
  - id: new_corrected_group
    type:
      - 'null'
      - string
    doc: FAST5 group created by resquiggle command.
    inputBinding:
      position: 101
      prefix: --new-corrected-group
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: 'Overwrite previous corrected group in FAST5 files. Note: only effects --corrected-group
      or --new-corrected-group.'
    inputBinding:
      position: 101
      prefix: --overwrite
  - id: p_value_threshold
    type:
      - 'null'
      - float
    doc: P-value threshold to identify regions to apply model re-squiggle 
      algorithm.
    inputBinding:
      position: 101
      prefix: --p-value-threshold
  - id: processes
    type:
      - 'null'
      - int
    doc: Number of processes.
    inputBinding:
      position: 101
      prefix: --processes
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Don't print status information.
    inputBinding:
      position: 101
      prefix: --quiet
  - id: region_context
    type:
      - 'null'
      - int
    doc: Number of context bases up and downstream of poorly fit regions to 
      perform model re-squiggle.
    inputBinding:
      position: 101
      prefix: --region-context
  - id: stouffer_z_context
    type:
      - 'null'
      - int
    doc: Number of context bases up and downstream over which to compute 
      Stouffer's Z combined z-scores.
    inputBinding:
      position: 101
      prefix: --stouffer-z-context
  - id: tombo_model_filename
    type:
      - 'null'
      - File
    doc: Tombo model for event-less resquiggle and significance testing. If no 
      model is provided the default DNA or RNA tombo model will be used.
    inputBinding:
      position: 101
      prefix: --tombo-model-filename
outputs:
  - id: failed_reads_filename
    type:
      - 'null'
      - File
    doc: Output failed read filenames with assoicated error.
    outputBinding:
      glob: $(inputs.failed_reads_filename)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tombo:1.0--py27_0
