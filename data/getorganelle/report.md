# getorganelle CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| getorganelle_fastg_to_gfa.py | PASS | SPAdes graph from the plastome run converted; segment counts match |
| getorganelle_get_organelle_config.py | PASS | downloaded the embplant_pt databases (config_dir now a string, network access added) |
| getorganelle_get_organelle_from_assembly.py | PASS | slimmed and disentangled the SPAdes graph into a 154478 bp plastome (expected sizes now comma-joined) |
| getorganelle_get_organelle_from_reads.py | PASS | Galaxy Arabidopsis reads assembled a complete 154478 bp plastome (run with -s and --genes from one database type) |
| getorganelle_gfa_to_fasta.py | PASS | SPAdes graph from the plastome run converted; segment counts match |
| getorganelle_gfa_to_fastg.py | PASS | SPAdes graph from the plastome run converted; segment counts match |
| getorganelle_plastome_arch_info.py | PASS | assembled plastome gives LSC 84170, SSC 17780, IR 26264 |
| getorganelle_reconstruct_graph_from_fasta.py | PASS | plastome fasta rebuilt into a GFA graph |
| getorganelle_rm_low_coverage_duplicated_contigs.py | Failed | tool bug: script crashes with AttributeError treat_no_hits for any input |
| getorganelle_slim_graph.py | PASS | SPAdes graph slimmed with the embplant_pt label fasta; hit contigs and csv written |
| getorganelle_summary_get_organelle_output.py | PASS | summary csv of the plastome run has organelle type, length 154478 and coverage |

## getorganelle_get_organelle_config.py

### Tool Description
is used for setting up default GetOrganelle database.

### Metadata
- **Docker Image**: quay.io/biocontainers/getorganelle:1.7.7.1--pyhdfd78af_0
- **Homepage**: http://github.com/Kinggerm/GetOrganelle
- **Package**: https://anaconda.org/channels/bioconda/packages/getorganelle/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/getorganelle/overview
- **Total Downloads**: 52.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/Kinggerm/GetOrganelle
- **Stars**: N/A
### Original Help Text
```text
Python 3.10.14 | packaged by conda-forge | (main, Mar 20 2024, 12:45:18) [GCC 12.3.0]
DEPENDENCIES: Bowtie2 2.4.5; Blast 2.15.0
WORKING DIR: /
/usr/local/bin/get_organelle_config.py

usage: get_organelle_config.py -a embplant_pt,embplant_mt

get_organelle_config.py 1.7.7.1 is used for setting up default GetOrganelle
database.

options:
  -h, --help            show this help message and exit
  -a ADD_ORGANELLE_TYPE, --add ADD_ORGANELLE_TYPE
                        Add database for organelle type(s). Followed by any of
                        all/embplant_pt/embplant_mt/embplant_nr/fungus_mt/fung
                        us_nr/animal_mt/other_pt or multiple types joined by
                        comma such as embplant_pt,embplant_mt,fungus_mt.
  --use-version DB_VERSION
                        The version of database to add. Find more versions at
                        github.com/Kinggerm/GetOrganelleDB. Default: latest
  -r RM_ORGANELLE_TYPE, --rm RM_ORGANELLE_TYPE
                        Remove local database(s) for organelle type(s).
                        Followed by any of all/embplant_pt/embplant_mt/embplan
                        t_nr/fungus_mt/fungus_nr/animal_mt/other_pt or
                        multiple types joined by comma such as
                        embplant_pt,embplant_mt.
  --update              Update local databases to the latest online version,
                        or the local version if "--use-local LOCAL_DB_PATH"
                        provided.
  --config-dir GET_ORGANELLE_PATH
                        The directory where the default databases were placed.
                        The default value also can be changed by adding
                        'export GETORG_PATH=your_favor' to the shell script
                        (e.g. ~/.bash_profile or ~/.bashrc) Default:
                        /root/.GetOrganelle
  --use-local USE_LOCAL
                        Input a path. This local database path must include
                        subdirectories LabelDatabase and SeedDatabase, under
                        which there is the fasta file(s) named by the
                        organelle type you want add, such as fungus_mt.fasta.
  --clean               Remove all configured database files (=="--rm all").
  --list                List configured databases checking and exit.
  --check               Check configured database files and exit.
  --db-type DB_TYPE     The database type (seed/label/both). Default: both
  --which-blast WHICH_BLAST
                        Assign the path to BLAST binary files if not added to
                        the path. Default: try "/GetOrganelleDep/linux/ncbi-
                        blast" first, then $PATH
  --which-bowtie2 WHICH_BOWTIE2
                        Assign the path to Bowtie2 binary files if not added
                        to the path. Default: try
                        "/GetOrganelleDep/linux/bowtie2" first, then $PATH
  --verbose             verbose output to the screen. Default: False
  -v, --version         show program's version number and exit
Insufficient arguments!
```


## getorganelle_get_organelle_from_reads.py

### Tool Description
GetOrganelle v1.7.7.1 get_organelle_from_reads.py assembles organelle genomes from genome skimming data.

### Metadata
- **Docker Image**: quay.io/biocontainers/getorganelle:1.7.7.1--pyhdfd78af_0
- **Homepage**: http://github.com/Kinggerm/GetOrganelle
- **Package**: https://anaconda.org/channels/bioconda/packages/getorganelle/overview
- **Validation**: PASS

