cwlVersion: v1.2
class: CommandLineTool
baseCommand: relion_particle_select
label: relion_relion_particle_select
doc: "Select particles of one STAR file that are present in a reference STAR file; optionally copy angles\
  \ and offsets.\n\nTool homepage: https://github.com/3dem/relion"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.staged_files)
inputs:
  - id: input
    type: File
    doc: Input STAR file containing the source particles
    inputBinding:
      position: 101
      prefix: --i
  - id: i_ref
    type: File
    doc: Input STAR file containing reference particles
    inputBinding:
      position: 101
      prefix: --i_ref
  - id: angles
    type:
      - 'null'
      - boolean
    doc: Copy particle viewing angles from reference
    inputBinding:
      position: 101
      prefix: --angles
  - id: offsets
    type:
      - 'null'
      - boolean
    doc: Copy particle offsets from reference
    inputBinding:
      position: 101
      prefix: --offsets
  - id: output
    type:
      - 'null'
      - string
    doc: 'Output path (RELION default: selected.star)'
    inputBinding:
      position: 101
      prefix: --o
    default: selected.star
  - id: staged_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Extra files that the input STAR file names (images, micrographs, maps, coordinate files). They
      are staged in the working directory so that the relative names in the STAR file resolve.
outputs:
  - id: selected_star
    type: File
    doc: Selected particles STAR file
    outputBinding:
      glob: $(inputs.output)
  - id: log
    type: stdout
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/relion:5.0.1--h6e3b700_0
stdout: relion_relion_particle_select.out
