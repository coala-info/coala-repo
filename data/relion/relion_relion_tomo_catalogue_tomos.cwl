cwlVersion: v1.2
class: CommandLineTool
baseCommand: relion_tomo_catalogue_tomos
label: relion_relion_tomo_catalogue_tomos
doc: "Write a catalogue (images and statistics) of the tomograms listed in a tomogram list file.\n\nTool\
  \ homepage: https://github.com/3dem/relion"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.staged_files)
inputs:
  - id: tomogram_list
    type: File
    doc: Tomogram list
    inputBinding:
      position: 101
      prefix: --t
  - id: output
    type: string
    doc: Output filename pattern
    inputBinding:
      position: 101
      prefix: --o
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of threads (RELION default: 6)'
    inputBinding:
      position: 101
      prefix: --j
  - id: bin
    type:
      - 'null'
      - float
    doc: 'Binning factor (RELION default: 8)'
    inputBinding:
      position: 101
      prefix: --bin
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
    doc: Catalogue files written with the output filename pattern
    outputBinding:
      glob: $(inputs.output)*
  - id: log
    type: stdout
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/relion:5.0.1--h6e3b700_0
stdout: relion_relion_tomo_catalogue_tomos.out
