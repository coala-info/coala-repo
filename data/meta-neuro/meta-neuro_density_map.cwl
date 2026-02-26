cwlVersion: v1.2
class: CommandLineTool
baseCommand: density_map
label: meta-neuro_density_map
doc: "Convert streamlines of white matter bundle into a density map and binary mask.\n\
  \nTool homepage: https://github.com/bagari/meta"
inputs:
  - id: reference
    type: File
    doc: Path to the reference image
    inputBinding:
      position: 101
      prefix: --reference
  - id: tractogram
    type: File
    doc: Path to the bundle file containing streamlines
    inputBinding:
      position: 101
      prefix: --tractogram
outputs:
  - id: output
    type: File
    doc: Path to the output binary mask file
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/meta-neuro:2.0.1--py313h47f2c4e_0
