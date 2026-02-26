cwlVersion: v1.2
class: CommandLineTool
baseCommand: taxsbp
label: taxsbp
doc: "Parses taxonomic information for sequences and assigns them to bins.\n\nTool
  homepage: https://github.com/pirovc/taxsbp"
inputs:
  - id: allow_merge
    type:
      - 'null'
      - boolean
    doc: When updating, allow merging of existing bins. Will output the whole 
      set, not only new bins
    inputBinding:
      position: 101
      prefix: --allow-merge
  - id: bin_exclusive
    type:
      - 'null'
      - string
    doc: Make bins rank, leaves or specialization exclusive. Bins will not have 
      mixed entries. When the chosen rank is not present on a sequence lineage, 
      this sequence will be leaf/specialization exclusive. 
      ['leaves',specialization name,rank name]
    inputBinding:
      position: 101
      prefix: --bin-exclusive
  - id: bin_len
    type:
      - 'null'
      - int
    doc: 'Maximum bin length (in bp). Use this parameter insted of -b to define the
      number of bins. Default: length of the biggest group [Mutually exclusive -b]'
    inputBinding:
      position: 101
      prefix: --bin-len
  - id: bins
    type:
      - 'null'
      - int
    doc: Approximate number of bins (estimated by total length/bin number). 
      [Mutually exclusive -l]
    inputBinding:
      position: 101
      prefix: --bins
  - id: fragment_len
    type:
      - 'null'
      - int
    doc: Fragment sequences into pieces
    inputBinding:
      position: 101
      prefix: --fragment-len
  - id: input_file
    type: File
    doc: 'Tab-separated with the fields: sequence id <tab> sequence length <tab> taxonomic
      id [<tab> specialization]'
    inputBinding:
      position: 101
      prefix: --input-file
  - id: merged_file
    type:
      - 'null'
      - File
    doc: merged.dmp from NCBI Taxonomy
    inputBinding:
      position: 101
      prefix: --merged-file
  - id: nodes_file
    type: File
    doc: nodes.dmp from NCBI Taxonomy
    inputBinding:
      position: 101
      prefix: --nodes-file
  - id: overlap_len
    type:
      - 'null'
      - int
    doc: Overlap length between fragments [Only valid with -a]
    inputBinding:
      position: 101
      prefix: --overlap-len
  - id: pre_cluster
    type:
      - 'null'
      - string
    doc: Pre-cluster sequences into any existing rank, leaves or specialization.
      Entries will not be divided in bins ['leaves',specialization name,rank 
      name]
    inputBinding:
      position: 101
      prefix: --pre-cluster
  - id: silent
    type:
      - 'null'
      - boolean
    doc: Do not print warning to STDERR
    inputBinding:
      position: 101
      prefix: --silent
  - id: specialization
    type:
      - 'null'
      - string
    doc: 'Specialization name (e.g. assembly, strain). If given, TaxSBP will cluster
      entries on a specialized level after the leaf. The specialization identifier
      should be provided as an extra collumn in the input_file and should respect
      the taxonomic hiercharchy: One leaf can have multiple specializations but a
      specialization is present in only one leaf'
    inputBinding:
      position: 101
      prefix: --specialization
  - id: update_file
    type:
      - 'null'
      - File
    doc: Previously generated clusters to be updated. Output only new sequences
    inputBinding:
      position: 101
      prefix: --update-file
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: 'Path to the output tab-separated file. Fields: sequence id <tab> sequence
      start <tab> sequence end <tab> sequence length <tab> taxonomic id <tab> bin
      id [<tab> specialization]. Default: STDOUT'
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/taxsbp:1.1.1--py_0
