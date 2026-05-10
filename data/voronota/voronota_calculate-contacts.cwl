cwlVersion: v1.2
class: CommandLineTool
baseCommand: voronota_calculate-contacts
label: voronota_calculate-contacts
doc: "Calculates contacts between balls.\n\nTool homepage: https://www.voronota.com/"
inputs:
  - id: input_balls
    type: File
    doc: list of balls (stdin)
    inputBinding:
      position: 1
  - id: add_mirrored
    type:
      - 'null'
      - boolean
    doc: flag to add mirrored contacts to non-annnotated output
    inputBinding:
      position: 102
      prefix: --add-mirrored
  - id: annotated
    type:
      - 'null'
      - boolean
    doc: flag to enable annotated mode
    inputBinding:
      position: 102
      prefix: --annotated
  - id: draw
    type:
      - 'null'
      - boolean
    doc: flag to output graphics for annotated contacts
    inputBinding:
      position: 102
      prefix: --draw
  - id: exclude_hidden_balls
    type:
      - 'null'
      - boolean
    doc: flag to exclude hidden input balls
    inputBinding:
      position: 102
      prefix: --exclude-hidden-balls
  - id: probe_radius
    type:
      - 'null'
      - float
    doc: probe radius
    inputBinding:
      position: 102
      prefix: --probe
  - id: projections
    type:
      - 'null'
      - int
    doc: curve optimization depth
    inputBinding:
      position: 102
      prefix: --projections
  - id: sih_depth
    type:
      - 'null'
      - int
    doc: spherical surface optimization depth
    inputBinding:
      position: 102
      prefix: --sih-depth
  - id: step
    type:
      - 'null'
      - float
    doc: curve step length
    inputBinding:
      position: 102
      prefix: --step
  - id: tag_centrality
    type:
      - 'null'
      - boolean
    doc: flag to tag contacts centrality
    inputBinding:
      position: 102
      prefix: --tag-centrality
  - id: tag_peripherial
    type:
      - 'null'
      - boolean
    doc: flag to tag peripherial contacts
    inputBinding:
      position: 102
      prefix: --tag-peripherial
  - id: old_contacts_output_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `old_contacts_output_path`
    inputBinding:
      position: 103
      prefix: --old-contacts-output
  - id: volumes_output_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `volumes_output_path`
    inputBinding:
      position: 104
      prefix: --volumes-output
outputs:
  - id: old_contacts_output
    type:
      - 'null'
      - File
    doc: file path to output spherical contacts
    outputBinding:
      glob: $(inputs.old_contacts_output_path)
  - id: volumes_output
    type:
      - 'null'
      - File
    doc: file path to output constrained cells volumes
    outputBinding:
      glob: $(inputs.volumes_output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/voronota:1.29.4602--h5755088_0
