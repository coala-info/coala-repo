cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cooler
  - cp
label: cooler_cp
doc: "Copy a cooler from one file to another or within the same file.\n\nTool homepage:
  https://github.com/open2c/cooler"
inputs:
  - id: src_uri
    type: File
    doc: Source cooler file
    inputBinding:
      position: 1
      valueFrom: "$(inputs.src_group ? self.path + '::' + inputs.src_group : self.path)"
  - id: src_group
    type:
      - 'null'
      - string
    doc: Group of the source cooler inside the file (e.g. resolutions/1000 in an
      .mcool); the root cooler if not set.
  - id: dst_uri
    type: string
    doc: Destination cooler URI (output file name, optionally followed by 
      ::group)
    inputBinding:
      position: 2
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Truncate and replace destination file if it already exists.
    inputBinding:
      position: 103
      prefix: --overwrite
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: dst_file
    type: File
    doc: Destination cooler file
    outputBinding:
      glob: $(inputs.dst_uri.split('::')[0])
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cooler:0.10.4--pyhdfd78af_0
stdout: cooler_cp.out
