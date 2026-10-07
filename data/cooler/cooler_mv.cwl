cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cooler
  - mv
label: cooler_mv
doc: "Rename a cooler within the same file.\n\nTool homepage: https://github.com/open2c/cooler"
inputs:
  - id: cool_file
    type: File
    doc: Cooler file that holds the source cooler; it is changed in place and 
      returned as output.
  - id: src_uri
    type: string
    doc: Source cooler group inside cool_file (e.g. / or resolutions/1000)
    inputBinding:
      position: 1
      valueFrom: $(inputs.cool_file.basename)::$(self)
  - id: dst_uri
    type: string
    doc: Destination cooler group inside cool_file
    inputBinding:
      position: 2
      valueFrom: $(inputs.cool_file.basename)::$(self)
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
  - id: out_cool
    type: File
    doc: The changed cooler file
    outputBinding:
      glob: $(inputs.cool_file.basename)
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.cool_file)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cooler:0.10.4--pyhdfd78af_0
stdout: cooler_mv.out
