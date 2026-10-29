cwlVersion: v1.2
class: CommandLineTool
baseCommand: relion_estimate_gain
label: relion_relion_estimate_gain
doc: "Estimate a gain reference from a set of movies.\n\nTool homepage: https://github.com/3dem/relion"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.staged_files)
inputs:
  - id: input
    type: File
    doc: Input movie STAR file
    inputBinding:
      position: 101
      prefix: --i
  - id: output
    type: string
    doc: Output file name
    inputBinding:
      position: 101
      prefix: --o
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of threads (RELION default: 1)'
    inputBinding:
      position: 101
      prefix: --j
  - id: max_frames
    type:
      - 'null'
      - int
    doc: 'Target number of frames to average (rounded to movies; -1 means use all) (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --max_frames
  - id: random
    type:
      - 'null'
      - boolean
    doc: Randomise the order of input movies before taking subset
    inputBinding:
      position: 101
      prefix: --random
  - id: dont_invert
    type:
      - 'null'
      - boolean
    doc: Don't take the inverse but simply writes the sum
    inputBinding:
      position: 101
      prefix: --dont_invert
  - id: eer_upsampling
    type:
      - 'null'
      - int
    doc: 'EER upsampling (1 = physical or 2 = 2x super-resolution) (RELION default: 2)'
    inputBinding:
      position: 101
      prefix: --eer_upsampling
  - id: staged_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Extra files that the input STAR file names (images, micrographs, maps, coordinate files). They
      are staged in the working directory so that the relative names in the STAR file resolve.
outputs:
  - id: gain_reference
    type: File
    doc: Estimated gain reference image
    outputBinding:
      glob: $(inputs.output)
  - id: log
    type: stdout
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/relion:5.0.1--h6e3b700_0
stdout: relion_relion_estimate_gain.out
