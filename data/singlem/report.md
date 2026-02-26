# singlem CWL Generation Report

## singlem_data

### Tool Description
Download reference metapackage data

### Metadata
- **Docker Image**: quay.io/biocontainers/singlem:0.20.3--pyhdfd78af_2
- **Homepage**: https://github.com/wwood/singlem
- **Package**: https://anaconda.org/channels/bioconda/packages/singlem/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/singlem/overview
- **Total Downloads**: 16.4K
- **Last updated**: 2026-01-27
- **GitHub**: https://github.com/wwood/singlem
- **Stars**: N/A
### Original Help Text
```text
usage: singlem data [-h] [--output-directory OUTPUT_DIRECTORY] [--verify-only]
                    [--debug] [--version] [--quiet] [--full-help]
                    [--full-help-roff]

Download reference metapackage data

options:
  -h, --help            show this help message and exit
  --output-directory OUTPUT_DIRECTORY
                        Output directory [required unless
                        SINGLEM_METAPACKAGE_PATH is specified]
  --verify-only         Check that the data is up to date and each file has
                        the correct checksum

Other general options:
  --debug               output debug information
  --version             output version information and quit
  --quiet               only output errors
  --full-help, --full_help
                        print longer help message
  --full-help-roff, --full_help_roff
                        print longer help message in ROFF (manpage) format
```


## singlem_pipe

### Tool Description
Generate a taxonomic profile or OTU table from raw sequences

### Metadata
- **Docker Image**: quay.io/biocontainers/singlem:0.20.3--pyhdfd78af_2
- **Homepage**: https://github.com/wwood/singlem
- **Package**: https://anaconda.org/channels/bioconda/packages/singlem/overview
- **Validation**: PASS

### Original Help Text
```text
usage: singlem pipe [-h] [-1 sequence_file [sequence_file ...]]
                    [-2 sequence_file [sequence_file ...]]
                    [-f PATH [PATH ...]] [-d PATH] [--genome-fasta-list PATH]
                    [-x EXT] [-p FILE] [--taxonomic-profile-krona FILE]
                    [--otu-table filename] [--threads num_threads]
                    [--assignment-method {smafa_naive_then_diamond,scann_naive_then_diamond,annoy_then_diamond,scann_then_diamond,diamond,diamond_example,annoy,pplacer}]
                    [--output-extras] [--archive-otu-table filename]
                    [--metapackage METAPACKAGE]
                    [--sra-files sra_file [sra_file ...]]
                    [--read-chunk-size num_reads]
                    [--read-chunk-number chunk_number]
                    [--output-jplace filename]
                    [--singlem-packages SINGLEM_PACKAGES [SINGLEM_PACKAGES ...]]
                    [--assignment-singlem-db ASSIGNMENT_SINGLEM_DB]
                    [--diamond-taxonomy-assignment-performance-parameters DIAMOND_TAXONOMY_ASSIGNMENT_PERFORMANCE_PARAMETERS]
                    [--evalue EVALUE] [--min-orf-length length]
                    [--restrict-read-length length]
                    [--translation-table number]
                    [--filter-minimum-protein length]
                    [--max-species-divergence INT] [--exclude-off-target-hits]
                    [--min-taxon-coverage FLOAT]
                    [--working-directory directory]
                    [--working-directory-dev-shm] [--force]
                    [--filter-minimum-nucleotide length] [--include-inserts]
                    [--known-otu-tables KNOWN_OTU_TABLES [KNOWN_OTU_TABLES ...]]
                    [--no-assign-taxonomy] [--known-sequence-taxonomy FILE]
                    [--no-diamond-prefilter]
                    [--diamond-prefilter-performance-parameters DIAMOND_PREFILTER_PERFORMANCE_PARAMETERS]
                    [--hmmsearch-package-assignment]
                    [--diamond-prefilter-db DIAMOND_PREFILTER_DB]
                    [--assignment-threads ASSIGNMENT_THREADS]
                    [--sleep-after-mkfifo SLEEP_AFTER_MKFIFO] [--debug]
                    [--version] [--quiet] [--full-help] [--full-help-roff]

Generate a taxonomic profile or OTU table from raw sequences

options:
  -h, --help            show this help message and exit

Common options:
  -1 sequence_file [sequence_file ...], --forward sequence_file [sequence_file ...], --reads sequence_file [sequence_file ...], --sequences sequence_file [sequence_file ...]
                        nucleotide read sequence(s) (forward or unpaired) to
                        be searched. Can be FASTA or FASTQ format, GZIP-
                        compressed or not, short or long (but Nanopore
                        >=10.4.1 or PacBio HiFi reads recommended).
  -2 sequence_file [sequence_file ...], --reverse sequence_file [sequence_file ...]
                        reverse reads to be searched. Can be FASTA or FASTQ
                        format, GZIP-compressed or not.
  -f PATH [PATH ...], --genome-fasta-files PATH [PATH ...]
                        Path(s) to genome FASTA files. These are processed
                        like input given with --forward, but use higher
                        default values for --min-taxon-coverage and --min-orf-
                        length.
  -d PATH, --genome-fasta-directory PATH
                        Directory containing genome FASTA files. Treated
                        identically to --forward input with higher default
                        values for --min-taxon-coverage and --min-orf-length.
  --genome-fasta-list PATH
                        File containing genome FASTA paths, one per line.
                        Behaviour matches --forward with higher default values
                        for --min-taxon-coverage and --min-orf-length.
  -x EXT, --genome-fasta-extension EXT
                        File extension of genomes in the directory specified
                        with -d/--genome-fasta-directory. [default: fna]
  -p FILE, --taxonomic-profile FILE
                        output a 'condensed' taxonomic profile for each sample
                        based on the OTU table. Taxonomic profiles output can
                        be further converted to other formats using singlem
                        summarise.
  --taxonomic-profile-krona FILE
                        output a 'condensed' taxonomic profile for each sample
                        based on the OTU table
  --otu-table filename  output OTU table
  --threads num_threads
                        number of CPUS to use [default: 1]
  --assignment-method {smafa_naive_then_diamond,scann_naive_then_diamond,annoy_then_diamond,scann_then_diamond,diamond,diamond_example,annoy,pplacer}, --assignment_method {smafa_naive_then_diamond,scann_naive_then_diamond,annoy_then_diamond,scann_then_diamond,diamond,diamond_example,annoy,pplacer}
                        Method of assigning taxonomy to OTUs and taxonomic
                        profiles [default: smafa_naive_then_diamond] .TS
                        tab(@); l l . T{ Method T}@T{ Description T} _ T{
                        smafa_naive_then_diamond T}@T{ Search for the most
                        similar window sequences <= 3bp different using a
                        brute force algorithm (using the smafa implementation)
                        over all window sequences in the database, and if none
                        are found use DIAMOND blastx of all reads from each
                        OTU. T} T{ scann_naive_then_diamond T}@T{ Search for
                        the most similar window sequences <= 3bp different
                        using a brute force algorithm over all window
                        sequences in the database, and if none are found use
                        DIAMOND blastx of all reads from each OTU. T} T{
                        annoy_then_diamond T}@T{ Same as
                        scann_naive_then_diamond, except search using ANNOY
                        rather than using brute force. Requires a non-standard
                        metapackage. T} T{ scann_then_diamond T}@T{ Same as
                        scann_naive_then_diamond, except search using SCANN
                        rather than using brute force. Requires a non-standard
                        metapackage. T} T{ diamond T}@T{ DIAMOND blastx best
                        hit(s) of all reads from each OTU. T} T{
                        diamond_example T}@T{ DIAMOND blastx best hit(s) of
                        all reads from each OTU, but report the best hit as a
                        sequence ID instead of a taxonomy. T} T{ annoy T}@T{
                        Search for the most similar window sequences <= 3bp
                        different using ANNOY, otherwise no taxonomy is
                        assigned. Requires a non-standard metapackage. T} T{
                        pplacer T}@T{ Use pplacer to assign taxonomy of each
                        read in each OTU. Requires a non-standard metapackage.
                        T} .TE
  --output-extras       give extra output for each sequence identified (e.g.
                        the read(s) each OTU was generated from) in the output
                        OTU table [default: not set]

Less common options:
  --archive-otu-table filename
                        output OTU table in archive format for making DBs etc.
                        [default: unused]
  --metapackage METAPACKAGE
                        Set of SingleM packages to use [default: use the
                        default set]
  --sra-files sra_file [sra_file ...]
                        "sra" format files (usually from NCBI SRA) to be
                        searched
  --read-chunk-size num_reads
                        Size chunk to process at a time (in number of reads).
                        Requires --sra-files.
  --read-chunk-number chunk_number
                        Process only this specific chunk number (1-based
                        index). Requires --sra-files.
  --output-jplace filename
                        Output a jplace format file for each singlem package
                        to a file starting with this string, each with one
                        entry per OTU. Requires 'pplacer' as the
                        --assignment_method [default: unused]
  --singlem-packages SINGLEM_PACKAGES [SINGLEM_PACKAGES ...]
                        SingleM packages to use [default: use the set from the
                        default metapackage]
  --assignment-singlem-db ASSIGNMENT_SINGLEM_DB, --assignment_singlem_db ASSIGNMENT_SINGLEM_DB
                        Use this SingleM DB when assigning taxonomy [default:
                        not set, use the default]
  --diamond-taxonomy-assignment-performance-parameters DIAMOND_TAXONOMY_ASSIGNMENT_PERFORMANCE_PARAMETERS
                        Performance-type arguments to use when calling
                        'diamond blastx' during the taxonomy assignment step.
                        [default: use setting defined in metapackage when set,
                        otherwise use '--block-size 0.5 --target-indexed -c1']
  --evalue EVALUE       HMMSEARCH e-value cutoff to use for sequence gathering
                        [default: 1e-05]
  --min-orf-length length
                        When predicting ORFs require this many base pairs
                        uninterrupted by a stop codon [default: 72 for reads,
                        300 for genomes]
  --restrict-read-length length
                        Only use this many base pairs at the start of each
                        sequence searched [default: no restriction]
  --translation-table number
                        Codon table for translation. By default, translation
                        table 4 is used, which is the same as translation
                        table 11 (the usual bacterial/archaeal one), except
                        that the TGA codon is translated as tryptophan, not as
                        a stop codon. Using table 4 means that the minority of
                        organisms which use table 4 are not biased against,
                        without a significant effect on the majority of
                        bacteria and archaea that use table 11. See http://www
                        .ncbi.nlm.nih.gov/Taxonomy/taxonomyhome.html/index.cgi
                        ?chapter=tgencodes for details on specific tables.
                        [default: 4]
  --filter-minimum-protein length
                        Ignore reads aligning in less than this many positions
                        to each protein HMM when using --no-diamond-prefilter
                        [default: 24]
  --max-species-divergence INT
                        Maximum number of different bases acids to allow
                        between a sequence and the best hit in the database so
                        that it is assigned to the species level. [default: 2]
  --exclude-off-target-hits
                        Exclude hits that are not in the target domain of each
                        SingleM package
  --min-taxon-coverage FLOAT
                        Minimum coverage to report in a taxonomic profile.
                        [default: 0.35 for reads, 0.1 for genomes]
  --working-directory directory
                        use intermediate working directory at a specified
                        location, and do not delete it upon completion
                        [default: not set, use a temporary directory]
  --working-directory-dev-shm
                        use an intermediate results temporary working
                        directory in /dev/shm rather than the default
                        [default: the usual temporary working directory,
                        currently /tmp]
  --force               overwrite working directory if required [default: not
                        set]
  --filter-minimum-nucleotide length
                        Ignore reads aligning in less than this many positions
                        to each nucleotide HMM [default: 72]
  --include-inserts     print the entirety of the sequences in the OTU table,
                        not just the aligned nucleotides [default: not set]
  --known-otu-tables KNOWN_OTU_TABLES [KNOWN_OTU_TABLES ...]
                        OTU tables previously generated with trusted
                        taxonomies for each sequence [default: unused]
  --no-assign-taxonomy  Do not assign any taxonomy except for those already
                        known [default: not set]
  --known-sequence-taxonomy FILE
                        A 2-column "sequence<tab>taxonomy" file specifying
                        some sequences that have known taxonomy [default:
                        unused]
  --no-diamond-prefilter
                        Do not parse sequence data through DIAMOND blastx
                        using a database constructed from the set of singlem
                        packages. Should be used with --hmmsearch-package-
                        assignment. NOTE: ignored for nucleotide packages
                        [default: protein packages: use the prefilter,
                        nucleotide packages: do not use the prefilter]
  --diamond-prefilter-performance-parameters DIAMOND_PREFILTER_PERFORMANCE_PARAMETERS
                        Performance-type arguments to use when calling
                        'diamond blastx' during the prefiltering. By default,
                        SingleM should run in <4GB of RAM except in very large
                        (>100Gbp) metagenomes. [default: use setting defined
                        in metapackage when set, otherwise use '--block-size
                        0.5 --target-indexed -c1']
  --hmmsearch-package-assignment, --hmmsearch_package_assignment
                        Assign each sequence to a SingleM package using
                        HMMSEARCH, and a sequence may then be assigned to
                        multiple packages. [default: not set]
  --diamond-prefilter-db DIAMOND_PREFILTER_DB
                        Use this DB when running DIAMOND prefilter [default:
                        use the one in the metapackage, or generate one from
                        the SingleM packages]
  --assignment-threads ASSIGNMENT_THREADS
                        Use this many processes in parallel while assigning
                        taxonomy [default: 1]
  --sleep-after-mkfifo SLEEP_AFTER_MKFIFO
                        Sleep for this many seconds after running os.mkfifo
                        [default: None]

Other general options:
  --debug               output debug information
  --version             output version information and quit
  --quiet               only output errors
  --full-help, --full_help
                        print longer help message
  --full-help-roff, --full_help_roff
                        print longer help message in ROFF (manpage) format
```


