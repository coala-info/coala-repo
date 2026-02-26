# captus CWL Generation Report

## captus_clean

### Tool Description
Clean; remove adaptors and quality-filter reads with BBTools

### Metadata
- **Docker Image**: quay.io/biocontainers/captus:1.6.3--pyh05cac1d_0
- **Homepage**: https://github.com/edgardomortiz/Captus
- **Package**: https://anaconda.org/channels/bioconda/packages/captus/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/captus/overview
- **Total Downloads**: 37.7K
- **Last updated**: 2026-02-22
- **GitHub**: https://github.com/edgardomortiz/Captus
- **Stars**: N/A
### Original Help Text
```text
usage: captus clean -r READS [READS ...] [options]

[1mCaptus-assembly: Clean; remove adaptors and quality-filter reads with
BBTools [0m

Input:
  -r, --reads READS [READS ...]
                          FASTQ files. Valid filename extensions are: .fq,
                          .fastq, .fq.gz, and .fastq.gz. The names must
                          include the string '_R1' (and '_R2' when pairs are
                          provided). Everything before the string '_R1' will
                          be used as sample name. There are a few ways to
                          provide the FASTQ files:
                            A directory = path to directory containing FASTQ
                                          files (e.g.: -r ./raw_reads)
                            A list = filenames separated by space (e.g.: -r
                                     A_R1.fq A_R2.fq B_R1.fq C_R1.fq)
                            A pattern = UNIX matching expression (e.g.: -r
                                        ./raw_reads/*.fastq.gz)

Output:
  -o, --out OUT           Output directory name (default: ./01_clean_reads)
  --keep_all              Do not delete any intermediate files (default:
                          False)
  --overwrite             Overwrite previous results (default: False)

Adaptor trimming:
  --adaptor_set ADAPTOR_SET
                          Set of adaptors to remove
                            Illumina = Illumina adaptors included in BBTools
                            BGI = BGISEQ, DNBSEG, or MGISEQ adaptors
                            ALL = Illumina + BGI
                            Alternatively, you can provide a path to a FASTA
                            file containing your own adaptors (default: ALL)
  --rna                   Trim ploy-A tails from RNA-Seq reads (default:
                          False)

Quality trimming and filtering:
  --trimq TRIMQ           Leading and trailing read regions with average PHRED
                          quality score below this value will be trimmed
                          (default: 13)
  --maq MAQ               After quality trimming, reads with average PHRED
                          quality score below this value will be removed
                          (default: 16)
  --ftl FTL               Trim any base to the left of this position. For
                          example, if you want to remove 4 bases from the left
                          of the reads set this number to 5 (default: 0)
  --ftr FTR               Trim any base to the right of this position. For
                          example, if you want to truncate your reads length
                          to 100 bp set this number to 100 (default: 0)

QC Statistics:
  --qc_program {fastqc,falco}
                          Which program to use to obtain the statistics from
                          the raw and cleaned FASTQ files. Falco produces
                          identical results to FastQC while being much faster
                          (default: fastqc)
  --skip_qc_stats         Skip FastQC/Falco analysis on raw and cleaned reads
                          (default: False)

Other:
  --bbduk_path BBDUK_PATH
                          Path to bbduk.sh (default: bbduk.sh)
  --falco_path FALCO_PATH
                          Path to Falco (default: falco)
  --fastqc_path FASTQC_PATH
                          Path to FastQC (default: fastqc)
  --ram RAM               Maximum RAM in GB (e.g.: 4.5) dedicated to Captus,
                          'auto' uses 99% of available RAM (default: auto)
  --threads THREADS       Maximum number of CPUs dedicated to Captus, 'auto'
                          uses all available CPUs (default: auto)
  --concurrent CONCURRENT
                          Captus will attempt to run FastQC concurrently on
                          this many samples. If set to 'auto', Captus will run
                          at most 4 instances of FastQC or as many CPU cores
                          are available, whatever number is lower (default:
                          auto)
  --debug                 Enable debugging mode, parallelization is disabled
                          so errors are logged to screen (default: False)
  --show_less             Do not show individual sample information during the
                          run, the information is still written to the log
                          (default: False)

Help:
  -h, --help              Show this help message and exit
  --version               Show Captus' version number

For more information, please see https://github.com/edgardomortiz/Captus
```


## captus_assemble

### Tool Description
Assemble; perform de novo assembly using MEGAHIT

### Metadata
- **Docker Image**: quay.io/biocontainers/captus:1.6.3--pyh05cac1d_0
- **Homepage**: https://github.com/edgardomortiz/Captus
- **Package**: https://anaconda.org/channels/bioconda/packages/captus/overview
- **Validation**: PASS

