cwlVersion: v1.2
class: CommandLineTool
baseCommand: relion_ctf_refine
label: relion_relion_ctf_refine
doc: "Refine per-particle defocus, astigmatism, beam tilt, aberrations and magnification (CTF refinement).\n\
  \nTool homepage: https://github.com/3dem/relion"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.staged_files)
inputs:
  - id: input
    type: File
    doc: Input STAR file containing the particles
    inputBinding:
      position: 101
      prefix: --i
  - id: fsc_star
    type: File
    doc: Input STAR file with the FSC of the reference (usually from PostProcess)
    inputBinding:
      position: 101
      prefix: --f
  - id: output
    type: string
    doc: Output directory, e.g. CtfRefine/job041/
    inputBinding:
      position: 101
      prefix: --o
  - id: m1
    type:
      - 'null'
      - File
    doc: Reference map, half 1
    inputBinding:
      position: 101
      prefix: --m1
  - id: m2
    type:
      - 'null'
      - File
    doc: Reference map, half 2
    inputBinding:
      position: 101
      prefix: --m2
  - id: a1
    type:
      - 'null'
      - File
    doc: Amplitude reference map, half 1
    inputBinding:
      position: 101
      prefix: --a1
  - id: a2
    type:
      - 'null'
      - File
    doc: Amplitude reference map, half 2
    inputBinding:
      position: 101
      prefix: --a2
  - id: angpix_ref
    type:
      - 'null'
      - float
    doc: 'Pixel size of the reference map (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --angpix_ref
  - id: mask
    type:
      - 'null'
      - File
    doc: Reference mask
    inputBinding:
      position: 101
      prefix: --mask
  - id: pad
    type:
      - 'null'
      - float
    doc: 'Padding factor (RELION default: 2)'
    inputBinding:
      position: 101
      prefix: --pad
  - id: only_do_unfinished
    type:
      - 'null'
      - boolean
    doc: Skip those steps for which output files already exist.
    inputBinding:
      position: 101
      prefix: --only_do_unfinished
  - id: ctf_pad
    type:
      - 'null'
      - boolean
    doc: Use larger box to calculate CTF and then downscale to mimic boxing operation in real space
    inputBinding:
      position: 101
      prefix: --ctf_pad
  - id: diag
    type:
      - 'null'
      - boolean
    doc: Write out diagnostic data (slower)
    inputBinding:
      position: 101
      prefix: --diag
  - id: fit_defocus
    type:
      - 'null'
      - boolean
    doc: Perform refinement of per-particle defocus values?
    inputBinding:
      position: 101
      prefix: --fit_defocus
  - id: fit_mode
    type:
      - 'null'
      - string
    doc: 'String of 5 characters describing whether to fit the phase shift (1), defocus (2), astigmatism
      (3), spherical aberration (4) and B-factors (5) per particle (''p''), per micrograph (''m'') or
      to keep them fixed (''f'') during the per-micrograph CTF refinement. (RELION default: fpmfm)'
    inputBinding:
      position: 101
      prefix: --fit_mode
  - id: max_defocus_iters
    type:
      - 'null'
      - float
    doc: 'Maximum number of iterations for CTF refinement. (RELION default: 100)'
    inputBinding:
      position: 101
      prefix: --max_defocus_iters
  - id: bf0
    type:
      - 'null'
      - boolean
    doc: Perform brute-force per-particle defocus search (as in RELION 3.0) prior to the per-micrograph
      CTF refinement.
    inputBinding:
      position: 101
      prefix: --bf0
  - id: bf1
    type:
      - 'null'
      - boolean
    doc: Perform brute-force defocus search after CTF refinement.
    inputBinding:
      position: 101
      prefix: --bf1
  - id: bf_only
    type:
      - 'null'
      - boolean
    doc: Skip CTF refinement and only perform a brute-force defocus search.
    inputBinding:
      position: 101
      prefix: --bf_only
  - id: bf_range
    type:
      - 'null'
      - float
    doc: 'Defocus scan range (in A) for brute-force search. (RELION default: 2000.)'
    inputBinding:
      position: 101
      prefix: --bf_range
  - id: legacy_astig
    type:
      - 'null'
      - boolean
    doc: Estimate independent per-particle astigmatism (from RELION 3.0)
    inputBinding:
      position: 101
      prefix: --legacy_astig
  - id: kmin_defocus
    type:
      - 'null'
      - float
    doc: 'Inner freq. threshold for defocus estimation [Angst] (RELION default: 30.0)'
    inputBinding:
      position: 101
      prefix: --kmin_defocus
  - id: fit_bfacs
    type:
      - 'null'
      - boolean
    doc: Estimate CTF B-factors
    inputBinding:
      position: 101
      prefix: --fit_bfacs
  - id: bfac_per_mg
    type:
      - 'null'
      - boolean
    doc: Estimate B-factors per micrograph, instead of per particle
    inputBinding:
      position: 101
      prefix: --bfac_per_mg
  - id: bfac_min_B
    type:
      - 'null'
      - float
    doc: 'Minimal allowed B-factor (RELION default: -30)'
    inputBinding:
      position: 101
      prefix: --bfac_min_B
  - id: bfac_max_B
    type:
      - 'null'
      - float
    doc: 'Maximal allowed B-factor (RELION default: 300)'
    inputBinding:
      position: 101
      prefix: --bfac_max_B
  - id: bfac_min_scale
    type:
      - 'null'
      - float
    doc: 'Minimal allowed scale-factor (essential for outlier rejection) (RELION default: 0.2)'
    inputBinding:
      position: 101
      prefix: --bfac_min_scale
  - id: kmin_bfac
    type:
      - 'null'
      - float
    doc: 'Inner freq. threshold for B-factor estimation [Angst] (RELION default: 30.0)'
    inputBinding:
      position: 101
      prefix: --kmin_bfac
  - id: fit_beamtilt
    type:
      - 'null'
      - boolean
    doc: Perform refinement of beamtilt
    inputBinding:
      position: 101
      prefix: --fit_beamtilt
  - id: kmin_tilt
    type:
      - 'null'
      - float
    doc: 'Inner freq. threshold for beamtilt estimation [Å] (RELION default: 20.0)'
    inputBinding:
      position: 101
      prefix: --kmin_tilt
  - id: odd_aberr_max_n
    type:
      - 'null'
      - float
    doc: 'Maximum degree of Zernike polynomials used to fit odd (i.e. antisymmetrical) aberrations (RELION
      default: 0)'
    inputBinding:
      position: 101
      prefix: --odd_aberr_max_n
  - id: xr0_t
    type:
      - 'null'
      - float
    doc: 'Exclusion ring start [Å] - use to exclude dominant frequency (e.g. for helices) (RELION default:
      -1)'
    inputBinding:
      position: 101
      prefix: --xr0_t
  - id: xr1_t
    type:
      - 'null'
      - float
    doc: 'Exclusion ring end [Å] (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --xr1_t
  - id: fit_aberr
    type:
      - 'null'
      - boolean
    doc: Estimate symmetric aberrations
    inputBinding:
      position: 101
      prefix: --fit_aberr
  - id: kmin_aberr
    type:
      - 'null'
      - float
    doc: 'Inner freq. threshold for symmetrical aberration estimation [Å] (RELION default: 20.0)'
    inputBinding:
      position: 101
      prefix: --kmin_aberr
  - id: even_aberr_max_n
    type:
      - 'null'
      - float
    doc: 'Maximum degree of Zernike polynomials used to fit even (i.e. symmetrical) aberrations (RELION
      default: 4)'
    inputBinding:
      position: 101
      prefix: --even_aberr_max_n
  - id: xr0_a
    type:
      - 'null'
      - float
    doc: 'Exclusion ring start [Å] (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --xr0_a
  - id: xr1_a
    type:
      - 'null'
      - float
    doc: 'Exclusion ring end [Å] (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --xr1_a
  - id: fit_aniso
    type:
      - 'null'
      - boolean
    doc: Estimate anisotropic magnification
    inputBinding:
      position: 101
      prefix: --fit_aniso
  - id: kmin_mag
    type:
      - 'null'
      - float
    doc: 'Inner freq. threshold for anisotropic magnification estimation [Angst] (RELION default: 20.0)'
    inputBinding:
      position: 101
      prefix: --kmin_mag
  - id: keep_astig
    type:
      - 'null'
      - boolean
    doc: Do not translate astigmatism into new coordinates
    inputBinding:
      position: 101
      prefix: --keep_astig
  - id: part_astig
    type:
      - 'null'
      - boolean
    doc: Allow astigmatism to vary among the particles of a micrograph
    inputBinding:
      position: 101
      prefix: --part_astig
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of (OMP) threads (RELION default: 1)'
    inputBinding:
      position: 101
      prefix: --j
  - id: min_MG
    type:
      - 'null'
      - int
    doc: 'First micrograph index (RELION default: 0)'
    inputBinding:
      position: 101
      prefix: --min_MG
  - id: max_MG
    type:
      - 'null'
      - int
    doc: 'Last micrograph index (default is to process all) (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --max_MG
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Write debugging data
    inputBinding:
      position: 101
      prefix: --debug
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
  - id: output_dir
    type: Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output)
  - id: log
    type: stdout
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/relion:5.0.1--h6e3b700_0
stdout: relion_relion_ctf_refine.out