## singlem_sequences

### Tool Description
singlem: error: argument subparser_name: invalid choice: 'sequences' (choose from data, pipe, appraise, seqs, makedb, query, summarise, prokaryotic_fraction, microbial_fraction, renew, create, get_tree, regenerate, metapackage, chainsaw, condense, trim_package_hmms, supplement)

### Metadata
- **Docker Image**: quay.io/biocontainers/singlem:0.20.3--pyhdfd78af_2
- **Homepage**: https://github.com/wwood/singlem
- **Package**: https://anaconda.org/channels/bioconda/packages/singlem/overview
- **Validation**: PASS

### Original Help Text
```text
usage: singlem [-h]
               {data,pipe,appraise,seqs,makedb,query,summarise,prokaryotic_fraction,microbial_fraction,renew,create,get_tree,regenerate,metapackage,chainsaw,condense,trim_package_hmms,supplement}
               ...
singlem: error: argument subparser_name: invalid choice: 'sequences' (choose from data, pipe, appraise, seqs, makedb, query, summarise, prokaryotic_fraction, microbial_fraction, renew, create, get_tree, regenerate, metapackage, chainsaw, condense, trim_package_hmms, supplement)
```


## singlem_appraise

### Tool Description
How much of the metagenome do the genomes or assembly represent?

### Metadata
- **Docker Image**: quay.io/biocontainers/singlem:0.20.3--pyhdfd78af_2
- **Homepage**: https://github.com/wwood/singlem
- **Package**: https://anaconda.org/channels/bioconda/packages/singlem/overview
- **Validation**: PASS

### Original Help Text
```text
usage: singlem appraise [-h]
                        [--metagenome-otu-tables METAGENOME_OTU_TABLES [METAGENOME_OTU_TABLES ...]]
                        [--metagenome-archive-otu-tables METAGENOME_ARCHIVE_OTU_TABLES [METAGENOME_ARCHIVE_OTU_TABLES ...]]
                        [--genome-otu-tables GENOME_OTU_TABLES [GENOME_OTU_TABLES ...]]
                        [--genome-archive-otu-tables GENOME_ARCHIVE_OTU_TABLES [GENOME_ARCHIVE_OTU_TABLES ...]]
                        [--assembly-otu-tables ASSEMBLY_OTU_TABLES [ASSEMBLY_OTU_TABLES ...]]
                        [--assembly-archive-otu-tables ASSEMBLY_ARCHIVE_OTU_TABLES [ASSEMBLY_ARCHIVE_OTU_TABLES ...]]
                        [--metapackage METAPACKAGE] [--imperfect]
                        [--sequence-identity SEQUENCE_IDENTITY] [--plot PLOT]
                        [--plot-marker PLOT_MARKER]
                        [--plot-basename PLOT_BASENAME]
                        [--output-binned-otu-table OUTPUT_BINNED_OTU_TABLE]
                        [--output-unbinned-otu-table OUTPUT_UNBINNED_OTU_TABLE]
                        [--output-assembled-otu-table OUTPUT_ASSEMBLED_OTU_TABLE]
                        [--output-unaccounted-for-otu-table OUTPUT_UNACCOUNTED_FOR_OTU_TABLE]
                        [--output-found-in]
                        [--output-style {standard,archive}] [--stream-inputs]
                        [--threads num_threads] [--debug] [--version]
                        [--quiet] [--full-help] [--full-help-roff]

How much of the metagenome do the genomes or assembly represent?

options:
  -h, --help            show this help message and exit

Input OTU table options:
  --metagenome-otu-tables METAGENOME_OTU_TABLES [METAGENOME_OTU_TABLES ...]
                        output of 'pipe' run on metagenomes
  --metagenome-archive-otu-tables METAGENOME_ARCHIVE_OTU_TABLES [METAGENOME_ARCHIVE_OTU_TABLES ...]
                        archive output of 'pipe' run on metagenomes
  --genome-otu-tables GENOME_OTU_TABLES [GENOME_OTU_TABLES ...]
                        output of 'pipe' run on genomes
  --genome-archive-otu-tables GENOME_ARCHIVE_OTU_TABLES [GENOME_ARCHIVE_OTU_TABLES ...]
                        archive output of 'pipe' run on genomes
  --assembly-otu-tables ASSEMBLY_OTU_TABLES [ASSEMBLY_OTU_TABLES ...]
                        output of 'pipe' run on assembled sequence
  --assembly-archive-otu-tables ASSEMBLY_ARCHIVE_OTU_TABLES [ASSEMBLY_ARCHIVE_OTU_TABLES ...]
                        archive output of 'pipe' run on assembled sequence
  --metapackage METAPACKAGE
                        Metapackage used in the creation of the OTU tables

Inexact appraisal options:
  --imperfect           use sequence searching to account for genomes that are
                        similar to those found in the metagenome [default:
                        False]
  --sequence-identity SEQUENCE_IDENTITY
                        sequence identity cutoff to use if --imperfect is
                        specified [default: ~species level divergence i.e.
                        0.9666666666666667]

Plotting-related options:
  --plot PLOT           Output plot SVG filename (marker chosen automatically
                        unless --plot-marker is also specified)
  --plot-marker PLOT_MARKER
                        Marker gene to plot OTUs from
  --plot-basename PLOT_BASENAME
                        Plot visualisation of appraisal results from all
                        markers to this basename (one SVG per marker)

Output summary OTU tables:
  --output-binned-otu-table OUTPUT_BINNED_OTU_TABLE
                        output OTU table of binned populations
  --output-unbinned-otu-table OUTPUT_UNBINNED_OTU_TABLE
                        output OTU table of assembled but not binned
                        populations
  --output-assembled-otu-table OUTPUT_ASSEMBLED_OTU_TABLE
                        output OTU table of all assembled populations
  --output-unaccounted-for-otu-table OUTPUT_UNACCOUNTED_FOR_OTU_TABLE
                        Output OTU table of populations not accounted for
  --output-found-in     Output sample name (genome or assembly) the hit was
                        found in
  --output-style {standard,archive}
                        Style of output OTU tables
  --stream-inputs       Stream input OTU tables, saving RAM. Only works with
                        --output-otu-table and transformation options do not
                        work [expert option].
  --threads num_threads
                        Use this many threads when processing streaming inputs
                        [default 1]

Other general options:
  --debug               output debug information
  --version             output version information and quit
  --quiet               only output errors
  --full-help, --full_help
                        print longer help message
  --full-help-roff, --full_help_roff
                        print longer help message in ROFF (manpage) format
```


