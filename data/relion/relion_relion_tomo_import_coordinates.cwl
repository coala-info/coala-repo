cwlVersion: v1.2
class: CommandLineTool
baseCommand: relion_tomo_import_coordinates
label: relion_relion_tomo_import_coordinates
doc: "Import particle coordinates (STAR or ASCII) in tomogram coordinates and write a particles STAR file.\n\
  \nTool homepage: https://github.com/3dem/relion"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.staged_files)
inputs:
  - id: input
    type: string
    doc: Linux wildcard for set of coordinate files (in STAR or 3/6-column ASCII), or a STAR file with
      a list of coordinate files and their tomogram name
    inputBinding:
      position: 101
      prefix: --i
  - id: output
    type: string
    doc: Name of the output directory
    inputBinding:
      position: 101
      prefix: --o
    default: ImportedCoordinates
  - id: remove_substring
    type:
      - 'null'
      - string
    doc: Remove this substring from the coordinate filenames to get the tomogram names
    inputBinding:
      position: 101
      prefix: --remove_substring
  - id: remove_substring2
    type:
      - 'null'
      - string
    doc: Remove also this substring from the coordinate filenames to get the tomogram names
    inputBinding:
      position: 101
      prefix: --remove_substring2
  - id: centered
    type:
      - 'null'
      - boolean
    doc: Are the coordinates relative to the center of the tomogram?
    inputBinding:
      position: 101
      prefix: --centered
  - id: scale_factor
    type:
      - 'null'
      - float
    doc: 'Multiply coordinates with this factor (RELION default: 1.0)'
    inputBinding:
      position: 101
      prefix: --scale_factor
  - id: add_factor
    type:
      - 'null'
      - float
    doc: 'Add this value to final coordinates (RELION default: 0.0)'
    inputBinding:
      position: 101
      prefix: --add_factor
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
    doc: Output directory with particles.star
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/relion:5.0.1--h6e3b700_0
