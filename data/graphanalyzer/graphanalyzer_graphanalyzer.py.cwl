cwlVersion: v1.2
class: CommandLineTool
baseCommand: graphanalyzer.py
label: graphanalyzer_graphanalyzer.py
doc: "This script automatically parse vConTACT2 outputs when using INPHARED as database.\n\
  \nTool homepage: https://github.com/lazzarigioele/graphanalyzer"
inputs:
  - id: csv
    type: File
    doc: The genome_by_genome_overview.csv output file from vConTACT2.
    inputBinding:
      position: 101
      prefix: --csv
  - id: graph
    type: File
    doc: The c1.ntw output file from vConTACT2.
    inputBinding:
      position: 101
      prefix: --graph
  - id: metas
    type: File
    doc: The data_excluding_refseq.tsv file from INPHARED.
    inputBinding:
      position: 101
      prefix: --metas
  - id: pickle
    type:
      - 'null'
      - File
    doc: Filepath to the pickle object, needed to enter directly to the 
      interactive plots generation step
    default: None
    inputBinding:
      position: 101
      prefix: --pickle
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix of the header of each conting representing a vOTU
    default: vOTU
    inputBinding:
      position: 101
      prefix: --prefix
  - id: suffix
    type:
      - 'null'
      - string
    doc: Suffix to append to every file produced in the output directory
    default: assemblerX
    inputBinding:
      position: 101
      prefix: --suffix
  - id: threads
    type:
      - 'null'
      - int
    doc: Define how many threads to use for the generation of the interactive 
      subgraphs
    default: 4
    inputBinding:
      position: 101
      prefix: --threads
  - id: view
    type:
      - 'null'
      - string
    doc: Whether to produce interactive subgraphs in 2 ('2d') or 3 dimensions 
      ('3d')
    default: 2d
    inputBinding:
      position: 101
      prefix: --view
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Path to the output directory
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/graphanalyzer:1.6.0--hdfd78af_0
