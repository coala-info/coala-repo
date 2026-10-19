cwlVersion: v1.2
class: CommandLineTool
baseCommand: mpirun
label: relion-bin-plusmpi_relion_refine_mpi
doc: "RELION MPI refinement (2D/3D classification and refinement)\n\nTool homepage: https://github.com/3dem/relion"
arguments:
  - position: 1
    prefix: -np
    valueFrom: $(inputs.num_mpi_processes)
  - position: 2
    valueFrom: relion_refine_mpi
inputs:
  - id: num_mpi_processes
    type: int
    default: 3
    doc: "Number of MPI processes started with mpirun (relion_refine_mpi needs at least 2: one master and one worker)"
  - id: input_particles
    type: File
    doc: "Input images (in a star-file or a stack)"
    inputBinding:
      position: 101
      prefix: --i
  - id: output_rootname
    type: string
    doc: "Output rootname"
    inputBinding:
      position: 101
      prefix: --o
  - id: angpix
    type:
      - 'null'
      - float
    doc: "Pixel size (in Angstroms)"
    inputBinding:
      position: 101
      prefix: --angpix
  - id: iter
    type:
      - 'null'
      - int
    doc: "Maximum number of iterations to perform"
    inputBinding:
      position: 101
      prefix: --iter
  - id: tau2_fudge
    type:
      - 'null'
      - float
    doc: "Regularisation parameter (values higher than 1 give more weight to the data)"
    inputBinding:
      position: 101
      prefix: --tau2_fudge
  - id: K
    type:
      - 'null'
      - int
    doc: "Number of references to be refined"
    inputBinding:
      position: 101
      prefix: --K
  - id: particle_diameter
    type:
      - 'null'
      - float
    doc: "Diameter of the circular mask that will be applied to the experimental images (in Angstroms)"
    inputBinding:
      position: 101
      prefix: --particle_diameter
  - id: zero_mask
    type:
      - 'null'
      - boolean
    doc: "Mask surrounding background in particles to zero (by default the solvent area is filled with random noise)"
    inputBinding:
      position: 101
      prefix: --zero_mask
  - id: flatten_solvent
    type:
      - 'null'
      - boolean
    doc: "Perform masking on the references as well?"
    inputBinding:
      position: 101
      prefix: --flatten_solvent
  - id: solvent_mask
    type:
      - 'null'
      - File
    doc: "User-provided mask for the references (default is to use spherical mask with particle_diameter)"
    inputBinding:
      position: 101
      prefix: --solvent_mask
  - id: solvent_mask2
    type:
      - 'null'
      - File
    doc: "User-provided secondary mask (with its own average density)"
    inputBinding:
      position: 101
      prefix: --solvent_mask2
  - id: tau
    type:
      - 'null'
      - File
    doc: "STAR file with input tau2-spectrum (to be kept constant)"
    inputBinding:
      position: 101
      prefix: --tau
  - id: split_random_halves
    type:
      - 'null'
      - boolean
    doc: "Refine two random halves of the data completely separately"
    inputBinding:
      position: 101
      prefix: --split_random_halves
  - id: low_resol_join_halves
    type:
      - 'null'
      - float
    doc: "Resolution (in Angstrom) up to which the two random half-reconstructions will not be independent to prevent diverging orientations"
    inputBinding:
      position: 101
      prefix: --low_resol_join_halves
  - id: ref
    type:
      - 'null'
      - File
    doc: "Image, stack or star-file with the reference(s). (Compulsory for 3D refinement!)"
    inputBinding:
      position: 101
      prefix: --ref
  - id: offset
    type:
      - 'null'
      - float
    doc: "Initial estimated stddev for the origin offsets"
    inputBinding:
      position: 101
      prefix: --offset
  - id: firstiter_cc
    type:
      - 'null'
      - boolean
    doc: "Perform CC-calculation in the first iteration (use this if references are not on the absolute intensity scale)"
    inputBinding:
      position: 101
      prefix: --firstiter_cc
  - id: ini_high
    type:
      - 'null'
      - float
    doc: "Resolution (in Angstroms) to which to limit refinement in the first iteration"
    inputBinding:
      position: 101
      prefix: --ini_high
  - id: oversampling
    type:
      - 'null'
      - int
    doc: "Adaptive oversampling order to speed-up calculations (0=no oversampling, 1=2x, 2=4x, etc)"
    inputBinding:
      position: 101
      prefix: --oversampling
  - id: healpix_order
    type:
      - 'null'
      - int
    doc: "Healpix order for the angular sampling (before oversampling) on the (3D) sphere: hp2=15deg, hp3=7.5deg, etc"
    inputBinding:
      position: 101
      prefix: --healpix_order
  - id: psi_step
    type:
      - 'null'
      - float
    doc: "Sampling rate (before oversampling) for the in-plane angle (default=10deg for 2D, hp sampling for 3D)"
    inputBinding:
      position: 101
      prefix: --psi_step
  - id: limit_tilt
    type:
      - 'null'
      - float
    doc: "Limited tilt angle: positive for keeping side views, negative for keeping top views"
    inputBinding:
      position: 101
      prefix: --limit_tilt
  - id: sym
    type:
      - 'null'
      - string
    doc: "Symmetry group"
    inputBinding:
      position: 101
      prefix: --sym
  - id: offset_range
    type:
      - 'null'
      - float
    doc: "Search range for origin offsets (in pixels)"
    inputBinding:
      position: 101
      prefix: --offset_range
  - id: offset_step
    type:
      - 'null'
      - float
    doc: "Sampling rate (before oversampling) for origin offsets (in pixels)"
    inputBinding:
      position: 101
      prefix: --offset_step
  - id: perturb
    type:
      - 'null'
      - float
    doc: "Perturbation factor for the angular sampling (0=no perturb; 0.5=perturb)"
    inputBinding:
      position: 101
      prefix: --perturb
  - id: auto_refine
    type:
      - 'null'
      - boolean
    doc: "Perform 3D auto-refine procedure?"
    inputBinding:
      position: 101
      prefix: --auto_refine
  - id: auto_local_healpix_order
    type:
      - 'null'
      - int
    doc: "Minimum healpix order (before oversampling) from which autosampling procedure will use local searches"
    inputBinding:
      position: 101
      prefix: --auto_local_healpix_order
  - id: sigma_ang
    type:
      - 'null'
      - float
    doc: "Stddev on all three Euler angles for local angular searches (of +/- 3 stddev)"
    inputBinding:
      position: 101
      prefix: --sigma_ang
  - id: sigma_rot
    type:
      - 'null'
      - float
    doc: "Stddev on the first Euler angle for local angular searches (of +/- 3 stddev)"
    inputBinding:
      position: 101
      prefix: --sigma_rot
  - id: sigma_tilt
    type:
      - 'null'
      - float
    doc: "Stddev on the second Euler angle for local angular searches (of +/- 3 stddev)"
    inputBinding:
      position: 101
      prefix: --sigma_tilt
  - id: sigma_psi
    type:
      - 'null'
      - float
    doc: "Stddev on the in-plane angle for local angular searches (of +/- 3 stddev)"
    inputBinding:
      position: 101
      prefix: --sigma_psi
  - id: skip_align
    type:
      - 'null'
      - boolean
    doc: "Skip orientational assignment (only classify)?"
    inputBinding:
      position: 101
      prefix: --skip_align
  - id: skip_rotate
    type:
      - 'null'
      - boolean
    doc: "Skip rotational assignment (only translate and classify)?"
    inputBinding:
      position: 101
      prefix: --skip_rotate
  - id: ctf
    type:
      - 'null'
      - boolean
    doc: "Perform CTF correction?"
    inputBinding:
      position: 101
      prefix: --ctf
  - id: ctf_intact_first_peak
    type:
      - 'null'
      - boolean
    doc: "Ignore CTFs until their first peak?"
    inputBinding:
      position: 101
      prefix: --ctf_intact_first_peak
  - id: ctf_corrected_ref
    type:
      - 'null'
      - boolean
    doc: "Have the input references been CTF-amplitude corrected?"
    inputBinding:
      position: 101
      prefix: --ctf_corrected_ref
  - id: ctf_phase_flipped
    type:
      - 'null'
      - boolean
    doc: "Have the data been CTF phase-flipped?"
    inputBinding:
      position: 101
      prefix: --ctf_phase_flipped
  - id: only_flip_phases
    type:
      - 'null'
      - boolean
    doc: "Only perform CTF phase-flipping? (default is full amplitude-correction)"
    inputBinding:
      position: 101
      prefix: --only_flip_phases
  - id: norm
    type:
      - 'null'
      - boolean
    doc: "Perform normalisation-error correction?"
    inputBinding:
      position: 101
      prefix: --norm
  - id: scale
    type:
      - 'null'
      - boolean
    doc: "Perform intensity-scale corrections on image groups?"
    inputBinding:
      position: 101
      prefix: --scale
  - id: j
    type:
      - 'null'
      - int
    doc: "Number of threads to run in parallel (only useful on multi-core machines)"
    inputBinding:
      position: 101
      prefix: --j
  - id: memory_per_thread
    type:
      - 'null'
      - float
    doc: "Available RAM (in Gb) for each thread"
    inputBinding:
      position: 101
      prefix: --memory_per_thread
  - id: dont_combine_weights_via_disc
    type:
      - 'null'
      - boolean
    doc: "Send the large arrays of summed weights through the MPI network, instead of writing large files to disc"
    inputBinding:
      position: 101
      prefix: --dont_combine_weights_via_disc
  - id: onthefly_shifts
    type:
      - 'null'
      - boolean
    doc: "Calculate shifted images on-the-fly, do not store precalculated ones in memory"
    inputBinding:
      position: 101
      prefix: --onthefly_shifts
  - id: no_parallel_disc_io
    type:
      - 'null'
      - boolean
    doc: "Do NOT let parallel (MPI) processes access the disc simultaneously (use this option with NFS)"
    inputBinding:
      position: 101
      prefix: --no_parallel_disc_io
  - id: preread_images
    type:
      - 'null'
      - boolean
    doc: "Use this to let the master process read all particles into memory. Be careful you have enough RAM for large data sets!"
    inputBinding:
      position: 101
      prefix: --preread_images
  - id: pad
    type:
      - 'null'
      - int
    doc: "Oversampling factor for the Fourier transforms of the references"
    inputBinding:
      position: 101
      prefix: --pad
  - id: NN
    type:
      - 'null'
      - boolean
    doc: "Perform nearest-neighbour instead of linear Fourier-space interpolation?"
    inputBinding:
      position: 101
      prefix: --NN
  - id: r_min_nn
    type:
      - 'null'
      - int
    doc: "Minimum number of Fourier shells to perform linear Fourier-space interpolation"
    inputBinding:
      position: 101
      prefix: --r_min_nn
  - id: verb
    type:
      - 'null'
      - int
    doc: "Verbosity (1=normal, 0=silent)"
    inputBinding:
      position: 101
      prefix: --verb
  - id: random_seed
    type:
      - 'null'
      - int
    doc: "Number for the random seed generator"
    inputBinding:
      position: 101
      prefix: --random_seed
  - id: coarse_size
    type:
      - 'null'
      - int
    doc: "Maximum image size for the first pass of the adaptive sampling approach"
    inputBinding:
      position: 101
      prefix: --coarse_size
  - id: adaptive_fraction
    type:
      - 'null'
      - float
    doc: "Fraction of the weights to be considered in the first pass of adaptive oversampling"
    inputBinding:
      position: 101
      prefix: --adaptive_fraction
  - id: maskedge
    type:
      - 'null'
      - int
    doc: "Width of the soft edge of the spherical mask (in pixels)"
    inputBinding:
      position: 101
      prefix: --maskedge
  - id: fix_sigma_noise
    type:
      - 'null'
      - boolean
    doc: "Fix the experimental noise spectra?"
    inputBinding:
      position: 101
      prefix: --fix_sigma_noise
  - id: fix_sigma_offset
    type:
      - 'null'
      - boolean
    doc: "Fix the stddev in the origin offsets?"
    inputBinding:
      position: 101
      prefix: --fix_sigma_offset
  - id: incr_size
    type:
      - 'null'
      - int
    doc: "Number of Fourier shells beyond the current resolution to be included in refinement"
    inputBinding:
      position: 101
      prefix: --incr_size
  - id: print_metadata_labels
    type:
      - 'null'
      - boolean
    doc: "Print a table with definitions of all metadata labels, and exit"
    inputBinding:
      position: 101
      prefix: --print_metadata_labels
  - id: print_symmetry_ops
    type:
      - 'null'
      - boolean
    doc: "Print all symmetry transformation matrices, and exit"
    inputBinding:
      position: 101
      prefix: --print_symmetry_ops
  - id: strict_highres_exp
    type:
      - 'null'
      - float
    doc: "Resolution limit (in Angstrom) to restrict probability calculations in the expectation step"
    inputBinding:
      position: 101
      prefix: --strict_highres_exp
  - id: dont_check_norm
    type:
      - 'null'
      - boolean
    doc: "Skip the check whether the images are normalised correctly"
    inputBinding:
      position: 101
      prefix: --dont_check_norm
  - id: always_cc
    type:
      - 'null'
      - boolean
    doc: "Perform CC-calculation in all iterations (useful for faster denovo model generation?)"
    inputBinding:
      position: 101
      prefix: --always_cc
  - id: scratchdir
    type:
      - 'null'
      - string
    doc: "Directory (with absolute path, and visible to all nodes) for temporary files"
    inputBinding:
      position: 101
      prefix: --scratchdir
  - id: particle_stacks
    type:
      - 'null'
      - type: array
        items: File
    doc: "Image stacks (.mrcs) named in the input STAR file, staged in the working directory so the names resolve"
outputs:
  - id: stdout
    type: stdout
    doc: "Standard output"
  - id: out_files
    type:
      type: array
      items: File
    doc: "Files written with the output rootname"
    outputBinding:
      glob: $(inputs.output_rootname)*
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: |
      ${
        var l = [];
        if (inputs.particle_stacks) { l = l.concat(inputs.particle_stacks); }
        var r = inputs.output_rootname;
        if (r && r.indexOf("/") >= 0) {
          var dn = r.substring(0, r.lastIndexOf("/"));
          l.push({"entryname": dn, "entry": {"class": "Directory", "basename": dn, "listing": []}, "writable": true});
        }
        return l;
      }
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/relion-bin-plusmpi:v1.4dfsg-4-deb_cv1
stdout: relion-bin-plusmpi_relion_refine_mpi.out
