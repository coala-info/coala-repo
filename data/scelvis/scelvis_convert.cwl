cwlVersion: v1.2
class: CommandLineTool
baseCommand: scelvis_convert
label: scelvis_convert
doc: "Convert scELVIS output to .h5ad format.\n\nTool homepage: https://github.com/bihealth/scelvis"
inputs:
  - id: about_md
    type:
      - 'null'
      - File
    doc: Path to about.md file to embed in the resulting .h5ad file
    inputBinding:
      position: 101
      prefix: --about-md
  - id: format
    type:
      - 'null'
      - string
    doc: input format
    inputBinding:
      position: 101
      prefix: --format
  - id: input_dir
    type: Directory
    doc: path to input/pipeline output directory
    inputBinding:
      position: 101
      prefix: --input-dir
  - id: markers
    type:
      - 'null'
      - File
    doc: Path to markers.tsv file to embed in the resulting .h5ad file
    inputBinding:
      position: 101
      prefix: --markers
  - id: ncells
    type:
      - 'null'
      - int
    doc: sample ncells cells from object
    inputBinding:
      position: 101
      prefix: --ncells
  - id: nmarkers
    type:
      - 'null'
      - int
    doc: Save top n markers per cluster
    inputBinding:
      position: 101
      prefix: --nmarkers
  - id: split_samples
    type:
      - 'null'
      - boolean
    doc: split samples according to summary.json file produced by cellranger 
      aggr
    inputBinding:
      position: 101
      prefix: --split-samples
  - id: split_species
    type:
      - 'null'
      - boolean
    doc: Split species
    inputBinding:
      position: 101
      prefix: --split-species
  - id: use_raw
    type:
      - 'null'
      - boolean
    doc: Do not normalize expression values (use raw counts)
    inputBinding:
      position: 101
      prefix: --use-raw
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output_file
    type: File
    doc: Path to the .h5ad file to write to
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scelvis:0.8.9--pyhdfd78af_0