### Original Help Text
```text
usage: captus assemble -r READS [READS ...] [options]

[1mCaptus-assembly: Assemble; perform de novo assembly using MEGAHIT [0m

Input:
  -r, --reads READS [READS ...]
                          FASTQ files. Valid file name extensions are: .fq,
                          .fastq, .fq.gz, and .fastq.gz. The names must
                          include the string '_R1' (and '_R2' when pairs are
                          provided). Everything before the string '_R1' will
                          be used as sample name. There are a few ways to
                          provide the FASTQ files:
                            A directory = path to directory containing FASTQ
                                          files (e.g.: -r ./raw_reads)
                            A list = file names separated by space (e.g.: -r
                                     A_R1.fq A_R2.fq B_R1.fq C_R1.fq)
                            A pattern = UNIX matching expression (e.g.: -r
                                        ./raw_reads/*.fastq.gz) (default:
                                        ./01_clean_reads)
  --sample_reads_target SAMPLE_READS_TARGET
                          Use this number of read pairs (or reads if single-
                          end) for assembly. Reads are randomly subsampled
                          with 'reformat.sh' from BBTools (option:
                          srt/samplereadstarget). Useful for limiting the
                          amount of data of samples with very high sequencing
                          depth. To use all the reads, set this value to 0
                          (default: 0)

Output:
  -o, --out OUT           Output directory name. Inside this directory the
                          output for each sample will be stored in a
                          subdirectory named as 'Sample_name__captus-asm'
                          (default: ./02_assemblies)
  --keep_all              Do not delete any intermediate files (default:
                          False)
  --overwrite             Overwrite previous results (default: False)

MEGAHIT:
  --k_list K_LIST         Comma-separated list of kmer sizes, all must be odd
                          values in the range 15-255, in increments of at most
                          28. If not provided, a list optimized for
                          hybridization capture and/or genome skimming data
                          will be used. The final kmer size will be adjusted
                          automatically so it never exceeds the mean read
                          length of the sample by more than 31
  --min_count MIN_COUNT   Minimum contig depth (a.k.a. multiplicity in
                          MEGAHIT), accepted values are integers >= 1.
                          Reducing it to 1 may increase the amount of low-
                          depth contigs likely produced from reads with
                          errors. Increase above 2 if the data has high and
                          even sequencing depth
  --prune_level PRUNE_LEVEL
                          Prunning strength for low-coverage edges during
                          graph cleaning. Increasing the value beyond 2 can
                          speed up the assembly at the cost of losing low-
                          depth contigs. Accepted values are integers between
                          0 and 3
  --merge_level MERGE_LEVEL
                          Merge complex bubbles, the first number multiplied
                          by the kmer size represents the maximum bubble
                          length to merge, the second number represents the
                          minimum similarity required to merge bubbles
                          (default: 20,0.95)
  --preset {CAPSKIM,RNA,WGS}
                          The default preset is 'CAPSKIM', these settings work
                          well with either hybridization capture or genome
                          skimming data (or a combination of both). You can
                          assemble RNA-Seq reads with the 'RNA' preset or
                          high-coverage Whole Genome Sequencing reads with the
                          'WGS' preset, however, both presets require a
                          minimum of 8GB of RAM to work well. In order to
                          avoid RAM limitations when assembly high-depth data,
                          consider using '--preset WGS --concurrent 1' to
                          assemble a single sample at time using all the CPUs
                          and RAM provided by '--threads' and '--ram'
                          (default: CAPSKIM)
                            CAPSKIM = --k-list
                                      31,39,47,63,79,95,111,127,143,159,175
                                      --min-count 2 --prune-level 2
                            RNA = --k-list 27,47,67,87,107,127,147,167
                                  --min-count 2 --prune-level 2
                            WGS = --k-list 31,39,49,69,89,109,129,149,169
                                  --min-count 3 --prune-level 2
  --min_contig_len MIN_CONTIG_LEN
                          Minimum contig length in output assembly, 'auto' is
                          mean input read length + smallest kmer size in '--
                          k_list' (default: auto)
  --tmp_dir TMP_DIR       Location to create the temporary directory
                          'captus_assembly_tmp' for MEGAHIT assembly.
                          Sometimes, when working on external hard drives
                          MEGAHIT will refuse to run unless this directory is
                          created in an internal hard drive (default: $HOME)
  --max_contig_gc MAX_CONTIG_GC
                          Maximum GC percentage allowed per contig. Useful to
                          filter contamination. For example, bacteria usually
                          exceed 60% GC content while eukaryotes rarely exceed
                          that limit. 100.0 disables the GC filter (default:
                          100.0)
  --disable_mapping       Disable mapping the reads back to the contigs using
                          Salmon for accurate depth estimation. If disabled,
                          the approximate depth estimation given by MEGAHIT
                          will be used instead (default: False)
  --min_contig_depth MIN_CONTIG_DEPTH
                          Minimum contig depth of coverage in output assembly;
                          'auto' will retain contigs with depth of coverage
                          greater than 1.0x when '--disable_mapping' is
                          chosen, otherwise it will retain only contigs of at
                          least 1.5x. Accepted values are decimals greater or
                          equal to 0. Use 0 to disable the filter (default:
                          auto)
  --redo_filtering        Enable if you want to try different values for
                          `--max_contig_gc` or `--min_contig_depth`. Only the
                          filtering step will be repeated (default: False)

Other:
  --reformat_path REFORMAT_PATH
                          Path to reformat.sh (default: reformat.sh)
  --megahit_path MEGAHIT_PATH
                          Path to MEGAHIT (default: megahit)
  --megahit_toolkit_path MEGAHIT_TOOLKIT_PATH
                          Path to MEGAHIT's toolkit (default: megahit_toolkit)
  --salmon_path SALMON_PATH
                          Path to Salmon (default: salmon)
  --ram RAM               Maximum RAM in GB (e.g.: 4.5) dedicated to Captus,
                          'auto' uses 99% of available RAM (default: auto)
  --threads THREADS       Maximum number of CPUs dedicated to Captus, 'auto'
                          uses all available CPUs (default: auto)
  --concurrent CONCURRENT
                          Captus will attempt to assemble this many samples
                          concurrently. RAM and CPUs will be divided by this
                          value for each individual MEGAHIT process. For
                          example if you set --threads to 12 and --concurrent
                          to 3, then each MEGAHIT assembly will be done using
                          --threads/--concurrent = 4 CPUs. If set to 'auto',
                          Captus will run as many concurrent assemblies as
                          possible with a minimum of 4 CPUs and 4 GB of RAM
                          per assembly (8 GB if presets RNA or WGS are used)
                          (default: auto)
  --debug                 Enable debugging mode, parallelization is disabled
                          so errors are logged to screen (default: False)
  --show_less             Do not show individual sample information during the
                          run, the information is still written to the log
                          (default: False)

Help:
  -h, --help              Show this help message and exit
  --version               Show Captus' version number

For more information, please see https://github.com/edgardomortiz/Captus
```


