# riboseed CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| riboseed_ribo_run | PASS |  |
| riboseed_ribo_scan | PASS |  |
| riboseed_ribo_score | PASS |  |
| riboseed_ribo_seed | PASS |  |
| riboseed_ribo_select | PASS |  |
| riboseed_ribo_sim | PASS |  |
| riboseed_ribo_sketch | Not completed | needs Mauve.jar (Mauve contig mover), which is not in the image |
| riboseed_ribo_snag | PASS |  |
| riboseed_ribo_spec | Not completed | no usable data: the small real SPAdes graphs have no complete 16S and 23S nodes, so the run stops with FileNotFoundError for riboSpec_results.tab |
| riboseed_ribo_stack | PASS |  |
| riboseed_ribo_structure | PASS |  |
| riboseed_ribo_swap | PASS |  |

## riboseed_ribo_run

### Tool Description
Run the riboSeed pipeline of scan, select, and seed, plus any additional stages. Uses a config file to wrangle all the args not available via these commandline args. This can either be run by providing (as minimum) a reference, some reads, and an output directory; or, if you have a completed config file, you can run it with just that.

### Metadata
- **Docker Image**: quay.io/biocontainers/riboseed:0.4.90--py_0
- **Homepage**: https://github.com/nickp60/riboSeed
- **Package**: https://anaconda.org/channels/bioconda/packages/riboseed/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/riboseed/overview
- **Total Downloads**: 63.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/nickp60/riboSeed
- **Stars**: N/A
### Original Help Text
```text
usage: ribo run [-r reference.fasta] -c config_file [-o /output/dir/]
                [-e experiment_name] [-K {bac,euk,arc,mito}] [-S 16S:23S:5S]
                [--clusters str] [-C str] [-F reads_F.fq] [-R reads_R.fq]
                [-S1 reads_S.fq] [-s int]
                [--ref_as_contig {ignore,infer,trusted,untrusted}] [--linear]
                [--subassembler {spades,skesa}] [-j] [-l int]
                [-k 21,33,55,77,99,127] [--force_kmers] [-p 21,33,55,77,99]
                [-d int] [--clean_temps] [-i int] [--skip_control]
                [-v {1,2,3,4,5}] [--cores int] [--memory int]
                [--damn_the_torpedos]
                [--stages {sketch,spec,snag,score,stack,none} [{sketch,spec,snag,score,stack,none} ...]]
                [-t {1,2,4}] [--additional_libs str] [-z] [-h] [--version]

Run the riboSeed pipeline of scan, select, and seed, plus any additional
stages. Uses a config file to wrangle all the args not available via these
commandline args. This can either be run by providing (as minimum) a
reference, some reads, and an output directory; or, if you have a completed
config file, you can run it with just that.

optional arguments:
  -r reference.fasta, --reference_fasta reference.fasta
                        path to a (multi)fasta or a directory containing one
                        or more chromosomal sequences in fasta format.
                        Required, unless using a config file
  -c config_file, --config config_file
                        config file; if none given, create one; default: /
  -o /output/dir/, --output /output/dir/
                        output directory; default:
                        /2026-02-25T1616_riboSeed_pipeline_results/
  -e experiment_name, --experiment_name experiment_name
                        prefix for results files; default: inferred
  -K {bac,euk,arc,mito}, --Kingdom {bac,euk,arc,mito}
                        whether to look for eukaryotic, archaeal, or bacterial
                        rDNA; default: bac
  -S 16S:23S:5S, --specific_features 16S:23S:5S
                        colon:separated -- specific features; default:
                        16S:23S:5S
  --clusters str        number of rDNA clusters;if submitting multiple
                        records, must be a colon:separated list whose length
                        matches number of genbank records. Default is inferred
                        from specific feature with fewest hits
  -C str, --cluster_file str
                        clustered_loci file output from riboSelect;this is
                        created by default from run_riboSeed, but if you don't
                        agree with the operon structure predicted by
                        riboSelect, you can use your alternate clustered_loci
                        file. default: None
  -F reads_F.fq, --fastq1 reads_F.fq
                        path to forward fastq file, can be compressed
  -R reads_R.fq, --fastq2 reads_R.fq
                        path to reverse fastq file, can be compressed
  -S1 reads_S.fq, --fastq_single1 reads_S.fq
                        path to single fastq file
  -s int, --score_min int
                        If using smalt, this sets the '-m' param; default with
                        smalt is inferred from read length. If using BWA,
                        reads mapping with ASscore lower than this will be
                        rejected; default with BWA is half of read length
  --ref_as_contig {ignore,infer,trusted,untrusted}
                        ignore: reference will not be used in subassembly.
                        trusted: SPAdes will use the seed sequences as a
                        --trusted-contig; untrusted: SPAdes will treat as
                        --untrusted-contig. infer: if mapping percentage over
                        80%, 'trusted'; else 'untrusted'. See SPAdes docs for
                        details. default: infer
  --linear              if genome is known to not be circular and a region of
                        interest (including flanking bits) extends past
                        chromosome end, this extends the seqence past
                        chromosome origin forward by --padding; default: False
  --subassembler {spades,skesa}
                        assembler to use for subassembly scheme. SPAdes is
                        used by default, but Skesa is a new addition that
                        seems to work for subassembly and is faster
  -j, --just_seed       Don't do an assembly, just generate the long read
                        'seeds'; default: False
  -l int, --flanking_length int
                        length of flanking regions, in bp; default: 1000
  -k 21,33,55,77,99,127, --kmers 21,33,55,77,99,127
                        kmers used for final assembly, separated by commas
                        such as21,33,55,77,99,127. Can be set to 'auto', where
                        SPAdes chooses. We ensure kmers are not too big or too
                        close to read length; default: 21,33,55,77,99,127
  --force_kmers         skip checking to see if kmerchoice is appropriate to
                        read length. Sometimes kmers longer than reads can
                        help in the final assembly, as the long reads
                        generated by riboSeed contain kmers longer than the
                        read length
  -p 21,33,55,77,99, --pre_kmers 21,33,55,77,99
                        kmers used during seeding assemblies, separated bt
                        commas; default: 21,33,55,77,99
  -d int, --min_flank_depth int
                        a subassembly won't be performed if this minimum depth
                        is not achieved on both the 3' and5' end of the
                        pseudocontig. default: 0
  --clean_temps         if --clean_temps, mapping files will be removed once
                        they are no no longer needed during the mapping
                        iterations to save space; default: False
  -i int, --iterations int
                        if iterations>1, multiple seedings will occur after
                        subassembly of seed regions; if setting --target_len,
                        seedings will continue until --iterations are
                        completed or --target_len is matched or exceeded;
                        default: 3
  --skip_control        if --skip_control, no de novo assembly will be done;
                        default: False
  -v {1,2,3,4,5}, --verbosity {1,2,3,4,5}
                        Logger writes debug to file in output dir; this sets
                        verbosity level sent to stderr. 1 = debug(), 2 =
                        info(), 3 = warning(), 4 = error() and 5 = critical();
                        default: 2
  --cores int           cores used; default: None
  --memory int          cores for multiprocessing; default: 8
  --damn_the_torpedos   Ignore certain errors, full speed ahead!
  --stages {sketch,spec,snag,score,stack,none} [{sketch,spec,snag,score,stack,none} ...]
                        Which assessment stages you wish to run: sketch, spec,
                        snag, score, stack. Any combination thereof
  -t {1,2,4}, --threads {1,2,4}
                        if your cores are hyperthreaded, set number threads to
                        the number of threads per processer.If unsure, see
                        'cat /proc/cpuinfo' under 'cpu cores', or 'lscpu'
                        under 'Thread(s) per core'.: 1
  --additional_libs str
                        include these libraries in final assembly in addition
                        to the reads supplied as -F and -R. They must be
                        supplied according to SPAdes arg naming scheme. Use at
                        own risk.default: None
  -z, --serialize       if --serialize, runs seeding and assembly without
                        multiprocessing. We recommend this for machines with
                        less than 8GB RAM: False
  -h, --help            Displays this help message
  --version             show program's version number and exit
```


