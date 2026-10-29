cwlVersion: v1.2
class: CommandLineTool
baseCommand: relion_tomo_make_optimisation_set
label: relion_relion_tomo_make_optimisation_set
doc: "Combine tomogram, particle, trajectory, manifold and reference files into one optimisation set STAR\
  \ file.\n\nTool homepage: https://github.com/3dem/relion"
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
  - id: output
    type: string
    doc: Output file name
    inputBinding:
      position: 101
      prefix: --o
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
  - id: manifolds_set
    type:
      - 'null'
      - File
    doc: Manifolds set
    inputBinding:
      position: 101
      prefix: --man
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
  - id: staged_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Extra files that the input STAR file names (images, micrographs, maps, coordinate files). They
      are staged in the working directory so that the relative names in the STAR file resolve.
outputs:
  - id: optimisation_set_out
    type: File
    doc: Optimisation set STAR file
    outputBinding:
      glob: $(inputs.output)
  - id: log
    type: stdout
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/relion:5.0.1--h6e3b700_0
stdout: relion_relion_tomo_make_optimisation_set.out