### Original Help Text
```text
usage: 
###  Embryophyta plant plastome, 2*(1G raw data, 150 bp) reads
get_organelle_from_reads.py -1 sample_1.fq -2 sample_2.fq -s cp_seed.fasta -o plastome_output  -R 15 -k 21,45,65,85,105 -F embplant_pt
###  Embryophyta plant mitogenome
get_organelle_from_reads.py -1 sample_1.fq -2 sample_2.fq -s mt_seed.fasta -o mitogenome_output  -R 30 -k 21,45,65,85,105 -F embplant_mt

GetOrganelle v1.7.7.1 get_organelle_from_reads.py assembles organelle genomes
from genome skimming data. Find updates in
https://github.com/Kinggerm/GetOrganelle and see README.md for more
information.

options:
  -v, --version         show program's version number and exit
  -h                    print brief introduction for frequently-used options.
  --help                print verbose introduction for all options.

IN-OUT OPTIONS:
  Options on inputs and outputs

  -1 FQ_FILE_1          Input file with forward paired-end reads (format:
                        fastq/fastq.gz/fastq.tar.gz).
  -2 FQ_FILE_2          Input file with reverse paired-end reads (format:
                        fastq/fastq.gz/fastq.tar.gz).
  -u UNPAIRED_FQ_FILES  Input file(s) with unpaired (single-end) reads
                        (format: fastq/fastq.gz/fastq.tar.gz). files could be
                        comma-separated lists such as 'seq1.fq,seq2.fq'.
  -o OUTPUT_BASE        Output directory. Overwriting files if directory
                        exists.
  -s SEED_FILE          Seed sequence(s). Input fasta format file as initial
                        seed. A seed sequence in GetOrganelle is only used for
                        identifying initial organelle reads. The assembly
                        process is purely de novo. Should be a list of files
                        split by comma(s) on a multi-organelle mode, with the
                        same list length to organelle_type (followed by '-F').
                        Default: '/root/.GetOrganelle/SeedDatabase/*.fasta' (*
                        depends on the value followed with flag '-F')
  -a ANTI_SEED          Anti-seed(s). Not suggested unless what you really
                        know what you are doing. Input fasta format file as
                        anti-seed, where the extension process stop. Typically
                        serves as excluding plastid reads when extending
                        mitochondrial reads, or the other way around. You
                        should be cautious about using this option, because if
                        the anti-seed includes some word in the target but not
                        in the seed, the result would have gaps. For example,
                        use the embplant_mt and embplant_pt from the same
                        plant-species as seed and anti-seed.
  --max-reads MAXIMUM_N_READS
                        Hard bound for maximum number of reads to be used per
                        file. A input larger than 536870911 will be treated as
                        infinity (INF). Default: 1.5E7 (-F
                        embplant_pt/embplant_nr/fungus_mt/fungus_nr); 7.5E7
                        (-F embplant_mt/other_pt/anonym); 3E8 (-F animal_mt)
  --reduce-reads-for-coverage REDUCE_READS_FOR_COV
                        Soft bound for maximum number of reads to be used
                        according to target-hitting base coverage. If the
                        estimated target-hitting base coverage is too high and
                        over this VALUE, GetOrganelle automatically reduce the
                        number of reads to generate a final assembly with base
                        coverage close to this VALUE. This design could
                        greatly save computational resources in many
                        situations. A mean base coverage over 500 is extremely
                        sufficient for most cases. This VALUE must be larger
                        than 10. Set this VALUE to inf to disable reducing.
                        Default: 500.
  --max-ignore-percent MAXIMUM_IGNORE_PERCENT
                        The maximum percent of bases to be ignore in
                        extension, due to low quality. Default: 0.01
  --phred-offset PHRED_OFFSET
                        Phred offset for spades-hammer. Default: GetOrganelle-
                        autodetect
  --min-quality-score MIN_QUALITY_SCORE
                        Minimum quality score in extension. This value would
                        be automatically decreased to prevent ignoring too
                        much raw data (see --max-ignore-percent).Default: 1
                        ('"' in Phred+33; 'A' in Phred+64/Solexa+64)
  --prefix PREFIX       Add extra prefix to resulting files under the output
                        directory.
  --out-per-round       Enable output per round. Choose to save memory but
                        cost more time per round.
  --zip-files           Choose to compress fq/sam files using gzip.
  --keep-temp           Choose to keep the running temp/index files.
  --config-dir GET_ORGANELLE_PATH
                        The directory where the configuration file and default
                        databases were placed. The default value also can be
                        changed by adding 'export GETORG_PATH=your_favor' to
                        the shell script (e.g. ~/.bash_profile or ~/.bashrc)
                        Default: /root/.GetOrganelle

SCHEME OPTIONS:
  Options on running schemes.

  -F ORGANELLE_TYPE     This flag should be followed with embplant_pt
                        (embryophyta plant plastome), other_pt (non-
                        embryophyta plant plastome), embplant_mt (plant
                        mitogenome), embplant_nr (plant nuclear ribosomal
                        RNA), animal_mt (animal mitogenome), fungus_mt (fungus
                        mitogenome), fungus_nr (fungus nuclear ribosomal
                        RNA)or embplant_mt,other_pt,fungus_mt (the combination
                        of any of above organelle genomes split by comma(s),
                        which might be computationally more intensive than
                        separate runs), or anonym (uncertain organelle genome
                        type). The anonym should be used with customized seed
                        and label databases ('-s' and '--genes'). For easy
                        usage and compatibility of old versions, following
                        redirection would be automatically fulfilled without
                        warning: plant_cp->embplant_pt; plant_pt->embplant_pt;
                        plant_mt->embplant_mt; plant_nr->embplant_nr
  --fast                ="-R 10 -t 4 -J 5 -M 7 --max-n-words 3E7 --larger-
                        auto-ws --disentangle-time-limit 360" This option is
                        suggested for homogeneously and highly covered data
                        (very fine data). You can overwrite the value of a
                        specific option listed above by adding that option
                        along with the "--fast" flag. You could try
                        GetOrganelle with this option for a list of samples
                        and run a second time without this option for the rest
                        with incomplete results.
  --memory-save         ="--out-per-round -P 0 --remove-duplicates 0" You can
                        overwrite the value of a specific option listed above
                        by adding that option along with the "--memory-save"
                        flag. A larger '-R' value is suggested when "--memory-
                        save" is chosen.
  --memory-unlimited    ="-P 1E7 --index-in-memory --remove-duplicates 2E8
                        --min-quality-score -5 --max-ignore-percent 0" You can
                        overwrite the value of a specific option listed above
                        by adding that option along with the "--memory-
                        unlimited" flag.

EXTENDING OPTIONS:
  Options on the performance of extending process

  -w WORD_SIZE          Word size (W) for pre-grouping (if not assigned by '--
                        pre-w') and extending process. This script would try
                        to guess (auto-estimate) a proper W using an empirical
                        function based on average read length, reads quality,
                        target genome coverage, and other variables that might
                        influence the extending process. You could assign the
                        ratio (1>input>0) of W to read_length, based on which
                        this script would estimate the W for you; or assign an
                        absolute W value (read length>input>=35). Default:
                        auto-estimated.
  --pre-w PREGROUP_WORD_SIZE
                        Word size (W) for pre-grouping. Used to reproduce
                        result when word size is a certain value during
                        pregrouping process and later changed during reads
                        extending process. Similar to word size. Default: the
                        same to word size.
  -R MAX_ROUNDS, --max-rounds MAX_ROUNDS
                        Maximum number of extending rounds (suggested: >=2).
                        Default: 15 (-F embplant_pt), 30 (-F
                        embplant_mt/other_pt), 10 (-F
                        embplant_nr/animal_mt/fungus_mt/fungus_nr), inf (-P
                        0).
  --max-n-words MAXIMUM_N_WORDS
                        Maximum number of words to be used in total.Default:
                        4E8 (-F embplant_pt), 2E8 (-F
                        embplant_nr/fungus_mt/fungus_nr/animal_mt), 2E9 (-F
                        embplant_mt/other_pt)
  -J JUMP_STEP          The length of step for checking words in reads during
                        extending process (integer >= 1). When you have reads
                        of high quality, the larger the number is, the faster
                        the extension will be, the more risk of missing reads
                        in low coverage area. Choose 1 to choose the slowest
                        but safest extension strategy. Default: 3
  -M MESH_SIZE          (Beta parameter) The length of step for building words
                        from seeds during extending process (integer >= 1).
                        When you have reads of high quality, the larger the
                        number is, the faster the extension will be, the more
                        risk of missing reads in low coverage area. Another
                        usage of this mesh size is to choose a larger mesh
                        size coupled with a smaller word size, which makes
                        smaller word size feasible when memory is
                        limited.Choose 1 to choose the slowest but safest
                        extension strategy. Default: 2
  --bowtie2-options BOWTIE2_OPTIONS
                        Bowtie2 options, such as '--ma 3 --mp 5,2 --very-fast
                        -t'. Default: --very-fast -t.
  --larger-auto-ws      By using this flag, the empirical function for
                        estimating W would tend to produce a relative larger
                        W, which would speed up the matching in extending,
                        reduce the memory cost in extending, but increase the
                        risk of broken final graph. Suggested when the data is
                        good with high and homogenous coverage.
  --target-genome-size TARGET_GENOME_SIZE
                        Hypothetical value(s) of target genome size. This is
                        only used for estimating word size when no '-w
                        word_size' is given. Should be a list of INTEGER
                        numbers split by comma(s) on a multi-organelle mode,
                        with the same list length to organelle_type (followed
                        by '-F'). Default: 130000 (-F embplant_pt) or 390000
                        (-F embplant_mt) or 13000 (-F embplant_nr) or 39000
                        (-F other_pt) or 13000 (-F animal_mt) or 65000 (-F
                        fungus_mt) or 13000 (-F fungus_nr) or
                        39000,390000,65000 (-F other_pt,embplant_mt,fungus_mt)
  --max-extending-len MAX_EXTENDING_LEN
                        Maximum extending length(s) derived from the seed(s).
                        A single value could be a non-negative number, or inf
                        (infinite) or auto (automatic estimation). This is
                        designed for properly stopping the extending from
                        getting too long and saving computational resources.
                        However, empirically, a maximum extending length value
                        larger than 6000 would not be helpful for saving
                        computational resources. This value would not be
                        precise in controlling output size, especially when
                        pre-group (followed by '-P') is turn on.In the auto
                        mode, the maximum extending length is estimated based
                        on the sizes of the gap regions that not covered in
                        the seed sequences. A sequence of a closely related
                        species would be preferred for estimating a better
                        maximum extending length value. If you are using
                        limited loci, e.g. rbcL gene as the seed for
                        assembling the whole plastome (with extending length
                        ca. 75000 >> 6000), you should set maximum extending
                        length to inf. Should be a list of numbers/auto/inf
                        split by comma(s) on a multi-organelle mode, with the
                        same list length to organelle_type (followed by '-F').
                        Default: inf.

ASSEMBLY OPTIONS:
  These options are about the assembly and graph disentangling

  -k SPADES_KMER        SPAdes kmer settings. Use the same format as in
                        SPAdes. illegal kmer values would be automatically
                        discarded by GetOrganelle. Default: 21,55,85,115
  --spades-options OTHER_SPADES_OPTIONS
                        Other SPAdes options. Use double quotation marks to
                        include all the arguments and parameters.
  --no-spades           Disable SPAdes.
  --ignore-k IGNORE_KMER_RES
                        A kmer threshold below which, no
                        slimming/disentangling would be executed on the
                        result. Default: 40
  --genes GENES_FASTA   Followed with a customized database (a fasta file or
                        the base name of a blast database) containing or made
                        of ONE set of protein coding genes and ribosomal RNAs
                        extracted from ONE reference genome that you want to
                        assemble. Should be a list of databases split by
                        comma(s) on a multi-organelle mode, with the same list
                        length to organelle_type (followed by '-F'). This is
                        optional for any organelle mentioned in '-F' but
                        required for 'anonym'. By default, certain database(s)
                        in /root/.GetOrganelle/LabelDatabase would be used
                        contingent on the organelle types chosen (-F). The
                        default value become invalid when '--genes' or '--ex-
                        genes' is used.
  --ex-genes EXCLUDE_GENES
                        This is optional and Not suggested, since non-target
                        contigs could contribute information for better
                        downstream coverage-based clustering. Followed with a
                        customized database (a fasta file or the base name of
                        a blast database) containing or made of protein coding
                        genes and ribosomal RNAs extracted from reference
                        genome(s) that you want to exclude. Could be a list of
                        databases split by comma(s) but NOT required to have
                        the same list length to organelle_type (followed by
                        '-F'). The default value will become invalid when '--
                        genes' or '--ex-genes' is used.
  --disentangle-df DISENTANGLE_DEPTH_FACTOR
                        Depth factor for differentiate genome type of contigs.
                        The genome type of contigs are determined by blast.
                        Default: 10.0
  --contamination-depth CONTAMINATION_DEPTH
                        Depth factor for confirming contamination in parallel
                        contigs. Default: 3.0
  --contamination-similarity CONTAMINATION_SIMILARITY
                        Similarity threshold for confirming contaminating
                        contigs. Default: 0.9
  --no-degenerate       Disable making consensus from parallel contig based on
                        nucleotide degenerate table.
  --degenerate-depth DEGENERATE_DEPTH
                        Depth factor for confirming parallel contigs. Default:
                        1.5
  --degenerate-similarity DEGENERATE_SIMILARITY
                        Similarity threshold for confirming parallel contigs.
                        Default: 0.98
  --disentangle-time-limit DISENTANGLE_TIME_LIMIT
                        Time limit (second) for each try of disentangling a
                        graph file as a circular genome. Disentangling a graph
                        as contigs is not limited. Default: 1800
  --expected-max-size EXPECTED_MAX_SIZE
                        Expected maximum target genome size(s) for
                        disentangling. Should be a list of INTEGER numbers
                        split by comma(s) on a multi-organelle mode, with the
                        same list length to organelle_type (followed by '-F').
                        Default: 250000 (-F embplant_pt/fungus_mt), 25000 (-F
                        embplant_nr/animal_mt/fungus_nr), 1000000 (-F
                        embplant_mt/other_pt),1000000,1000000,250000 (-F
                        other_pt,embplant_mt,fungus_mt)
  --expected-min-size EXPECTED_MIN_SIZE
                        Expected minimum target genome size(s) for
                        disentangling. Should be a list of INTEGER numbers
                        split by comma(s) on a multi-organelle mode, with the
                        same list length to organelle_type (followed by '-F').
                        Default: 10000 for all.
  --reverse-lsc         For '-F embplant_pt' with complete circular result, by
                        default, the direction of the starting contig (usually
                        the LSC region) is determined as the direction with
                        less ORFs. Choose this option to reverse the direction
                        of the starting contig when result is circular.
                        Actually, both directions are biologically equivalent
                        to each other. The reordering of the direction is only
                        for easier downstream analysis.
  --max-paths-num MAX_PATHS_NUM
                        Repeats would dramatically increase the number of
                        potential isomers (paths). This option was used to
                        export a certain amount of paths out of all possible
                        paths per assembly graph. Default: 1000

ADDITIONAL OPTIONS:

  -t THREADS            Maximum threads to use.
  -P PRE_GROUPED        The maximum number (integer) of high-covered reads to
                        be pre-grouped before extending process. pre_grouping
                        is suggested when the whole genome coverage is shallow
                        but the organ genome coverage is deep. The default
                        value is 2E5. For personal computer with 8G memory, we
                        suggest no more than 3E5. A larger number (ex. 6E5)
                        would run faster but exhaust memory in the first few
                        minutes. Choose 0 to disable this process.
  --which-blast WHICH_BLAST
                        Assign the path to BLAST binary files if not added to
                        the path. Default: try
                        "/usr/local/lib/python3.10/site-
                        packages/GetOrganelleDep/linux/ncbi-blast" first, then
                        $PATH
  --which-bowtie2 WHICH_BOWTIE2
                        Assign the path to Bowtie2 binary files if not added
                        to the path. Default: try
                        "/usr/local/lib/python3.10/site-
                        packages/GetOrganelleDep/linux/bowtie2" first, then
                        $PATH
  --which-spades WHICH_SPADES
                        Assign the path to SPAdes binary files if not added to
                        the path. Default: try
                        "/usr/local/lib/python3.10/site-
                        packages/GetOrganelleDep/linux/SPAdes" first, then
                        $PATH
  --which-bandage WHICH_BANDAGE
                        Assign the path to bandage binary file if not added to
                        the path. Default: try $PATH
  --continue            Several check points based on files produced, rather
                        than on the log file, so keep in mind that this script
                        will NOT detect the difference between this input
                        parameters and the previous ones.
  --overwrite           Overwrite previous file if existed.
  --index-in-memory     Keep index in memory. Choose save index in memory than
                        in disk.
  --remove-duplicates RM_DUPLICATES
                        By default this script use unique reads to extend.
                        Choose the number of duplicates (integer) to be saved
                        in memory. A larger number (ex. 2E7) would run faster
                        but exhaust memory in the first few minutes. Choose 0
                        to disable this process. Note that whether choose or
                        not will not disable the calling of replicate reads.
                        Default: 10000000.0.
  --flush-step ECHO_STEP
                        Flush step (INTEGER OR INF) for presenting progress.
                        For running in the background, you could set this to
                        inf, which would disable this. Default: 54321
  --random-seed RANDOM_SEED
                        Default: 12345
  --verbose             Verbose output. Choose to enable verbose running
                        log_handler.
```


