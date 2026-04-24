cwlVersion: v1.2
class: CommandLineTool
baseCommand: integron_finder
label: integron-finder
doc: "Search for integrons in genetic sequences (DNA).\n\nTool homepage: https://github.com/movingpictures83/IntegronFinder"
inputs:
  - id: input_file
    type: File
    doc: Input sequence file (FASTA format).
    inputBinding:
      position: 1
  - id: calin_threshold
    type:
      - 'null'
      - int
    doc: Threshold for CALIN (default is 2).
    inputBinding:
      position: 102
      prefix: --calin-threshold
  - id: cpu
    type:
      - 'null'
      - int
    doc: Number of CPUs to use.
    inputBinding:
      position: 102
      prefix: --cpu
  - id: func_annot
    type:
      - 'null'
      - boolean
    doc: Functional annotation of the protein coding genes (needs HMM profiles).
    inputBinding:
      position: 102
      prefix: --func-annot
  - id: keep_tmp
    type:
      - 'null'
      - boolean
    doc: Keep temporary files.
    inputBinding:
      position: 102
      prefix: --keep-tmp
  - id: linear
    type:
      - 'null'
      - boolean
    doc: Consider the sequence as linear.
    inputBinding:
      position: 102
      prefix: --linear
  - id: local_max
    type:
      - 'null'
      - boolean
    doc: Allows to find CALIN with a local maximum of probability.
    inputBinding:
      position: 102
      prefix: --local-max
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix for the output files.
    inputBinding:
      position: 102
      prefix: --prefix
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Disable progress bar and logging.
    inputBinding:
      position: 102
      prefix: --quiet
  - id: search_palist
    type:
      - 'null'
      - boolean
    doc: Search for Palistromic Integrons (PAI).
    inputBinding:
      position: 102
      prefix: --search-palist
  - id: topology
    type:
      - 'null'
      - string
    doc: Topology of the sequence (circular or linear).
    inputBinding:
      position: 102
      prefix: --topology
outputs:
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Output directory.
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/integron-finder:v1.5.1_cv2
