cwlVersion: v1.2
class: CommandLineTool
baseCommand: relion_tomo_template_pick
label: relion_relion_tomo_template_pick
doc: "Pick particles in tomograms by template matching.\n\nTool homepage: https://github.com/3dem/relion"
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
  - id: template
    type: File
    doc: Template file name
    inputBinding:
      position: 101
      prefix: --template
  - id: output
    type: string
    doc: Output directory
    inputBinding:
      position: 101
      prefix: --o
  - id: tomogram_set
    type:
      - 'null'
      - File
    doc: Tomogram set
    inputBinding:
      position: 101
      prefix: --t
  - id: fiducial_radius
    type:
      - 'null'
      - float
    doc: 'Fiducial marker radius [Å] (RELION default: 100)'
    inputBinding:
      position: 101
      prefix: --frad
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of OMP threads (RELION default: 8)'
    inputBinding:
      position: 101
      prefix: --j
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
stdout: relion_relion_tomo_template_pick.out