## getorganelle_get_organelle_from_assembly.py

### Tool Description
isolates organelle genomes from assembly graph.

### Metadata
- **Docker Image**: quay.io/biocontainers/getorganelle:1.7.7.1--pyhdfd78af_0
- **Homepage**: http://github.com/Kinggerm/GetOrganelle
- **Package**: https://anaconda.org/channels/bioconda/packages/getorganelle/overview
- **Validation**: PASS

### Original Help Text
```text
usage: get_organelle_from_assembly.py -g assembly_graph_file -F embplant_pt -o output --min-depth 10

GetOrganelle v1.7.7.1 get_organelle_from_assembly.py isolates organelle
genomes from assembly graph. Find updates in
https://github.com/Kinggerm/GetOrganelle and see README.md for more
information.

options:
  -F ORGANELLE_TYPE     This flag should be followed with embplant_pt
                        (embryophyta plant plastome), other_pt (non-
                        embryophyta plant plastome), embplant_mt (plant
                        mitochondrion), embplant_nr (plant nuclear ribosomal
                        RNA), animal_mt (animal mitochondrion), fungus_mt
                        (fungus mitochondrion), fungus_nr (fungus nuclear
                        ribosomal RNA), or embplant_mt,other_pt,fungus_mt (the
                        combination of any of above organelle genomes split by
                        comma(s), which might be computationally more
                        intensive than separate runs), or anonym (uncertain
                        organelle genome type). The anonym should be used with
                        customized seed and label databases ('-s' and '--
                        genes').
  -g INPUT_GRAPH        Input assembly graph (fastg/gfa) file. The format will
                        be recognized by the file name suffix.
  -o OUTPUT_BASE        Output directory. Overwriting files if directory
                        exists.
  --min-depth MIN_DEPTH
                        Input a float or integer number. Filter graph file by
                        a minimum depth. Default: 0.0.
  --max-depth MAX_DEPTH
                        Input a float or integer number. filter graph file by
                        a maximum depth. Default: inf.
  --config-dir GET_ORGANELLE_PATH
                        The directory where the configuration file and default
                        databases were placed. The default value also can be
                        changed by adding 'export GETORG_PATH=your_favor' to
                        the shell script (e.g. ~/.bash_profile or ~/.bashrc)
                        Default: /root/.GetOrganelle
  --genes GENES_FASTA   Followed with a customized database (a fasta file or
                        the base name of a blast database) containing or made
                        of ONE set of protein coding genes and ribosomal RNAs
                        extracted from ONE reference genome that you want to
                        assemble. Should be a list of databases split by
                        comma(s) on a multi-organelle mode, with the same list
                        length to organelle_type (followed by '-F'). This is
                        optional for any organelle mentioned in '-F' but
                        required for 'anonym'. By default, certain database(s)
                        in /root/.GetOrganelle/LabelDatabase would be used
                        contingent on the organelle types chosen (-F). The
                        default value no longer holds when '--genes' or '--ex-
                        genes' is used.
  --ex-genes EXCLUDE_GENES
                        This is optional and Not suggested, since non-target
                        contigs could contribute information for better
                        downstream coverage-based clustering. Followed with a
                        customized database (a fasta file or the base name of
                        a blast database) containing or made of protein coding
                        genes and ribosomal RNAs extracted from reference
                        genome(s) that you want to exclude. Could be a list of
                        databases split by comma(s) but NOT required to have
                        the same list length to organelle_type (followed by
                        '-F'). The default value no longer holds when '--
                        genes' or '--ex-genes' is used.
  --no-slim             Disable slimming process and directly disentangle the
                        original assembly graph. Default: False
  --slim-options SLIM_OPTIONS
                        Other options for calling slim_graph.py
  --max-slim-extending-len MAX_SLIM_EXTENDING_LEN
                        This is used to limit the extending length, below
                        which a "non-hit contig" is allowed to be distant from
                        a "hit contig" to be kept. See more under
                        slim_graph.py:--max-slim-extending-len. Default: 15000
                        (-F embplant_pt), 50000 (-F
                        embplant_mt/fungus_mt/other_pt), 12500 (-F
                        embplant_nr/fungus_nr/animal_mt),
                        maximum_of_type1_type2 (-F type1,type2), inf (-F
                        anonym)
  --spades-out-dir SPADES_SCAFFOLDS_PATH
                        Input spades output directory with 'scaffolds.fasta'
                        and 'scaffolds.paths', which are used for scaffolding
                        disconnected contigs with GAPs. Default: disabled
  --depth-factor DEPTH_FACTOR
                        Depth factor for differentiate genome type of contigs.
                        The genome type of contigs are determined by blast.
                        Default: 10.0
  --type-f TYPE_FACTOR  Type factor for identifying contig type tag when
                        multiple tags exist in one contig. Default:3.0
  --contamination-depth CONTAMINATION_DEPTH
                        Depth factor for confirming contamination in parallel
                        contigs. Default: 3.0
  --contamination-similarity CONTAMINATION_SIMILARITY
                        Similarity threshold for confirming contaminating
                        contigs. Default: 0.9
  --no-degenerate       Disable making consensus from parallel contig based on
                        nucleotide degenerate table.
  --degenerate-depth DEGENERATE_DEPTH
                        Depth factor for confirming parallel contigs. Default:
                        1.5
  --degenerate-similarity DEGENERATE_SIMILARITY
                        Similarity threshold for confirming parallel contigs.
                        Default: 0.98
  --disentangle-time-limit DISENTANGLE_TIME_LIMIT
                        Time limit (second) for each try of disentangling a
                        graph file as a circular genome. Disentangling a graph
                        as contigs is not limited. Default: 3600
  --expected-max-size EXPECTED_MAX_SIZE
                        Expected maximum target genome size(s) for
                        disentangling. Should be a list of INTEGER numbers
                        split by comma(s) on a multi-organelle mode, with the
                        same list length to organelle_type (followed by '-F').
                        Default: 250000 (-F embplant_pt/fungus_mt), 25000 (-F
                        embplant_nr/fungus_nr/animal_mt), 1000000 (-F
                        embplant_mt/other_pt), 1000000,1000000,250000 (-F
                        other_pt,embplant_mt,fungus_mt)
  --expected-min-size EXPECTED_MIN_SIZE
                        Expected minimum target genome size(s) for
                        disentangling. Should be a list of INTEGER numbers
                        split by comma(s) on a multi-organelle mode, with the
                        same list length to organelle_type (followed by '-F').
                        Default: 10000 for all.
  --reverse-lsc         For '-F embplant_pt' with complete circular result, by
                        default, the direction of the starting contig (usually
                        the LSC contig) is determined as the direction with
                        less ORFs. Choose this option to reverse the direction
                        of the starting contig when result is circular.
                        Actually, both directions are biologically equivalent
                        to each other. The reordering of the direction is only
                        for easier downstream analysis.
  --max-paths-num MAX_PATHS_NUM
                        Repeats would dramatically increase the number of
                        potential isomers (paths). This option was used to
                        export a certain amount of paths out of all possible
                        paths per assembly graph. Default: 1000
  --keep-all-polymorphic
                        By default, this script would pick the contig with
                        highest coverage among all parallel (polymorphic)
                        contigs when degenerating was not applicable. Choose
                        this flag to export all combinations.
  --min-sigma MIN_SIGMA_FACTOR
                        Minimum deviation factor for excluding non-target
                        contigs. Default:0.1
  --max-multiplicity MAX_MULTIPLICITY
                        Maximum multiplicity of contigs for disentangling
                        genome paths. Should be 1~12. Default:8
  -t THREADS            Maximum threads to use.
  --prefix PREFIX       Add extra prefix to resulting files under the output
                        directory.
  --which-blast WHICH_BLAST
                        Assign the path to BLAST binary files if not added to
                        the path. Default: try
                        "/usr/local/lib/python3.10/site-
                        packages/GetOrganelleDep/linux/ncbi-blast" first, then
                        $PATH
  --which-bandage WHICH_BANDAGE
                        Assign the path to bandage binary file if not added to
                        the path. Default: try $PATH
  --keep-temp           Choose to keep the running temp/index files.
  --continue            Several check points based on files produced, rather
                        than on the log file, so keep in mind that this script
                        will not detect the difference between this input
                        parameters and the previous ones.
  --overwrite           Overwrite previous file if existed.
  --random-seed RANDOM_SEED
                        Default: 12345
  -v, --version         show program's version number and exit
  --verbose             Verbose output. Choose to enable verbose running
                        log_handler.
  -h                    print brief introduction for frequently-used options.
  --help                print verbose introduction for all options.
```


