# mikado CWL Generation Report

## mikado_configure

### Tool Description
Configuration utility for Mikado

### Metadata
- **Docker Image**: quay.io/biocontainers/mikado:2.3.4--py310h8ea774a_2
- **Homepage**: https://github.com/lucventurini/mikado
- **Package**: https://anaconda.org/channels/bioconda/packages/mikado/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mikado/overview
- **Total Downloads**: 114.8K
- **Last updated**: 2025-10-03
- **GitHub**: https://github.com/lucventurini/mikado
- **Stars**: N/A
### Original Help Text
```text
usage: Mikado configure [-h] [--full] [--seed SEED | --random-seed]
                        [--minimum-cdna-length MINIMUM_CDNA_LENGTH]
                        [--max-intron-length MAX_INTRON_LENGTH]
                        [--strip-faulty-cds] [--scoring SCORING]
                        [--copy-scoring COPY_SCORING]
                        [-i INTRON_RANGE INTRON_RANGE]
                        [--subloci-out SUBLOCI_OUT]
                        [--monoloci-out MONOLOCI_OUT] [--no-pad]
                        [--reference-update] [--only-reference-update] [-eri]
                        [-kdc] [--check-references]
                        [-mco MIN_CLUSTERING_CDNA_OVERLAP]
                        [-mcso MIN_CLUSTERING_CDS_OVERLAP] [--report-all-orfs]
                        [--report-all-external-metrics] [--cds-only]
                        [--as-cds-only] [--strand-specific]
                        [--no-files | --gff GFF | --list LIST]
                        [--reference REFERENCE] [--junctions JUNCTIONS]
                        [-bt BLAST_TARGETS]
                        [--strand-specific-assemblies STRAND_SPECIFIC_ASSEMBLIES]
                        [--labels LABELS] [--codon-table CODON_TABLE]
                        [--external EXTERNAL] [--daijin] [-bc BLAST_CHUNKS]
                        [--use-blast] [--use-transdecoder]
                        [--mode {nosplit,stringent,lenient,permissive,split} [{nosplit,stringent,lenient,permissive,split} ...]]
                        [--scheduler {local,SLURM,LSF,PBS}] [--exe EXE]
                        [-c CLUSTER_CONFIG] [-t THREADS]
                        [--skip-split SKIP_SPLIT [SKIP_SPLIT ...]]
                        [-j | -y | --toml] [-od OUT_DIR]
                        [out]

Configuration utility for Mikado

positional arguments:
  out

options:
  -h, --help            show this help message and exit
  --full
  --seed SEED           Random seed number. Default: 0.
  --random-seed         Generate a new random seed number (instead of the
                        default of 0)
  --strand-specific     Boolean flag indicating whether all the assemblies are
                        strand-specific.
  --no-files            Remove all files-specific options from the printed
                        configuration file. Invoking the "--gff" option will
                        disable this flag.
  --gff GFF             Input GFF/GTF file(s), separated by comma
  --list LIST           Tab-delimited file containing rows with the following
                        format: <file> <label> <strandedness(def. False)>
                        <score(optional, def. 0)> <is_reference(optional, def.
                        False)> <exclude_redundant(optional, def. True)>
                        <strip_cds(optional, def. False)>
                        <skip_split(optional, def. False)> "strandedness",
                        "is_reference", "exclude_redundant", "strip_cds" and
                        "skip_split" must be boolean values (True, False)
                        "score" must be a valid floating number.
  --reference REFERENCE, --genome REFERENCE
                        Fasta genomic reference.
  --strand-specific-assemblies STRAND_SPECIFIC_ASSEMBLIES
                        List of strand-specific assemblies among the inputs.
  --labels LABELS       Labels to attach to the IDs of the transcripts of the
                        input files, separated by comma.
  --codon-table CODON_TABLE
                        Codon table to use. Default: 0 (ie Standard, NCBI #1,
                        but only ATG is considered a valid start codon.
  --external EXTERNAL   External configuration file to overwrite/add values
                        from. Parameters specified on the command line will
                        take precedence over those present in the
                        configuration file.
  -t THREADS, --threads THREADS
  --skip-split SKIP_SPLIT [SKIP_SPLIT ...]
                        List of labels for which splitting will be disabled
                        (eg long reads such as PacBio)
  -j, --json            Output will be in JSON (default: inferred by filename,
                        with TOML as fallback).
  -y, --yaml            Output will be in YAML (default: inferred by filename,
                        with TOML as fallback).
  --toml                Output will be in TOML (default: inferred by filename,
                        with TOML as fallback).
  -od OUT_DIR, --out-dir OUT_DIR
                        Destination directory for the output.

Options related to the prepare stage.:
  --minimum-cdna-length MINIMUM_CDNA_LENGTH
                        Minimum cDNA length for transcripts.
  --max-intron-length MAX_INTRON_LENGTH
                        Maximum intron length for transcripts.
  --strip-faulty-cds    Flag. If set, transcripts with an incorrect CDS will
                        be retained but with their CDS stripped. Default
                        behaviour: the whole transcript will be considered
                        invalid and discarded.

Options related to the scoring system:
  --scoring SCORING     Scoring file to use. Mikado provides the following:
                        mammalian.yaml, plant.yaml, HISTORIC/scerevisiae.yaml,
                        HISTORIC/human.yaml, HISTORIC/mammalian.yaml,
                        HISTORIC/hsapiens_scoring.yaml,
                        HISTORIC/celegans_scoring.yaml, HISTORIC/worm.yaml,
                        HISTORIC/plant.yaml, HISTORIC/athaliana_scoring.yaml,
                        HISTORIC/dmelanogaster_scoring.yaml,
                        HISTORIC/insects.yaml, HISTORIC/plants.yaml
  --copy-scoring COPY_SCORING
                        File into which to copy the selected scoring file, for
                        modification.

Options related to the picking:
  -i INTRON_RANGE INTRON_RANGE, --intron-range INTRON_RANGE INTRON_RANGE
                        Range into which intron lengths should fall, as a
                        couple of integers. Transcripts with intron lengths
                        outside of this range will be penalised. Default: (60,
                        900)
  --subloci-out SUBLOCI_OUT
                        Name of the optional subloci output. By default, this
                        will not be produced.
  --monoloci-out MONOLOCI_OUT
                        Name of the optional monoloci output. By default, this
                        will not be produced.
  --no-pad              Disable transcript padding. On by default.
  --reference-update    Flag. If switched on, Mikado will prioritise
                        transcripts marked as reference and will consider any
                        other transcipt within loci only in reference to these
                        reference transcripts. Novel loci will still be
                        reported.
  --only-reference-update
                        Flag. If switched on, Mikado will only keep loci where
                        at least one of the transcripts is marked as
                        "reference". CAUTION: if no transcript has been marked
                        as reference, the output will be completely empty!
  -eri, --exclude-retained-introns
                        Exclude all retained intron alternative splicing
                        events from the final output. Default: False. Retained
                        intron events that do not dirsupt the CDS are kept by
                        Mikado in the final output.
  -kdc, --keep-disrupted-cds
                        Keep in the final output transcripts whose CDS is most
                        probably disrupted by a retained intron event.
                        Default: False. Mikado will try to detect these
                        instances and exclude them from the final output.
  --check-references    Flag. If switched on, Mikado will also check reference
                        models against the general transcript requirements,
                        and will also consider them as potential fragments.
                        This is useful in the context of e.g. updating an *ab-
                        initio* results with data from RNASeq, protein
                        alignments, etc.
  -mco MIN_CLUSTERING_CDNA_OVERLAP, --min-clustering-cdna-overlap MIN_CLUSTERING_CDNA_OVERLAP
                        Minimum cDNA overlap between two transcripts for them
                        to be considered part of the same locus during the
                        late picking stages. NOTE: if --min-cds-overlap is not
                        specified, it will be set to this value! Default: 20%.
  -mcso MIN_CLUSTERING_CDS_OVERLAP, --min-clustering-cds-overlap MIN_CLUSTERING_CDS_OVERLAP
                        Minimum CDS overlap between two transcripts for them
                        to be considered part of the same locus during the
                        late picking stages. NOTE: if not specified, and
                        --min-cdna-overlap is specified on the command line,
                        min-cds-overlap will be set to this value! Default:
                        20%.
  --report-all-orfs     Boolean switch. If set to true, all ORFs will be
                        reported, not just the primary.
  --report-all-external-metrics
                        Boolean switch. If activated, Mikado will report all
                        available external metrics, not just those requested
                        for in the scoring configuration. This might affect
                        speed in Minos analyses.
  --cds-only            "Flag. If set, Mikado will only look for overlap in
                        the coding features when clustering transcripts
                        (unless one transcript is non-coding, in which case
                        the whole transcript will be considered). Please note
                        that Mikado will only consider the **best** ORF for
                        this. Default: False, Mikado will consider transcripts
                        in their entirety.
  --as-cds-only         Flag. If set, Mikado will only consider the CDS to
                        determine whether a transcript is a valid alternative
                        splicing event in a locus.

Options related to the serialisation step:
  --junctions JUNCTIONS
  -bt BLAST_TARGETS, --blast_targets BLAST_TARGETS

Options related to configuring a Daijin run.:
  --daijin              Flag. If set, the configuration file will be also
                        valid for Daijin.
  -bc BLAST_CHUNKS, --blast-chunks BLAST_CHUNKS
                        Number of parallel DIAMOND/BLAST jobs to run. Default:
                        10.
  --use-blast           Flag. If switched on, Mikado will use BLAST instead of
                        DIAMOND.
  --use-transdecoder    Flag. If switched on, Mikado will use TransDecoder
                        instead of Prodigal.
  --mode {nosplit,stringent,lenient,permissive,split} [{nosplit,stringent,lenient,permissive,split} ...]
                        Mode(s) in which Mikado will treat transcripts with
                        multiple ORFs. - nosplit: keep the transcripts whole.
                        - stringent: split multi-orf transcripts if two
                        consecutive ORFs have both BLAST hits and none of
                        those hits is against the same target. - lenient:
                        split multi-orf transcripts as in stringent, and
                        additionally, also when either of the ORFs lacks a
                        BLAST hit (but not both). - permissive: like lenient,
                        but also split when both ORFs lack BLAST hits - split:
                        split multi-orf transcripts regardless of what BLAST
                        data is available. If multiple modes are specified,
                        Mikado will create a Daijin-compatible configuration
                        file.
  --scheduler {local,SLURM,LSF,PBS}
                        Scheduler to use. Default: None - ie, either execute
                        everything on the local machine or use DRMAA to submit
                        and control jobs (recommended).
  --exe EXE             Configuration file for the executables.
  -c CLUSTER_CONFIG, --cluster_config CLUSTER_CONFIG
                        Cluster configuration file to write to.
```


