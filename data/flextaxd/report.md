# flextaxd CWL Generation Report

## flextaxd

### Tool Description
FlexTaxD taxonomy sqlite3 database file (fullpath)

### Metadata
- **Docker Image**: quay.io/biocontainers/flextaxd:0.4.4--pyhdfd78af_0
- **Homepage**: https://github.com/FOI-Bioinformatics/flextaxd
- **Package**: https://anaconda.org/channels/bioconda/packages/flextaxd/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/flextaxd/overview
- **Total Downloads**: 39.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/FOI-Bioinformatics/flextaxd
- **Stars**: N/A
### Original Help Text
```text
usage: flextaxd [-h] [-db] [-o] [--dump] [--dump_mini] [--force] [--validate]
                [--stats] [-tf] [-tt] [--taxid_base] [-mf] [-md] [-gt] [-gp]
                [--rename_from] [--rename_to] [-p] [--replace]
                [--clean_database] [--skip_annotation] [--refdatabase]
                [--purge_database] [--purge_database_force] [--dbprogram]
                [--dump_prefix] [--dump_sep] [--dump_descriptions]
                [--dump_genomes] [--dump_genome_annotations] [--vis_node]
                [--vis_type] [--vis_depth] [--vis_label_size]
                [--vis_clip_labels] [--logs] [--verbose] [--debug] [--supress]
                [--quiet]

options:
  -h, --help            show this help message and exit

required:
  Required

  -db , --database , --db 
                        FlexTaxD taxonomy sqlite3 database file (fullpath)

basic:
  Basic commands

  -o , --outdir         Output directory
  --dump                Write database to names.dmp and nodes.dmp
  --dump_mini           Dump minimal file with tab as separator
  --force               use when script is implemented in pipeline to avoid
                        security questions on overwrite!
  --validate            Validate database format
  --stats               Print some statistics from the database

read_opts:
  Source options

  -tf , --taxonomy_file 
                        Taxonomy source file
  -tt , --taxonomy_type 
                        Source format of taxonomy input file
                        (CanSNPer,GTDB,NCBI,QIIME,SILVA)
  --taxid_base          The base for internal taxonomy ID numbers, when using
                        NCBI as base select base at minimum 3000000 (default =
                        1)

mod_opts:
  Database modification options

  -mf , --mod_file      File contaning modifications parent,child,(taxonomy
                        level)
  -md , --mod_database , --mod_db 
                        Database file containing modifications
  -gt , --genomeid2taxid 
                        File that lists which node a genome should be assigned
                        to
  -gp , --genomes_path 
                        Path to genome folder is required when using
                        NCBI_taxonomy as source
  --rename_from         Updates a node name. Must be paired with --rename_to
  --rename_to           Updates a node name. Must be paired with --rename_from
  -p , --parent         Parent from which to add (replace see below) branch
  --replace             Add if existing children of parents should be removed!
  --clean_database, --clean_db
                        Clean up database from unannotated nodes
  --skip_annotation     Do not automatically add annotation when creating GTDB
                        database
  --refdatabase         For download command, give value of expected source,
                        default (refseq)
  --purge_database , --purge_db 
                        Used to purge the FlexTaxD-database from entries that
                        lack a downloaded genome (such as when creating a
                        GTDB-database using all taxonomy but using just the
                        representative dataset) Provide the directory path of
                        the downloaded genomes (default = FALSE)
  --purge_database_force, --purge_db_force
                        If specified, will remove all genomes that are missing
                        from the FlexTaxD-database, regardless if they are
                        distinct nodes or not in the tree (default = FALSE)

output_opts:
  Output options

  --dbprogram , --db_program 
                        Adjust output file to certain output specifications
                        [kraken2, krakenuniq, ganon, centrifuge, bracken]
  --dump_prefix         change dump prefix reqires two names
                        default(names,nodes)
  --dump_sep            Set output separator default(NCBI) also adds extra
                        trailing columns for kraken
  --dump_descriptions   Dump description names instead of database integers
  --dump_genomes        Print list of genomes (and source) to file
  --dump_genome_annotations
                        Add genome taxid annotation to genomes dump

vis_opts:
  Visualisation options

  --vis_node , --visualise_node 
                        Visualise tree from selected node
  --vis_type            Choices [newick, newick_vis, tree]
  --vis_depth           Maximum depth from node to visualise default 3, 0 =
                        all levels
  --vis_label_size      Adjusts the size of labels printed at drawn tree nodes
  --vis_clip_labels     If specified, will clip long node names in the drawn
                        tree

Logging and debug options:
  --logs                Specify log directory
  --verbose             Verbose output
  --debug               Debug output
  --supress             Supress warnings
  --quiet               Dont show logging messages in terminal!
```

