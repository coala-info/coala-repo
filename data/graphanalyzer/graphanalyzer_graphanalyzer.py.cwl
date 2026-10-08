cwlVersion: v1.2
class: CommandLineTool
baseCommand: graphanalyzer.py
label: graphanalyzer_graphanalyzer.py
doc: "This script automatically parse vConTACT2 outputs when using INPHARED as database.\n\
  \nTool homepage: https://github.com/lazzarigioele/graphanalyzer"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.output)
        entry: '$({"class": "Directory", "listing": []})'
        writable: true
inputs:
  - id: graph
    type: File
    doc: The c1.ntw output file from vConTACT2.
    inputBinding:
      position: 101
      prefix: --graph
  - id: csv
    type: File
    doc: The genome_by_genome_overview.csv output file from vConTACT2.
    inputBinding:
      position: 101
      prefix: --csv
  - id: metas
    type: File
    doc: The data_excluding_refseq.tsv file from INPHARED.
    inputBinding:
      position: 101
      prefix: --metas
  - id: output
    type: string
    default: graphanalyzer_out
    doc: Path to the output directory (created before the run; the tool needs a
      trailing slash, which the wrapper adds).
    inputBinding:
      position: 101
      prefix: --output
      valueFrom: $(self)/
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix of the header of each conting representing a vOTU (default is vOTU).
    inputBinding:
      position: 101
      prefix: --prefix
  - id: suffix
    type:
      - 'null'
      - string
    doc: Suffix to append to every file produced in the output directory (default
      is assemblerX).
    inputBinding:
      position: 101
      prefix: --suffix
  - id: threads
    type:
      - 'null'
      - int
    doc: Define how many threads to use for the generation of the interactive subgraphs
      (default is 4).
    inputBinding:
      position: 101
      prefix: --threads
  - id: pickle
    type:
      - 'null'
      - File
    doc: Filepath to the pickle object, needed to enter directly to the interactive
      plots generation step
    inputBinding:
      position: 101
      prefix: --pickle
  - id: view
    type:
      - 'null'
      - string
    doc: Whether to produce interactive subgraphs in 2 ('2d') or 3 dimensions ('3d')
      (default is '2d').
    inputBinding:
      position: 101
      prefix: --view
outputs:
  - id: output_dir
    type: Directory
    doc: Output directory with the vOTU taxonomy tables and interactive subgraphs
    outputBinding:
      glob: $(inputs.output)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/graphanalyzer:1.6.0--hdfd78af_0
stdout: graphanalyzer_graphanalyzer.py.out
