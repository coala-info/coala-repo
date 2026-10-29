cwlVersion: v1.2
class: CommandLineTool
baseCommand: relion_filament_selection
label: relion_relion_filament_selection
doc: "Select filament-like 2D classes by clustering class averages (dendrogram) and write the selected particles.\n\nTool homepage: https://github.com/3dem/relion"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.staged_files)
inputs:
  - id: input
    type: File
    doc: Input optimiser.star from 2D classification
    inputBinding:
      position: 101
      prefix: --input
  - id: output
    type: string
    doc: Output directory
    inputBinding:
      position: 101
      prefix: --output
  - id: threshold
    type:
      - 'null'
      - float
    doc: 'Dendrogram threshold (script default: 0.8)'
    inputBinding:
      position: 101
      prefix: --threshold
  - id: classmin
    type:
      - 'null'
      - int
    doc: 'Minimum number of particles per class; write out star files if positive (script default: -1)'
    inputBinding:
      position: 101
      prefix: --classmin
  - id: pipeline_control
    type:
      - 'null'
      - string
    doc: Needed to work together with the RELION GUI
    inputBinding:
      position: 101
      prefix: --pipeline_control
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
stdout: relion_relion_filament_selection.out
