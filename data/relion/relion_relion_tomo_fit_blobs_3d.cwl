cwlVersion: v1.2
class: CommandLineTool
baseCommand: relion_tomo_fit_blobs_3d
label: relion_relion_tomo_fit_blobs_3d
doc: "Fit spherical-harmonics surfaces (membranes) to manifolds in tomograms.\n\nTool homepage: https://github.com/3dem/relion"
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
  - id: output
    type: string
    doc: Output filename pattern
    inputBinding:
      position: 101
      prefix: --o
  - id: radius_range
    type:
      - 'null'
      - float
    doc: 'Sphere radius range as a multiple of radius (RELION default: 1)'
    inputBinding:
      position: 101
      prefix: --rr
  - id: membrane_separation
    type:
      - 'null'
      - float
    doc: 'Membrane separation [Å] (RELION default: 40)'
    inputBinding:
      position: 101
      prefix: --ms
  - id: fiducial_radius
    type:
      - 'null'
      - float
    doc: 'Fiducial marker radius [Å] (RELION default: 100)'
    inputBinding:
      position: 101
      prefix: --frad
  - id: bin
    type:
      - 'null'
      - float
    doc: 'Binning at which to perform the fit (RELION default: 2)'
    inputBinding:
      position: 101
      prefix: --bin
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
    doc: 'Number of spherical harmonics bands (RELION default: 5)'
    inputBinding:
      position: 101
      prefix: --n
  - id: lowpass_sigma
    type:
      - 'null'
      - float
    doc: 'Low-pass sigma [Å, real space] (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --lp
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
stdout: relion_relion_tomo_fit_blobs_3d.out
