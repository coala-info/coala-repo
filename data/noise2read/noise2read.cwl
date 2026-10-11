cwlVersion: v1.2
class: CommandLineTool
baseCommand: noise2read
label: noise2read
doc: "Noise2Read is a tool for denoising sequencing data. It corrects errors in short
  reads (amplicon, miRNA, UMI and other data) with a graph and machine learning
  model.\n\nTool homepage: https://github.com/Jappy0/noise2read"
inputs:
  - id: module
    type: string
    doc: "module selection: correction, amplicon_correction, umi_correction, mimic_umi,
      real_umi, evaluation or simulation"
    inputBinding:
      position: 1
      prefix: -m
  - id: config
    type:
      - 'null'
      - File
    doc: input configuration file (use this or input)
    inputBinding:
      position: 2
      prefix: -c
  - id: input
    type:
      - 'null'
      - File
    doc: input raw data to be corrected (fastq, fasta, fa or fq)
    inputBinding:
      position: 2
      prefix: -i
  - id: umi_file
    type:
      - 'null'
      - File
    doc: UMI file (the umi_file option, short form -u)
    inputBinding:
      position: 2
      prefix: -u
  - id: output_directory
    type:
      - 'null'
      - string
    doc: set output directory (a trailing slash is added)
    inputBinding:
      position: 3
      prefix: -d
      valueFrom: $(self + "/")
  - id: high_ambiguous
    type:
      - 'null'
      - string
    doc: "predict high ambiguous errors using machine learning, True or False (default
      True)"
    inputBinding:
      position: 3
      prefix: -a
  - id: ground_truth
    type:
      - 'null'
      - File
    doc: input ground truth data if you have
    inputBinding:
      position: 3
      prefix: -t
  - id: rectification
    type:
      - 'null'
      - File
    doc: input corrected data when using module evaluation
    inputBinding:
      position: 3
      prefix: -r
  - id: parallel
    type:
      - 'null'
      - int
    doc: use multiple cpu cores, default total cpu cores - 2
    inputBinding:
      position: 3
      prefix: -p
  - id: tree_method
    type:
      - 'null'
      - string
    doc: use gpu for training and prediction, default auto, (options gpu_hist,
      hist, auto)
    inputBinding:
      position: 3
      prefix: -g
outputs:
  - id: output_directory_dir
    type:
      - 'null'
      - Directory
    doc: output directory with the corrected reads, tables and plots
    outputBinding:
      glob: $(inputs.output_directory)
  - id: log_files
    type:
      type: array
      items: File
    doc: Log file written to the working directory
    outputBinding:
      glob: '*noise2read.log'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/noise2read:0.3.0--pyhdfd78af_0
