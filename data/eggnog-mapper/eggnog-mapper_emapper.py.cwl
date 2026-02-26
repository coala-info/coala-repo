cwlVersion: v1.2
class: CommandLineTool
baseCommand: emapper.py
label: eggnog-mapper_emapper.py
doc: "EggNOG-mapper: functional annotation of novel and known proteins.\n\nTool homepage:
  https://github.com/jhcepas/eggnog-mapper"
inputs:
  - id: allow_overlaps
    type:
      - 'null'
      - string
    doc: When using 'blastx'-based genepred (--genepred search --itype 
      genome/metagenome) this option controls whether overlapping hits are 
      reported or not, or if only those overlapping hits in a different strand 
      or frame are reported. Also, the degree of accepted overlap can be 
      controlled with --overlap_tol.
    default: none
    inputBinding:
      position: 101
      prefix: --allow_overlaps
  - id: annotate_hits_table
    type:
      - 'null'
      - File
    doc: 'Annotate TSV formatted table with 4 fields: query, hit, evalue, score. Usually,
      a .seed_orthologs file from a previous emapper.py run. Requires -m no_search.'
    inputBinding:
      position: 101
      prefix: --annotate_hits_table
  - id: block_size
    type:
      - 'null'
      - int
    doc: Diamond -b/--block-size option. Default is the diamond's default.
    inputBinding:
      position: 101
      prefix: --block_size
  - id: cache_file
    type:
      - 'null'
      - File
    doc: File containing annotations and md5 hashes of queries, to be used as 
      cache. Required if -m cache
    inputBinding:
      position: 101
      prefix: --cache_file
  - id: clean_overlaps
    type:
      - 'null'
      - string
    doc: Removes those hits which overlap, keeping only the one with best 
      evalue. Use the "all" and "clans" options when performing a hmmscan type 
      search (i.e. domains are in the database). Use the "hmmsearch_all" and 
      "hmmsearch_clans" options when using a hmmsearch type search (i.e. domains
      are the queries from -i file). The "clans" and "hmmsearch_clans" and 
      options will only have effect for hits to/from Pfam.
    inputBinding:
      position: 101
      prefix: --clean_overlaps
  - id: cpu
    type:
      - 'null'
      - int
    doc: Number of CPUs to be used. --cpu 0 to run with all available CPUs.
    default: 1
    inputBinding:
      position: 101
      prefix: --cpu
  - id: cut_ga
    type:
      - 'null'
      - boolean
    doc: Adds the --cut_ga to hmmer commands (useful for Pfam mappings, for 
      example). See hmmer documentation.
    default: false
    inputBinding:
      position: 101
      prefix: --cut_ga
  - id: data_dir
    type:
      - 'null'
      - Directory
    doc: Path to eggnog-mapper databases. By default, "data/" or the path 
      specified in the environment variable EGGNOG_DATA_DIR.
    inputBinding:
      position: 101
      prefix: --data_dir
  - id: db_size
    type:
      - 'null'
      - int
    doc: Fixed database size used in phmmer/hmmscan (allows comparing e-values 
      among databases).
    default: 40000000
    inputBinding:
      position: 101
      prefix: --Z
  - id: dbmem
    type:
      - 'null'
      - boolean
    doc: Use this option to allocate the whole eggnog.db DB in memory. Database 
      will be unloaded after execution.
    default: false
    inputBinding:
      position: 101
      prefix: --dbmem
  - id: dbtype
    type:
      - 'null'
      - string
    doc: Type of data in DB (-db).
    default: hmmdb
    inputBinding:
      position: 101
      prefix: --dbtype
  - id: decorate_gff
    type:
      - 'null'
      - string
    doc: Add search hits and/or annotation results to GFF file from gene 
      prediction of a user specified one. no = no GFF decoration at all. GFF 
      file from blastx-based gene prediction will be created anyway. yes = add 
      search hits and/or annotations to GFF file from Prodigal or blastx-based 
      gene prediction. FILE = decorate the specified pre-existing GFF FILE. e.g.
      --decorage_gff myfile.gff You change the field interpreted as ID of the 
      feature with --decorate_gff_ID_field.
    default: no
    inputBinding:
      position: 101
      prefix: --decorate_gff
  - id: decorate_gff_id_field
    type:
      - 'null'
      - string
    doc: Change the field used in GFF files as ID of the feature.
    default: ID
    inputBinding:
      position: 101
      prefix: --decorate_gff_ID_field
  - id: dmnd_algo
    type:
      - 'null'
      - string
    doc: Diamond's --algo option, which can be tuned to search small query sets.
      By default, it is adjusted automatically. However, the ctg option should 
      be activated manually. If you plan to search a small input set of 
      sequences, use --dmnd_algo ctg to make it faster.
    default: auto
    inputBinding:
      position: 101
      prefix: --dmnd_algo
  - id: dmnd_db
    type:
      - 'null'
      - File
    doc: Path to DIAMOND-compatible database
    inputBinding:
      position: 101
      prefix: --dmnd_db
  - id: dmnd_frameshift
    type:
      - 'null'
      - int
    doc: 'Diamond --frameshift/-F option. Not used by default. Recommended by diamond:
      15.'
    inputBinding:
      position: 101
      prefix: --dmnd_frameshift
  - id: dmnd_ignore_warnings
    type:
      - 'null'
      - boolean
    doc: Diamond --ignore-warnings option. It avoids Diamond stopping due to 
      warnings (e.g. when a protein contains only ATGC symbols.
    default: false
    inputBinding:
      position: 101
      prefix: --dmnd_ignore_warnings
  - id: dmnd_iterate
    type:
      - 'null'
      - string
    doc: --dmnd_iterate yes --> activates the --iterate option of diamond for 
      iterative searches, from faster, less sensitive modes, up to the 
      sensitivity specified with --sensmode. Available since diamond 2.0.11. 
      --dmnd_iterate no --> disables the --iterate mode.
    default: yes
    inputBinding:
      position: 101
      prefix: --dmnd_iterate
  - id: end_port
    type:
      - 'null'
      - int
    doc: Last port to be used to setup HMM server, when --usemem. Also used for 
      --pfam_realign modes.
    default: 53200
    inputBinding:
      position: 101
      prefix: --end_port
  - id: evalue
    type:
      - 'null'
      - float
    doc: Report only alignments below or equal the e-value threshold.
    default: 0.001
    inputBinding:
      position: 101
      prefix: --evalue
  - id: excel
    type:
      - 'null'
      - boolean
    doc: Output annotations also in .xlsx format.
    default: false
    inputBinding:
      position: 101
      prefix: --excel
  - id: excluded_taxa
    type:
      - 'null'
      - string
    doc: Orthologs from the specified comma-separated list of taxa and all its 
      descendants will not be used for annotation transference. By default, no 
      taxa is excluded.
    inputBinding:
      position: 101
      prefix: --excluded_taxa
  - id: final_sens
    type:
      - 'null'
      - int
    doc: Final sensititivy step.
    default: 7
    inputBinding:
      position: 101
      prefix: --final_sens
  - id: gapextend
    type:
      - 'null'
      - int
    doc: Gap extend penalty
    inputBinding:
      position: 101
      prefix: --gapextend
  - id: gapopen
    type:
      - 'null'
      - int
    doc: Gap open penalty
    inputBinding:
      position: 101
      prefix: --gapopen
  - id: genepred
    type:
      - 'null'
      - string
    doc: 'This is applied when --itype genome or --itype metagenome. search: gene
      prediction is inferred from Diamond/MMseqs2 blastx hits. prodigal: gene prediction
      is performed using Prodigal.'
    default: search
    inputBinding:
      position: 101
      prefix: --genepred
  - id: go_evidence
    type:
      - 'null'
      - string
    doc: Defines what type of GO terms should be used for annotation. 
      experimental = Use only terms inferred from experimental evidence. 
      non-electronic = Use only non-electronically curated terms
    default: non-electronic
    inputBinding:
      position: 101
      prefix: --go_evidence
  - id: hmm_maxhits
    type:
      - 'null'
      - int
    doc: Max number of hits to report (0 to report all).
    default: 1
    inputBinding:
      position: 101
      prefix: --hmm_maxhits
  - id: hmm_maxseqlen
    type:
      - 'null'
      - int
    doc: Ignore query sequences larger than `maxseqlen`.
    default: 5000
    inputBinding:
      position: 101
      prefix: --hmm_maxseqlen
  - id: hmmer_db_prefix
    type:
      - 'null'
      - string
    doc: 'specify the target database for sequence searches. Choose among: euk,bact,arch,
      or a database loaded in a server, db.hmm:host:port (see hmm_server.py)'
    inputBinding:
      position: 101
      prefix: --hmmer_db_prefix
  - id: index_chunks
    type:
      - 'null'
      - int
    doc: Diamond -c/--index-chunks option. Default is the diamond's default.
    inputBinding:
      position: 101
      prefix: --index_chunks
  - id: input_fasta_file
    type:
      - 'null'
      - File
    doc: Input FASTA file containing query sequences (proteins by default; see 
      --itype and --translate). Required unless -m no_search.
    inputBinding:
      position: 101
      prefix: --input_fasta_file
  - id: itype
    type:
      - 'null'
      - string
    doc: Type of data in the input (-i) file.
    default: proteins
    inputBinding:
      position: 101
      prefix: --itype
  - id: list_taxa
    type:
      - 'null'
      - boolean
    doc: List taxa available for --tax_scope/--tax_scope_mode, and exit
    inputBinding:
      position: 101
      prefix: --list_taxa
  - id: matrix
    type:
      - 'null'
      - string
    doc: Scoring matrix
    inputBinding:
      position: 101
      prefix: --matrix
  - id: md5
    type:
      - 'null'
      - boolean
    doc: Adds the md5 hash of each query as an additional field in annotations 
      output files.
    default: false
    inputBinding:
      position: 101
      prefix: --md5
  - id: mmseqs_db
    type:
      - 'null'
      - File
    doc: Path to MMseqs2-compatible database
    inputBinding:
      position: 101
      prefix: --mmseqs_db
  - id: mmseqs_sub_mat
    type:
      - 'null'
      - string
    doc: Matrix to be used for --sub-mat MMseqs2 search option. Default=default 
      used by MMseqs2
    inputBinding:
      position: 101
      prefix: --mmseqs_sub_mat
  - id: mp_start_method
    type:
      - 'null'
      - string
    doc: Sets the python multiprocessing start method. Check 
      https://docs.python.org/3/library/multiprocessing.html. Only use if the 
      default method is not working properly in your OS.
    default: spawn
    inputBinding:
      position: 101
      prefix: --mp_start_method
  - id: no_annot
    type:
      - 'null'
      - boolean
    doc: Skip functional annotation, reporting only hits.
    default: false
    inputBinding:
      position: 101
      prefix: --no_annot
  - id: no_file_comments
    type:
      - 'null'
      - boolean
    doc: No header lines nor stats are included in the output files
    default: false
    inputBinding:
      position: 101
      prefix: --no_file_comments
  - id: num_servers
    type:
      - 'null'
      - int
    doc: When using --usemem, specify the number of servers to fire up.Note that
      cpus specified with --cpu will be distributed among servers and workers. 
      Also used for --pfam_realign modes.
    default: 1
    inputBinding:
      position: 101
      prefix: --num_servers
  - id: num_workers
    type:
      - 'null'
      - int
    doc: When using --usemem, specify the number of workers per server 
      (--num_servers) to fire up. By default, cpus specified with --cpu will be 
      distributed among servers and workers. Also used for --pfam_realign modes.
    default: 1
    inputBinding:
      position: 101
      prefix: --num_workers
  - id: outfmt_short
    type:
      - 'null'
      - boolean
    doc: Diamond output will include only qseqid sseqid evalue and score. This 
      could help obtain better performance, if also no --pident, --query_cover 
      or --subject_cover thresholds are used. This option is ignored when the 
      diamond search is run in blastx mode for gene prediction (see --genepred).
    default: false
    inputBinding:
      position: 101
      prefix: --outfmt_short
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Where output files should be written
    default: /
    inputBinding:
      position: 101
      prefix: --output_dir
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: base name for output files
    inputBinding:
      position: 101
      prefix: --output_prefix
  - id: overlap_tol
    type:
      - 'null'
      - float
    doc: 'This value (0-1) is the proportion such that if (overlap size / hit length)
      > overlap_tol, hits are considered to overlap. e.g: if overlap_tol is 0.0, any
      overlap is considered as such. e.g: if overlap_tol is 1.0, one of the hits must
      overlap entirely to consider that hits do overlap.'
    default: 0.0
    inputBinding:
      position: 101
      prefix: --overlap_tol
  - id: override
    type:
      - 'null'
      - boolean
    doc: Overwrites output files if they exist. By default, execution is aborted
      if conflicting files are detected.
    default: false
    inputBinding:
      position: 101
      prefix: --override
  - id: pfam_realign
    type:
      - 'null'
      - string
    doc: Realign the queries to the PFAM domains. none = no realignment is 
      performed. PFAM annotation will be that transferred as specify in the 
      --pfam_transfer option. realign = queries will be realigned to the PFAM 
      domains found according to the --pfam_transfer option. denovo = queries 
      will be realigned to the whole PFAM database, ignoring the --pfam_transfer
      option. Check hmmer options (--num_servers, --num_workers, --port, 
      --end_port) to change how the hmmpgmd server is run.
    default: none
    inputBinding:
      position: 101
      prefix: --pfam_realign
  - id: pident
    type:
      - 'null'
      - float
    doc: Report only alignments above or equal to the given percentage of 
      identity (0-100).No effect if -m hmmer.
    inputBinding:
      position: 101
      prefix: --pident
  - id: port
    type:
      - 'null'
      - int
    doc: Port used to setup HMM server, when --usemem. Also used for 
      --pfam_realign modes.
    default: 51700
    inputBinding:
      position: 101
      prefix: --port
  - id: qtype
    type:
      - 'null'
      - string
    doc: Type of input data (-i).
    default: seq
    inputBinding:
      position: 101
      prefix: --qtype
  - id: query_cover
    type:
      - 'null'
      - float
    doc: Report only alignments above or equal the given percentage of query 
      cover (0-100).No effect if -m hmmer.
    inputBinding:
      position: 101
      prefix: --query_cover
  - id: report_no_hits
    type:
      - 'null'
      - boolean
    doc: Whether queries without hits should be included in the output table.
    default: false
    inputBinding:
      position: 101
      prefix: --report_no_hits
  - id: report_orthologs
    type:
      - 'null'
      - boolean
    doc: Output the list of orthologs found for each query to a .orthologs file
    default: false
    inputBinding:
      position: 101
      prefix: --report_orthologs
  - id: resume
    type:
      - 'null'
      - boolean
    doc: Resumes a previous emapper run, skipping results in existing output 
      files.
    default: false
    inputBinding:
      position: 101
      prefix: --resume
  - id: score
    type:
      - 'null'
      - float
    doc: Report only alignments above or equal the score threshold.
    inputBinding:
      position: 101
      prefix: --score
  - id: scratch_dir
    type:
      - 'null'
      - Directory
    doc: Write output files in a temporary scratch dir, move them to the final 
      output dir when finished. Speed up large computations using network file 
      systems.
    inputBinding:
      position: 101
      prefix: --scratch_dir
  - id: search_mode
    type:
      - 'null'
      - string
    doc: 'diamond: search seed orthologs using diamond (-i is required). mmseqs: search
      seed orthologs using MMseqs2 (-i is required). hmmer: search seed orthologs
      using HMMER. (-i is required). no_search: skip seed orthologs search (--annotate_hits_table
      is required, unless --no_annot). cache: skip seed orthologs search and annotate
      based on cached results (-i and -c are required).novel_fams: search against
      the novel families database (-i is required).'
    default: diamond
    inputBinding:
      position: 101
      prefix: --search_mode
  - id: seed_ortholog_evalue
    type:
      - 'null'
      - float
    doc: Min E-value expected when searching for seed eggNOG ortholog. Queries 
      not having a significant seed orthologs will not be annotated.
    default: 0.001
    inputBinding:
      position: 101
      prefix: --seed_ortholog_evalue
  - id: seed_ortholog_score
    type:
      - 'null'
      - float
    doc: Min bit score expected when searching for seed eggNOG ortholog. Queries
      not having a significant seed orthologs will not be annotated.
    inputBinding:
      position: 101
      prefix: --seed_ortholog_score
  - id: sens_steps
    type:
      - 'null'
      - int
    doc: Number of sensitivity steps.
    default: 3
    inputBinding:
      position: 101
      prefix: --sens_steps
  - id: sensmode
    type:
      - 'null'
      - string
    doc: Diamond's sensitivity mode. Note that emapper's default is sensitive, 
      which is different from diamond's default, which can be activated with 
      --sensmode default.
    default: sensitive
    inputBinding:
      position: 101
      prefix: --sensmode
  - id: servers_list
    type:
      - 'null'
      - File
    doc: A FILE with a list of remote hmmpgmd servers. Each row in the file 
      represents a server, in the format 'host:port'. If --servers_list is 
      specified, host and port from -d option will be ignored.
    inputBinding:
      position: 101
      prefix: --servers_list
  - id: start_sens
    type:
      - 'null'
      - int
    doc: Starting sensitivity.
    default: 3
    inputBinding:
      position: 101
      prefix: --start_sens
  - id: subject_cover
    type:
      - 'null'
      - float
    doc: Report only alignments above or equal the given percentage of subject 
      cover (0-100).No effect if -m hmmer.
    inputBinding:
      position: 101
      prefix: --subject_cover
  - id: target_orthologs
    type:
      - 'null'
      - string
    doc: defines what type of orthologs (in relation to the seed ortholog) 
      should be used for functional transfer
    default: all
    inputBinding:
      position: 101
      prefix: --target_orthologs
  - id: target_taxa
    type:
      - 'null'
      - string
    doc: Only orthologs from the specified comma-separated list of taxa and all 
      its descendants will be used for annotation transference. By default, all 
      taxa are used.
    inputBinding:
      position: 101
      prefix: --target_taxa
  - id: tax_scope
    type:
      - 'null'
      - string
    doc: "Fix the taxonomic scope used for annotation, so only speciation events from
      a particular clade are used for functional transfer. More specifically, the
      --tax_scope list is intersected with the seed orthologs clades, and the resulting
      clades are used for annotation based on --tax_scope_mode. Note that those seed
      orthologs without clades intersecting with --tax_scope will be filtered out,
      and won't annotated. Possible arguments for --tax_scope are: 1) A path to a
      file defined by the user, which contains a list of tax IDs and/or tax names.
      2) The name of a pre-configured tax scope, whose source is a file stored within
      the 'eggnogmapper/annotation/tax_scopes/' directory By default, available ones
      are: 'auto' ('all'), 'auto_broad' ('all_broad'), 'all_narrow', 'archaea', 'bacteria',
      'bacteria_broad', 'eukaryota', 'eukaryota_broad' and 'prokaryota_broad'.3) A
      comma-separated list of taxonomic names and/or taxonomic IDs, sorted by preference.
      An example of list of tax IDs would be 2759,2157,2,1 for Eukaryota, Archaea,
      Bacteria and root, in that order of preference. 4) 'none': do not filter out
      annotations based on taxonomic scope."
    default: auto
    inputBinding:
      position: 101
      prefix: --tax_scope
  - id: tax_scope_mode
    type:
      - 'null'
      - string
    doc: 'For a seed ortholog which passed the filter imposed by --tax_scope, --tax_scope_mode
      controls which specific clade, to which the seed ortholog belongs, will be used
      for annotation. Options: 1) broadest: use the broadest clade. 2) inner_broadest:
      use the broadest clade from the intersection with --tax_scope. 3) inner_narrowest:
      use the narrowest clade from the intersection with --tax_scope. 4) narrowest:
      use the narrowest clade. 5) A taxonomic scope as in --tax_scope: use this second
      list to intersect with seed ortholog clades and use the narrowest (as in inner_narrowest)
      from the intersection to annotate.'
    default: inner_narrowest
    inputBinding:
      position: 101
      prefix: --tax_scope_mode
  - id: temp_dir
    type:
      - 'null'
      - Directory
    doc: Where temporary files are created. Better if this is a local disk.
    default: /
    inputBinding:
      position: 101
      prefix: --temp_dir
  - id: timeout_load_server
    type:
      - 'null'
      - int
    doc: Number of attempts to load a server on a specific port. If failed, the 
      next numerical port will be tried.
    default: 10
    inputBinding:
      position: 101
      prefix: --timeout_load_server
  - id: training_file
    type:
      - 'null'
      - File
    doc: A training file from Prodigal training mode. If this parameter is used,
      Prodigal will run using this training file to analyze the emapper input 
      data. Only used if --genepred prodigal.
    inputBinding:
      position: 101
      prefix: --training_file
  - id: training_genome
    type:
      - 'null'
      - File
    doc: 'A genome to run Prodigal in training mode. If this parameter is used, Prodigal
      will run in two steps: firstly in training mode, and secondly using the training
      to analize the emapper input data. See Prodigal documentation about Traning
      mode for more info. Only used if --genepred prodigal.'
    inputBinding:
      position: 101
      prefix: --training_genome
  - id: trans_table
    type:
      - 'null'
      - string
    doc: This option will be used for Prodigal, Diamond or MMseqs2, depending on
      the mode. For Diamond searches, this option corresponds to the 
      --query-gencode option. For MMseqs2 searches, this option corresponds to 
      the --translation-table option. For Prodigal, this option corresponds to 
      the -g/--trans_table option. It is also used when --translate, check 
      https://biopython.org/docs/1.75/api/Bio.Seq.html#Bio.Seq.Seq.translate. 
      Default is the corresponding programs defaults.
    inputBinding:
      position: 101
      prefix: --trans_table
  - id: translate
    type:
      - 'null'
      - boolean
    doc: When --itype CDS, translate CDS to proteins before search. When --itype
      genome/metagenome and --genepred search, translate predicted CDS from 
      blastx hits to proteins.
    default: false
    inputBinding:
      position: 101
      prefix: --translate
  - id: usemem
    type:
      - 'null'
      - boolean
    doc: Use this option to allocate the whole database (-d) in memory using 
      hmmpgmd. If --dbtype hmm, the database must be a hmmpress-ed database. If 
      --dbtype seqdb, the database must be a HMMER-format database created with 
      esl-reformat. Database will be unloaded after execution. Note that this 
      only works for HMMER based searches. To load the eggnog-mapper annotation 
      DB into memory use --dbmem.
    default: false
    inputBinding:
      position: 101
      prefix: --usemem
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/eggnog-mapper:2.1.13--pyhdfd78af_2
stdout: eggnog-mapper_emapper.py.out
