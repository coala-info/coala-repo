cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hotspot3d
  - search
label: hotspot3d_search
doc: "Search for proximity results using HotSpot3D preprocessing results\n\nTool homepage:
  https://github.com/ding-lab/hotspot3d"
inputs:
  - id: amino_acid_header
    type:
      - 'null'
      - string
    doc: MAF file column header for amino acid changes
    default: amino_acid_change
    inputBinding:
      position: 101
      prefix: --amino-acid-header
  - id: drugport_file
    type:
      - 'null'
      - File
    doc: DrugPort database parsing results file
    inputBinding:
      position: 101
      prefix: --drugport-file
  - id: linear_cutoff
    type:
      - 'null'
      - int
    doc: Linear distance cutoff (>= peptides)
    default: 0
    inputBinding:
      position: 101
      prefix: --linear-cutoff
  - id: maf_file
    type:
      - 'null'
      - File
    doc: Input MAF file used to search proximity results
    inputBinding:
      position: 101
      prefix: --maf-file
  - id: missense_only
    type:
      - 'null'
      - boolean
    doc: missense mutation only
    default: no
    inputBinding:
      position: 101
      prefix: --missense-only
  - id: p_value_cutoff
    type:
      - 'null'
      - float
    doc: p_value cutoff(<=)
    default: 0.05
    inputBinding:
      position: 101
      prefix: --p-value-cutoff
  - id: prep_dir
    type: Directory
    doc: HotSpot3D preprocessing results directory
    inputBinding:
      position: 101
      prefix: --prep-dir
  - id: site_file
    type:
      - 'null'
      - File
    doc: Protein site file (gene transcript position description)
    inputBinding:
      position: 101
      prefix: --site-file
  - id: skip_silent
    type:
      - 'null'
      - boolean
    doc: skip silent mutations
    default: no
    inputBinding:
      position: 101
      prefix: --skip-silent
  - id: three_d_distance_cutoff
    type:
      - 'null'
      - int
    doc: 3D distance cutoff (<=)
    default: 10
    inputBinding:
      position: 101
      prefix: --3d-distance-cutoff
  - id: transcript_id_header
    type:
      - 'null'
      - string
    doc: MAF file column header for transcript id's
    default: transcript_name
    inputBinding:
      position: 101
      prefix: --transcript-id-header
outputs:
  - id: output_prefix
    type:
      - 'null'
      - File
    doc: Prefix of output files
    outputBinding:
      glob: $(inputs.output_prefix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hotspot3d:1.8.2--pl526_0