## getorganelle_fastg_to_gfa.py

### Tool Description
Convert a SPAdes FASTG assembly graph to GFA.

### Metadata
- **Docker Image**: quay.io/biocontainers/getorganelle:1.7.7.1--pyhdfd78af_0
- **Homepage**: http://github.com/Kinggerm/GetOrganelle
- **Package**: https://anaconda.org/channels/bioconda/packages/getorganelle/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: fastg2gfa.py *.fastg
```

## getorganelle_gfa_to_fasta.py

### Tool Description
Convert a GFA assembly graph to FASTA (one record per segment).

### Metadata
- **Docker Image**: quay.io/biocontainers/getorganelle:1.7.7.1--pyhdfd78af_0
- **Homepage**: http://github.com/Kinggerm/GetOrganelle
- **Package**: https://anaconda.org/channels/bioconda/packages/getorganelle/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: gfa2fasta.py *.gfa
```

## getorganelle_gfa_to_fastg.py

### Tool Description
Convert a GFA assembly graph to FASTG.

### Metadata
- **Docker Image**: quay.io/biocontainers/getorganelle:1.7.7.1--pyhdfd78af_0
- **Homepage**: http://github.com/Kinggerm/GetOrganelle
- **Package**: https://anaconda.org/channels/bioconda/packages/getorganelle/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: gfa2fastg.py *.gfa
```

## getorganelle_plastome_arch_info.py

### Tool Description
Count the LSC, SSC and IR/DR lengths of plastome sequences from fasta files.

### Metadata
- **Docker Image**: quay.io/biocontainers/getorganelle:1.7.7.1--pyhdfd78af_0
- **Homepage**: http://github.com/Kinggerm/GetOrganelle
- **Package**: https://anaconda.org/channels/bioconda/packages/getorganelle/overview
- **Validation**: PASS

### Original Help Text
```text
usage: plastome_arch_info.py fasta_format_sequence_file(s)

