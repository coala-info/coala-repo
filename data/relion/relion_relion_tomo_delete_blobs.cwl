cwlVersion: v1.2
class: CommandLineTool
baseCommand: relion_tomo_delete_blobs
label: relion_relion_tomo_delete_blobs
doc: "Delete blob-like objects (spheres) from tomograms listed in a tomogram/sphere-file list.\n\nTool\
  \ homepage: https://github.com/3dem/relion"
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
      prefix: --i
  - id: thickness
    type: float
    doc: Sphere thickness (same units as sphere centres)
    inputBinding:
      position: 101
      prefix: --th
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
  - id: tomogram_set
    type:
      - 'null'
      - File
    doc: 'Tomogram set filename (RELION default: tomograms.star)'
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
  - id: position_sigma
    type:
      - 'null'
      - float
    doc: 'Uncertainty std. dev. of initial position [Å] (RELION default: 10)'
    inputBinding:
      position: 101
      prefix: --sig
  - id: bin_start
    type:
      - 'null'
      - int
    doc: 'Initial (maximal) binning factor (RELION default: 8)'
    inputBinding:
      position: 101
      prefix: --bin0
  - id: bin_end
    type:
      - 'null'
      - int
    doc: 'Final (minimal) binning factor (RELION default: 2)'
    inputBinding:
      position: 101
      prefix: --bin1
  - id: diag
    type:
      - 'null'
      - boolean
    doc: Write out diagnostic information
    inputBinding:
      position: 101
      prefix: --diag
  - id: bands
    type:
      - 'null'
      - int
    doc: 'Number of spherical harmonics bands (RELION default: 2)'
    inputBinding:
      position: 101
      prefix: --n
  - id: highpass_sigma
    type:
      - 'null'
      - float
    doc: 'High-pass sigma [Å, real space] (RELION default: 300)'
    inputBinding:
      position: 101
      prefix: --hp
  - id: max_iters
    type:
      - 'null'
      - int
    doc: 'Maximum number of iterations (RELION default: 1000)'
    inputBinding:
      position: 101
      prefix: --max_iters
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of OMP threads (RELION default: 6)'
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
stdout: relion_relion_tomo_delete_blobs.out
