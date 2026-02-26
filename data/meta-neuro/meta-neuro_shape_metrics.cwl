cwlVersion: v1.2
class: CommandLineTool
baseCommand: shape_metrics
label: meta-neuro_shape_metrics
doc: "Extract shape features from white matter bundle streamlines\n\nTool homepage:
  https://github.com/bagari/meta"
inputs:
  - id: bundle
    type: string
    doc: White matter bundle name
    inputBinding:
      position: 101
      prefix: --bundle
  - id: mask
    type: File
    doc: Binary image of white matter bundle
    inputBinding:
      position: 101
      prefix: --mask
  - id: subject
    type: string
    doc: Subject ID
    inputBinding:
      position: 101
      prefix: --subject
  - id: tractogram
    type: File
    doc: Streamline file of white matter bundle
    inputBinding:
      position: 101
      prefix: --tractogram
outputs:
  - id: output
    type: Directory
    doc: Output directory to save features
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/meta-neuro:2.0.1--py313h47f2c4e_0
