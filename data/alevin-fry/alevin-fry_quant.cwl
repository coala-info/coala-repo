cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - alevin-fry
  - quant
label: alevin-fry_quant
doc: "Quantify expression from a collated RAD file\n\nTool homepage: https://github.com/COMBINE-lab/alevin-fry"
inputs:
  - id: dump_eqclasses
    type:
      - 'null'
      - boolean
    doc: flag for dumping equivalence classes
    inputBinding:
      position: 101
      prefix: --dump-eqclasses
  - id: init_uniform
    type:
      - 'null'
      - boolean
    doc: flag for uniform sampling
    inputBinding:
      position: 101
      prefix: --init-uniform
  - id: input_dir
    type: Directory
    doc: input directory containing collated RAD file
    inputBinding:
      position: 101
      prefix: --input-dir
  - id: num_bootstraps
    type:
      - 'null'
      - int
    doc: number of bootstraps to use
    inputBinding:
      position: 101
      prefix: --num-bootstraps
  - id: quant_subset
    type:
      - 'null'
      - File
    doc: file containing list of barcodes to quantify, those not in this list will
      be ignored
    inputBinding:
      position: 101
      prefix: --quant-subset
  - id: resolution
    type: string
    doc: 'the resolution strategy by which molecules will be counted [possible values:
      trivial, cr-like, cr-like-em, parsimony-em, parsimony, parsimony-gene-em, parsimony-gene]'
    inputBinding:
      position: 101
      prefix: --resolution
  - id: summary_stat
    type:
      - 'null'
      - boolean
    doc: flag for storing only summary statistics
    inputBinding:
      position: 101
      prefix: --summary-stat
  - id: tg_map
    type: File
    doc: transcript to gene map
    inputBinding:
      position: 101
      prefix: --tg-map
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads to use for processing
    inputBinding:
      position: 101
      prefix: --threads
  - id: use_eds
    type:
      - 'null'
      - boolean
    doc: flag for writing output matrix in EDS format
    inputBinding:
      position: 101
      prefix: --use-eds
  - id: use_mtx
    type:
      - 'null'
      - boolean
    doc: flag for writing output matrix in matrix market format (default)
    inputBinding:
      position: 101
      prefix: --use-mtx
outputs:
  - id: output_dir
    type: Directory
    doc: output directory where quantification results will be written
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/alevin-fry:0.11.2--ha6fb395_0
