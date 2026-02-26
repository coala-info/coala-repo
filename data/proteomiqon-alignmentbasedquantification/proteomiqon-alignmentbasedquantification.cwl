cwlVersion: v1.2
class: CommandLineTool
baseCommand: ProteomIQon.AlignmentBasedQuantification
label: proteomiqon-alignmentbasedquantification
doc: "Performs alignment-based quantification of proteomic data.\n\nTool homepage:
  https://csbiology.github.io/ProteomIQon/"
inputs:
  - id: alignedpeptides
    type: File
    doc: Specify the aligned peptide spectrum matches, either specify a file 
      directory containing the files to be analyzed or specify the file path of 
      a single qpsm file. If InstrumentOutPut(i) and ScoredPSMs (ii) both 
      reference a directory the files are automatically aligned by their file 
      name.
    inputBinding:
      position: 101
      prefix: --alignedpeptides
  - id: diagnosticcharts
    type:
      - 'null'
      - boolean
    doc: Set to save diagnostic charts to the output directory.
    inputBinding:
      position: 101
      prefix: --diagnosticcharts
  - id: instrumentoutput
    type: Directory
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
    doc: If this flag is set the files specified by InstrumentOutput, 
      AlignedPeptides, Metrics and QuantifiedPeptides are matched according to 
      their file name, otherwise they are matched by their position in the input
      lists.
    inputBinding:
      position: 101
      prefix: --matchfiles
  - id: metrics
    type: File
    doc: Specify the .alignmetrics file used to assess false positive 
      alignments, either specify a file directory containing the files to be 
      analyzed or specify the file path of a single qpsm file. If 
      InstrumentOutPut(i) and ScoredPSMs (ii) both reference a directory the 
      files are automatically aligned by their file name.
    inputBinding:
      position: 101
      prefix: --metrics
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
  - id: quantifiedpeptides
    type: Directory
    doc: Specify quantified peptides, specify a directory containing .quant 
      files.
    inputBinding:
      position: 101
      prefix: --quantifiedpeptides
  - id: verbosity_level
    type:
      - 'null'
      - string
    doc: Set the verbosity level.
    inputBinding:
      position: 101
      prefix: --verbosity-level
outputs:
  - id: outputdirectory
    type: Directory
    doc: Specify the output directory.
    outputBinding:
      glob: $(inputs.outputdirectory)
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/proteomiqon-alignmentbasedquantification:0.0.2--hdfd78af_0
