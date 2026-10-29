cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tombo
  - filter
  - genome_locations
label: ont-tombo_filter_genome_locations
doc: "Filter reads based on mapping location.\n\nTool homepage: https://github.com/nanoporetech/tombo"
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
  - id: include_regions
    type:
      - 'null'
      - type: array
        items: string
    doc: "Filter out reads not falling completely within include regions. Omit start and end coordinates to include an entire chromosome/sequence record. Format regions as \"chrm[:start-end] [chrm2[:start2-end2] ...]\"."
    inputBinding:
      position: 101
      prefix: "--include-regions"
  - id: include_partial_overlap
    type:
      - 'null'
      - boolean
    doc: "Include reads that partially overlap the specified region. Default: Only include reads completely contained in a specified region"
    inputBinding:
      position: 101
      prefix: "--include-partial-overlap"
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
