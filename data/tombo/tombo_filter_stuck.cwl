cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tombo
  - filter_stuck
label: tombo_filter_stuck
doc: "Filter reads based on observations per base percentile thresholds to identify
  'stuck' reads.\n\nTool homepage: https://github.com/nanoporetech/tombo"
inputs:
  - id: corrected_group
    type:
      - 'null'
      - string
    doc: FAST5 group created by resquiggle command.
    default: RawGenomeCorrected_000
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
  - id: obs_per_base_filter
    type:
      - 'null'
      - type: array
        items: string
    doc: Filter reads based on observations per base percentile thresholds. 
      Format thresholds as "percentile:thresh [pctl2:thresh2 ...]". For example 
      to filter reads with 99th pctl > 200 obs/base or max > 5k obs/base use 
      "99:200 100:5000".
    inputBinding:
      position: 101
      prefix: --obs-per-base-filter
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Don't print status information.
    inputBinding:
      position: 101
      prefix: --quiet
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tombo:1.0--py27_0
stdout: tombo_filter_stuck.out
