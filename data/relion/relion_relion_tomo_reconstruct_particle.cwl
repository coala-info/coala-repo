cwlVersion: v1.2
class: CommandLineTool
baseCommand: relion_tomo_reconstruct_particle
label: relion_relion_tomo_reconstruct_particle
doc: "Reconstruct a subtomogram average directly from the tilt-series images (particle reconstruction).\n\
  \nTool homepage: https://github.com/3dem/relion"
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
  - id: particle_set
    type:
      - 'null'
      - File
    doc: Particle set
    inputBinding:
      position: 101
      prefix: --p
  - id: tomogram_set
    type:
      - 'null'
      - File
    doc: Tomogram set
    inputBinding:
      position: 101
      prefix: --t
  - id: trajectories_set
    type:
      - 'null'
      - File
    doc: Particle trajectories set
    inputBinding:
      position: 101
      prefix: --mot
  - id: box_size
    type: int
    doc: Box size
    inputBinding:
      position: 101
      prefix: --b
  - id: output
    type: string
    doc: Output directory
    inputBinding:
      position: 101
      prefix: --o
  - id: crop
    type:
      - 'null'
      - int
    doc: 'Size of (additionally output) cropped image (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --crop
  - id: whiten
    type:
      - 'null'
      - boolean
    doc: Whiten the noise by flattening the power spectrum
    inputBinding:
      position: 101
      prefix: --whiten
  - id: no_ctf
    type:
      - 'null'
      - boolean
    doc: Do not apply CTFs
    inputBinding:
      position: 101
      prefix: --no_ctf
  - id: bin
    type:
      - 'null'
      - float
    doc: 'Binning factor (RELION default: 1)'
    inputBinding:
      position: 101
      prefix: --bin
  - id: taper
    type:
      - 'null'
      - float
    doc: 'Taper against the sphere by this number of pixels (only if cropping) (RELION default: 10)'
    inputBinding:
      position: 101
      prefix: --taper
  - id: SNR
    type:
      - 'null'
      - float
    doc: 'Assumed signal-to-noise ratio (negative means use a heuristic) (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --SNR
  - id: sym
    type:
      - 'null'
      - string
    doc: 'Symmetry group (RELION default: C1)'
    inputBinding:
      position: 101
      prefix: --sym
  - id: nr_helical_asu
    type:
      - 'null'
      - int
    doc: 'Number of helical asymmetrical units (RELION default: 1)'
    inputBinding:
      position: 101
      prefix: --nr_helical_asu
  - id: helical_rise
    type:
      - 'null'
      - float
    doc: 'Helical rise (in Angstroms) (RELION default: 0.)'
    inputBinding:
      position: 101
      prefix: --helical_rise
  - id: helical_twist
    type:
      - 'null'
      - float
    doc: 'Helical twist (in degrees, + for right-handedness) (RELION default: 0.)'
    inputBinding:
      position: 101
      prefix: --helical_twist
  - id: mem
    type:
      - 'null'
      - int
    doc: 'Max. amount of memory (in GB) to use for accumulation (--j_out will be reduced) (RELION default:
      -1)'
    inputBinding:
      position: 101
      prefix: --mem
  - id: only_do_unfinished
    type:
      - 'null'
      - boolean
    doc: Only process undone subtomograms
    inputBinding:
      position: 101
      prefix: --only_do_unfinished
  - id: no_backup
    type:
      - 'null'
      - boolean
    doc: Do not make backups (makes it impossible to use --only_do_unfinished)
    inputBinding:
      position: 101
      prefix: --no_backup
  - id: no_circle_crop
    type:
      - 'null'
      - boolean
    doc: Do not crop 2D images to a circle prior to insertion
    inputBinding:
      position: 101
      prefix: --no_circle_crop
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of OMP threads (RELION default: 6)'
    inputBinding:
      position: 101
      prefix: --j
  - id: j_in
    type:
      - 'null'
      - int
    doc: 'Number of inner threads (slower, needs less memory) (RELION default: 3)'
    inputBinding:
      position: 101
      prefix: --j_in
  - id: j_out
    type:
      - 'null'
      - int
    doc: 'Number of outer threads (faster, needs more memory) (RELION default: 2)'
    inputBinding:
      position: 101
      prefix: --j_out
  - id: no_recon
    type:
      - 'null'
      - boolean
    doc: Do not reconstruct the volume, only backproject (for benchmarking purposes)
    inputBinding:
      position: 101
      prefix: --no_recon
  - id: cutoff_fract
    type:
      - 'null'
      - float
    doc: 'Ignore shells for which the dose weight falls below this value (RELION default: 0.01)'
    inputBinding:
      position: 101
      prefix: --cutoff_fract
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
    doc: Output directory with the average and half maps
    outputBinding:
      glob: $(inputs.output)
  - id: log
    type: stdout
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/relion:5.0.1--h6e3b700_0
stdout: relion_relion_tomo_reconstruct_particle.out
