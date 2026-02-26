cwlVersion: v1.2
class: CommandLineTool
baseCommand: ProteomIQon.AlignmentBasedQuantStatistics
label: proteomiqon-alignmentbasedquantstatistics
doc: "Performs alignment-based quantification statistics.\n\nTool homepage: https://csbiology.github.io/ProteomIQon/"
inputs:
  - id: align
    type:
      - 'null'
      - type: array
        items: File
    doc: Specify the align files or directory
    inputBinding:
      position: 101
      prefix: --align
  - id: alignedquant
    type:
      - 'null'
      - type: array
        items: File
    doc: Specify the aligned quant files or directory
    inputBinding:
      position: 101
      prefix: --alignedquant
  - id: alignedquantlearn
    type:
      - 'null'
      - type: array
        items: File
    doc: Specify the aligned quant files or directory for learning
    inputBinding:
      position: 101
      prefix: --alignedquantlearn
  - id: alignlearn
    type:
      - 'null'
      - type: array
        items: File
    doc: Specify the align files or directory for learning
    inputBinding:
      position: 101
      prefix: --alignlearn
  - id: diagnosticcharts
    type:
      - 'null'
      - boolean
    doc: Set to save diagnostic charts to the output directory.
    inputBinding:
      position: 101
      prefix: --diagnosticcharts
  - id: matchfiles
    type:
      - 'null'
      - boolean
    doc: If this flag is set the files specified by Quant, Align AlignedQuant 
      are matched according to their file name, otherwise they are matched by 
      their position in the input lists.
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
  - id: quant
    type:
      - 'null'
      - type: array
        items: File
    doc: Specify the quant files or directory
    inputBinding:
      position: 101
      prefix: --quant
  - id: quantlearn
    type:
      - 'null'
      - type: array
        items: File
    doc: Specify the quant files or directory for learning
    inputBinding:
      position: 101
      prefix: --quantlearn
outputs:
  - id: outputdirectory
    type: Directory
    doc: Specify the output directory.
    outputBinding:
      glob: $(inputs.outputdirectory)
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/proteomiqon-alignmentbasedquantstatistics:0.0.3--hdfd78af_0
