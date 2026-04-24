cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tombo
  - write_wiggles
label: tombo_write_wiggles
doc: "Write wiggle files from FAST5 data or statistics for visualization.\n\nTool
  homepage: https://github.com/nanoporetech/tombo"
inputs:
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
  - id: control_fast5_basedirs
    type:
      - 'null'
      - type: array
        items: Directory
    doc: Control set of directories containing fast5 files. These reads should 
      contain only standard nucleotides.
    inputBinding:
      position: 101
      prefix: --control-fast5-basedirs
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
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Don't print status information.
    inputBinding:
      position: 101
      prefix: --quiet
  - id: statistics_filename
    type:
      - 'null'
      - File
    doc: File to save/load base by base statistics.
    inputBinding:
      position: 101
      prefix: --statistics-filename
  - id: wiggle_types
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Data types of wiggles to produce. Options: coverage, fraction, signal, signal_sd,
      length, stat, mt_stat, difference.'
    inputBinding:
      position: 101
      prefix: --wiggle-types
outputs:
  - id: wiggle_basename
    type:
      - 'null'
      - File
    doc: Basename for output wiggle files. Two files (plus and minus strand) 
      will be produced for each --wiggle-types supplied.
    outputBinding:
      glob: $(inputs.wiggle_basename)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tombo:1.0--py27_0
