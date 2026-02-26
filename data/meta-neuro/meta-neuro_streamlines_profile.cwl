cwlVersion: v1.2
class: CommandLineTool
baseCommand: streamlines_profile
label: meta-neuro_streamlines_profile
doc: "Compute streamlines profile (average mean and point-wise) of a white matter
  bundle.\n\nTool homepage: https://github.com/bagari/meta"
inputs:
  - id: bundle
    type: string
    doc: White matter bundle name
    inputBinding:
      position: 101
      prefix: --bundle
  - id: map
    type: string
    doc: Brain microstructure map, e.g. FA, MD, etc.
    inputBinding:
      position: 101
      prefix: --map
  - id: mask
    type: File
    doc: Path to white matter bundle mask
    inputBinding:
      position: 101
      prefix: --mask
  - id: pointwise
    type:
      - 'null'
      - boolean
    doc: Save point-wise in HDF5 format
    inputBinding:
      position: 101
      prefix: --pointwise
  - id: subject
    type: string
    doc: Subject ID
    inputBinding:
      position: 101
      prefix: --subject
  - id: tractogram
    type: File
    doc: Streamlines of subject bundle
    inputBinding:
      position: 101
      prefix: --tractogram
outputs:
  - id: output
    type: Directory
    doc: Output directory to save extracted features
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/meta-neuro:2.0.1--py313h47f2c4e_0
