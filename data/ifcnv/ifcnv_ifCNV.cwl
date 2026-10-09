cwlVersion: v1.2
class: CommandLineTool
baseCommand: ifCNV
label: ifcnv_ifCNV
doc: "ifCNV\n\nTool homepage: https://github.com/SimCab-CHU/ifCNV"
inputs:
  - id: auto_open
    type:
      - 'null'
      - string
    doc: A boolean
    inputBinding:
      position: 101
      prefix: --autoOpen
  - id: bed_file
    type: File
    doc: Path to the bed file
    inputBinding:
      position: 101
      prefix: --bed
  - id: conta_samples
    type:
      - 'null'
      - string
    doc: Contamination parameter for the AberrantSamples function (auto or a number; default auto)
    inputBinding:
      position: 101
      prefix: --contaSamples
  - id: conta_targets
    type:
      - 'null'
      - float
    doc: Contamination parameter for the AberrantTargets function
    inputBinding:
      position: 101
      prefix: --contaTargets
  - id: input_bam_folder
    type: Directory
    doc: Path to the input bam folder
    inputBinding:
      position: 101
      prefix: --input
  - id: lib_ressources
    type:
      - 'null'
      - Directory
    doc: Path where lib to import for report.
    inputBinding:
      position: 101
      prefix: --lib-ressources
  - id: min_reads
    type:
      - 'null'
      - int
    doc: Min mean reads per target
    inputBinding:
      position: 101
      prefix: --minReads
  - id: mode
    type:
      - 'null'
      - string
    doc: fast or extensive
    inputBinding:
      position: 101
      prefix: --mode
  - id: reg_sample
    type:
      - 'null'
      - string
    doc: A pattern for removing controls
    inputBinding:
      position: 101
      prefix: --regSample
  - id: reg_targets
    type:
      - 'null'
      - string
    doc: A pattern for removing targets
    inputBinding:
      position: 101
      prefix: --regTargets
  - id: run_name
    type:
      - 'null'
      - string
    doc: The name of the experiment
    inputBinding:
      position: 101
      prefix: --run
  - id: save_results
    type:
      - 'null'
      - string
    doc: A boolean given as a value (any non-empty text means True), if True, saves the results in a .tsv file
    inputBinding:
      position: 101
      prefix: --save
  - id: score_threshold
    type:
      - 'null'
      - int
    doc: Threshold on the localisation score
    inputBinding:
      position: 101
      prefix: --scoreThreshold
  - id: skip
    type:
      - 'null'
      - File
    doc: A path to the reads matrix
    inputBinding:
      position: 101
      prefix: --skip
  - id: verbose
    type:
      - 'null'
      - string
    doc: A boolean
    inputBinding:
      position: 101
      prefix: --verbose
  - id: output_report_path
    type:
      - 'null'
      - string
    doc: ' Path to the output report'
    inputBinding:
      position: 102
      prefix: --output
  - id: reads_matrix_output_path
    type:
      - 'null'
      - string
    doc: ' A path to a file to export the reads matrix as a .tsv file'
    inputBinding:
      position: 103
      prefix: -rm
outputs:
  - id: output_report
    type: Directory
    doc: Output report directory (run.html plus one html page per detected region)
    outputBinding:
      glob: $(inputs.output_report_path)
  - id: reads_matrix_output
    type:
      - 'null'
      - File
    doc: A path to a file to export the reads matrix as a .tsv file
    outputBinding:
      glob: $(inputs.reads_matrix_output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ifcnv:0.2.1--pyh5e36f6f_0
