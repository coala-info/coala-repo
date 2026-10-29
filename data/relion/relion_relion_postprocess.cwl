cwlVersion: v1.2
class: CommandLineTool
baseCommand: relion_postprocess
label: relion_relion_postprocess
doc: "Post-process two half maps: mask, FSC, sharpening (B-factor) and local resolution.\n\nTool homepage:\
  \ https://github.com/3dem/relion"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.staged_files)
inputs:
  - id: input
    type: File
    doc: Input name of half1, e.g. run_half1_class001_unfil.mrc
    inputBinding:
      position: 101
      prefix: --i
  - id: input2
    type:
      - 'null'
      - File
    doc: Input name of half2, (default replaces half1 from --i with half2)
    inputBinding:
      position: 101
      prefix: --i2
  - id: ios
    type:
      - 'null'
      - File
    doc: Input tomo optimiser set file. It is used to set --i if not provided. Updated output optimiser
      set is created.
    inputBinding:
      position: 101
      prefix: --ios
  - id: output
    type:
      - 'null'
      - string
    doc: 'Output rootname; a folder in front is created, e.g. PostProcess/postprocess (RELION default: postprocess)'
    inputBinding:
      position: 101
      prefix: --o
    default: postprocess
  - id: angpix
    type:
      - 'null'
      - float
    doc: 'Pixel size in Angstroms (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --angpix
  - id: half_maps
    type:
      - 'null'
      - boolean
    doc: Write post-processed half maps for validation
    inputBinding:
      position: 101
      prefix: --half_maps
  - id: mtf_angpix
    type:
      - 'null'
      - float
    doc: 'Pixel size in the original micrographs/movies (in Angstroms) (RELION default: -1.)'
    inputBinding:
      position: 101
      prefix: --mtf_angpix
  - id: molweight
    type:
      - 'null'
      - float
    doc: 'Molecular weight (in kDa) of ordered protein mass (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --molweight
  - id: auto_mask
    type:
      - 'null'
      - boolean
    doc: Perform automated masking, based on a density threshold
    inputBinding:
      position: 101
      prefix: --auto_mask
  - id: inimask_threshold
    type:
      - 'null'
      - float
    doc: 'Density at which to threshold the map for the initial seed mask (RELION default: 0.02)'
    inputBinding:
      position: 101
      prefix: --inimask_threshold
  - id: extend_inimask
    type:
      - 'null'
      - float
    doc: 'Number of pixels to extend the initial seed mask (RELION default: 3.)'
    inputBinding:
      position: 101
      prefix: --extend_inimask
  - id: width_mask_edge
    type:
      - 'null'
      - float
    doc: 'Width for the raised cosine soft mask edge (in pixels) (RELION default: 6.)'
    inputBinding:
      position: 101
      prefix: --width_mask_edge
  - id: mask
    type:
      - 'null'
      - File
    doc: Filename of a user-provided mask (1=protein, 0=solvent, all values in range [0,1])
    inputBinding:
      position: 101
      prefix: --mask
  - id: force_mask
    type:
      - 'null'
      - boolean
    doc: Use the mask even when the masked resolution is worse than the unmasked resolution
    inputBinding:
      position: 101
      prefix: --force_mask
  - id: mtf
    type:
      - 'null'
      - File
    doc: User-provided STAR-file with the MTF-curve of the detector
    inputBinding:
      position: 101
      prefix: --mtf
  - id: auto_bfac
    type:
      - 'null'
      - boolean
    doc: Perform automated B-factor determination (Rosenthal and Henderson, 2003)
    inputBinding:
      position: 101
      prefix: --auto_bfac
  - id: autob_lowres
    type:
      - 'null'
      - float
    doc: 'Lowest resolution (in A) to include in fitting of the B-factor (RELION default: 10.)'
    inputBinding:
      position: 101
      prefix: --autob_lowres
  - id: autob_highres
    type:
      - 'null'
      - float
    doc: 'Highest resolution (in A) to include in fitting of the B-factor (RELION default: 0.)'
    inputBinding:
      position: 101
      prefix: --autob_highres
  - id: adhoc_bfac
    type:
      - 'null'
      - float
    doc: 'User-provided B-factor (in A^2) for map sharpening, e.g. -400 (RELION default: 0.)'
    inputBinding:
      position: 101
      prefix: --adhoc_bfac
  - id: skip_fsc_weighting
    type:
      - 'null'
      - boolean
    doc: Do not use FSC-weighting (Rosenthal and Henderson, 2003) in the sharpening process
    inputBinding:
      position: 101
      prefix: --skip_fsc_weighting
  - id: low_pass
    type:
      - 'null'
      - float
    doc: 'Resolution (in Angstroms) at which to low-pass filter the final map (0: disable, negative: resolution
      at FSC=0.143) (RELION default: 0)'
    inputBinding:
      position: 101
      prefix: --low_pass
  - id: locres
    type:
      - 'null'
      - boolean
    doc: Perform local resolution estimation
    inputBinding:
      position: 101
      prefix: --locres
  - id: locres_sampling
    type:
      - 'null'
      - float
    doc: 'Sampling rate (in Angstroms) with which to sample the local-resolution map (RELION default:
      25.)'
    inputBinding:
      position: 101
      prefix: --locres_sampling
  - id: locres_maskrad
    type:
      - 'null'
      - float
    doc: 'Radius (in A) of spherical mask for local-resolution map (default = 0.5*sampling) (RELION default:
      -1)'
    inputBinding:
      position: 101
      prefix: --locres_maskrad
  - id: locres_edgwidth
    type:
      - 'null'
      - float
    doc: 'Width of soft edge (in A) on masks for local-resolution map (default = sampling) (RELION default:
      -1)'
    inputBinding:
      position: 101
      prefix: --locres_edgwidth
  - id: locres_randomize_at
    type:
      - 'null'
      - float
    doc: 'Randomize phases from this resolution (in A) (RELION default: 25.)'
    inputBinding:
      position: 101
      prefix: --locres_randomize_at
  - id: locres_minres
    type:
      - 'null'
      - float
    doc: 'Lowest local resolution allowed (in A) (RELION default: 50.)'
    inputBinding:
      position: 101
      prefix: --locres_minres
  - id: ampl_corr
    type:
      - 'null'
      - boolean
    doc: Perform amplitude correlation and DPR, also re-normalize amplitudes for non-uniform angular distributions
    inputBinding:
      position: 101
      prefix: --ampl_corr
  - id: randomize_at_fsc
    type:
      - 'null'
      - float
    doc: 'Randomize phases from the resolution where FSC drops below this value (RELION default: 0.8)'
    inputBinding:
      position: 101
      prefix: --randomize_at_fsc
  - id: randomize_at_A
    type:
      - 'null'
      - float
    doc: 'Randomize phases from this resolution (in A) onwards (if positive) (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --randomize_at_A
  - id: filter_edge_width
    type:
      - 'null'
      - int
    doc: 'Width of the raised cosine on the low-pass filter edge (in resolution shells) (RELION default:
      2)'
    inputBinding:
      position: 101
      prefix: --filter_edge_width
  - id: interpolate
    type:
      - 'null'
      - boolean
    doc: Interpolate the FSC to obtain an additional, more precise resolution estimate
    inputBinding:
      position: 101
      prefix: --interpolate
  - id: verb
    type:
      - 'null'
      - int
    doc: 'Verbosity (RELION default: 1)'
    inputBinding:
      position: 101
      prefix: --verb
  - id: random_seed
    type:
      - 'null'
      - int
    doc: 'Seed for random number generator (negative value for truly random) (RELION default: 0)'
    inputBinding:
      position: 101
      prefix: --random_seed
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
    doc: Post-processed maps, FSC tables, logfile and the STAR file
    outputBinding:
      glob: $(inputs.output)*
  - id: log
    type: stdout
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/relion:5.0.1--h6e3b700_0
stdout: relion_relion_postprocess.out