## This script helps you count the LSC/SSC/IR-DR lengths from a batch of
plastome sequences. ## Jianjun

positional arguments:
  sequences         Input fasta format sequences (split the files by spaces).

options:
  -h, --help        show this help message and exit
  -o OUTPUT         output file.
  -r MIN_IR_LENGTH  The minimum repeat length treated as the IR region of
                    plastome. Default: [5000]
  -v VALID_BASES    Valid bases. Default: ATGCRMYKHBDVatgcrmykhbdv
  --version         show program's version number and exit
```

## getorganelle_reconstruct_graph_from_fasta.py

### Tool Description
Convert sequences back into an assembly graph (GFA, or FASTG when the output name ends with .fastg) using a naive De Bruijn approach.

### Metadata
- **Docker Image**: quay.io/biocontainers/getorganelle:1.7.7.1--pyhdfd78af_0
- **Homepage**: http://github.com/Kinggerm/GetOrganelle
- **Package**: https://anaconda.org/channels/bioconda/packages/getorganelle/overview
- **Validation**: PASS

### Original Help Text
```text
usage: reconstruct_graph_from_fasta.py -i fasta_file -o out.gfa

This script uses an naive De Bruijn approach to convert sequence back into an
assembly graph file, such as a gfa (Graphical Fragment Assembly) or a fastg
file.

