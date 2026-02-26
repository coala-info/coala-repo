# protgraph CWL Generation Report

## protgraph

### Tool Description
A tool for protein graph generation and peptide export from sequence data.

### Metadata
- **Docker Image**: quay.io/biocontainers/protgraph:0.3.12--pyhdfd78af_0
- **Homepage**: https://github.com/mpc-bioinformatics/ProtGraph
- **Package**: https://anaconda.org/channels/bioconda/packages/protgraph/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/protgraph/overview
- **Total Downloads**: 23.5K
- **Last updated**: 2026-01-17
- **GitHub**: https://github.com/mpc-bioinformatics/ProtGraph
- **Stars**: N/A
### Original Help Text
```text
usage: protgraph [--help] [--num_of_entries NUM_OF_ENTRIES]
                 [--exclude_accessions EXCLUDE_ACCESSIONS]
                 [--num_of_processes NUM_OF_PROCESSES]
                 [--output_csv OUTPUT_CSV]
                 [--output_csv_layout OUTPUT_CSV_LAYOUT] [--no_description]
                 [--help_all] [--help_graph_generation]
                 [--feature_table {ALL,NONE,INIT_MET,VARIANT,VAR_SEQ,SIGNAL,MUTAGEN,CONFLICT,PEPTIDE,PROPEP,CHAIN}]
                 [--replace_aa REPLACE_AA] [--fixed_mod FIXED_MOD]
                 [--variable_mod VARIABLE_MOD] [--verify_graph]
                 [--digestion {gluc,trypsin,skip,full}] [--no_merge]
                 [--no_collapsing_edges] [--annotate_mono_weights]
                 [--annotate_avrg_weights] [--annotate_mono_weight_to_end]
                 [--annotate_avrg_weight_to_end]
                 [--mass_dict_type {int,float}]
                 [--mass_dict_factor MASS_DICT_FACTOR]
                 [--queue_size QUEUE_SIZE] [--help_statistics]
                 [--calc_num_possibilities]
                 [--calc_num_possibilities_miscleavages]
                 [--calc_num_possibilities_hops]
                 [--calc_num_possibilities_variant]
                 [--calc_num_possibilities_mutagen]
                 [--calc_num_possibilities_conflict]
                 [--calc_num_possibilities_or_count {<built-in function min>,<built-in function max>}]
                 [--help_graph_exports]
                 [--export_output_folder EXPORT_OUTPUT_FOLDER]
                 [--export_in_directories] [--export_dot] [--export_csv]
                 [--export_large_csv] [--export_graphml] [--export_gml]
                 [--export_pickle] [--export_pcsr]
                 [--export_pcsr_pdb_entries EXPORT_PCSR_PDB_ENTRIES]
                 [--export_large_pcsr]
                 [--export_large_pcsr_pdb_entries EXPORT_LARGE_PCSR_PDB_ENTRIES]
                 [--export_binary_pcsr]
                 [--export_binary_pcsr_pdb_entries EXPORT_BINARY_PCSR_PDB_ENTRIES]
                 [--export_large_binary_pcsr]
                 [--export_large_binary_pcsr_pdb_entries EXPORT_LARGE_BINARY_PCSR_PDB_ENTRIES]
                 [--pcsr_feature_to_count {INIT_MET,VARIANT,VAR_SEQ,SIGNAL,MUTAGEN,CONFLICT,PEPTIDE,PROPEP,CHAIN,VARMOD,FIXMOD}]
                 [--help_redis_graph_export] [--export_redisgraph]
                 [--redisgraph_host REDISGRAPH_HOST]
                 [--redisgraph_port REDISGRAPH_PORT]
                 [--redisgraph_graph REDISGRAPH_GRAPH]
                 [--help_postgres_graph_export] [--export_postgres]
                 [--postgres_host POSTGRES_HOST]
                 [--postgres_port POSTGRES_PORT]
                 [--postgres_user POSTGRES_USER]
                 [--postgres_password POSTGRES_PASSWORD]
                 [--postgres_database POSTGRES_DATABASE]
                 [--help_mysql_graph_export] [--export_mysql]
                 [--mysql_host MYSQL_HOST] [--mysql_port MYSQL_PORT]
                 [--mysql_user MYSQL_USER] [--mysql_password MYSQL_PASSWORD]
                 [--mysql_database MYSQL_DATABASE]
                 [--help_cassandra_graph_export] [--export_cassandra]
                 [--cassandra_host CASSANDRA_HOST]
                 [--cassandra_port CASSANDRA_PORT]
                 [--cassandra_keyspace CASSANDRA_KEYSPACE]
                 [--cassandra_chunk_size CASSANDRA_CHUNK_SIZE]
                 [--help_peptide_export_traversal_options]
                 [--pep_hops PEP_HOPS] [--pep_miscleavages PEP_MISCLEAVAGES]
                 [--pep_skip_x] [--pep_use_igraph]
                 [--pep_min_pep_length PEP_MIN_PEP_LENGTH]
                 [--pep_batch_size PEP_BATCH_SIZE]
                 [--pep_min_weight PEP_MIN_WEIGHT]
                 [--pep_max_weight PEP_MAX_WEIGHT]
                 [--help_postgres_peptide_export] [--export_peptide_postgres]
                 [--pep_postgres_host PEP_POSTGRES_HOST]
                 [--pep_postgres_port PEP_POSTGRES_PORT]
                 [--pep_postgres_user PEP_POSTGRES_USER]
                 [--pep_postgres_password PEP_POSTGRES_PASSWORD]
                 [--pep_postgres_database PEP_POSTGRES_DATABASE]
                 [--pep_postgres_no_duplicates] [--help_mysql_peptide_export]
                 [--export_peptide_mysql] [--pep_mysql_host PEP_MYSQL_HOST]
                 [--pep_mysql_port PEP_MYSQL_PORT]
                 [--pep_mysql_user PEP_MYSQL_USER]
                 [--pep_mysql_password PEP_MYSQL_PASSWORD]
                 [--pep_mysql_database PEP_MYSQL_DATABASE]
                 [--pep_mysql_no_duplicates] [--help_citus_peptide_export]
                 [--export_peptide_citus] [--pep_citus_host PEP_CITUS_HOST]
                 [--pep_citus_port PEP_CITUS_PORT]
                 [--pep_citus_user PEP_CITUS_USER]
                 [--pep_citus_password PEP_CITUS_PASSWORD]
                 [--pep_citus_database PEP_CITUS_DATABASE]
                 [--pep_citus_no_duplicates] [--help_sqlite_peptide_export]
                 [--export_peptide_sqlite]
                 [--pep_sqlite_database PEP_SQLITE_DATABASE]
                 [--pep_sqlite_output_dir PEP_SQLITE_OUTPUT_DIR]
                 [--pep_sqlite_non_compact]
                 [--pep_sqlite_compression_level PEP_SQLITE_COMPRESSION_LEVEL]
                 [--pep_sqlite_use_blobs] [--help_fasta_peptide_export]
                 [--export_peptide_fasta] [--pep_fasta_out PEP_FASTA_OUT]
                 [--help_trie_peptide_export] [--export_peptide_trie]
                 [--pep_trie_folder_out PEP_TRIE_FOLDER_OUT]
                 [--help_gremlin_graph_export] [--export_gremlin]
                 [--gremlin_url GREMLIN_URL]
                 [--gremlin_traversal_source GREMLIN_TRAVERSAL_SOURCE]
                 files [files ...]
protgraph: error: ambiguous option: --h could match --help, --help_all, --help_graph_generation, --help_statistics, --help_graph_exports, --help_redis_graph_export, --help_postgres_graph_export, --help_mysql_graph_export, --help_cassandra_graph_export, --help_peptide_export_traversal_options, --help_postgres_peptide_export, --help_mysql_peptide_export, --help_citus_peptide_export, --help_sqlite_peptide_export, --help_fasta_peptide_export, --help_trie_peptide_export, --help_gremlin_graph_export
```

