cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hotspot3d
  - prep
label: hotspot3d_prep
doc: "Preparation step for Hotspot3D to generate proximity files and perform various
  analysis steps.\n\nTool homepage: https://github.com/ding-lab/hotspot3d"
inputs:
  - id: blat
    type:
      - 'null'
      - File
    doc: Installation of blat to use for trans (defaults to your system default)
    inputBinding:
      position: 101
      prefix: --blat
  - id: grch
    type:
      - 'null'
      - int
    doc: Genome build (37 or 38), defaults to 38 or according to --release input
    default: 38
    inputBinding:
      position: 101
      prefix: --grch
  - id: linear_cutoff
    type:
      - 'null'
      - int
    doc: Linear distance cutoff (> peptides) for prior
    default: 0
    inputBinding:
      position: 101
      prefix: --linear-cutoff
  - id: p_value_cutoff
    type:
      - 'null'
      - float
    doc: p_value cutoff(<=) for prior
    default: 0.05
    inputBinding:
      position: 101
      prefix: --p-value-cutoff
  - id: release
    type:
      - 'null'
      - int
    doc: Ensembl release verion (55-87), defaults to 87 or to the latest release
      according to --grch input. Note that releases 55-75 correspond to GRCh37 &
      76-87 correspond to GRCh38
    default: 87
    inputBinding:
      position: 101
      prefix: --release
  - id: start
    type:
      - 'null'
      - string
    doc: What step to start on ( calroi , statis , anno , trans , cosmic , prior
      )
    default: calroi
    inputBinding:
      position: 101
      prefix: --start
  - id: three_d_distance_cutoff
    type:
      - 'null'
      - int
    doc: 3D distance cutoff (<= Angstroms) for prior
    default: 20
    inputBinding:
      position: 101
      prefix: --3d-distance-cutoff
outputs:
  - id: output_dir
    type: Directory
    doc: Output directory of proximity files
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hotspot3d:1.8.2--pl526_0