## singlem_seqs

### Tool Description
Find the best window position for a SingleM package

### Metadata
- **Docker Image**: quay.io/biocontainers/singlem:0.20.3--pyhdfd78af_2
- **Homepage**: https://github.com/wwood/singlem
- **Package**: https://anaconda.org/channels/bioconda/packages/singlem/overview
- **Validation**: PASS

### Original Help Text
```text
usage: singlem seqs [-h] --alignment aligned_fasta --alignment-type type
                    [--window-size INT] [--hmm HMM] [--debug] [--version]
                    [--quiet] [--full-help] [--full-help-roff]

Find the best window position for a SingleM package

options:
  -h, --help            show this help message and exit
  --alignment aligned_fasta
                        Protein sequences hmmaligned and converted to fasta
                        format with seqmagick
  --alignment-type type
                        alignment is 'aa' or 'dna'
  --window-size INT     Number of nucleotides to use in continuous window
                        [default: 60]
  --hmm HMM             HMM file used to generate alignment, used here to rank
                        windows according to their information content.

Other general options:
  --debug               output debug information
  --version             output version information and quit
  --quiet               only output errors
  --full-help, --full_help
                        print longer help message
  --full-help-roff, --full_help_roff
                        print longer help message in ROFF (manpage) format
```


## singlem_makedb

### Tool Description
Create a searchable OTU sequence database from an OTU table

### Metadata
- **Docker Image**: quay.io/biocontainers/singlem:0.20.3--pyhdfd78af_2
- **Homepage**: https://github.com/wwood/singlem
- **Package**: https://anaconda.org/channels/bioconda/packages/singlem/overview
- **Validation**: PASS

### Original Help Text
```text
usage: singlem makedb [-h] [--otu-tables OTU_TABLES [OTU_TABLES ...]]
                      [--otu-tables-list OTU_TABLES_LIST]
                      [--archive-otu-tables ARCHIVE_OTU_TABLES [ARCHIVE_OTU_TABLES ...]]
                      [--archive-otu-table-list ARCHIVE_OTU_TABLE_LIST]
                      [--gzip-archive-otu-table-list GZIP_ARCHIVE_OTU_TABLE_LIST]
                      --db DB [--threads THREADS]
                      [--sequence-database-methods {smafa-naive,annoy,scann,nmslib,scann-naive,none} [{smafa-naive,annoy,scann,nmslib,scann-naive,none} ...]]
                      [--sequence-database-types {nucleotide,protein} [{nucleotide,protein} ...]]
                      [--pregenerated-otu-sqlite-db PREGENERATED_OTU_SQLITE_DB]
                      [--num-annoy-nucleotide-trees NUM_ANNOY_NUCLEOTIDE_TREES]
                      [--num-annoy-protein-trees NUM_ANNOY_PROTEIN_TREES]
                      [--tmpdir TMPDIR] [--debug] [--version] [--quiet]
                      [--full-help] [--full-help-roff]

Create a searchable OTU sequence database from an OTU table

options:
  -h, --help            show this help message and exit

required arguments:
  --otu-tables OTU_TABLES [OTU_TABLES ...], --otu-table OTU_TABLES [OTU_TABLES ...]
                        Make a db from these OTU tables
  --otu-tables-list OTU_TABLES_LIST
                        Make a db from the OTU table files newline separated
                        in this file
  --archive-otu-tables ARCHIVE_OTU_TABLES [ARCHIVE_OTU_TABLES ...], --archive-otu-table ARCHIVE_OTU_TABLES [ARCHIVE_OTU_TABLES ...]
                        Make a db from these archive tables
  --archive-otu-table-list ARCHIVE_OTU_TABLE_LIST
                        Make a db from the archive tables newline separated in
                        this file
  --gzip-archive-otu-table-list GZIP_ARCHIVE_OTU_TABLE_LIST
                        Make a db from the gzip'd archive tables newline
                        separated in this file
  --db DB               Name of database to create e.g. tundra.sdb

Other arguments:
  --threads THREADS     Use this many threads where possible [default 1]
  --sequence-database-methods {smafa-naive,annoy,scann,nmslib,scann-naive,none} [{smafa-naive,annoy,scann,nmslib,scann-naive,none} ...]
                        Index sequences using these methods. Note that
                        specifying "scann-naive" means "scann" databases will
                        also be built [default ['smafa-naive']]
  --sequence-database-types {nucleotide,protein} [{nucleotide,protein} ...]
                        Index sequences using these types. [default:
                        ['nucleotide']]
  --pregenerated-otu-sqlite-db PREGENERATED_OTU_SQLITE_DB
                        [for internal usage] remake the indices using this
                        input SQLite database
  --num-annoy-nucleotide-trees NUM_ANNOY_NUCLEOTIDE_TREES
                        make annoy nucleotide sequence indices with this
                        ntrees [default 10]
  --num-annoy-protein-trees NUM_ANNOY_PROTEIN_TREES
                        make annoy protein sequence indices with this ntrees
                        [default 10]
  --tmpdir TMPDIR       [for internal usage] use this directory internally for
                        working

Other general options:
  --debug               output debug information
  --version             output version information and quit
  --quiet               only output errors
  --full-help, --full_help
                        print longer help message
  --full-help-roff, --full_help_roff
                        print longer help message in ROFF (manpage) format
```


## singlem_table

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/singlem:0.20.3--pyhdfd78af_2
- **Homepage**: https://github.com/wwood/singlem
- **Package**: https://anaconda.org/channels/bioconda/packages/singlem/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
usage: singlem [-h]
               {data,pipe,appraise,seqs,makedb,query,summarise,prokaryotic_fraction,microbial_fraction,renew,create,get_tree,regenerate,metapackage,chainsaw,condense,trim_package_hmms,supplement}
               ...
singlem: error: argument subparser_name: invalid choice: 'table' (choose from data, pipe, appraise, seqs, makedb, query, summarise, prokaryotic_fraction, microbial_fraction, renew, create, get_tree, regenerate, metapackage, chainsaw, condense, trim_package_hmms, supplement)
```


## singlem_query

### Tool Description
Find closely related sequences in a SingleM database.

### Metadata
- **Docker Image**: quay.io/biocontainers/singlem:0.20.3--pyhdfd78af_2
- **Homepage**: https://github.com/wwood/singlem
- **Package**: https://anaconda.org/channels/bioconda/packages/singlem/overview
- **Validation**: PASS

### Original Help Text
```text
usage: singlem query [-h] --db DB [--query-otu-table file [file ...]]
                     [--query-otu-tables-list QUERY_OTU_TABLES_LIST]
                     [--query-archive-otu-tables QUERY_ARCHIVE_OTU_TABLES [QUERY_ARCHIVE_OTU_TABLES ...]]
                     [--query-archive-otu-table-list QUERY_ARCHIVE_OTU_TABLE_LIST]
                     [--query-gzip-archive-otu-table-list QUERY_GZIP_ARCHIVE_OTU_TABLE_LIST]
                     [--max-nearest-neighbours MAX_NEAREST_NEIGHBOURS]
                     [--max-divergence INT]
                     [--search-method {smafa-naive,nmslib,annoy,scann,scann-naive}]
                     [--sequence-type {nucleotide,protein}]
                     [--max-search-nearest-neighbours MAX_SEARCH_NEAREST_NEIGHBOURS]
                     [--threads THREADS]
                     [--limit-per-sequence LIMIT_PER_SEQUENCE] [--preload-db]
                     [--sample-names name [name ...]] [--sample-list path]
                     [--taxonomy name] [--dump] [--continue-on-missing-genes]
                     [--debug] [--version] [--quiet] [--full-help]
                     [--full-help-roff]

Find closely related sequences in a SingleM database.

options:
  -h, --help            show this help message and exit

Required arguments:
  --db DB               Output from 'makedb' mode

Database querying by OTU sequence:
  --query-otu-table file [file ...], --query-otu-tables file [file ...]
                        Query the database with all sequences in this OTU
                        table
  --query-otu-tables-list QUERY_OTU_TABLES_LIST
                        Query the database with all sequences in OTU table
                        files newline separated in this file
  --query-archive-otu-tables QUERY_ARCHIVE_OTU_TABLES [QUERY_ARCHIVE_OTU_TABLES ...]
                        Query the database with all sequences in these archive
                        tables
  --query-archive-otu-table-list QUERY_ARCHIVE_OTU_TABLE_LIST
                        Query the database with all sequences in archive
                        tables newline separated in this file
  --query-gzip-archive-otu-table-list QUERY_GZIP_ARCHIVE_OTU_TABLE_LIST
                        Query the database with all sequences in gzip'd
                        archive tables newline separated in this file
  --max-nearest-neighbours MAX_NEAREST_NEIGHBOURS
                        How many nearest neighbours to report. Each neighbour
                        is a distinct sequence from the DB. [default: 20]
  --max-divergence INT  Report sequences less than or equal to this divergence
                        i.e. number of different bases/amino acids
  --search-method {smafa-naive,nmslib,annoy,scann,scann-naive}
                        Algorithm to perform search [default: smafa-naive]
  --sequence-type {nucleotide,protein}
                        Which sequence types to compare (i.e. protein for
                        blastp, nucleotide for blastn) [default: nucleotide]
  --max-search-nearest-neighbours MAX_SEARCH_NEAREST_NEIGHBOURS
                        How many nearest neighbours to search for with
                        approximate nearest neighbours. Of these hits, only
                        --max-nearest-neighbours will actually be reported.
                        Ignored for --search-method naive and scann-naive.
                        [default: 100]
  --threads THREADS     Use this many threads where possible [default 1]
  --limit-per-sequence LIMIT_PER_SEQUENCE
                        How many entries (samples/genomes from DB with
                        identical sequences) to report for each distinct,
                        matched sequence (arbitrarily chosen) [default: No
                        limit]
  --preload-db          Cache all DB data in python-land instead of querying
                        for it by SQL each time. This is faster particularly
                        for querying many sequences, but uses more memory and
                        has a larger start-up time for each marker gene.

