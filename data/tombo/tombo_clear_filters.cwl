cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tombo
  - clear_filters
label: tombo_clear_filters
doc: "Clear filters from FAST5 files in the specified directories.\n\nTool homepage:
  https://github.com/nanoporetech/tombo"
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
