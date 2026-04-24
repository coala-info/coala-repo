cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hotspot3d
  - prior
label: hotspot3d_prior
doc: "Calculate prior probabilities for Hotspot3D analysis\n\nTool homepage: https://github.com/ding-lab/hotspot3d"
inputs:
  - id: d_distance_cutoff
    type:
      - 'null'
      - float
    doc: 3D distance cutoff (<= Angstroms)
    inputBinding:
      position: 101
      prefix: --3d-distance-cutoff
  - id: linear_cutoff
    type:
      - 'null'
      - int
    doc: Linear distance cutoff (> peptides)
    inputBinding:
      position: 101
      prefix: --linear-cutoff
  - id: p_value_cutoff
    type:
      - 'null'
      - float
    doc: p_value cutoff(<=)
    inputBinding:
      position: 101
      prefix: --p-value-cutoff
outputs:
  - id: output_dir
    type: Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hotspot3d:1.8.2--pl526_0