Other database extraction methods:
  --sample-names name [name ...]
                        Print all OTUs from these samples
  --sample-list path    Print all OTUs from the samples listed in the file
                        (newline-separated)
  --taxonomy name       Print all OTUs assigned a taxonomy including this
                        string e.g. 'Archaea'
  --dump                Print all OTUs in the DB
  --continue-on-missing-genes
                        Continue if a gene is missing from the DB. Only works
                        with smafa/nuclotide search method.

Other general options:
  --debug               output debug information
  --version             output version information and quit
  --quiet               only output errors
  --full-help, --full_help
                        print longer help message
  --full-help-roff, --full_help_roff
                        print longer help message in ROFF (manpage) format
```


## singlem_summarise

### Tool Description
Summarise single-cell RNA-seq data

### Metadata
- **Docker Image**: quay.io/biocontainers/singlem:0.20.3--pyhdfd78af_2
- **Homepage**: https://github.com/wwood/singlem
- **Package**: https://anaconda.org/channels/bioconda/packages/singlem/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/singlem", line 9, in <module>
    sys.exit(main())
             ^^^^^^
  File "/usr/local/lib/python3.12/site-packages/singlem/main.py", line 756, in main
    args = bird_argparser.parse_the_args()
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.12/site-packages/bird_tool_utils/argparsing.py", line 218, in parse_the_args
    args = self._child_parser.parse_args()
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.12/argparse.py", line 1904, in parse_args
    args, argv = self.parse_known_args(args, namespace)
                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.12/argparse.py", line 1914, in parse_known_args
    return self._parse_known_args2(args, namespace, intermixed=False)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.12/argparse.py", line 1943, in _parse_known_args2
    namespace, args = self._parse_known_args(args, namespace, intermixed)
                      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.12/argparse.py", line 2165, in _parse_known_args
    positionals_end_index = consume_positionals(start_index)
                            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.12/argparse.py", line 2141, in consume_positionals
    take_action(action, args)
  File "/usr/local/lib/python3.12/argparse.py", line 2018, in take_action
    action(self, namespace, argument_values, option_string)
  File "/usr/local/lib/python3.12/argparse.py", line 1272, in __call__
    subnamespace, arg_strings = parser.parse_known_args(arg_strings, None)
                                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.12/argparse.py", line 1914, in parse_known_args
    return self._parse_known_args2(args, namespace, intermixed=False)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.12/argparse.py", line 1943, in _parse_known_args2
    namespace, args = self._parse_known_args(args, namespace, intermixed)
                      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.12/argparse.py", line 2184, in _parse_known_args
    start_index = consume_optional(start_index)
                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.12/argparse.py", line 2113, in consume_optional
    take_action(action, args, option_string)
  File "/usr/local/lib/python3.12/argparse.py", line 2018, in take_action
    action(self, namespace, argument_values, option_string)
  File "/usr/local/lib/python3.12/argparse.py", line 1148, in __call__
    parser.print_help()
  File "/usr/local/lib/python3.12/argparse.py", line 2621, in print_help
    self._print_message(self.format_help(), file)
                        ^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.12/argparse.py", line 2605, in format_help
    return formatter.format_help()
           ^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.12/argparse.py", line 286, in format_help
    help = self._root_section.format_help()
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.12/argparse.py", line 217, in format_help
    item_help = join([func(*args) for func, args in self.items])
                      ^^^^^^^^^^^
  File "/usr/local/lib/python3.12/argparse.py", line 217, in format_help
    item_help = join([func(*args) for func, args in self.items])
                      ^^^^^^^^^^^
  File "/usr/local/lib/python3.12/argparse.py", line 546, in _format_action
    help_text = self._expand_help(action)
                ^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.12/argparse.py", line 640, in _expand_help
    return self._get_help_string(action) % params
           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~
ValueError: unsupported format character ']' (0x5d) at index 109
```


## singlem_prokaryotic_fraction

### Tool Description
Estimate the fraction of reads from a metagenome that are assigned to Bacteria and Archaea compared to e.g. eukaryote or phage. Also estimate average genome size.

### Metadata
- **Docker Image**: quay.io/biocontainers/singlem:0.20.3--pyhdfd78af_2
- **Homepage**: https://github.com/wwood/singlem
- **Package**: https://anaconda.org/channels/bioconda/packages/singlem/overview
- **Validation**: PASS

### Original Help Text
```text
usage: singlem prokaryotic_fraction [-h] -p INPUT_PROFILE
                                    [-1 sequence_file [sequence_file ...]]
                                    [-2 sequence_file [sequence_file ...]]
                                    [--input-metagenome-sizes INPUT_METAGENOME_SIZES]
                                    [--taxon-genome-lengths-file TAXON_GENOME_LENGTHS_FILE]
                                    [--metapackage METAPACKAGE]
                                    [--accept-missing-samples]
                                    [--output-tsv OUTPUT_TSV]
                                    [--output-per-taxon-read-fractions OUTPUT_PER_TAXON_READ_FRACTIONS]
                                    [--debug] [--version] [--quiet]
                                    [--full-help] [--full-help-roff]

Estimate the fraction of reads from a metagenome that are assigned to Bacteria
and Archaea compared to e.g. eukaryote or phage. Also estimate average genome
size.

options:
  -h, --help            show this help message and exit

input:
  -p INPUT_PROFILE, --input-profile INPUT_PROFILE
                        Input taxonomic profile file [required]

Read information [1+ args required]:
  -1 sequence_file [sequence_file ...], --forward sequence_file [sequence_file ...], --reads sequence_file [sequence_file ...], --sequences sequence_file [sequence_file ...]
                        nucleotide read sequence(s) (forward or unpaired) to
                        be searched. Can be FASTA or FASTQ format, GZIP-
                        compressed or not. These must be the same ones that
                        were used to generate the input profile.
  -2 sequence_file [sequence_file ...], --reverse sequence_file [sequence_file ...]
                        reverse reads to be searched. Can be FASTA or FASTQ
                        format, GZIP-compressed or not. These must be the same
                        reads that were used to generate the input profile.
  --input-metagenome-sizes INPUT_METAGENOME_SIZES
                        TSV file with 'sample' and 'num_bases' as a header,
                        where sample matches the input profile name, and
                        num_reads is the total number (forward+reverse) of
                        bases in the metagenome that was analysed with 'pipe'.
                        These must be the same reads that were used to
                        generate the input profile.

database:
  --taxon-genome-lengths-file TAXON_GENOME_LENGTHS_FILE
                        TSV file with 'rank' and 'genome_size' as headers
                        [default: Use genome lengths from the default
                        metapackage]
  --metapackage METAPACKAGE
                        Metapackage containing genome lengths [default: Use
                        genome lengths from the default metapackage]

other options:
  --accept-missing-samples
                        If a sample is missing from the input-metagenome-sizes
                        file, skip analysis of it without croaking.
  --output-tsv OUTPUT_TSV
                        Output file [default: stdout]
  --output-per-taxon-read-fractions OUTPUT_PER_TAXON_READ_FRACTIONS
                        Output a fraction for each taxon to this TSV [default:
                        Do not output anything]

Other general options:
  --debug               output debug information
  --version             output version information and quit
  --quiet               only output errors
  --full-help, --full_help
                        print longer help message
  --full-help-roff, --full_help_roff
                        print longer help message in ROFF (manpage) format
```


## singlem_Estimate

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/singlem:0.20.3--pyhdfd78af_2
- **Homepage**: https://github.com/wwood/singlem
- **Package**: https://anaconda.org/channels/bioconda/packages/singlem/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
usage: singlem [-h]
               {data,pipe,appraise,seqs,makedb,query,summarise,prokaryotic_fraction,microbial_fraction,renew,create,get_tree,regenerate,metapackage,chainsaw,condense,trim_package_hmms,supplement}
               ...
singlem: error: argument subparser_name: invalid choice: 'Estimate' (choose from data, pipe, appraise, seqs, makedb, query, summarise, prokaryotic_fraction, microbial_fraction, renew, create, get_tree, regenerate, metapackage, chainsaw, condense, trim_package_hmms, supplement)
```


## singlem_are

### Tool Description
singlem: error: argument subparser_name: invalid choice: 'are' (choose from data, pipe, appraise, seqs, makedb, query, summarise, prokaryotic_fraction, microbial_fraction, renew, create, get_tree, regenerate, metapackage, chainsaw, condense, trim_package_hmms, supplement)

### Metadata
- **Docker Image**: quay.io/biocontainers/singlem:0.20.3--pyhdfd78af_2
- **Homepage**: https://github.com/wwood/singlem
- **Package**: https://anaconda.org/channels/bioconda/packages/singlem/overview
- **Validation**: PASS

### Original Help Text
```text
usage: singlem [-h]
               {data,pipe,appraise,seqs,makedb,query,summarise,prokaryotic_fraction,microbial_fraction,renew,create,get_tree,regenerate,metapackage,chainsaw,condense,trim_package_hmms,supplement}
               ...
singlem: error: argument subparser_name: invalid choice: 'are' (choose from data, pipe, appraise, seqs, makedb, query, summarise, prokaryotic_fraction, microbial_fraction, renew, create, get_tree, regenerate, metapackage, chainsaw, condense, trim_package_hmms, supplement)
```


## singlem_eukaryote

### Tool Description
singlem: error: argument subparser_name: invalid choice: 'eukaryote' (choose from data, pipe, appraise, seqs, makedb, query, summarise, prokaryotic_fraction, microbial_fraction, renew, create, get_tree, regenerate, metapackage, chainsaw, condense, trim_package_hmms, supplement)

### Metadata
- **Docker Image**: quay.io/biocontainers/singlem:0.20.3--pyhdfd78af_2
- **Homepage**: https://github.com/wwood/singlem
- **Package**: https://anaconda.org/channels/bioconda/packages/singlem/overview
- **Validation**: PASS

### Original Help Text
```text
usage: singlem [-h]
               {data,pipe,appraise,seqs,makedb,query,summarise,prokaryotic_fraction,microbial_fraction,renew,create,get_tree,regenerate,metapackage,chainsaw,condense,trim_package_hmms,supplement}
               ...
