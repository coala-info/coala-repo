cwlVersion: v1.2
class: CommandLineTool
baseCommand: relion_pseudotomo_expansion
label: relion_relion_pseudotomo_expansion
doc: "Expand tomography particles into pseudo-subtomograms with per-particle motion (tomography STAR files).\n\
  \nTool homepage: https://github.com/3dem/relion"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.staged_files)
inputs:
  - id: particles
    type: File
    doc: Input particles STAR file
    inputBinding:
      position: 101
      prefix: --particles
  - id: tomograms
    type: File
    doc: Input tomography STAR file
    inputBinding:
      position: 101
      prefix: --tomograms
  - id: motion
    type: File
    doc: Input motions STAR file
    inputBinding:
      position: 101
      prefix: --motion
  - id: output
    type: string
    doc: Output STAR file
    inputBinding:
      position: 101
      prefix: --o
  - id: staged_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Extra files that the input STAR file names (images, micrographs, maps, coordinate files). They
      are staged in the working directory so that the relative names in the STAR file resolve.
outputs:
  - id: output_star
    type: File
    doc: Output STAR file
    outputBinding:
      glob: $(inputs.output)
  - id: log
    type: stdout
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/relion:5.0.1--h6e3b700_0
stdout: relion_relion_pseudotomo_expansion.out