## riboseed_ribo_score

### Tool Description
This does some simple blasting to detect correctness of riboSeed results

### Metadata
- **Docker Image**: quay.io/biocontainers/riboseed:0.4.90--py_0
- **Homepage**: https://github.com/nickp60/riboSeed
- **Package**: https://anaconda.org/channels/bioconda/packages/riboseed/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ribo score [-h] [-o OUTPUT] [-l FLANKING] [-p MIN_PERCENT]
                  [-f ASSEMBLY_EXT] [-g REF_EXT] [-F] [-v {1,2,3,4,5}]
                  indir

This does some simple blasting to detect correctness of riboSeed results

positional arguments:
  indir                 dir containing a genbank file, assembly filesas
                        fastas. Usually the 'mauve' dir in the riboSeed
                        results

optional arguments:
  -h, --help            show this help message and exit
  -o OUTPUT, --output OUTPUT
                        directory in which to place the output files
  -l FLANKING, --flanking_length FLANKING
                        length of flanking regions, in bp; default: 1000
  -p MIN_PERCENT, --min_percent MIN_PERCENT
                        minimum percent identity
  -f ASSEMBLY_EXT, --assembly_ext ASSEMBLY_EXT
                        extenssion of reference, usually fasta
  -g REF_EXT, --ref_ext REF_EXT
                        extension of reference, usually .gb
  -F, --blast_Full      if true, blast full sequences along with just the
                        flanking. Interpretation is not implemented currently
                        as false positives cant be detected this way
  -v {1,2,3,4,5}, --verbosity {1,2,3,4,5}
                        Logger writes debug to file in output dir; this sets
                        verbosity level sent to stderr. 1 = debug(), 2 =
                        info(), 3 = warning(), 4 = error() and 5 = critical();
                        default: 2
