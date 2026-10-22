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
      valueFrom: '$(self === null ? null : self.map(function(d) { return d.basename;
        }))'
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
  - id: index_files
    type:
      type: array
      items: File
    doc: Tombo index files written by resquiggle (hidden files named .<fast5 
      directory>.<corrected group>.tombo.index), one for each fast5 directory. 
      The filter is stored in these files.
outputs:
  - id: tombo_index_files
    type:
      type: array
      items: File
    doc: Updated tombo index files with the read filter stored
    outputBinding:
      glob: .*.tombo.index
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.fast5_basedirs)
        writable: true
      - entry: $(inputs.index_files)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tombo:1.0--py27_0
