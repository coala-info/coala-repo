cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - metabuli
  - classifiedRefiner
label: metabuli_classifiedRefiner
doc: "Refine a read-by-read classification file: filter by taxon, adjust to a rank, add lineage columns, make a report.\n\nTool homepage: https://github.com/steineggerlab/Metabuli"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.classified_file)
        writable: true
inputs:
  - id: classified_file
    type: File
    doc: "Classified file (read-by-read classification result)"
    inputBinding:
      position: 1
  - id: taxonomy_dump
    type: Directory
    doc: "Taxonomy dump directory"
    inputBinding:
      position: 2
  - id: remove_unclassified
    type: 
      - 'null'
      - int
    doc: "Remove unclassified reads (BOOL: 0 or 1) [0]"
    inputBinding:
      position: 11
      prefix: --remove-unclassified
  - id: exclude_taxid
    type: 
      - 'null'
      - string
    doc: "Exclude taxId as well as its children"
    inputBinding:
      position: 12
      prefix: --exclude-taxid
  - id: select_taxid
    type: 
      - 'null'
      - string
    doc: "Select taxId as well as its children"
    inputBinding:
      position: 13
      prefix: --select-taxid
  - id: select_columns
    type: 
      - 'null'
      - string
    doc: "Select columns with number (7: full lineage, generated if absent)"
    inputBinding:
      position: 14
      prefix: --select-columns
  - id: report
    type: 
      - 'null'
      - int
    doc: "Make report of refined classification file (BOOL: 0 or 1) [0]"
    inputBinding:
      position: 15
      prefix: --report
  - id: rank
    type: 
      - 'null'
      - string
    doc: "Adjust classification to the specified rank"
    inputBinding:
      position: 16
      prefix: --rank
  - id: rank_file_type
    type: 
      - 'null'
      - int
    doc: "0: without higher rank, 1: with higher rank, 2: separate file for higher rank classification [0]"
    inputBinding:
      position: 17
      prefix: --rank-file-type
  - id: min_score
    type: 
      - 'null'
      - float
    doc: "Min. sequence similarity score (0.0-1.0) [0.000]"
    inputBinding:
      position: 18
      prefix: --min-score
  - id: threads
    type: 
      - 'null'
      - int
    doc: "Number of CPU-cores used (all by default) [20]"
    inputBinding:
      position: 100
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: refined
    type: File[]
    doc: "Refined classification files written beside the input (staged in the working directory)"
    outputBinding:
      glob: '*refined*'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metabuli:1.1.1--pl5321h0bb26bb_0
stdout: metabuli_classifiedRefiner.out
