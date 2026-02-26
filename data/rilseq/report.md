# rilseq CWL Generation Report

## rilseq_map_single_fragments.py

### Tool Description
Map fastq files to the genome using bwa.

### Metadata
- **Docker Image**: quay.io/biocontainers/rilseq:0.82--pyhdfd78af_0
- **Homepage**: http://github.com/asafpr/RILseq
- **Package**: https://anaconda.org/channels/bioconda/packages/rilseq/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/rilseq/overview
- **Total Downloads**: 31.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/asafpr/RILseq
- **Stars**: N/A
### Original Help Text
```text
usage: map_single_fragments.py [-h] [-1 FASTQ_1 [FASTQ_1 ...]]
                               [-2 [FASTQ_2 ...]] [-g GENES_GFF] [-r]
                               [-f FEATURE] [-i IDENTIFIER] [-v OVERLAP]
                               [-m ALLOWED_MISMATCHES] [-o OUTHEAD]
                               [-d DIROUT] [--bwa_exec BWA_EXEC]
                               [-S SAMTOOLS_CMD] [-a PARAMS_ALN]
                               [-s SAMPE_PARAMS] [--samse_params SAMSE_PARAMS]
                               [-w]
                               genome_fasta

Map fastq files to the genome using bwa.

positional arguments:
  genome_fasta          Name of genome fasta file. The file must be indexed
                        usingbwa index command prior to this run.

optional arguments:
  -h, --help            show this help message and exit
  -1 FASTQ_1 [FASTQ_1 ...], --fastq_1 FASTQ_1 [FASTQ_1 ...]
                        A list of the first read of the sequencing. (default:
                        None)
  -2 [FASTQ_2 ...], --fastq_2 [FASTQ_2 ...]
                        A list of the second read of the sequencing. The order
                        of these files should be as same as -1. Optional.
                        (default: None)
  -g GENES_GFF, --genes_gff GENES_GFF
                        Name of gff file to count the reads per gene. If not
                        given or not readable, skip this stage. (default:
                        None)
  -r, --reverse_complement
                        Treat the reads as reverse complement only when
                        counting number of reads per gene and generating wig
                        file. The resulting BAM files will be the original
                        ones. Use this when treating libraries built using
                        Livny's protocol. (default: False)
  -f FEATURE, --feature FEATURE
                        Name of features to count on the GTF file (column 2).
                        (default: exon)
  -i IDENTIFIER, --identifier IDENTIFIER
                        Name of identifier to print (in column 8 of the GTF
                        file). (default: gene_id)
  -v OVERLAP, --overlap OVERLAP
                        Minimal required overlap between the fragment and the
                        feature. (default: 5)
  -m ALLOWED_MISMATCHES, --allowed_mismatches ALLOWED_MISMATCHES
                        Allowed mismatches for BWA mapping. (default: 2)
  -o OUTHEAD, --outhead OUTHEAD
                        Output file names of counts table (suffixed
                        _counts.txt) and wiggle file (suffixed _coverage.wig)
                        (default: bwa_mapped_single_reads)
  -d DIROUT, --dirout DIROUT
                        Output directory, default is this directory. (default:
                        .)
  --bwa_exec BWA_EXEC   bwa command (default: bwa)
  -S SAMTOOLS_CMD, --samtools_cmd SAMTOOLS_CMD
                        Samtools executable. (default: samtools)
  -a PARAMS_ALN, --params_aln PARAMS_ALN
                        Additional parameters for aln function of bwa.
                        (default: -t 8 -R 200)
  -s SAMPE_PARAMS, --sampe_params SAMPE_PARAMS
                        Additional parameters for sampe function of bwa.
                        (default: -a 1500 -P)
  --samse_params SAMSE_PARAMS
                        Additional parameters for samse function of bwa.
                        (default: )
  -w, --create_wig      Create a coverage wiggle file. (default: False)
```


## rilseq_map_chimeric_fragments.py

### Tool Description
Map unmapped reads as chimeric fragments

### Metadata
- **Docker Image**: quay.io/biocontainers/rilseq:0.82--pyhdfd78af_0
- **Homepage**: http://github.com/asafpr/RILseq
- **Package**: https://anaconda.org/channels/bioconda/packages/rilseq/overview
- **Validation**: PASS

