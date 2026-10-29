cwlVersion: v1.2
class: CommandLineTool
baseCommand: relion_run_motioncorr
label: relion_relion_run_motioncorr
doc: "Correct beam-induced motion of movies with RELION's own implementation or MotionCor2, and write\
  \ dose-weighted micrographs.\n\nTool homepage: https://github.com/3dem/relion"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.staged_files)
inputs:
  - id: input
    type: File
    doc: STAR file with all input micrographs, the tomography tilt series, or a Linux wildcard with all
      micrographs to operate on
    inputBinding:
      position: 101
      prefix: --i
  - id: output
    type:
      - 'null'
      - string
    doc: 'Name for the output directory (RELION default: MotionCorr)'
    inputBinding:
      position: 101
      prefix: --o
    default: MotionCorr
  - id: skip_logfile
    type:
      - 'null'
      - boolean
    doc: Skip generation of tracks-part of the logfile.pdf
    inputBinding:
      position: 101
      prefix: --skip_logfile
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of threads per movie (= process) (RELION default: 1)'
    inputBinding:
      position: 101
      prefix: --j
  - id: max_io_threads
    type:
      - 'null'
      - int
    doc: 'Limit the number of IO threads. (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --max_io_threads
  - id: only_do_unfinished
    type:
      - 'null'
      - boolean
    doc: Only run motion correction for those micrographs for which there is not yet an output micrograph.
    inputBinding:
      position: 101
      prefix: --only_do_unfinished
  - id: do_at_most
    type:
      - 'null'
      - int
    doc: 'Only process at most this number of (unprocessed) micrographs. (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --do_at_most
  - id: grouping_for_ps
    type:
      - 'null'
      - int
    doc: 'Group this number of frames and write summed power spectrum. -1 == do not write (RELION default:
      -1)'
    inputBinding:
      position: 101
      prefix: --grouping_for_ps
  - id: ps_size
    type:
      - 'null'
      - int
    doc: 'Output size of power spectrum (RELION default: 512)'
    inputBinding:
      position: 101
      prefix: --ps_size
  - id: first_frame_sum
    type:
      - 'null'
      - int
    doc: 'First movie frame used in output sum (start at 1) (RELION default: 1)'
    inputBinding:
      position: 101
      prefix: --first_frame_sum
  - id: last_frame_sum
    type:
      - 'null'
      - int
    doc: 'Last movie frame used in output sum (0 or negative: use all) (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --last_frame_sum
  - id: eer_grouping
    type:
      - 'null'
      - int
    doc: 'EER grouping (RELION default: 40)'
    inputBinding:
      position: 101
      prefix: --eer_grouping
  - id: eer_upsampling
    type:
      - 'null'
      - int
    doc: 'EER upsampling (1 = physical or 2 = 2x super-resolution) (RELION default: 1)'
    inputBinding:
      position: 101
      prefix: --eer_upsampling
  - id: use_motioncor2
    type:
      - 'null'
      - boolean
    doc: Use Shawn Zheng's MOTIONCOR2.
    inputBinding:
      position: 101
      prefix: --use_motioncor2
  - id: motioncor2_exe
    type:
      - 'null'
      - string
    doc: Location of MOTIONCOR2 executable (or through RELION_MOTIONCOR2_EXECUTABLE environment variable)
    inputBinding:
      position: 101
      prefix: --motioncor2_exe
  - id: bin_factor
    type:
      - 'null'
      - float
    doc: 'Binning factor (can be non-integer) (RELION default: 1)'
    inputBinding:
      position: 101
      prefix: --bin_factor
  - id: bfactor
    type:
      - 'null'
      - float
    doc: 'B-factor (in pix^2) that will be used inside MOTIONCOR2 (RELION default: 150)'
    inputBinding:
      position: 101
      prefix: --bfactor
  - id: gainref
    type:
      - 'null'
      - File
    doc: Location of MRC file with the gain reference to be applied
    inputBinding:
      position: 101
      prefix: --gainref
  - id: gain_rot
    type:
      - 'null'
      - int
    doc: 'Rotate the gain reference this number times 90 degrees clock-wise (in relion_display). This
      is same as MotionCor2''s RotGain. 0, 1, 2 or 3 (RELION default: 0)'
    inputBinding:
      position: 101
      prefix: --gain_rot
  - id: gain_flip
    type:
      - 'null'
      - int
    doc: 'Flip the gain reference. This is same as MotionCor2''s FlipGain. 0, 1 (flip Y == upside down)
      or 2 (flip X == left to right) (RELION default: 0)'
    inputBinding:
      position: 101
      prefix: --gain_flip
  - id: patch_x
    type:
      - 'null'
      - int
    doc: 'Patching in X-direction for MOTIONCOR2 (RELION default: 1)'
    inputBinding:
      position: 101
      prefix: --patch_x
  - id: patch_y
    type:
      - 'null'
      - int
    doc: 'Patching in Y-direction for MOTIONCOR2 (RELION default: 1)'
    inputBinding:
      position: 101
      prefix: --patch_y
  - id: group_frames
    type:
      - 'null'
      - int
    doc: 'Average together this many frames before calculating the beam-induced shifts (RELION default:
      1)'
    inputBinding:
      position: 101
      prefix: --group_frames
  - id: defect_file
    type:
      - 'null'
      - File
    doc: Location of a MOTIONCOR2-style detector defect file (x y w h) or a defect map (1 means bad)
    inputBinding:
      position: 101
      prefix: --defect_file
  - id: archive
    type:
      - 'null'
      - string
    doc: Location of the directory for archiving movies in 4-byte MRC format
    inputBinding:
      position: 101
      prefix: --archive
  - id: even_odd_split
    type:
      - 'null'
      - boolean
    doc: Generate two images summed from odd and even movie frames. Later used for denoising in tomography.
    inputBinding:
      position: 101
      prefix: --even_odd_split
  - id: other_motioncor2_args
    type:
      - 'null'
      - string
    doc: Additional arguments to MOTIONCOR2
    inputBinding:
      position: 101
      prefix: --other_motioncor2_args
  - id: gpu
    type:
      - 'null'
      - string
    doc: Device ids for each MPI-thread, e.g 0:1:2:3
    inputBinding:
      position: 101
      prefix: --gpu
  - id: dose_weighting
    type:
      - 'null'
      - boolean
    doc: Use dose-weighting scheme
    inputBinding:
      position: 101
      prefix: --dose_weighting
  - id: angpix
    type:
      - 'null'
      - float
    doc: 'Pixel size in Angstroms (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --angpix
  - id: voltage
    type:
      - 'null'
      - float
    doc: 'Voltage (in kV) for dose-weighting (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --voltage
  - id: dose_per_frame
    type:
      - 'null'
      - float
    doc: 'Electron dose (in electrons/A2/frame) for dose-weighting (RELION default: 1)'
    inputBinding:
      position: 101
      prefix: --dose_per_frame
  - id: preexposure
    type:
      - 'null'
      - float
    doc: 'Pre-exposure (in electrons/A2) for dose-weighting (RELION default: 0)'
    inputBinding:
      position: 101
      prefix: --preexposure
  - id: use_own
    type:
      - 'null'
      - boolean
    doc: Use our own implementation of motion correction
    inputBinding:
      position: 101
      prefix: --use_own
  - id: float16
    type:
      - 'null'
      - boolean
    doc: Write in half-precision 16 bit floating point numbers (MRC mode 12), instead of 32 bit (MRC mode
      0).
    inputBinding:
      position: 101
      prefix: --float16
  - id: skip_defect
    type:
      - 'null'
      - boolean
    doc: Skip hot pixel detection
    inputBinding:
      position: 101
      prefix: --skip_defect
  - id: save_noDW
    type:
      - 'null'
      - boolean
    doc: Save aligned but non dose weighted micrograph
    inputBinding:
      position: 101
      prefix: --save_noDW
  - id: max_iter
    type:
      - 'null'
      - int
    doc: 'Maximum number of iterations for alignment. Only valid with --use_own (RELION default: 5)'
    inputBinding:
      position: 101
      prefix: --max_iter
  - id: interpolate_shifts
    type:
      - 'null'
      - boolean
    doc: (EXPERIMENTAL) Interpolate shifts
    inputBinding:
      position: 101
      prefix: --interpolate_shifts
  - id: ccf_downsample
    type:
      - 'null'
      - int
    doc: '(EXPERT) Downsampling rate of CC map. default = 0 = automatic based on B factor (RELION default:
      0)'
    inputBinding:
      position: 101
      prefix: --ccf_downsample
  - id: early_binning
    type:
      - 'null'
      - boolean
    doc: Do binning before alignment to reduce memory usage. This might dampen signal near Nyquist. (ON
      by default)
    inputBinding:
      position: 101
      prefix: --early_binning
  - id: no_early_binning
    type:
      - 'null'
      - boolean
    doc: Disable --early_binning
    inputBinding:
      position: 101
      prefix: --no_early_binning
  - id: dose_motionstats_cutoff
    type:
      - 'null'
      - float
    doc: 'Electron dose (in electrons/A2) at which to distinguish early/late global accumulated motion
      in output statistics (RELION default: 4.)'
    inputBinding:
      position: 101
      prefix: --dose_motionstats_cutoff
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
    doc: Directory with the corrected micrographs and corrected_micrographs.star
    outputBinding:
      glob: $(inputs.output)
  - id: log
    type: stdout
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/relion:5.0.1--h6e3b700_0
stdout: relion_relion_run_motioncorr.out
