cwlVersion: v1.2
class: CommandLineTool
baseCommand: relion_tomo_refine_ctf
label: relion_relion_tomo_refine_ctf
doc: "Refine tomography CTF parameters: defocus, contrast scale and higher-order aberrations.\n\nTool\
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
  - id: reference_half1
    type:
      - 'null'
      - File
    doc: Reference map, half 1
    inputBinding:
      position: 101
      prefix: --ref1
  - id: reference_half2
    type:
      - 'null'
      - File
    doc: Reference map, half 2
    inputBinding:
      position: 101
      prefix: --ref2
  - id: reference_mask
    type:
      - 'null'
      - File
    doc: Reference mask
    inputBinding:
      position: 101
      prefix: --mask
  - id: reference_fsc
    type:
      - 'null'
      - File
    doc: Star file containing the FSC of the reference
    inputBinding:
      position: 101
      prefix: --fsc
  - id: freq_cutoff
    type:
      - 'null'
      - float
    doc: 'Explicit cutoff frequency (in Å; negative to turn off) (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --freq_cutoff
  - id: fsc_thresh_width
    type:
      - 'null'
      - float
    doc: 'Width of the frq. weight flank (RELION default: 5)'
    inputBinding:
      position: 101
      prefix: --fsc_thresh_width
  - id: use_SNR_weight
    type:
      - 'null'
      - boolean
    doc: Weight each shell proportionally to its reference-map confidence
    inputBinding:
      position: 101
      prefix: --use_SNR_weight
  - id: box_size
    type: int
    doc: Box size
    inputBinding:
      position: 101
      prefix: --b
  - id: output
    type: string
    doc: Output directory
    inputBinding:
      position: 101
      prefix: --o
  - id: only_do_unfinished
    type:
      - 'null'
      - boolean
    doc: Only process tomograms for which no temporary output data can be found
    inputBinding:
      position: 101
      prefix: --only_do_unfinished
  - id: per_frame_noise
    type:
      - 'null'
      - boolean
    doc: Assume a different noise distribution for each frame
    inputBinding:
      position: 101
      prefix: --per_frame_noise
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
  - id: do_defocus
    type:
      - 'null'
      - boolean
    doc: Refine the (astigmatic) defocus.
    inputBinding:
      position: 101
      prefix: --do_defocus
  - id: do_reg_defocus
    type:
      - 'null'
      - boolean
    doc: Regularise defocus estimation (i.e. require tilts to have similar defoci).
    inputBinding:
      position: 101
      prefix: --do_reg_defocus
  - id: lambda
    type:
      - 'null'
      - float
    doc: 'Defocus regularisation scale (RELION default: 0.001)'
    inputBinding:
      position: 101
      prefix: --lambda
  - id: d0
    type:
      - 'null'
      - float
    doc: 'Min. defocus offset to test [Å] (RELION default: -3000)'
    inputBinding:
      position: 101
      prefix: --d0
  - id: d1
    type:
      - 'null'
      - float
    doc: 'Max. defocus offset to test [Å] (RELION default: 3000)'
    inputBinding:
      position: 101
      prefix: --d1
  - id: ds
    type:
      - 'null'
      - float
    doc: 'Number of defocus steps in-between (RELION default: 100)'
    inputBinding:
      position: 101
      prefix: --ds
  - id: kmin
    type:
      - 'null'
      - float
    doc: 'Lowest spatial frequency to consider [Å] (RELION default: 30)'
    inputBinding:
      position: 101
      prefix: --kmin
  - id: reset_to_common
    type:
      - 'null'
      - boolean
    doc: Reset the CTFs of all tilts to a common one prior to local refinement.
    inputBinding:
      position: 101
      prefix: --reset_to_common
  - id: do_scale
    type:
      - 'null'
      - boolean
    doc: Refine the contrast scale
    inputBinding:
      position: 101
      prefix: --do_scale
  - id: per_frame_scale
    type:
      - 'null'
      - boolean
    doc: Estimate the scale per frame (no Lambert fit)
    inputBinding:
      position: 101
      prefix: --per_frame_scale
  - id: per_tomogram_scale
    type:
      - 'null'
      - boolean
    doc: Estimate the scale per tomogram (luminance may become unstable)
    inputBinding:
      position: 101
      prefix: --per_tomogram_scale
  - id: do_even_aberrations
    type:
      - 'null'
      - boolean
    doc: Refine even higher-order aberrations
    inputBinding:
      position: 101
      prefix: --do_even_aberrations
  - id: do_odd_aberrations
    type:
      - 'null'
      - boolean
    doc: Refine odd higher-order aberrations
    inputBinding:
      position: 101
      prefix: --do_odd_aberrations
  - id: ne
    type:
      - 'null'
      - int
    doc: 'Maximal N for even aberrations (RELION default: 4)'
    inputBinding:
      position: 101
      prefix: --ne
  - id: 'no'
    type:
      - 'null'
      - int
    doc: 'Maximal N for odd aberrations (RELION default: 3)'
    inputBinding:
      position: 101
      prefix: --no
  - id: min_frame
    type:
      - 'null'
      - int
    doc: 'First frame to consider (RELION default: 0)'
    inputBinding:
      position: 101
      prefix: --min_frame
  - id: max_frame
    type:
      - 'null'
      - int
    doc: 'Last frame to consider (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --max_frame
  - id: cutoff_fract
    type:
      - 'null'
      - float
    doc: 'Ignore shells for which the relative dose or frequency weight falls below this fraction of the
      average (RELION default: 0.02)'
    inputBinding:
      position: 101
      prefix: --cutoff_fract
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
    doc: Output directory
    outputBinding:
      glob: $(inputs.output)
  - id: log
    type: stdout
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/relion:5.0.1--h6e3b700_0
stdout: relion_relion_tomo_refine_ctf.out