```


## riboseed_ribo_sketch

### Tool Description
Pretty up the plots generated by mauve contig mover

### Metadata
- **Docker Image**: quay.io/biocontainers/riboseed:0.4.90--py_0
- **Homepage**: https://github.com/nickp60/riboSeed
- **Package**: https://anaconda.org/channels/bioconda/packages/riboseed/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ribo sketch [-o OUTDIR] [-f ASSEMBLY_EXT] [-g REF_EXT] [-n NAMES] [-r]
                   [--mauve_jar MAUVE_JAR] [-v {1,2,3,4,5}] [-h]
                   indir

Pretty up the plots generated by mauve contig mover

positional arguments:
  indir                 dir containing a genbank file, assembly filesas
                        fastas. Usually the 'mauve' dir in the riboSeed
                        results

required named arguments:
  -o OUTDIR, --outdir OUTDIR
                        output directory; default: None

optional arguments:
  -f ASSEMBLY_EXT, --assembly_ext ASSEMBLY_EXT
                        extension of assemblies, usually fasta
  -g REF_EXT, --ref_ext REF_EXT
                        extension of reference, usually gb
  -n NAMES, --names NAMES
                        name the resulting plot and output dirs; comma-
                        separate
  -r, --replot          replot, using a previous run of analyses
  --mauve_jar MAUVE_JAR
                        path to Mauve.jar; default:
                        ~/mauve_snapshot_2015-02-13/Mauve.jar
  -v {1,2,3,4,5}, --verbosity {1,2,3,4,5}
                        Logger writes debug to file in output dir; this sets
                        verbosity level sent to stderr. 1 = debug(), 2 =
                        info(), 3 = warning(), 4 = error() and 5 = critical();
                        default: 2
  -h, --help            Displays this help message
```


## riboseed_ribo_snag

### Tool Description
Use to extract regions of interest based on supplied Locus tags and evaluate the extracted regions

### Metadata
- **Docker Image**: quay.io/biocontainers/riboseed:0.4.90--py_0
- **Homepage**: https://github.com/nickp60/riboSeed
- **Package**: https://anaconda.org/channels/bioconda/packages/riboseed/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ribo snag [-o OUTPUT] [-n NAME] [-l FLANKING] [--msa_kmers]
                 [--skip_kmers] [--skip_blast] [--linear] [-p PADDING]
                 [-v VERBOSITY] [--title TITLE] [--clobber] [--no_revcomp]
                 [-j] [--msa_tool {mafft,prank}] [--prank_exe PRANK_EXE]
                 [--mafft_exe MAFFT_EXE] [--barrnap_exe BARRNAP_EXE]
                 [--makeblastdb_exe MAKEBLASTDB_EXE]
                 [--kingdom {mito,euk,arc,bac}] [-s SEQ_NAME] [-h]
                 genbank_genome clustered_loci

Use to extract regions of interest based on supplied Locus tags and evaluate
the extracted regions

positional arguments:
  genbank_genome        Genbank file (WITH SEQUENCE)
  clustered_loci        output from riboSelect

required named arguments:
  -o OUTPUT, --output OUTPUT
                        output directory; default: /

