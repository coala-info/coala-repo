cwlVersion: v1.2
class: CommandLineTool
baseCommand: relion_run_ctffind
label: relion_relion_run_ctffind
doc: "Estimate the CTF of micrographs with an external CTFFIND executable and collect the results in a\
  \ STAR file.\n\nTool homepage: https://github.com/3dem/relion"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.staged_files)
inputs:
  - id: input
    type: File
    doc: STAR file with all input micrographs, or a unix wildcard to all micrograph files, e.g. "mics/*.mrc"
    inputBinding:
      position: 101
      prefix: --i
  - id: use_noDW
    type:
      - 'null'
      - boolean
    doc: Estimate CTFs from rlnMicrographNameNoDW instead of rlnMicrographName (only after MotionCor2)
    inputBinding:
      position: 101
      prefix: --use_noDW
  - id: output
    type:
      - 'null'
      - string
    doc: 'Directory, where all output files will be stored (RELION default: CtfEstimate/)'
    inputBinding:
      position: 101
      prefix: --o
    default: CtfEstimate
  - id: only_make_star
    type:
      - 'null'
      - boolean
    doc: Don't estimate any CTFs, only join all logfile results in a STAR file
    inputBinding:
      position: 101
      prefix: --only_make_star
  - id: only_do_unfinished
    type:
      - 'null'
      - boolean
    doc: Only estimate CTFs for those micrographs for which there is not yet a logfile with Final values.
    inputBinding:
      position: 101
      prefix: --only_do_unfinished
  - id: do_at_most
    type:
      - 'null'
      - int
    doc: 'Only process up to this number of (unprocessed) micrographs. (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --do_at_most
  - id: ctfWin
    type:
      - 'null'
      - int
    doc: 'Size (in pixels) of a centered, squared window to use for CTF-estimation (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --ctfWin
  - id: localsearch_nominal_defocus
    type:
      - 'null'
      - float
    doc: 'If positive, search defoci (+/-) around rlnTomoNominalDefocus (in A) (RELION default: 10000.)'
    inputBinding:
      position: 101
      prefix: --localsearch_nominal_defocus
  - id: exp_factor_dose
    type:
      - 'null'
      - float
    doc: 'If positive, use exponential factor by which to limit maxres per unit dose (maxres*=exp(dose/factor))
      (RELION default: 100.)'
    inputBinding:
      position: 101
      prefix: --exp_factor_dose
  - id: CS
    type:
      - 'null'
      - float
    doc: 'Spherical Aberration (mm) (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --CS
  - id: HT
    type:
      - 'null'
      - float
    doc: 'Voltage (kV) (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --HT
  - id: AmpCnst
    type:
      - 'null'
      - float
    doc: 'Amplitude constrast (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --AmpCnst
  - id: angpix
    type:
      - 'null'
      - float
    doc: 'Pixel size in the input micrographs (A) (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --angpix
  - id: ctffind_exe
    type:
      - 'null'
      - string
    doc: Location of ctffind executable (or through RELION_CTFFIND_EXECUTABLE environment variable)
    inputBinding:
      position: 101
      prefix: --ctffind_exe
  - id: Box
    type:
      - 'null'
      - int
    doc: 'Size of the boxes to calculate FFTs (RELION default: 512)'
    inputBinding:
      position: 101
      prefix: --Box
  - id: ResMin
    type:
      - 'null'
      - float
    doc: 'Minimum resolution (in A) to include in calculations (RELION default: 100)'
    inputBinding:
      position: 101
      prefix: --ResMin
  - id: ResMax
    type:
      - 'null'
      - float
    doc: 'Maximum resolution (in A) to include in calculations (RELION default: 7)'
    inputBinding:
      position: 101
      prefix: --ResMax
  - id: dFMin
    type:
      - 'null'
      - float
    doc: 'Minimum defocus value (in A) to search (RELION default: 10000)'
    inputBinding:
      position: 101
      prefix: --dFMin
  - id: dFMax
    type:
      - 'null'
      - float
    doc: 'Maximum defocus value (in A) to search (RELION default: 50000)'
    inputBinding:
      position: 101
      prefix: --dFMax
  - id: FStep
    type:
      - 'null'
      - float
    doc: 'defocus step size (in A) for search (RELION default: 250)'
    inputBinding:
      position: 101
      prefix: --FStep
  - id: dAst
    type:
      - 'null'
      - float
    doc: 'amount of astigmatism (in A) (RELION default: 0)'
    inputBinding:
      position: 101
      prefix: --dAst
  - id: is_ctffind4
    type:
      - 'null'
      - boolean
    doc: The provided CTFFIND executable is CTFFIND4 (version 4.1+)
    inputBinding:
      position: 101
      prefix: --is_ctffind4
  - id: use_given_ps
    type:
      - 'null'
      - boolean
    doc: Use pre-calculated power spectra?
    inputBinding:
      position: 101
      prefix: --use_given_ps
  - id: do_movie_thon_rings
    type:
      - 'null'
      - boolean
    doc: Calculate Thon rings from movie frames?
    inputBinding:
      position: 101
      prefix: --do_movie_thon_rings
  - id: avg_movie_frames
    type:
      - 'null'
      - int
    doc: 'Average over how many movie frames (try to get 4 e-/A2) (RELION default: 1)'
    inputBinding:
      position: 101
      prefix: --avg_movie_frames
  - id: movie_rootname
    type:
      - 'null'
      - string
    doc: 'Rootname plus extension for movies (RELION default: _movie.mrcs)'
    inputBinding:
      position: 101
      prefix: --movie_rootname
  - id: do_phaseshift
    type:
      - 'null'
      - boolean
    doc: Estimate the phase shift in the images (e.g. from a phase-plate)
    inputBinding:
      position: 101
      prefix: --do_phaseshift
  - id: phase_min
    type:
      - 'null'
      - float
    doc: 'Minimum phase shift (in degrees) (RELION default: 0.)'
    inputBinding:
      position: 101
      prefix: --phase_min
  - id: phase_max
    type:
      - 'null'
      - float
    doc: 'Maximum phase shift (in degrees) (RELION default: 180.)'
    inputBinding:
      position: 101
      prefix: --phase_max
  - id: phase_step
    type:
      - 'null'
      - float
    doc: 'Step in phase shift (in degrees) (RELION default: 10.)'
    inputBinding:
      position: 101
      prefix: --phase_step
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of threads (for CTFIND4 only) (RELION default: 1)'
    inputBinding:
      position: 101
      prefix: --j
  - id: fast_search
    type:
      - 'null'
      - boolean
    doc: Disable "Slower, more exhaustive search" in CTFFIND4.1 (faster but less accurate)
    inputBinding:
      position: 101
      prefix: --fast_search
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
    doc: Directory with the CTF estimates and micrographs_ctf.star
    outputBinding:
      glob: $(inputs.output)
  - id: log
    type: stdout
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/relion:5.0.1--h6e3b700_0
stdout: relion_relion_run_ctffind.out
