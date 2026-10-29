cwlVersion: v1.2
class: CommandLineTool
baseCommand: relion_movie_reconstruct
label: relion_relion_movie_reconstruct
doc: "Reconstruct a 3D map from a single movie frame of all particles.\n\nTool homepage: https://github.com/3dem/relion"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.staged_files)
inputs:
  - id: input
    type:
      - 'null'
      - File
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
  - id: corr_mic
    type:
      - 'null'
      - File
    doc: Motion correction STAR file
    inputBinding:
      position: 101
      prefix: --corr_mic
  - id: traj_path
    type:
      - 'null'
      - string
    doc: Trajectory path prefix
    inputBinding:
      position: 101
      prefix: --traj_path
  - id: movie_angpix
    type:
      - 'null'
      - float
    doc: 'Pixel size in the movie (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --movie_angpix
  - id: coord_angpix
    type:
      - 'null'
      - float
    doc: 'Pixel size of particle coordinates (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --coord_angpix
  - id: frame
    type:
      - 'null'
      - int
    doc: 'Movie frame to reconstruct (1-indexed) (RELION default: 1)'
    inputBinding:
      position: 101
      prefix: --frame
  - id: eer_grouping
    type:
      - 'null'
      - int
    doc: 'Override EER grouping (--frame is in this new grouping) (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --eer_grouping
  - id: window
    type:
      - 'null'
      - int
    doc: 'Box size to extract from raw movies (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --window
  - id: scale
    type:
      - 'null'
      - int
    doc: 'Box size after down-sampling (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --scale
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of threads (1 or 2) (RELION default: 2)'
    inputBinding:
      position: 101
      prefix: --j
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
      - float
    doc: 'Number of gridding-correction iterations (RELION default: 10)'
    inputBinding:
      position: 101
      prefix: --iter
  - id: skip_gridding
    type:
      - 'null'
      - boolean
    doc: Skip gridding part of the reconstruction
    inputBinding:
      position: 101
      prefix: --skip_gridding
  - id: no_barcode
    type:
      - 'null'
      - boolean
    doc: Don't apply barcode-like extension when extracting outside a micrograph
    inputBinding:
      position: 101
      prefix: --no_barcode
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
stdout: relion_relion_movie_reconstruct.out
