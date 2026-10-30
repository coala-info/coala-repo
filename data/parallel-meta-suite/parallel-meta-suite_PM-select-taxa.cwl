cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - PM-select-taxa
label: parallel-meta-suite_PM-select-taxa
doc: "Select the taxonomy features\n\nTool homepage: https://github.com/qdu-bioinfo/parallel-meta-suite"
inputs:
  - id: ref_database
    type:
      - 'null'
      - string
    doc: "Reference database (the help gives 'Empty database' as the default text)"
    inputBinding:
      position: 1
      prefix: "-D"
  - id: list_file
    type:
      - 'null'
      - File
    doc: "Input files list"
    inputBinding:
      position: 1
      prefix: "-l"
  - id: list_path_prefix
    type:
      - 'null'
      - string
    doc: "List file path prefix [Optional for -l]"
    inputBinding:
      position: 1
      prefix: "-p"
  - id: list_members
    type:
      - 'null'
      - {type: array, items: File}
    doc: "Files named in the list; staged in the working directory so that the names in the list resolve"
  - id: otu_count_table
    type:
      - 'null'
      - File
    doc: "Input OTU count table (*.OTU.Count)"
    inputBinding:
      position: 1
      prefix: "-T"
  - id: output_file
    type:
      - 'null'
      - string
    doc: "Output file name, default is \"taxaonomy_selection\""
    default: taxaonomy_selection
    inputBinding:
      position: 1
      prefix: "-o"
  - id: taxonomy_level
    type:
      - 'null'
      - int
    doc: "Taxonomical level (1-6: Phylum - Species, 7: OTU). default is 5"
    inputBinding:
      position: 1
      prefix: "-L"
  - id: print_barchart
    type:
      - 'null'
      - string
    doc: "Print distribution barchart, T(rue) or F(alse), default is F"
    inputBinding:
      position: 1
      prefix: "-P"
  - id: copy_number_correction
    type:
      - 'null'
      - string
    doc: "rRNA copy number correction, T(rue) or F(alse), default is T"
    inputBinding:
      position: 1
      prefix: "-r"
  - id: min_sequence_count
    type:
      - 'null'
      - int
    doc: "Minimum sequence count threshold, default is 2"
    inputBinding:
      position: 1
      prefix: "-q"
  - id: max_abundance
    type:
      - 'null'
      - float
    doc: "Maximum abundance threshold, default is 0.001 (0.1%)"
    inputBinding:
      position: 1
      prefix: "-m"
  - id: min_abundance
    type:
      - 'null'
      - float
    doc: "Minimum abundance threshold, default is 0.0 (0%)"
    inputBinding:
      position: 1
      prefix: "-n"
  - id: min_nonzero_abundance
    type:
      - 'null'
      - float
    doc: "Minimum No-Zero abundance threshold, default is 0.1 (10%)"
    inputBinding:
      position: 1
      prefix: "-z"
  - id: min_average_abundance
    type:
      - 'null'
      - float
    doc: "Minimum average abundance threshold, default is 0.001 (0.1%)"
    inputBinding:
      position: 1
      prefix: "-v"
outputs:
  - id: selected_tables
    type: {type: array, items: File}
    doc: "Selected taxonomy abundance tables and plots"
    outputBinding:
      glob: "$(inputs.output_file + '*')"
  - id: stdout
    type: stdout
    doc: "Standard output (screen messages)"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: '$(inputs.list_members ? inputs.list_members : [])'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/parallel-meta-suite:1.0--h7d875b9_1
stdout: parallel-meta-suite_PM-select-taxa.out