options:
  -h, --help            show this help message and exit
  -i INPUT              Input fasta file.
  -o OUTPUT             Output graph file. The output format is GFA by
                        default, but FASTG only when indicated with postfix
                        '.fastg'.
  -L OVERLAP, --overlap OVERLAP
                        overlap for reconstructing De Bruijn graph. Default:55
  -c CIRCULAR, --circular CIRCULAR
                        Sequences in input fasta file are all circular
                        (yes/no/auto). The auto mode enables detection by
                        checking the existence of '(circular)' in the end of
                        the header of each sequence. Default:auto
  --single-chain        The input sequence(s) was by default treated as DNA
                        double-chain with its complementary sequence. Choose
                        this flag to turn off.
  --out-kg OUT_KG       Output kmer node graph.
  -v, --version         show program's version number and exit
```

## getorganelle_rm_low_coverage_duplicated_contigs.py

### Tool Description
Remove low-coverage contigs that duplicate higher-coverage contigs in FASTG assembly graphs, found by blastn.

### Metadata
- **Docker Image**: quay.io/biocontainers/getorganelle:1.7.7.1--pyhdfd78af_0
- **Homepage**: http://github.com/Kinggerm/GetOrganelle
- **Package**: https://anaconda.org/channels/bioconda/packages/getorganelle/overview
- **Validation**: PASS

### Original Help Text
```text
usage: Usage: rm_low_coverage_duplicated_contigs.py *.fastg

