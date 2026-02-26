cwlVersion: v1.2
class: CommandLineTool
baseCommand: meta
label: meta-neuro_meta
doc: "Medial Tractography Analysis (MeTA) for White Matter Bundle Parcellation\n\n\
  Tool homepage: https://github.com/bagari/meta"
inputs:
  - id: bundle
    type:
      - 'null'
      - string
    doc: Name of white matter bundle
    inputBinding:
      position: 101
      prefix: --bundle
  - id: extract
    type:
      - 'null'
      - boolean
    doc: Extract largest connected set in bundle mesh
    inputBinding:
      position: 101
      prefix: --extract
  - id: fill
    type:
      - 'null'
      - boolean
    doc: Fill holes in bundle mesh
    inputBinding:
      position: 101
      prefix: --fill
  - id: inverse
    type:
      - 'null'
      - boolean
    doc: Inverse transformation matrix if direction subject → MNI
    inputBinding:
      position: 101
      prefix: --inverse
  - id: mask
    type: File
    doc: Mask of white matter bundle
    inputBinding:
      position: 101
      prefix: --mask
  - id: mbundle
    type: File
    doc: Streamlines of model bundle
    inputBinding:
      position: 101
      prefix: --mbundle
  - id: medial_surface
    type: File
    doc: Medial surface of white matter bundle in vtk format
    inputBinding:
      position: 101
      prefix: --medial_surface
  - id: num_segments
    type:
      - 'null'
      - int
    doc: The required number of segments along the bundle length
    inputBinding:
      position: 101
      prefix: --num_segments
  - id: percent
    type:
      - 'null'
      - float
    doc: Percent of distance to keep from each side of Medial surface
    inputBinding:
      position: 101
      prefix: --percent
  - id: sbundle
    type: File
    doc: Streamlines of subject bundle
    inputBinding:
      position: 101
      prefix: --sbundle
  - id: size
    type:
      - 'null'
      - int
    doc: Maximum hole size to fill
    inputBinding:
      position: 101
      prefix: --size
  - id: subject
    type:
      - 'null'
      - string
    doc: Subject IDs
    inputBinding:
      position: 101
      prefix: --subject
  - id: transform
    type:
      - 'null'
      - File
    doc: 'Transformation matrix: MNI → subject space'
    inputBinding:
      position: 101
      prefix: --transform
  - id: volume
    type: File
    doc: Volume of white matter bundle in vtk format (mesh)
    inputBinding:
      position: 101
      prefix: --volume
outputs:
  - id: output
    type: Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/meta-neuro:2.0.1--py313h47f2c4e_0