## mikado_prepare

### Tool Description
Prepare input files for Mikado.

### Metadata
- **Docker Image**: quay.io/biocontainers/mikado:2.3.4--py310h8ea774a_2
- **Homepage**: https://github.com/lucventurini/mikado
- **Package**: https://anaconda.org/channels/bioconda/packages/mikado/overview
- **Validation**: PASS

### Original Help Text
```text
usage: Mikado prepare [-h] [--fasta REFERENCE]
                      [--verbose | --quiet | -lv {DEBUG,INFO,WARN,ERROR}]
                      [--start-method {fork,spawn,forkserver}]
                      [-s | -sa STRAND_SPECIFIC_ASSEMBLIES] [--list LIST]
                      [-l LOG] [--lenient] [-m MINIMUM_CDNA_LENGTH]
                      [-MI MAX_INTRON_LENGTH] [-p PROCS] [-scds]
                      [--labels LABELS] [--codon-table CODON_TABLE] [--single]
                      [-od OUTPUT_DIR] [-o OUT] [-of OUT_FASTA]
                      [--configuration CONFIGURATION] [-er]
                      [--strip-faulty-cds] [--seed SEED | --random-seed]
                      [gff ...]

positional arguments:
  gff                   Input GFF/GTF file(s).

options:
  -h, --help            show this help message and exit
  --fasta REFERENCE, --reference REFERENCE, --genome REFERENCE
                        Genome FASTA file. Required.
  --verbose
  --quiet
  -lv {DEBUG,INFO,WARN,ERROR}, --log-level {DEBUG,INFO,WARN,ERROR}
                        Log level. Default: derived from the configuration; if
                        absent, INFO
  --start-method {fork,spawn,forkserver}
                        Multiprocessing start method.
  -s, --strand-specific
                        Flag. If set, monoexonic transcripts will be left on
                        their strand rather than being moved to the unknown
                        strand.
  -sa STRAND_SPECIFIC_ASSEMBLIES, --strand-specific-assemblies STRAND_SPECIFIC_ASSEMBLIES
                        Comma-delimited list of strand specific assemblies.
  --list LIST           Tab-delimited file containing rows with the following
                        format: <file> <label> <strandedness(def. False)>
                        <score(optional, def. 0)> <is_reference(optional, def.
                        False)> <exclude_redundant(optional, def. True)>
                        <strip_cds(optional, def. False)>
                        <skip_split(optional, def. False)> "strandedness",
                        "is_reference", "exclude_redundant", "strip_cds" and
                        "skip_split" must be boolean values (True, False)
                        "score" must be a valid floating number.
  -l LOG, --log LOG     Log file. Optional.
  --lenient             Flag. If set, transcripts with only non-canonical
                        splices will be output as well.
  -m MINIMUM_CDNA_LENGTH, --minimum-cdna-length MINIMUM_CDNA_LENGTH
                        Minimum length for transcripts. Default: 200 bps.
  -MI MAX_INTRON_LENGTH, --max-intron-size MAX_INTRON_LENGTH
                        Maximum intron length for transcripts. Default:
                        1,000,000 bps.
  -p PROCS, --procs PROCS
                        Number of processors to use (default None)
  -scds, --strip_cds    Boolean flag. If set, ignores any CDS/UTR segment.
  --labels LABELS       Labels to attach to the IDs of the transcripts of the
                        input files, separated by comma.
  --codon-table CODON_TABLE
                        Codon table to use. Default: 0 (ie Standard, NCBI #1,
                        but only ATG is considered a valid start codon.
  --single, --single-thread
                        Disable multi-threading. Useful for debugging.
  -od OUTPUT_DIR, --output-dir OUTPUT_DIR
                        Output directory. Default: current working directory
  -o OUT, --out OUT     Output file. Default: mikado_prepared.gtf.
  -of OUT_FASTA, --out_fasta OUT_FASTA
                        Output file. Default: mikado_prepared.fasta.
  --configuration CONFIGURATION, --json-conf CONFIGURATION
                        Configuration file.
  -er, --exclude-redundant
                        Boolean flag. If invoked, Mikado prepare will exclude
                        redundant models,ignoring the per-sample instructions.
  --strip-faulty-cds    Flag. If set, transcripts with an incorrect CDS will
                        be retained but with their CDS stripped. Default
                        behaviour: the whole transcript will be considered
                        invalid and discarded.
  --seed SEED           Random seed number. Default: 0.
  --random-seed         Generate a new random seed number (instead of the
                        default of 0)
```


