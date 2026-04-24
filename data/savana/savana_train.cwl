cwlVersion: v1.2
class: CommandLineTool
baseCommand: savana train
label: savana_train
doc: "Train the model to predict germline and somatic variants (GERMLINE label must
  be present)\n\nTool homepage: https://github.com/cortes-ciriano-lab/savana"
inputs:
  - id: germline_class
    type:
      - 'null'
      - boolean
    doc: Train the model to predict germline and somatic variants (GERMLINE 
      label must be present)
    inputBinding:
      position: 101
      prefix: --germline_class
  - id: load_matrix
    type:
      - 'null'
      - File
    doc: Pre-loaded pickle file of VCFs
    inputBinding:
      position: 101
      prefix: --load_matrix
  - id: outdir
    type: Directory
    doc: Output directory (can exist but must be empty)
    inputBinding:
      position: 101
      prefix: --outdir
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Use this flag to write to output directory even if files are present
    inputBinding:
      position: 101
      prefix: --overwrite
  - id: recursive
    type:
      - 'null'
      - boolean
    doc: Search recursively through input folder for input VCFs (default only 
      one-level deep)
    inputBinding:
      position: 101
      prefix: --recursive
  - id: test_split
    type:
      - 'null'
      - float
    doc: Fraction of data to use for test (default=0.2)
    inputBinding:
      position: 101
      prefix: --test_split
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 101
      prefix: --threads
  - id: tumour_only
    type:
      - 'null'
      - boolean
    doc: Training a model on tumour-only data
    inputBinding:
      position: 101
      prefix: --tumour_only
  - id: vcfs
    type:
      - 'null'
      - Directory
    doc: Folder of labelled VCF files to read in
    inputBinding:
      position: 101
      prefix: --vcfs
outputs:
  - id: save_matrix
    type:
      - 'null'
      - File
    doc: Output pickle file for data matrix of VCFs
    outputBinding:
      glob: $(inputs.save_matrix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/savana:1.3.6--pyhdfd78af_0
