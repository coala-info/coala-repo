cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gapseq
  - find
label: gapseq_find
doc: "Pathway analysis, try to find enzymes based on homology.

Tool homepage: https://github.com/jotech/gapseq"
inputs:
  - id: pathways
    type:
      - 'null'
      - string
    doc: "keywords such as pathways or subsystems (for example amino,nucl,cofactor,carbo,polyamine)"
    inputBinding:
      position: 101
      prefix: -p
  - id: ec_numbers
    type:
      - 'null'
      - string
    doc: "Search by ec numbers (comma separated)"
    inputBinding:
      position: 101
      prefix: -e
  - id: enzyme_name
    type:
      - 'null'
      - string
    doc: "Search by enzyme name (colon separated)"
    inputBinding:
      position: 101
      prefix: -r
  - id: database
    type:
      - 'null'
      - string
    doc: "Database: vmh or seed (default: seed)"
    inputBinding:
      position: 101
      prefix: -d
  - id: taxonomy
    type:
      - 'null'
      - string
    doc: "Taxonomic range for reference sequences to be used (Bacteria, Archaea, auto; default: Bacteria)"
    inputBinding:
      position: 101
      prefix: -t
  - id: bit_score_cutoff
    type:
      - 'null'
      - int
    doc: "Bit score cutoff for local alignment (default: 200)"
    inputBinding:
      position: 101
      prefix: -b
  - id: identity_cutoff
    type:
      - 'null'
      - int
    doc: "Identity cutoff for local alignment (default: 0)"
    inputBinding:
      position: 101
      prefix: -i
  - id: coverage_cutoff
    type:
      - 'null'
      - int
    doc: "Coverage cutoff for local alignment (default: 75)"
    inputBinding:
      position: 101
      prefix: -c
  - id: strict_candidate_handling
    type:
      - 'null'
      - boolean
    doc: "Strict candidate reaction handling (do not use pathway completeness, key enzymes and operon structure to infer if incomplete pathway could be still present)"
    inputBinding:
      position: 101
      prefix: -s
  - id: output_suffix
    type:
      - 'null'
      - string
    doc: "Suffix used for output files (default: pathway keyword)"
    inputBinding:
      position: 101
      prefix: -u
  - id: blast_back_uniprot
    type:
      - 'null'
      - boolean
    doc: "Blast hits back against uniprot enzyme database"
    inputBinding:
      position: 101
      prefix: -a
  - id: consider_superpathways
    type:
      - 'null'
      - boolean
    doc: "Consider superpathways of metacyc database"
    inputBinding:
      position: 101
      prefix: -n
  - id: pathway_database
    type:
      - 'null'
      - string
    doc: "Select the pathway database (MetaCyc, KEGG, SEED, all; default: metacyc,custom)"
    inputBinding:
      position: 101
      prefix: -l
  - id: list_only_pathways
    type:
      - 'null'
      - boolean
    doc: "Only list pathways found for keyword"
    inputBinding:
      position: 101
      prefix: -o
  - id: no_blast
    type:
      - 'null'
      - boolean
    doc: "Do not blast, only list pathways, reactions and check for available sequences"
    inputBinding:
      position: 101
      prefix: -x
  - id: include_sequences_in_logs
    type:
      - 'null'
      - boolean
    doc: "Include sequences of hits in log files"
    inputBinding:
      position: 101
      prefix: -q
  - id: verbose_level
    type:
      - 'null'
      - int
    doc: "Verbose level, 0 for nothing, 1 for pathway infos, 2 for full (default: 1)"
    inputBinding:
      position: 101
      prefix: -v
  - id: disable_parallel
    type:
      - 'null'
      - boolean
    doc: "Do not use parallel (deprecated: use threads 1 instead)"
    inputBinding:
      position: 101
      prefix: -k
  - id: exhaustive_search
    type:
      - 'null'
      - boolean
    doc: "Exhaustive search, continue blast even when cutoff is reached"
    inputBinding:
      position: 101
      prefix: -g
  - id: sequence_quality
    type:
      - 'null'
      - int
    doc: "Quality of sequences for homology search: 1 only reviewed (swissprot), 2 unreviewed only if reviewed not available, 3 reviewed+unreviewed, 4 only unreviewed (default: 2)"
    inputBinding:
      position: 101
      prefix: -z
  - id: limit_taxonomic_range
    type:
      - 'null'
      - string
    doc: "Limit pathways to taxonomic range (default: all)"
    inputBinding:
      position: 101
      prefix: -m
  - id: use_gene_name_sequences
    type:
      - 'null'
      - boolean
    doc: "Use additional sequences derived from gene names"
    inputBinding:
      position: 101
      prefix: -w
  - id: print_annotation_genome_coverage
    type:
      - 'null'
      - boolean
    doc: "Print annotation genome coverage"
    inputBinding:
      position: 101
      prefix: -y
  - id: quit_if_output_exists
    type:
      - 'null'
      - boolean
    doc: "Quit if output files already exist"
    inputBinding:
      position: 101
      prefix: -j
  - id: output_dir
    type:
      - 'null'
      - string
    doc: "Path to directory, where output files will be saved (default: current directory)"
    inputBinding:
      position: 101
      prefix: -f
  - id: no_gapseq_archive
    type:
      - 'null'
      - boolean
    doc: "Do not use gapseq sequence archive and update sequences from uniprot manually (very slow)"
    inputBinding:
      position: 101
      prefix: -U
  - id: temp_folder
    type:
      - 'null'
      - string
    doc: "Set user-defined temporary folder"
    inputBinding:
      position: 101
      prefix: -T
  - id: force_offline_mode
    type:
      - 'null'
      - boolean
    doc: "Force offline mode"
    inputBinding:
      position: 101
      prefix: -O
  - id: genome_mode
    type:
      - 'null'
      - string
    doc: "Input genome mode. Either nucl, prot, or auto (default: auto)"
    inputBinding:
      position: 101
      prefix: -M
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads for sequence alignments (default: number of available CPUs)"
    inputBinding:
      position: 101
      prefix: -K
  - id: genome
    type: File
    doc: "Genome sequence in FASTA format (nucleotide or protein, optionally gzipped)"
    inputBinding:
      position: 200
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: result_tables
    type:
      type: array
      items: File
    doc: "Reaction and pathway tables written by gapseq find"
    outputBinding:
      glob:
        - "*-Reactions.tbl"
        - "*-Pathways.tbl"
  - id: output_dir_dir
    type:
      - 'null'
      - Directory
    doc: "Output directory when output_dir is given"
    outputBinding:
      glob: $(inputs.output_dir)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - '${ if (inputs.output_dir) { return [{class: "Directory", basename: inputs.output_dir, listing: [], writable: true}]; } else { return []; } }'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gapseq:1.4.0--h9ee0642_1
stdout: gapseq_find.out