optional arguments:
  -n NAME, --name NAME  rename the contigs with this prefix; default: date
                        (YYYYMMDD)
  -l FLANKING, --flanking_length FLANKING
                        length of flanking regions, in bp; default: 1000
  --msa_kmers           calculate kmer similarity based on aligned sequences
                        instead of raw sequences;default: False
  --skip_kmers          Just plot entropy if MSAdefault: False
  --skip_blast          Skip running BLAST Comparisonsdefault: False
  --linear              if the genome is not circular, and an region of
                        interest (including flanking bits) extends past
                        chromosome end, this extends the sequence past
                        chromosome origin forward by 5kb; default: False
  -p PADDING, --padding PADDING
                        if treating as circular, this controls the length of
                        sequence added to the 5' and 3' ends to allow for
                        selecting regions that cross the chromosome's origin;
                        default: 5000
  -v VERBOSITY, --verbosity VERBOSITY
                        1 = debug(), 2 = info(), 3 = warning(), 4 = error()
                        and 5 = critical(); default: 2
  --title TITLE         String for plot title; uses matplotlib math processing
                        for italics (you know, the LaTeX $..$ syntax):
                        https://matplotlib.org/users/mathtext.html default:
                        inferred from --seq_name
  --clobber             overwrite previous output files; default: False
  --no_revcomp          default returns reverse complimented seq if majority
                        of regions on reverse strand. if --no_revcomp, this is
                        overwridden; default: False
  -j, --just_extract    Dont bother making an MSA, calculating Shannon
                        Entropy, BLASTing, generating plots etc; just extract
                        the regions ; default: False
  --msa_tool {mafft,prank}
                        Path to PRANK executable; default: mafft
  --prank_exe PRANK_EXE
                        Path to PRANK executable; default: prank
  --mafft_exe MAFFT_EXE
                        Path to MAFFT executable; default: mafft
  --barrnap_exe BARRNAP_EXE
                        Path to barrnap executable; default: barrnap
  --makeblastdb_exe MAKEBLASTDB_EXE
                        Path to makeblastdb executable; default: makeblastdb
  --kingdom {mito,euk,arc,bac}
                        kingdom for barrnap; default: bac
  -s SEQ_NAME, --seq_name SEQ_NAME
                        name of genome; default: inferred from file name, as
                        many casesinvolve multiple contigs, etc, making
                        inference from record intractable
  -h, --help            Displays this help message
```


## riboseed_ribo_scan

### Tool Description
Reannotate rRNA in a FASTA file with Barrnap and write an annotated genbank file

### Metadata
- **Docker Image**: quay.io/biocontainers/riboseed:0.4.90--py_0
- **Homepage**: https://github.com/nickp60/riboSeed
- **Package**: https://anaconda.org/channels/bioconda/packages/riboseed/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ribo scan -o OUTPUT [-k {bac,euk,arc,mito}] [-t ID_THRESH]
                 [-b BARRNAP_EXE] [-n NAME] [-c CORES] [-m MIN_LENGTH]
                 [-v {1,2,3,4,5}] [-h]
                 contigs

Given a directory of one or more chromosomes as fasta files, this facilitates
reannotation of rDNA regions with Barrnap and outputs all sequences as a
single, annotated genbank file

positional arguments:
  contigs               either a (multi)fasta or a directory containing one or
                        more chromosomal sequences in fasta format

required named arguments:
  -o OUTPUT, --output OUTPUT
                        output directory; default: /tmp

optional arguments:
  -k {bac,euk,arc,mito}, --kingdom {bac,euk,arc,mito}
                        whether to look for eukaryotic, archaeal, or bacterial
                        rDNA; default: bac
  -t ID_THRESH, --id_thresh ID_THRESH
                        partial rRNA hits below this threshold will be
                        ignored. default: 0.5
  -b BARRNAP_EXE, --barrnap_exe BARRNAP_EXE
                        path to barrnap executable; default: barrnap
  -n NAME, --name NAME  name to give the contig files; default: infered from
                        file
  -c CORES, --cores CORES
                        number of threads/cores to use; default: 2
  -m MIN_LENGTH, --min_length MIN_LENGTH
                        skip the scaffold if its shorter than this default: 0
  -v {1,2,3,4,5}, --verbosity {1,2,3,4,5}
                        Logger writes debug to file in output dir; this sets
                        verbosity level sent to stderr. 1 = debug(), 2 =
                        info(), 3 = warning(), 4 = error() and 5 = critical();
                        default: 2
  -h, --help            Displays this help message
```

## riboseed_ribo_select

### Tool Description
Group rRNA annotations into rDNA operons

### Metadata
- **Docker Image**: quay.io/biocontainers/riboseed:0.4.90--py_0
- **Homepage**: https://github.com/nickp60/riboSeed
- **Package**: https://anaconda.org/channels/bioconda/packages/riboseed/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ribo select [-h] -o OUTPUT [-f FEATURE] [-s SPECIFIC_FEATURES]
                   [--clobber] [-c CLUSTERS] [-v VERBOSITY] [--debug]
                   genbank_genome

This is used to identify and cluster rRNA regions from a gb file, returnsa
text file with the clusters

positional arguments:
  genbank_genome        Genbank file (WITH SEQUENCE)

optional arguments:
  -h, --help            show this help message and exit

required named arguments:
  -o OUTPUT, --output OUTPUT
                        output directory;default: None