## captus_extract

### Tool Description
Captus-assembly: Extract; recover markers from FASTA assemblies

### Metadata
- **Docker Image**: quay.io/biocontainers/captus:1.6.3--pyh05cac1d_0
- **Homepage**: https://github.com/edgardomortiz/Captus
- **Package**: https://anaconda.org/channels/bioconda/packages/captus/overview
- **Validation**: PASS

### Original Help Text
```text
usage: captus extract -a CAPTUS_ASSEMBLIES_DIR [options]

[1mCaptus-assembly: Extract; recover markers from FASTA assemblies [0m

Input:
  -a, --captus_assemblies_dir CAPTUS_ASSEMBLIES_DIR
                          Path to an output directory from the 'assemble' step
                          of Captus-assembly which is tipically called
                          '02_assemblies'. If you DID NOT assemble any sample
                          within Captus and want to start exclusivey with
                          FASTAs assembled elsewhere, the path provided here
                          will be created in order to contain your assemblies
                          provided with '-f' into a proper directory structure
                          needed by Captus (default: ./02_assemblies)
  -f, --fastas FASTAS [FASTAS ...]
                          FASTA assembly file(s) that were not assembled with
                          Captus. Valid file name extensions are: .fa, .fna,
                          .fasta, .fa.gz, .fna.gz, .fasta.gz. These FASTA
                          files must contain only nucleotides (no aminoacids).
                          All the text before the extension of the filename
                          will be used as sample name. These FASTAs will be
                          automatically copied to the path provided with
                          '-a'/'--captus_assemblies_dir' using the correct
                          directory structure needed by Captus. There are a
                          few ways to provide the FASTA files:
                            A directory = path to directory containing FASTA
                                          files (e.g.: -f ./my_fastas)
                            A list = filenames separated by space (e.g.: -f
                                     speciesA.fa speciesB.fasta.gz)
                            A pattern = UNIX matching expression (e.g.: -f
                                        ./my_fastas/*.fasta)

Output:
  -o, --out OUT           Output directory name (default: ./03_extractions)
  --ignore_depth          Do not filter contigs based on their depth of
                          coverage (default: False)
  --disable_stitching     Use only if you are sure your target loci will be
                          found in a single contig (for example if you have a
                          chromosome-level assembly), otherwise Captus tries
                          to join partial matches to a target that are
                          scattered across multiple contigs if their structure
                          and overlaps are compatible (default: False)
  --max_locus_overlap MAX_LOCUS_OVERLAP
                          Maximum overlap percentage allowed between loci
                          annotations, nuclear genes usually do not overlap
                          but certain organellar genes do (default: 5.0)
  --pit, --paralog_identity_tolerance PARALOG_IDENTITY_TOLERANCE
                          Keep paralogs if they have at least this proportion
                          of the identity of the best hit in the locus, use 0
                          to disable this filter (default: 0.66)
  --pct, --paralog_coverage_tolerance PARALOG_COVERAGE_TOLERANCE
                          Keep paralogs if they have at least this proportion
                          of the coverage of the best hit in the locus, use 0
                          to disable this filter (default: 0.33)
  --pdt, --paralog_depth_tolerance PARALOG_DEPTH_TOLERANCE
                          Keep paralogs if they have at least this proportion
                          of the depth of the best hit in the locus, use 0 to
                          disable this filter. Reduce accordingly if you have
                          polyploids in your dataset (default: 0.33)
  --max_paralogs MAX_PARALOGS
                          Maximum number of secondary hits (copies) of any
                          particular reference target marker allowed in the
                          output. We recommend disabling the removal of
                          paralogs (secondary hits/copies) during the
                          'extract' step because the 'align' step uses a more
                          sophisticated filter for paralogs. -1 disables the
                          removal of paralogs (default: -1)
  --max_loci_files MAX_LOCI_FILES
                          When the number of markers in a reference target
                          file exceeds this number, Captus will not write a
                          separate FASTA file per sample per marker to not
                          overload I/O. The single FASTA file containing all
                          recovered markers per sample needed by the 'align'
                          step is still produced as are the rest of output
                          files (default: 0)
  --keep_all              Do not delete any intermediate files (default:
                          False)
  --overwrite             Overwrite previous results (default: False)

Proteins extraction global options (Scipio):
  --max_loci_scipio_x2 MAX_LOCI_SCIPIO_X2
                          When the number of loci in a protein reference
                          target file exceeds this number, Captus will not run
                          a second, more exhaustive round of Scipio. Usually
                          the results from the first round are extremely
                          similar and sufficient, the second round can become
                          extremely slow as the number of reference target
                          proteins grows (default: 2000)
  --predict               Scipio flags introns as dubious when the splice
                          signals are not found at the exon edges, this may
                          indicate that there are additional aminoacids in the
                          recovered protein that are not present in the
                          reference target protein. Enable this flag to
                          attempt translation of these dubious introns, if the
                          translation does not introduce premature stop codons
                          they will be added to the recovered protein
                          (default: False)

Nuclear proteins extraction (Scipio):
  -n, --nuc_refs NUC_REFS
                          Set of nuclear protein reference target sequences,
                          options are:
                            Angiosperms353 = The original set of target
                                             proteins from Angiosperms353
                            Mega353 = The improved set of target proteins from
                                      Angiosperms353
                            Alternatively, provide a path to a FASTA file
                            containing your reference target protein sequences
                            in either nucleotide or aminoacid. When the FASTA
                            file is in nucleotides, '--nuc_transtable' will be
                            used to translate it to aminoacids
  --nuc_transtable NUC_TRANSTABLE
                          Genetic code table to translate your nuclear
                          proteins. Complete list of tables at: https://www.nc
                          bi.nlm.nih.gov/Taxonomy/Utils/wprintgc.cgi (default:
                          1: Standard)
  --nuc_min_score NUC_MIN_SCORE
                          Minimum Scipio score to retain hits to reference
                          target proteins. (default: 0.13)
  --nuc_min_identity NUC_MIN_IDENTITY
                          Minimum identity percentage to retain hits to
                          reference target proteins (default: 65)
  --nuc_min_coverage NUC_MIN_COVERAGE
                          Minimum coverage percentage of reference target
                          protein to consider a hit by a contig (default: 20)
  --nuc_depth_tolerance NUC_DEPTH_TOLERANCE
                          Minimum depth = 10^(log(depth of contig with best
                          hit in locus) * nuc_depth_tolerance), values must be
                          between 0 and 1 (1 is the most strict) (default:
                          0.5)

Plastidial proteins extraction (Scipio):
  -p, --ptd_refs PTD_REFS
                          Set of plastidial protein reference target
                          sequences, options are:
                            SeedPlantsPTD = A set of plastidial proteins for
                                            Seed Plants, curated by us
                            Alternatively, provide a path to a FASTA file
                            containing your reference target protein sequences
                            in either nucleotide or aminoacid. When the FASTA
                            file is in nucleotides, '--ptd_transtable' will be
                            used to translate it to aminoacids
  --ptd_transtable PTD_TRANSTABLE
                          Genetic code table to translate your plastidial
                          proteins. Complete list of tables at: https://www.nc
                          bi.nlm.nih.gov/Taxonomy/Utils/wprintgc.cgi (default:
                          11: Bacterial, Archaeal and Plant Plastid)
  --ptd_min_score PTD_MIN_SCORE
                          Minimum Scipio score to retain hits to reference
                          target proteins (default: 0.2)
  --ptd_min_identity PTD_MIN_IDENTITY
                          Minimum identity percentage to retain hits to
                          reference target proteins (default: 65)
  --ptd_min_coverage PTD_MIN_COVERAGE
                          Minimum coverage percentage of reference target
                          protein to consider a hit by a contig (default: 20)
  --ptd_depth_tolerance PTD_DEPTH_TOLERANCE
                          Minimum depth = 10^(log(depth of contig with best
                          hit in locus) * ptd_depth_tolerance), values must be
                          between 0 and 1 (1 is the most strict) (default:
                          0.5)

Mitochondrial proteins extraction (Scipio):
  -m, --mit_refs MIT_REFS
                          Set of mitochondrial protein reference target
                          sequences, options are:
                            SeedPlantsMIT = A set of mitochondrial proteins
                                            for Seed Plants, curated by us
                            Alternatively, provide a path to a FASTA file
                            containing your reference target protein sequences
                            in either nucleotide or aminoacid. When the FASTA
                            file is in nucleotides, '--mit_transtable' will be
                            used to translate it to aminoacids
  --mit_transtable MIT_TRANSTABLE
                          Genetic code table to translate your mitochondrial
                          proteins. Complete list of tables at: https://www.nc
                          bi.nlm.nih.gov/Taxonomy/Utils/wprintgc.cgi (default:
                          1: Standard)
  --mit_min_score MIT_MIN_SCORE
                          Minimum Scipio score to retain hits to reference
                          target proteins (default: 0.2)
  --mit_min_identity MIT_MIN_IDENTITY
                          Minimum identity percentage to retain hits to
                          reference target proteins (default: 65)
  --mit_min_coverage MIT_MIN_COVERAGE
                          Minimum coverage percentage of reference target
                          protein to consider a hit by a contig (default: 20)
  --mit_depth_tolerance MIT_DEPTH_TOLERANCE
                          Minimum depth = 10^(log(depth of contig with best
                          hit in locus) * mit_depth_tolerance), values must be
                          between 0 and 1 (1 is the most strict) (default:
                          0.5)

Miscellaneous DNA extraction (BLAT):
  -d, --dna_refs DNA_REFS
                          Path to a FASTA nucleotide file of miscellaneous DNA
                          reference targets
  --blat_min_score BLAT_MIN_SCORE
                          Minimum BLAT score for DNA matches, decrease if the
                          targets are very divergent (default: 20)
  --dna_min_identity DNA_MIN_IDENTITY
                          Minimum identity percentage to reference target
                          sequences to retain matches (default: 80)
  --dna_min_coverage DNA_MIN_COVERAGE
                          Minimum coverage percentage of reference target
                          sequence to retain matches (default: 20)
  --dna_depth_tolerance DNA_DEPTH_TOLERANCE
                          Minimum depth = 10^(log(depth of contig with best
                          hit in locus) * dna_depth_tolerance), values must be
                          between 0 and 1 (1 is the most strict) (default:
                          0.5)

Assemblies clustering (MMseqs2):
  -c, --cluster_leftovers
                          Enable MMseqs2 clustering across samples of the
                          contigs that had no hits to the reference target
                          markers. A new miscellaneous DNA reference is built
                          from the best representative of each cluster in
                          order to perform a miscellaneous DNA marker
                          extraction. (default: False)
  --mmseqs_method {easy-linclust,easy-cluster}
                          MMseqs2 clustering algorithm, options are:
                            easy-linclust = Fast linear time (for huge
                                            datasets), less sensitive
                                            clustering
                            easy-cluster = Sensitive homology search
                                           (recommended but slower) (default:
                                           easy-linclust)
  --cl_mode {0,1,2}       MMseqs2 clustering mode
                          (https://github.com/soedinglab/mmseqs2/wiki#clustering-modes),
                          options are:
                            0 = Greedy set cover
                            1 = Connected component
                            2 = Greedy incremental (analogous to CD-HIT)
                                (default: 2)
  --cl_sensitivity CL_SENSITIVITY
                          MMseqs2 sensitivity, from 1 to 7.5, only applicable
                          when using 'easy-cluster'. Common reference points
                          are: 1 (faster), 4 (fast), 7.5 (sens) (default: 7.5)
  --cl_min_identity CL_MIN_IDENTITY
                          Minimum identity percentage between sequences in a
                          cluster, when set to 'auto' it becomes 99% of the '
                          --dna_min_identity' value but never less than 75%
                          (default: auto)
  --cl_seq_id_mode CL_SEQ_ID_MODE
                          MMseqs2 sequence identity mode, options are:
                            0 = Alignment length
                            1 = Shorter sequence
                            2 = Longer sequence (default: 1)
  --cl_min_coverage CL_MIN_COVERAGE
                          Any sequence in a cluster has to be at least this
                          percent included in the length of the longest
                          sequence in the cluster (default: 80)
  --cl_cov_mode CL_COV_MODE
                          MMseqs2 sequence coverage mode
                          (https://github.com/soedinglab/mmseqs2/wiki#how-to-
                          set-the-right-alignment-coverage-to-cluster)
                          (default: 1)
  --cl_min_samples CL_MIN_SAMPLES
                          Minimum number of samples per cluster, if set to
                          'auto' the number is adjusted to 66% of the total
                          number of samples or at least 4 (default: auto)
  --cl_rep_single         Retain a single representative sequence per cluster,
                          useful for example when you intend to map the reads
                          to the set of targets found by clustering (default:
                          False)
  --cl_rep_min_len CL_REP_MIN_LEN
                          After clustering is finished, only accept cluster
                          representatives of at least this length to be part
                          of the new miscellaneous DNA reference targets. Use
                          0 to disable this filter (default: 500)
  --cl_max_seq_len CL_MAX_SEQ_LEN
                          Do not cluster sequences longer than this length in
                          bp, the maximum allowed by MMseqs2 is 65535. Use 0
                          to disable this filter (default: 5000)
  --cl_max_copies CL_MAX_COPIES
                          Maximum average number of sequences per sample in a
                          cluster. This can exclude loci that are extremely
                          paralogous (default: 3)
  --cl_tmp_dir CL_TMP_DIR
                          Where to create the temporary directory
                          'captus_mmseqs_tmp' for MMseqs2. Clustering can
                          become slow when done on external drives, set this
                          location to a fast, preferably local, drive
                          (default: $HOME)

Other:
  --scipio_path SCIPIO_PATH
                          Path to Scipio (default: bundled)
  --blat_path BLAT_PATH   Path to BLAT >= 36x7 (this version is the first one
                          that guarantees the same result both in Mac and
                          Linux) (default: bundled)
  --mmseqs_path MMSEQS_PATH
                          Path to MMseqs2 (default: mmseqs)
  --mafft_path MAFFT_PATH
                          Path to MAFFT (default: mafft/mafft.bat)
  --ram RAM               Maximum RAM in GB (e.g.: 4.5) dedicated to Captus,
                          'auto' uses 99% of available RAM (default: auto)
  --threads THREADS       Maximum number of CPUs dedicated to Captus, 'auto'
                          uses all available CPUs (default: auto)
  --concurrent CONCURRENT
                          Captus will attempt to execute this many extractions
                          concurrently. RAM and CPUs will be divided by this
                          value for each individual process. If set to 'auto',
                          Captus will set as many processes as to at least
                          have 2GB of RAM available for each process due to
                          the RAM requirements of BLAT (default: auto)
  --debug                 Enable debugging mode, parallelization is disabled
                          so errors are logged to screen (default: False)
  --show_less             Do not show individual sample information during the
                          run, the information is still written to the log
                          (default: False)

Help:
  -h, --help              Show this help message and exit
  --version               Show Captus' version number

For more information, please see https://github.com/edgardomortiz/Captus
```


