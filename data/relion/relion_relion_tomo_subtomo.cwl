cwlVersion: v1.2
class: CommandLineTool
baseCommand: relion_tomo_subtomo
label: relion_relion_tomo_subtomo
doc: "Write pseudo-subtomograms (or 2D stacks) of particles for RELION subtomogram averaging.\n\nTool\
  \ homepage: https://github.com/3dem/relion"
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
    doc: Binned projection box size
    inputBinding:
      position: 101
      prefix: --b
  - id: output
    type: string
    doc: Output filename pattern
    inputBinding:
      position: 101
      prefix: --o
  - id: crop
    type:
      - 'null'
      - int
    doc: 'Output box size (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --crop
  - id: bin
    type:
      - 'null'
      - float
    doc: 'Binning factor (RELION default: 1)'
    inputBinding:
      position: 101
      prefix: --bin
  - id: stack2d
    type:
      - 'null'
      - boolean
    doc: Write out 2D stacks of cropped images for each particle, instead of pseudo-subtomograms
    inputBinding:
      position: 101
      prefix: --stack2d
  - id: multi
    type:
      - 'null'
      - boolean
    doc: Write out multiplicity volumes
    inputBinding:
      position: 101
      prefix: --multi
  - id: SNR
    type:
      - 'null'
      - float
    doc: 'Assumed signal-to-noise ratio (negative means use a heuristic) (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --SNR
  - id: min_frames
    type:
      - 'null'
      - int
    doc: 'Minimum number of lowest-dose tilt series frames that needs to be inside the box (RELION default:
      1)'
    inputBinding:
      position: 101
      prefix: --min_frames
  - id: max_dose
    type:
      - 'null'
      - float
    doc: 'Maximum dose (in e/A^2) of tilt series frames to be included (negative means use all frames)
      (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --max_dose
  - id: cone_weight
    type:
      - 'null'
      - boolean
    doc: Weight down a double cone along Z
    inputBinding:
      position: 101
      prefix: --cone_weight
  - id: cone_angle
    type:
      - 'null'
      - float
    doc: 'Opening angle of the cone in degrees (RELION default: 10)'
    inputBinding:
      position: 101
      prefix: --cone_angle
  - id: cone_sig0
    type:
      - 'null'
      - float
    doc: 'Cone width at Z = 0 (RELION default: 2)'
    inputBinding:
      position: 101
      prefix: --cone_sig0
  - id: no_circle_crop
    type:
      - 'null'
      - boolean
    doc: Do not crop 2D images to a circle
    inputBinding:
      position: 101
      prefix: --no_circle_crop
  - id: circle_precrop
    type:
      - 'null'
      - boolean
    doc: Crop 2D images to the large circle (--b) prior to CTF modulation
    inputBinding:
      position: 101
      prefix: --circle_precrop
  - id: grid_precorr
    type:
      - 'null'
      - boolean
    doc: Perform gridding pre-correction on 2D images
    inputBinding:
      position: 101
      prefix: --grid_precorr
  - id: taper
    type:
      - 'null'
      - float
    doc: 'Taper against the sphere by this number of pixels (RELION default: 5)'
    inputBinding:
      position: 101
      prefix: --taper
  - id: env
    type:
      - 'null'
      - float
    doc: 'Sigma of a Gaussian envelope applied before cropping (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --env
  - id: whiten
    type:
      - 'null'
      - boolean
    doc: Whiten the noise by flattening the power spectrum
    inputBinding:
      position: 101
      prefix: --whiten
  - id: no_center
    type:
      - 'null'
      - boolean
    doc: Do not subtract the mean from the voxel values
    inputBinding:
      position: 101
      prefix: --no_center
  - id: no_ic
    type:
      - 'null'
      - boolean
    doc: Do not invert contrast (keep particles dark)
    inputBinding:
      position: 101
      prefix: --no_ic
  - id: no_ctf
    type:
      - 'null'
      - boolean
    doc: Do not apply CTFs
    inputBinding:
      position: 101
      prefix: --no_ctf
  - id: no_comb
    type:
      - 'null'
      - boolean
    doc: Do not write the concatenated CTF-multiplicity image
    inputBinding:
      position: 101
      prefix: --no_comb
  - id: ctf
    type:
      - 'null'
      - boolean
    doc: Write 3D CTFs
    inputBinding:
      position: 101
      prefix: --ctf
  - id: div
    type:
      - 'null'
      - boolean
    doc: Write CTF-corrected subtomograms
    inputBinding:
      position: 101
      prefix: --div
  - id: nrm
    type:
      - 'null'
      - boolean
    doc: Write multiplicity-normalised subtomograms
    inputBinding:
      position: 101
      prefix: --nrm
  - id: dont_apply_offsets
    type:
      - 'null'
      - boolean
    doc: By default, rlnOriginX/Y/ZAngst are combined with rlnCoordinateX/Y/Z to construct the particles
      in their refined translations. Use this argument to skip that.
    inputBinding:
      position: 101
      prefix: --dont_apply_offsets
  - id: apply_orientations
    type:
      - 'null'
      - boolean
    doc: rlnAngle<Rot/Tilt/Psi> are combined with rlnTomoSubtomogram<Rot/Tilt/Psi> to construct the particles
      in their refined orientations. This will also apply translations!
    inputBinding:
      position: 101
      prefix: --apply_orientations
  - id: only_do_unfinished
    type:
      - 'null'
      - boolean
    doc: Only process undone subtomograms
    inputBinding:
      position: 101
      prefix: --only_do_unfinished
  - id: float16
    type:
      - 'null'
      - boolean
    doc: Write in half-precision 16 bit floating point numbers (MRC mode 12), instead of 32 bit (MRC mode
      0).
    inputBinding:
      position: 101
      prefix: --float16
  - id: diag
    type:
      - 'null'
      - boolean
    doc: Write out diagnostic information
    inputBinding:
      position: 101
      prefix: --diag
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of OMP threads (RELION default: 6)'
    inputBinding:
      position: 101
      prefix: --j
  - id: cutoff_fract
    type:
      - 'null'
      - float
    doc: 'Ignore shells for which the dose weight falls below this value (RELION default: 0.01)'
    inputBinding:
      position: 101
      prefix: --cutoff_fract
  - id: real_subtomo
    type:
      - 'null'
      - boolean
    doc: Extract true subtomograms and write out projections of those out as 2D stacks
    inputBinding:
      position: 101
      prefix: --real_subtomo
  - id: sum
    type:
      - 'null'
      - boolean
    doc: Sum up all subtomograms (for debugging)
    inputBinding:
      position: 101
      prefix: --sum
  - id: no_writing
    type:
      - 'null'
      - boolean
    doc: Do not write out any files, only a sum
    inputBinding:
      position: 101
      prefix: --no_writing
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
    doc: Output directory with Subtomograms/, particles.star and optimisation_set.star (give the name
      with a trailing slash)
    outputBinding:
      glob: $(inputs.output)
  - id: log
    type: stdout
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/relion:5.0.1--h6e3b700_0
stdout: relion_relion_tomo_subtomo.out
