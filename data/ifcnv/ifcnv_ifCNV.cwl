cwlVersion: v1.2
class: CommandLineTool
baseCommand: ifcnv_ifCNV
label: ifcnv_ifCNV
doc: "ifCNV\n\nTool homepage: https://github.com/SimCab-CHU/ifCNV"
inputs:
  - id: auto_open
    type:
      - 'null'
      - boolean
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
      - float
    doc: Contamination parameter for the AberrantSamples function
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
    default: fast or extensive
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
      - boolean
    doc: A boolean, if True, saves the results in a .tsv file
    inputBinding:
      position: 101
      prefix: --save
  - id: score_threshold
    type:
      - 'null'
      - float
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
      - boolean
    doc: A boolean
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output_report
    type: File
    doc: Path to the output report
    outputBinding:
      glob: $(inputs.output_report)
  - id: reads_matrix_output
    type:
      - 'null'
      - File
    doc: A path to a file to export the reads matrix as a .tsv file
    outputBinding:
      glob: $(inputs.reads_matrix_output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ifcnv:0.2.1--pyh5e36f6f_0
