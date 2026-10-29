cwlVersion: v1.2
class: CommandLineTool
baseCommand: relion_tomo_add_spheres
label: relion_relion_tomo_add_spheres
doc: "Add spheres (from sphere files) to the manifold set of an optimisation set.\n\nTool homepage: https://github.com/3dem/relion"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.staged_files)
inputs:
  - id: spheres_list
    type: File
    doc: File containing a list of tomogram-name/spheres-file pairs
    inputBinding:
      position: 101
      prefix: --sph
  - id: sphere_binning
    type: float
    doc: Binning factor of the sphere coordinates
    inputBinding:
      position: 101
      prefix: --sbin
  - id: output
    type: string
    doc: Output filename pattern
    inputBinding:
      position: 101
      prefix: --o
  - id: optimisation_set
    type:
      - 'null'
      - File
    doc: Optimisation set
    inputBinding:
      position: 101
      prefix: --i
  - id: diag
    type:
      - 'null'
      - boolean
    doc: Write out diagnostic information
    inputBinding:
      position: 101
      prefix: --diag
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
  - id: output_files
    type:
      type: array
      items: File
    doc: Output files written with the output filename pattern
    outputBinding:
      glob: $(inputs.output)*
  - id: log
    type: stdout
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/relion:5.0.1--h6e3b700_0
stdout: relion_relion_tomo_add_spheres.out
