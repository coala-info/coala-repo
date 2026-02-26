cwlVersion: v1.2
class: CommandLineTool
baseCommand: ProteomIQon.MzMLToMzLite
label: proteomiqon-mzmltomzlite
doc: "Converts mzML files to MzLite format.\n\nTool homepage: https://csbiology.github.io/ProteomIQon/"
inputs:
  - id: instrument_output
    type:
      - 'null'
      - type: array
        items: File
    doc: specify mass spectrometry Output
    inputBinding:
      position: 101
      prefix: --instrumentoutput
  - id: log_level
    type:
      - 'null'
      - string
    doc: set the log level.
    inputBinding:
      position: 101
      prefix: --log-level
  - id: output_directory
    type: Directory
    doc: specify output directory
    inputBinding:
      position: 101
      prefix: --outputdirectory
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
    doc: specify param file For centroidization
    inputBinding:
      position: 101
      prefix: --paramfile
  - id: verbosity_level
    type:
      - 'null'
      - string
    doc: set the verbosity level.
    inputBinding:
      position: 101
      prefix: --verbosity-level
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/proteomiqon-mzmltomzlite:0.0.8--hdfd78af_0
stdout: proteomiqon-mzmltomzlite.out
