cwlVersion: v1.2
class: CommandLineTool
baseCommand: genEra
label: genera_genEra
doc: "genEra is an easy-to-use, low-dependency command-line tool that estimates the
  age of the earliest common ancestor of protein coding genes though genomic phylostratigraphy.\n\
  \nTool homepage: https://github.com/josuebarrera/GenEra"
inputs:
  - id: additional_diamond_foldseek_options
    type:
      - 'null'
      - string
    doc: 'Additional options to feed DIAMOND or Foldseek, based on user preferences
      (filtering hits by identity or query coverage) Users should input the additional
      commands in quotes, using the original arguments from DIAMOND (Example: -o "--id
      30") or from Foldseek (Example: -o "-c 0.8 --cov-mode 0")'
    inputBinding:
      position: 101
      prefix: -u
  - id: additional_nucleotide_sequences_table
    type:
      - 'null'
      - File
    doc: "Table with additional nucleotide sequences to search against your query
      proteins. Particularly useful with genome assemblies for improved orphan gene
      classification. Use this option when using FASTA sequences as input. The table
      should be tab-delimited and have the following format: /path/to/genome_1.fasta\t\
      taxid_1\n/path/to/genome_2.fasta\ttaxid_2\n/path/to/genome_3.fasta\ttaxid_3"
    inputBinding:
      position: 101
      prefix: -f
  - id: additional_proteins_table
    type:
      - 'null'
      - File
    doc: "Table with additional proteins to be included in the analysis (e.g., proteins
      from species that are absent from the nr). Use this option when using FASTA
      sequences as input. The table should be tab-delimited and have the following
      format: /path/to/species_1.fasta\ttaxid_1\n/path/to/species_2.fasta\ttaxid_2\n\
      /path/to/species_3.fasta\ttaxid_3"
    inputBinding:
      position: 101
      prefix: -a
  - id: additional_structural_predictions_table
    type:
      - 'null'
      - File
    doc: "Table with additional structural predictions to be included in the analysis
      (e.g., structural predictions from species that are absent from the AlphaFold
      DB). Use this option when using PDB files as input. The table should be tab-delimited
      and have the following format: /path/to/species_directory_1\ttaxid_1\n/path/to/species_directory_2\t\
      taxid_2\n/path/to/species_directory_3\ttaxid_3"
    inputBinding:
      position: 101
      prefix: -A
  - id: custom_lineages_file
    type:
      - 'null'
      - File
    doc: Custom "ncbi_lineages" file that is already tailored for the query 
      species (skip step 2). The table should be arranged so that the taxid is 
      in the first column and all the phylostrata of interest are organized from
      the species level all the way back to "cellular organisms"
    inputBinding:
      position: 101
      prefix: -c
  - id: diamond_db
    type:
      - 'null'
      - Directory
    doc: Path to a locally installed database for DIAMOND (FASTA only)
    inputBinding:
      position: 101
      prefix: -b
  - id: diamond_sensitivity_parameter
    type:
      - 'null'
      - string
    doc: 'Modify the sensitivity parameter in DIAMOND for faster or more sensitive
      results in step 1 (default: sensitive)'
    default: sensitive
    inputBinding:
      position: 101
      prefix: -y
  - id: evalue_threshold
    type:
      - 'null'
      - float
    doc: 'E-value threshold for DIAMOND and Foldseek (default: 1e-5)'
    default: '1e-5'
    inputBinding:
      position: 101
      prefix: -e
  - id: evolutionary_distances_table
    type:
      - 'null'
      - File
    doc: "Table with pairwise evolutionary distances (substitutions/site) between
      several species in the database and the query species (necessary to calculate
      homology detection failure probabilities with abSENSE). NOTE: the query species
      SHOULD be included in this table. The table should be tab-delimited and have
      the following format: query_sp_taxid\t0\nspecies_1_taxid\tdistance_1\nspecies_2_taxid\t\
      distance_2"
    inputBinding:
      position: 101
      prefix: -s
  - id: foldseek_db
    type:
      - 'null'
      - Directory
    doc: Path to a locally installed database for Foldseek (PDB only)
    inputBinding:
      position: 101
      prefix: -B
  - id: foldseek_prefilter_amount
    type:
      - 'null'
      - int
    doc: 'Adjust the amount of prefilter made by Foldseek (i.e., the maximum number
      of hits that are reported) (default: 10000)'
    default: 10000
    inputBinding:
      position: 101
      prefix: -M
  - id: infraspecies_analysis_files
    type:
      - 'null'
      - type: array
        items: File
    doc: List with protein FASTA files to perform an infraspecies-level analysis
      against the query proteome. Particularly useful for detecting candidate de
      novo genes. The user can give GenEra a precomputed phylogeny with -z or 
      let GenEra estimate the evolutionary relationship between the listed 
      proteomes using OrthoFinder. Make sure the file names are unique and 
      recognizable.
    inputBinding:
      position: 101
      prefix: -v
  - id: jackhmmer_start_rank
    type:
      - 'null'
      - int
    doc: 'Starting taxonomic rank of genes that will be re-analyzed using jackhmmer
      (default: 2)'
    default: 2
    inputBinding:
      position: 101
      prefix: -k
  - id: min_matches_percentage
    type:
      - 'null'
      - int
    doc: 'Minimum percentage of matches between your query sequences and any species
      within a taxonomic level to consider it useful for the gene age assignment (i.e.,
      filtering taxonomic levels lacking complete genomes in the database) (default:
      10)'
    default: 10
    inputBinding:
      position: 101
      prefix: -m
  - id: ncbi_lineages_file
    type:
      - 'null'
      - File
    doc: Raw "ncbi_lineages" file generated by ncbitax2lin (saves time on step 
      2)
    inputBinding:
      position: 101
      prefix: -r
  - id: precomputed_phylogeny
    type:
      - 'null'
      - File
    doc: Precomputed phylogeny in NEWICK format for the infraspecies-level 
      analysis. Make sure that the names in the phylogeny match the prefixes of 
      the FASTA files (-v).
    inputBinding:
      position: 101
      prefix: -z
  - id: pregenerated_table
    type:
      - 'null'
      - File
    doc: 'Pre-generated DIAMOND/Foldseek table (skip step 1), with the query genes
      in the first column, the bitscore in the second to last column and the target
      taxid in the last column (IMPORTANT: the query sequences must also be searched
      against themselves for genEra to work properly)'
    inputBinding:
      position: 101
      prefix: -p
  - id: print_best_hit
    type:
      - 'null'
      - boolean
    doc: 'When true, prints an additional output file with the best sequence hit responsible
      for the oldest gene age assignment for each of the query genes (default: true)'
    default: true
    inputBinding:
      position: 101
      prefix: -i
  - id: query_sequences
    type:
      - 'null'
      - File
    doc: File with query protein sequences in FASTA format to perform pairwise 
      sequence alignments using DIAMOND
    inputBinding:
      position: 101
      prefix: -q
  - id: query_structure_directory
    type:
      - 'null'
      - Directory
    doc: Directory with query structural predictions in PDB format to perform 
      pairwise structural alignments using Foldseek
    inputBinding:
      position: 101
      prefix: -Q
  - id: query_taxid
    type: string
    doc: NCBI Taxonomy ID of query species (search for the taxid of your query 
      species at https://www.ncbi.nlm.nih.gov/taxonomy)
    inputBinding:
      position: 101
      prefix: -t
  - id: run_jackhmmer
    type:
      - 'null'
      - boolean
    doc: 'When true, run an additional search step using jackhmmer against the online
      Uniprot database (default: false) (warning 1: Only available when using FASTA
      sequences) (warning 2: this step requires internet connection)'
    default: false
    inputBinding:
      position: 101
      prefix: -j
  - id: speed_up_step3
    type:
      - 'null'
      - boolean
    doc: 'Speed up STEP 3 gen age assignment at the cost of using more RAM, e.g 200
      GB RAM for 180 GB STEP 1 .bout output, and temporary files, as much temp files
      as the number of query genes. Please take into account the requeriments before
      running. Set -F false to run genEra with fewer resources at the cost of longer
      running times. Speed up of x ~ 5 times faster per 10,000 query genes (-F true
      vs -F false). Speed improvement will increase gradually with bigger queries.
      (default: true)'
    default: true
    inputBinding:
      position: 101
      prefix: -F
  - id: taxdump_dir
    type: Directory
    doc: Location of the uncompressed taxonomy dump from the NCBI 
      (ftp.ncbi.nlm.nih.gov/pub/taxonomy/new_taxdump/new_taxdump.tar.gz)
    inputBinding:
      position: 101
      prefix: -d
  - id: taxonomic_representativeness_threshold
    type:
      - 'null'
      - int
    doc: 'Taxonomic representativeness threshold below which a gene will be flagged
      as putative genome contamination or the product of a horizontal gene transfer
      (HGT) event (default: 30)'
    default: 30
    inputBinding:
      position: 101
      prefix: -l
  - id: temporary_files_dir
    type:
      - 'null'
      - Directory
    doc: 'Alternative path where you would like to store the temporary files as well
      as the DIAMOND/Foldseek results (warning: genEra will generate HUGE temporary
      files) (default: the files will be stored in a tmp_[RAMDOMNUM]/ directory created
      by genEra)'
    inputBinding:
      position: 101
      prefix: -x
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of threads to run genEra (genEra can run with a single thread, but
      it is HIGHLY suggested to use as many threads as possible) (default: all available
      threads)'
    inputBinding:
      position: 101
      prefix: -n
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: 'Directory to save output files (default: working directory)'
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genera:1.4.2--py38hdfd78af_0