positional arguments:
  assemblies            Input FASTG format assembly graph files (split the
                        files by spaces).

options:
  -h, --help            show this help message and exit
  --cov-t COVERAGE_THRESHOLD
                        With ratio (coverage of query/coverage of subject)
                        below which, the query would be exposed to discarded.
                        Default: 0.12
  --len-t LENGTH_THRESHOLD
                        With overlap (length of hit of query/ length of query)
                        above which, the query would be exposed to discarded.
                        Default: 0.9
  --blur                Replace hit low-coverage bases with N.
  --keep-temp           Keep temp blast files.
  --which-blast WHICH_BLAST
                        Assign the path to BLAST binary files if not added to
                        the path.
  -o OUTPUT_DIR         Output directory. Default: along with the original
                        file
  -t THREADS, --threads THREADS
                        Threads of blastn.
  -v, --version         show program's version number and exit
```

## getorganelle_summary_get_organelle_output.py

### Tool Description
Summarize the output folders of get_organelle_from_reads.py into one csv table.

### Metadata
- **Docker Image**: quay.io/biocontainers/getorganelle:1.7.7.1--pyhdfd78af_0
- **Homepage**: http://github.com/Kinggerm/GetOrganelle
- **Package**: https://anaconda.org/channels/bioconda/packages/getorganelle/overview
- **Validation**: PASS

### Original Help Text
```text
usage: summary_get_organelle_output.py list_of_folders -o tab_file

positional arguments:
  output         Input a list of folders generated by
                 get_organelle_from_reads.py.Please split the files by spaces.

options:
  -h, --help     show this help message and exit
  -o OUTPUT      Output csv file.
  -v, --version  show program's version number and exit
```

## getorganelle_slim_graph.py

### Tool Description
Exclude certain contigs from an assembly graph (fastg, gfa or fasta) by blast against label databases.

### Metadata
- **Docker Image**: quay.io/biocontainers/getorganelle:1.7.7.1--pyhdfd78af_0
- **Homepage**: http://github.com/Kinggerm/GetOrganelle
- **Package**: https://anaconda.org/channels/bioconda/packages/getorganelle/overview
- **Validation**: PASS

### Original Help Text
```text
usage: python slim_graph.py assembly_graph_files -F embplant_pt -E embplant_mt

