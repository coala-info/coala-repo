cwlVersion: v1.2
class: CommandLineTool
baseCommand: relion_tomo_local_particle_refine
label: relion_relion_tomo_local_particle_refine
doc: "Locally refine tomography particle positions and orientations in subtomogram averaging.\n\nTool\
  \ homepage: https://github.com/3dem/relion"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.staged_files)
inputs:
  - id: input
    type:
      - 'null'
      - File
    doc: Optimisation set
    inputBinding:
      position: 101
      prefix: --i
  - id: particles
    type:
      - 'null'
      - File
    doc: Particle set
    inputBinding:
      position: 101
      prefix: --p
  - id: tomograms
    type:
      - 'null'
      - File
    doc: Tomogram set
    inputBinding:
      position: 101
      prefix: --t
  - id: motion
    type:
      - 'null'
      - File
    doc: Particle trajectories set
    inputBinding:
      position: 101
      prefix: --mot
  - id: ref1
    type:
      - 'null'
      - File
    doc: Reference map, half 1
    inputBinding:
      position: 101
      prefix: --ref1
  - id: ref2
    type:
      - 'null'
      - File
    doc: Reference map, half 2
    inputBinding:
      position: 101
      prefix: --ref2
  - id: mask
    type:
      - 'null'
      - File
    doc: Reference mask
    inputBinding:
      position: 101
      prefix: --mask
  - id: fsc
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
  - id: max_it
    type:
      - 'null'
      - float
    doc: 'Maximum number of iterations (RELION default: 300)'
    inputBinding:
      position: 101
      prefix: --max_it
  - id: dose_cutoff
    type:
      - 'null'
      - float
    doc: 'Neglect pixels with a smaller dose weight (RELION default: 0.05)'
    inputBinding:
      position: 101
      prefix: --dose_cutoff
  - id: eps
    type:
      - 'null'
      - float
    doc: 'Optimisation change threshold (RELION default: 1e-5)'
    inputBinding:
      position: 101
      prefix: --eps
  - id: xtol
    type:
      - 'null'
      - float
    doc: 'Optimisation gradient threshold (RELION default: 1e-4)'
    inputBinding:
      position: 101
      prefix: --xtol
  - id: verbose_opt
    type:
      - 'null'
      - boolean
    doc: Print out the cost function after each iteration (for the first thread)
    inputBinding:
      position: 101
      prefix: --verbose_opt
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
stdout: relion_relion_tomo_local_particle_refine.out
