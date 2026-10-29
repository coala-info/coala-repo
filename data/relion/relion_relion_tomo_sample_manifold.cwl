cwlVersion: v1.2
class: CommandLineTool
baseCommand: relion_tomo_sample_manifold
label: relion_relion_tomo_sample_manifold
doc: "Sample particle positions on manifolds (membranes or spheres) in tomograms.\n\nTool homepage: https://github.com/3dem/relion"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.staged_files)
inputs:
  - id: optimisation_set
    type:
      - 'null'
      - File
    doc: Optimisation set
    inputBinding:
      position: 101
      prefix: --i
  - id: tomogram_set
    type:
      - 'null'
      - File
    doc: Tomogram set
    inputBinding:
      position: 101
      prefix: --t
  - id: manifolds_set
    type:
      - 'null'
      - File
    doc: Manifolds set
    inputBinding:
      position: 101
      prefix: --man
  - id: spacing
    type: float
    doc: Particle spacing [A]
    inputBinding:
      position: 101
      prefix: --spacing
  - id: depth
    type: float
    doc: Depth below surface [A]
    inputBinding:
      position: 101
      prefix: --depth
  - id: max_tilt
    type: float
    doc: Maximum tilt angle [degrees]
    inputBinding:
      position: 101
      prefix: --max_tilt
  - id: output
    type: string
    doc: Output directory
    inputBinding:
      position: 101
      prefix: --o
  - id: nmw
    type:
      - 'null'
      - boolean
    doc: Do not sample particles from the missing wedges
    inputBinding:
      position: 101
      prefix: --nmw
  - id: npw
    type:
      - 'null'
      - boolean
    doc: Do not sample particles from the present wedges
    inputBinding:
      position: 101
      prefix: --npw
  - id: ts
    type:
      - 'null'
      - boolean
    doc: Store the name of the tilt series in the star file
    inputBinding:
      position: 101
      prefix: --ts
  - id: theme
    type:
      - 'null'
      - string
    doc: 'Select display theme (RELION default: molten)'
    inputBinding:
      position: 101
      prefix: --theme
  - id: list_themes
    type:
      - 'null'
      - boolean
    doc: List available themes and quit
    inputBinding:
      position: 101
      prefix: --list_themes
  - id: staged_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Extra files that the input STAR file names (images, micrographs, maps, coordinate files). They
      are staged in the working directory so that the relative names in the STAR file resolve.
outputs:
  - id: output_dir
    type: Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output)
  - id: log
    type: stdout
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/relion:5.0.1--h6e3b700_0
stdout: relion_relion_tomo_sample_manifold.out