optional arguments:
  -f FEATURE, --feature FEATURE
                        Feature, rRNA or RRNA; default: rRNA
  -s SPECIFIC_FEATURES, --specific_features SPECIFIC_FEATURES
                        colon:separated -- specific features; default:
                        16S:23S:5S
  --clobber             overwrite previous output files: default: False
  -c CLUSTERS, --clusters CLUSTERS
                        number of rDNA clusters;if submitting multiple
                        records, must be a colon:separated list whose length
                        matches number of genbank records. Default is inferred
                        from specific feature with fewest hits
  -v VERBOSITY, --verbosity VERBOSITY
                        1 = debug(), 2 = info(), 3 = warning(), 4 = error()
                        and 5 = critical(); default: 2
  --debug               Enable debug messages
```

## riboseed_ribo_seed

### Tool Description
Perform de fere novo assembly of rDNA regions from seeds and reads

### Metadata
- **Docker Image**: quay.io/biocontainers/riboseed:0.4.90--py_0
- **Homepage**: https://github.com/nickp60/riboSeed
- **Package**: https://anaconda.org/channels/bioconda/packages/riboseed/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ribo seed -r REFERENCE_GENBANK -o OUTPUT [-F FASTQ1] [-R FASTQ2]
                 [-S1 FASTQS1] [-l FLANKING] [-j] [-e EXPERIMENT_NAME]
                 [--mapper {smalt,bwa}] [-k KMERS] [-p PRE_KMERS]
                 [--force_kmers] [-s SCORE_MIN] [-a MIN_ASSEMBLY_LEN]
                 [--include_shorts] [--damn_the_torpedos] [--subtract]
                 [--linear] [-d MIN_FLANK_DEPTH]
                 [--subassembler {spades,skesa}]
                 [--ref_as_contig {ignore,infer,trusted,untrusted}]
                 [--additional_libs ADDITIONAL_LIBS] [--clean_temps]
                 [--enable-spades-error-corection] [--skip_control]
                 [-i ITERATIONS] [-v {1,2,3,4,5}] [--target_len TARGET_LEN]
                 [-z] [--consensus] [--smalt_scoring SMALT_SCORING]
                 [--mapper_args MAPPER_ARGS] [--spades_exe SPADES_EXE]
                 [--samtools_exe SAMTOOLS_EXE] [--skesa_exe SKESA_EXE]
                 [--smalt_exe SMALT_EXE] [--bwa_exe BWA_EXE]
                 [--quast_exe QUAST_EXE] [--bcftools_exe BCFTOOLS_EXE]
                 [-c CORES] [-t {1,2,4}] [-m MEMORY] [--version] [-h]
                 clustered_loci_txt

Given cluster file of rDNA regions from riboSelect and either paired-end or
single-end reads, assembles the mapped reads into pseduocontig 'seeds', and
uses those with the reads to runde fere novo and de novo assembly with SPAdes

positional arguments:
  clustered_loci_txt    output from riboSelect

required named arguments:
  -r REFERENCE_GENBANK, --reference_genbank REFERENCE_GENBANK
                        genbank reference, used to estimate insert sizes, and
                        compare with QUAST
  -o OUTPUT, --output OUTPUT
                        output directory; default: /tmp

optional arguments:
  -F FASTQ1, --fastq1 FASTQ1
                        forward fastq reads, can be compressed
  -R FASTQ2, --fastq2 FASTQ2
                        reverse fastq reads, can be compressed
  -S1 FASTQS1, --fastqS1 FASTQS1
                        single fastq reads
  -l FLANKING, --flanking_length FLANKING
                        length of flanking regions, in bp; default: 1000
  -j, --just_seed       Don't do an assembly, just generate the long read
                        'seeds'; default: False
  -e EXPERIMENT_NAME, --experiment_name EXPERIMENT_NAME
                        prefix for results files; default: riboSeed
  --mapper {smalt,bwa}  available mappers: smalt and bwa; default: bwa
  -k KMERS, --kmers KMERS
                        kmers used for final assembly, separated by commas
                        such as21,33,55,77,99,127 . Can be set to 'auto',
                        where SPAdes chooses. We ensure kmers are not too big
                        or too close to read length; default:
                        21,33,55,77,99,127
  -p PRE_KMERS, --pre_kmers PRE_KMERS
                        kmers used during seeding assemblies, separated bt
                        commas; default: 21,33,55,77,99
  --force_kmers         skip checking to see if kmerchoice is appropriate to
                        read length. Sometimes kmers longer than reads can
                        help in the final assembly, as the long reads
                        generated by riboSeed contain kmers longer than the
                        read length
  -s SCORE_MIN, --score_min SCORE_MIN
                        If using smalt, this sets the '-m' param; default with
                        smalt is inferred from read length. If using BWA,
                        reads mapping with ASscore lower than this will be
                        rejected; default with BWA is half of read length
  -a MIN_ASSEMBLY_LEN, --min_assembly_len MIN_ASSEMBLY_LEN
                        if initial SPAdes assembly largest contig is not at
                        least as long as --min_assembly_len, reject. Set this
                        to the length of the seed sequence; if it is not
                        achieved, seeding across regions will likely fail;
                        default: 6000
  --include_shorts      if assembled contig is smaller than
                        --min_assembly_len, contig will still be included in
                        assembly; default: inferred
  --damn_the_torpedos   Ignore certain errors, full speed ahead!
  --subtract            if --subtract reads already used in previousround of
                        subassembly will not be included in subsequent rounds.
                        This can lead to problems with multiple mapping and
                        inflated coverage.
  --linear              if genome is known to not be circular and a region of
                        interest (including flanking bits) extends past
                        chromosome end, this extends the seqence past
                        chromosome origin forward by --padding; default: False
  -d MIN_FLANK_DEPTH, --min_flank_depth MIN_FLANK_DEPTH
                        a subassembly will not be performed if this minimum
                        depth is not achieved on both the 3' and5' end of the
                        pseudocontig. default: 0
  --subassembler {spades,skesa}
                        assembler to use for subassembly scheme. SPAdes is
                        used by default, but Skesa is a new addition that
                        seems to work for subassembly and is faster
  --ref_as_contig {ignore,infer,trusted,untrusted}
                        ignore: reference will not be used in subassembly.
                        trusted: SPAdes will use the seed sequences as a
                        --trusted-contig; untrusted: SPAdes will treat as
                        --untrusted-contig. infer: if mapping percentage over
                        80%, 'trusted'; else 'untrusted'. See SPAdes docs for
                        details. default: infer
  --additional_libs ADDITIONAL_LIBS
                        include this string (usually additional library, but
                        could be other SPAdes args) these libraries in final
                        assembly in addition to the reads supplied as -F and
                        -R. They must be supplied according to SPAdes arg
                        naming scheme. Use at own risk.default: None
  --clean_temps         if --clean_temps, mapping files will be removed once
                        they are no no longer needed during the mapping
                        iterations to save space; default: False
  --enable-spades-error-corection
                        Default behaviour should be to skip read error
                        correction: http://cab.spbu.ru/benchmarking-tools-for-
                        de-novo-microbial-assembly/ . This re-enables
                        itdefault: False
  --skip_control        if --skip_control, no de novo assembly will be done;
                        default: False
  -i ITERATIONS, --iterations ITERATIONS
                        if iterations>1, multiple seedings will occur after
                        subassembly of seed regions; if setting --target_len,
                        seedings will continue until --iterations are
                        completed or --target_len is matched or exceeded;
                        default: 3
  -v {1,2,3,4,5}, --verbosity {1,2,3,4,5}
                        Logger writes debug to file in output dir; this sets
                        verbosity level sent to stderr. 1 = debug(), 2 =
                        info(), 3 = warning(), 4 = error() and 5 = critical();
                        default: 2
  --target_len TARGET_LEN
                        if set, iterations will continue until contigs reach
                        this length, or max iterations (set by --iterations)
                        have been completed. Set as fraction of original seed
                        length by giving a decimal between 0 and 5, or set as
                        an absolute number of base pairs by giving an integer
                        greater than 50. Not used by default
  -z, --serialize       if --serialize, runs seeding and assembly without
                        multiprocessing. This is recommended for machines with
                        less than 8GB RAM: False
  --consensus           if --initial_consensus, generate a mpileup-based
                        consesnsus instead of doing a proper spades
                        subassembly
  --smalt_scoring SMALT_SCORING
                        if mapping with SMALT, submit custom smalt scoring via
                        smalt -S scorespec option; default:
                        match=1,subst=-4,gapopen=-4,gapext=-3
  --mapper_args MAPPER_ARGS
                        submit custom parameters to mapper. And by mapper, I
                        mean bwa, cause we dont support this option for SMALT,
                        sorry. This requires knowledge of your chosen mapper's
                        optional arguments. Proceed with caution! default: -L
                        0,0 -U 0 -a
  --spades_exe SPADES_EXE
                        Path to SPAdes executable; default: spades.py
  --samtools_exe SAMTOOLS_EXE
                        Path to samtools executable; default: samtools
  --skesa_exe SKESA_EXE
                        Path to skesa executable; default: skesa
  --smalt_exe SMALT_EXE
                        Path to smalt executable; default: smalt
  --bwa_exe BWA_EXE     Path to BWA executable; default: bwa
  --quast_exe QUAST_EXE
                        Path to quast executable; default: quast
  --bcftools_exe BCFTOOLS_EXE
                        Path to bcftools executable; default: bcftools
  -c CORES, --cores CORES
                        cores to be used; default: None
  -t {1,2,4}, --threads {1,2,4}
                        if your cores are hyperthreaded, set number threads to
                        the number of threads per processer.If unsure, see
                        'cat /proc/cpuinfo' under 'cpu cores', or 'lscpu'
                        under 'Thread(s) per core'.: 1
  -m MEMORY, --memory MEMORY
                        system memory available; default: 8
  --version             show program's version number and exit
  -h, --help            Displays this help message
```