## mikado_serialise

### Tool Description
Serialise Mikado database

### Metadata
- **Docker Image**: quay.io/biocontainers/mikado:2.3.4--py310h8ea774a_2
- **Homepage**: https://github.com/lucventurini/mikado
- **Package**: https://anaconda.org/channels/bioconda/packages/mikado/overview
- **Validation**: PASS

### Original Help Text
```text
usage: Mikado serialise [-h] [--start-method {fork,spawn,forkserver}]
                        [--shm | --no-shm] [--orfs ORFS]
                        [--transcripts TRANSCRIPTS] [-mr MAX_REGRESSION]
                        [--codon-table CODON_TABLE] [-nsa]
                        [--max-target-seqs MAX_TARGET_SEQS]
                        [-bt BLAST_TARGETS] [--xml XML] [-p PROCS]
                        [--single-thread] [--genome_fai GENOME_FAI]
                        [--genome GENOME] [--junctions JUNCTIONS]
                        [--external-scores EXTERNAL_SCORES] [-mo MAX_OBJECTS]
                        [--no-force | --force] [--configuration CONFIGURATION]
                        [-l [LOG]] [-od OUTPUT_DIR]
                        [-lv {DEBUG,INFO,WARN,ERROR} | --verbose | --quiet | --blast-loading-debug]
                        [--seed SEED | --random-seed]
                        [db]

options:
  -h, --help            show this help message and exit
  --start-method {fork,spawn,forkserver}
                        Multiprocessing start method.
  --shm                 Use /dev/shm (if available) for faster database
                        building.
  --no-shm              Force building the database on its final location,
                        even if /dev/shm is available.
  --no-force            Flag. If set, do not drop the contents of an existing
                        Mikado DB before beginning the serialisation.
  --force               Flag. If set, an existing databse will be deleted
                        (sqlite) or dropped (MySQL/PostGreSQL) before
                        beginning the serialisation.
  -od OUTPUT_DIR, --output-dir OUTPUT_DIR
                        Output directory. Default: current working directory
  -lv {DEBUG,INFO,WARN,ERROR}, --log-level {DEBUG,INFO,WARN,ERROR}
                        Log level. Default: derived from the configuration; if
                        absent, INFO
  --verbose
  --quiet
  --blast-loading-debug
                        Flag. If set, Mikado will switch on the debug mode for
                        the XML/TSV loading.
  --seed SEED           Random seed number. Default: 0.
  --random-seed         Generate a new random seed number (instead of the
                        default of 0)

  --orfs ORFS           ORF BED file(s), separated by commas
  --transcripts TRANSCRIPTS
                        Transcript FASTA file(s) used for ORF calling and
                        BLAST queries, separated by commas. If multiple files
                        are given, they must be in the same order of the ORF
                        files. E.g. valid command lines are:
                        --transcript_fasta all_seqs1.fasta --orfs all_orfs.bed
                        --transcript_fasta seq1.fasta,seq2.fasta --orfs
                        orfs1.bed,orf2.bed --transcript_fasta all_seqs.fasta
                        --orfs orfs1.bed,orf2.bed These are invalid instead: #
                        Inverted order --transcript_fasta
                        seq1.fasta,seq2.fasta --orfs orfs2.bed,orf1.bed #Two
                        transcript files, one ORF file --transcript_fasta
                        seq1.fasta,seq2.fasta --orfs all_orfs.bed
  -mr MAX_REGRESSION, --max-regression MAX_REGRESSION
                        "Amount of sequence in the ORF (in %) to backtrack in
                        order to find a valid START codon, if one is absent.
                        Default: None
  --codon-table CODON_TABLE
                        Codon table to use. Default: 0 (ie Standard, NCBI #1,
                        but only ATG is considered a valid start codon.
  -nsa, --no-start-adjustment
                        Disable the start adjustment algorithm. Useful when
                        using e.g. TransDecoder vs 5+.

  --max-target-seqs MAX_TARGET_SEQS
                        Maximum number of target sequences.
  -bt BLAST_TARGETS, --blast-targets BLAST_TARGETS, --blast_targets BLAST_TARGETS
                        Target sequences
  --xml XML, --tsv XML  BLAST file(s) to parse. They can be provided in three
                        ways: - a comma-separated list - as a base folder -
                        using bash-like name expansion (*,?, etc.). In this
                        case, you have to enclose the filename pattern in
                        double quotes. Multiple folders/file patterns can be
                        given, separated by a comma. BLAST files must be
                        either of two formats: - BLAST XML - BLAST tabular
                        format, with the following **custom** fields: qseqid
                        sseqid pident length mismatch gapopen qstart qend
                        sstart send evalue bitscore ppos btop
  -p PROCS, --procs PROCS
                        Number of threads to use for analysing the BLAST
                        files. This number should not be higher than the total
                        number of XML files.
  --single-thread       Force serialise to run with a single thread,
                        irrespective of other configuration options.

  --genome_fai GENOME_FAI
  --genome GENOME
  --junctions JUNCTIONS

  --external-scores EXTERNAL_SCORES
                        Tabular file containing external scores for the
                        transcripts. Each column should have a distinct name,
                        and transcripts have to be listed on the first column.

  -mo MAX_OBJECTS, --max-objects MAX_OBJECTS
                        Maximum number of objects to cache in memory before
                        committing to the database. Default: 100,000 i.e.
                        approximately 450MB RAM usage for Drosophila.
  --configuration CONFIGURATION, --json-conf CONFIGURATION
  -l [LOG], --log [LOG]
                        Optional log file. Default: stderr
  db                    Optional output database. Default: derived from
                        configuration
```