singlem: error: argument subparser_name: invalid choice: 'eukaryote' (choose from data, pipe, appraise, seqs, makedb, query, summarise, prokaryotic_fraction, microbial_fraction, renew, create, get_tree, regenerate, metapackage, chainsaw, condense, trim_package_hmms, supplement)
```


## singlem_microbial_fraction

### Tool Description
Estimate the fraction of reads from a metagenome that are assigned to Bacteria and Archaea compared to e.g. eukaryote or phage. Also estimate average genome size. [deprecated; use prokaryotic_fraction]

### Metadata
- **Docker Image**: quay.io/biocontainers/singlem:0.20.3--pyhdfd78af_2
- **Homepage**: https://github.com/wwood/singlem
- **Package**: https://anaconda.org/channels/bioconda/packages/singlem/overview
- **Validation**: PASS

### Original Help Text
```text
usage: singlem microbial_fraction [-h] -p INPUT_PROFILE
                                  [-1 sequence_file [sequence_file ...]]
                                  [-2 sequence_file [sequence_file ...]]
                                  [--input-metagenome-sizes INPUT_METAGENOME_SIZES]
                                  [--taxon-genome-lengths-file TAXON_GENOME_LENGTHS_FILE]
                                  [--metapackage METAPACKAGE]
                                  [--accept-missing-samples]
                                  [--output-tsv OUTPUT_TSV]
                                  [--output-per-taxon-read-fractions OUTPUT_PER_TAXON_READ_FRACTIONS]
                                  [--debug] [--version] [--quiet]
                                  [--full-help] [--full-help-roff]

Estimate the fraction of reads from a metagenome that are assigned to Bacteria
and Archaea compared to e.g. eukaryote or phage. Also estimate average genome
size. [deprecated; use prokaryotic_fraction]

options:
  -h, --help            show this help message and exit

input:
  -p INPUT_PROFILE, --input-profile INPUT_PROFILE
                        Input taxonomic profile file [required]

Read information [1+ args required]:
  -1 sequence_file [sequence_file ...], --forward sequence_file [sequence_file ...], --reads sequence_file [sequence_file ...], --sequences sequence_file [sequence_file ...]
                        nucleotide read sequence(s) (forward or unpaired) to
                        be searched. Can be FASTA or FASTQ format, GZIP-
                        compressed or not. These must be the same ones that
                        were used to generate the input profile.
  -2 sequence_file [sequence_file ...], --reverse sequence_file [sequence_file ...]
                        reverse reads to be searched. Can be FASTA or FASTQ
                        format, GZIP-compressed or not. These must be the same
                        reads that were used to generate the input profile.
  --input-metagenome-sizes INPUT_METAGENOME_SIZES
                        TSV file with 'sample' and 'num_bases' as a header,
                        where sample matches the input profile name, and
                        num_reads is the total number (forward+reverse) of
                        bases in the metagenome that was analysed with 'pipe'.
                        These must be the same reads that were used to
                        generate the input profile.

database:
  --taxon-genome-lengths-file TAXON_GENOME_LENGTHS_FILE
                        TSV file with 'rank' and 'genome_size' as headers
                        [default: Use genome lengths from the default
                        metapackage]
  --metapackage METAPACKAGE
                        Metapackage containing genome lengths [default: Use
                        genome lengths from the default metapackage]

other options:
  --accept-missing-samples
                        If a sample is missing from the input-metagenome-sizes
                        file, skip analysis of it without croaking.
  --output-tsv OUTPUT_TSV
                        Output file [default: stdout]
  --output-per-taxon-read-fractions OUTPUT_PER_TAXON_READ_FRACTIONS
                        Output a fraction for each taxon to this TSV [default:
                        Do not output anything]

Other general options:
  --debug               output debug information
  --version             output version information and quit
  --quiet               only output errors
  --full-help, --full_help
                        print longer help message
  --full-help-roff, --full_help_roff
                        print longer help message in ROFF (manpage) format
```


## singlem_renew

### Tool Description
Reannotate an OTU table with an updated taxonomy

### Metadata
- **Docker Image**: quay.io/biocontainers/singlem:0.20.3--pyhdfd78af_2
- **Homepage**: https://github.com/wwood/singlem
- **Package**: https://anaconda.org/channels/bioconda/packages/singlem/overview
- **Validation**: PASS

### Original Help Text
```text
usage: singlem renew [-h] --input-archive-otu-table INPUT_ARCHIVE_OTU_TABLE
                     [--ignore-missing-singlem-packages] [-p FILE]
                     [--taxonomic-profile-krona FILE] [--otu-table filename]
                     [--threads num_threads]
                     [--assignment-method {smafa_naive_then_diamond,scann_naive_then_diamond,annoy_then_diamond,scann_then_diamond,diamond,diamond_example,annoy,pplacer}]
                     [--output-extras] [--archive-otu-table filename]
                     [--metapackage METAPACKAGE]
                     [--sra-files sra_file [sra_file ...]]
                     [--read-chunk-size num_reads]
                     [--read-chunk-number chunk_number]
                     [--output-jplace filename]
                     [--singlem-packages SINGLEM_PACKAGES [SINGLEM_PACKAGES ...]]
                     [--assignment-singlem-db ASSIGNMENT_SINGLEM_DB]
                     [--diamond-taxonomy-assignment-performance-parameters DIAMOND_TAXONOMY_ASSIGNMENT_PERFORMANCE_PARAMETERS]
                     [--evalue EVALUE] [--min-orf-length length]
                     [--restrict-read-length length]
                     [--translation-table number]
                     [--filter-minimum-protein length]
                     [--max-species-divergence INT]
                     [--exclude-off-target-hits] [--min-taxon-coverage FLOAT]
                     [--debug] [--version] [--quiet] [--full-help]
                     [--full-help-roff]

Reannotate an OTU table with an updated taxonomy

options:
  -h, --help            show this help message and exit

input:
  --input-archive-otu-table INPUT_ARCHIVE_OTU_TABLE
                        Renew this table
  --ignore-missing-singlem-packages
                        Ignore OTUs which have been assigned to packages not
                        in the metapackage being used for renewal [default:
                        croak]

Common arguments in shared with 'pipe':
  -p FILE, --taxonomic-profile FILE
                        output a 'condensed' taxonomic profile for each sample
                        based on the OTU table. Taxonomic profiles output can
                        be further converted to other formats using singlem
                        summarise.
  --taxonomic-profile-krona FILE
                        output a 'condensed' taxonomic profile for each sample
                        based on the OTU table
  --otu-table filename  output OTU table
  --threads num_threads
                        number of CPUS to use [default: 1]
  --assignment-method {smafa_naive_then_diamond,scann_naive_then_diamond,annoy_then_diamond,scann_then_diamond,diamond,diamond_example,annoy,pplacer}, --assignment_method {smafa_naive_then_diamond,scann_naive_then_diamond,annoy_then_diamond,scann_then_diamond,diamond,diamond_example,annoy,pplacer}
                        Method of assigning taxonomy to OTUs and taxonomic
                        profiles [default: smafa_naive_then_diamond] .TS
                        tab(@); l l . T{ Method T}@T{ Description T} _ T{
                        smafa_naive_then_diamond T}@T{ Search for the most
                        similar window sequences <= 3bp different using a
                        brute force algorithm (using the smafa implementation)
                        over all window sequences in the database, and if none
                        are found use DIAMOND blastx of all reads from each
                        OTU. T} T{ scann_naive_then_diamond T}@T{ Search for
                        the most similar window sequences <= 3bp different
                        using a brute force algorithm over all window
                        sequences in the database, and if none are found use
                        DIAMOND blastx of all reads from each OTU. T} T{
                        annoy_then_diamond T}@T{ Same as
                        scann_naive_then_diamond, except search using ANNOY
                        rather than using brute force. Requires a non-standard
                        metapackage. T} T{ scann_then_diamond T}@T{ Same as
                        scann_naive_then_diamond, except search using SCANN
                        rather than using brute force. Requires a non-standard
                        metapackage. T} T{ diamond T}@T{ DIAMOND blastx best
                        hit(s) of all reads from each OTU. T} T{
                        diamond_example T}@T{ DIAMOND blastx best hit(s) of
                        all reads from each OTU, but report the best hit as a
                        sequence ID instead of a taxonomy. T} T{ annoy T}@T{
                        Search for the most similar window sequences <= 3bp
                        different using ANNOY, otherwise no taxonomy is
                        assigned. Requires a non-standard metapackage. T} T{
                        pplacer T}@T{ Use pplacer to assign taxonomy of each
                        read in each OTU. Requires a non-standard metapackage.
                        T} .TE
  --output-extras       give extra output for each sequence identified (e.g.
                        the read(s) each OTU was generated from) in the output
                        OTU table [default: not set]

