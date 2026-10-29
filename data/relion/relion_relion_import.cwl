cwlVersion: v1.2
class: CommandLineTool
baseCommand: relion_import
label: relion_relion_import
doc: "Import movies, micrographs, coordinates, half maps or particle STAR files into a RELION project\
  \ (writes a STAR file).\n\nTool homepage: https://github.com/3dem/relion"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.staged_files)
      - entry: "$({class: 'Directory', basename: inputs.odir, listing: []})"
        writable: true
inputs:
  - id: input
    type: string
    doc: Input (wildcard) filename
    inputBinding:
      position: 101
      prefix: --i
  - id: odir
    type: string
    doc: Output directory name without a trailing slash (e.g. "Import"); it is created in the working directory and a slash is appended for the program
    inputBinding:
      position: 101
      prefix: --odir
      valueFrom: $(self)/
  - id: ofile
    type: string
    doc: Output file name (e.g. "movies.star")
    inputBinding:
      position: 101
      prefix: --ofile
  - id: do_movies
    type:
      - 'null'
      - boolean
    doc: Import movies
    inputBinding:
      position: 101
      prefix: --do_movies
  - id: do_micrographs
    type:
      - 'null'
      - boolean
    doc: Import micrographs
    inputBinding:
      position: 101
      prefix: --do_micrographs
  - id: do_coordinates
    type:
      - 'null'
      - boolean
    doc: Import coordinates
    inputBinding:
      position: 101
      prefix: --do_coordinates
  - id: do_halfmaps
    type:
      - 'null'
      - boolean
    doc: Import unfiltered half maps
    inputBinding:
      position: 101
      prefix: --do_halfmaps
  - id: do_particles
    type:
      - 'null'
      - boolean
    doc: Import particle STAR files
    inputBinding:
      position: 101
      prefix: --do_particles
  - id: particles_optics_group_name
    type:
      - 'null'
      - string
    doc: Rename optics group for all imported particles (e.g. "opticsGroupLMBjan2019"
    inputBinding:
      position: 101
      prefix: --particles_optics_group_name
  - id: do_other
    type:
      - 'null'
      - boolean
    doc: Import anything else
    inputBinding:
      position: 101
      prefix: --do_other
  - id: optics_group_name
    type:
      - 'null'
      - string
    doc: 'Name for this optics group (RELION default: opticsGroup1)'
    inputBinding:
      position: 101
      prefix: --optics_group_name
  - id: optics_group_mtf
    type:
      - 'null'
      - File
    doc: Name for this optics group's MTF
    inputBinding:
      position: 101
      prefix: --optics_group_mtf
  - id: angpix
    type:
      - 'null'
      - float
    doc: 'Pixel size (Angstrom) (RELION default: 1.0)'
    inputBinding:
      position: 101
      prefix: --angpix
  - id: kV
    type:
      - 'null'
      - float
    doc: 'Voltage (kV) (RELION default: 300)'
    inputBinding:
      position: 101
      prefix: --kV
  - id: Cs
    type:
      - 'null'
      - float
    doc: 'Spherical aberration (mm) (RELION default: 2.7)'
    inputBinding:
      position: 101
      prefix: --Cs
  - id: Q0
    type:
      - 'null'
      - float
    doc: 'Amplitude contrast (RELION default: 0.1)'
    inputBinding:
      position: 101
      prefix: --Q0
  - id: beamtilt_x
    type:
      - 'null'
      - float
    doc: 'Beam tilt (X; mrad) (RELION default: 0.0)'
    inputBinding:
      position: 101
      prefix: --beamtilt_x
  - id: beamtilt_y
    type:
      - 'null'
      - float
    doc: 'Beam tilt (Y; mrad) (RELION default: 0.0)'
    inputBinding:
      position: 101
      prefix: --beamtilt_y
  - id: continue
    type:
      - 'null'
      - boolean
    doc: Continue and old run, add more files to the same import directory
    inputBinding:
      position: 101
      prefix: --continue
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
    doc: Output directory with the imported STAR file
    outputBinding:
      glob: $(inputs.odir)
  - id: log
    type: stdout
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/relion:5.0.1--h6e3b700_0
stdout: relion_relion_import.out
