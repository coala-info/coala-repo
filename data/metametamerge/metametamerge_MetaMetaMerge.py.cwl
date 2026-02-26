cwlVersion: v1.2
class: CommandLineTool
baseCommand: MetaMetaMerge.py
label: metametamerge_MetaMetaMerge.py
doc: "MetaMetaMerge by Vitor C. Piro (vitorpiro@gmail.com, http://github.com/pirovc)\n\
  \nTool homepage: https://github.com/pirovc/metametamerge/"
inputs:
  - id: bins
    type:
      - 'null'
      - int
    doc: Number of bins.
    default: 4
    inputBinding:
      position: 101
      prefix: --bins
  - id: cutoff
    type:
      - 'null'
      - float
    doc: 'Minimum abundance/Maximum results for each taxonomic level (0: off / 0-1:
      minimum relative abundance / >=1: maximum number of identifications). Default:
      0.0001'
    default: 0.0001
    inputBinding:
      position: 101
      prefix: --cutoff
  - id: database_profiles
    type:
      type: array
      items: File
    doc: Database profiles on the same order of the input files (see README)
    inputBinding:
      position: 101
      prefix: --database-profiles
  - id: detailed
    type:
      - 'null'
      - boolean
    doc: 'Generate an additional detailed output with individual normalized abundances
      for each tool, where: 0 -> not identified but present in the database, -1 not
      present in the database.'
    inputBinding:
      position: 101
      prefix: --detailed
  - id: input_files
    type:
      type: array
      items: File
    doc: Input (binning or profiling) files. Bioboxes or tsv format (see README)
    inputBinding:
      position: 101
      prefix: --input-files
  - id: merged_file
    type: File
    doc: merged.dmp from the NCBI Taxonomy database
    inputBinding:
      position: 101
      prefix: --merged-file
  - id: mode
    type:
      - 'null'
      - string
    doc: 'Result mode (precise, very-precise, linear, sensitive, very-sensitive, no-cutoff).
      Default: linear'
    default: linear
    inputBinding:
      position: 101
      prefix: --mode
  - id: names_file
    type: File
    doc: names.dmp from the NCBI Taxonomy database
    inputBinding:
      position: 101
      prefix: --names-file
  - id: nodes_file
    type: File
    doc: nodes.dmp from the NCBI Taxonomy database
    inputBinding:
      position: 101
      prefix: --nodes-file
  - id: output_parsed_profiles
    type:
      - 'null'
      - boolean
    doc: Output parsed and converted profiles for all input files (without 
      cutoff)
    inputBinding:
      position: 101
      prefix: --output-parsed-profiles
  - id: output_type
    type:
      - 'null'
      - string
    doc: 'Output type (tsv, bioboxes). Default: bioboxes'
    default: bioboxes
    inputBinding:
      position: 101
      prefix: --output-type
  - id: ranks
    type:
      - 'null'
      - string
    doc: 'Comma-separated list of ranks to be independently merged (superkingdom,phylum,class,order,family,genus,species,all).
      Default: species'
    default: species
    inputBinding:
      position: 101
      prefix: --ranks
  - id: tool_identifier
    type: string
    doc: Comma-separated identifiers on the same order of the input files
    inputBinding:
      position: 101
      prefix: --tool-identifier
  - id: tool_method
    type: string
    doc: Comma-separated methods on the same order of the input files (p -> 
      profiling / b -> binning)
    inputBinding:
      position: 101
      prefix: --tool-method
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output log
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output_file
    type: File
    doc: Output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metametamerge:1.1--py35_1