## riboseed_ribo_stack

### Tool Description
Compare coverage depth in rDNA regions to the rest of the genome

### Metadata
- **Docker Image**: quay.io/biocontainers/riboseed:0.4.90--py_0
- **Homepage**: https://github.com/nickp60/riboSeed
- **Package**: https://anaconda.org/channels/bioconda/packages/riboseed/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ribo stack -o OUTPUT [-b BAM] -r RIBOSEED_DIR [-n N_SAMPLES]
                  [-e EXPERIMENT_NAME] [-i] [-v {1,2,3,4,5}] [-h]
                  riboScan_dir

This facilitates the mapping of reads to a reference and comparison of
coverage depths in rDNA regions to assess disparity in rDNA counts between the
reference and your reads

positional arguments:
  riboScan_dir          We need the gff and fasta files from your riboScan
                        run.

required named arguments:
  -o OUTPUT, --output OUTPUT
                        output directory; default: /tmp

optional arguments:
  -b BAM, --bam BAM     BAM file; tested with BWA output; default: None
  -r RIBOSEED_DIR, --riboSeed_dir RIBOSEED_DIR
                        look for BAM file in this riboSeed output directory
  -n N_SAMPLES, --n_samples N_SAMPLES
                        Number of regions to compare rDNA depth to; must be
                        greater than 1; default: 10
  -e EXPERIMENT_NAME, --experiment_name EXPERIMENT_NAME
                        prefix for results files; default: riboStack
  -i, --infer           If --infer, ignore the name and length of reference
                        sequence, using the BAM header instead default: False
  -v {1,2,3,4,5}, --verbosity {1,2,3,4,5}
                        Logger writes debug to file in output dir; this sets
                        verbosity level sent to stderr. 1 = debug(), 2 =
                        info(), 3 = warning(), 4 = error() and 5 = critical();
                        default: 2
  -h, --help            Displays this help message