## captus_align

### Tool Description
Captus-assembly: Align; collect, align, and curate aligned markers

### Metadata
- **Docker Image**: quay.io/biocontainers/captus:1.6.3--pyh05cac1d_0
- **Homepage**: https://github.com/edgardomortiz/Captus
- **Package**: https://anaconda.org/channels/bioconda/packages/captus/overview
- **Validation**: PASS

### Original Help Text
```text
usage: captus align -e CAPTUS_EXTRACTIONS_DIR [options]

[1mCaptus-assembly: Align; collect, align, and curate aligned markers [0m

Input:
  -e, --captus_extractions_dir CAPTUS_EXTRACTIONS_DIR
                          Path to the output directory that contains the
                          assemblies and extractions from previous steps of
                          Captus-assembly. This directory is called
                          '02_assemblies' if you did not specify a different
                          name during the 'assemble' or 'extract' steps
                          (default: ./03_extractions)
  -m, --markers MARKERS   Which markers to align, you can provide a
                          comma-separated list, no spaces (default: all)
                            NUC = Nuclear proteins inside directories
                                  '01_coding_NUC'
                            PTD = Plastidial proteins inside directories
                                  '02_coding_PTD'
                            MIT = Mitochondrial proteins inside directories
                                  '03_coding_MIT'
                            DNA = Miscellaneous DNA markers inside directories
                                  '04_misc_DNA'
                            CLR = Cluster-derived DNA markers inside
                                  directories '05_clusters'
                            ALL = Shortcut for NUC,PTD,MIT,DNA,CLR
  -f, --formats FORMATS   Which alignment format(s) to prepare for each marker
                          category, you can provide a comma-separated list, no
                          spaces (default: AA,NT,GE,MA)
                            Valid types for NUC, PTD, and MIT markers:
                            AA = Coding sequences in aminoacids
                            NT = Coding sequences in nucleotides
                            GE = Complete gene sequences (exons + introns)
                                 without flanking upstream or downstream
                                 basepairs
                            GF = Complete gene sequences with flanking
                                 upstream and downstream basepairs
                            Valid types for miscellaneous DNA and
                            CLusteR-derived markers:
                            MA = Matched sequences without flanking upstream
                                 or downstream basepairs
                            MF = Matched sequences with flanking upstream and
                                 downstream basepairs
                            ALL = Shortcut for AA,NT,GE,GF,MA,MF
  --max_paralogs MAX_PARALOGS
                          Maximum number of secondary hits (copies) per sample
                          to import from the extraction step. Large numbers of
                          marker copies per sample can increase alignment
                          times. Hits (copies) are ranked from best to worst
                          during the 'extract' step. -1 disables the removal
                          of paralogs and aligns them all, which might be
                          useful if you expect very high ploidy levels for
                          example (default: 5)
  -s, --min_samples MIN_SAMPLES
                          Minimum number of samples in a marker to proceed
                          with alignment. Markers with fewer samples will be
                          skipped (default: 4)

Output:
  -o, --out OUT           Output directory name (default: ./04_alignments)
  --collect_only          Only collect the markers from the extraction folder
                          and exit (skips addition of reference target
                          sequences and subsequent steps) (default: False)
  --keep_w_refs           Keep the directories containing the alignments that
                          include target reference sequences. The deletion of
                          these directories is performed after alignments are
                          filtered for paralogs and before trimming. Enable if
                          you plan to repeat the paralog filtering in the
                          future with '--redo_from filtering' (default: False)
  --keep_all              Do not delete any intermediate files (default:
                          False)
  --overwrite             Overwrite previous results (default: False)

Alignment:
  --align_method {mafft_auto,mafft_genafpair,mafft_localpair,mafft_globalpair,mafft_retree1,mafft_retree2,muscle_align,muscle_super5}
                          For MAFFT's algorithms see: https://mafft.cbrc.jp/al
                          ignment/software/algorithms/algorithms.html For
                          MUSCLE's algorithms see:
                          https://drive5.com/muscle5/manual/commands.html
                          (default: mafft_auto)
  --mafft_unalignlevel MAFFT_UNALIGNLEVEL
                          Use a value greater than 0 but lower than 1
                          (recommended 0.8)if the input data is expected to be
                          globally conserved but locally contaminated by
                          unrelated segments. When value is different than 0,
                          the method '--mafft_globalpair' will be used.
                          Consider also enabling '--mafft_leavegappyregion'
                          (default: 0.0)
  --mafft_leavegappyregion
                          Do not align gappy regions, will only be used if a
                          MAFFT algorithm is selected (default: False)
  --timeout TIMEOUT       Maximum allowed time in seconds for a single
                          alignment (default: 21600)
  --disable_codon_align   Do not align nucleotide coding sequences based on
                          their protein alignment (default: False)
  --outgroup OUTGROUP     Outgroup sample names, separated by commas, no
                          spaces. Since phylogenetic programs usually root the
                          resulting trees at the first taxon in the alignment,
                          Captus will place these samples at the beggining of
                          every alignment in the given order

Paralog filtering:
  --filter_method {naive,informed,both,none}
                          Methods for filtering paralogous sequences:
                            naive = Only the best hit for each sample (marked
                                    as hit=00) is retained
                            informed = Only keep the copy (regardless of hit
                                       ranking) that is most similar to the
                                       reference target sequence that was
                                       chosen most frequently among all other
                                       samples in the alignmentboth = Two
                                       separate folders will be created, each
                                       containing the results from each
                                       filtering methodnone = Skip paralog
                                       removal, just remove reference target
                                       sequences from the alignments. Useful
                                       for phylogenetic methods that allow
                                       paralogs like ASTRAL-Pro (default:
                                       both)
  --tolerance TOLERANCE   Only applicable to the 'informed' filter. If the
                          selected copy's identity to the most commonly chosen
                          reference target is below this number of Standard
                          Deviations from the mean, it will also be removed
                          (the lower the number the stricter the filter). The
                          previous default value of 4.0 works well for broad
                          taxonomic scopes, but tends to remove the outgroup
                          in family and genus-level studies. -1 disables this
                          filter

Trimming:
  -t, --taper_cutoff TAPER_CUTOFF
                          TAPER cutoff threshold, values greater than 1.0 are
                          recommended, the lower the value the more aggressive
                          the correction, 3.0 recommended by TAPER's authors
                          (default: 3.0)
  --taper_conservative    Enable the more conservative mode of TAPER. Captus
                          uses the aggressive mode by default, see
                          'correction_multi_aggressive.jl' at
                          https://github.com/chaoszhang/TAPER
  --taper_unfiltered      Enable TAPER correction even for alignments than
                          have not been paralog-filtered, TAPER is only able
                          to distinguish error when an unfiltered alignment
                          contains copies of the locus that are not extremely
                          divergent (default: False)
  --disable_taper         Disable the TAPER algorithm for masking for
                          erroneous regions in alignments, see
                          https://doi.org/10.1111/2041-210X.13696 (default:
                          False)
  --clipkit_method {smart-gap,gappy,kpic,kpic-smart-gap,kpic-gappy,kpi,kpi-smart-gap,kpi-gappy}
                          ClipKIT's algorithm, see https://jlsteenwyk.com/Clip
                          KIT/advanced/index.html#modes (default: gappy)
  -g, --clipkit_gaps CLIPKIT_GAPS
                          Gappyness threshold per position. Accepted values
                          between 0 and 1. This argument is ignored when using
                          the 'kpi' and 'kpic' algorithms or intermediate
                          steps that use 'smart-gap', the higher the value the
                          more columns are preserved (default: 0.9)
  -d, --min_data_per_column MIN_DATA_PER_COLUMN
                          Minimum number of non-missing sites per column. When
                          this parameter is > 0, Captus will dynamically
                          calculate a '--clipkit_gaps' threshold per alignment
                          to keep this minimum amount of data per column
                          (default: 0)
  --ends_only             Trim only the ends of the alignments (do not trim
                          internal gaps) (default: False)
  -c, --min_coverage MIN_COVERAGE
                          Minimum coverage of sequence as proportion of the
                          mean of sequence lengths in the alignment, ignoring
                          gaps. Accepted values between 0 and 1. After ClipKIT
                          finishes trimming columns, Captus will also remove
                          short sequences below this threshold (default: 0.4)

Other:
  --redo_from {alignment,filtering,removal,trimming}
                          Repeat analysis from a particular stage:
                            alignment = Delete all subdirectories with
                                        alignments and restart
                            filtering = Delete all subdirectories with
                                        filtered alignments and restart
                            removal = Delete all subdirectories with
                                      alignments with reference targets
                                      removed and restart
                            trimming = Delete all subdirectories with trimmed
                                       alignments and restart
  --mafft_path MAFFT_PATH
                          Path to MAFFT (default: mafft/mafft.bat)
  --muscle_path MUSCLE_PATH
                          Path to MUSCLE (default: muscle)
  --clipkit_path CLIPKIT_PATH
                          Path to ClipKIT (default: clipkit)
  --ram RAM               Maximum RAM in GB (e.g.: 4.5) dedicated to Captus,
                          'auto' uses 99% of available RAM (default: auto)
  --threads THREADS       Maximum number of CPUs dedicated to Captus, 'auto'
                          uses all available CPUs (default: auto)
  --concurrent CONCURRENT
                          Captus will attempt to execute this many alignments
                          concurrently. CPUs will be divided by this value for
                          each individual process. If set to 'auto', Captus
                          will set as many processes as to at least have 2
                          threads available for each MAFFT or MUSCLE process
                          (default: auto)
  --debug                 Enable debugging mode, parallelization is disabled
                          so errors are logged to screen (default: False)
  --show_more             Show individual alignment information during the
                          run. Detailed information is written regardless to
                          the log (default: False)

Help:
  -h, --help              Show this help message and exit
  --version               Show Captus' version number

For more information, please see https://github.com/edgardomortiz/Captus
```