## mikado_pick

### Tool Description
Launcher of the Mikado pipeline.

### Metadata
- **Docker Image**: quay.io/biocontainers/mikado:2.3.4--py310h8ea774a_2
- **Homepage**: https://github.com/lucventurini/mikado
- **Package**: https://anaconda.org/channels/bioconda/packages/mikado/overview
- **Validation**: PASS

### Original Help Text
```text
usage: Mikado pick [-h] [--fasta GENOME]
                   [--start-method {fork,spawn,forkserver}] [--shm | --no-shm]
                   [-p PROCS] --configuration CONFIGURATION
                   [--scoring-file SCORING_FILE]
                   [-i INTRON_RANGE INTRON_RANGE]
                   [--no-pad | --pad | --codon-table CODON_TABLE]
                   [--pad-max-splices PAD_MAX_SPLICES]
                   [--pad-max-distance PAD_MAX_DISTANCE] [-r REGIONS]
                   [-od OUTPUT_DIR] [--subloci-out SUBLOCI_OUT]
                   [--monoloci-out MONOLOCI_OUT] [--loci-out LOCI_OUT]
                   [--prefix PREFIX] [--source SOURCE]
                   [--report-all-external-metrics] [--no_cds] [--flank FLANK]
                   [--max-intron-length MAX_INTRON_LENGTH] [--no-purge]
                   [--cds-only] [--as-cds-only] [--reference-update]
                   [--report-all-orfs] [--only-reference-update] [-eri] [-kdc]
                   [-mco MIN_CLUSTERING_CDNA_OVERLAP]
                   [-mcso MIN_CLUSTERING_CDS_OVERLAP] [--check-references]
                   [-db SQLITE_DB] [--single] [-l LOG]
                   [--verbose | --quiet | -lv {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                   [--mode {nosplit,stringent,lenient,permissive,split}]
                   [--seed SEED | --random-seed]
                   [gff]

Launcher of the Mikado pipeline.

positional arguments:
  gff

options:
  -h, --help            show this help message and exit
  --fasta GENOME, --genome GENOME
                        Genome FASTA file. Required for transcript padding.
  --start-method {fork,spawn,forkserver}
                        Multiprocessing start method.
  --shm                 Flag. If switched, Mikado pick will copy the database
                        to RAM (ie SHM) for faster access during the run.
  --no-shm              Flag. If switched, Mikado will force using the
                        database on location instead of copying it to /dev/shm
                        for faster access.
  -p PROCS, --procs PROCS
                        Number of processors to use. Default: look in the
                        configuration file (1 if undefined)
  --configuration CONFIGURATION, --json-conf CONFIGURATION
                        Configuration file for Mikado.
  --scoring-file SCORING_FILE
                        Optional scoring file for the run. It will override
                        the value set in the configuration.
  -i INTRON_RANGE INTRON_RANGE, --intron-range INTRON_RANGE INTRON_RANGE
                        Range into which intron lengths should fall, as a
                        couple of integers. Transcripts with intron lengths
                        outside of this range will be penalised. Default: (60,
                        900)
  --no-pad              Disable transcript padding.
  --pad                 Whether to pad transcripts in loci.
  --codon-table CODON_TABLE
                        Codon table to use. Default: 0 (ie Standard, NCBI #1,
                        but only ATG is considered a valid start codon.
  --pad-max-splices PAD_MAX_SPLICES
                        Maximum splice sites that can be crossed during
                        transcript padding.
  --pad-max-distance PAD_MAX_DISTANCE
                        Maximum amount of bps that transcripts can be padded
                        with (per side).
  -r REGIONS, --regions REGIONS
                        Either a single region on the CLI or a file listing a
                        series of target regions. Mikado pick will only
                        consider regions included in this string/file. Regions
                        should be provided in a WebApollo-like format:
                        <chrom>:<start>..<end>
  --no_cds              Flag. If set, not CDS information will be printed out
                        in the GFF output files.
  --flank FLANK         Flanking distance (in bps) to group non-overlapping
                        transcripts into a single superlocus. Default:
                        determined by the configuration file.
  --max-intron-length MAX_INTRON_LENGTH
                        Maximum intron length for a transcript. Default:
                        inferred from the configuration file (default value
                        there is 1,000,000 bps).
  --no-purge            Flag. If set, the pipeline will NOT suppress any loci
                        whose transcripts do not pass the requirements set in
                        the JSON file.
  --cds-only            "Flag. If set, Mikado will only look for overlap in
                        the coding features when clustering transcripts
                        (unless one transcript is non-coding, in which case
                        the whole transcript will be considered). Please note
                        that Mikado will only consider the **best** ORF for
                        this. Default: False, Mikado will consider transcripts
                        in their entirety.
  --as-cds-only         Flag. If set, Mikado will only consider the CDS to
                        determine whether a transcript is a valid alternative
                        splicing event in a locus.
  --reference-update    Flag. If switched on, Mikado will prioritise
                        transcripts marked as reference and will consider any
                        other transcipt within loci only in reference to these
                        reference transcripts. Novel loci will still be
                        reported.
  --report-all-orfs     Boolean switch. If set to true, all ORFs will be
                        reported, not just the primary.
  --only-reference-update
                        Flag. If switched on, Mikado will only keep loci where
                        at least one of the transcripts is marked as
                        "reference". CAUTION: if no transcript has been marked
                        as reference, the output will be completely empty!
  -eri, --exclude-retained-introns
                        Exclude all retained intron alternative splicing
                        events from the final output. Default: False. Retained
                        intron events that do not dirsupt the CDS are kept by
                        Mikado in the final output.
  -kdc, --keep-disrupted-cds
                        Keep in the final output transcripts whose CDS is most
                        probably disrupted by a retained intron event.
                        Default: False. Mikado will try to detect these
                        instances and exclude them from the final output.
  -mco MIN_CLUSTERING_CDNA_OVERLAP, --min-clustering-cdna-overlap MIN_CLUSTERING_CDNA_OVERLAP
                        Minimum cDNA overlap between two transcripts for them
                        to be considered part of the same locus during the
                        late picking stages. NOTE: if --min-cds-overlap is not
                        specified, it will be set to this value! Default: 20%.
  -mcso MIN_CLUSTERING_CDS_OVERLAP, --min-clustering-cds-overlap MIN_CLUSTERING_CDS_OVERLAP
                        Minimum CDS overlap between two transcripts for them
                        to be considered part of the same locus during the
                        late picking stages. NOTE: if not specified, and
                        --min-cdna-overlap is specified on the command line,
                        min-cds-overlap will be set to this value! Default:
                        20%.
  --check-references    Flag. If switched on, Mikado will also check reference
                        models against the general transcript requirements,
                        and will also consider them as potential fragments.
                        This is useful in the context of e.g. updating an *ab-
                        initio* results with data from RNASeq, protein
                        alignments, etc.
  -db SQLITE_DB, --sqlite-db SQLITE_DB
                        Location of an SQLite database to overwrite what is
                        specified in the configuration file.
  --single              Flag. If set, Creator will be launched with a single
                        process, without involving the multithreading
                        apparatus. Useful for debugging purposes only.
  --mode {nosplit,stringent,lenient,permissive,split}
                        Mode in which Mikado will treat transcripts with
                        multiple ORFs. - nosplit: keep the transcripts whole.
                        - stringent: split multi-orf transcripts if two
                        consecutive ORFs have both BLAST hits and none of
                        those hits is against the same target. - lenient:
                        split multi-orf transcripts as in stringent, and
                        additionally, also when either of the ORFs lacks a
                        BLAST hit (but not both). - permissive: like lenient,
                        but also split when both ORFs lack BLAST hits - split:
                        split multi-orf transcripts regardless of what BLAST
                        data is available.
  --seed SEED           Random seed number. Default: 0.
  --random-seed         Generate a new random seed number (instead of the
                        default of 0)

Options related to the output files.:
  -od OUTPUT_DIR, --output-dir OUTPUT_DIR
                        Output directory. Default: current working directory
  --subloci-out SUBLOCI_OUT
  --monoloci-out MONOLOCI_OUT
  --loci-out LOCI_OUT   This output file is mandatory. If it is not specified
                        in the configuration file, it must be provided here.
  --prefix PREFIX       Prefix for the genes. Default: Mikado
  --source SOURCE       Source field to use for the output files.
  --report-all-external-metrics
                        Boolean switch. If activated, Mikado will report all
                        available external metrics, not just those requested
                        for in the scoring configuration. This might affect
                        speed in Minos analyses.

Log options:
  -l LOG, --log LOG     File to write the log to. Default: decided by the
                        configuration file.
  --verbose
  --quiet
  -lv {DEBUG,INFO,WARNING,ERROR,CRITICAL}, --log-level {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Logging level. Default: retrieved by the configuration
                        file.
```


