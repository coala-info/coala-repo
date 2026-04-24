cwlVersion: v1.2
class: CommandLineTool
baseCommand: gapseq_find.sh
label: gapseq_find
doc: "Search for pathways or subsystems using keywords or EC numbers in a FASTA file.\n\
  \nTool homepage: https://github.com/jotech/gapseq"
inputs:
  - id: input_fasta
    type: File
    doc: Input FASTA file
    inputBinding:
      position: 1
  - id: bit_score_cutoff
    type:
      - 'null'
      - int
    doc: Bit score cutoff for local alignment
    inputBinding:
      position: 102
      prefix: -b
  - id: blast_hits_back_uniprot
    type:
      - 'null'
      - boolean
    doc: blast hits back against uniprot enzyme database
    inputBinding:
      position: 102
      prefix: -a
  - id: consider_superpathways
    type:
      - 'null'
      - boolean
    doc: Consider superpathways of metacyc database
    inputBinding:
      position: 102
      prefix: -n
  - id: coverage_cutoff
    type:
      - 'null'
      - int
    doc: Coverage cutoff for local alignment
    inputBinding:
      position: 102
      prefix: -c
  - id: database
    type:
      - 'null'
      - string
    doc: 'Database: vmh or seed'
    inputBinding:
      position: 102
      prefix: -d
  - id: disable_parallel
    type:
      - 'null'
      - boolean
    doc: "Do not use parallel (Deprecated: use '-K 1' instead to disable multi-threading.)"
    inputBinding:
      position: 102
      prefix: -k
  - id: ec_numbers
    type: string
    doc: Search by ec numbers (comma separated)
    inputBinding:
      position: 102
      prefix: -e
  - id: enzyme_name
    type:
      - 'null'
      - string
    doc: Search by enzyme name (colon separated)
    inputBinding:
      position: 102
      prefix: -r
  - id: exhaustive_search
    type:
      - 'null'
      - boolean
    doc: Exhaustive search, continue blast even when cutoff is reached
    inputBinding:
      position: 102
      prefix: -g
  - id: force_offline_mode
    type:
      - 'null'
      - boolean
    doc: Force offline mode
    inputBinding:
      position: 102
      prefix: -O
  - id: identity_cutoff
    type:
      - 'null'
      - int
    doc: Identity cutoff for local alignment
    inputBinding:
      position: 102
      prefix: -i
  - id: include_sequences_in_logs
    type:
      - 'null'
      - boolean
    doc: Include sequences of hits in log files
    inputBinding:
      position: 102
      prefix: -q
  - id: input_genome_mode
    type:
      - 'null'
      - string
    doc: Input genome mode. Either 'nucl', 'prot', or 'auto'
    inputBinding:
      position: 102
      prefix: -M
  - id: keyword
    type: string
    doc: Keywords such as pathways or subsystems (for example 
      amino,nucl,cofactor,carbo,polyamine)
    inputBinding:
      position: 102
      prefix: -p
  - id: limit_pathways_to_taxonomy
    type:
      - 'null'
      - boolean
    doc: Limit pathways to taxonomic range
    inputBinding:
      position: 102
      prefix: -m
  - id: list_only_pathways
    type:
      - 'null'
      - boolean
    doc: Only list pathways found for keyword
    inputBinding:
      position: 102
      prefix: -o
  - id: no_blast_list_pathways
    type:
      - 'null'
      - boolean
    doc: Do not blast only list pathways, reactions and check for available 
      sequences
    inputBinding:
      position: 102
      prefix: -x
  - id: no_gapseq_archive
    type:
      - 'null'
      - boolean
    doc: Do not use gapseq sequence archive and update sequences from uniprot 
      manually (very slow)
    inputBinding:
      position: 102
      prefix: -U
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Path to directory, where output files will be saved
    inputBinding:
      position: 102
      prefix: -f
  - id: output_suffix
    type:
      - 'null'
      - string
    doc: Suffix used for output files
    inputBinding:
      position: 102
      prefix: -u
  - id: pathway_database
    type:
      - 'null'
      - string
    doc: Select the pathway database (MetaCyc, KEGG, SEED, all)
    inputBinding:
      position: 102
      prefix: -l
  - id: print_annotation_genome_coverage
    type:
      - 'null'
      - boolean
    doc: Print annotation genome coverage
    inputBinding:
      position: 102
      prefix: -y
  - id: quit_if_output_exists
    type:
      - 'null'
      - boolean
    doc: Quit if output files already exist
    inputBinding:
      position: 102
      prefix: -j
  - id: sequence_quality
    type:
      - 'null'
      - int
    doc: 'Quality of sequences for homology search: 1:only reviewed (swissprot), 2:unreviewed
      only if reviewed not available, 3:reviewed+unreviewed, 4:only unreviewed'
    inputBinding:
      position: 102
      prefix: -z
  - id: strict_candidate_handling
    type:
      - 'null'
      - boolean
    doc: Strict candidate reaction handling (do _not_ use pathway completeness, 
      key kenzymes and operon structure to infere if imcomplete pathway could be
      still present)
    inputBinding:
      position: 102
      prefix: -s
  - id: taxonomy
    type:
      - 'null'
      - string
    doc: 'Taxonomic range for reference sequences to be used. (Bacteria, Archaea,
      auto; default: Bacteria). See Details.'
    inputBinding:
      position: 102
      prefix: -t
  - id: temp_folder
    type:
      - 'null'
      - Directory
    doc: Set user-defined temporary folder
    inputBinding:
      position: 102
      prefix: -T
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads for sequence alignments. If option is not provided, 
      number of available CPUs will be automatically determined.
    inputBinding:
      position: 102
      prefix: -K
  - id: use_gene_name_sequences
    type:
      - 'null'
      - boolean
    doc: Use additional sequences derived from gene names
    inputBinding:
      position: 102
      prefix: -w
  - id: verbose_level
    type:
      - 'null'
      - int
    doc: Verbose level, 0 for nothing, 1 for pathway infos, 2 for full
    inputBinding:
      position: 102
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gapseq:1.4.0--h9ee0642_1
stdout: gapseq_find.out
