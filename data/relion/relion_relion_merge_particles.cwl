cwlVersion: v1.2
class: CommandLineTool
baseCommand: relion_merge_particles
label: relion_relion_merge_particles
doc: "Merge several particle STAR files into one STAR file.\n\nTool homepage: https://github.com/3dem/relion"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.staged_files)
inputs:
  - id: input_stars
    type:
      type: array
      items: File
    doc: Input particle STAR files
    inputBinding:
      position: 1
  - id: output_name
    type: string
    doc: Output STAR file name
    inputBinding:
      position: 2
    default: merged.star
  - id: staged_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Extra files that the input STAR file names (images, micrographs, maps, coordinate files). They
      are staged in the working directory so that the relative names in the STAR file resolve.
outputs:
  - id: merged_star
    type: File
    doc: Merged STAR file
    outputBinding:
      glob: $(inputs.output_name)
  - id: log
    type: stdout
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/relion:5.0.1--h6e3b700_0
stdout: relion_relion_merge_particles.out
