cwlVersion: v1.2
class: CommandLineTool
baseCommand: phylophlan
label: phylophlan
doc: "PhyloPhlAn is an accurate, rapid, and easy-to-use method for large-scale microbial
  genome characterization and phylogenetic analysis at multiple levels of resolution.
  PhyloPhlAn can assign finished, draft, or metagenome-assembled genomes (MAGs) to
  species-level genome bins (SGBs). For individual clades of interest (e.g. newly
  sequenced genome sets), PhyloPhlAn reconstructs strain-level phylogenies from among
  the closest species using clade-specific maximally informative markers. At the other
  extreme of resolution, PhyloPhlAn scales to very-large phylogenies comprising >17,000
  microbial species\n\nTool homepage: https://github.com/biobakery/phylophlan"
inputs:
  - id: accurate
    type:
      - 'null'
      - boolean
    doc: Use more phylogenetic signal which can result in more accurate 
      phylogeny; affected parameters depend on the "--diversity" level
    default: false
    inputBinding:
      position: 101
      prefix: --accurate
  - id: citation
    type:
      - 'null'
      - boolean
    doc: Show citation
    inputBinding:
      position: 101
      prefix: --citation
  - id: clean
    type:
      - 'null'
      - string
    doc: Clean the output and partial data produced for the specified project
    default: None
    inputBinding:
      position: 101
      prefix: --clean
  - id: clean_all
    type:
      - 'null'
      - boolean
    doc: Remove all installation and database files automatically generated
    default: false
    inputBinding:
      position: 101
      prefix: --clean_all
  - id: config_file
    type:
      - 'null'
      - File
    doc: The configuration file to use. Four ready-to-use configuration files 
      can be generated using the "phylophlan_write_default_configs.sh" script
    default: None
    inputBinding:
      position: 101
      prefix: --config_file
  - id: configs_folder
    type:
      - 'null'
      - Directory
    doc: Path to the folder containing the configuration files
    default: phylophlan_configs/
    inputBinding:
      position: 101
      prefix: --configs_folder
  - id: convert_N2gap
    type:
      - 'null'
      - boolean
    doc: If specified Ns will be forced to gaps (-) after the MSAs and only whit
      nucleotides MSAs
    default: false
    inputBinding:
      position: 101
      prefix: --convert_N2gap
  - id: data_folder
    type:
      - 'null'
      - Directory
    doc: Path to the folder where to store the intermediate files, default is 
      "tmp" inside the project's output folder
    default: None
    inputBinding:
      position: 101
      prefix: --data_folder
  - id: database
    type:
      - 'null'
      - string
    doc: The name of the database of markers to use
    default: None
    inputBinding:
      position: 101
      prefix: --database
  - id: database_list
    type:
      - 'null'
      - boolean
    doc: List of all the available databases that can be specified with the 
      -d/--database option
    default: false
    inputBinding:
      position: 101
      prefix: --database_list
  - id: databases_folder
    type:
      - 'null'
      - Directory
    doc: Path to the folder containing the database files
    default: phylophlan_databases/
    inputBinding:
      position: 101
      prefix: --databases_folder
  - id: db_type
    type:
      - 'null'
      - string
    doc: Specify the type of the database of markers, where "n" stands for 
      nucleotides and "a" for amino acids. If not specified, PhyloPhlAn will 
      automatically detect the type of database
    default: None
    inputBinding:
      position: 101
      prefix: --db_type
  - id: diversity
    type: string
    doc: 'Specify the expected diversity of the phylogeny, automatically adjust some
      parameters: "low": for genus-/species-/strain-level phylogenies; "medium": for
      class-/order-level phylogenies; "high": for phylum-/tree-of-life size phylogenies'
    inputBinding:
      position: 101
      prefix: --diversity
  - id: fast
    type:
      - 'null'
      - boolean
    doc: Perform more a faster phylogeny reconstruction by reducing the 
      phylogenetic positions to use; affected parameters depend on the 
      "--diversity" level
    default: false
    inputBinding:
      position: 101
      prefix: --fast
  - id: force_nucleotides
    type:
      - 'null'
      - boolean
    doc: If specified force PhyloPhlAn to use nucleotide sequences for the 
      phylogenetic analysis, even in the case of a database of amino acids
    default: false
    inputBinding:
      position: 101
      prefix: --force_nucleotides
  - id: fragmentary_threshold
    type:
      - 'null'
      - float
    doc: The fraction of gaps in the MSA for the sample to be considered 
      fragmentary and hence discarded when --remove_fragmentary_entries is set. 
      [0-1]
    default: 0.85
    inputBinding:
      position: 101
      prefix: --fragmentary_threshold
  - id: gap_perc_threshold
    type:
      - 'null'
      - float
    doc: Fraction of gaps above which to discard a column when "--trim gap_perc"
      is specified. [0-1]
    default: 0.8
    inputBinding:
      position: 101
      prefix: --gap_perc_threshold
  - id: genome_extension
    type:
      - 'null'
      - string
    doc: Extension for input genomes
    default: .fna
    inputBinding:
      position: 101
      prefix: --genome_extension
  - id: input
    type:
      - 'null'
      - Directory
    doc: Folder containing your input genomes and/or proteomes
    default: None
    inputBinding:
      position: 101
      prefix: --input
  - id: input_folder
    type:
      - 'null'
      - Directory
    doc: Path to the folder containing the input data
    default: input/
    inputBinding:
      position: 101
      prefix: --input_folder
  - id: maas
    type:
      - 'null'
      - File
    doc: Select a mapping file that specifies the substitution model of amino 
      acid to use for each of the markers for the gene tree reconstruction. File
      must be tab-separated
    default: None
    inputBinding:
      position: 101
      prefix: --maas
  - id: min_len_protein
    type:
      - 'null'
      - int
    doc: Proteins in proteomes shorter than this value will be discarded
    default: 50
    inputBinding:
      position: 101
      prefix: --min_len_protein
  - id: min_num_entries
    type:
      - 'null'
      - int
    doc: The minimum number of entries to be present for each of the markers in 
      the database
    default: 4
    inputBinding:
      position: 101
      prefix: --min_num_entries
  - id: min_num_markers
    type:
      - 'null'
      - int
    doc: Input genomes or proteomes that map to less than the specified number 
      of markers will be discarded
    default: 1
    inputBinding:
      position: 101
      prefix: --min_num_markers
  - id: min_num_proteins
    type:
      - 'null'
      - int
    doc: Proteomes with less than this number of proteins will be discarded
    default: 1
    inputBinding:
      position: 101
      prefix: --min_num_proteins
  - id: mutation_rates
    type:
      - 'null'
      - boolean
    doc: If specified will produced a mutation rates table for each of the 
      aligned markers and a summary table for the concatenated MSA. This 
      operation can take a long time to finish
    default: false
    inputBinding:
      position: 101
      prefix: --mutation_rates
  - id: not_variant_threshold
    type:
      - 'null'
      - float
    doc: Conservation value used above which to discard a column as not variant 
      when "--trim not_variant" is specified. [0-1]
    default: 0.99
    inputBinding:
      position: 101
      prefix: --not_variant_threshold
  - id: nproc
    type:
      - 'null'
      - int
    doc: The number of cores to use
    default: 1
    inputBinding:
      position: 101
      prefix: --nproc
  - id: output
    type:
      - 'null'
      - Directory
    doc: Output folder name, otherwise it will be the name of the input folder 
      concatenated with the name of the database used
    default: None
    inputBinding:
      position: 101
      prefix: --output
  - id: output_folder
    type:
      - 'null'
      - Directory
    doc: Path to the output folder where to save the results
    default: ''
    inputBinding:
      position: 101
      prefix: --output_folder
  - id: proteome_extension
    type:
      - 'null'
      - string
    doc: Extension for input proteomes
    default: .faa
    inputBinding:
      position: 101
      prefix: --proteome_extension
  - id: remove_fragmentary_entries
    type:
      - 'null'
      - boolean
    doc: If specified the MSAs will be checked and cleaned from fragmentary 
      entries. See --fragmentary_threshold for the threshold values above which 
      an entry will be considered fragmentary
    default: false
    inputBinding:
      position: 101
      prefix: --remove_fragmentary_entries
  - id: remove_only_gaps_entries
    type:
      - 'null'
      - boolean
    doc: If specified, entries in the MSAs composed only of gaps ("-") will be 
      removed. This is equivalent to specify "--remove_fragmentary_entries 
      --fragmentary_threshold 1"
    default: false
    inputBinding:
      position: 101
      prefix: --remove_only_gaps_entries
  - id: scoring_function
    type:
      - 'null'
      - string
    doc: Specify which scoring function to use to evaluate columns in the MSA 
      results
    default: None
    inputBinding:
      position: 101
      prefix: --scoring_function
  - id: sort
    type:
      - 'null'
      - boolean
    doc: If specified, the markers will be ordered, when using the PhyloPhlAn 
      database, it will be automatically set to "True"
    default: false
    inputBinding:
      position: 101
      prefix: --sort
  - id: strainphlan
    type:
      - 'null'
      - boolean
    doc: The inputs are aligned markers from StrainPhlAn
    default: false
    inputBinding:
      position: 101
      prefix: --strainphlan
  - id: submat
    type:
      - 'null'
      - string
    doc: Specify the substitution matrix to use, available substitution matrices
      can be listed with "--submat_list"
    default: None
    inputBinding:
      position: 101
      prefix: --submat
  - id: submat_folder
    type:
      - 'null'
      - Directory
    doc: Path to the folder containing the substitution matrices to use to 
      compute the column score for the subsampling step
    default: phylophlan_substitution_matrices/
    inputBinding:
      position: 101
      prefix: --submat_folder
  - id: submat_list
    type:
      - 'null'
      - boolean
    doc: List of all the available substitution matrices that can be specified 
      with the -s/--submat option
    default: false
    inputBinding:
      position: 101
      prefix: --submat_list
  - id: submod_folder
    type:
      - 'null'
      - Directory
    doc: Path to the folder containing the mapping file with substitution models
      for each marker for the gene tree building
    default: phylophlan_substitution_models/
    inputBinding:
      position: 101
      prefix: --submod_folder
  - id: submod_list
    type:
      - 'null'
      - boolean
    doc: List of all the available substitution models that can be specified 
      with the --maas option
    default: false
    inputBinding:
      position: 101
      prefix: --submod_list
  - id: subsample
    type:
      - 'null'
      - string
    doc: 'The number of positions to retain from each single marker, available option
      are: "phylophlan": specific number of positions for each PhyloPhlAn marker (only
      when "--database phylophlan"); "onethousand": return the top 1000 positions;
      "sevenhundred": return the top 700; "fivehundred": return the top 500; "threehundred"
      return the top 300; "onehundred": return the top 100 positions; "fifty": return
      the top 50 positions; "twentyfive": return the top 25 positions; "fiftypercent":
      return the top 50 percent positions; "twentyfivepercent": return the top 25%
      positions; "tenpercent": return the top 10% positions; "full": full alignment.'
    default: full
    inputBinding:
      position: 101
      prefix: --subsample
  - id: trim
    type:
      - 'null'
      - string
    doc: 'Specify which type of trimming to perform: "gap_trim": execute what specified
      in the "trim" section of the configuration file; "gap_perc": remove columns
      with a percentage of gaps above a certain threshold (see "--gap_perc_threshold"
      parameter)"not_variant": remove columns with at least one nucleotide/amino acid
      appearing above a certain threshold (see "--not_variant_threshold" parameter);
      "greedy": performs all the above trimming steps; If not specified, no trimming
      will be performed'
    default: None
    inputBinding:
      position: 101
      prefix: --trim
  - id: unknown_fraction
    type:
      - 'null'
      - float
    doc: Define the amount of unknowns ("X" and "-") allowed in each column of 
      the MSA of the markers
    default: 0.3
    inputBinding:
      position: 101
      prefix: --unknown_fraction
  - id: update
    type:
      - 'null'
      - boolean
    doc: Update the databases file
    default: false
    inputBinding:
      position: 101
      prefix: --update
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Makes PhyloPhlAn verbose
    default: false
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylophlan:3.2.1--pyhdfd78af_0
stdout: phylophlan.out