### Original Help Text
```text
usage: map_chimeric_fragments.py [-h] [-r] [-t TRANSCRIPTS] [-s DISTANCE]
                                 [--dust_thr DUST_THR] [-d DIROUT]
                                 [-a ALL_READS] [-A] [--keep_circular]
                                 [-l LENGTH] [--max_mismatches MAX_MISMATCHES]
                                 [--allowed_mismatches ALLOWED_MISMATCHES]
                                 [--skip_mapping] [--maxG MAXG] [-f FEATURE]
                                 [-i IDENTIFIER] [--bwa_exec BWA_EXEC]
                                 [-S SAMTOOLS_CMD] [--params_aln PARAMS_ALN]
                                 [--samse_params SAMSE_PARAMS]
                                 genome_fasta bamfiles [bamfiles ...]

Map unmapped reads as chimeric fragments

positional arguments:
  genome_fasta          Name of genome fasta file. The file must be indexed
                        usingbwa index command prior to this run.
  bamfiles              One or more bam files.

optional arguments:
  -h, --help            show this help message and exit
  -r, --reverse_complement
                        Treat the reads as reverse complement. This means that
                        the first read is actually the 3' end of the fragment.
                        Use this when using Jonathan Livny's protocol for
                        library construction (default: False)
  -t TRANSCRIPTS, --transcripts TRANSCRIPTS
                        A gff file of transcripts. If given, screen reads that
                        might reside from the same transcript. Very useful for
                        screening ribosomal RNAs. Otherwise use only the size
                        limit. (default: None)
  -s DISTANCE, --distance DISTANCE
                        Maximal distance between concordant reads. If they are
                        generated from the same strand but larger than this
                        distance they will be considered as chimeric.
                        (default: 1000)
  --dust_thr DUST_THR   Threshold for dust filter. If 0 skip. (default: 10)
  -d DIROUT, --dirout DIROUT
                        Output directory, default is this directory. (default:
                        ./remapped-data/)
  -a ALL_READS, --all_reads ALL_READS
                        Map all reads in the BAM file, write all the fragments
                        that are not chimeric to the file specified here e.g.
                        -a single_fragments_mapping.txt. By default these
                        reads will be written to the standard output.
                        (default: None)
  -A, --add_all_reads   By default map all reads in the BAM file, write all
                        the fragments, either chimeric ro single to the output
                        file (stdout). If this option is selected don't wirte
                        the single reads. (default: True)
  --keep_circular       Remove reads that are probably a result of circular
                        RNAs by default. If the reads are close but in
                        opposite order they will be removed unless this
                        argument is set. (default: False)
  -l LENGTH, --length LENGTH
                        Length of sequence to map. Take the ends of the
                        fragment and map each to the genome. The length of the
                        region will be this length. (default: 25)
  --max_mismatches MAX_MISMATCHES
                        Find alignment allowing this number of mismatches. If
                        there are more than one match with this number of
                        mismatches the read will be treated as if it might
                        match all of them and if there is one scenario in
                        which the two ends are concordant it will be removed.
                        (default: 3)
  --allowed_mismatches ALLOWED_MISMATCHES
                        This number of mismatches is allowed between the a
                        match and the genome. If there are mapped reads with
                        less than --max_mismatches mismatches but more than
                        this number the read will be ignored. (default: 1)
  --skip_mapping        Skip the mapping step, use previously mapped files.
                        (default: False)
  --maxG MAXG           If a read has more than this fraction of Gs remove
                        this readfrom the screen. This is due to nextseq
                        technology which puts G where there is no signal, the
                        poly G might just be noise. When using other
                        sequencing technologies set to 1. (default: 0.8)
  -f FEATURE, --feature FEATURE
                        Name of features to count on the GTF file (column 2).
                        (default: exon)
  -i IDENTIFIER, --identifier IDENTIFIER
                        Name of identifier to print (in column 8 of the GTF
                        file). (default: gene_id)
  --bwa_exec BWA_EXEC   bwa command (default: bwa)
  -S SAMTOOLS_CMD, --samtools_cmd SAMTOOLS_CMD
                        Samtools executable. (default: samtools)
  --params_aln PARAMS_ALN
                        Additional parameters for aln function of bwa.
                        (default: -t 8 -N -M 0)
  --samse_params SAMSE_PARAMS
                        Additional parameters for samse function of bwa.
                        (default: -n 1000)
```


## rilseq_RILseq_significant_regions.py

### Tool Description
Find over-represented regions of interactions.

### Metadata
- **Docker Image**: quay.io/biocontainers/rilseq:0.82--pyhdfd78af_0
- **Homepage**: http://github.com/asafpr/RILseq
- **Package**: https://anaconda.org/channels/bioconda/packages/rilseq/overview
- **Validation**: PASS

