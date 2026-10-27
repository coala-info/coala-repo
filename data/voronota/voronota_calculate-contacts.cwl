cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - voronota
  - calculate-contacts
label: voronota_calculate-contacts
doc: "Calculates contacts between balls.

Tool homepage: https://www.voronota.com/"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: input_balls
    type: File
    doc: "list of balls (stdin)"
  - id: annotated
    type:
      - 'null'
      - boolean
    doc: "flag to enable annotated mode"
    inputBinding:
      position: 101
      prefix: --annotated
  - id: probe
    type:
      - 'null'
      - float
    doc: "probe radius"
    inputBinding:
      position: 101
      prefix: --probe
  - id: exclude_hidden_balls
    type:
      - 'null'
      - boolean
    doc: "flag to exclude hidden input balls"
    inputBinding:
      position: 101
      prefix: --exclude-hidden-balls
  - id: step
    type:
      - 'null'
      - float
    doc: "curve step length"
    inputBinding:
      position: 101
      prefix: --step
  - id: projections
    type:
      - 'null'
      - int
    doc: "curve optimization depth"
    inputBinding:
      position: 101
      prefix: --projections
  - id: sih_depth
    type:
      - 'null'
      - int
    doc: "spherical surface optimization depth"
    inputBinding:
      position: 101
      prefix: --sih-depth
  - id: add_mirrored
    type:
      - 'null'
      - boolean
    doc: "flag to add mirrored contacts to non-annnotated output"
    inputBinding:
      position: 101
      prefix: --add-mirrored
  - id: draw
    type:
      - 'null'
      - boolean
    doc: "flag to output graphics for annotated contacts"
    inputBinding:
      position: 101
      prefix: --draw
  - id: tag_centrality
    type:
      - 'null'
      - boolean
    doc: "flag to tag contacts centrality"
    inputBinding:
      position: 101
      prefix: --tag-centrality
  - id: tag_peripherial
    type:
      - 'null'
      - boolean
    doc: "flag to tag peripherial contacts"
    inputBinding:
      position: 101
      prefix: --tag-peripherial
  - id: old_contacts_output_path
    type:
      - 'null'
      - string
    doc: "file path to output spherical contacts"
    inputBinding:
      position: 101
      prefix: --old-contacts-output
  - id: volumes_output_path
    type:
      - 'null'
      - string
    doc: "file path to output constrained cells volumes"
    inputBinding:
      position: 101
      prefix: --volumes-output
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: old_contacts_output
    type:
      - 'null'
      - File
    doc: "file path to output spherical contacts"
    outputBinding:
      glob: $(inputs.old_contacts_output_path)
  - id: volumes_output
    type:
      - 'null'
      - File
    doc: "file path to output constrained cells volumes"
    outputBinding:
      glob: $(inputs.volumes_output_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/voronota:1.29.4602--h5755088_0
stdin: $(inputs.input_balls.path)
stdout: voronota_calculate-contacts.out
