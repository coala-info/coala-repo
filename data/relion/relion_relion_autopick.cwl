cwlVersion: v1.2
class: CommandLineTool
baseCommand: relion_autopick
label: relion_relion_autopick
doc: "Pick particles from micrographs by template matching, Laplacian-of-Gaussian blob detection or Topaz.\n\
  \nTool homepage: https://github.com/3dem/relion"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.staged_files)
inputs:
  - id: input
    type: File
    doc: Micrograph STAR file OR filenames from which to autopick particles, e.g. "Micrographs/*.mrc"
    inputBinding:
      position: 101
      prefix: --i
  - id: pickname
    type:
      - 'null'
      - string
    doc: 'Rootname for coordinate STAR files (RELION default: autopick)'
    inputBinding:
      position: 101
      prefix: --pickname
  - id: odir
    type:
      - 'null'
      - string
    doc: 'Output directory for coordinate files (default is to store next to micrographs) (RELION default:
      AutoPick/)'
    inputBinding:
      position: 101
      prefix: --odir
    default: AutoPick/
  - id: angpix
    type:
      - 'null'
      - float
    doc: 'Pixel size of the micrographs in Angstroms (RELION default: 1)'
    inputBinding:
      position: 101
      prefix: --angpix
  - id: particle_diameter
    type:
      - 'null'
      - float
    doc: 'Diameter of the circular mask that will be applied to the experimental images (in Angstroms,
      default=automatic) (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --particle_diameter
  - id: shrink_particle_mask
    type:
      - 'null'
      - int
    doc: 'Shrink the particle mask by this many pixels (to detect Einstein-from-noise classes) (RELION
      default: 2)'
    inputBinding:
      position: 101
      prefix: --shrink_particle_mask
  - id: outlier_removal_zscore
    type:
      - 'null'
      - float
    doc: 'Remove pixels that are this many sigma away from the mean (RELION default: 8.)'
    inputBinding:
      position: 101
      prefix: --outlier_removal_zscore
  - id: write_fom_maps
    type:
      - 'null'
      - boolean
    doc: Write calculated probability-ratio maps to disc (for re-reading in subsequent runs)
    inputBinding:
      position: 101
      prefix: --write_fom_maps
  - id: no_fom_limit
    type:
      - 'null'
      - boolean
    doc: Ignore default maximum limit of 30 fom maps being written
    inputBinding:
      position: 101
      prefix: --no_fom_limit
  - id: read_fom_maps
    type:
      - 'null'
      - boolean
    doc: Skip probability calculations, re-read precalculated maps from disc
    inputBinding:
      position: 101
      prefix: --read_fom_maps
  - id: skip_optimise_scale
    type:
      - 'null'
      - boolean
    doc: Skip the optimisation of the micrograph scale for better prime factors in the FFTs. This runs
      slower, but at exactly the requested resolution.
    inputBinding:
      position: 101
      prefix: --skip_optimise_scale
  - id: only_do_unfinished
    type:
      - 'null'
      - boolean
    doc: Only autopick those micrographs for which the coordinate file does not yet exist
    inputBinding:
      position: 101
      prefix: --only_do_unfinished
  - id: gpu
    type:
      - 'null'
      - boolean
    doc: Use GPU acceleration when availiable
    inputBinding:
      position: 101
      prefix: --gpu
  - id: ref
    type:
      - 'null'
      - File
    doc: STAR file with the reference names, or an MRC stack with all references, or "gauss" for blob-picking
    inputBinding:
      position: 101
      prefix: --ref
  - id: angpix_ref
    type:
      - 'null'
      - float
    doc: 'Pixel size of the references in Angstroms (default is same as micrographs) (RELION default:
      -1)'
    inputBinding:
      position: 101
      prefix: --angpix_ref
  - id: invert
    type:
      - 'null'
      - boolean
    doc: Density in micrograph is inverted w.r.t. density in template
    inputBinding:
      position: 101
      prefix: --invert
  - id: ang
    type:
      - 'null'
      - float
    doc: 'Angular sampling (in degrees); use 360 for no rotations (RELION default: 10)'
    inputBinding:
      position: 101
      prefix: --ang
  - id: lowpass
    type:
      - 'null'
      - float
    doc: 'Lowpass filter in Angstroms for the references (prevent Einstein-from-noise!) (RELION default:
      -1)'
    inputBinding:
      position: 101
      prefix: --lowpass
  - id: highpass
    type:
      - 'null'
      - float
    doc: 'Highpass filter in Angstroms for the micrographs (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --highpass
  - id: ctf
    type:
      - 'null'
      - boolean
    doc: Perform CTF correction on the references?
    inputBinding:
      position: 101
      prefix: --ctf
  - id: ctf_intact_first_peak
    type:
      - 'null'
      - boolean
    doc: Ignore CTFs until their first peak?
    inputBinding:
      position: 101
      prefix: --ctf_intact_first_peak
  - id: gauss_max
    type:
      - 'null'
      - float
    doc: 'Value of the peak in the Gaussian blob reference (RELION default: 0.1)'
    inputBinding:
      position: 101
      prefix: --gauss_max
  - id: healpix_order
    type:
      - 'null'
      - int
    doc: 'Healpix order for projecting a 3D reference (hp0=60deg; hp1=30deg; hp2=15deg) (RELION default:
      1)'
    inputBinding:
      position: 101
      prefix: --healpix_order
  - id: sym
    type:
      - 'null'
      - string
    doc: 'Symmetry point group for a 3D reference (RELION default: C1)'
    inputBinding:
      position: 101
      prefix: --sym
  - id: LoG
    type:
      - 'null'
      - boolean
    doc: Use Laplacian-of-Gaussian filter-based picking, instead of template matching
    inputBinding:
      position: 101
      prefix: --LoG
  - id: LoG_diam_min
    type:
      - 'null'
      - float
    doc: 'Smallest particle diameter (in Angstroms) for blob-detection by Laplacian-of-Gaussian filter
      (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --LoG_diam_min
  - id: LoG_diam_max
    type:
      - 'null'
      - float
    doc: 'Largest particle diameter (in Angstroms) for blob-detection by Laplacian-of-Gaussian filter
      (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --LoG_diam_max
  - id: LoG_neighbour
    type:
      - 'null'
      - float
    doc: 'Avoid neighbouring particles within (the detected diameter + the minimum diameter) times this
      percent (RELION default: 100)'
    inputBinding:
      position: 101
      prefix: --LoG_neighbour
  - id: Log_invert
    type:
      - 'null'
      - boolean
    doc: Use this option if the particles are white instead of black
    inputBinding:
      position: 101
      prefix: --Log_invert
  - id: LoG_adjust_threshold
    type:
      - 'null'
      - float
    doc: 'Use this option to adjust the picking threshold: positive for less particles, negative for more
      (RELION default: 0.)'
    inputBinding:
      position: 101
      prefix: --LoG_adjust_threshold
  - id: LoG_upper_threshold
    type:
      - 'null'
      - float
    doc: 'Use this option to set the upper limit of the picking threshold (RELION default: 99999)'
    inputBinding:
      position: 101
      prefix: --LoG_upper_threshold
  - id: LoG_use_ctf
    type:
      - 'null'
      - boolean
    doc: Use CTF until the first peak in Laplacian-of-Gaussian picker
    inputBinding:
      position: 101
      prefix: --LoG_use_ctf
  - id: topaz_train
    type:
      - 'null'
      - boolean
    doc: Use wrapper to the topaz train command
    inputBinding:
      position: 101
      prefix: --topaz_train
  - id: topaz_extract
    type:
      - 'null'
      - boolean
    doc: Use wrapper to the topaz extract command (i.e. predict particle positions)
    inputBinding:
      position: 101
      prefix: --topaz_extract
  - id: topaz_nr_particles
    type:
      - 'null'
      - int
    doc: 'Expected number of particles per micrograph for topaz (RELION default: 200)'
    inputBinding:
      position: 101
      prefix: --topaz_nr_particles
  - id: topaz_threshold
    type:
      - 'null'
      - float
    doc: 'Minimum threshold for topaz picking (RELION default: -6)'
    inputBinding:
      position: 101
      prefix: --topaz_threshold
  - id: topaz_train_picks
    type:
      - 'null'
      - File
    doc: Name of picking coordinates for topaz training
    inputBinding:
      position: 101
      prefix: --topaz_train_picks
  - id: topaz_train_parts
    type:
      - 'null'
      - File
    doc: 'OR: name of particle star file for topaz training'
    inputBinding:
      position: 101
      prefix: --topaz_train_parts
  - id: topaz_test_ratio
    type:
      - 'null'
      - float
    doc: 'Ratio of picks in the test set for cross-validation in topaz training (RELION default: 0.2)'
    inputBinding:
      position: 101
      prefix: --topaz_test_ratio
  - id: topaz_downscale
    type:
      - 'null'
      - float
    doc: 'Downscale factor for topaz (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --topaz_downscale
  - id: topaz_model
    type:
      - 'null'
      - File
    doc: Saved model model from topaz train for topaz extract. Leave this empty to use the default (general)
      model.
    inputBinding:
      position: 101
      prefix: --topaz_model
  - id: topaz_radius
    type:
      - 'null'
      - int
    doc: 'Particle radius (in pix) for topaz extract (default is from particle diameter) (RELION default:
      -1)'
    inputBinding:
      position: 101
      prefix: --topaz_radius
  - id: topaz_args
    type:
      - 'null'
      - string
    doc: Additional arguments to be passed to topaz
    inputBinding:
      position: 101
      prefix: --topaz_args
  - id: topaz_workers
    type:
      - 'null'
      - int
    doc: 'Number of topaz workers for parallelized training (RELION default: 1)'
    inputBinding:
      position: 101
      prefix: --topaz_workers
  - id: topaz_plot
    type:
      - 'null'
      - boolean
    doc: Plot intermediate information for helical picking in topaz (developmental)
    inputBinding:
      position: 101
      prefix: --topaz_plot
  - id: fn_topaz_exe
    type:
      - 'null'
      - string
    doc: 'Topaz executable (default is using relion_python_topaz from conda install) (RELION default:
      relion_python_topaz)'
    inputBinding:
      position: 101
      prefix: --fn_topaz_exe
  - id: helix
    type:
      - 'null'
      - boolean
    doc: Are the references 2D helical segments? If so, in-plane rotation angles (psi) are estimated for
      the references.
    inputBinding:
      position: 101
      prefix: --helix
  - id: helical_tube_kappa_max
    type:
      - 'null'
      - float
    doc: 'Factor of maximum curvature relative to that of a circle (RELION default: 0.25)'
    inputBinding:
      position: 101
      prefix: --helical_tube_kappa_max
  - id: helical_tube_outer_diameter
    type:
      - 'null'
      - float
    doc: 'Tube diameter in Angstroms (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --helical_tube_outer_diameter
  - id: helical_tube_length_min
    type:
      - 'null'
      - float
    doc: 'Minimum tube length in Angstroms (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --helical_tube_length_min
  - id: amyloid
    type:
      - 'null'
      - boolean
    doc: Activate specific algorithm for amyloid picking?
    inputBinding:
      position: 101
      prefix: --amyloid
  - id: max_diam_local_avg
    type:
      - 'null'
      - float
    doc: 'Maximum diameter to calculate local average density in Angstroms (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --max_diam_local_avg
  - id: threshold
    type:
      - 'null'
      - float
    doc: 'Fraction of expected probability ratio in order to consider peaks? (RELION default: 0.25)'
    inputBinding:
      position: 101
      prefix: --threshold
  - id: min_distance
    type:
      - 'null'
      - float
    doc: 'Minimum distance (in A) between any two particles (default is half the box size) (RELION default:
      -1)'
    inputBinding:
      position: 101
      prefix: --min_distance
  - id: max_stddev_noise
    type:
      - 'null'
      - float
    doc: 'Maximum standard deviation in the noise area to use for picking peaks (default is no maximum)
      (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --max_stddev_noise
  - id: min_avg_noise
    type:
      - 'null'
      - float
    doc: 'Minimum average in the noise area to use for picking peaks (default is no minimum) (RELION default:
      -999.)'
    inputBinding:
      position: 101
      prefix: --min_avg_noise
  - id: skip_side
    type:
      - 'null'
      - int
    doc: 'Keep this many extra pixels (apart from particle_size/2) away from the edge of the micrograph
      (RELION default: 0)'
    inputBinding:
      position: 101
      prefix: --skip_side
  - id: verb
    type:
      - 'null'
      - int
    doc: 'Verbosity (RELION default: 1)'
    inputBinding:
      position: 101
      prefix: --verb
  - id: pad
    type:
      - 'null'
      - float
    doc: 'Padding factor for Fourier transforms (RELION default: 2)'
    inputBinding:
      position: 101
      prefix: --pad
  - id: random_seed
    type:
      - 'null'
      - int
    doc: 'Number for the random seed generator (RELION default: 1)'
    inputBinding:
      position: 101
      prefix: --random_seed
  - id: shrink
    type:
      - 'null'
      - float
    doc: 'Reduce micrograph to this fraction size, during correlation calc (saves memory and time) (RELION
      default: 1.0)'
    inputBinding:
      position: 101
      prefix: --shrink
  - id: Log_max_search
    type:
      - 'null'
      - float
    doc: 'Maximum diameter in LoG-picking multi-scale approach is this many times the min/max diameter
      (RELION default: 5.)'
    inputBinding:
      position: 101
      prefix: --Log_max_search
  - id: extra_pad
    type:
      - 'null'
      - int
    doc: 'Number of pixels for additional padding of the original micrograph (RELION default: 0)'
    inputBinding:
      position: 101
      prefix: --extra_pad
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
    doc: Directory with the coordinate STAR files
    outputBinding:
      glob: $(inputs.odir)
  - id: log
    type: stdout
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/relion:5.0.1--h6e3b700_0
stdout: relion_relion_autopick.out