### Original Help Text
```text
usage: RILseq_significant_regions.py [-h] [-g GENOME] [--total_RNA TOTAL_RNA]
                                     [--total_reverse]
                                     [--min_total_counts MIN_TOTAL_COUNTS]
                                     [--norm_percentile NORM_PERCENTILE]
                                     [--bc_dir BC_DIR] [--ribozero]
                                     [--rrna_list RRNA_LIST]
                                     [--all_interactions] [--only_singles]
                                     [--est_utr_lens EST_UTR_LENS]
                                     [--BC_chrlist BC_CHRLIST]
                                     [--refseq_dir REFSEQ_DIR]
                                     [-t TARGETS_FILE] [-c SINGLE_COUNTS]
                                     [-r REP_TABLE] [-l LENGTH] [-s SHUFFLES]
                                     [--servers SERVERS] [--run_RNAup]
                                     [--RNAup_cmd RNAUP_CMD]
                                     [--pad_seqs PAD_SEQS] [--seglen SEGLEN]
                                     [--maxsegs MAXSEGS] [--min_int MIN_INT]
                                     [--max_pv MAX_PV]
                                     [--min_odds_ratio MIN_ODDS_RATIO]
                                     [--linear_chromosome_list LINEAR_CHROMOSOME_LIST]
                                     reads_in

Find over-represented regions of interactions.

positional arguments:
  reads_in              An output file of map_chimeric_fragments.py with the
                        chimeric fragments.

optional arguments:
  -h, --help            show this help message and exit
  -g GENOME, --genome GENOME
                        genome fasta file (default: None)
  --total_RNA TOTAL_RNA
                        Normalize in total RNA from these bam files. Enter a
                        comma separated list of bam files. (default: None)
  --total_reverse       Total library is the reverse strand. (default: False)
  --min_total_counts MIN_TOTAL_COUNTS
                        Minimal number of reads in the total library to assess
                        normalization from. (default: 10)
  --norm_percentile NORM_PERCENTILE
                        Percentile of IP/total to use when evaluating
                        normalization of odds ratio in total. The value
                        IP/total is evaluated for every region with at least
                        (--min_total_counts) reads and to avoid outliers the
                        99th percentile is taken as the normalization value
                        meaning this is the highest amount of IP reads that
                        can be obtained in this library given the amount of
                        total RNA. (default: 0.99)
  --bc_dir BC_DIR       BioCyc data dir, used to map the regions to genes. If
                        not given only the regions will be reported (default:
                        None)
  --ribozero            Remove rRNA prior to the statistical analysis.
                        (default: False)
  --rrna_list RRNA_LIST
                        rRNA list of types for rRNA_prod param in
                        read_genes_data(). this is a no spaces comma-seperated
                        list. e.g. 'rRNA,rrna,RRNA' (default: rRNA,rrna,RRNA)
  --all_interactions    Skip all statistical tests and report all the
                        interactions. (default: False)
  --only_singles        Return only the single interactions. This should be
                        used with --all_interactions to count the number of
                        single reads in the library. (default: False)
  --est_utr_lens EST_UTR_LENS
                        Estimated UTRs lengths when there is not data.
                        (default: 100)
  --BC_chrlist BC_CHRLIST
                        A comma separated dictionary of chromosome names from
                        the bam file to EcoCyc names. See the names of
                        chromosomes in bam file using samtools view -H
                        foo.bam. (default: chr,COLI-K12)
  --refseq_dir REFSEQ_DIR
                        RefSeq dir of organism to get the gene description
                        from. (default: None)
  -t TARGETS_FILE, --targets_file TARGETS_FILE
                        A list of sRNA-mRNA interactions, should be in EcoCyc
                        acc. (default: None)
  -c SINGLE_COUNTS, --single_counts SINGLE_COUNTS
                        A file with the counts of single fragments per gene.
                        (default: None)
  -r REP_TABLE, --rep_table REP_TABLE
                        A table containing data on REP elements. This file was
                        generated using SmartTables (e.g. this:
                        http://ecocyc.org/group?id=biocyc14-8223-3640227683)
                        (default: None)
  -l LENGTH, --length LENGTH
                        Length of sequence used for mapping. Used to determine
                        the gene in the regions. (default: 25)
  -s SHUFFLES, --shuffles SHUFFLES
                        Shuffle the first sequence to compute an empirical
                        p-value of the hybridization energy using RNAup.
                        (default: 0)
  --servers SERVERS     A list of computers to run RNAup on (or number of
                        CPUs) (default: None)
  --run_RNAup           Run RNAup and compute the interactions predicted
                        strength (default: False)
  --RNAup_cmd RNAUP_CMD
                        Executable of RNAup with its parameters (default:
                        RNAup)
  --pad_seqs PAD_SEQS   When computing RNAup pad the interacting regions.
                        (default: 50)
  --seglen SEGLEN       Length of minimal segment of interaction. (default:
                        100)
  --maxsegs MAXSEGS     Maximal number of consecutive segments that will be
                        treated as a region. (default: 5)
  --min_int MIN_INT     Minimal number of interactions to report. (default: 5)
  --max_pv MAX_PV       Maximal pvalue to report (after correction). (default:
                        0.05)
  --min_odds_ratio MIN_ODDS_RATIO
                        Minimal odds ratio to report (default: 1.0)
  --linear_chromosome_list LINEAR_CHROMOSOME_LIST
                        A list of chromosomes/plasmids names that are linear
                        and not cyclic.The name should be identical to the
                        chromosome/plasmid name in the given genome fasta
                        file. (default: )
```

