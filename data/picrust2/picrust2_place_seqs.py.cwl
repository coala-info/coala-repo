cwlVersion: v1.2
class: CommandLineTool
baseCommand: place_seqs.py
label: picrust2_place_seqs.py
doc: "Script to run EPA-ng and GAPPA to place study sequences (i.e. OTUs or ASVs) into a reference tree. This is typically done to prep for subsequent hidden-state prediction with PICRUSt2. Requires unaligned FASTA of study sequences. Users can specify a non-default reference files if needed.\n\nTool homepage: https://github.com/picrust/picrust2"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: study_fasta
    type: File
    doc: 'FASTA of unaligned study sequences. The headerline should be only one field.'
    inputBinding:
      position: 101
      prefix: --study_fasta
  - id: placement_tool
    type:
      - 'null'
      - string
    doc: 'Placement tool to use when placing sequences into reference tree: epa-ng or sepp (default: epa-ng).'
    inputBinding:
      position: 101
      prefix: --placement_tool
  - id: ref_dir
    type:
      - 'null'
      - Directory
    doc: 'Directory containing reference sequence files (default: bac). Files in the directory must be named after the directory.'
    inputBinding:
      position: 101
      prefix: --ref_dir
  - id: processes
    type:
      - 'null'
      - int
    doc: 'Number of processes to run in parallel (default: 1).'
    inputBinding:
      position: 101
      prefix: --processes
  - id: intermediate
    type:
      - 'null'
      - string
    doc: 'Output folder for intermediate files (will be deleted otherwise).'
    inputBinding:
      position: 101
      prefix: --intermediate
  - id: min_align
    type:
      - 'null'
      - float
    doc: 'Proportion of the total length of an input query sequence that must align with reference sequences (default: 0.80).'
    inputBinding:
      position: 101
      prefix: --min_align
  - id: chunk_size
    type:
      - 'null'
      - int
    doc: 'Number of query seqs to read in at once for EPA-ng (default: 5000).'
    inputBinding:
      position: 101
      prefix: --chunk_size
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: 'If specified, print out wrapped commands and other details to screen.'
    inputBinding:
      position: 101
      prefix: --verbose
  - id: out_tree_path
    type: string
    doc: 'Name of final output tree.'
    inputBinding:
      position: 102
      prefix: --out_tree
outputs:
  - id: out_tree
    type: File
    doc: 'Name of final output tree.'
    outputBinding:
      glob: $(inputs.out_tree_path)
  - id: intermediate_dir
    type:
      - 'null'
      - Directory
    doc: 'Intermediate files folder, when requested.'
    outputBinding:
      glob: $(inputs.intermediate)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/picrust2:2.6.3--pyhdfd78af_1