Less common arguments shared with 'pipe':
  --archive-otu-table filename
                        output OTU table in archive format for making DBs etc.
                        [default: unused]
  --metapackage METAPACKAGE
                        Set of SingleM packages to use [default: use the
                        default set]
  --sra-files sra_file [sra_file ...]
                        "sra" format files (usually from NCBI SRA) to be
                        searched
  --read-chunk-size num_reads
                        Size chunk to process at a time (in number of reads).
                        Requires --sra-files.
  --read-chunk-number chunk_number
                        Process only this specific chunk number (1-based
                        index). Requires --sra-files.
  --output-jplace filename
                        Output a jplace format file for each singlem package
                        to a file starting with this string, each with one
                        entry per OTU. Requires 'pplacer' as the
                        --assignment_method [default: unused]
  --singlem-packages SINGLEM_PACKAGES [SINGLEM_PACKAGES ...]
                        SingleM packages to use [default: use the set from the
                        default metapackage]
  --assignment-singlem-db ASSIGNMENT_SINGLEM_DB, --assignment_singlem_db ASSIGNMENT_SINGLEM_DB
                        Use this SingleM DB when assigning taxonomy [default:
                        not set, use the default]
  --diamond-taxonomy-assignment-performance-parameters DIAMOND_TAXONOMY_ASSIGNMENT_PERFORMANCE_PARAMETERS
                        Performance-type arguments to use when calling
                        'diamond blastx' during the taxonomy assignment step.
                        [default: use setting defined in metapackage when set,
                        otherwise use '--block-size 0.5 --target-indexed -c1']
  --evalue EVALUE       HMMSEARCH e-value cutoff to use for sequence gathering
                        [default: 1e-05]
  --min-orf-length length
                        When predicting ORFs require this many base pairs
                        uninterrupted by a stop codon [default: 72 for reads,
                        300 for genomes]
  --restrict-read-length length
                        Only use this many base pairs at the start of each
                        sequence searched [default: no restriction]
  --translation-table number
                        Codon table for translation. By default, translation
                        table 4 is used, which is the same as translation
                        table 11 (the usual bacterial/archaeal one), except
                        that the TGA codon is translated as tryptophan, not as
                        a stop codon. Using table 4 means that the minority of
                        organisms which use table 4 are not biased against,
                        without a significant effect on the majority of
                        bacteria and archaea that use table 11. See http://www
                        .ncbi.nlm.nih.gov/Taxonomy/taxonomyhome.html/index.cgi
                        ?chapter=tgencodes for details on specific tables.
                        [default: 4]
  --filter-minimum-protein length
                        Ignore reads aligning in less than this many positions
                        to each protein HMM when using --no-diamond-prefilter
                        [default: 24]
  --max-species-divergence INT
                        Maximum number of different bases acids to allow
                        between a sequence and the best hit in the database so
                        that it is assigned to the species level. [default: 2]
  --exclude-off-target-hits
                        Exclude hits that are not in the target domain of each
                        SingleM package
  --min-taxon-coverage FLOAT
                        Minimum coverage to report in a taxonomic profile.
                        [default: 0.35 for reads, 0.1 for genomes]

Other general options:
  --debug               output debug information
  --version             output version information and quit
  --quiet               only output errors
  --full-help, --full_help
                        print longer help message
  --full-help-roff, --full_help_roff
                        print longer help message in ROFF (manpage) format
```


## singlem_create

### Tool Description
Create a SingleM package.

### Metadata
- **Docker Image**: quay.io/biocontainers/singlem:0.20.3--pyhdfd78af_2
- **Homepage**: https://github.com/wwood/singlem
- **Package**: https://anaconda.org/channels/bioconda/packages/singlem/overview
- **Validation**: PASS

### Original Help Text
```text
usage: singlem create [-h] --input-graftm-package PATH --input-taxonomy PATH
                      --output-singlem-package PATH --hmm-position INTEGER
                      [--window-size INTEGER] --target-domains TARGET_DOMAINS
                      [TARGET_DOMAINS ...] --gene-description STRING [--force]
                      [--debug] [--version] [--quiet] [--full-help]
                      [--full-help-roff]

Create a SingleM package.

