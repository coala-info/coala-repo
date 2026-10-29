cwlVersion: v1.2
class: CommandLineTool
baseCommand: disentangle_organelle_assembly.py
label: getorganelle_disentangle_organelle_assembly.py
doc: "Disentangle organelle genomes from an assembly graph (fastg) with the tab file produced by slim_graph.py.\n\nTool homepage: http://github.com/Kinggerm/GetOrganelle"
inputs:
  - id: fastg_file
    type:
      - File
    doc: "Input fastg format file."
    inputBinding:
      position: 101
      prefix: "-g"
  - id: tab_file
    type:
      - File
    doc: "Input tab format file (*.csv; the postfix 'csv' was in conformity with Bandage) produced by slim_graph.py."
    inputBinding:
      position: 101
      prefix: "-t"
  - id: output_directory
    type:
      - string
    doc: "Output directory."
    inputBinding:
      position: 101
      prefix: "-o"
  - id: mode
    type:
      - string
    doc: "Organelle type: embplant_pt/other_pt/embplant_mt/embplant_nr/animal_mt/fungus_mt/fungus_nr/anonym."
    inputBinding:
      position: 101
      prefix: "-F"
  - id: linear
    type:
      - 'null'
      - boolean
    doc: "By default, this script would only disentangle the circular graph (the complete circular organelle genome), and would directly give up linear/broken graphs. Choose this option to try for linear/broken cases."
    inputBinding:
      position: 101
      prefix: "--linear"
  - id: weight_factor
    type:
      - 'null'
      - float
    doc: "Weight factor for excluding non-target contigs. Default:100.0"
    inputBinding:
      position: 101
      prefix: "--weight-f"
  - id: depth_factor
    type:
      - 'null'
      - float
    doc: "Depth factor for excluding non-target contigs. Default:10.0"
    inputBinding:
      position: 101
      prefix: "--depth-f"
  - id: type_factor
    type:
      - 'null'
      - float
    doc: "Type factor for identifying genome type tag. Default:3.0"
    inputBinding:
      position: 101
      prefix: "--type-f"
  - id: contamination_depth
    type:
      - 'null'
      - float
    doc: "Depth factor for confirming contaminating contigs. Default:3.0"
    inputBinding:
      position: 101
      prefix: "--contamination-depth"
  - id: contamination_similarity
    type:
      - 'null'
      - float
    doc: "Similarity threshold for confirming contaminating contigs. Default:0.9"
    inputBinding:
      position: 101
      prefix: "--contamination-similarity"
  - id: no_degenerate
    type:
      - 'null'
      - boolean
    doc: "Disable making consensus from parallel contig based on nucleotide degenerate table."
    inputBinding:
      position: 101
      prefix: "--no-degenerate"
  - id: degenerate_depth
    type:
      - 'null'
      - float
    doc: "Depth factor for confirming parallel contigs. Default:1.5"
    inputBinding:
      position: 101
      prefix: "--degenerate-depth"
  - id: degenerate_similarity
    type:
      - 'null'
      - float
    doc: "Similarity threshold for confirming parallel contigs. Default:0.98"
    inputBinding:
      position: 101
      prefix: "--degenerate-similarity"
  - id: expected_max_size
    type:
      - 'null'
      - int
    doc: "Expected maximum target genome size. Default: 200000 (-F embplant_pt/fungus_mt), 25000 (-F embplant_nr/animal_mt/fungus_nr), 600000 (-F embplant_mt/other_pt)"
    inputBinding:
      position: 101
      prefix: "--expected-max-size"
  - id: expected_min_size
    type:
      - 'null'
      - int
    doc: "Expected minimum target genome size. Default: 10000"
    inputBinding:
      position: 101
      prefix: "--expected-min-size"
  - id: reverse_lsc
    type:
      - 'null'
      - boolean
    doc: "For '-F embplant_pt' with complete circular result, reverse the direction of the starting contig (usually the LSC contig). Both directions are biologically equivalent."
    inputBinding:
      position: 101
      prefix: "--reverse-lsc"
  - id: max_paths_num
    type:
      - 'null'
      - int
    doc: "Export a certain amount of paths out of all possible paths per assembly graph. Default: 1000"
    inputBinding:
      position: 101
      prefix: "--max-paths-num"
  - id: keep_all_polymorphic
    type:
      - 'null'
      - boolean
    doc: "By default, the contig with highest coverage among all parallel (polymorphic) contigs is picked when degenerating was not applicable. Choose this flag to export all combinations."
    inputBinding:
      position: 101
      prefix: "--keep-all-polymorphic"
  - id: min_sigma
    type:
      - 'null'
      - float
    doc: "Minimum deviation factor for excluding non-target contigs. Default:0.1"
    inputBinding:
      position: 101
      prefix: "--min-sigma"
  - id: min_depth
    type:
      - 'null'
      - float
    doc: "Minimum coverage for a contig to be included in disentangling. Default:0.0"
    inputBinding:
      position: 101
      prefix: "--min-depth"
  - id: max_depth
    type:
      - 'null'
      - string
    doc: "Maximum coverage for a contig to be included in disentangling (a number or inf). Default:inf"
    inputBinding:
      position: 101
      prefix: "--max-depth"
  - id: max_multiplicity
    type:
      - 'null'
      - int
    doc: "Maximum multiplicity of contigs for disentangling genome paths. Should be 1~12. Default:8"
    inputBinding:
      position: 101
      prefix: "--max-multiplicity"
  - id: prefix
    type:
      - 'null'
      - string
    doc: "Prefix of output files inside output directory. Default:target"
    inputBinding:
      position: 101
      prefix: "--prefix"
  - id: keep_temp
    type:
      - 'null'
      - boolean
    doc: "Export intermediate graph file."
    inputBinding:
      position: 101
      prefix: "--keep-temp"
  - id: time_limit
    type:
      - 'null'
      - int
    doc: "Time limit for the disentangling process. Default:3600"
    inputBinding:
      position: 101
      prefix: "--time-limit"
  - id: random_seed
    type:
      - 'null'
      - int
    doc: "Random seed (only for disentangling at this moment). Default: 12345"
    inputBinding:
      position: 101
      prefix: "--random-seed"
  - id: continue_mode
    type:
      - 'null'
      - boolean
    doc: "Continue mode."
    inputBinding:
      position: 101
      prefix: "--continue"
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Verbose logging."
    inputBinding:
      position: 101
      prefix: "--verbose"
  - id: debug
    type:
      - 'null'
      - boolean
    doc: "For debug."
    inputBinding:
      position: 101
      prefix: "--debug"
outputs:
  - id: output_dir
    type:
      - Directory
    doc: "Output directory with the disentangled graphs and sequences."
    outputBinding:
      glob: "$(inputs.output_directory)"
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/getorganelle:1.7.7.1--pyhdfd78af_0
stdout: getorganelle_disentangle_organelle_assembly.py.out
