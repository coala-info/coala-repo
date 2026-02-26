cwlVersion: v1.2
class: CommandLineTool
baseCommand: ProteomIQon.PSMBasedQuantification
label: proteomiqon-psmbasedquantification
doc: "Performs PSM-based quantification using mass spectrometry output, scored PSMs,
  and a peptide database.\n\nTool homepage: https://csbiology.github.io/ProteomIQon/"
inputs:
  - id: diagnosticcharts
    type:
      - 'null'
      - boolean
    doc: Set to save diagnostic charts to the output directory.
    inputBinding:
      position: 101
      prefix: --diagnosticcharts
  - id: instrumentoutput
    type:
      type: array
      items: File
    doc: Specify the mass spectrometry output, either specify a file directory 
      containing the files to be analyzed or specify the file path of a single 
      mzlite file.
    inputBinding:
      position: 101
      prefix: --instrumentoutput
  - id: log_level
    type:
      - 'null'
      - string
    doc: Set the log level.
    inputBinding:
      position: 101
      prefix: --log-level
  - id: matchfiles
    type:
      - 'null'
      - boolean
    doc: If this flag is set the files specified by InstrumentOutput and 
      ScoredPSMs are matched according to their file name, otherwise they are 
      matched by their position in the input lists.
    inputBinding:
      position: 101
      prefix: --matchfiles
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
  - id: paramfile
    type: File
    doc: Specify parameter file for peptide spectrum matching.
    inputBinding:
      position: 101
      prefix: --paramfile
  - id: peptidedatabase
    type: File
    doc: Specify the file path of the peptide data base.
    inputBinding:
      position: 101
      prefix: --peptidedatabase
  - id: scoredpsms
    type:
      type: array
      items: File
    doc: Specify the scored peptide spectrum matches, either specify a file 
      directory containing the files to be analyzed or specify the file path of 
      a single qpsm file. If InstrumentOutPut(i) and ScoredPSMs (ii) both 
      reference a directory the files are automatically aligned by their file 
      name.
    inputBinding:
      position: 101
      prefix: --scoredpsms
  - id: verbosity_level
    type:
      - 'null'
      - string
    doc: Set the verbosity level.
    inputBinding:
      position: 101
      prefix: --verbosity-level
  - id: zipcharts
    type:
      - 'null'
      - boolean
    doc: Set to zip the diagnostic charts.
    inputBinding:
      position: 101
      prefix: --zipcharts
outputs:
  - id: outputdirectory
    type: Directory
    doc: Specify the output directory.
    outputBinding:
      glob: $(inputs.outputdirectory)
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/proteomiqon-psmbasedquantification:0.0.9--hdfd78af_0