## mikado_compare

### Tool Description
Compare predictions to a reference annotation.

### Metadata
- **Docker Image**: quay.io/biocontainers/mikado:2.3.4--py310h8ea774a_2
- **Homepage**: https://github.com/lucventurini/mikado
- **Package**: https://anaconda.org/channels/bioconda/packages/mikado/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/lib/python3.10/site-packages/Mikado/subprograms/configure.py:7: UserWarning: pkg_resources is deprecated as an API. See https://setuptools.pypa.io/en/latest/pkg_resources.html. The pkg_resources package is slated for removal as early as 2025-11-30. Refrain from using this package or pin to Setuptools<81.
  from pkg_resources import resource_filename, resource_stream
usage: Mikado compare [-h] -r REFERENCE
                      (-p PREDICTION | --self | --internal | --index)
                      [--no-shm | --shm] [--distance DISTANCE] [-pc] [-o OUT]
                      [-fm FUZZYMATCH] [--lenient] [-nF] [-eu] [-n] [-erm]
                      [-upa] [-l LOG] [-v] [-z] [-x PROCESSES]
Mikado compare: error: the following arguments are required: -r/--reference
```


## mikado_util

### Tool Description
Mikado util

### Metadata
- **Docker Image**: quay.io/biocontainers/mikado:2.3.4--py310h8ea774a_2
- **Homepage**: https://github.com/lucventurini/mikado
- **Package**: https://anaconda.org/channels/bioconda/packages/mikado/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/lib/python3.10/site-packages/Mikado/subprograms/configure.py:7: UserWarning: pkg_resources is deprecated as an API. See https://setuptools.pypa.io/en/latest/pkg_resources.html. The pkg_resources package is slated for removal as early as 2025-11-30. Refrain from using this package or pin to Setuptools<81.
  from pkg_resources import resource_filename, resource_stream
usage: Mikado util [-h]
                   {awk_gtf,class_codes,collect_compare,convert,grep,metrics,stats,trim}
                   ...
Mikado util: error: argument -h/--help: ignored explicit argument 'elp'
```