```

## riboseed_ribo_spec

### Tool Description
Use an assembly graph to speculate the number of rDNAs

### Metadata
- **Docker Image**: quay.io/biocontainers/riboseed:0.4.90--py_0
- **Homepage**: https://github.com/nickp60/riboSeed
- **Package**: https://anaconda.org/channels/bioconda/packages/riboseed/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ribo spec -o OUTPUT -g ASSEMBLY_GRAPH [--plot_graphs] [-v {1,2,3,4,5}]
                 [-m MIN_CONTIG_LEN] [-a MIN_ANCHOR_LENGTH]
                 [-f MEDIUM_LENGTH_THRESHOLD] [-t THRESHOLD]
                 [-b BARRNAP_LENGTH_THRESHOLD] [--barrnap_exe BARRNAP_EXE]
                 [-c CORES] [-x] [-h]

Given either an assembly graph or a mapping file and reference, determine
whether the number of rDNAs appears to match the reference

required named arguments:
  -o OUTPUT, --output OUTPUT
                        output directory; default: None
  -g ASSEMBLY_GRAPH, --assembly_graph ASSEMBLY_GRAPH
                        fastg assembly graph from SPAdes or a SPAdes output
                        directory. If the latter, riboSpec will be run on both
                        the final assembly graph, and all the intermediate
                        graphs for each k-mer.

optional arguments:
  --plot_graphs         draw the network graphs
  -v {1,2,3,4,5}, --verbosity {1,2,3,4,5}
                        Logger writes debug to file in output dir; this sets
                        verbosity level sent to stderr. 1 = debug(), 2 =
                        info(), 3 = warning(), 4 = error() and 5 = critical();
                        default: 2
  -m MIN_CONTIG_LEN, --min_contig_len MIN_CONTIG_LEN
                        Contigs under this length will be collapsed; default:
                        75
  -a MIN_ANCHOR_LENGTH, --min_anchor_length MIN_ANCHOR_LENGTH
                        Paths must contain at least one node this long as an
                        anchor; default: 500
  -f MEDIUM_LENGTH_THRESHOLD, --medium_length_threshold MEDIUM_LENGTH_THRESHOLD
                        Paths are simplified when contigs are greater than the
                        --min_contig_length, but still short. These medium-
                        length contigs may be assembly artificts or otherwise
                        irrelevent. IF you dont want this filtering applied,
                        set to the same value as --min_contig_len; default:
                        400
  -t THRESHOLD, --threshold THRESHOLD
                        paths must be at least this long (bp) to be
                        considered; default: 1500
  -b BARRNAP_LENGTH_THRESHOLD, --barrnap_length_threshold BARRNAP_LENGTH_THRESHOLD
                        This gets passed to barrnap's --lencutoff argument,
                        for determining what we should treat as a legitimate
                        hmm hit; default: 0.75
  --barrnap_exe BARRNAP_EXE
                        Path to barrnap executable; default: barrnap
  -c CORES, --cores CORES
                        cores to be used; default: None
  -x, --MAKE_ADJACENCY_MATRIX
                        generate and plot an adjacency matrix; default: False
  -h, --help            Displays this help message
```

