cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - jclusterfunk
  - reroot
label: jclusterfunk_reroot
doc: "Re-root the tree using an outgroup.\n\nTool homepage: https://github.com/snake-flu/jclusterfunk"
inputs:
  - id: field_delimiter
    type:
      - 'null'
      - string
    doc: "the delimiter used to specify fields in the tip labels (default = '|')"
    inputBinding:
      position: 101
      prefix: --field-delimiter
  - id: format
    type:
      - 'null'
      - string
    doc: output file format (nexus or newick)
    inputBinding:
      position: 101
      prefix: --format
  - id: id_field
    type:
      - 'null'
      - int
    doc: tip label field to use to match metadata (default = whole label)
    inputBinding:
      position: 101
      prefix: --id-field
  - id: input_file
    type: File
    doc: input tree file
    inputBinding:
      position: 101
      prefix: --input
  - id: midpoint
    type:
      - 'null'
      - boolean
    doc: midpoint root the tree
    inputBinding:
      position: 101
      prefix: --midpoint
  - id: outgroups
    type:
      - 'null'
      - type: array
        items: string
    doc: a list of tips to use as an outgroup for re-rooting
    inputBinding:
      position: 101
      prefix: --outgroups
  - id: root_location
    type:
      - 'null'
      - double
    doc: location on the root branch for the root as a fraction of the branch length from the ingroup
    inputBinding:
      position: 101
      prefix: --root-location
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: write analysis details to console
    inputBinding:
      position: 101
      prefix: --verbose
  - id: output_file_path
    type: string
    doc: output file
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: output_file
    type: File
    doc: output file
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jclusterfunk:0.0.25--hdfd78af_0
