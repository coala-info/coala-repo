cwlVersion: v1.2
class: CommandLineTool
baseCommand: ProteomIQon.JoinQuantPepIonsWithProteins
label: proteomiqon-joinquantpepionswithproteins
doc: "Joins quantified peptide information with inferred protein information.\n\n\
  Tool homepage: https://csbiology.github.io/ProteomIQon/"
inputs:
  - id: inferredproteins
    type:
      type: array
      items: File
    doc: Specify inferred proteins, specify either a directory containing or a 
      space separated list of .prot files.
    inputBinding:
      position: 101
      prefix: --inferredproteins
  - id: matchfiles
    type:
      - 'null'
      - boolean
    doc: If this flag is set the files specified using the QuantifiedPeptides 
      and InferredProteins are matched according to their file name, otherwise 
      they are matched by their position in the input lists.
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
  - id: quantifiedpeptides
    type:
      type: array
      items: File
    doc: Specify quantified peptides, specify either a directory containing or a
      space separated list of .quant files.
    inputBinding:
      position: 101
      prefix: --quantifiedpeptides
outputs:
  - id: outputdirectory
    type: Directory
    doc: Specify the output directory.
    outputBinding:
      glob: $(inputs.outputdirectory)
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/proteomiqon-joinquantpepionswithproteins:0.0.2--hdfd78af_1
