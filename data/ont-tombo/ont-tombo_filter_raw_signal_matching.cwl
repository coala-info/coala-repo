cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tombo
  - filter
  - raw_signal_matching
label: ont-tombo_filter_raw_signal_matching
doc: "Filter reads with poor raw to expected signal matching.\n\nTool homepage: https://github.com/nanoporetech/tombo"
inputs:
  - id: fast5_basedirs
    type:
      type: array
      items: Directory
    doc: "Directories containing fast5 files."
    inputBinding:
      position: 101
      prefix: "--fast5-basedirs"
      valueFrom: "$(self.map(function(d) { return d.basename; }))"
  - id: signal_matching_score
    type: float
    doc: "Observed to expected signal matching score (higher score indicates poor matching). Sample type defaults: RNA : 2 || DNA : 1.1"
    inputBinding:
      position: 101
      prefix: "--signal-matching-score"
  - id: corrected_group
    type:
      - 'null'
      - string
    doc: "FAST5 group created by resquiggle command. Default: RawGenomeCorrected_000"
    inputBinding:
      position: 101
      prefix: "--corrected-group"
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: "Don't print status information."
    inputBinding:
      position: 101
      prefix: "--quiet"
outputs:
  - id: fast5_dirs
    type:
      type: array
      items: Directory
    doc: "FAST5 directories with the filter applied to the re-squiggle index"
    outputBinding:
      glob: "$(inputs.fast5_basedirs.map(function(d) { return d.basename; }))"
  - id: tombo_index_files
    type:
      type: array
      items: File
    doc: "Tombo index files (hidden .tombo.index files) holding the filter marks"
    outputBinding:
      glob: "$(inputs.fast5_basedirs.map(function(d) { return '.' + d.basename + '.' + (inputs.corrected_group || 'RawGenomeCorrected_000') + '.tombo.index'; }))"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.fast5_basedirs)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ont-tombo:1.5.1--py37r36hb3f55d8_0
