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
    inputBinding:
      position: 101
      prefix: --grch
  - id: linear_cutoff
    type:
      - 'null'
      - int
    doc: Linear distance cutoff (> peptides) for prior
    inputBinding:
      position: 101
      prefix: --linear-cutoff
  - id: p_value_cutoff
    type:
      - 'null'
      - float
    doc: p_value cutoff(<=) for prior
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
    inputBinding:
      position: 101
      prefix: --release
  - id: start
    type:
      - 'null'
      - string
    doc: What step to start on ( calroi , statis , anno , trans , cosmic , prior
      )
    inputBinding:
      position: 101
      prefix: --start
  - id: three_d_distance_cutoff
    type:
      - 'null'
      - int
    doc: 3D distance cutoff (<= Angstroms) for prior
    inputBinding:
      position: 101
      prefix: --3d-distance-cutoff
  - id: prep_dir
    type: Directory
    doc: Output directory of proximity files (the preprocessing directory; it is updated
      in place)
    inputBinding:
      position: 102
      prefix: --output-dir
      valueFrom: $(self.basename)
outputs:
  - id: updated_prep_dir
    type: Directory
    doc: Updated preprocessing directory
    outputBinding:
      glob: $(inputs.prep_dir.basename)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.prep_dir)
        writable: true
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hotspot3d:1.8.2--pl526_0
