cwlVersion: v1.2
class: CommandLineTool
baseCommand: relion_reconstruct
label: relion_relion_reconstruct
doc: "Reconstruct a 3D map (or 2D average) from particle images with known orientations, by Fourier-space\
  \ back-projection.\n\nTool homepage: https://github.com/3dem/relion"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.staged_files)
inputs:
  - id: input
    type: File
    doc: Input STAR file with the projection images and their orientations
    inputBinding:
      position: 101
      prefix: --i
  - id: output
    type:
      - 'null'
      - string
    doc: 'Name for output reconstruction (RELION default: relion.mrc)'
    inputBinding:
      position: 101
      prefix: --o
    default: relion.mrc
  - id: symmetry
    type:
      - 'null'
      - string
    doc: 'Symmetry group (RELION default: c1)'
    inputBinding:
      position: 101
      prefix: --sym
  - id: maxres
    type:
      - 'null'
      - float
    doc: 'Maximum resolution (in Angstrom) to consider in Fourier space (default Nyquist) (RELION default:
      -1)'
    inputBinding:
      position: 101
      prefix: --maxres
  - id: pad
    type:
      - 'null'
      - float
    doc: 'Padding factor (RELION default: 2)'
    inputBinding:
      position: 101
      prefix: --pad
  - id: image_prefix
    type:
      - 'null'
      - string
    doc: 'Optional: image path prefix'
    inputBinding:
      position: 101
      prefix: --img
  - id: subset
    type:
      - 'null'
      - int
    doc: 'Subset of images to consider (1: only reconstruct half1; 2: only half2; other: reconstruct all)
      (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --subset
  - id: class_number
    type:
      - 'null'
      - int
    doc: 'Consider only this class (-1: use all classes) (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --class
  - id: angpix
    type:
      - 'null'
      - float
    doc: 'Pixel size in the reconstruction (take from first optics group by default) (RELION default:
      -1)'
    inputBinding:
      position: 101
      prefix: --angpix
  - id: ctf
    type:
      - 'null'
      - boolean
    doc: Apply CTF correction
    inputBinding:
      position: 101
      prefix: --ctf
  - id: ctf_intact_first_peak
    type:
      - 'null'
      - boolean
    doc: Leave CTFs intact until first peak
    inputBinding:
      position: 101
      prefix: --ctf_intact_first_peak
  - id: ctf_phase_flipped
    type:
      - 'null'
      - boolean
    doc: Images have been phase flipped
    inputBinding:
      position: 101
      prefix: --ctf_phase_flipped
  - id: only_flip_phases
    type:
      - 'null'
      - boolean
    doc: Do not correct CTF-amplitudes, only flip phases
    inputBinding:
      position: 101
      prefix: --only_flip_phases
  - id: ewald
    type:
      - 'null'
      - boolean
    doc: Correct for Ewald-sphere curvature (developmental)
    inputBinding:
      position: 101
      prefix: --ewald
  - id: mask_diameter
    type:
      - 'null'
      - float
    doc: 'Diameter (in A) of mask for Ewald-sphere curvature correction (RELION default: -1.)'
    inputBinding:
      position: 101
      prefix: --mask_diameter
  - id: width_mask_edge
    type:
      - 'null'
      - int
    doc: 'Width (in pixels) of the soft edge on the mask (RELION default: 3)'
    inputBinding:
      position: 101
      prefix: --width_mask_edge
  - id: reverse_curvature
    type:
      - 'null'
      - boolean
    doc: Try curvature the other way around
    inputBinding:
      position: 101
      prefix: --reverse_curvature
  - id: newbox
    type:
      - 'null'
      - int
    doc: 'Box size of reconstruction after Ewald sphere correction (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --newbox
  - id: sectors
    type:
      - 'null'
      - int
    doc: 'Number of sectors for Ewald sphere correction (RELION default: 2)'
    inputBinding:
      position: 101
      prefix: --sectors
  - id: skip_mask
    type:
      - 'null'
      - boolean
    doc: Do not apply real space mask during Ewald sphere correction
    inputBinding:
      position: 101
      prefix: --skip_mask
  - id: skip_weighting
    type:
      - 'null'
      - boolean
    doc: Do not apply weighting during Ewald sphere correction
    inputBinding:
      position: 101
      prefix: --skip_weighting
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
  - id: normalised_subtomo
    type:
      - 'null'
      - boolean
    doc: Have subtomograms been multiplicity normalised? (Default=False)
    inputBinding:
      position: 101
      prefix: --normalised_subtomo
  - id: skip_subtomo_multi
    type:
      - 'null'
      - boolean
    doc: Skip subtomo multiplicity correction? (For nomalised subtomos only)
    inputBinding:
      position: 101
      prefix: --skip_subtomo_multi
  - id: ctf3d_not_squared
    type:
      - 'null'
      - boolean
    doc: CTF3D files contain sqrt(CTF^2) patterns
    inputBinding:
      position: 101
      prefix: --ctf3d_not_squared
  - id: subtract_map
    type:
      - 'null'
      - File
    doc: Subtract projections of this map from the images used for reconstruction
    inputBinding:
      position: 101
      prefix: --subtract
  - id: NN
    type:
      - 'null'
      - boolean
    doc: Use nearest-neighbour instead of linear interpolation before gridding correction
    inputBinding:
      position: 101
      prefix: --NN
  - id: blob_r
    type:
      - 'null'
      - float
    doc: 'Radius of blob for gridding interpolation (RELION default: 1.9)'
    inputBinding:
      position: 101
      prefix: --blob_r
  - id: blob_m
    type:
      - 'null'
      - int
    doc: 'Order of blob for gridding interpolation (RELION default: 0)'
    inputBinding:
      position: 101
      prefix: --blob_m
  - id: blob_a
    type:
      - 'null'
      - float
    doc: 'Alpha-value of blob for gridding interpolation (RELION default: 15)'
    inputBinding:
      position: 101
      prefix: --blob_a
  - id: iter
    type:
      - 'null'
      - int
    doc: 'Number of gridding-correction iterations (RELION default: 10)'
    inputBinding:
      position: 101
      prefix: --iter
  - id: refdim
    type:
      - 'null'
      - int
    doc: 'Dimension of the reconstruction (2D or 3D) (RELION default: 3)'
    inputBinding:
      position: 101
      prefix: --refdim
  - id: angular_error
    type:
      - 'null'
      - float
    doc: 'Apply random deviations with this standard deviation (in degrees) to each of the 3 Euler angles
      (RELION default: 0.)'
    inputBinding:
      position: 101
      prefix: --angular_error
  - id: shift_error
    type:
      - 'null'
      - float
    doc: 'Apply random deviations with this standard deviation (in Angstrom) to each of the 2 translations
      (RELION default: 0.)'
    inputBinding:
      position: 101
      prefix: --shift_error
  - id: fom_weighting
    type:
      - 'null'
      - boolean
    doc: Weight particles according to their figure-of-merit (_rlnParticleFigureOfMerit)
    inputBinding:
      position: 101
      prefix: --fom_weighting
  - id: fsc_star
    type:
      - 'null'
      - File
    doc: FSC-curve for regularized reconstruction
    inputBinding:
      position: 101
      prefix: --fsc
  - id: rot3d
    type:
      - 'null'
      - boolean
    doc: Perform 3D rotations instead of backprojections from 2D images
    inputBinding:
      position: 101
      prefix: --3d_rot
  - id: reconstruct_ctf
    type:
      - 'null'
      - int
    doc: 'Perform a 3D reconstruction from 2D CTF-images, with the given size in pixels (RELION default:
      -1)'
    inputBinding:
      position: 101
      prefix: --reconstruct_ctf
  - id: ctf2
    type:
      - 'null'
      - boolean
    doc: Reconstruct CTF^2 and then take the sqrt of that
    inputBinding:
      position: 101
      prefix: --ctf2
  - id: dont_skip_gridding
    type:
      - 'null'
      - boolean
    doc: Perform gridding in the reconstruction (obsolete?)
    inputBinding:
      position: 101
      prefix: --dont_skip_gridding
  - id: debug
    type:
      - 'null'
      - string
    doc: Rootname for debug reconstruction files
    inputBinding:
      position: 101
      prefix: --debug
  - id: debug_ori_size
    type:
      - 'null'
      - int
    doc: 'Rootname for debug reconstruction files (RELION default: 1)'
    inputBinding:
      position: 101
      prefix: --debug_ori_size
  - id: debug_size
    type:
      - 'null'
      - int
    doc: 'Rootname for debug reconstruction files (RELION default: 1)'
    inputBinding:
      position: 101
      prefix: --debug_size
  - id: noise_model_star
    type:
      - 'null'
      - File
    doc: Reconstruct noise using sigma2 values in this model STAR file
    inputBinding:
      position: 101
      prefix: --reconstruct_noise
  - id: read_weights
    type:
      - 'null'
      - boolean
    doc: 'Developmental: read freq. weight files'
    inputBinding:
      position: 101
      prefix: --read_weights
  - id: write_debug_output
    type:
      - 'null'
      - boolean
    doc: Write out arrays with data and weight terms prior to reconstruct
    inputBinding:
      position: 101
      prefix: --write_debug_output
  - id: external_reconstruct
    type:
      - 'null'
      - boolean
    doc: Write out BP denominator and numerator for external_reconstruct program
    inputBinding:
      position: 101
      prefix: --external_reconstruct
  - id: verb
    type:
      - 'null'
      - int
    doc: 'Verbosity (RELION default: 1)'
    inputBinding:
      position: 101
      prefix: --verb
  - id: staged_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Extra files that the input STAR file names (images, micrographs, maps, coordinate files). They
      are staged in the working directory so that the relative names in the STAR file resolve.
outputs:
  - id: reconstruction
    type: File
    doc: Reconstructed map
    outputBinding:
      glob: $(inputs.output)
  - id: log
    type: stdout
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/relion:5.0.1--h6e3b700_0
stdout: relion_relion_reconstruct.out