## riboseed_ribo_swap

### Tool Description
Swap misjoined contigs of a de fere novo assembly for de novo contigs

### Metadata
- **Docker Image**: quay.io/biocontainers/riboseed:0.4.90--py_0
- **Homepage**: https://github.com/nickp60/riboSeed
- **Package**: https://anaconda.org/channels/bioconda/packages/riboseed/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ribo swap -o OUTPUT [-v {1,2,3,4,5}] [-h]
                 de_novo_file de_fere_novo_file bad_contig good_contigs

Given de novo and de fere novo contigs files, a misjoined de fere novo contig
name, and a colon:separated list of de novo contig names, replace the
offending contig with the de novo contig(s)

positional arguments:
  de_novo_file          multifasta containing de novo contigs
  de_fere_novo_file     multifasta containing de fere novo contigs
  bad_contig            name of the bad contig
  good_contigs          colon separated good contigs for replacement

required named arguments:
  -o OUTPUT, --output OUTPUT
                        output directory; default: /tmp

optional arguments:
  -v {1,2,3,4,5}, --verbosity {1,2,3,4,5}
                        Logger writes debug to file in output dir; this sets
                        verbosity level sent to stderr. 1 = debug(), 2 =
                        info(), 3 = warning(), 4 = error() and 5 = critical();
                        default: 2
  -h, --help            Displays this help message
```

## riboseed_ribo_structure

### Tool Description
View the rRNA operon structure across several genomes

### Metadata
- **Docker Image**: quay.io/biocontainers/riboseed:0.4.90--py_0
- **Homepage**: https://github.com/nickp60/riboSeed
- **Package**: https://anaconda.org/channels/bioconda/packages/riboseed/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ribo structure -o OUTPUT [-g GFFDIR] [-k {bac,euk,arc,mito}]
                      [-t ID_THRESH] [-b BARRNAP_EXE] [-c {1,2,4,8,16}]
                      [-v {1,2,3,4,5}]
                      dir
ribo structure: error: the following arguments are required: dir, -o/--output
```

## riboseed_ribo_sim

### Tool Description
Simulate divergent reference sequences with the JC model of genome evolution

### Metadata
- **Docker Image**: quay.io/biocontainers/riboseed:0.4.90--py_0
- **Homepage**: https://github.com/nickp60/riboSeed
- **Package**: https://anaconda.org/channels/bioconda/packages/riboseed/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ribo sim -o OUTPUT [-v {1,2,3,4,5}] [-f FREQUENCY] [-e END_LENGTH]
                [-s SEED] [-h]
                fasta

This uses the JC model of genome evolution to test the effectiveness of
riboSeed on divergent reference sequences.

positional arguments:
  fasta                 (multi)fasta file containing the sequences to be
                        mutated

required named arguments:
  -o OUTPUT, --output OUTPUT
                        output directory; default: /tmp

optional arguments:
  -v {1,2,3,4,5}, --verbosity {1,2,3,4,5}
                        Logger writes debug to file in output dir; this sets
                        verbosity level sent to stderr. 1 = debug(), 2 =
                        info(), 3 = warning(), 4 = error() and 5 = critical();
                        default: 2
  -f FREQUENCY, --frequency FREQUENCY
                        Probability of mutated basesdefault: 0.01
  -e END_LENGTH, --end_length END_LENGTH
                        if value given, only mutated the ends of the sequences
                        and ignore the middledefault: None
  -s SEED, --seed SEED  cause reproduciblity; default: None
  -h, --help            Displays this help message
```

## Metadata
- **Skill**: generated
