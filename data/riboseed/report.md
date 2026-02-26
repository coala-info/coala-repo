# riboseed CWL Generation Report

## riboseed_ribo run

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


## riboseed_ribo score

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


## riboseed_ribo sketch

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


## riboseed_ribo snag

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