options:
  -h, --help            show this help message and exit
  --input-graftm-package PATH
                        Input GraftM package underlying the new SingleM
                        package. The GraftM package is usually made with
                        'graftM create --no_tree --hmm <your.hmm>' where
                        <your.hmm> is the one provided to 'singlem seqs'.
  --input-taxonomy PATH
                        Input taxonomy file in GreenGenes format (2 column tab
                        separated, ID then taxonomy with taxonomy separated by
                        ';' or '; '.
  --output-singlem-package PATH
                        Output package path
  --hmm-position INTEGER
                        Position in the GraftM alignment HMM where the SingleM
                        window starts. To choose the best position, use
                        'singlem seqs'. Note that this position (both the one
                        output by 'seqs' and the one specified here) is a
                        1-based index, but this positions stored within the
                        SingleM package as a 0-based index.
  --window-size INTEGER
                        Length of NUCLEOTIDE residues in the window, counting
                        only those that match the HMM [default: 60]
  --target-domains TARGET_DOMAINS [TARGET_DOMAINS ...]
                        Input domains targeted by this package e.g. 'Archaea',
                        'Bacteria', 'Eukaryota' or 'Viruses'. Input with
                        multiple domains must be space separated.
  --gene-description STRING
                        Input free form text description of this marker
                        package, for use with 'singlem metapackage
                        --describe'.
  --force               Overwrite output path if it already exists [default:
                        false]

Other general options:
  --debug               output debug information
  --version             output version information and quit
  --quiet               only output errors
  --full-help, --full_help
                        print longer help message
  --full-help-roff, --full_help_roff
                        print longer help message in ROFF (manpage) format
```


## singlem_get_tree

### Tool Description
Extract path to Newick tree file in a SingleM package.

### Metadata
- **Docker Image**: quay.io/biocontainers/singlem:0.20.3--pyhdfd78af_2
- **Homepage**: https://github.com/wwood/singlem
- **Package**: https://anaconda.org/channels/bioconda/packages/singlem/overview
- **Validation**: PASS

### Original Help Text
```text
usage: singlem get_tree [-h]
                        [--singlem-packages SINGLEM_PACKAGES [SINGLEM_PACKAGES ...]]
                        [--debug] [--version] [--quiet] [--full-help]
                        [--full-help-roff]

Extract path to Newick tree file in a SingleM package.

options:
  -h, --help            show this help message and exit

required arguments:
  --singlem-packages SINGLEM_PACKAGES [SINGLEM_PACKAGES ...]
                        SingleM packages to use [default: use the default set]

Other general options:
  --debug               output debug information
  --version             output version information and quit
  --quiet               only output errors
  --full-help, --full_help
                        print longer help message
  --full-help-roff, --full_help_roff
                        print longer help message in ROFF (manpage) format
```


## singlem_regenerate

### Tool Description
Update a SingleM package with new sequences and taxonomy (expert mode).

### Metadata
- **Docker Image**: quay.io/biocontainers/singlem:0.20.3--pyhdfd78af_2
- **Homepage**: https://github.com/wwood/singlem
- **Package**: https://anaconda.org/channels/bioconda/packages/singlem/overview
- **Validation**: PASS

### Original Help Text
```text
usage: singlem regenerate [-h] [--min-aligned-percent percent]
                          [--window-position WINDOW_POSITION]
                          [--sequence-prefix SEQUENCE_PREFIX]
                          [--candidate-decoy-sequences CANDIDATE_DECOY_SEQUENCES]
                          [--candidate-decoy-taxonomy CANDIDATE_DECOY_TAXONOMY]
                          [--no-candidate-decoy-sequences]
                          --input-singlem-package PATH
                          --output-singlem-package PATH --input-sequences
                          INPUT_SEQUENCES --input-taxonomy INPUT_TAXONOMY
                          [--debug] [--version] [--quiet] [--full-help]
                          [--full-help-roff]

Update a SingleM package with new sequences and taxonomy (expert mode).

options:
  -h, --help            show this help message and exit
  --min-aligned-percent percent
                        remove sequences from the alignment which do not cover
                        this percentage of the HMM [default: 10]
  --window-position WINDOW_POSITION
                        change window position of output package [default: do
                        not change]
  --sequence-prefix SEQUENCE_PREFIX
                        add a prefix to sequence names
  --candidate-decoy-sequences CANDIDATE_DECOY_SEQUENCES, --euk-sequences CANDIDATE_DECOY_SEQUENCES
                        candidate amino acid sequences fasta file to search
                        for decoys
  --candidate-decoy-taxonomy CANDIDATE_DECOY_TAXONOMY, --euk-taxonomy CANDIDATE_DECOY_TAXONOMY
                        tab-separated sequence ID to taxonomy file of
                        candidate decoy sequences
  --no-candidate-decoy-sequences, --no-further-euks
                        Do not include any euk sequences beyond what is
                        already in the current SingleM package

required arguments:
  --input-singlem-package PATH
                        input package path
  --output-singlem-package PATH
                        output package path
  --input-sequences INPUT_SEQUENCES
                        all on-target amino acid sequences fasta file for new
                        package
  --input-taxonomy INPUT_TAXONOMY
                        tab-separated sequence ID to taxonomy file of on-
                        target sequence taxonomy

Other general options:
  --debug               output debug information
  --version             output version information and quit
  --quiet               only output errors
  --full-help, --full_help
                        print longer help message
  --full-help-roff, --full_help_roff
                        print longer help message in ROFF (manpage) format
```


## singlem_taxonomy

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/singlem:0.20.3--pyhdfd78af_2
- **Homepage**: https://github.com/wwood/singlem
- **Package**: https://anaconda.org/channels/bioconda/packages/singlem/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
usage: singlem [-h]
               {data,pipe,appraise,seqs,makedb,query,summarise,prokaryotic_fraction,microbial_fraction,renew,create,get_tree,regenerate,metapackage,chainsaw,condense,trim_package_hmms,supplement}
               ...
singlem: error: argument subparser_name: invalid choice: 'taxonomy' (choose from data, pipe, appraise, seqs, makedb, query, summarise, prokaryotic_fraction, microbial_fraction, renew, create, get_tree, regenerate, metapackage, chainsaw, condense, trim_package_hmms, supplement)
```


## singlem_metapackage

### Tool Description
Create or describe a metapackage (i.e. set of SingleM packages)

### Metadata
- **Docker Image**: quay.io/biocontainers/singlem:0.20.3--pyhdfd78af_2
- **Homepage**: https://github.com/wwood/singlem
- **Package**: https://anaconda.org/channels/bioconda/packages/singlem/overview
- **Validation**: PASS

### Original Help Text
```text
usage: singlem metapackage [-h] [--metapackage METAPACKAGE]
                           [--singlem-packages SINGLEM_PACKAGES [SINGLEM_PACKAGES ...]]
                           [--nucleotide-sdb NUCLEOTIDE_SDB]
                           [--no-nucleotide-sdb]
                           [--taxon-genome-lengths TAXON_GENOME_LENGTHS]
                           [--no-taxon-genome-lengths]
                           [--taxonomy-database-name TAXONOMY_DATABASE_NAME]
                           [--taxonomy-database-version TAXONOMY_DATABASE_VERSION]
                           [--diamond-prefilter-performance-parameters DIAMOND_PREFILTER_PERFORMANCE_PARAMETERS]
                           [--diamond-taxonomy-assignment-performance-parameters DIAMOND_TAXONOMY_ASSIGNMENT_PERFORMANCE_PARAMETERS]
                           [--describe] [--threads num_threads]
                           [--prefilter-clustering-threshold fraction]
                           [--prefilter-diamond-db DMND]
                           [--makeidx-sensitivity-params PARAMS]
                           [--calculate-average-num-genes-per-species]
                           [--debug] [--version] [--quiet] [--full-help]
                           [--full-help-roff]

Create or describe a metapackage (i.e. set of SingleM packages)

options:
  -h, --help            show this help message and exit
  --metapackage METAPACKAGE
                        Path to write generated metapackage to
  --singlem-packages SINGLEM_PACKAGES [SINGLEM_PACKAGES ...]
                        Input packages
  --nucleotide-sdb NUCLEOTIDE_SDB
                        Nucleotide SingleM database for initial assignment
                        pass
  --no-nucleotide-sdb   Skip nucleotide SingleM database
  --taxon-genome-lengths TAXON_GENOME_LENGTHS
                        TSV file of genome lengths for each taxon
  --no-taxon-genome-lengths
                        Skip taxon genome lengths
  --taxonomy-database-name TAXONOMY_DATABASE_NAME
                        Name of the taxonomy database to use [default:
                        custom_taxonomy_database]
  --taxonomy-database-version TAXONOMY_DATABASE_VERSION
                        Version of the taxonomy database to use [default:
                        unspecified]
  --diamond-prefilter-performance-parameters DIAMOND_PREFILTER_PERFORMANCE_PARAMETERS
                        Performance-type arguments to use when calling
                        'diamond blastx' during the prefiltering. [default: '
                        --block-size 0.5 --target-indexed -c1']
  --diamond-taxonomy-assignment-performance-parameters DIAMOND_TAXONOMY_ASSIGNMENT_PERFORMANCE_PARAMETERS
                        Performance-type arguments to use when calling
                        'diamond blastx' during the taxonomy assignment.
                        [default: '--block-size 0.5 --target-indexed -c1']
  --describe            Describe a metapackage rather than create it
  --threads num_threads
                        number of CPUS to use [default: 1]
  --prefilter-clustering-threshold fraction
                        ID for dereplication of prefilter DB [default: 0.6]
  --prefilter-diamond-db DMND
                        Dereplicated DIAMOND db for prefilter to use [default:
                        dereplicate from input SingleM packages]
  --makeidx-sensitivity-params PARAMS
                        DIAMOND sensitivity parameters to use when indexing
                        the prefilter DIAMOND db. [default: None]
  --calculate-average-num-genes-per-species
                        Calculate the average number of genes per species in
                        the metapackage. [default: False]

Other general options:
  --debug               output debug information
  --version             output version information and quit
  --quiet               only output errors
  --full-help, --full_help
                        print longer help message
  --full-help-roff, --full_help_roff
                        print longer help message in ROFF (manpage) format
```


## singlem_chainsaw

### Tool Description
Remove tree information and trim unaligned sequences from a SingleM package (expert mode)

### Metadata
- **Docker Image**: quay.io/biocontainers/singlem:0.20.3--pyhdfd78af_2
- **Homepage**: https://github.com/wwood/singlem
- **Package**: https://anaconda.org/channels/bioconda/packages/singlem/overview
- **Validation**: PASS

### Original Help Text
```text
usage: singlem chainsaw [-h] [--keep-tree] --input-singlem-package
                        INPUT_SINGLEM_PACKAGE --output-singlem-package
                        OUTPUT_SINGLEM_PACKAGE
                        [--sequence-prefix SEQUENCE_PREFIX] [--debug]
                        [--version] [--quiet] [--full-help] [--full-help-roff]

Remove tree information and trim unaligned sequences from a SingleM package
(expert mode)

options:
  -h, --help            show this help message and exit
  --keep-tree           Stop tree info from being removed

required arguments:
  --input-singlem-package INPUT_SINGLEM_PACKAGE
                        Remove tree info and trim unaligned sequences from
                        this package
  --output-singlem-package OUTPUT_SINGLEM_PACKAGE
                        Package to be created
  --sequence-prefix SEQUENCE_PREFIX
                        Rename the sequences by adding this at the front
                        [default: '']

Other general options:
  --debug               output debug information
  --version             output version information and quit
  --quiet               only output errors
  --full-help, --full_help
                        print longer help message
  --full-help-roff, --full_help_roff
                        print longer help message in ROFF (manpage) format
```


## singlem_from

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/singlem:0.20.3--pyhdfd78af_2
- **Homepage**: https://github.com/wwood/singlem
- **Package**: https://anaconda.org/channels/bioconda/packages/singlem/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
usage: singlem [-h]
               {data,pipe,appraise,seqs,makedb,query,summarise,prokaryotic_fraction,microbial_fraction,renew,create,get_tree,regenerate,metapackage,chainsaw,condense,trim_package_hmms,supplement}
               ...
singlem: error: argument subparser_name: invalid choice: 'from' (choose from data, pipe, appraise, seqs, makedb, query, summarise, prokaryotic_fraction, microbial_fraction, renew, create, get_tree, regenerate, metapackage, chainsaw, condense, trim_package_hmms, supplement)
```


## singlem_condense

### Tool Description
Combine OTU tables across different markers into a single taxonomic profile.

### Metadata
- **Docker Image**: quay.io/biocontainers/singlem:0.20.3--pyhdfd78af_2
- **Homepage**: https://github.com/wwood/singlem
- **Package**: https://anaconda.org/channels/bioconda/packages/singlem/overview
- **Validation**: PASS

### Original Help Text
```text
usage: singlem condense [-h]
                        [--input-archive-otu-tables INPUT_ARCHIVE_OTU_TABLES [INPUT_ARCHIVE_OTU_TABLES ...]]
                        [--input-archive-otu-table-list INPUT_ARCHIVE_OTU_TABLE_LIST]
                        [--input-gzip-archive-otu-table-list INPUT_GZIP_ARCHIVE_OTU_TABLE_LIST]
                        [-p filename] [--taxonomic-profile-krona filename]
                        [--output-after-em-otu-table filename]
                        [--metapackage METAPACKAGE]
                        [--min-taxon-coverage FRACTION]
                        [--trim-percent TRIM_PERCENT] [--debug] [--version]
                        [--quiet] [--full-help] [--full-help-roff]

Combine OTU tables across different markers into a single taxonomic profile.
Note that while this mode can be run independently, it is often more
straightforward to invoke its methodology by specifying -p / --taxonomic-
profile when running pipe mode.

options:
  -h, --help            show this help message and exit

Input arguments (1+ required):
  --input-archive-otu-tables INPUT_ARCHIVE_OTU_TABLES [INPUT_ARCHIVE_OTU_TABLES ...], --input-archive-otu-table INPUT_ARCHIVE_OTU_TABLES [INPUT_ARCHIVE_OTU_TABLES ...]
                        Condense from these archive tables
  --input-archive-otu-table-list INPUT_ARCHIVE_OTU_TABLE_LIST
                        Condense from the archive tables newline separated in
                        this file
  --input-gzip-archive-otu-table-list INPUT_GZIP_ARCHIVE_OTU_TABLE_LIST
                        Condense from the gzip'd archive tables newline
                        separated in this file

Output arguments (1+ required):
  -p filename, --taxonomic-profile filename
                        output OTU table
  --taxonomic-profile-krona filename
                        name of krona file to generate.
  --output-after-em-otu-table filename
                        output OTU table after expectation maximisation has
                        been applied. Note that this table usually contains
                        multiple rows with the same window sequence.

Other options:
  --metapackage METAPACKAGE
                        Set of SingleM packages to use [default: use the
                        default set]
  --min-taxon-coverage FRACTION
                        Set taxons with less coverage to coverage=0. [default:
                        0.35]
  --trim-percent TRIM_PERCENT
                        percentage of markers to be trimmed for each taxonomy
                        [default: 10]

Other general options:
  --debug               output debug information
  --version             output version information and quit
  --quiet               only output errors
  --full-help, --full_help
                        print longer help message
  --full-help-roff, --full_help_roff
                        print longer help message in ROFF (manpage) format
```


## singlem_single

### Tool Description
singlem: error: argument subparser_name: invalid choice: 'single' (choose from data, pipe, appraise, seqs, makedb, query, summarise, prokaryotic_fraction, microbial_fraction, renew, create, get_tree, regenerate, metapackage, chainsaw, condense, trim_package_hmms, supplement)

### Metadata
- **Docker Image**: quay.io/biocontainers/singlem:0.20.3--pyhdfd78af_2
- **Homepage**: https://github.com/wwood/singlem
- **Package**: https://anaconda.org/channels/bioconda/packages/singlem/overview
- **Validation**: PASS

### Original Help Text
```text
usage: singlem [-h]
               {data,pipe,appraise,seqs,makedb,query,summarise,prokaryotic_fraction,microbial_fraction,renew,create,get_tree,regenerate,metapackage,chainsaw,condense,trim_package_hmms,supplement}
               ...
singlem: error: argument subparser_name: invalid choice: 'single' (choose from data, pipe, appraise, seqs, makedb, query, summarise, prokaryotic_fraction, microbial_fraction, renew, create, get_tree, regenerate, metapackage, chainsaw, condense, trim_package_hmms, supplement)
```


## singlem_can

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/singlem:0.20.3--pyhdfd78af_2
- **Homepage**: https://github.com/wwood/singlem
- **Package**: https://anaconda.org/channels/bioconda/packages/singlem/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
usage: singlem [-h]
               {data,pipe,appraise,seqs,makedb,query,summarise,prokaryotic_fraction,microbial_fraction,renew,create,get_tree,regenerate,metapackage,chainsaw,condense,trim_package_hmms,supplement}
               ...
singlem: error: argument subparser_name: invalid choice: 'can' (choose from data, pipe, appraise, seqs, makedb, query, summarise, prokaryotic_fraction, microbial_fraction, renew, create, get_tree, regenerate, metapackage, chainsaw, condense, trim_package_hmms, supplement)
```


## singlem_straightforward

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/singlem:0.20.3--pyhdfd78af_2
- **Homepage**: https://github.com/wwood/singlem
- **Package**: https://anaconda.org/channels/bioconda/packages/singlem/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
usage: singlem [-h]
               {data,pipe,appraise,seqs,makedb,query,summarise,prokaryotic_fraction,microbial_fraction,renew,create,get_tree,regenerate,metapackage,chainsaw,condense,trim_package_hmms,supplement}
               ...
singlem: error: argument subparser_name: invalid choice: 'straightforward' (choose from data, pipe, appraise, seqs, makedb, query, summarise, prokaryotic_fraction, microbial_fraction, renew, create, get_tree, regenerate, metapackage, chainsaw, condense, trim_package_hmms, supplement)
```


## singlem_specifying

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/singlem:0.20.3--pyhdfd78af_2
- **Homepage**: https://github.com/wwood/singlem
- **Package**: https://anaconda.org/channels/bioconda/packages/singlem/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
usage: singlem [-h]
               {data,pipe,appraise,seqs,makedb,query,summarise,prokaryotic_fraction,microbial_fraction,renew,create,get_tree,regenerate,metapackage,chainsaw,condense,trim_package_hmms,supplement}
               ...
singlem: error: argument subparser_name: invalid choice: 'specifying' (choose from data, pipe, appraise, seqs, makedb, query, summarise, prokaryotic_fraction, microbial_fraction, renew, create, get_tree, regenerate, metapackage, chainsaw, condense, trim_package_hmms, supplement)
```


## singlem_trim_package_hmms

### Tool Description
Trim the width of HMMs to increase speed (expert mode)

### Metadata
- **Docker Image**: quay.io/biocontainers/singlem:0.20.3--pyhdfd78af_2
- **Homepage**: https://github.com/wwood/singlem
- **Package**: https://anaconda.org/channels/bioconda/packages/singlem/overview
- **Validation**: PASS

### Original Help Text
```text
usage: singlem trim_package_hmms [-h] [--keep-tree] --input-singlem-package
                                 INPUT_SINGLEM_PACKAGE
                                 --output-singlem-package
                                 OUTPUT_SINGLEM_PACKAGE [--debug] [--version]
                                 [--quiet] [--full-help] [--full-help-roff]

Trim the width of HMMs to increase speed (expert mode)

options:
  -h, --help            show this help message and exit
  --keep-tree           Stop tree info from being removed

required arguments:
  --input-singlem-package INPUT_SINGLEM_PACKAGE
                        Input package to trim HMMs from
  --output-singlem-package OUTPUT_SINGLEM_PACKAGE
                        Package to be created

Other general options:
  --debug               output debug information
  --version             output version information and quit
  --quiet               only output errors
  --full-help, --full_help
                        print longer help message
  --full-help-roff, --full_help_roff
                        print longer help message in ROFF (manpage) format
```


## singlem_supplement

### Tool Description
Create a new metapackage from a vanilla one plus new genomes

### Metadata
- **Docker Image**: quay.io/biocontainers/singlem:0.20.3--pyhdfd78af_2
- **Homepage**: https://github.com/wwood/singlem
- **Package**: https://anaconda.org/channels/bioconda/packages/singlem/overview
- **Validation**: PASS

### Original Help Text
```text
usage: singlem supplement [-h]
                          [--new-genome-fasta-files NEW_GENOME_FASTA_FILES [NEW_GENOME_FASTA_FILES ...]]
                          [--new-genome-fasta-files-list NEW_GENOME_FASTA_FILES_LIST [NEW_GENOME_FASTA_FILES_LIST ...]]
                          [--input-metapackage INPUT_METAPACKAGE]
                          --output-metapackage OUTPUT_METAPACKAGE
                          [--threads THREADS]
                          [--new-fully-defined-taxonomies NEW_FULLY_DEFINED_TAXONOMIES | --taxonomy-file TAXONOMY_FILE | --gtdbtk-output-directory GTDBTK_OUTPUT_DIRECTORY | --pplacer-threads PPLACER_THREADS]
                          [--output-taxonomies OUTPUT_TAXONOMIES]
                          [--skip-taxonomy-check]
                          [--checkm2-quality-file CHECKM2_QUALITY_FILE]
                          [--no-quality-filter]
                          [--checkm2-min-completeness CHECKM2_MIN_COMPLETENESS]
                          [--checkm2-max-contamination CHECKM2_MAX_CONTAMINATION]
                          (--no-dereplication | --dereplicate-with-galah)
                          [--hmmsearch-evalue HMMSEARCH_EVALUE]
                          [--gene-definitions GENE_DEFINITIONS]
                          [--working-directory WORKING_DIRECTORY]
                          [--no-taxon-genome-lengths]
                          [--ignore-taxonomy-database-incompatibility]
                          [--new-taxonomy-database-name NEW_TAXONOMY_DATABASE_NAME]
                          [--new-taxonomy-database-version NEW_TAXONOMY_DATABASE_VERSION]
                          [--debug] [--version] [--quiet] [--full-help]
                          [--full-help-roff]

Create a new metapackage from a vanilla one plus new genomes

options:
  -h, --help            show this help message and exit
  --new-genome-fasta-files NEW_GENOME_FASTA_FILES [NEW_GENOME_FASTA_FILES ...]
                        FASTA files of new genomes
  --new-genome-fasta-files-list NEW_GENOME_FASTA_FILES_LIST [NEW_GENOME_FASTA_FILES_LIST ...]
                        File containing FASTA file paths of new genomes
  --input-metapackage INPUT_METAPACKAGE
                        metapackage to build upon [default: Use default
                        package]
  --output-metapackage OUTPUT_METAPACKAGE
                        output metapackage
  --threads THREADS     parallelisation

Taxonomy:
  --new-fully-defined-taxonomies NEW_FULLY_DEFINED_TAXONOMIES
                        newline separated file containing taxonomies of new
                        genomes (path<TAB>taxonomy). Must be fully specified
                        to species level. If not specified, the taxonomy will
                        be inferred from the new genomes using GTDB-tk or read
                        from --taxonomy-file [default: not set, run GTDBtk].
  --taxonomy-file TAXONOMY_FILE
                        A 2 column tab-separated file containing each genome's
                        taxonomy as output by GTDBtk [default: not set, run
                        GTDBtk]
  --gtdbtk-output-directory GTDBTK_OUTPUT_DIRECTORY
                        use this GTDBtk result. Not used if --new-taxonomies
                        is used [default: not set, run GTDBtk]
  --pplacer-threads PPLACER_THREADS
                        for GTDBtk classify_wf
  --output-taxonomies OUTPUT_TAXONOMIES
                        TSV output file of taxonomies of new genomes, whether
                        they are novel species or not.
  --skip-taxonomy-check
                        skip check which ensures that GTDBtk assigned
                        taxonomies are concordant with the old metapackage's
                        [default: do the check]

Quality filtering of new genomes:
  --checkm2-quality-file CHECKM2_QUALITY_FILE
                        CheckM2 quality file of new genomes
  --no-quality-filter   skip quality filtering
  --checkm2-min-completeness CHECKM2_MIN_COMPLETENESS
                        minimum completeness for CheckM2 [default: 50]
  --checkm2-max-contamination CHECKM2_MAX_CONTAMINATION
                        maximum contamination for CheckM2 [default: 10]

Dereplication:
  --no-dereplication    Assume genome inputs are already dereplicated
  --dereplicate-with-galah
                        Run galah to dereplicate genomes at species level

Less common options:
  --hmmsearch-evalue HMMSEARCH_EVALUE
                        evalue for hmmsearch run on proteins to gather markers
                        [default: 1e-20]
  --gene-definitions GENE_DEFINITIONS
                        Tab-separated file of
                        genome_fasta<TAB>transcript_fasta<TAB>protein_fasta
                        [default: undefined, call genes using Prodigal]
  --working-directory WORKING_DIRECTORY
                        working directory [default: use a temporary directory]
  --no-taxon-genome-lengths
                        Do not include taxon genome lengths in updated
                        metapackage
  --ignore-taxonomy-database-incompatibility
                        Do not halt when the old metapackage is not the
                        default metapackage.
  --new-taxonomy-database-name NEW_TAXONOMY_DATABASE_NAME
                        Name of the taxonomy database to record in the created
                        metapackage [default: custom_taxonomy_database]
  --new-taxonomy-database-version NEW_TAXONOMY_DATABASE_VERSION
                        Version of the taxonomy database to use [default:
                        None]

Other general options:
  --debug               output debug information
  --version             output version information and quit
  --quiet               only output errors
  --full-help, --full_help
                        print longer help message
  --full-help-roff, --full_help_roff
                        print longer help message in ROFF (manpage) format
```


## singlem_genomes

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/singlem:0.20.3--pyhdfd78af_2
- **Homepage**: https://github.com/wwood/singlem
- **Package**: https://anaconda.org/channels/bioconda/packages/singlem/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
usage: singlem [-h]
               {data,pipe,appraise,seqs,makedb,query,summarise,prokaryotic_fraction,microbial_fraction,renew,create,get_tree,regenerate,metapackage,chainsaw,condense,trim_package_hmms,supplement}
               ...
singlem: error: argument subparser_name: invalid choice: 'genomes' (choose from data, pipe, appraise, seqs, makedb, query, summarise, prokaryotic_fraction, microbial_fraction, renew, create, get_tree, regenerate, metapackage, chainsaw, condense, trim_package_hmms, supplement)
```

