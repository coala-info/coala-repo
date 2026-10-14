cwlVersion: v1.2
class: CommandLineTool
baseCommand: pathway_pipeline.py
label: picrust2_pathway_pipeline.py
doc: "Script to infer the presence and abundances of pathways based on gene family abundances in a sample. By default, this script expects a table of EC number abundances (as output by PICRUSt2).\n\nTool homepage: https://github.com/picrust/picrust2"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: input
    type: File
    doc: 'Input TSV table of gene family abundances (unstratified or stratified output of metagenome_pipeline.py).'
    inputBinding:
      position: 101
      prefix: --input
  - id: database
    type:
      - 'null'
      - string
    doc: 'Database used for the pathway calculations. Set to oldIMG to use the old IMG database.'
    inputBinding:
      position: 101
      prefix: --database
  - id: map
    type:
      - 'null'
      - File
    doc: 'Mapping of pathways to reactions (default: MetaCyc reactions to prokaryotic MetaCyc pathways).'
    inputBinding:
      position: 101
      prefix: --map
  - id: skip_minpath
    type:
      - 'null'
      - boolean
    doc: 'Do not run MinPath to identify which pathways are present as a first pass.'
    inputBinding:
      position: 101
      prefix: --skip_minpath
  - id: no_gap_fill
    type:
      - 'null'
      - boolean
    doc: 'Do not perform gap filling before predicting pathway abundances.'
    inputBinding:
      position: 101
      prefix: --no_gap_fill
  - id: intermediate
    type:
      - 'null'
      - string
    doc: 'Output folder for intermediate files (will be deleted otherwise).'
    inputBinding:
      position: 101
      prefix: --intermediate
  - id: processes
    type:
      - 'null'
      - int
    doc: 'Number of processes to run in parallel (default: 1).'
    inputBinding:
      position: 101
      prefix: --processes
  - id: no_regroup
    type:
      - 'null'
      - boolean
    doc: 'Do not regroup input gene families to reactions as specified in the regrouping mapfile.'
    inputBinding:
      position: 101
      prefix: --no_regroup
  - id: coverage
    type:
      - 'null'
      - boolean
    doc: 'Calculate pathway coverages as well as abundances (experimental).'
    inputBinding:
      position: 101
      prefix: --coverage
  - id: regroup_map
    type:
      - 'null'
      - File
    doc: 'Mapfile of ids to regroup gene families to before running MinPath.'
    inputBinding:
      position: 101
      prefix: --regroup_map
  - id: per_sequence_contrib
    type:
      - 'null'
      - boolean
    doc: 'Run MinPath on the genes contributed by each sequence individually (needs per_sequence_abun and per_sequence_function).'
    inputBinding:
      position: 101
      prefix: --per_sequence_contrib
  - id: per_sequence_abun
    type:
      - 'null'
      - File
    doc: 'Table of sequence abundances across samples normalized by marker copy number.'
    inputBinding:
      position: 101
      prefix: --per_sequence_abun
  - id: per_sequence_function
    type:
      - 'null'
      - File
    doc: 'Table of function abundances per sequence from the hidden-state prediction step.'
    inputBinding:
      position: 101
      prefix: --per_sequence_function
  - id: wide_table
    type:
      - 'null'
      - boolean
    doc: 'Output wide-format stratified table rather than the contribution table (deprecated).'
    inputBinding:
      position: 101
      prefix: --wide_table
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: 'Print out details as commands are run.'
    inputBinding:
      position: 101
      prefix: --verbose
  - id: out_dir
    type: string
    doc: 'Output folder for pathway abundance output.'
    inputBinding:
      position: 102
      prefix: --out_dir
outputs:
  - id: output_directory
    type: Directory
    doc: 'Pathway abundance output folder.'
    outputBinding:
      glob: $(inputs.out_dir)
  - id: intermediate_directory
    type:
      - 'null'
      - Directory
    doc: 'Intermediate files, when requested.'
    outputBinding:
      glob: $(inputs.intermediate)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/picrust2:2.6.3--pyhdfd78af_1
