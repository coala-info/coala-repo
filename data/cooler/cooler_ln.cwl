cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cooler
  - ln
label: cooler_ln
doc: "Create a hard link to a cooler (rather than a true copy) in the same file.\n\
  \  Also supports soft links (in the same file) or external links (different\n  files).\n\
  \nTool homepage: https://github.com/open2c/cooler"
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
  - id: soft
    type:
      - 'null'
      - boolean
    doc: "Creates a soft link rather than a hard link if the source\n            \
      \       and destination file are the same. Otherwise, creates an\n         \
      \          external link. This type of link uses a path rather than a\n    \
      \               pointer."
    inputBinding:
      position: 103
      prefix: --soft
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
stdout: cooler_ln.out