GetOrganelle v1.7.7.1 slim_graph.py is a script for excluding certain contigs
from assembly graph file (*.fastg/*.fasta) by blast

positional arguments:
  assemblies            Input assembly (graph) files (.fasta or .gfa or
                        .fastg). Please split the files by spaces.

options:
  -h, --help            show this help message and exit
  -F ORGANELLE_TYPES    followed with mode embplant_pt, other_pt, embplant_mt,
                        embplant_nr, animal_mt, fungus_mt, fungus_nr (which
                        means embryophyta plastome, non-embryophyta plastome,
                        plant mitochondrion, plant nuclear ribosomal RNA,
                        animal mitochondrion, fungus mitochondrion, fungus
                        nuclear ribosomal RNA separately), or a combination of
                        above split by comma(s) (corresponds to certain
                        arguments as following listed). embplant_pt "
                        --include-priority
                        /root/.GetOrganelle/LabelDatabase/embplant_pt.fasta"
                        other_pt " --include-priority
                        /root/.GetOrganelle/LabelDatabase/other_pt.fasta"
                        embplant_mt " --include-priority
                        /root/.GetOrganelle/LabelDatabase/embplant_mt.fasta"
                        embplant_nr " --include-priority
                        /root/.GetOrganelle/LabelDatabase/embplant_nr.fasta"
                        animal_mt " --include-priority
                        /root/.GetOrganelle/LabelDatabase/animal_mt.fasta"
                        fungus_mt " --include-priority
                        /root/.GetOrganelle/LabelDatabase/fungus_mt.fasta"
                        fungus_nr " --include-priority
                        /root/.GetOrganelle/LabelDatabase/fungus_nr.fasta"
                        other_pt,embplant_mt,fungus_mt " --include-priority /r
                        oot/.GetOrganelle/LabelDatabase/other_pt.fasta,/root/.
                        GetOrganelle/LabelDatabase/embplant_mt.fasta,/root/.Ge
                        tOrganelle/LabelDatabase/fungus_mt.fasta"For easy
                        usage and compatibility of old versions, following
                        redirection would be automatically fulfilled without
                        warning: plant_cp->embplant_pt; plant_pt->embplant_pt;
                        plant_mt->embplant_mt; plant_nr->embplant_nr
  -E EXCLUDE_ORGANELLE_TYPES
                        followed with mode embplant_pt, other_pt, embplant_mt,
                        embplant_nr, animal_mt, fungus_mt,fungus_nr (which
                        means embryophyta plastome, non-embryophyta plastome,
                        plant mitochondrion, plant nuclear ribosomal RNA,
                        animal mitochondrion, fungus mitochondrion, fungus
                        nuclear ribosomal RNA separately), or a combination of
                        above split by comma(s) (be similar to -F and
                        corresponds to certain arguments as following listed).
                        embplant_pt " --exclude
                        /root/.GetOrganelle/LabelDatabase/embplant_pt.fasta"
                        embplant_mt " --exclude
                        /root/.GetOrganelle/LabelDatabase/embplant_mt.fasta"
                        embplant_nr " --exclude
                        /root/.GetOrganelle/LabelDatabase/embplant_nr.fasta"
                        animal_mt " --exclude
                        /root/.GetOrganelle/LabelDatabase/animal_mt.fasta"
                        fungus_mt " --exclude
                        /root/.GetOrganelle/LabelDatabase/fungus_mt.fasta"
                        fungus_nr " --exclude
                        /root/.GetOrganelle/LabelDatabase/fungus_nr.fasta"
                        embplant_mt,embplant_nr " --exclude /root/.GetOrganell
                        e/LabelDatabase/embplant_mt.fasta,/root/.GetOrganelle/
                        LabelDatabase/embplant_nr.fasta"
                        ------------------------------------------------------
                        For easy usage and compatibility of old versions,
                        following redirection would be automatically fulfilled
                        without warning: plant_cp->embplant_pt;
                        plant_pt->embplant_pt; plant_mt->embplant_mt;
                        plant_nr->embplant_nr
  --no-hits TREAT_NO_HITS
                        Provide treatment for non-hitting contigs. ex_no_con
                        keep those connect with hitting-include contigs.
                        (Default) ex_no_hit exclude all. keep_all keep all
  --max-slim-extending-len MAX_SLIM_EXTENDING_LEN
                        This is used to limit the extending length, below
                        which a "non-hit contig" is allowed to be distant from
                        a "hit contig" to be kept. This distance is measured
                        by the shortest distance connecting those two contigs,
                        weighted by the depth of the "hit contig". This is
                        used only when "--no-hits ex_no_con" was chosen.
                        Should be a single INTEGER number or inf (meaning
                        infinite). It is supposed to be half of the maximum
                        expected genome size to be safe, but could be much
                        smaller if the LabelDatabse is closely related.
                        Default: 15000 (-F embplant_pt), 50000 (-F
                        embplant_mt/fungus_mt/other_pt), 12500 (-F
                        embplant_nr/fungus_nr/animal_mt),
                        maximum_of_type1_type2 (-F type1,type2), inf (cases
                        without using -F)
  --significant SIGNIFICANT
                        Within a contig, if the query-score of hitting A is
                        more than given times (Default: 3.0) of the query-
                        score of hitting B, this contig would be treated as
                        only A related, rather than both.
  --depth-cutoff DEPTH_CUTOFF
                        After detection for target coverage, those beyond
                        certain times (depth cutoff) of the detected coverage
                        would be excluded. Default: 10000.0
  --min-depth MIN_DEPTH
                        Input a float or integer number. Filter fastg file by
                        a minimum depth. Default: 0.0.
  --max-depth MAX_DEPTH
                        Input a float or integer number. filter fastg file by
                        a maximum depth. Default: inf.
  --merge               Merge all possible contigs.
  --include INCLUDE     followed by Blastn database(s)
  --include-priority INCLUDE_PRIORITY
                        followed by Blastn database(s).
  --exclude EXCLUDE     followed by Blastn database(s).
  --exclude-priority EXCLUDE_PRIORITY
                        followed by Blastn database(s)
  --no-hits-labeled-tab
                        Choose to disable producing tab file
  --keep-temp           Choose to disable deleting temp files produced by
                        blast and this script
  -o OUT_DIR, --out-dir OUT_DIR
                        By default the output would be along with the input
                        fastg file. But you could assign a new directory with
                        this option.
  -e EVALUE, --evalue EVALUE
                        blastn evalue threshold. Default: 1e-25
  --percent PERCENT_IDENTITY, --perc-identity PERCENT_IDENTITY
                        blastn percent identity threshold. Default unset.
  --blast-options BLAST_OPTIONS
                        other blastn options. e.g. --blast-options "-word_size
                        13".
  --prefix PREFIX       Add prefix to the output basename. Conflict with "--
                        out-base".
  --out-base OUT_BASE   By default the output basename would be modified based
                        on the input fastg file. But you could assign a new
                        basename with this option. Conflict with "--prefix".
                        Conflict with multiple input files!
  --log                 Generate log file.
  --wrapper             Wrapper mode logging when called by get_organelle*.py.
                        Default: False
  --verbose             For debug usage.
  --continue            Specified for calling from get_organelle_from_reads.py
  --no-overwrite        Overwrite existing output result.
  --which-blast WHICH_BLAST
                        Assign the path to BLAST binary files if not added to
                        the path. Default: try
                        "/tmp/GetOrganelleDep/linux/ncbi-blast" first, then
                        $PATH
  --config-dir GET_ORGANELLE_PATH
                        The directory where the default databases were placed.
                        The default value also can be changed by adding
                        'export GETORG_PATH=your_favor' to the shell script
                        (e.g. ~/.bash_profile or ~/.bashrc) Default:
                        /root/.GetOrganelle
  -t THREADS, --threads THREADS
                        Threads for blastn.
  -v, --version         show program's version number and exit
```

## Metadata
- **Skill**: generated
