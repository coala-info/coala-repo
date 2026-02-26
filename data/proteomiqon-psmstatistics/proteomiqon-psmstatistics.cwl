cwlVersion: v1.2
class: CommandLineTool
baseCommand: ProteomIQon.PSMStatistics
label: proteomiqon-psmstatistics
doc: "Compute PSM statistics and score peptide spectrum matches.\n\nTool homepage:
  https://csbiology.github.io/ProteomIQon/"
inputs:
  - id: diagnostic_charts
    type:
      - 'null'
      - boolean
    doc: Set to save diagnostic charts to the output directory.
    inputBinding:
      position: 101
      prefix: --diagnosticcharts
  - id: log_level
    type:
      - 'null'
      - string
    doc: Set the log level.
    inputBinding:
      position: 101
      prefix: --log-level
  - id: parallelism_level
    type:
      - 'null'
      - int
    doc: Set the number of cores the programm can use. Parallelization occurs on
      file level. This flag is only of effect if a input directory (-i) is 
      specified.
    inputBinding:
      position: 101
      prefix: --parallelism-level
  - id: param_file
    type: File
    doc: Specify parameter file for computation of psm statistics.
    inputBinding:
      position: 101
      prefix: --paramfile
  - id: peptide_database
    type: File
    doc: Specify the file path of the peptide data base.
    inputBinding:
      position: 101
      prefix: --peptidedatabase
  - id: psms
    type:
      type: array
      items: File
    doc: Specify the peptide spectum matches (PSMs) to be scored, either specify
      a file directory containing the files to be analyzed or specify the file 
      path of a single .psm file.
    inputBinding:
      position: 101
      prefix: --psms
  - id: verbosity_level
    type:
      - 'null'
      - string
    doc: Set the verbosity level.
    inputBinding:
      position: 101
      prefix: --verbosity-level
outputs:
  - id: output_directory
    type: Directory
    doc: Specify the output directory.
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/proteomiqon-psmstatistics:0.0.8--hdfd78af_0
