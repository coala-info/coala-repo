cwlVersion: v1.2
class: CommandLineTool
baseCommand: relion_tomo_reconstruct_tomogram
label: relion_relion_tomo_reconstruct_tomogram
doc: "Reconstruct tomograms from tilt series by weighted back-projection or Fourier inversion.\n\nTool\
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
  - id: tomogram_set
    type:
      - 'null'
      - File
    doc: Tomogram set
    inputBinding:
      position: 101
      prefix: --t
  - id: output
    type: string
    doc: Output filename (or output directory in case of reconstructing multiple tomograms)
    inputBinding:
      position: 101
      prefix: --o
  - id: width
    type: int
    doc: Width
    inputBinding:
      position: 101
      prefix: --w
  - id: height
    type: int
    doc: Height
    inputBinding:
      position: 101
      prefix: --h
  - id: thickness
    type: int
    doc: Thickness
    inputBinding:
      position: 101
      prefix: --d
  - id: tomogram_name
    type:
      - 'null'
      - string
    doc: 'Tomogram name (RELION default: *)'
    inputBinding:
      position: 101
      prefix: --tn
  - id: generate_split_tomograms
    type:
      - 'null'
      - boolean
    doc: Reconstruct tomograms from even/odd movie frames or tilt image index for denoising
    inputBinding:
      position: 101
      prefix: --generate_split_tomograms
  - id: fourier
    type:
      - 'null'
      - boolean
    doc: Use a Fourier-inversion reconstruction algorithm
    inputBinding:
      position: 101
      prefix: --fourier
  - id: lambda
    type:
      - 'null'
      - float
    doc: 'Regularisation constant for CTF-correction of the SNRs in the Fourier-inversion algorithm (RELION
      default: 10)'
    inputBinding:
      position: 101
      prefix: --lambda
  - id: ctf_intact_first_peak
    type:
      - 'null'
      - boolean
    doc: Leave CTFs intact until first peak
    inputBinding:
      position: 101
      prefix: --ctf_intact_first_peak
  - id: no_weight
    type:
      - 'null'
      - boolean
    doc: Do not perform weighting in Fourier space using a Wiener filter
    inputBinding:
      position: 101
      prefix: --no_weight
  - id: pre_weight
    type:
      - 'null'
      - boolean
    doc: Pre-weight the 2D slices prior to backprojection
    inputBinding:
      position: 101
      prefix: --pre_weight
  - id: Fc
    type:
      - 'null'
      - boolean
    doc: Downsample the 2D images by Fourier cropping
    inputBinding:
      position: 101
      prefix: --Fc
  - id: only_do_unfinished
    type:
      - 'null'
      - boolean
    doc: Only reconstruct those tomograms that haven't finished yet
    inputBinding:
      position: 101
      prefix: --only_do_unfinished
  - id: SNR
    type:
      - 'null'
      - float
    doc: 'SNR assumed by the Wiener filter (RELION default: 10)'
    inputBinding:
      position: 101
      prefix: --SNR
  - id: ctf
    type:
      - 'null'
      - boolean
    doc: Perform CTF correction
    inputBinding:
      position: 101
      prefix: --ctf
  - id: skip_wiener
    type:
      - 'null'
      - boolean
    doc: Do multiply images with CTF, but don't divide by CTF^2 in Wiener filter
    inputBinding:
      position: 101
      prefix: --skip_wiener
  - id: keep_mean
    type:
      - 'null'
      - boolean
    doc: Do not zero the DC component of each frame
    inputBinding:
      position: 101
      prefix: --keep_mean
  - id: td
    type:
      - 'null'
      - float
    doc: 'Tapering distance (RELION default: 0.0)'
    inputBinding:
      position: 101
      prefix: --td
  - id: tf
    type:
      - 'null'
      - float
    doc: 'Tapering falloff (RELION default: 0.0)'
    inputBinding:
      position: 101
      prefix: --tf
  - id: x0
    type:
      - 'null'
      - float
    doc: 'X origin (RELION default: 0.0)'
    inputBinding:
      position: 101
      prefix: --x0
  - id: y0
    type:
      - 'null'
      - float
    doc: 'Y origin (RELION default: 0.0)'
    inputBinding:
      position: 101
      prefix: --y0
  - id: z0
    type:
      - 'null'
      - float
    doc: 'Z origin (RELION default: 0.0)'
    inputBinding:
      position: 101
      prefix: --z0
  - id: bin
    type:
      - 'null'
      - float
    doc: 'Binning (RELION default: 1.0)'
    inputBinding:
      position: 101
      prefix: --bin
  - id: binned_angpix
    type:
      - 'null'
      - float
    doc: 'OR: desired pixel size after binning (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --binned_angpix
  - id: tiltangle_offset
    type:
      - 'null'
      - float
    doc: 'Offset applied to all tilt angles (in deg) (RELION default: 0)'
    inputBinding:
      position: 101
      prefix: --tiltangle_offset
  - id: bfactor_per_edose
    type:
      - 'null'
      - float
    doc: 'B-factor dose-weighting per electron/A^2 dose (default is use Niko''s model) (RELION default:
      0)'
    inputBinding:
      position: 101
      prefix: --bfactor_per_edose
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of threads (RELION default: 1)'
    inputBinding:
      position: 101
      prefix: --j
  - id: do_proj
    type:
      - 'null'
      - boolean
    doc: Use this to skip calculation of 2D projection of the tomogram along the Z-axis
    inputBinding:
      position: 101
      prefix: --do_proj
  - id: centre_proj
    type:
      - 'null'
      - float
    doc: 'Central Z-slice for 2D projection (in tomogram pixels from the middle) (RELION default: 0)'
    inputBinding:
      position: 101
      prefix: --centre_proj
  - id: thickness_proj
    type:
      - 'null'
      - float
    doc: 'Thickness of the 2D projection (in tomogram pixels) (RELION default: 10)'
    inputBinding:
      position: 101
      prefix: --thickness_proj
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
    doc: Output directory with the tomograms/ folder (give the name with a trailing slash)
    outputBinding:
      glob: $(inputs.output)
  - id: log
    type: stdout
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/relion:5.0.1--h6e3b700_0
stdout: relion_relion_tomo_reconstruct_tomogram.out
