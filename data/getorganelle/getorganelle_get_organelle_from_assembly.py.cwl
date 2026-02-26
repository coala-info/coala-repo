cwlVersion: v1.2
class: CommandLineTool
baseCommand: get_organelle_from_assembly.py
label: getorganelle_get_organelle_from_assembly.py
doc: "isolates organelle genomes from assembly graph.\n\nTool homepage: http://github.com/Kinggerm/GetOrganelle"
inputs:
  - id: config_dir
    type:
      - 'null'
      - Directory
    doc: The directory where the configuration file and default databases were 
      placed. The default value also can be changed by adding 'export 
      GETORG_PATH=your_favor' to the shell script (e.g. ~/.bash_profile or 
      ~/.bashrc)
    default: /root/.GetOrganelle
    inputBinding:
      position: 101
      prefix: --config-dir
  - id: contamination_depth
    type:
      - 'null'
      - float
    doc: Depth factor for confirming contamination in parallel contigs.
    default: 3.0
    inputBinding:
      position: 101
      prefix: --contamination-depth
  - id: contamination_similarity
    type:
      - 'null'
      - float
    doc: Similarity threshold for confirming contaminating contigs.
    default: 0.9
    inputBinding:
      position: 101
      prefix: --contamination-similarity
  - id: continue
    type:
      - 'null'
      - boolean
    doc: Several check points based on files produced, rather than on the log 
      file, so keep in mind that this script will not detect the difference 
      between this input parameters and the previous ones.
    inputBinding:
      position: 101
      prefix: --continue
  - id: degenerate_depth
    type:
      - 'null'
      - float
    doc: Depth factor for confirming parallel contigs.
    default: 1.5
    inputBinding:
      position: 101
      prefix: --degenerate-depth
  - id: degenerate_similarity
    type:
      - 'null'
      - float
    doc: Similarity threshold for confirming parallel contigs.
    default: 0.98
    inputBinding:
      position: 101
      prefix: --degenerate-similarity
  - id: depth_factor
    type:
      - 'null'
      - float
    doc: Depth factor for differentiate genome type of contigs. The genome type 
      of contigs are determined by blast.
    default: 10.0
    inputBinding:
      position: 101
      prefix: --depth-factor
  - id: disentangle_time_limit
    type:
      - 'null'
      - int
    doc: Time limit (second) for each try of disentangling a graph file as a 
      circular genome. Disentangling a graph as contigs is not limited.
    default: 3600
    inputBinding:
      position: 101
      prefix: --disentangle-time-limit
  - id: ex_genes
    type:
      - 'null'
      - File
    doc: This is optional and Not suggested, since non-target contigs could 
      contribute information for better downstream coverage-based clustering. 
      Followed with a customized database (a fasta file or the base name of a 
      blast database) containing or made of protein coding genes and ribosomal 
      RNAs extracted from reference genome(s) that you want to exclude. Could be
      a list of databases split by comma(s) but NOT required to have the same 
      list length to organelle_type (followed by '-F'). The default value no 
      longer holds when '--genes' or '--ex-genes' is used.
    inputBinding:
      position: 101
      prefix: --ex-genes
  - id: expected_max_size
    type:
      - 'null'
      - type: array
        items: int
    doc: Expected maximum target genome size(s) for disentangling. Should be a 
      list of INTEGER numbers split by comma(s) on a multi-organelle mode, with 
      the same list length to organelle_type (followed by '-F').
    inputBinding:
      position: 101
      prefix: --expected-max-size
  - id: expected_min_size
    type:
      - 'null'
      - type: array
        items: int
    doc: Expected minimum target genome size(s) for disentangling. Should be a 
      list of INTEGER numbers split by comma(s) on a multi-organelle mode, with 
      the same list length to organelle_type (followed by '-F').
    default: 10000 for all
    inputBinding:
      position: 101
      prefix: --expected-min-size
  - id: genes
    type:
      - 'null'
      - File
    doc: Followed with a customized database (a fasta file or the base name of a
      blast database) containing or made of ONE set of protein coding genes and 
      ribosomal RNAs extracted from ONE reference genome that you want to 
      assemble. Should be a list of databases split by comma(s) on a 
      multi-organelle mode, with the same list length to organelle_type 
      (followed by '-F'). This is optional for any organelle mentioned in '-F' 
      but required for 'anonym'. By default, certain database(s) in 
      /root/.GetOrganelle/LabelDatabase would be used contingent on the 
      organelle types chosen (-F). The default value no longer holds when 
      '--genes' or '--ex-genes' is used.
    inputBinding:
      position: 101
      prefix: --genes
  - id: input_graph
    type: File
    doc: Input assembly graph (fastg/gfa) file. The format will be recognized by
      the file name suffix.
    inputBinding:
      position: 101
      prefix: -g
  - id: keep_all_polymorphic
    type:
      - 'null'
      - boolean
    doc: By default, this script would pick the contig with highest coverage 
      among all parallel (polymorphic) contigs when degenerating was not 
      applicable. Choose this flag to export all combinations.
    inputBinding:
      position: 101
      prefix: --keep-all-polymorphic
  - id: keep_temp
    type:
      - 'null'
      - boolean
    doc: Choose to keep the running temp/index files.
    inputBinding:
      position: 101
      prefix: --keep-temp
  - id: max_depth
    type:
      - 'null'
      - float
    doc: Input a float or integer number. filter graph file by a maximum depth.
    default: inf
    inputBinding:
      position: 101
      prefix: --max-depth
  - id: max_multiplicity
    type:
      - 'null'
      - int
    doc: Maximum multiplicity of contigs for disentangling genome paths. Should 
      be 1~12.
    default: 8
    inputBinding:
      position: 101
      prefix: --max-multiplicity
  - id: max_paths_num
    type:
      - 'null'
      - int
    doc: Repeats would dramatically increase the number of potential isomers 
      (paths). This option was used to export a certain amount of paths out of 
      all possible paths per assembly graph.
    default: 1000
    inputBinding:
      position: 101
      prefix: --max-paths-num
  - id: max_slim_extending_len
    type:
      - 'null'
      - int
    doc: This is used to limit the extending length, below which a "non-hit 
      contig" is allowed to be distant from a "hit contig" to be kept. See more 
      under slim_graph.py:--max-slim-extending-len.
    inputBinding:
      position: 101
      prefix: --max-slim-extending-len
  - id: min_depth
    type:
      - 'null'
      - float
    doc: Input a float or integer number. Filter graph file by a minimum depth.
    default: 10.0
    inputBinding:
      position: 101
      prefix: --min-depth
  - id: min_sigma_factor
    type:
      - 'null'
      - float
    doc: Minimum deviation factor for excluding non-target contigs.
    default: 0.1
    inputBinding:
      position: 101
      prefix: --min-sigma
  - id: no_degenerate
    type:
      - 'null'
      - boolean
    doc: Disable making consensus from parallel contig based on nucleotide 
      degenerate table.
    inputBinding:
      position: 101
      prefix: --no-degenerate
  - id: no_slim
    type:
      - 'null'
      - boolean
    doc: Disable slimming process and directly disentangle the original assembly
      graph.
    default: false
    inputBinding:
      position: 101
      prefix: --no-slim
  - id: organelle_type
    type: string
    doc: This flag should be followed with embplant_pt (embryophyta plant 
      plastome), other_pt (non-embryophyta plant plastome), embplant_mt (plant 
      mitochondrion), embplant_nr (plant nuclear ribosomal RNA), animal_mt 
      (animal mitochondrion), fungus_mt (fungus mitochondrion), fungus_nr 
      (fungus nuclear ribosomal RNA), or embplant_mt,other_pt,fungus_mt (the 
      combination of any of above organelle genomes split by comma(s), which 
      might be computationally more intensive than separate runs), or anonym 
      (uncertain organelle genome type). The anonym should be used with 
      customized seed and label databases ('-s' and '--genes').
    inputBinding:
      position: 101
      prefix: -F
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Overwrite previous file if existed.
    inputBinding:
      position: 101
      prefix: --overwrite
  - id: prefix
    type:
      - 'null'
      - string
    doc: Add extra prefix to resulting files under the output directory.
    inputBinding:
      position: 101
      prefix: --prefix
  - id: random_seed
    type:
      - 'null'
      - int
    doc: 'Default: 12345'
    default: 12345
    inputBinding:
      position: 101
      prefix: --random-seed
  - id: reverse_lsc
    type:
      - 'null'
      - boolean
    doc: For '-F embplant_pt' with complete circular result, by default, the 
      direction of the starting contig (usually the LSC contig) is determined as
      the direction with less ORFs. Choose this option to reverse the direction 
      of the starting contig when result is circular. Actually, both directions 
      are biologically equivalent to each other. The reordering of the direction
      is only for easier downstream analysis.
    inputBinding:
      position: 101
      prefix: --reverse-lsc
  - id: slim_options
    type:
      - 'null'
      - string
    doc: Other options for calling slim_graph.py
    inputBinding:
      position: 101
      prefix: --slim-options
  - id: spades_out_dir
    type:
      - 'null'
      - Directory
    doc: Input spades output directory with 'scaffolds.fasta' and 
      'scaffolds.paths', which are used for scaffolding disconnected contigs 
      with GAPs.
    inputBinding:
      position: 101
      prefix: --spades-out-dir
  - id: threads
    type:
      - 'null'
      - int
    doc: Maximum threads to use.
    inputBinding:
      position: 101
      prefix: -t
  - id: type_factor
    type:
      - 'null'
      - float
    doc: Type factor for identifying contig type tag when multiple tags exist in
      one contig.
    default: 3.0
    inputBinding:
      position: 101
      prefix: --type-f
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output. Choose to enable verbose running log_handler.
    inputBinding:
      position: 101
      prefix: --verbose
  - id: which_bandage
    type:
      - 'null'
      - File
    doc: Assign the path to bandage binary file if not added to the path.
    default: try $PATH
    inputBinding:
      position: 101
      prefix: --which-bandage
  - id: which_blast
    type:
      - 'null'
      - File
    doc: Assign the path to BLAST binary files if not added to the path.
    default: try 
      /usr/local/lib/python3.10/site-packages/GetOrganelleDep/linux/ncbi-blast 
      first, then $PATH
    inputBinding:
      position: 101
      prefix: --which-blast
outputs:
  - id: output_base
    type: Directory
    doc: Output directory. Overwriting files if directory exists.
    outputBinding:
      glob: $(inputs.output_base)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/getorganelle:1.7.7.1--pyhdfd78af_0
