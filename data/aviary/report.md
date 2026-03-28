# aviary CWL Generation Report

## aviary_assemble

### Tool Description
Step-down hybrid assembly using long and short reads, or assembly using only short or long reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/aviary:0.12.0--pyhdfd78af_0
- **Homepage**: https://github.com/rhysnewell/aviary/
- **Package**: https://anaconda.org/channels/bioconda/packages/aviary/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/aviary/overview
- **Total Downloads**: 24.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/rhysnewell/aviary
- **Stars**: N/A
### Original Help Text
```text
usage: aviary assemble [-h] [-g [GOLD_STANDARD ...]]
                       [--gsa-mappings GSA_MAPPINGS]
                       [-r [REFERENCE_FILTER ...]]
                       [--min-read-size MIN_READ_SIZE]
                       [--min-mean-q MIN_MEAN_Q] [--keep-percent KEEP_PERCENT]
                       [--min-short-read-length MIN_SHORT_READ_LENGTH]
                       [--max-short-read-length MAX_SHORT_READ_LENGTH]
                       [--disable-adpater-trimming [DISABLE_ADAPTER_TRIMMING]]
                       [--unqualified-percent-limit UNQUALIFIED_PERCENT_LIMIT]
                       [--quality-cutoff QUALITY_CUTOFF]
                       [--extra-fastp-params EXTRA_FASTP_PARAMS]
                       [--skip-qc [SKIP_QC]] [--use-unicycler [USE_UNICYCLER]]
                       [--use-megahit [USE_MEGAHIT]] [--coassemble [yes|no]]
                       [--kmer-sizes KMER_SIZES [KMER_SIZES ...]]
                       [--min-cov-long MIN_COV_LONG]
                       [--min-cov-short MIN_COV_SHORT]
                       [--exclude-contig-cov EXCLUDE_CONTIG_COV]
                       [--exclude-contig-size EXCLUDE_CONTIG_SIZE]
                       [--include-contig-size INCLUDE_CONTIG_SIZE]
                       [-1 [PE1 ...]] [-2 [PE2 ...]] [-i [INTERLEAVED ...]]
                       [-c [COUPLED ...]]
                       [--min-percent-read-identity-short SHORT_PERCENT_IDENTITY]
                       [-l [LONGREADS ...]] [-z {ont,ont_hq,rs,sq,ccs,hifi}]
                       [--medaka-model {r103_fast_g507,r103_fast_snp_g507,r103_fast_variant_g507,r103_hac_g507,r103_hac_snp_g507,r103_hac_variant_g507,r103_min_high_g345,r103_min_high_g360,r103_prom_high_g360,r103_prom_snp_g3210,r103_prom_variant_g3210,r103_sup_g507,r103_sup_snp_g507,r103_sup_variant_g507,r1041_e82_260bps_fast_g632,r1041_e82_260bps_fast_variant_g632,r1041_e82_260bps_hac_g632,r1041_e82_260bps_hac_variant_g632,r1041_e82_260bps_sup_g632,r1041_e82_260bps_sup_variant_g632,r1041_e82_400bps_fast_g615,r1041_e82_400bps_fast_g632,r1041_e82_400bps_fast_variant_g615,r1041_e82_400bps_fast_variant_g632,r1041_e82_400bps_hac_g615,r1041_e82_400bps_hac_g632,r1041_e82_400bps_hac_variant_g615,r1041_e82_400bps_hac_variant_g632,r1041_e82_400bps_sup_g615,r1041_e82_400bps_sup_variant_g615,r104_e81_fast_g5015,r104_e81_fast_variant_g5015,r104_e81_hac_g5015,r104_e81_hac_variant_g5015,r104_e81_sup_g5015,r104_e81_sup_g610,r104_e81_sup_variant_g610,r10_min_high_g303,r10_min_high_g340,r941_e81_fast_g514,r941_e81_fast_variant_g514,r941_e81_hac_g514,r941_e81_hac_variant_g514,r941_e81_sup_g514,r941_e81_sup_variant_g514,r941_min_fast_g303,r941_min_fast_g507,r941_min_fast_snp_g507,r941_min_fast_variant_g507,r941_min_hac_g507,r941_min_hac_snp_g507,r941_min_hac_variant_g507,r941_min_high_g303,r941_min_high_g330,r941_min_high_g340_rle,r941_min_high_g344,r941_min_high_g351,r941_min_high_g360,r941_min_sup_g507,r941_min_sup_snp_g507,r941_min_sup_variant_g507,r941_prom_fast_g303,r941_prom_fast_g507,r941_prom_fast_snp_g507,r941_prom_fast_variant_g507,r941_prom_hac_g507,r941_prom_hac_snp_g507,r941_prom_hac_variant_g507,r941_prom_high_g303,r941_prom_high_g330,r941_prom_high_g344,r941_prom_high_g360,r941_prom_high_g4011,r941_prom_snp_g303,r941_prom_snp_g322,r941_prom_snp_g360,r941_prom_sup_g507,r941_prom_sup_snp_g507,r941_prom_sup_variant_g507,r941_prom_variant_g303,r941_prom_variant_g322,r941_prom_variant_g360,r941_sup_plant_g610,r941_sup_plant_variant_g610}]
                       [--min-percent-read-identity-long LONG_PERCENT_IDENTITY]
                       [-s MIN_CONTIG_SIZE] [-b MIN_BIN_SIZE]
                       [--semibin-model SEMIBIN_MODEL]
                       [--refinery-max-iterations REFINERY_MAX_ITERATIONS]
                       [--refinery-max-retries REFINERY_MAX_RETRIES]
                       [--extra-binners [{maxbin,maxbin2,concoct,comebin,taxvamb} ...]]
                       [--skip-binners [{rosella,semibin,metabat1,metabat2,metabat,vamb} ...]]
                       [--binning-only [BINNING_ONLY]]
                       [--skip-abundances [SKIP_ABUNDANCES]]
                       [--skip-taxonomy [SKIP_TAXONOMY]]
                       [--skip-singlem [SKIP_SINGLEM]] [-t MAX_THREADS]
                       [-p PPLACER_THREADS] [-n N_CORES] [-m MAX_MEMORY]
                       [--request-gpu [REQUEST_GPU]] [-o OUTPUT]
                       [--conda-prefix CONDA_PREFIX] [--tmpdir TMPDIR]
                       [--default-resources RESOURCES]
                       [--snakemake-profile SNAKEMAKE_PROFILE]
                       [--local-cores LOCAL_CORES]
                       [--cluster-retries CLUSTER_RETRIES]
                       [--dry-run [DRYRUN]] [--clean [CLEAN]]
                       [--build [yes|no]]
                       [--download [{gtdb,eggnog,singlem,checkm2,metabuli} ...]]
                       [--rerun-triggers [{mtime,params,input,software-env,code} ...]]
                       [--snakemake-cmds CMDS] [-w WORKFLOW [WORKFLOW ...]]

Step-down hybrid assembly using long and short reads, or assembly using only short or long reads.

options:
  -h, --help            show this help message and exit
  -g [GOLD_STANDARD ...], --gold-standard-assembly [GOLD_STANDARD ...], --gold_standard_assembly [GOLD_STANDARD ...]
                        Gold standard assembly to compare either the Aviary assembly or a given input assembly against (default: ['none'])
  --gsa-mappings GSA_MAPPINGS, --gsa_mappings GSA_MAPPINGS
                        CAMI I & II GSA mappings (default: none)
  -r [REFERENCE_FILTER ...], --reference-filter [REFERENCE_FILTER ...], --reference_filter [REFERENCE_FILTER ...]
                        One or more reference filter files to aid in the assembly. Remove contaminant reads from the assembly. (default: ['none'])
  --min-read-size MIN_READ_SIZE, --min_read_size MIN_READ_SIZE
                        Minimum long read size when filtering using Filtlong (default: 100)
  --min-mean-q MIN_MEAN_Q, --min_mean_q MIN_MEAN_Q
                        Minimum long read mean quality threshold (default: 10)
  --keep-percent KEEP_PERCENT, --keep_percent KEEP_PERCENT
                        DEPRECATED: Percentage of reads passing quality thresholds kept by filtlong (default: 100)
  --min-short-read-length MIN_SHORT_READ_LENGTH, --min_short_read_length MIN_SHORT_READ_LENGTH
                        Minimum length of short reads to be kept (default: 15)
  --max-short-read-length MAX_SHORT_READ_LENGTH, --max_short_read_length MAX_SHORT_READ_LENGTH
                        Maximum length of short reads to be kept, 0 = no maximum
  --disable-adpater-trimming [DISABLE_ADAPTER_TRIMMING], --disable_adpater_trimming [DISABLE_ADAPTER_TRIMMING]
                        Disable adapter trimming of short reads
  --unqualified-percent-limit UNQUALIFIED_PERCENT_LIMIT, --unqualified_percent_limit UNQUALIFIED_PERCENT_LIMIT
                        how many percents of bases are allowed to be unqualified. Default 40 means 40 percent (default: 40)
  --quality-cutoff QUALITY_CUTOFF, --quality_cutoff QUALITY_CUTOFF
                        The short read quality value that a base is qualified. Default 15 means phred quality >=Q15 is qualified. (default: 15)
  --extra-fastp-params EXTRA_FASTP_PARAMS, --extra_fastp_params EXTRA_FASTP_PARAMS
                        Extra parameters to pass to fastp, supply as a single string e.g. --extra-fastp-params "-V -e 10"
  --skip-qc [SKIP_QC], --skip_qc [SKIP_QC]
                        Skip quality control steps
  --use-unicycler [USE_UNICYCLER], --use_unicycler [USE_UNICYCLER]
                        Use Unicycler to re-assemble the metaSPAdes hybrid assembly. Not recommended for complex metagenomes.
  --use-megahit [USE_MEGAHIT], --use_megahit [USE_MEGAHIT]
                        Specifies whether or not to use megahit if multiple for short-read only assembly
  --coassemble [yes|no], --co-assemble [yes|no], --co_assemble [yes|no]
                        Specifies whether or not, when given multiple input reads, to coassemble them. 
                        If False (no), Aviary will use the first set of short reads and first set of long reads to perform assembly 
                        All read files will still be used during the MAG recovery process for differential coverage.
  --kmer-sizes KMER_SIZES [KMER_SIZES ...], --kmer_sizes KMER_SIZES [KMER_SIZES ...], -k KMER_SIZES [KMER_SIZES ...]
                        Manually specify the kmer-sizes used by SPAdes during assembly. Space separated odd integer values and less than 128 or "auto" (default: ['auto'])
  --min-cov-long MIN_COV_LONG, --min_cov_long MIN_COV_LONG
                        Automatically include Flye contigs with long read coverage greater than or equal to this.  (default: 5)
                        High long read coverage during assembly indicates that the overlap layout consensus algorithm 
                        is more likely to be correct.
  --min-cov-short MIN_COV_SHORT, --min_cov_short MIN_COV_SHORT
                        Automatically include Flye contigs with short read coverage less than or equal to this.  (default: 5)
                        Low coverage via short reads indicates that metaSPAdes will not be able to better assemble this contig.
  --exclude-contig-cov EXCLUDE_CONTIG_COV, --exclude_contig_cov EXCLUDE_CONTIG_COV
                        Automatically exclude Flye contigs with long read coverage less than or equal to this  (default: 10)
                        and less than or equal to `--exclude-contig-size`
  --exclude-contig-size EXCLUDE_CONTIG_SIZE, --exclude_contig_size EXCLUDE_CONTIG_SIZE
                        Automatically exclude Flye contigs with length less than or equal to this  (default: 2500)
                        and long read coverage less than or equal to `--exclude-contig-cov`
  --include-contig-size INCLUDE_CONTIG_SIZE, --include_contig_size INCLUDE_CONTIG_SIZE
                        Automatically include Flye contigs with length greater than or equal to this (default: 10000)
  -1 [PE1 ...], --pe-1 [PE1 ...], --paired-reads-1 [PE1 ...], --paired_reads_1 [PE1 ...], --pe1 [PE1 ...]
                        A space separated list of forwards read files  (default: none)
                        NOTE: If performing assembly and multiple files are provided then only the first file will be used for assembly. 
                              If no longreads are provided then all samples will be co-assembled 
                              with megahit or metaspades depending on the --coassemble parameter
  -2 [PE2 ...], --pe-2 [PE2 ...], --paired-reads-2 [PE2 ...], --paired_reads_2 [PE2 ...], --pe2 [PE2 ...]
                        A space separated list of reverse read files  (default: none)
                        NOTE: If performing assembly and multiple files are provided then only the first file will be used for assembly. 
                              If no longreads are provided then all samples will be co-assembled 
                              with megahit or metaspades depending on the --coassemble parameter
  -i [INTERLEAVED ...], --interleaved [INTERLEAVED ...]
                        A space separated list of interleaved read files  (default: none)
                        NOTE: If performing assembly and multiple files are provided then only the first file will be used for assembly. 
                              If no longreads are provided then all samples will be co-assembled 
                              with megahit or metaspades depending on the --coassemble parameter
  -c [COUPLED ...], --coupled [COUPLED ...]
                        Forward and reverse read files in a coupled space separated list.  (default: none)
                        NOTE: If performing assembly and multiple files are provided then only the first file will be used for assembly. 
                              If no longreads are provided then all samples will be co-assembled 
                              with megahit or metaspades depending on the --coassemble parameter
  --min-percent-read-identity-short SHORT_PERCENT_IDENTITY, --min_percent_read_identity_short SHORT_PERCENT_IDENTITY
                        Minimum percent read identity used by CoverM for short-reads  (default: 95)
                        when calculating genome abundances.
  -l [LONGREADS ...], --longreads [LONGREADS ...], --long-reads [LONGREADS ...], --long_reads [LONGREADS ...]
                        A space separated list of long-read read files. NOTE: The first file will be used for assembly unless --coassemble is set to True. Then all files will be used. (default: none)
  -z {ont,ont_hq,rs,sq,ccs,hifi}, --longread-type {ont,ont_hq,rs,sq,ccs,hifi}, --longread_type {ont,ont_hq,rs,sq,ccs,hifi}, --long_read_type {ont,ont_hq,rs,sq,ccs,hifi}, --long-read-type {ont,ont_hq,rs,sq,ccs,hifi}
                        Whether the sequencing platform and technology for the longreads.  (default: ont)
                        "rs" for PacBio RSII, "sq" for PacBio Sequel, "ccs" for PacBio CCS, "hifi" for PacBio HiFi 
                        reads, "ont" for Oxford Nanopore and "ont_hq" for Oxford Nanopore high quality reads (Guppy5+ or Q20) 
  --medaka-model {r103_fast_g507,r103_fast_snp_g507,r103_fast_variant_g507,r103_hac_g507,r103_hac_snp_g507,r103_hac_variant_g507,r103_min_high_g345,r103_min_high_g360,r103_prom_high_g360,r103_prom_snp_g3210,r103_prom_variant_g3210,r103_sup_g507,r103_sup_snp_g507,r103_sup_variant_g507,r1041_e82_260bps_fast_g632,r1041_e82_260bps_fast_variant_g632,r1041_e82_260bps_hac_g632,r1041_e82_260bps_hac_variant_g632,r1041_e82_260bps_sup_g632,r1041_e82_260bps_sup_variant_g632,r1041_e82_400bps_fast_g615,r1041_e82_400bps_fast_g632,r1041_e82_400bps_fast_variant_g615,r1041_e82_400bps_fast_variant_g632,r1041_e82_400bps_hac_g615,r1041_e82_400bps_hac_g632,r1041_e82_400bps_hac_variant_g615,r1041_e82_400bps_hac_variant_g632,r1041_e82_400bps_sup_g615,r1041_e82_400bps_sup_variant_g615,r104_e81_fast_g5015,r104_e81_fast_variant_g5015,r104_e81_hac_g5015,r104_e81_hac_variant_g5015,r104_e81_sup_g5015,r104_e81_sup_g610,r104_e81_sup_variant_g610,r10_min_high_g303,r10_min_high_g340,r941_e81_fast_g514,r941_e81_fast_variant_g514,r941_e81_hac_g514,r941_e81_hac_variant_g514,r941_e81_sup_g514,r941_e81_sup_variant_g514,r941_min_fast_g303,r941_min_fast_g507,r941_min_fast_snp_g507,r941_min_fast_variant_g507,r941_min_hac_g507,r941_min_hac_snp_g507,r941_min_hac_variant_g507,r941_min_high_g303,r941_min_high_g330,r941_min_high_g340_rle,r941_min_high_g344,r941_min_high_g351,r941_min_high_g360,r941_min_sup_g507,r941_min_sup_snp_g507,r941_min_sup_variant_g507,r941_prom_fast_g303,r941_prom_fast_g507,r941_prom_fast_snp_g507,r941_prom_fast_variant_g507,r941_prom_hac_g507,r941_prom_hac_snp_g507,r941_prom_hac_variant_g507,r941_prom_high_g303,r941_prom_high_g330,r941_prom_high_g344,r941_prom_high_g360,r941_prom_high_g4011,r941_prom_snp_g303,r941_prom_snp_g322,r941_prom_snp_g360,r941_prom_sup_g507,r941_prom_sup_snp_g507,r941_prom_sup_variant_g507,r941_prom_variant_g303,r941_prom_variant_g322,r941_prom_variant_g360,r941_sup_plant_g610,r941_sup_plant_variant_g610}, --medaka_model {r103_fast_g507,r103_fast_snp_g507,r103_fast_variant_g507,r103_hac_g507,r103_hac_snp_g507,r103_hac_variant_g507,r103_min_high_g345,r103_min_high_g360,r103_prom_high_g360,r103_prom_snp_g3210,r103_prom_variant_g3210,r103_sup_g507,r103_sup_snp_g507,r103_sup_variant_g507,r1041_e82_260bps_fast_g632,r1041_e82_260bps_fast_variant_g632,r1041_e82_260bps_hac_g632,r1041_e82_260bps_hac_variant_g632,r1041_e82_260bps_sup_g632,r1041_e82_260bps_sup_variant_g632,r1041_e82_400bps_fast_g615,r1041_e82_400bps_fast_g632,r1041_e82_400bps_fast_variant_g615,r1041_e82_400bps_fast_variant_g632,r1041_e82_400bps_hac_g615,r1041_e82_400bps_hac_g632,r1041_e82_400bps_hac_variant_g615,r1041_e82_400bps_hac_variant_g632,r1041_e82_400bps_sup_g615,r1041_e82_400bps_sup_variant_g615,r104_e81_fast_g5015,r104_e81_fast_variant_g5015,r104_e81_hac_g5015,r104_e81_hac_variant_g5015,r104_e81_sup_g5015,r104_e81_sup_g610,r104_e81_sup_variant_g610,r10_min_high_g303,r10_min_high_g340,r941_e81_fast_g514,r941_e81_fast_variant_g514,r941_e81_hac_g514,r941_e81_hac_variant_g514,r941_e81_sup_g514,r941_e81_sup_variant_g514,r941_min_fast_g303,r941_min_fast_g507,r941_min_fast_snp_g507,r941_min_fast_variant_g507,r941_min_hac_g507,r941_min_hac_snp_g507,r941_min_hac_variant_g507,r941_min_high_g303,r941_min_high_g330,r941_min_high_g340_rle,r941_min_high_g344,r941_min_high_g351,r941_min_high_g360,r941_min_sup_g507,r941_min_sup_snp_g507,r941_min_sup_variant_g507,r941_prom_fast_g303,r941_prom_fast_g507,r941_prom_fast_snp_g507,r941_prom_fast_variant_g507,r941_prom_hac_g507,r941_prom_hac_snp_g507,r941_prom_hac_variant_g507,r941_prom_high_g303,r941_prom_high_g330,r941_prom_high_g344,r941_prom_high_g360,r941_prom_high_g4011,r941_prom_snp_g303,r941_prom_snp_g322,r941_prom_snp_g360,r941_prom_sup_g507,r941_prom_sup_snp_g507,r941_prom_sup_variant_g507,r941_prom_variant_g303,r941_prom_variant_g322,r941_prom_variant_g360,r941_sup_plant_g610,r941_sup_plant_variant_g610}
                        Medaka model to use for polishing long reads.  (default: r941_min_hac_g507)
  --min-percent-read-identity-long LONG_PERCENT_IDENTITY, --min_percent_read_identity_long LONG_PERCENT_IDENTITY
                        Minimum percent read identity used by CoverM for long-readswhen calculating genome abundances. (default: 85)
  -s MIN_CONTIG_SIZE, --min-contig-size MIN_CONTIG_SIZE, --min_contig_size MIN_CONTIG_SIZE
                        Minimum contig size in base pairs to be considered for binning (default: 1500)
  -b MIN_BIN_SIZE, --min-bin-size MIN_BIN_SIZE, --min_bin_size MIN_BIN_SIZE
                        Minimum bin size in base pairs for a MAG (default: 200000)
  --semibin-model SEMIBIN_MODEL, --semibin_model SEMIBIN_MODEL
                        The environment model to passed to SemiBin. Can be one of:  (default: global)
                        human_gut, dog_gut, ocean, soil, cat_gut, human_oral, mouse_gut, pig_gut, built_environment, wastewater, global
  --refinery-max-iterations REFINERY_MAX_ITERATIONS, --refinery_max_iterations REFINERY_MAX_ITERATIONS
                        Maximum number of iterations for Rosella refinery. Set to 0 to skip refinery. Lower values will run faster but may result in lower quality MAGs. (default: 5)
  --refinery-max-retries REFINERY_MAX_RETRIES, --refinery_max_retries REFINERY_MAX_RETRIES
                        Maximum number of retries rosella uses to generate valid reclustering within a refinery iteration. Lower values will run faster but may result in lower quality MAGs. (default: 3)
  --extra-binners [{maxbin,maxbin2,concoct,comebin,taxvamb} ...], --extra_binners [{maxbin,maxbin2,concoct,comebin,taxvamb} ...], --extra-binner [{maxbin,maxbin2,concoct,comebin,taxvamb} ...], --extra_binner [{maxbin,maxbin2,concoct,comebin,taxvamb} ...]
                        Optional list of extra binning algorithms to run. Can be any combination of: 
                        maxbin, maxbin2, concoct, comebin, taxvamb 
                        These binners are skipped by default as they can have long runtimes 
                        N.B. specifying "maxbin" and "maxbin2" are equivalent 
                        N.B. specifying "taxvamb" will also run metabuli for contig taxonomic assignment 
  --skip-binners [{rosella,semibin,metabat1,metabat2,metabat,vamb} ...], --skip_binners [{rosella,semibin,metabat1,metabat2,metabat,vamb} ...], --skip_binner [{rosella,semibin,metabat1,metabat2,metabat,vamb} ...], --skip-binner [{rosella,semibin,metabat1,metabat2,metabat,vamb} ...]
                        Optional list of binning algorithms to skip. Can be any combination of: 
                        rosella, semibin, metabat1, metabat2, metabat, vamb 
                        N.B. specifying "metabat" will skip both MetaBAT1 and MetaBAT2. 
  --binning-only [BINNING_ONLY], --binning_only [BINNING_ONLY]
                        Only run up to the binning stage. Do not run SingleM, GTDB-tk, or CoverM
  --skip-abundances [SKIP_ABUNDANCES], --skip_abundances [SKIP_ABUNDANCES]
                        Skip CoverM post-binning abundance calculations.
  --skip-taxonomy [SKIP_TAXONOMY], --skip_taxonomy [SKIP_TAXONOMY]
                        Skip GTDB-tk post-binning taxonomy assignment.
  --skip-singlem [SKIP_SINGLEM], --skip_singlem [SKIP_SINGLEM]
                        Skip SingleM post-binning recovery assessment.
  -t MAX_THREADS, --max-threads MAX_THREADS, --max_threads MAX_THREADS
                        Maximum number of threads given to any particular process. If max_threads > n_cores then n_cores will be bumped up to max_threads. Useful if you want more fine grain control over the number of threads used by each process. (default: 8)
  -p PPLACER_THREADS, --pplacer-threads PPLACER_THREADS, --pplacer_threads PPLACER_THREADS
                        The number of threads given to pplacer, values above `--max-threads` will be scaled to equal `--max-threads` (default: 8)
  -n N_CORES, --n-cores N_CORES, --n_cores N_CORES
                        Maximum number of cores available for use. Setting to multiples of max_threads will allow for multiple processes to be run in parallel. (default: 16)
  -m MAX_MEMORY, --max-memory MAX_MEMORY, --max_memory MAX_MEMORY
                        Maximum memory for available usage in Gigabytes (default: 250)
  --request-gpu [REQUEST_GPU], --request_gpu [REQUEST_GPU]
                        Request a GPU for use with the pipeline. This will only work if the pipeline is run on a cluster
  -o OUTPUT, --output OUTPUT
                        Output directory (default: ./)
  --conda-prefix CONDA_PREFIX, --conda_prefix CONDA_PREFIX
                        Path to the location of installed conda environments, or where to install new environments. 
                        Can be configured within the `configure` subcommand
  --tmpdir TMPDIR, --tempdir TMPDIR, --tmp-dir TMPDIR, --tmp_dir TMPDIR, --tmp TMPDIR, --temp TMPDIR, --temp-dir TMPDIR, --temp_dir TMPDIR
                        Path to the location that will be treated used for temporary files. If none is specified, the TMPDIR 
                        environment variable will be used. Can be configured within the `configure` subcommand
  --default-resources RESOURCES
                        Snakemake resources used as is found at: https://snakemake.readthedocs.io/en/stable/snakefiles/rules.html?highlight=resources#standard-resources  (default:  )
                        NOTE: tmpdir is handled by the `tmpdir` command line parameter. 
  --snakemake-profile SNAKEMAKE_PROFILE
                        Snakemake profile (see https://snakemake.readthedocs.io/en/stable/executing/cli.html#profiles)
                        Create profile as `~/.config/snakemake/[CLUSTER_PROFILE]/config.yaml`. 
                        Can be used to submit rules as jobs to cluster engine (see https://snakemake.readthedocs.io/en/stable/executing/cluster.html), 
                        requires cluster, cluster-status, jobs, cluster-cancel. 
  --local-cores LOCAL_CORES, --local_cores LOCAL_CORES
                        Maximum number of cores available for use locally. Only relevant if jobs are being submitted to a cluster (e.g. see `--snakemake-profile`), in which case `--n-cores` will restrict requested cores in submitted jobs. (default: 16)
  --cluster-retries CLUSTER_RETRIES
                        Number of times to retry a failed job when using cluster submission (see `--snakemake-profile`). 
  --dry-run [DRYRUN], --dry_run [DRYRUN], --dryrun [DRYRUN]
                        Perform snakemake dry run, tests workflow order and conda environments
  --clean [CLEAN]       Clean up all temporary files. This will remove most BAM files and any FASTQ files  (default: True)
                        generated from read filtering. Setting this to False is the equivalent of the --notemp 
                        option in snakemake. Useful for when running only part of a workflow as it avoids 
                        deleting files that would likely be needed in later parts of the workflow. 
                        NOTE: Not cleaning makes reruns faster but will incur the wrath of your sysadmin
  --build [yes|no]      Build conda environments necessary to run the pipeline, and then exit. Equivalent to "--snakemake-cmds '--conda-create-envs-only True ' ". Other inputs should be specified as if running normally so that the right set of conda environments is built. (default: no)
  --download [{gtdb,eggnog,singlem,checkm2,metabuli} ...], --download [{gtdb,eggnog,singlem,checkm2,metabuli} ...]
                        Downloads the requested GTDB, EggNOG, SingleM, CheckM2, & Metabuli databases
  --rerun-triggers [{mtime,params,input,software-env,code} ...], --rerun_triggers [{mtime,params,input,software-env,code} ...]
                        Specify which kinds of modifications will trigger rules to rerun (default: ['mtime'])
  --snakemake-cmds CMDS
                        Additional commands to supplied to snakemake in the form of a single string e.g. "--print-compilation True". 
                         NOTE: Most commands in snakemake -h are valid but some commands may clash with commands 
                         aviary directly supplies to snakemake. Please make sure your additional commands don't clash.
  -w WORKFLOW [WORKFLOW ...], --workflow WORKFLOW [WORKFLOW ...]
                        Main workflow to run. This is the snakemake target rule to run. (default: ['complete_assembly_with_qc'])

                                        ......:::::: ASSEMBLE ::::::......

        aviary assemble -1 *.1.fq.gz -2 *.2.fq.gz --longreads *.nanopore.fastq.gz --long_read_type ont
```


## aviary_recover

### Tool Description
The aviary binning pipeline

### Metadata
- **Docker Image**: quay.io/biocontainers/aviary:0.12.0--pyhdfd78af_0
- **Homepage**: https://github.com/rhysnewell/aviary/
- **Package**: https://anaconda.org/channels/bioconda/packages/aviary/overview
- **Validation**: PASS

### Original Help Text
```text
usage: aviary recover [-h] [-g [GOLD_STANDARD ...]]
                      [--gsa-mappings GSA_MAPPINGS]
                      [-r [REFERENCE_FILTER ...]]
                      [--min-read-size MIN_READ_SIZE]
                      [--min-mean-q MIN_MEAN_Q] [--keep-percent KEEP_PERCENT]
                      [--min-short-read-length MIN_SHORT_READ_LENGTH]
                      [--max-short-read-length MAX_SHORT_READ_LENGTH]
                      [--disable-adpater-trimming [DISABLE_ADAPTER_TRIMMING]]
                      [--unqualified-percent-limit UNQUALIFIED_PERCENT_LIMIT]
                      [--quality-cutoff QUALITY_CUTOFF]
                      [--extra-fastp-params EXTRA_FASTP_PARAMS]
                      [--skip-qc [SKIP_QC]] [--use-unicycler [USE_UNICYCLER]]
                      [--use-megahit [USE_MEGAHIT]] [--coassemble [yes|no]]
                      [--kmer-sizes KMER_SIZES [KMER_SIZES ...]]
                      [--min-cov-long MIN_COV_LONG]
                      [--min-cov-short MIN_COV_SHORT]
                      [--exclude-contig-cov EXCLUDE_CONTIG_COV]
                      [--exclude-contig-size EXCLUDE_CONTIG_SIZE]
                      [--include-contig-size INCLUDE_CONTIG_SIZE]
                      [-1 [PE1 ...]] [-2 [PE2 ...]] [-i [INTERLEAVED ...]]
                      [-c [COUPLED ...]]
                      [--min-percent-read-identity-short SHORT_PERCENT_IDENTITY]
                      [-l [LONGREADS ...]] [-z {ont,ont_hq,rs,sq,ccs,hifi}]
                      [--medaka-model {r103_fast_g507,r103_fast_snp_g507,r103_fast_variant_g507,r103_hac_g507,r103_hac_snp_g507,r103_hac_variant_g507,r103_min_high_g345,r103_min_high_g360,r103_prom_high_g360,r103_prom_snp_g3210,r103_prom_variant_g3210,r103_sup_g507,r103_sup_snp_g507,r103_sup_variant_g507,r1041_e82_260bps_fast_g632,r1041_e82_260bps_fast_variant_g632,r1041_e82_260bps_hac_g632,r1041_e82_260bps_hac_variant_g632,r1041_e82_260bps_sup_g632,r1041_e82_260bps_sup_variant_g632,r1041_e82_400bps_fast_g615,r1041_e82_400bps_fast_g632,r1041_e82_400bps_fast_variant_g615,r1041_e82_400bps_fast_variant_g632,r1041_e82_400bps_hac_g615,r1041_e82_400bps_hac_g632,r1041_e82_400bps_hac_variant_g615,r1041_e82_400bps_hac_variant_g632,r1041_e82_400bps_sup_g615,r1041_e82_400bps_sup_variant_g615,r104_e81_fast_g5015,r104_e81_fast_variant_g5015,r104_e81_hac_g5015,r104_e81_hac_variant_g5015,r104_e81_sup_g5015,r104_e81_sup_g610,r104_e81_sup_variant_g610,r10_min_high_g303,r10_min_high_g340,r941_e81_fast_g514,r941_e81_fast_variant_g514,r941_e81_hac_g514,r941_e81_hac_variant_g514,r941_e81_sup_g514,r941_e81_sup_variant_g514,r941_min_fast_g303,r941_min_fast_g507,r941_min_fast_snp_g507,r941_min_fast_variant_g507,r941_min_hac_g507,r941_min_hac_snp_g507,r941_min_hac_variant_g507,r941_min_high_g303,r941_min_high_g330,r941_min_high_g340_rle,r941_min_high_g344,r941_min_high_g351,r941_min_high_g360,r941_min_sup_g507,r941_min_sup_snp_g507,r941_min_sup_variant_g507,r941_prom_fast_g303,r941_prom_fast_g507,r941_prom_fast_snp_g507,r941_prom_fast_variant_g507,r941_prom_hac_g507,r941_prom_hac_snp_g507,r941_prom_hac_variant_g507,r941_prom_high_g303,r941_prom_high_g330,r941_prom_high_g344,r941_prom_high_g360,r941_prom_high_g4011,r941_prom_snp_g303,r941_prom_snp_g322,r941_prom_snp_g360,r941_prom_sup_g507,r941_prom_sup_snp_g507,r941_prom_sup_variant_g507,r941_prom_variant_g303,r941_prom_variant_g322,r941_prom_variant_g360,r941_sup_plant_g610,r941_sup_plant_variant_g610}]
                      [--min-percent-read-identity-long LONG_PERCENT_IDENTITY]
                      [-s MIN_CONTIG_SIZE] [-b MIN_BIN_SIZE]
                      [--semibin-model SEMIBIN_MODEL]
                      [--refinery-max-iterations REFINERY_MAX_ITERATIONS]
                      [--refinery-max-retries REFINERY_MAX_RETRIES]
                      [--extra-binners [{maxbin,maxbin2,concoct,comebin,taxvamb} ...]]
                      [--skip-binners [{rosella,semibin,metabat1,metabat2,metabat,vamb} ...]]
                      [--binning-only [BINNING_ONLY]]
                      [--skip-abundances [SKIP_ABUNDANCES]]
                      [--skip-taxonomy [SKIP_TAXONOMY]]
                      [--skip-singlem [SKIP_SINGLEM]] [--gtdb-path GTDB_PATH]
                      [--eggnog-db-path EGGNOG_DB_PATH]
                      [--singlem-metapackage-path SINGLEM_METAPACKAGE_PATH]
                      [--checkm2-db-path CHECKM2_DB_PATH] [-t MAX_THREADS]
                      [-p PPLACER_THREADS] [-n N_CORES] [-m MAX_MEMORY]
                      [--request-gpu [REQUEST_GPU]] [-o OUTPUT]
                      [--conda-prefix CONDA_PREFIX] [--tmpdir TMPDIR]
                      [--default-resources RESOURCES]
                      [--snakemake-profile SNAKEMAKE_PROFILE]
                      [--local-cores LOCAL_CORES]
                      [--cluster-retries CLUSTER_RETRIES] [--dry-run [DRYRUN]]
                      [--clean [CLEAN]] [--build [yes|no]]
                      [--download [{gtdb,eggnog,singlem,checkm2,metabuli} ...]]
                      [--rerun-triggers [{mtime,params,input,software-env,code} ...]]
                      [--snakemake-cmds CMDS] [-a ASSEMBLY]
                      [-w WORKFLOW [WORKFLOW ...]]
                      [--perform-strain-analysis [STRAIN_ANALYSIS]]

The aviary binning pipeline

options:
  -h, --help            show this help message and exit
  -g [GOLD_STANDARD ...], --gold-standard-assembly [GOLD_STANDARD ...], --gold_standard_assembly [GOLD_STANDARD ...]
                        Gold standard assembly to compare either the Aviary assembly or a given input assembly against (default: ['none'])
  --gsa-mappings GSA_MAPPINGS, --gsa_mappings GSA_MAPPINGS
                        CAMI I & II GSA mappings (default: none)
  -r [REFERENCE_FILTER ...], --reference-filter [REFERENCE_FILTER ...], --reference_filter [REFERENCE_FILTER ...]
                        One or more reference filter files to aid in the assembly. Remove contaminant reads from the assembly. (default: ['none'])
  --min-read-size MIN_READ_SIZE, --min_read_size MIN_READ_SIZE
                        Minimum long read size when filtering using Filtlong (default: 100)
  --min-mean-q MIN_MEAN_Q, --min_mean_q MIN_MEAN_Q
                        Minimum long read mean quality threshold (default: 10)
  --keep-percent KEEP_PERCENT, --keep_percent KEEP_PERCENT
                        DEPRECATED: Percentage of reads passing quality thresholds kept by filtlong (default: 100)
  --min-short-read-length MIN_SHORT_READ_LENGTH, --min_short_read_length MIN_SHORT_READ_LENGTH
                        Minimum length of short reads to be kept (default: 15)
  --max-short-read-length MAX_SHORT_READ_LENGTH, --max_short_read_length MAX_SHORT_READ_LENGTH
                        Maximum length of short reads to be kept, 0 = no maximum
  --disable-adpater-trimming [DISABLE_ADAPTER_TRIMMING], --disable_adpater_trimming [DISABLE_ADAPTER_TRIMMING]
                        Disable adapter trimming of short reads
  --unqualified-percent-limit UNQUALIFIED_PERCENT_LIMIT, --unqualified_percent_limit UNQUALIFIED_PERCENT_LIMIT
                        how many percents of bases are allowed to be unqualified. Default 40 means 40 percent (default: 40)
  --quality-cutoff QUALITY_CUTOFF, --quality_cutoff QUALITY_CUTOFF
                        The short read quality value that a base is qualified. Default 15 means phred quality >=Q15 is qualified. (default: 15)
  --extra-fastp-params EXTRA_FASTP_PARAMS, --extra_fastp_params EXTRA_FASTP_PARAMS
                        Extra parameters to pass to fastp, supply as a single string e.g. --extra-fastp-params "-V -e 10"
  --skip-qc [SKIP_QC], --skip_qc [SKIP_QC]
                        Skip quality control steps
  --use-unicycler [USE_UNICYCLER], --use_unicycler [USE_UNICYCLER]
                        Use Unicycler to re-assemble the metaSPAdes hybrid assembly. Not recommended for complex metagenomes.
  --use-megahit [USE_MEGAHIT], --use_megahit [USE_MEGAHIT]
                        Specifies whether or not to use megahit if multiple for short-read only assembly
  --coassemble [yes|no], --co-assemble [yes|no], --co_assemble [yes|no]
                        Specifies whether or not, when given multiple input reads, to coassemble them. 
                        If False (no), Aviary will use the first set of short reads and first set of long reads to perform assembly 
                        All read files will still be used during the MAG recovery process for differential coverage.
  --kmer-sizes KMER_SIZES [KMER_SIZES ...], --kmer_sizes KMER_SIZES [KMER_SIZES ...], -k KMER_SIZES [KMER_SIZES ...]
                        Manually specify the kmer-sizes used by SPAdes during assembly. Space separated odd integer values and less than 128 or "auto" (default: ['auto'])
  --min-cov-long MIN_COV_LONG, --min_cov_long MIN_COV_LONG
                        Automatically include Flye contigs with long read coverage greater than or equal to this.  (default: 5)
                        High long read coverage during assembly indicates that the overlap layout consensus algorithm 
                        is more likely to be correct.
  --min-cov-short MIN_COV_SHORT, --min_cov_short MIN_COV_SHORT
                        Automatically include Flye contigs with short read coverage less than or equal to this.  (default: 5)
                        Low coverage via short reads indicates that metaSPAdes will not be able to better assemble this contig.
  --exclude-contig-cov EXCLUDE_CONTIG_COV, --exclude_contig_cov EXCLUDE_CONTIG_COV
                        Automatically exclude Flye contigs with long read coverage less than or equal to this  (default: 10)
                        and less than or equal to `--exclude-contig-size`
  --exclude-contig-size EXCLUDE_CONTIG_SIZE, --exclude_contig_size EXCLUDE_CONTIG_SIZE
                        Automatically exclude Flye contigs with length less than or equal to this  (default: 2500)
                        and long read coverage less than or equal to `--exclude-contig-cov`
  --include-contig-size INCLUDE_CONTIG_SIZE, --include_contig_size INCLUDE_CONTIG_SIZE
                        Automatically include Flye contigs with length greater than or equal to this (default: 10000)
  -1 [PE1 ...], --pe-1 [PE1 ...], --paired-reads-1 [PE1 ...], --paired_reads_1 [PE1 ...], --pe1 [PE1 ...]
                        A space separated list of forwards read files  (default: none)
                        NOTE: If performing assembly and multiple files are provided then only the first file will be used for assembly. 
                              If no longreads are provided then all samples will be co-assembled 
                              with megahit or metaspades depending on the --coassemble parameter
  -2 [PE2 ...], --pe-2 [PE2 ...], --paired-reads-2 [PE2 ...], --paired_reads_2 [PE2 ...], --pe2 [PE2 ...]
                        A space separated list of reverse read files  (default: none)
                        NOTE: If performing assembly and multiple files are provided then only the first file will be used for assembly. 
                              If no longreads are provided then all samples will be co-assembled 
                              with megahit or metaspades depending on the --coassemble parameter
  -i [INTERLEAVED ...], --interleaved [INTERLEAVED ...]
                        A space separated list of interleaved read files  (default: none)
                        NOTE: If performing assembly and multiple files are provided then only the first file will be used for assembly. 
                              If no longreads are provided then all samples will be co-assembled 
                              with megahit or metaspades depending on the --coassemble parameter
  -c [COUPLED ...], --coupled [COUPLED ...]
                        Forward and reverse read files in a coupled space separated list.  (default: none)
                        NOTE: If performing assembly and multiple files are provided then only the first file will be used for assembly. 
                              If no longreads are provided then all samples will be co-assembled 
                              with megahit or metaspades depending on the --coassemble parameter
  --min-percent-read-identity-short SHORT_PERCENT_IDENTITY, --min_percent_read_identity_short SHORT_PERCENT_IDENTITY
                        Minimum percent read identity used by CoverM for short-reads  (default: 95)
                        when calculating genome abundances.
  -l [LONGREADS ...], --longreads [LONGREADS ...], --long-reads [LONGREADS ...], --long_reads [LONGREADS ...]
                        A space separated list of long-read read files. NOTE: The first file will be used for assembly unless --coassemble is set to True. Then all files will be used. (default: none)
  -z {ont,ont_hq,rs,sq,ccs,hifi}, --longread-type {ont,ont_hq,rs,sq,ccs,hifi}, --longread_type {ont,ont_hq,rs,sq,ccs,hifi}, --long_read_type {ont,ont_hq,rs,sq,ccs,hifi}, --long-read-type {ont,ont_hq,rs,sq,ccs,hifi}
                        Whether the sequencing platform and technology for the longreads.  (default: ont)
                        "rs" for PacBio RSII, "sq" for PacBio Sequel, "ccs" for PacBio CCS, "hifi" for PacBio HiFi 
                        reads, "ont" for Oxford Nanopore and "ont_hq" for Oxford Nanopore high quality reads (Guppy5+ or Q20) 
  --medaka-model {r103_fast_g507,r103_fast_snp_g507,r103_fast_variant_g507,r103_hac_g507,r103_hac_snp_g507,r103_hac_variant_g507,r103_min_high_g345,r103_min_high_g360,r103_prom_high_g360,r103_prom_snp_g3210,r103_prom_variant_g3210,r103_sup_g507,r103_sup_snp_g507,r103_sup_variant_g507,r1041_e82_260bps_fast_g632,r1041_e82_260bps_fast_variant_g632,r1041_e82_260bps_hac_g632,r1041_e82_260bps_hac_variant_g632,r1041_e82_260bps_sup_g632,r1041_e82_260bps_sup_variant_g632,r1041_e82_400bps_fast_g615,r1041_e82_400bps_fast_g632,r1041_e82_400bps_fast_variant_g615,r1041_e82_400bps_fast_variant_g632,r1041_e82_400bps_hac_g615,r1041_e82_400bps_hac_g632,r1041_e82_400bps_hac_variant_g615,r1041_e82_400bps_hac_variant_g632,r1041_e82_400bps_sup_g615,r1041_e82_400bps_sup_variant_g615,r104_e81_fast_g5015,r104_e81_fast_variant_g5015,r104_e81_hac_g5015,r104_e81_hac_variant_g5015,r104_e81_sup_g5015,r104_e81_sup_g610,r104_e81_sup_variant_g610,r10_min_high_g303,r10_min_high_g340,r941_e81_fast_g514,r941_e81_fast_variant_g514,r941_e81_hac_g514,r941_e81_hac_variant_g514,r941_e81_sup_g514,r941_e81_sup_variant_g514,r941_min_fast_g303,r941_min_fast_g507,r941_min_fast_snp_g507,r941_min_fast_variant_g507,r941_min_hac_g507,r941_min_hac_snp_g507,r941_min_hac_variant_g507,r941_min_high_g303,r941_min_high_g330,r941_min_high_g340_rle,r941_min_high_g344,r941_min_high_g351,r941_min_high_g360,r941_min_sup_g507,r941_min_sup_snp_g507,r941_min_sup_variant_g507,r941_prom_fast_g303,r941_prom_fast_g507,r941_prom_fast_snp_g507,r941_prom_fast_variant_g507,r941_prom_hac_g507,r941_prom_hac_snp_g507,r941_prom_hac_variant_g507,r941_prom_high_g303,r941_prom_high_g330,r941_prom_high_g344,r941_prom_high_g360,r941_prom_high_g4011,r941_prom_snp_g303,r941_prom_snp_g322,r941_prom_snp_g360,r941_prom_sup_g507,r941_prom_sup_snp_g507,r941_prom_sup_variant_g507,r941_prom_variant_g303,r941_prom_variant_g322,r941_prom_variant_g360,r941_sup_plant_g610,r941_sup_plant_variant_g610}, --medaka_model {r103_fast_g507,r103_fast_snp_g507,r103_fast_variant_g507,r103_hac_g507,r103_hac_snp_g507,r103_hac_variant_g507,r103_min_high_g345,r103_min_high_g360,r103_prom_high_g360,r103_prom_snp_g3210,r103_prom_variant_g3210,r103_sup_g507,r103_sup_snp_g507,r103_sup_variant_g507,r1041_e82_260bps_fast_g632,r1041_e82_260bps_fast_variant_g632,r1041_e82_260bps_hac_g632,r1041_e82_260bps_hac_variant_g632,r1041_e82_260bps_sup_g632,r1041_e82_260bps_sup_variant_g632,r1041_e82_400bps_fast_g615,r1041_e82_400bps_fast_g632,r1041_e82_400bps_fast_variant_g615,r1041_e82_400bps_fast_variant_g632,r1041_e82_400bps_hac_g615,r1041_e82_400bps_hac_g632,r1041_e82_400bps_hac_variant_g615,r1041_e82_400bps_hac_variant_g632,r1041_e82_400bps_sup_g615,r1041_e82_400bps_sup_variant_g615,r104_e81_fast_g5015,r104_e81_fast_variant_g5015,r104_e81_hac_g5015,r104_e81_hac_variant_g5015,r104_e81_sup_g5015,r104_e81_sup_g610,r104_e81_sup_variant_g610,r10_min_high_g303,r10_min_high_g340,r941_e81_fast_g514,r941_e81_fast_variant_g514,r941_e81_hac_g514,r941_e81_hac_variant_g514,r941_e81_sup_g514,r941_e81_sup_variant_g514,r941_min_fast_g303,r941_min_fast_g507,r941_min_fast_snp_g507,r941_min_fast_variant_g507,r941_min_hac_g507,r941_min_hac_snp_g507,r941_min_hac_variant_g507,r941_min_high_g303,r941_min_high_g330,r941_min_high_g340_rle,r941_min_high_g344,r941_min_high_g351,r941_min_high_g360,r941_min_sup_g507,r941_min_sup_snp_g507,r941_min_sup_variant_g507,r941_prom_fast_g303,r941_prom_fast_g507,r941_prom_fast_snp_g507,r941_prom_fast_variant_g507,r941_prom_hac_g507,r941_prom_hac_snp_g507,r941_prom_hac_variant_g507,r941_prom_high_g303,r941_prom_high_g330,r941_prom_high_g344,r941_prom_high_g360,r941_prom_high_g4011,r941_prom_snp_g303,r941_prom_snp_g322,r941_prom_snp_g360,r941_prom_sup_g507,r941_prom_sup_snp_g507,r941_prom_sup_variant_g507,r941_prom_variant_g303,r941_prom_variant_g322,r941_prom_variant_g360,r941_sup_plant_g610,r941_sup_plant_variant_g610}
                        Medaka model to use for polishing long reads.  (default: r941_min_hac_g507)
  --min-percent-read-identity-long LONG_PERCENT_IDENTITY, --min_percent_read_identity_long LONG_PERCENT_IDENTITY
                        Minimum percent read identity used by CoverM for long-readswhen calculating genome abundances. (default: 85)
  -s MIN_CONTIG_SIZE, --min-contig-size MIN_CONTIG_SIZE, --min_contig_size MIN_CONTIG_SIZE
                        Minimum contig size in base pairs to be considered for binning (default: 1500)
  -b MIN_BIN_SIZE, --min-bin-size MIN_BIN_SIZE, --min_bin_size MIN_BIN_SIZE
                        Minimum bin size in base pairs for a MAG (default: 200000)
  --semibin-model SEMIBIN_MODEL, --semibin_model SEMIBIN_MODEL
                        The environment model to passed to SemiBin. Can be one of:  (default: global)
                        human_gut, dog_gut, ocean, soil, cat_gut, human_oral, mouse_gut, pig_gut, built_environment, wastewater, global
  --refinery-max-iterations REFINERY_MAX_ITERATIONS, --refinery_max_iterations REFINERY_MAX_ITERATIONS
                        Maximum number of iterations for Rosella refinery. Set to 0 to skip refinery. Lower values will run faster but may result in lower quality MAGs. (default: 5)
  --refinery-max-retries REFINERY_MAX_RETRIES, --refinery_max_retries REFINERY_MAX_RETRIES
                        Maximum number of retries rosella uses to generate valid reclustering within a refinery iteration. Lower values will run faster but may result in lower quality MAGs. (default: 3)
  --extra-binners [{maxbin,maxbin2,concoct,comebin,taxvamb} ...], --extra_binners [{maxbin,maxbin2,concoct,comebin,taxvamb} ...], --extra-binner [{maxbin,maxbin2,concoct,comebin,taxvamb} ...], --extra_binner [{maxbin,maxbin2,concoct,comebin,taxvamb} ...]
                        Optional list of extra binning algorithms to run. Can be any combination of: 
                        maxbin, maxbin2, concoct, comebin, taxvamb 
                        These binners are skipped by default as they can have long runtimes 
                        N.B. specifying "maxbin" and "maxbin2" are equivalent 
                        N.B. specifying "taxvamb" will also run metabuli for contig taxonomic assignment 
  --skip-binners [{rosella,semibin,metabat1,metabat2,metabat,vamb} ...], --skip_binners [{rosella,semibin,metabat1,metabat2,metabat,vamb} ...], --skip_binner [{rosella,semibin,metabat1,metabat2,metabat,vamb} ...], --skip-binner [{rosella,semibin,metabat1,metabat2,metabat,vamb} ...]
                        Optional list of binning algorithms to skip. Can be any combination of: 
                        rosella, semibin, metabat1, metabat2, metabat, vamb 
                        N.B. specifying "metabat" will skip both MetaBAT1 and MetaBAT2. 
  --binning-only [BINNING_ONLY], --binning_only [BINNING_ONLY]
                        Only run up to the binning stage. Do not run SingleM, GTDB-tk, or CoverM
  --skip-abundances [SKIP_ABUNDANCES], --skip_abundances [SKIP_ABUNDANCES]
                        Skip CoverM post-binning abundance calculations.
  --skip-taxonomy [SKIP_TAXONOMY], --skip_taxonomy [SKIP_TAXONOMY]
                        Skip GTDB-tk post-binning taxonomy assignment.
  --skip-singlem [SKIP_SINGLEM], --skip_singlem [SKIP_SINGLEM]
                        Skip SingleM post-binning recovery assessment.
  --gtdb-path GTDB_PATH, --gtdb_path GTDB_PATH
                        Path to the local gtdb database files
  --eggnog-db-path EGGNOG_DB_PATH, --eggnog_db_path EGGNOG_DB_PATH
                        Path to the local eggnog database files
  --singlem-metapackage-path SINGLEM_METAPACKAGE_PATH, --singlem_metapackage_path SINGLEM_METAPACKAGE_PATH
                        Path to the local SingleM metapackage
  --checkm2-db-path CHECKM2_DB_PATH, --checkm2_db_path CHECKM2_DB_PATH
                        Path to Checkm2 Database
  -t MAX_THREADS, --max-threads MAX_THREADS, --max_threads MAX_THREADS
                        Maximum number of threads given to any particular process. If max_threads > n_cores then n_cores will be bumped up to max_threads. Useful if you want more fine grain control over the number of threads used by each process. (default: 8)
  -p PPLACER_THREADS, --pplacer-threads PPLACER_THREADS, --pplacer_threads PPLACER_THREADS
                        The number of threads given to pplacer, values above `--max-threads` will be scaled to equal `--max-threads` (default: 8)
  -n N_CORES, --n-cores N_CORES, --n_cores N_CORES
                        Maximum number of cores available for use. Setting to multiples of max_threads will allow for multiple processes to be run in parallel. (default: 16)
  -m MAX_MEMORY, --max-memory MAX_MEMORY, --max_memory MAX_MEMORY
                        Maximum memory for available usage in Gigabytes (default: 250)
  --request-gpu [REQUEST_GPU], --request_gpu [REQUEST_GPU]
                        Request a GPU for use with the pipeline. This will only work if the pipeline is run on a cluster
  -o OUTPUT, --output OUTPUT
                        Output directory (default: ./)
  --conda-prefix CONDA_PREFIX, --conda_prefix CONDA_PREFIX
                        Path to the location of installed conda environments, or where to install new environments. 
                        Can be configured within the `configure` subcommand
  --tmpdir TMPDIR, --tempdir TMPDIR, --tmp-dir TMPDIR, --tmp_dir TMPDIR, --tmp TMPDIR, --temp TMPDIR, --temp-dir TMPDIR, --temp_dir TMPDIR
                        Path to the location that will be treated used for temporary files. If none is specified, the TMPDIR 
                        environment variable will be used. Can be configured within the `configure` subcommand
  --default-resources RESOURCES
                        Snakemake resources used as is found at: https://snakemake.readthedocs.io/en/stable/snakefiles/rules.html?highlight=resources#standard-resources  (default:  )
                        NOTE: tmpdir is handled by the `tmpdir` command line parameter. 
  --snakemake-profile SNAKEMAKE_PROFILE
                        Snakemake profile (see https://snakemake.readthedocs.io/en/stable/executing/cli.html#profiles)
                        Create profile as `~/.config/snakemake/[CLUSTER_PROFILE]/config.yaml`. 
                        Can be used to submit rules as jobs to cluster engine (see https://snakemake.readthedocs.io/en/stable/executing/cluster.html), 
                        requires cluster, cluster-status, jobs, cluster-cancel. 
  --local-cores LOCAL_CORES, --local_cores LOCAL_CORES
                        Maximum number of cores available for use locally. Only relevant if jobs are being submitted to a cluster (e.g. see `--snakemake-profile`), in which case `--n-cores` will restrict requested cores in submitted jobs. (default: 16)
  --cluster-retries CLUSTER_RETRIES
                        Number of times to retry a failed job when using cluster submission (see `--snakemake-profile`). 
  --dry-run [DRYRUN], --dry_run [DRYRUN], --dryrun [DRYRUN]
                        Perform snakemake dry run, tests workflow order and conda environments
  --clean [CLEAN]       Clean up all temporary files. This will remove most BAM files and any FASTQ files  (default: True)
                        generated from read filtering. Setting this to False is the equivalent of the --notemp 
                        option in snakemake. Useful for when running only part of a workflow as it avoids 
                        deleting files that would likely be needed in later parts of the workflow. 
                        NOTE: Not cleaning makes reruns faster but will incur the wrath of your sysadmin
  --build [yes|no]      Build conda environments necessary to run the pipeline, and then exit. Equivalent to "--snakemake-cmds '--conda-create-envs-only True ' ". Other inputs should be specified as if running normally so that the right set of conda environments is built. (default: no)
  --download [{gtdb,eggnog,singlem,checkm2,metabuli} ...], --download [{gtdb,eggnog,singlem,checkm2,metabuli} ...]
                        Downloads the requested GTDB, EggNOG, SingleM, CheckM2, & Metabuli databases
  --rerun-triggers [{mtime,params,input,software-env,code} ...], --rerun_triggers [{mtime,params,input,software-env,code} ...]
                        Specify which kinds of modifications will trigger rules to rerun (default: ['mtime'])
  --snakemake-cmds CMDS
                        Additional commands to supplied to snakemake in the form of a single string e.g. "--print-compilation True". 
                         NOTE: Most commands in snakemake -h are valid but some commands may clash with commands 
                         aviary directly supplies to snakemake. Please make sure your additional commands don't clash.
  -a ASSEMBLY, --assembly ASSEMBLY
                        Optional FASTA file containing scaffolded contigs of the metagenome assembly
  -w WORKFLOW [WORKFLOW ...], --workflow WORKFLOW [WORKFLOW ...]
                        Main workflow to run. This is the snakemake target rule to run. (default: ['recover_mags'])
  --perform-strain-analysis [STRAIN_ANALYSIS], --perform_strain_analysis [STRAIN_ANALYSIS]
                        Specify whether to use Lorikeet on recovered MAGs get strain diversity metrics

                                           ......:::::: RECOVER ::::::......
    
    aviary recover --assembly scaffolds.fasta -1 *.1.fq.gz -2 *.2.fq.gz --longreads *.nanopore.fastq.gz --long_read_type ont
```


## aviary_annotate

### Tool Description
Annotate a given set of MAGs using EggNOG, GTDB-tk, and Checkm2

### Metadata
- **Docker Image**: quay.io/biocontainers/aviary:0.12.0--pyhdfd78af_0
- **Homepage**: https://github.com/rhysnewell/aviary/
- **Package**: https://anaconda.org/channels/bioconda/packages/aviary/overview
- **Validation**: PASS

### Original Help Text
```text
usage: aviary annotate [-h] [-d DIRECTORY] [-x EXT] [--gtdb-path GTDB_PATH]
                       [--eggnog-db-path EGGNOG_DB_PATH]
                       [--singlem-metapackage-path SINGLEM_METAPACKAGE_PATH]
                       [--checkm2-db-path CHECKM2_DB_PATH] [-t MAX_THREADS]
                       [-p PPLACER_THREADS] [-n N_CORES] [-m MAX_MEMORY]
                       [--request-gpu [REQUEST_GPU]] [-o OUTPUT]
                       [--conda-prefix CONDA_PREFIX] [--tmpdir TMPDIR]
                       [--default-resources RESOURCES]
                       [--snakemake-profile SNAKEMAKE_PROFILE]
                       [--local-cores LOCAL_CORES]
                       [--cluster-retries CLUSTER_RETRIES]
                       [--dry-run [DRYRUN]] [--clean [CLEAN]]
                       [--build [yes|no]]
                       [--download [{gtdb,eggnog,singlem,checkm2,metabuli} ...]]
                       [--rerun-triggers [{mtime,params,input,software-env,code} ...]]
                       [--snakemake-cmds CMDS] [-g [GOLD_STANDARD ...]]
                       [--gsa-mappings GSA_MAPPINGS]
                       [-r [REFERENCE_FILTER ...]]
                       [--min-read-size MIN_READ_SIZE]
                       [--min-mean-q MIN_MEAN_Q] [--keep-percent KEEP_PERCENT]
                       [--min-short-read-length MIN_SHORT_READ_LENGTH]
                       [--max-short-read-length MAX_SHORT_READ_LENGTH]
                       [--disable-adpater-trimming [DISABLE_ADAPTER_TRIMMING]]
                       [--unqualified-percent-limit UNQUALIFIED_PERCENT_LIMIT]
                       [--quality-cutoff QUALITY_CUTOFF]
                       [--extra-fastp-params EXTRA_FASTP_PARAMS]
                       [--skip-qc [SKIP_QC]] [-a [ASSEMBLY ...]]
                       [-w WORKFLOW [WORKFLOW ...]]

Annotate a given set of MAGs using EggNOG, GTDB-tk, and Checkm2

options:
  -h, --help            show this help message and exit
  -d DIRECTORY, --genome-fasta-directory DIRECTORY, --genome_fasta_directory DIRECTORY
                        Directory containing MAGs to be annotated
  -x EXT, --fasta-extension EXT, --fasta_extension EXT
                        File extension of fasta files in --genome-fasta-directory (default: fna)
  --gtdb-path GTDB_PATH, --gtdb_path GTDB_PATH
                        Path to the local gtdb database files
  --eggnog-db-path EGGNOG_DB_PATH, --eggnog_db_path EGGNOG_DB_PATH
                        Path to the local eggnog database files
  --singlem-metapackage-path SINGLEM_METAPACKAGE_PATH, --singlem_metapackage_path SINGLEM_METAPACKAGE_PATH
                        Path to the local SingleM metapackage
  --checkm2-db-path CHECKM2_DB_PATH, --checkm2_db_path CHECKM2_DB_PATH
                        Path to Checkm2 Database
  -t MAX_THREADS, --max-threads MAX_THREADS, --max_threads MAX_THREADS
                        Maximum number of threads given to any particular process. If max_threads > n_cores then n_cores will be bumped up to max_threads. Useful if you want more fine grain control over the number of threads used by each process. (default: 8)
  -p PPLACER_THREADS, --pplacer-threads PPLACER_THREADS, --pplacer_threads PPLACER_THREADS
                        The number of threads given to pplacer, values above `--max-threads` will be scaled to equal `--max-threads` (default: 8)
  -n N_CORES, --n-cores N_CORES, --n_cores N_CORES
                        Maximum number of cores available for use. Setting to multiples of max_threads will allow for multiple processes to be run in parallel. (default: 16)
  -m MAX_MEMORY, --max-memory MAX_MEMORY, --max_memory MAX_MEMORY
                        Maximum memory for available usage in Gigabytes (default: 250)
  --request-gpu [REQUEST_GPU], --request_gpu [REQUEST_GPU]
                        Request a GPU for use with the pipeline. This will only work if the pipeline is run on a cluster
  -o OUTPUT, --output OUTPUT
                        Output directory (default: ./)
  --conda-prefix CONDA_PREFIX, --conda_prefix CONDA_PREFIX
                        Path to the location of installed conda environments, or where to install new environments. 
                        Can be configured within the `configure` subcommand
  --tmpdir TMPDIR, --tempdir TMPDIR, --tmp-dir TMPDIR, --tmp_dir TMPDIR, --tmp TMPDIR, --temp TMPDIR, --temp-dir TMPDIR, --temp_dir TMPDIR
                        Path to the location that will be treated used for temporary files. If none is specified, the TMPDIR 
                        environment variable will be used. Can be configured within the `configure` subcommand
  --default-resources RESOURCES
                        Snakemake resources used as is found at: https://snakemake.readthedocs.io/en/stable/snakefiles/rules.html?highlight=resources#standard-resources  (default:  )
                        NOTE: tmpdir is handled by the `tmpdir` command line parameter. 
  --snakemake-profile SNAKEMAKE_PROFILE
                        Snakemake profile (see https://snakemake.readthedocs.io/en/stable/executing/cli.html#profiles)
                        Create profile as `~/.config/snakemake/[CLUSTER_PROFILE]/config.yaml`. 
                        Can be used to submit rules as jobs to cluster engine (see https://snakemake.readthedocs.io/en/stable/executing/cluster.html), 
                        requires cluster, cluster-status, jobs, cluster-cancel. 
  --local-cores LOCAL_CORES, --local_cores LOCAL_CORES
                        Maximum number of cores available for use locally. Only relevant if jobs are being submitted to a cluster (e.g. see `--snakemake-profile`), in which case `--n-cores` will restrict requested cores in submitted jobs. (default: 16)
  --cluster-retries CLUSTER_RETRIES
                        Number of times to retry a failed job when using cluster submission (see `--snakemake-profile`). 
  --dry-run [DRYRUN], --dry_run [DRYRUN], --dryrun [DRYRUN]
                        Perform snakemake dry run, tests workflow order and conda environments
  --clean [CLEAN]       Clean up all temporary files. This will remove most BAM files and any FASTQ files  (default: True)
                        generated from read filtering. Setting this to False is the equivalent of the --notemp 
                        option in snakemake. Useful for when running only part of a workflow as it avoids 
                        deleting files that would likely be needed in later parts of the workflow. 
                        NOTE: Not cleaning makes reruns faster but will incur the wrath of your sysadmin
  --build [yes|no]      Build conda environments necessary to run the pipeline, and then exit. Equivalent to "--snakemake-cmds '--conda-create-envs-only True ' ". Other inputs should be specified as if running normally so that the right set of conda environments is built. (default: no)
  --download [{gtdb,eggnog,singlem,checkm2,metabuli} ...], --download [{gtdb,eggnog,singlem,checkm2,metabuli} ...]
                        Downloads the requested GTDB, EggNOG, SingleM, CheckM2, & Metabuli databases
  --rerun-triggers [{mtime,params,input,software-env,code} ...], --rerun_triggers [{mtime,params,input,software-env,code} ...]
                        Specify which kinds of modifications will trigger rules to rerun (default: ['mtime'])
  --snakemake-cmds CMDS
                        Additional commands to supplied to snakemake in the form of a single string e.g. "--print-compilation True". 
                         NOTE: Most commands in snakemake -h are valid but some commands may clash with commands 
                         aviary directly supplies to snakemake. Please make sure your additional commands don't clash.
  -g [GOLD_STANDARD ...], --gold-standard-assembly [GOLD_STANDARD ...], --gold_standard_assembly [GOLD_STANDARD ...]
                        Gold standard assembly to compare either the Aviary assembly or a given input assembly against (default: ['none'])
  --gsa-mappings GSA_MAPPINGS, --gsa_mappings GSA_MAPPINGS
                        CAMI I & II GSA mappings (default: none)
  -r [REFERENCE_FILTER ...], --reference-filter [REFERENCE_FILTER ...], --reference_filter [REFERENCE_FILTER ...]
                        One or more reference filter files to aid in the assembly. Remove contaminant reads from the assembly. (default: ['none'])
  --min-read-size MIN_READ_SIZE, --min_read_size MIN_READ_SIZE
                        Minimum long read size when filtering using Filtlong (default: 100)
  --min-mean-q MIN_MEAN_Q, --min_mean_q MIN_MEAN_Q
                        Minimum long read mean quality threshold (default: 10)
  --keep-percent KEEP_PERCENT, --keep_percent KEEP_PERCENT
                        DEPRECATED: Percentage of reads passing quality thresholds kept by filtlong (default: 100)
  --min-short-read-length MIN_SHORT_READ_LENGTH, --min_short_read_length MIN_SHORT_READ_LENGTH
                        Minimum length of short reads to be kept (default: 15)
  --max-short-read-length MAX_SHORT_READ_LENGTH, --max_short_read_length MAX_SHORT_READ_LENGTH
                        Maximum length of short reads to be kept, 0 = no maximum
  --disable-adpater-trimming [DISABLE_ADAPTER_TRIMMING], --disable_adpater_trimming [DISABLE_ADAPTER_TRIMMING]
                        Disable adapter trimming of short reads
  --unqualified-percent-limit UNQUALIFIED_PERCENT_LIMIT, --unqualified_percent_limit UNQUALIFIED_PERCENT_LIMIT
                        how many percents of bases are allowed to be unqualified. Default 40 means 40 percent (default: 40)
  --quality-cutoff QUALITY_CUTOFF, --quality_cutoff QUALITY_CUTOFF
                        The short read quality value that a base is qualified. Default 15 means phred quality >=Q15 is qualified. (default: 15)
  --extra-fastp-params EXTRA_FASTP_PARAMS, --extra_fastp_params EXTRA_FASTP_PARAMS
                        Extra parameters to pass to fastp, supply as a single string e.g. --extra-fastp-params "-V -e 10"
  --skip-qc [SKIP_QC], --skip_qc [SKIP_QC]
                        Skip quality control steps
  -a [ASSEMBLY ...], --assembly [ASSEMBLY ...]
                        FASTA file containing scaffolded contigs of one or more metagenome assemblies wishing to be passed to QUAST
  -w WORKFLOW [WORKFLOW ...], --workflow WORKFLOW [WORKFLOW ...]
                        Main workflow to run. This is the snakemake target rule to run. (default: ['annotate'])

                                                  ......:::::: ANNOTATE ::::::......
                                        
                                            aviary annotate --genome-fasta-directory input_bins/
```


## aviary_diversity

### Tool Description
Perform strain diversity analysis

### Metadata
- **Docker Image**: quay.io/biocontainers/aviary:0.12.0--pyhdfd78af_0
- **Homepage**: https://github.com/rhysnewell/aviary/
- **Package**: https://anaconda.org/channels/bioconda/packages/aviary/overview
- **Validation**: PASS

### Original Help Text
```text
usage: aviary diversity [-h] [-d DIRECTORY] [-x EXT] [-g [GOLD_STANDARD ...]]
                        [--gsa-mappings GSA_MAPPINGS]
                        [-r [REFERENCE_FILTER ...]]
                        [--min-read-size MIN_READ_SIZE]
                        [--min-mean-q MIN_MEAN_Q]
                        [--keep-percent KEEP_PERCENT]
                        [--min-short-read-length MIN_SHORT_READ_LENGTH]
                        [--max-short-read-length MAX_SHORT_READ_LENGTH]
                        [--disable-adpater-trimming [DISABLE_ADAPTER_TRIMMING]]
                        [--unqualified-percent-limit UNQUALIFIED_PERCENT_LIMIT]
                        [--quality-cutoff QUALITY_CUTOFF]
                        [--extra-fastp-params EXTRA_FASTP_PARAMS]
                        [--skip-qc [SKIP_QC]]
                        [--use-unicycler [USE_UNICYCLER]]
                        [--use-megahit [USE_MEGAHIT]] [--coassemble [yes|no]]
                        [--kmer-sizes KMER_SIZES [KMER_SIZES ...]]
                        [--min-cov-long MIN_COV_LONG]
                        [--min-cov-short MIN_COV_SHORT]
                        [--exclude-contig-cov EXCLUDE_CONTIG_COV]
                        [--exclude-contig-size EXCLUDE_CONTIG_SIZE]
                        [--include-contig-size INCLUDE_CONTIG_SIZE]
                        [-1 [PE1 ...]] [-2 [PE2 ...]] [-i [INTERLEAVED ...]]
                        [-c [COUPLED ...]]
                        [--min-percent-read-identity-short SHORT_PERCENT_IDENTITY]
                        [-l [LONGREADS ...]] [-z {ont,ont_hq,rs,sq,ccs,hifi}]
                        [--medaka-model {r103_fast_g507,r103_fast_snp_g507,r103_fast_variant_g507,r103_hac_g507,r103_hac_snp_g507,r103_hac_variant_g507,r103_min_high_g345,r103_min_high_g360,r103_prom_high_g360,r103_prom_snp_g3210,r103_prom_variant_g3210,r103_sup_g507,r103_sup_snp_g507,r103_sup_variant_g507,r1041_e82_260bps_fast_g632,r1041_e82_260bps_fast_variant_g632,r1041_e82_260bps_hac_g632,r1041_e82_260bps_hac_variant_g632,r1041_e82_260bps_sup_g632,r1041_e82_260bps_sup_variant_g632,r1041_e82_400bps_fast_g615,r1041_e82_400bps_fast_g632,r1041_e82_400bps_fast_variant_g615,r1041_e82_400bps_fast_variant_g632,r1041_e82_400bps_hac_g615,r1041_e82_400bps_hac_g632,r1041_e82_400bps_hac_variant_g615,r1041_e82_400bps_hac_variant_g632,r1041_e82_400bps_sup_g615,r1041_e82_400bps_sup_variant_g615,r104_e81_fast_g5015,r104_e81_fast_variant_g5015,r104_e81_hac_g5015,r104_e81_hac_variant_g5015,r104_e81_sup_g5015,r104_e81_sup_g610,r104_e81_sup_variant_g610,r10_min_high_g303,r10_min_high_g340,r941_e81_fast_g514,r941_e81_fast_variant_g514,r941_e81_hac_g514,r941_e81_hac_variant_g514,r941_e81_sup_g514,r941_e81_sup_variant_g514,r941_min_fast_g303,r941_min_fast_g507,r941_min_fast_snp_g507,r941_min_fast_variant_g507,r941_min_hac_g507,r941_min_hac_snp_g507,r941_min_hac_variant_g507,r941_min_high_g303,r941_min_high_g330,r941_min_high_g340_rle,r941_min_high_g344,r941_min_high_g351,r941_min_high_g360,r941_min_sup_g507,r941_min_sup_snp_g507,r941_min_sup_variant_g507,r941_prom_fast_g303,r941_prom_fast_g507,r941_prom_fast_snp_g507,r941_prom_fast_variant_g507,r941_prom_hac_g507,r941_prom_hac_snp_g507,r941_prom_hac_variant_g507,r941_prom_high_g303,r941_prom_high_g330,r941_prom_high_g344,r941_prom_high_g360,r941_prom_high_g4011,r941_prom_snp_g303,r941_prom_snp_g322,r941_prom_snp_g360,r941_prom_sup_g507,r941_prom_sup_snp_g507,r941_prom_sup_variant_g507,r941_prom_variant_g303,r941_prom_variant_g322,r941_prom_variant_g360,r941_sup_plant_g610,r941_sup_plant_variant_g610}]
                        [--min-percent-read-identity-long LONG_PERCENT_IDENTITY]
                        [-s MIN_CONTIG_SIZE] [-b MIN_BIN_SIZE]
                        [--semibin-model SEMIBIN_MODEL]
                        [--refinery-max-iterations REFINERY_MAX_ITERATIONS]
                        [--refinery-max-retries REFINERY_MAX_RETRIES]
                        [--extra-binners [{maxbin,maxbin2,concoct,comebin,taxvamb} ...]]
                        [--skip-binners [{rosella,semibin,metabat1,metabat2,metabat,vamb} ...]]
                        [--binning-only [BINNING_ONLY]]
                        [--skip-abundances [SKIP_ABUNDANCES]]
                        [--skip-taxonomy [SKIP_TAXONOMY]]
                        [--skip-singlem [SKIP_SINGLEM]]
                        [--gtdb-path GTDB_PATH]
                        [--eggnog-db-path EGGNOG_DB_PATH]
                        [--singlem-metapackage-path SINGLEM_METAPACKAGE_PATH]
                        [--checkm2-db-path CHECKM2_DB_PATH] [-t MAX_THREADS]
                        [-p PPLACER_THREADS] [-n N_CORES] [-m MAX_MEMORY]
                        [--request-gpu [REQUEST_GPU]] [-o OUTPUT]
                        [--conda-prefix CONDA_PREFIX] [--tmpdir TMPDIR]
                        [--default-resources RESOURCES]
                        [--snakemake-profile SNAKEMAKE_PROFILE]
                        [--local-cores LOCAL_CORES]
                        [--cluster-retries CLUSTER_RETRIES]
                        [--dry-run [DRYRUN]] [--clean [CLEAN]]
                        [--build [yes|no]]
                        [--download [{gtdb,eggnog,singlem,checkm2,metabuli} ...]]
                        [--rerun-triggers [{mtime,params,input,software-env,code} ...]]
                        [--snakemake-cmds CMDS] [-a [ASSEMBLY ...]]
                        [-w WORKFLOW [WORKFLOW ...]]

Perform strain diversity analysis

options:
  -h, --help            show this help message and exit
  -d DIRECTORY, --genome-fasta-directory DIRECTORY, --genome_fasta_directory DIRECTORY
                        Directory containing MAGs to be annotated
  -x EXT, --fasta-extension EXT, --fasta_extension EXT
                        File extension of fasta files in --genome-fasta-directory (default: fna)
  -g [GOLD_STANDARD ...], --gold-standard-assembly [GOLD_STANDARD ...], --gold_standard_assembly [GOLD_STANDARD ...]
                        Gold standard assembly to compare either the Aviary assembly or a given input assembly against (default: ['none'])
  --gsa-mappings GSA_MAPPINGS, --gsa_mappings GSA_MAPPINGS
                        CAMI I & II GSA mappings (default: none)
  -r [REFERENCE_FILTER ...], --reference-filter [REFERENCE_FILTER ...], --reference_filter [REFERENCE_FILTER ...]
                        One or more reference filter files to aid in the assembly. Remove contaminant reads from the assembly. (default: ['none'])
  --min-read-size MIN_READ_SIZE, --min_read_size MIN_READ_SIZE
                        Minimum long read size when filtering using Filtlong (default: 100)
  --min-mean-q MIN_MEAN_Q, --min_mean_q MIN_MEAN_Q
                        Minimum long read mean quality threshold (default: 10)
  --keep-percent KEEP_PERCENT, --keep_percent KEEP_PERCENT
                        DEPRECATED: Percentage of reads passing quality thresholds kept by filtlong (default: 100)
  --min-short-read-length MIN_SHORT_READ_LENGTH, --min_short_read_length MIN_SHORT_READ_LENGTH
                        Minimum length of short reads to be kept (default: 15)
  --max-short-read-length MAX_SHORT_READ_LENGTH, --max_short_read_length MAX_SHORT_READ_LENGTH
                        Maximum length of short reads to be kept, 0 = no maximum
  --disable-adpater-trimming [DISABLE_ADAPTER_TRIMMING], --disable_adpater_trimming [DISABLE_ADAPTER_TRIMMING]
                        Disable adapter trimming of short reads
  --unqualified-percent-limit UNQUALIFIED_PERCENT_LIMIT, --unqualified_percent_limit UNQUALIFIED_PERCENT_LIMIT
                        how many percents of bases are allowed to be unqualified. Default 40 means 40 percent (default: 40)
  --quality-cutoff QUALITY_CUTOFF, --quality_cutoff QUALITY_CUTOFF
                        The short read quality value that a base is qualified. Default 15 means phred quality >=Q15 is qualified. (default: 15)
  --extra-fastp-params EXTRA_FASTP_PARAMS, --extra_fastp_params EXTRA_FASTP_PARAMS
                        Extra parameters to pass to fastp, supply as a single string e.g. --extra-fastp-params "-V -e 10"
  --skip-qc [SKIP_QC], --skip_qc [SKIP_QC]
                        Skip quality control steps
  --use-unicycler [USE_UNICYCLER], --use_unicycler [USE_UNICYCLER]
                        Use Unicycler to re-assemble the metaSPAdes hybrid assembly. Not recommended for complex metagenomes.
  --use-megahit [USE_MEGAHIT], --use_megahit [USE_MEGAHIT]
                        Specifies whether or not to use megahit if multiple for short-read only assembly
  --coassemble [yes|no], --co-assemble [yes|no], --co_assemble [yes|no]
                        Specifies whether or not, when given multiple input reads, to coassemble them. 
                        If False (no), Aviary will use the first set of short reads and first set of long reads to perform assembly 
                        All read files will still be used during the MAG recovery process for differential coverage.
  --kmer-sizes KMER_SIZES [KMER_SIZES ...], --kmer_sizes KMER_SIZES [KMER_SIZES ...], -k KMER_SIZES [KMER_SIZES ...]
                        Manually specify the kmer-sizes used by SPAdes during assembly. Space separated odd integer values and less than 128 or "auto" (default: ['auto'])
  --min-cov-long MIN_COV_LONG, --min_cov_long MIN_COV_LONG
                        Automatically include Flye contigs with long read coverage greater than or equal to this.  (default: 5)
                        High long read coverage during assembly indicates that the overlap layout consensus algorithm 
                        is more likely to be correct.
  --min-cov-short MIN_COV_SHORT, --min_cov_short MIN_COV_SHORT
                        Automatically include Flye contigs with short read coverage less than or equal to this.  (default: 5)
                        Low coverage via short reads indicates that metaSPAdes will not be able to better assemble this contig.
  --exclude-contig-cov EXCLUDE_CONTIG_COV, --exclude_contig_cov EXCLUDE_CONTIG_COV
                        Automatically exclude Flye contigs with long read coverage less than or equal to this  (default: 10)
                        and less than or equal to `--exclude-contig-size`
  --exclude-contig-size EXCLUDE_CONTIG_SIZE, --exclude_contig_size EXCLUDE_CONTIG_SIZE
                        Automatically exclude Flye contigs with length less than or equal to this  (default: 2500)
                        and long read coverage less than or equal to `--exclude-contig-cov`
  --include-contig-size INCLUDE_CONTIG_SIZE, --include_contig_size INCLUDE_CONTIG_SIZE
                        Automatically include Flye contigs with length greater than or equal to this (default: 10000)
  -1 [PE1 ...], --pe-1 [PE1 ...], --paired-reads-1 [PE1 ...], --paired_reads_1 [PE1 ...], --pe1 [PE1 ...]
                        A space separated list of forwards read files  (default: none)
                        NOTE: If performing assembly and multiple files are provided then only the first file will be used for assembly. 
                              If no longreads are provided then all samples will be co-assembled 
                              with megahit or metaspades depending on the --coassemble parameter
  -2 [PE2 ...], --pe-2 [PE2 ...], --paired-reads-2 [PE2 ...], --paired_reads_2 [PE2 ...], --pe2 [PE2 ...]
                        A space separated list of reverse read files  (default: none)
                        NOTE: If performing assembly and multiple files are provided then only the first file will be used for assembly. 
                              If no longreads are provided then all samples will be co-assembled 
                              with megahit or metaspades depending on the --coassemble parameter
  -i [INTERLEAVED ...], --interleaved [INTERLEAVED ...]
                        A space separated list of interleaved read files  (default: none)
                        NOTE: If performing assembly and multiple files are provided then only the first file will be used for assembly. 
                              If no longreads are provided then all samples will be co-assembled 
                              with megahit or metaspades depending on the --coassemble parameter
  -c [COUPLED ...], --coupled [COUPLED ...]
                        Forward and reverse read files in a coupled space separated list.  (default: none)
                        NOTE: If performing assembly and multiple files are provided then only the first file will be used for assembly. 
                              If no longreads are provided then all samples will be co-assembled 
                              with megahit or metaspades depending on the --coassemble parameter
  --min-percent-read-identity-short SHORT_PERCENT_IDENTITY, --min_percent_read_identity_short SHORT_PERCENT_IDENTITY
                        Minimum percent read identity used by CoverM for short-reads  (default: 95)
                        when calculating genome abundances.
  -l [LONGREADS ...], --longreads [LONGREADS ...], --long-reads [LONGREADS ...], --long_reads [LONGREADS ...]
                        A space separated list of long-read read files. NOTE: The first file will be used for assembly unless --coassemble is set to True. Then all files will be used. (default: none)
  -z {ont,ont_hq,rs,sq,ccs,hifi}, --longread-type {ont,ont_hq,rs,sq,ccs,hifi}, --longread_type {ont,ont_hq,rs,sq,ccs,hifi}, --long_read_type {ont,ont_hq,rs,sq,ccs,hifi}, --long-read-type {ont,ont_hq,rs,sq,ccs,hifi}
                        Whether the sequencing platform and technology for the longreads.  (default: ont)
                        "rs" for PacBio RSII, "sq" for PacBio Sequel, "ccs" for PacBio CCS, "hifi" for PacBio HiFi 
                        reads, "ont" for Oxford Nanopore and "ont_hq" for Oxford Nanopore high quality reads (Guppy5+ or Q20) 
  --medaka-model {r103_fast_g507,r103_fast_snp_g507,r103_fast_variant_g507,r103_hac_g507,r103_hac_snp_g507,r103_hac_variant_g507,r103_min_high_g345,r103_min_high_g360,r103_prom_high_g360,r103_prom_snp_g3210,r103_prom_variant_g3210,r103_sup_g507,r103_sup_snp_g507,r103_sup_variant_g507,r1041_e82_260bps_fast_g632,r1041_e82_260bps_fast_variant_g632,r1041_e82_260bps_hac_g632,r1041_e82_260bps_hac_variant_g632,r1041_e82_260bps_sup_g632,r1041_e82_260bps_sup_variant_g632,r1041_e82_400bps_fast_g615,r1041_e82_400bps_fast_g632,r1041_e82_400bps_fast_variant_g615,r1041_e82_400bps_fast_variant_g632,r1041_e82_400bps_hac_g615,r1041_e82_400bps_hac_g632,r1041_e82_400bps_hac_variant_g615,r1041_e82_400bps_hac_variant_g632,r1041_e82_400bps_sup_g615,r1041_e82_400bps_sup_variant_g615,r104_e81_fast_g5015,r104_e81_fast_variant_g5015,r104_e81_hac_g5015,r104_e81_hac_variant_g5015,r104_e81_sup_g5015,r104_e81_sup_g610,r104_e81_sup_variant_g610,r10_min_high_g303,r10_min_high_g340,r941_e81_fast_g514,r941_e81_fast_variant_g514,r941_e81_hac_g514,r941_e81_hac_variant_g514,r941_e81_sup_g514,r941_e81_sup_variant_g514,r941_min_fast_g303,r941_min_fast_g507,r941_min_fast_snp_g507,r941_min_fast_variant_g507,r941_min_hac_g507,r941_min_hac_snp_g507,r941_min_hac_variant_g507,r941_min_high_g303,r941_min_high_g330,r941_min_high_g340_rle,r941_min_high_g344,r941_min_high_g351,r941_min_high_g360,r941_min_sup_g507,r941_min_sup_snp_g507,r941_min_sup_variant_g507,r941_prom_fast_g303,r941_prom_fast_g507,r941_prom_fast_snp_g507,r941_prom_fast_variant_g507,r941_prom_hac_g507,r941_prom_hac_snp_g507,r941_prom_hac_variant_g507,r941_prom_high_g303,r941_prom_high_g330,r941_prom_high_g344,r941_prom_high_g360,r941_prom_high_g4011,r941_prom_snp_g303,r941_prom_snp_g322,r941_prom_snp_g360,r941_prom_sup_g507,r941_prom_sup_snp_g507,r941_prom_sup_variant_g507,r941_prom_variant_g303,r941_prom_variant_g322,r941_prom_variant_g360,r941_sup_plant_g610,r941_sup_plant_variant_g610}, --medaka_model {r103_fast_g507,r103_fast_snp_g507,r103_fast_variant_g507,r103_hac_g507,r103_hac_snp_g507,r103_hac_variant_g507,r103_min_high_g345,r103_min_high_g360,r103_prom_high_g360,r103_prom_snp_g3210,r103_prom_variant_g3210,r103_sup_g507,r103_sup_snp_g507,r103_sup_variant_g507,r1041_e82_260bps_fast_g632,r1041_e82_260bps_fast_variant_g632,r1041_e82_260bps_hac_g632,r1041_e82_260bps_hac_variant_g632,r1041_e82_260bps_sup_g632,r1041_e82_260bps_sup_variant_g632,r1041_e82_400bps_fast_g615,r1041_e82_400bps_fast_g632,r1041_e82_400bps_fast_variant_g615,r1041_e82_400bps_fast_variant_g632,r1041_e82_400bps_hac_g615,r1041_e82_400bps_hac_g632,r1041_e82_400bps_hac_variant_g615,r1041_e82_400bps_hac_variant_g632,r1041_e82_400bps_sup_g615,r1041_e82_400bps_sup_variant_g615,r104_e81_fast_g5015,r104_e81_fast_variant_g5015,r104_e81_hac_g5015,r104_e81_hac_variant_g5015,r104_e81_sup_g5015,r104_e81_sup_g610,r104_e81_sup_variant_g610,r10_min_high_g303,r10_min_high_g340,r941_e81_fast_g514,r941_e81_fast_variant_g514,r941_e81_hac_g514,r941_e81_hac_variant_g514,r941_e81_sup_g514,r941_e81_sup_variant_g514,r941_min_fast_g303,r941_min_fast_g507,r941_min_fast_snp_g507,r941_min_fast_variant_g507,r941_min_hac_g507,r941_min_hac_snp_g507,r941_min_hac_variant_g507,r941_min_high_g303,r941_min_high_g330,r941_min_high_g340_rle,r941_min_high_g344,r941_min_high_g351,r941_min_high_g360,r941_min_sup_g507,r941_min_sup_snp_g507,r941_min_sup_variant_g507,r941_prom_fast_g303,r941_prom_fast_g507,r941_prom_fast_snp_g507,r941_prom_fast_variant_g507,r941_prom_hac_g507,r941_prom_hac_snp_g507,r941_prom_hac_variant_g507,r941_prom_high_g303,r941_prom_high_g330,r941_prom_high_g344,r941_prom_high_g360,r941_prom_high_g4011,r941_prom_snp_g303,r941_prom_snp_g322,r941_prom_snp_g360,r941_prom_sup_g507,r941_prom_sup_snp_g507,r941_prom_sup_variant_g507,r941_prom_variant_g303,r941_prom_variant_g322,r941_prom_variant_g360,r941_sup_plant_g610,r941_sup_plant_variant_g610}
                        Medaka model to use for polishing long reads.  (default: r941_min_hac_g507)
  --min-percent-read-identity-long LONG_PERCENT_IDENTITY, --min_percent_read_identity_long LONG_PERCENT_IDENTITY
                        Minimum percent read identity used by CoverM for long-readswhen calculating genome abundances. (default: 85)
  -s MIN_CONTIG_SIZE, --min-contig-size MIN_CONTIG_SIZE, --min_contig_size MIN_CONTIG_SIZE
                        Minimum contig size in base pairs to be considered for binning (default: 1500)
  -b MIN_BIN_SIZE, --min-bin-size MIN_BIN_SIZE, --min_bin_size MIN_BIN_SIZE
                        Minimum bin size in base pairs for a MAG (default: 200000)
  --semibin-model SEMIBIN_MODEL, --semibin_model SEMIBIN_MODEL
                        The environment model to passed to SemiBin. Can be one of:  (default: global)
                        human_gut, dog_gut, ocean, soil, cat_gut, human_oral, mouse_gut, pig_gut, built_environment, wastewater, global
  --refinery-max-iterations REFINERY_MAX_ITERATIONS, --refinery_max_iterations REFINERY_MAX_ITERATIONS
                        Maximum number of iterations for Rosella refinery. Set to 0 to skip refinery. Lower values will run faster but may result in lower quality MAGs. (default: 5)
  --refinery-max-retries REFINERY_MAX_RETRIES, --refinery_max_retries REFINERY_MAX_RETRIES
                        Maximum number of retries rosella uses to generate valid reclustering within a refinery iteration. Lower values will run faster but may result in lower quality MAGs. (default: 3)
  --extra-binners [{maxbin,maxbin2,concoct,comebin,taxvamb} ...], --extra_binners [{maxbin,maxbin2,concoct,comebin,taxvamb} ...], --extra-binner [{maxbin,maxbin2,concoct,comebin,taxvamb} ...], --extra_binner [{maxbin,maxbin2,concoct,comebin,taxvamb} ...]
                        Optional list of extra binning algorithms to run. Can be any combination of: 
                        maxbin, maxbin2, concoct, comebin, taxvamb 
                        These binners are skipped by default as they can have long runtimes 
                        N.B. specifying "maxbin" and "maxbin2" are equivalent 
                        N.B. specifying "taxvamb" will also run metabuli for contig taxonomic assignment 
  --skip-binners [{rosella,semibin,metabat1,metabat2,metabat,vamb} ...], --skip_binners [{rosella,semibin,metabat1,metabat2,metabat,vamb} ...], --skip_binner [{rosella,semibin,metabat1,metabat2,metabat,vamb} ...], --skip-binner [{rosella,semibin,metabat1,metabat2,metabat,vamb} ...]
                        Optional list of binning algorithms to skip. Can be any combination of: 
                        rosella, semibin, metabat1, metabat2, metabat, vamb 
                        N.B. specifying "metabat" will skip both MetaBAT1 and MetaBAT2. 
  --binning-only [BINNING_ONLY], --binning_only [BINNING_ONLY]
                        Only run up to the binning stage. Do not run SingleM, GTDB-tk, or CoverM
  --skip-abundances [SKIP_ABUNDANCES], --skip_abundances [SKIP_ABUNDANCES]
                        Skip CoverM post-binning abundance calculations.
  --skip-taxonomy [SKIP_TAXONOMY], --skip_taxonomy [SKIP_TAXONOMY]
                        Skip GTDB-tk post-binning taxonomy assignment.
  --skip-singlem [SKIP_SINGLEM], --skip_singlem [SKIP_SINGLEM]
                        Skip SingleM post-binning recovery assessment.
  --gtdb-path GTDB_PATH, --gtdb_path GTDB_PATH
                        Path to the local gtdb database files
  --eggnog-db-path EGGNOG_DB_PATH, --eggnog_db_path EGGNOG_DB_PATH
                        Path to the local eggnog database files
  --singlem-metapackage-path SINGLEM_METAPACKAGE_PATH, --singlem_metapackage_path SINGLEM_METAPACKAGE_PATH
                        Path to the local SingleM metapackage
  --checkm2-db-path CHECKM2_DB_PATH, --checkm2_db_path CHECKM2_DB_PATH
                        Path to Checkm2 Database
  -t MAX_THREADS, --max-threads MAX_THREADS, --max_threads MAX_THREADS
                        Maximum number of threads given to any particular process. If max_threads > n_cores then n_cores will be bumped up to max_threads. Useful if you want more fine grain control over the number of threads used by each process. (default: 8)
  -p PPLACER_THREADS, --pplacer-threads PPLACER_THREADS, --pplacer_threads PPLACER_THREADS
                        The number of threads given to pplacer, values above `--max-threads` will be scaled to equal `--max-threads` (default: 8)
  -n N_CORES, --n-cores N_CORES, --n_cores N_CORES
                        Maximum number of cores available for use. Setting to multiples of max_threads will allow for multiple processes to be run in parallel. (default: 16)
  -m MAX_MEMORY, --max-memory MAX_MEMORY, --max_memory MAX_MEMORY
                        Maximum memory for available usage in Gigabytes (default: 250)
  --request-gpu [REQUEST_GPU], --request_gpu [REQUEST_GPU]
                        Request a GPU for use with the pipeline. This will only work if the pipeline is run on a cluster
  -o OUTPUT, --output OUTPUT
                        Output directory (default: ./)
  --conda-prefix CONDA_PREFIX, --conda_prefix CONDA_PREFIX
                        Path to the location of installed conda environments, or where to install new environments. 
                        Can be configured within the `configure` subcommand
  --tmpdir TMPDIR, --tempdir TMPDIR, --tmp-dir TMPDIR, --tmp_dir TMPDIR, --tmp TMPDIR, --temp TMPDIR, --temp-dir TMPDIR, --temp_dir TMPDIR
                        Path to the location that will be treated used for temporary files. If none is specified, the TMPDIR 
                        environment variable will be used. Can be configured within the `configure` subcommand
  --default-resources RESOURCES
                        Snakemake resources used as is found at: https://snakemake.readthedocs.io/en/stable/snakefiles/rules.html?highlight=resources#standard-resources  (default:  )
                        NOTE: tmpdir is handled by the `tmpdir` command line parameter. 
  --snakemake-profile SNAKEMAKE_PROFILE
                        Snakemake profile (see https://snakemake.readthedocs.io/en/stable/executing/cli.html#profiles)
                        Create profile as `~/.config/snakemake/[CLUSTER_PROFILE]/config.yaml`. 
                        Can be used to submit rules as jobs to cluster engine (see https://snakemake.readthedocs.io/en/stable/executing/cluster.html), 
                        requires cluster, cluster-status, jobs, cluster-cancel. 
  --local-cores LOCAL_CORES, --local_cores LOCAL_CORES
                        Maximum number of cores available for use locally. Only relevant if jobs are being submitted to a cluster (e.g. see `--snakemake-profile`), in which case `--n-cores` will restrict requested cores in submitted jobs. (default: 16)
  --cluster-retries CLUSTER_RETRIES
                        Number of times to retry a failed job when using cluster submission (see `--snakemake-profile`). 
  --dry-run [DRYRUN], --dry_run [DRYRUN], --dryrun [DRYRUN]
                        Perform snakemake dry run, tests workflow order and conda environments
  --clean [CLEAN]       Clean up all temporary files. This will remove most BAM files and any FASTQ files  (default: True)
                        generated from read filtering. Setting this to False is the equivalent of the --notemp 
                        option in snakemake. Useful for when running only part of a workflow as it avoids 
                        deleting files that would likely be needed in later parts of the workflow. 
                        NOTE: Not cleaning makes reruns faster but will incur the wrath of your sysadmin
  --build [yes|no]      Build conda environments necessary to run the pipeline, and then exit. Equivalent to "--snakemake-cmds '--conda-create-envs-only True ' ". Other inputs should be specified as if running normally so that the right set of conda environments is built. (default: no)
  --download [{gtdb,eggnog,singlem,checkm2,metabuli} ...], --download [{gtdb,eggnog,singlem,checkm2,metabuli} ...]
                        Downloads the requested GTDB, EggNOG, SingleM, CheckM2, & Metabuli databases
  --rerun-triggers [{mtime,params,input,software-env,code} ...], --rerun_triggers [{mtime,params,input,software-env,code} ...]
                        Specify which kinds of modifications will trigger rules to rerun (default: ['mtime'])
  --snakemake-cmds CMDS
                        Additional commands to supplied to snakemake in the form of a single string e.g. "--print-compilation True". 
                         NOTE: Most commands in snakemake -h are valid but some commands may clash with commands 
                         aviary directly supplies to snakemake. Please make sure your additional commands don't clash.
  -a [ASSEMBLY ...], --assembly [ASSEMBLY ...]
                        FASTA file containing scaffolded contigs of one or more metagenome assemblies wishing to be passed to QUAST
  -w WORKFLOW [WORKFLOW ...], --workflow WORKFLOW [WORKFLOW ...]
                        Main workflow to run. This is the snakemake target rule to run. (default: ['lorikeet'])

                                                                    ......:::::: DIVERSITY ::::::......

                                             aviary diversity -c R1.fastq.gz R2.fastq.gz --genome-fasta-directory input_bins/
```


## aviary_complete

### Tool Description
Performs all steps in the Aviary pipeline. Assembly > Binning > Refinement > Annotation > Diversity

### Metadata
- **Docker Image**: quay.io/biocontainers/aviary:0.12.0--pyhdfd78af_0
- **Homepage**: https://github.com/rhysnewell/aviary/
- **Package**: https://anaconda.org/channels/bioconda/packages/aviary/overview
- **Validation**: PASS

### Original Help Text
```text
usage: aviary complete [-h] [-g [GOLD_STANDARD ...]]
                       [--gsa-mappings GSA_MAPPINGS]
                       [-r [REFERENCE_FILTER ...]]
                       [--min-read-size MIN_READ_SIZE]
                       [--min-mean-q MIN_MEAN_Q] [--keep-percent KEEP_PERCENT]
                       [--min-short-read-length MIN_SHORT_READ_LENGTH]
                       [--max-short-read-length MAX_SHORT_READ_LENGTH]
                       [--disable-adpater-trimming [DISABLE_ADAPTER_TRIMMING]]
                       [--unqualified-percent-limit UNQUALIFIED_PERCENT_LIMIT]
                       [--quality-cutoff QUALITY_CUTOFF]
                       [--extra-fastp-params EXTRA_FASTP_PARAMS]
                       [--skip-qc [SKIP_QC]] [--use-unicycler [USE_UNICYCLER]]
                       [--use-megahit [USE_MEGAHIT]] [--coassemble [yes|no]]
                       [--kmer-sizes KMER_SIZES [KMER_SIZES ...]]
                       [--min-cov-long MIN_COV_LONG]
                       [--min-cov-short MIN_COV_SHORT]
                       [--exclude-contig-cov EXCLUDE_CONTIG_COV]
                       [--exclude-contig-size EXCLUDE_CONTIG_SIZE]
                       [--include-contig-size INCLUDE_CONTIG_SIZE]
                       [-1 [PE1 ...]] [-2 [PE2 ...]] [-i [INTERLEAVED ...]]
                       [-c [COUPLED ...]]
                       [--min-percent-read-identity-short SHORT_PERCENT_IDENTITY]
                       [-l [LONGREADS ...]] [-z {ont,ont_hq,rs,sq,ccs,hifi}]
                       [--medaka-model {r103_fast_g507,r103_fast_snp_g507,r103_fast_variant_g507,r103_hac_g507,r103_hac_snp_g507,r103_hac_variant_g507,r103_min_high_g345,r103_min_high_g360,r103_prom_high_g360,r103_prom_snp_g3210,r103_prom_variant_g3210,r103_sup_g507,r103_sup_snp_g507,r103_sup_variant_g507,r1041_e82_260bps_fast_g632,r1041_e82_260bps_fast_variant_g632,r1041_e82_260bps_hac_g632,r1041_e82_260bps_hac_variant_g632,r1041_e82_260bps_sup_g632,r1041_e82_260bps_sup_variant_g632,r1041_e82_400bps_fast_g615,r1041_e82_400bps_fast_g632,r1041_e82_400bps_fast_variant_g615,r1041_e82_400bps_fast_variant_g632,r1041_e82_400bps_hac_g615,r1041_e82_400bps_hac_g632,r1041_e82_400bps_hac_variant_g615,r1041_e82_400bps_hac_variant_g632,r1041_e82_400bps_sup_g615,r1041_e82_400bps_sup_variant_g615,r104_e81_fast_g5015,r104_e81_fast_variant_g5015,r104_e81_hac_g5015,r104_e81_hac_variant_g5015,r104_e81_sup_g5015,r104_e81_sup_g610,r104_e81_sup_variant_g610,r10_min_high_g303,r10_min_high_g340,r941_e81_fast_g514,r941_e81_fast_variant_g514,r941_e81_hac_g514,r941_e81_hac_variant_g514,r941_e81_sup_g514,r941_e81_sup_variant_g514,r941_min_fast_g303,r941_min_fast_g507,r941_min_fast_snp_g507,r941_min_fast_variant_g507,r941_min_hac_g507,r941_min_hac_snp_g507,r941_min_hac_variant_g507,r941_min_high_g303,r941_min_high_g330,r941_min_high_g340_rle,r941_min_high_g344,r941_min_high_g351,r941_min_high_g360,r941_min_sup_g507,r941_min_sup_snp_g507,r941_min_sup_variant_g507,r941_prom_fast_g303,r941_prom_fast_g507,r941_prom_fast_snp_g507,r941_prom_fast_variant_g507,r941_prom_hac_g507,r941_prom_hac_snp_g507,r941_prom_hac_variant_g507,r941_prom_high_g303,r941_prom_high_g330,r941_prom_high_g344,r941_prom_high_g360,r941_prom_high_g4011,r941_prom_snp_g303,r941_prom_snp_g322,r941_prom_snp_g360,r941_prom_sup_g507,r941_prom_sup_snp_g507,r941_prom_sup_variant_g507,r941_prom_variant_g303,r941_prom_variant_g322,r941_prom_variant_g360,r941_sup_plant_g610,r941_sup_plant_variant_g610}]
                       [--min-percent-read-identity-long LONG_PERCENT_IDENTITY]
                       [-s MIN_CONTIG_SIZE] [-b MIN_BIN_SIZE]
                       [--semibin-model SEMIBIN_MODEL]
                       [--refinery-max-iterations REFINERY_MAX_ITERATIONS]
                       [--refinery-max-retries REFINERY_MAX_RETRIES]
                       [--extra-binners [{maxbin,maxbin2,concoct,comebin,taxvamb} ...]]
                       [--skip-binners [{rosella,semibin,metabat1,metabat2,metabat,vamb} ...]]
                       [--binning-only [BINNING_ONLY]]
                       [--skip-abundances [SKIP_ABUNDANCES]]
                       [--skip-taxonomy [SKIP_TAXONOMY]]
                       [--skip-singlem [SKIP_SINGLEM]] [--gtdb-path GTDB_PATH]
                       [--eggnog-db-path EGGNOG_DB_PATH]
                       [--singlem-metapackage-path SINGLEM_METAPACKAGE_PATH]
                       [--checkm2-db-path CHECKM2_DB_PATH] [-t MAX_THREADS]
                       [-p PPLACER_THREADS] [-n N_CORES] [-m MAX_MEMORY]
                       [--request-gpu [REQUEST_GPU]] [-o OUTPUT]
                       [--conda-prefix CONDA_PREFIX] [--tmpdir TMPDIR]
                       [--default-resources RESOURCES]
                       [--snakemake-profile SNAKEMAKE_PROFILE]
                       [--local-cores LOCAL_CORES]
                       [--cluster-retries CLUSTER_RETRIES]
                       [--dry-run [DRYRUN]] [--clean [CLEAN]]
                       [--build [yes|no]]
                       [--download [{gtdb,eggnog,singlem,checkm2,metabuli} ...]]
                       [--rerun-triggers [{mtime,params,input,software-env,code} ...]]
                       [--snakemake-cmds CMDS] [-a ASSEMBLY]
                       [-w WORKFLOW [WORKFLOW ...]]

Performs all steps in the Aviary pipeline. Assembly > Binning > Refinement > Annotation > Diversity

options:
  -h, --help            show this help message and exit
  -g [GOLD_STANDARD ...], --gold-standard-assembly [GOLD_STANDARD ...], --gold_standard_assembly [GOLD_STANDARD ...]
                        Gold standard assembly to compare either the Aviary assembly or a given input assembly against (default: ['none'])
  --gsa-mappings GSA_MAPPINGS, --gsa_mappings GSA_MAPPINGS
                        CAMI I & II GSA mappings (default: none)
  -r [REFERENCE_FILTER ...], --reference-filter [REFERENCE_FILTER ...], --reference_filter [REFERENCE_FILTER ...]
                        One or more reference filter files to aid in the assembly. Remove contaminant reads from the assembly. (default: ['none'])
  --min-read-size MIN_READ_SIZE, --min_read_size MIN_READ_SIZE
                        Minimum long read size when filtering using Filtlong (default: 100)
  --min-mean-q MIN_MEAN_Q, --min_mean_q MIN_MEAN_Q
                        Minimum long read mean quality threshold (default: 10)
  --keep-percent KEEP_PERCENT, --keep_percent KEEP_PERCENT
                        DEPRECATED: Percentage of reads passing quality thresholds kept by filtlong (default: 100)
  --min-short-read-length MIN_SHORT_READ_LENGTH, --min_short_read_length MIN_SHORT_READ_LENGTH
                        Minimum length of short reads to be kept (default: 15)
  --max-short-read-length MAX_SHORT_READ_LENGTH, --max_short_read_length MAX_SHORT_READ_LENGTH
                        Maximum length of short reads to be kept, 0 = no maximum
  --disable-adpater-trimming [DISABLE_ADAPTER_TRIMMING], --disable_adpater_trimming [DISABLE_ADAPTER_TRIMMING]
                        Disable adapter trimming of short reads
  --unqualified-percent-limit UNQUALIFIED_PERCENT_LIMIT, --unqualified_percent_limit UNQUALIFIED_PERCENT_LIMIT
                        how many percents of bases are allowed to be unqualified. Default 40 means 40 percent (default: 40)
  --quality-cutoff QUALITY_CUTOFF, --quality_cutoff QUALITY_CUTOFF
                        The short read quality value that a base is qualified. Default 15 means phred quality >=Q15 is qualified. (default: 15)
  --extra-fastp-params EXTRA_FASTP_PARAMS, --extra_fastp_params EXTRA_FASTP_PARAMS
                        Extra parameters to pass to fastp, supply as a single string e.g. --extra-fastp-params "-V -e 10"
  --skip-qc [SKIP_QC], --skip_qc [SKIP_QC]
                        Skip quality control steps
  --use-unicycler [USE_UNICYCLER], --use_unicycler [USE_UNICYCLER]
                        Use Unicycler to re-assemble the metaSPAdes hybrid assembly. Not recommended for complex metagenomes.
  --use-megahit [USE_MEGAHIT], --use_megahit [USE_MEGAHIT]
                        Specifies whether or not to use megahit if multiple for short-read only assembly
  --coassemble [yes|no], --co-assemble [yes|no], --co_assemble [yes|no]
                        Specifies whether or not, when given multiple input reads, to coassemble them. 
                        If False (no), Aviary will use the first set of short reads and first set of long reads to perform assembly 
                        All read files will still be used during the MAG recovery process for differential coverage.
  --kmer-sizes KMER_SIZES [KMER_SIZES ...], --kmer_sizes KMER_SIZES [KMER_SIZES ...], -k KMER_SIZES [KMER_SIZES ...]
                        Manually specify the kmer-sizes used by SPAdes during assembly. Space separated odd integer values and less than 128 or "auto" (default: ['auto'])
  --min-cov-long MIN_COV_LONG, --min_cov_long MIN_COV_LONG
                        Automatically include Flye contigs with long read coverage greater than or equal to this.  (default: 5)
                        High long read coverage during assembly indicates that the overlap layout consensus algorithm 
                        is more likely to be correct.
  --min-cov-short MIN_COV_SHORT, --min_cov_short MIN_COV_SHORT
                        Automatically include Flye contigs with short read coverage less than or equal to this.  (default: 5)
                        Low coverage via short reads indicates that metaSPAdes will not be able to better assemble this contig.
  --exclude-contig-cov EXCLUDE_CONTIG_COV, --exclude_contig_cov EXCLUDE_CONTIG_COV
                        Automatically exclude Flye contigs with long read coverage less than or equal to this  (default: 10)
                        and less than or equal to `--exclude-contig-size`
  --exclude-contig-size EXCLUDE_CONTIG_SIZE, --exclude_contig_size EXCLUDE_CONTIG_SIZE
                        Automatically exclude Flye contigs with length less than or equal to this  (default: 2500)
                        and long read coverage less than or equal to `--exclude-contig-cov`
  --include-contig-size INCLUDE_CONTIG_SIZE, --include_contig_size INCLUDE_CONTIG_SIZE
                        Automatically include Flye contigs with length greater than or equal to this (default: 10000)
  -1 [PE1 ...], --pe-1 [PE1 ...], --paired-reads-1 [PE1 ...], --paired_reads_1 [PE1 ...], --pe1 [PE1 ...]
                        A space separated list of forwards read files  (default: none)
                        NOTE: If performing assembly and multiple files are provided then only the first file will be used for assembly. 
                              If no longreads are provided then all samples will be co-assembled 
                              with megahit or metaspades depending on the --coassemble parameter
  -2 [PE2 ...], --pe-2 [PE2 ...], --paired-reads-2 [PE2 ...], --paired_reads_2 [PE2 ...], --pe2 [PE2 ...]
                        A space separated list of reverse read files  (default: none)
                        NOTE: If performing assembly and multiple files are provided then only the first file will be used for assembly. 
                              If no longreads are provided then all samples will be co-assembled 
                              with megahit or metaspades depending on the --coassemble parameter
  -i [INTERLEAVED ...], --interleaved [INTERLEAVED ...]
                        A space separated list of interleaved read files  (default: none)
                        NOTE: If performing assembly and multiple files are provided then only the first file will be used for assembly. 
                              If no longreads are provided then all samples will be co-assembled 
                              with megahit or metaspades depending on the --coassemble parameter
  -c [COUPLED ...], --coupled [COUPLED ...]
                        Forward and reverse read files in a coupled space separated list.  (default: none)
                        NOTE: If performing assembly and multiple files are provided then only the first file will be used for assembly. 
                              If no longreads are provided then all samples will be co-assembled 
                              with megahit or metaspades depending on the --coassemble parameter
  --min-percent-read-identity-short SHORT_PERCENT_IDENTITY, --min_percent_read_identity_short SHORT_PERCENT_IDENTITY
                        Minimum percent read identity used by CoverM for short-reads  (default: 95)
                        when calculating genome abundances.
  -l [LONGREADS ...], --longreads [LONGREADS ...], --long-reads [LONGREADS ...], --long_reads [LONGREADS ...]
                        A space separated list of long-read read files. NOTE: The first file will be used for assembly unless --coassemble is set to True. Then all files will be used. (default: none)
  -z {ont,ont_hq,rs,sq,ccs,hifi}, --longread-type {ont,ont_hq,rs,sq,ccs,hifi}, --longread_type {ont,ont_hq,rs,sq,ccs,hifi}, --long_read_type {ont,ont_hq,rs,sq,ccs,hifi}, --long-read-type {ont,ont_hq,rs,sq,ccs,hifi}
                        Whether the sequencing platform and technology for the longreads.  (default: ont)
                        "rs" for PacBio RSII, "sq" for PacBio Sequel, "ccs" for PacBio CCS, "hifi" for PacBio HiFi 
                        reads, "ont" for Oxford Nanopore and "ont_hq" for Oxford Nanopore high quality reads (Guppy5+ or Q20) 
  --medaka-model {r103_fast_g507,r103_fast_snp_g507,r103_fast_variant_g507,r103_hac_g507,r103_hac_snp_g507,r103_hac_variant_g507,r103_min_high_g345,r103_min_high_g360,r103_prom_high_g360,r103_prom_snp_g3210,r103_prom_variant_g3210,r103_sup_g507,r103_sup_snp_g507,r103_sup_variant_g507,r1041_e82_260bps_fast_g632,r1041_e82_260bps_fast_variant_g632,r1041_e82_260bps_hac_g632,r1041_e82_260bps_hac_variant_g632,r1041_e82_260bps_sup_g632,r1041_e82_260bps_sup_variant_g632,r1041_e82_400bps_fast_g615,r1041_e82_400bps_fast_g632,r1041_e82_400bps_fast_variant_g615,r1041_e82_400bps_fast_variant_g632,r1041_e82_400bps_hac_g615,r1041_e82_400bps_hac_g632,r1041_e82_400bps_hac_variant_g615,r1041_e82_400bps_hac_variant_g632,r1041_e82_400bps_sup_g615,r1041_e82_400bps_sup_variant_g615,r104_e81_fast_g5015,r104_e81_fast_variant_g5015,r104_e81_hac_g5015,r104_e81_hac_variant_g5015,r104_e81_sup_g5015,r104_e81_sup_g610,r104_e81_sup_variant_g610,r10_min_high_g303,r10_min_high_g340,r941_e81_fast_g514,r941_e81_fast_variant_g514,r941_e81_hac_g514,r941_e81_hac_variant_g514,r941_e81_sup_g514,r941_e81_sup_variant_g514,r941_min_fast_g303,r941_min_fast_g507,r941_min_fast_snp_g507,r941_min_fast_variant_g507,r941_min_hac_g507,r941_min_hac_snp_g507,r941_min_hac_variant_g507,r941_min_high_g303,r941_min_high_g330,r941_min_high_g340_rle,r941_min_high_g344,r941_min_high_g351,r941_min_high_g360,r941_min_sup_g507,r941_min_sup_snp_g507,r941_min_sup_variant_g507,r941_prom_fast_g303,r941_prom_fast_g507,r941_prom_fast_snp_g507,r941_prom_fast_variant_g507,r941_prom_hac_g507,r941_prom_hac_snp_g507,r941_prom_hac_variant_g507,r941_prom_high_g303,r941_prom_high_g330,r941_prom_high_g344,r941_prom_high_g360,r941_prom_high_g4011,r941_prom_snp_g303,r941_prom_snp_g322,r941_prom_snp_g360,r941_prom_sup_g507,r941_prom_sup_snp_g507,r941_prom_sup_variant_g507,r941_prom_variant_g303,r941_prom_variant_g322,r941_prom_variant_g360,r941_sup_plant_g610,r941_sup_plant_variant_g610}, --medaka_model {r103_fast_g507,r103_fast_snp_g507,r103_fast_variant_g507,r103_hac_g507,r103_hac_snp_g507,r103_hac_variant_g507,r103_min_high_g345,r103_min_high_g360,r103_prom_high_g360,r103_prom_snp_g3210,r103_prom_variant_g3210,r103_sup_g507,r103_sup_snp_g507,r103_sup_variant_g507,r1041_e82_260bps_fast_g632,r1041_e82_260bps_fast_variant_g632,r1041_e82_260bps_hac_g632,r1041_e82_260bps_hac_variant_g632,r1041_e82_260bps_sup_g632,r1041_e82_260bps_sup_variant_g632,r1041_e82_400bps_fast_g615,r1041_e82_400bps_fast_g632,r1041_e82_400bps_fast_variant_g615,r1041_e82_400bps_fast_variant_g632,r1041_e82_400bps_hac_g615,r1041_e82_400bps_hac_g632,r1041_e82_400bps_hac_variant_g615,r1041_e82_400bps_hac_variant_g632,r1041_e82_400bps_sup_g615,r1041_e82_400bps_sup_variant_g615,r104_e81_fast_g5015,r104_e81_fast_variant_g5015,r104_e81_hac_g5015,r104_e81_hac_variant_g5015,r104_e81_sup_g5015,r104_e81_sup_g610,r104_e81_sup_variant_g610,r10_min_high_g303,r10_min_high_g340,r941_e81_fast_g514,r941_e81_fast_variant_g514,r941_e81_hac_g514,r941_e81_hac_variant_g514,r941_e81_sup_g514,r941_e81_sup_variant_g514,r941_min_fast_g303,r941_min_fast_g507,r941_min_fast_snp_g507,r941_min_fast_variant_g507,r941_min_hac_g507,r941_min_hac_snp_g507,r941_min_hac_variant_g507,r941_min_high_g303,r941_min_high_g330,r941_min_high_g340_rle,r941_min_high_g344,r941_min_high_g351,r941_min_high_g360,r941_min_sup_g507,r941_min_sup_snp_g507,r941_min_sup_variant_g507,r941_prom_fast_g303,r941_prom_fast_g507,r941_prom_fast_snp_g507,r941_prom_fast_variant_g507,r941_prom_hac_g507,r941_prom_hac_snp_g507,r941_prom_hac_variant_g507,r941_prom_high_g303,r941_prom_high_g330,r941_prom_high_g344,r941_prom_high_g360,r941_prom_high_g4011,r941_prom_snp_g303,r941_prom_snp_g322,r941_prom_snp_g360,r941_prom_sup_g507,r941_prom_sup_snp_g507,r941_prom_sup_variant_g507,r941_prom_variant_g303,r941_prom_variant_g322,r941_prom_variant_g360,r941_sup_plant_g610,r941_sup_plant_variant_g610}
                        Medaka model to use for polishing long reads.  (default: r941_min_hac_g507)
  --min-percent-read-identity-long LONG_PERCENT_IDENTITY, --min_percent_read_identity_long LONG_PERCENT_IDENTITY
                        Minimum percent read identity used by CoverM for long-readswhen calculating genome abundances. (default: 85)
  -s MIN_CONTIG_SIZE, --min-contig-size MIN_CONTIG_SIZE, --min_contig_size MIN_CONTIG_SIZE
                        Minimum contig size in base pairs to be considered for binning (default: 1500)
  -b MIN_BIN_SIZE, --min-bin-size MIN_BIN_SIZE, --min_bin_size MIN_BIN_SIZE
                        Minimum bin size in base pairs for a MAG (default: 200000)
  --semibin-model SEMIBIN_MODEL, --semibin_model SEMIBIN_MODEL
                        The environment model to passed to SemiBin. Can be one of:  (default: global)
                        human_gut, dog_gut, ocean, soil, cat_gut, human_oral, mouse_gut, pig_gut, built_environment, wastewater, global
  --refinery-max-iterations REFINERY_MAX_ITERATIONS, --refinery_max_iterations REFINERY_MAX_ITERATIONS
                        Maximum number of iterations for Rosella refinery. Set to 0 to skip refinery. Lower values will run faster but may result in lower quality MAGs. (default: 5)
  --refinery-max-retries REFINERY_MAX_RETRIES, --refinery_max_retries REFINERY_MAX_RETRIES
                        Maximum number of retries rosella uses to generate valid reclustering within a refinery iteration. Lower values will run faster but may result in lower quality MAGs. (default: 3)
  --extra-binners [{maxbin,maxbin2,concoct,comebin,taxvamb} ...], --extra_binners [{maxbin,maxbin2,concoct,comebin,taxvamb} ...], --extra-binner [{maxbin,maxbin2,concoct,comebin,taxvamb} ...], --extra_binner [{maxbin,maxbin2,concoct,comebin,taxvamb} ...]
                        Optional list of extra binning algorithms to run. Can be any combination of: 
                        maxbin, maxbin2, concoct, comebin, taxvamb 
                        These binners are skipped by default as they can have long runtimes 
                        N.B. specifying "maxbin" and "maxbin2" are equivalent 
                        N.B. specifying "taxvamb" will also run metabuli for contig taxonomic assignment 
  --skip-binners [{rosella,semibin,metabat1,metabat2,metabat,vamb} ...], --skip_binners [{rosella,semibin,metabat1,metabat2,metabat,vamb} ...], --skip_binner [{rosella,semibin,metabat1,metabat2,metabat,vamb} ...], --skip-binner [{rosella,semibin,metabat1,metabat2,metabat,vamb} ...]
                        Optional list of binning algorithms to skip. Can be any combination of: 
                        rosella, semibin, metabat1, metabat2, metabat, vamb 
                        N.B. specifying "metabat" will skip both MetaBAT1 and MetaBAT2. 
  --binning-only [BINNING_ONLY], --binning_only [BINNING_ONLY]
                        Only run up to the binning stage. Do not run SingleM, GTDB-tk, or CoverM
  --skip-abundances [SKIP_ABUNDANCES], --skip_abundances [SKIP_ABUNDANCES]
                        Skip CoverM post-binning abundance calculations.
  --skip-taxonomy [SKIP_TAXONOMY], --skip_taxonomy [SKIP_TAXONOMY]
                        Skip GTDB-tk post-binning taxonomy assignment.
  --skip-singlem [SKIP_SINGLEM], --skip_singlem [SKIP_SINGLEM]
                        Skip SingleM post-binning recovery assessment.
  --gtdb-path GTDB_PATH, --gtdb_path GTDB_PATH
                        Path to the local gtdb database files
  --eggnog-db-path EGGNOG_DB_PATH, --eggnog_db_path EGGNOG_DB_PATH
                        Path to the local eggnog database files
  --singlem-metapackage-path SINGLEM_METAPACKAGE_PATH, --singlem_metapackage_path SINGLEM_METAPACKAGE_PATH
                        Path to the local SingleM metapackage
  --checkm2-db-path CHECKM2_DB_PATH, --checkm2_db_path CHECKM2_DB_PATH
                        Path to Checkm2 Database
  -t MAX_THREADS, --max-threads MAX_THREADS, --max_threads MAX_THREADS
                        Maximum number of threads given to any particular process. If max_threads > n_cores then n_cores will be bumped up to max_threads. Useful if you want more fine grain control over the number of threads used by each process. (default: 8)
  -p PPLACER_THREADS, --pplacer-threads PPLACER_THREADS, --pplacer_threads PPLACER_THREADS
                        The number of threads given to pplacer, values above `--max-threads` will be scaled to equal `--max-threads` (default: 8)
  -n N_CORES, --n-cores N_CORES, --n_cores N_CORES
                        Maximum number of cores available for use. Setting to multiples of max_threads will allow for multiple processes to be run in parallel. (default: 16)
  -m MAX_MEMORY, --max-memory MAX_MEMORY, --max_memory MAX_MEMORY
                        Maximum memory for available usage in Gigabytes (default: 250)
  --request-gpu [REQUEST_GPU], --request_gpu [REQUEST_GPU]
                        Request a GPU for use with the pipeline. This will only work if the pipeline is run on a cluster
  -o OUTPUT, --output OUTPUT
                        Output directory (default: ./)
  --conda-prefix CONDA_PREFIX, --conda_prefix CONDA_PREFIX
                        Path to the location of installed conda environments, or where to install new environments. 
                        Can be configured within the `configure` subcommand
  --tmpdir TMPDIR, --tempdir TMPDIR, --tmp-dir TMPDIR, --tmp_dir TMPDIR, --tmp TMPDIR, --temp TMPDIR, --temp-dir TMPDIR, --temp_dir TMPDIR
                        Path to the location that will be treated used for temporary files. If none is specified, the TMPDIR 
                        environment variable will be used. Can be configured within the `configure` subcommand
  --default-resources RESOURCES
                        Snakemake resources used as is found at: https://snakemake.readthedocs.io/en/stable/snakefiles/rules.html?highlight=resources#standard-resources  (default:  )
                        NOTE: tmpdir is handled by the `tmpdir` command line parameter. 
  --snakemake-profile SNAKEMAKE_PROFILE
                        Snakemake profile (see https://snakemake.readthedocs.io/en/stable/executing/cli.html#profiles)
                        Create profile as `~/.config/snakemake/[CLUSTER_PROFILE]/config.yaml`. 
                        Can be used to submit rules as jobs to cluster engine (see https://snakemake.readthedocs.io/en/stable/executing/cluster.html), 
                        requires cluster, cluster-status, jobs, cluster-cancel. 
  --local-cores LOCAL_CORES, --local_cores LOCAL_CORES
                        Maximum number of cores available for use locally. Only relevant if jobs are being submitted to a cluster (e.g. see `--snakemake-profile`), in which case `--n-cores` will restrict requested cores in submitted jobs. (default: 16)
  --cluster-retries CLUSTER_RETRIES
                        Number of times to retry a failed job when using cluster submission (see `--snakemake-profile`). 
  --dry-run [DRYRUN], --dry_run [DRYRUN], --dryrun [DRYRUN]
                        Perform snakemake dry run, tests workflow order and conda environments
  --clean [CLEAN]       Clean up all temporary files. This will remove most BAM files and any FASTQ files  (default: True)
                        generated from read filtering. Setting this to False is the equivalent of the --notemp 
                        option in snakemake. Useful for when running only part of a workflow as it avoids 
                        deleting files that would likely be needed in later parts of the workflow. 
                        NOTE: Not cleaning makes reruns faster but will incur the wrath of your sysadmin
  --build [yes|no]      Build conda environments necessary to run the pipeline, and then exit. Equivalent to "--snakemake-cmds '--conda-create-envs-only True ' ". Other inputs should be specified as if running normally so that the right set of conda environments is built. (default: no)
  --download [{gtdb,eggnog,singlem,checkm2,metabuli} ...], --download [{gtdb,eggnog,singlem,checkm2,metabuli} ...]
                        Downloads the requested GTDB, EggNOG, SingleM, CheckM2, & Metabuli databases
  --rerun-triggers [{mtime,params,input,software-env,code} ...], --rerun_triggers [{mtime,params,input,software-env,code} ...]
                        Specify which kinds of modifications will trigger rules to rerun (default: ['mtime'])
  --snakemake-cmds CMDS
                        Additional commands to supplied to snakemake in the form of a single string e.g. "--print-compilation True". 
                         NOTE: Most commands in snakemake -h are valid but some commands may clash with commands 
                         aviary directly supplies to snakemake. Please make sure your additional commands don't clash.
  -a ASSEMBLY, --assembly ASSEMBLY
                        Optional FASTA file containing scaffolded contigs of the metagenome assembly
  -w WORKFLOW [WORKFLOW ...], --workflow WORKFLOW [WORKFLOW ...]
                        Main workflow to run. This is the snakemake target rule to run. (default: ['get_bam_indices', 'recover_mags', 'annotate', 'lorikeet'])

                                                               ......:::::: COMPLETE ::::::......

                                            aviary complete -1 *.1.fq.gz -2 *.2.fq.gz --longreads *.nanopore.fastq.gz
```


## aviary_cluster

### Tool Description
Clusters previous aviary runs together and performsdereplication using Galah

### Metadata
- **Docker Image**: quay.io/biocontainers/aviary:0.12.0--pyhdfd78af_0
- **Homepage**: https://github.com/rhysnewell/aviary/
- **Package**: https://anaconda.org/channels/bioconda/packages/aviary/overview
- **Validation**: PASS

### Original Help Text
```text
usage: aviary cluster [-h] [-t MAX_THREADS] [-p PPLACER_THREADS] [-n N_CORES]
                      [-m MAX_MEMORY] [--request-gpu [REQUEST_GPU]]
                      [-o OUTPUT] [--conda-prefix CONDA_PREFIX]
                      [--tmpdir TMPDIR] [--default-resources RESOURCES]
                      [--snakemake-profile SNAKEMAKE_PROFILE]
                      [--local-cores LOCAL_CORES]
                      [--cluster-retries CLUSTER_RETRIES] [--dry-run [DRYRUN]]
                      [--clean [CLEAN]] [--build [yes|no]]
                      [--download [{gtdb,eggnog,singlem,checkm2,metabuli} ...]]
                      [--rerun-triggers [{mtime,params,input,software-env,code} ...]]
                      [--snakemake-cmds CMDS] [--ani ANI]
                      [--precluster-ani PRECLUSTER_ANI]
                      [--precluster-method PRECLUSTER_METHOD]
                      [--min-completeness MIN_COMPLETENESS]
                      [--max-contamination MAX_CONTAMINATION]
                      [--use-checkm2-scores [USE_CHECKM2_SCORES]]
                      [--pggb-params PGGB_PARAMS] -i [PREVIOUS_RUNS ...]
                      [-w WORKFLOW [WORKFLOW ...]]

Clusters previous aviary runs together and performsdereplication using Galah

options:
  -h, --help            show this help message and exit
  -t MAX_THREADS, --max-threads MAX_THREADS, --max_threads MAX_THREADS
                        Maximum number of threads given to any particular process. If max_threads > n_cores then n_cores will be bumped up to max_threads. Useful if you want more fine grain control over the number of threads used by each process. (default: 8)
  -p PPLACER_THREADS, --pplacer-threads PPLACER_THREADS, --pplacer_threads PPLACER_THREADS
                        The number of threads given to pplacer, values above `--max-threads` will be scaled to equal `--max-threads` (default: 8)
  -n N_CORES, --n-cores N_CORES, --n_cores N_CORES
                        Maximum number of cores available for use. Setting to multiples of max_threads will allow for multiple processes to be run in parallel. (default: 16)
  -m MAX_MEMORY, --max-memory MAX_MEMORY, --max_memory MAX_MEMORY
                        Maximum memory for available usage in Gigabytes (default: 250)
  --request-gpu [REQUEST_GPU], --request_gpu [REQUEST_GPU]
                        Request a GPU for use with the pipeline. This will only work if the pipeline is run on a cluster
  -o OUTPUT, --output OUTPUT
                        Output directory (default: ./)
  --conda-prefix CONDA_PREFIX, --conda_prefix CONDA_PREFIX
                        Path to the location of installed conda environments, or where to install new environments. 
                        Can be configured within the `configure` subcommand
  --tmpdir TMPDIR, --tempdir TMPDIR, --tmp-dir TMPDIR, --tmp_dir TMPDIR, --tmp TMPDIR, --temp TMPDIR, --temp-dir TMPDIR, --temp_dir TMPDIR
                        Path to the location that will be treated used for temporary files. If none is specified, the TMPDIR 
                        environment variable will be used. Can be configured within the `configure` subcommand
  --default-resources RESOURCES
                        Snakemake resources used as is found at: https://snakemake.readthedocs.io/en/stable/snakefiles/rules.html?highlight=resources#standard-resources  (default:  )
                        NOTE: tmpdir is handled by the `tmpdir` command line parameter. 
  --snakemake-profile SNAKEMAKE_PROFILE
                        Snakemake profile (see https://snakemake.readthedocs.io/en/stable/executing/cli.html#profiles)
                        Create profile as `~/.config/snakemake/[CLUSTER_PROFILE]/config.yaml`. 
                        Can be used to submit rules as jobs to cluster engine (see https://snakemake.readthedocs.io/en/stable/executing/cluster.html), 
                        requires cluster, cluster-status, jobs, cluster-cancel. 
  --local-cores LOCAL_CORES, --local_cores LOCAL_CORES
                        Maximum number of cores available for use locally. Only relevant if jobs are being submitted to a cluster (e.g. see `--snakemake-profile`), in which case `--n-cores` will restrict requested cores in submitted jobs. (default: 16)
  --cluster-retries CLUSTER_RETRIES
                        Number of times to retry a failed job when using cluster submission (see `--snakemake-profile`). 
  --dry-run [DRYRUN], --dry_run [DRYRUN], --dryrun [DRYRUN]
                        Perform snakemake dry run, tests workflow order and conda environments
  --clean [CLEAN]       Clean up all temporary files. This will remove most BAM files and any FASTQ files  (default: True)
                        generated from read filtering. Setting this to False is the equivalent of the --notemp 
                        option in snakemake. Useful for when running only part of a workflow as it avoids 
                        deleting files that would likely be needed in later parts of the workflow. 
                        NOTE: Not cleaning makes reruns faster but will incur the wrath of your sysadmin
  --build [yes|no]      Build conda environments necessary to run the pipeline, and then exit. Equivalent to "--snakemake-cmds '--conda-create-envs-only True ' ". Other inputs should be specified as if running normally so that the right set of conda environments is built. (default: no)
  --download [{gtdb,eggnog,singlem,checkm2,metabuli} ...], --download [{gtdb,eggnog,singlem,checkm2,metabuli} ...]
                        Downloads the requested GTDB, EggNOG, SingleM, CheckM2, & Metabuli databases
  --rerun-triggers [{mtime,params,input,software-env,code} ...], --rerun_triggers [{mtime,params,input,software-env,code} ...]
                        Specify which kinds of modifications will trigger rules to rerun (default: ['mtime'])
  --snakemake-cmds CMDS
                        Additional commands to supplied to snakemake in the form of a single string e.g. "--print-compilation True". 
                         NOTE: Most commands in snakemake -h are valid but some commands may clash with commands 
                         aviary directly supplies to snakemake. Please make sure your additional commands don't clash.
  --ani ANI             Overall ANI level to dereplicate at with FastANI. (default: 97)
  --precluster-ani PRECLUSTER_ANI, --precluster_ani PRECLUSTER_ANI
                        Require at least this dashing-derived ANI for preclustering and to avoid FastANI on distant lineages within preclusters. (default: 95)
  --precluster-method PRECLUSTER_METHOD, --precluster_method PRECLUSTER_METHOD
                        method of calculating rough ANI for dereplication. 'dashing' for HyperLogLog, 'finch' for finch MinHash. (default: dashing)
  --min-completeness MIN_COMPLETENESS, --min_completeness MIN_COMPLETENESS
                        Ignore genomes with less completeness than this percentage. (default: none)
  --max-contamination MAX_CONTAMINATION, --max_contamination MAX_CONTAMINATION
                        Ignore genomes with more contamination than this percentage. (default: none)
  --use-checkm2-scores [USE_CHECKM2_SCORES], --use_checkm2_scores [USE_CHECKM2_SCORES]
                        Use CheckM2 completeness and contamination scores (if available) to perform Galah dereplication
  --pggb-params PGGB_PARAMS, --pggb_params PGGB_PARAMS
                        Parameters to be used with pggb, must be surrounded by quotation marks e.g. '' (default: -k 79 -G 7919,8069)
  -i [PREVIOUS_RUNS ...], --input-runs [PREVIOUS_RUNS ...], --input_runs [PREVIOUS_RUNS ...]
                        The paths to the previous finished runs of Aviary. Must contain the bins/checkm.out and bins/final_binsoutputs
  -w WORKFLOW [WORKFLOW ...], --workflow WORKFLOW [WORKFLOW ...]
                        Main workflow to run. This is the snakemake target rule to run. (default: ['complete_cluster'])

                                                                   ......:::::: CLUSTER ::::::......

                                             aviary cluster --input-runs aviary_output_folder_1/ aviary_output_folder_2/
```


## aviary_batch

### Tool Description
Performs all steps in the Aviary pipeline on a batch file. Each line in the batch file is processed separately and then clustered using aviary. (Assembly > Binning > Refinement > Annotation > Diversity) * n_samples --> Cluster

### Metadata
- **Docker Image**: quay.io/biocontainers/aviary:0.12.0--pyhdfd78af_0
- **Homepage**: https://github.com/rhysnewell/aviary/
- **Package**: https://anaconda.org/channels/bioconda/packages/aviary/overview
- **Validation**: PASS

### Original Help Text
```text
usage: aviary batch [-h] [-g [GOLD_STANDARD ...]]
                    [--gsa-mappings GSA_MAPPINGS] [-r [REFERENCE_FILTER ...]]
                    [--min-read-size MIN_READ_SIZE] [--min-mean-q MIN_MEAN_Q]
                    [--keep-percent KEEP_PERCENT]
                    [--min-short-read-length MIN_SHORT_READ_LENGTH]
                    [--max-short-read-length MAX_SHORT_READ_LENGTH]
                    [--disable-adpater-trimming [DISABLE_ADAPTER_TRIMMING]]
                    [--unqualified-percent-limit UNQUALIFIED_PERCENT_LIMIT]
                    [--quality-cutoff QUALITY_CUTOFF]
                    [--extra-fastp-params EXTRA_FASTP_PARAMS]
                    [--skip-qc [SKIP_QC]] [--use-unicycler [USE_UNICYCLER]]
                    [--use-megahit [USE_MEGAHIT]] [--coassemble [yes|no]]
                    [--kmer-sizes KMER_SIZES [KMER_SIZES ...]]
                    [--min-cov-long MIN_COV_LONG]
                    [--min-cov-short MIN_COV_SHORT]
                    [--exclude-contig-cov EXCLUDE_CONTIG_COV]
                    [--exclude-contig-size EXCLUDE_CONTIG_SIZE]
                    [--include-contig-size INCLUDE_CONTIG_SIZE]
                    [-s MIN_CONTIG_SIZE] [-b MIN_BIN_SIZE]
                    [--semibin-model SEMIBIN_MODEL]
                    [--refinery-max-iterations REFINERY_MAX_ITERATIONS]
                    [--refinery-max-retries REFINERY_MAX_RETRIES]
                    [--extra-binners [{maxbin,maxbin2,concoct,comebin,taxvamb} ...]]
                    [--skip-binners [{rosella,semibin,metabat1,metabat2,metabat,vamb} ...]]
                    [--binning-only [BINNING_ONLY]]
                    [--skip-abundances [SKIP_ABUNDANCES]]
                    [--skip-taxonomy [SKIP_TAXONOMY]]
                    [--skip-singlem [SKIP_SINGLEM]] [--gtdb-path GTDB_PATH]
                    [--eggnog-db-path EGGNOG_DB_PATH]
                    [--singlem-metapackage-path SINGLEM_METAPACKAGE_PATH]
                    [--checkm2-db-path CHECKM2_DB_PATH] [--ani ANI]
                    [--precluster-ani PRECLUSTER_ANI]
                    [--precluster-method PRECLUSTER_METHOD]
                    [--min-completeness MIN_COMPLETENESS]
                    [--max-contamination MAX_CONTAMINATION]
                    [--use-checkm2-scores [USE_CHECKM2_SCORES]]
                    [--pggb-params PGGB_PARAMS] [-t MAX_THREADS]
                    [-p PPLACER_THREADS] [-n N_CORES] [-m MAX_MEMORY]
                    [--request-gpu [REQUEST_GPU]] [-o OUTPUT]
                    [--conda-prefix CONDA_PREFIX] [--tmpdir TMPDIR]
                    [--default-resources RESOURCES]
                    [--snakemake-profile SNAKEMAKE_PROFILE]
                    [--local-cores LOCAL_CORES]
                    [--cluster-retries CLUSTER_RETRIES] [--dry-run [DRYRUN]]
                    [--clean [CLEAN]] [--build [yes|no]]
                    [--download [{gtdb,eggnog,singlem,checkm2,metabuli} ...]]
                    [--rerun-triggers [{mtime,params,input,software-env,code} ...]]
                    [--snakemake-cmds CMDS] -f BATCH_FILE
                    [--write-script WRITE_SCRIPT] [--cluster [CLUSTER]]
                    [--cluster-ani-values [ANI_VALUES ...]]
                    [--min-percent-read-identity-long LONG_PERCENT_IDENTITY]
                    [--min-percent-read-identity-short SHORT_PERCENT_IDENTITY]
                    [--medaka-model {r103_fast_g507,r103_fast_snp_g507,r103_fast_variant_g507,r103_hac_g507,r103_hac_snp_g507,r103_hac_variant_g507,r103_min_high_g345,r103_min_high_g360,r103_prom_high_g360,r103_prom_snp_g3210,r103_prom_variant_g3210,r103_sup_g507,r103_sup_snp_g507,r103_sup_variant_g507,r1041_e82_260bps_fast_g632,r1041_e82_260bps_fast_variant_g632,r1041_e82_260bps_hac_g632,r1041_e82_260bps_hac_variant_g632,r1041_e82_260bps_sup_g632,r1041_e82_260bps_sup_variant_g632,r1041_e82_400bps_fast_g615,r1041_e82_400bps_fast_g632,r1041_e82_400bps_fast_variant_g615,r1041_e82_400bps_fast_variant_g632,r1041_e82_400bps_hac_g615,r1041_e82_400bps_hac_g632,r1041_e82_400bps_hac_variant_g615,r1041_e82_400bps_hac_variant_g632,r1041_e82_400bps_sup_g615,r1041_e82_400bps_sup_variant_g615,r104_e81_fast_g5015,r104_e81_fast_variant_g5015,r104_e81_hac_g5015,r104_e81_hac_variant_g5015,r104_e81_sup_g5015,r104_e81_sup_g610,r104_e81_sup_variant_g610,r10_min_high_g303,r10_min_high_g340,r941_e81_fast_g514,r941_e81_fast_variant_g514,r941_e81_hac_g514,r941_e81_hac_variant_g514,r941_e81_sup_g514,r941_e81_sup_variant_g514,r941_min_fast_g303,r941_min_fast_g507,r941_min_fast_snp_g507,r941_min_fast_variant_g507,r941_min_hac_g507,r941_min_hac_snp_g507,r941_min_hac_variant_g507,r941_min_high_g303,r941_min_high_g330,r941_min_high_g340_rle,r941_min_high_g344,r941_min_high_g351,r941_min_high_g360,r941_min_sup_g507,r941_min_sup_snp_g507,r941_min_sup_variant_g507,r941_prom_fast_g303,r941_prom_fast_g507,r941_prom_fast_snp_g507,r941_prom_fast_variant_g507,r941_prom_hac_g507,r941_prom_hac_snp_g507,r941_prom_hac_variant_g507,r941_prom_high_g303,r941_prom_high_g330,r941_prom_high_g344,r941_prom_high_g360,r941_prom_high_g4011,r941_prom_snp_g303,r941_prom_snp_g322,r941_prom_snp_g360,r941_prom_sup_g507,r941_prom_sup_snp_g507,r941_prom_sup_variant_g507,r941_prom_variant_g303,r941_prom_variant_g322,r941_prom_variant_g360,r941_sup_plant_g610,r941_sup_plant_variant_g610}]
                    [-w WORKFLOW [WORKFLOW ...]]

Performs all steps in the Aviary pipeline on a batch file. 
Each line in the batch file is processed separately and then 
clustered using aviary. 
(Assembly > Binning > Refinement > Annotation > Diversity) * n_samples --> Cluster

options:
  -h, --help            show this help message and exit
  -g [GOLD_STANDARD ...], --gold-standard-assembly [GOLD_STANDARD ...], --gold_standard_assembly [GOLD_STANDARD ...]
                        Gold standard assembly to compare either the Aviary assembly or a given input assembly against (default: ['none'])
  --gsa-mappings GSA_MAPPINGS, --gsa_mappings GSA_MAPPINGS
                        CAMI I & II GSA mappings (default: none)
  -r [REFERENCE_FILTER ...], --reference-filter [REFERENCE_FILTER ...], --reference_filter [REFERENCE_FILTER ...]
                        One or more reference filter files to aid in the assembly. Remove contaminant reads from the assembly. (default: ['none'])
  --min-read-size MIN_READ_SIZE, --min_read_size MIN_READ_SIZE
                        Minimum long read size when filtering using Filtlong (default: 100)
  --min-mean-q MIN_MEAN_Q, --min_mean_q MIN_MEAN_Q
                        Minimum long read mean quality threshold (default: 10)
  --keep-percent KEEP_PERCENT, --keep_percent KEEP_PERCENT
                        DEPRECATED: Percentage of reads passing quality thresholds kept by filtlong (default: 100)
  --min-short-read-length MIN_SHORT_READ_LENGTH, --min_short_read_length MIN_SHORT_READ_LENGTH
                        Minimum length of short reads to be kept (default: 15)
  --max-short-read-length MAX_SHORT_READ_LENGTH, --max_short_read_length MAX_SHORT_READ_LENGTH
                        Maximum length of short reads to be kept, 0 = no maximum
  --disable-adpater-trimming [DISABLE_ADAPTER_TRIMMING], --disable_adpater_trimming [DISABLE_ADAPTER_TRIMMING]
                        Disable adapter trimming of short reads
  --unqualified-percent-limit UNQUALIFIED_PERCENT_LIMIT, --unqualified_percent_limit UNQUALIFIED_PERCENT_LIMIT
                        how many percents of bases are allowed to be unqualified. Default 40 means 40 percent (default: 40)
  --quality-cutoff QUALITY_CUTOFF, --quality_cutoff QUALITY_CUTOFF
                        The short read quality value that a base is qualified. Default 15 means phred quality >=Q15 is qualified. (default: 15)
  --extra-fastp-params EXTRA_FASTP_PARAMS, --extra_fastp_params EXTRA_FASTP_PARAMS
                        Extra parameters to pass to fastp, supply as a single string e.g. --extra-fastp-params "-V -e 10"
  --skip-qc [SKIP_QC], --skip_qc [SKIP_QC]
                        Skip quality control steps
  --use-unicycler [USE_UNICYCLER], --use_unicycler [USE_UNICYCLER]
                        Use Unicycler to re-assemble the metaSPAdes hybrid assembly. Not recommended for complex metagenomes.
  --use-megahit [USE_MEGAHIT], --use_megahit [USE_MEGAHIT]
                        Specifies whether or not to use megahit if multiple for short-read only assembly
  --coassemble [yes|no], --co-assemble [yes|no], --co_assemble [yes|no]
                        Specifies whether or not, when given multiple input reads, to coassemble them. 
                        If False (no), Aviary will use the first set of short reads and first set of long reads to perform assembly 
                        All read files will still be used during the MAG recovery process for differential coverage.
  --kmer-sizes KMER_SIZES [KMER_SIZES ...], --kmer_sizes KMER_SIZES [KMER_SIZES ...], -k KMER_SIZES [KMER_SIZES ...]
                        Manually specify the kmer-sizes used by SPAdes during assembly. Space separated odd integer values and less than 128 or "auto" (default: ['auto'])
  --min-cov-long MIN_COV_LONG, --min_cov_long MIN_COV_LONG
                        Automatically include Flye contigs with long read coverage greater than or equal to this.  (default: 5)
                        High long read coverage during assembly indicates that the overlap layout consensus algorithm 
                        is more likely to be correct.
  --min-cov-short MIN_COV_SHORT, --min_cov_short MIN_COV_SHORT
                        Automatically include Flye contigs with short read coverage less than or equal to this.  (default: 5)
                        Low coverage via short reads indicates that metaSPAdes will not be able to better assemble this contig.
  --exclude-contig-cov EXCLUDE_CONTIG_COV, --exclude_contig_cov EXCLUDE_CONTIG_COV
                        Automatically exclude Flye contigs with long read coverage less than or equal to this  (default: 10)
                        and less than or equal to `--exclude-contig-size`
  --exclude-contig-size EXCLUDE_CONTIG_SIZE, --exclude_contig_size EXCLUDE_CONTIG_SIZE
                        Automatically exclude Flye contigs with length less than or equal to this  (default: 2500)
                        and long read coverage less than or equal to `--exclude-contig-cov`
  --include-contig-size INCLUDE_CONTIG_SIZE, --include_contig_size INCLUDE_CONTIG_SIZE
                        Automatically include Flye contigs with length greater than or equal to this (default: 10000)
  -s MIN_CONTIG_SIZE, --min-contig-size MIN_CONTIG_SIZE, --min_contig_size MIN_CONTIG_SIZE
                        Minimum contig size in base pairs to be considered for binning (default: 1500)
  -b MIN_BIN_SIZE, --min-bin-size MIN_BIN_SIZE, --min_bin_size MIN_BIN_SIZE
                        Minimum bin size in base pairs for a MAG (default: 200000)
  --semibin-model SEMIBIN_MODEL, --semibin_model SEMIBIN_MODEL
                        The environment model to passed to SemiBin. Can be one of:  (default: global)
                        human_gut, dog_gut, ocean, soil, cat_gut, human_oral, mouse_gut, pig_gut, built_environment, wastewater, global
  --refinery-max-iterations REFINERY_MAX_ITERATIONS, --refinery_max_iterations REFINERY_MAX_ITERATIONS
                        Maximum number of iterations for Rosella refinery. Set to 0 to skip refinery. Lower values will run faster but may result in lower quality MAGs. (default: 5)
  --refinery-max-retries REFINERY_MAX_RETRIES, --refinery_max_retries REFINERY_MAX_RETRIES
                        Maximum number of retries rosella uses to generate valid reclustering within a refinery iteration. Lower values will run faster but may result in lower quality MAGs. (default: 3)
  --extra-binners [{maxbin,maxbin2,concoct,comebin,taxvamb} ...], --extra_binners [{maxbin,maxbin2,concoct,comebin,taxvamb} ...], --extra-binner [{maxbin,maxbin2,concoct,comebin,taxvamb} ...], --extra_binner [{maxbin,maxbin2,concoct,comebin,taxvamb} ...]
                        Optional list of extra binning algorithms to run. Can be any combination of: 
                        maxbin, maxbin2, concoct, comebin, taxvamb 
                        These binners are skipped by default as they can have long runtimes 
                        N.B. specifying "maxbin" and "maxbin2" are equivalent 
                        N.B. specifying "taxvamb" will also run metabuli for contig taxonomic assignment 
  --skip-binners [{rosella,semibin,metabat1,metabat2,metabat,vamb} ...], --skip_binners [{rosella,semibin,metabat1,metabat2,metabat,vamb} ...], --skip_binner [{rosella,semibin,metabat1,metabat2,metabat,vamb} ...], --skip-binner [{rosella,semibin,metabat1,metabat2,metabat,vamb} ...]
                        Optional list of binning algorithms to skip. Can be any combination of: 
                        rosella, semibin, metabat1, metabat2, metabat, vamb 
                        N.B. specifying "metabat" will skip both MetaBAT1 and MetaBAT2. 
  --binning-only [BINNING_ONLY], --binning_only [BINNING_ONLY]
                        Only run up to the binning stage. Do not run SingleM, GTDB-tk, or CoverM
  --skip-abundances [SKIP_ABUNDANCES], --skip_abundances [SKIP_ABUNDANCES]
                        Skip CoverM post-binning abundance calculations.
  --skip-taxonomy [SKIP_TAXONOMY], --skip_taxonomy [SKIP_TAXONOMY]
                        Skip GTDB-tk post-binning taxonomy assignment.
  --skip-singlem [SKIP_SINGLEM], --skip_singlem [SKIP_SINGLEM]
                        Skip SingleM post-binning recovery assessment.
  --gtdb-path GTDB_PATH, --gtdb_path GTDB_PATH
                        Path to the local gtdb database files
  --eggnog-db-path EGGNOG_DB_PATH, --eggnog_db_path EGGNOG_DB_PATH
                        Path to the local eggnog database files
  --singlem-metapackage-path SINGLEM_METAPACKAGE_PATH, --singlem_metapackage_path SINGLEM_METAPACKAGE_PATH
                        Path to the local SingleM metapackage
  --checkm2-db-path CHECKM2_DB_PATH, --checkm2_db_path CHECKM2_DB_PATH
                        Path to Checkm2 Database
  --ani ANI             Overall ANI level to dereplicate at with FastANI. (default: 97)
  --precluster-ani PRECLUSTER_ANI, --precluster_ani PRECLUSTER_ANI
                        Require at least this dashing-derived ANI for preclustering and to avoid FastANI on distant lineages within preclusters. (default: 95)
  --precluster-method PRECLUSTER_METHOD, --precluster_method PRECLUSTER_METHOD
                        method of calculating rough ANI for dereplication. 'dashing' for HyperLogLog, 'finch' for finch MinHash. (default: dashing)
  --min-completeness MIN_COMPLETENESS, --min_completeness MIN_COMPLETENESS
                        Ignore genomes with less completeness than this percentage. (default: none)
  --max-contamination MAX_CONTAMINATION, --max_contamination MAX_CONTAMINATION
                        Ignore genomes with more contamination than this percentage. (default: none)
  --use-checkm2-scores [USE_CHECKM2_SCORES], --use_checkm2_scores [USE_CHECKM2_SCORES]
                        Use CheckM2 completeness and contamination scores (if available) to perform Galah dereplication
  --pggb-params PGGB_PARAMS, --pggb_params PGGB_PARAMS
                        Parameters to be used with pggb, must be surrounded by quotation marks e.g. '' (default: -k 79 -G 7919,8069)
  -t MAX_THREADS, --max-threads MAX_THREADS, --max_threads MAX_THREADS
                        Maximum number of threads given to any particular process. If max_threads > n_cores then n_cores will be bumped up to max_threads. Useful if you want more fine grain control over the number of threads used by each process. (default: 8)
  -p PPLACER_THREADS, --pplacer-threads PPLACER_THREADS, --pplacer_threads PPLACER_THREADS
                        The number of threads given to pplacer, values above `--max-threads` will be scaled to equal `--max-threads` (default: 8)
  -n N_CORES, --n-cores N_CORES, --n_cores N_CORES
                        Maximum number of cores available for use. Setting to multiples of max_threads will allow for multiple processes to be run in parallel. (default: 16)
  -m MAX_MEMORY, --max-memory MAX_MEMORY, --max_memory MAX_MEMORY
                        Maximum memory for available usage in Gigabytes (default: 250)
  --request-gpu [REQUEST_GPU], --request_gpu [REQUEST_GPU]
                        Request a GPU for use with the pipeline. This will only work if the pipeline is run on a cluster
  -o OUTPUT, --output OUTPUT
                        Output directory (default: ./)
  --conda-prefix CONDA_PREFIX, --conda_prefix CONDA_PREFIX
                        Path to the location of installed conda environments, or where to install new environments. 
                        Can be configured within the `configure` subcommand
  --tmpdir TMPDIR, --tempdir TMPDIR, --tmp-dir TMPDIR, --tmp_dir TMPDIR, --tmp TMPDIR, --temp TMPDIR, --temp-dir TMPDIR, --temp_dir TMPDIR
                        Path to the location that will be treated used for temporary files. If none is specified, the TMPDIR 
                        environment variable will be used. Can be configured within the `configure` subcommand
  --default-resources RESOURCES
                        Snakemake resources used as is found at: https://snakemake.readthedocs.io/en/stable/snakefiles/rules.html?highlight=resources#standard-resources  (default:  )
                        NOTE: tmpdir is handled by the `tmpdir` command line parameter. 
  --snakemake-profile SNAKEMAKE_PROFILE
                        Snakemake profile (see https://snakemake.readthedocs.io/en/stable/executing/cli.html#profiles)
                        Create profile as `~/.config/snakemake/[CLUSTER_PROFILE]/config.yaml`. 
                        Can be used to submit rules as jobs to cluster engine (see https://snakemake.readthedocs.io/en/stable/executing/cluster.html), 
                        requires cluster, cluster-status, jobs, cluster-cancel. 
  --local-cores LOCAL_CORES, --local_cores LOCAL_CORES
                        Maximum number of cores available for use locally. Only relevant if jobs are being submitted to a cluster (e.g. see `--snakemake-profile`), in which case `--n-cores` will restrict requested cores in submitted jobs. (default: 16)
  --cluster-retries CLUSTER_RETRIES
                        Number of times to retry a failed job when using cluster submission (see `--snakemake-profile`). 
  --dry-run [DRYRUN], --dry_run [DRYRUN], --dryrun [DRYRUN]
                        Perform snakemake dry run, tests workflow order and conda environments
  --clean [CLEAN]       Clean up all temporary files. This will remove most BAM files and any FASTQ files  (default: True)
                        generated from read filtering. Setting this to False is the equivalent of the --notemp 
                        option in snakemake. Useful for when running only part of a workflow as it avoids 
                        deleting files that would likely be needed in later parts of the workflow. 
                        NOTE: Not cleaning makes reruns faster but will incur the wrath of your sysadmin
  --build [yes|no]      Build conda environments necessary to run the pipeline, and then exit. Equivalent to "--snakemake-cmds '--conda-create-envs-only True ' ". Other inputs should be specified as if running normally so that the right set of conda environments is built. (default: no)
  --download [{gtdb,eggnog,singlem,checkm2,metabuli} ...], --download [{gtdb,eggnog,singlem,checkm2,metabuli} ...]
                        Downloads the requested GTDB, EggNOG, SingleM, CheckM2, & Metabuli databases
  --rerun-triggers [{mtime,params,input,software-env,code} ...], --rerun_triggers [{mtime,params,input,software-env,code} ...]
                        Specify which kinds of modifications will trigger rules to rerun (default: ['mtime'])
  --snakemake-cmds CMDS
                        Additional commands to supplied to snakemake in the form of a single string e.g. "--print-compilation True". 
                         NOTE: Most commands in snakemake -h are valid but some commands may clash with commands 
                         aviary directly supplies to snakemake. Please make sure your additional commands don't clash.
  -f BATCH_FILE, --batch_file BATCH_FILE, --batch-file BATCH_FILE
                        The tab or comma separated batch file containing the input samples to assemble and/or recover MAGs from. 
                        An example batch file can be found at https://rhysnewell.github.io/aviary/examples. The heading line is required. 
                        The number of reads provided to each sample is flexible as is the type of assembly being performed (if any). 
                        Multiple reads can be supplied by providing a comma-separated list (surrounded by double quotes "" if using a 
                        comma separated batch file) within the specific read column.
  --write-script WRITE_SCRIPT, --write_script WRITE_SCRIPT
                        Write the aviary batch Snakemake commands to a bash script and exit. 
                        Useful when submitting jobs to HPC cluster with custom queueing.
  --cluster [CLUSTER]   Cluster final output of all samples using aviary cluster if possible.
  --cluster-ani-values [ANI_VALUES ...], --cluster_ani_values [ANI_VALUES ...], --ani-values [ANI_VALUES ...], --ani_values [ANI_VALUES ...]
                        The range of ANI values to perform clustering and dereplication at during aviary cluster. (default: [0.99, 0.97, 0.95])
  --min-percent-read-identity-long LONG_PERCENT_IDENTITY, --min_percent_read_identity_long LONG_PERCENT_IDENTITY
                        Minimum percent read identity used by CoverM for long-readswhen calculating genome abundances. (default: 85)
  --min-percent-read-identity-short SHORT_PERCENT_IDENTITY, --min_percent_read_identity_short SHORT_PERCENT_IDENTITY
                        Minimum percent read identity used by CoverM for short-reads  (default: 95)
                        when calculating genome abundances.
  --medaka-model {r103_fast_g507,r103_fast_snp_g507,r103_fast_variant_g507,r103_hac_g507,r103_hac_snp_g507,r103_hac_variant_g507,r103_min_high_g345,r103_min_high_g360,r103_prom_high_g360,r103_prom_snp_g3210,r103_prom_variant_g3210,r103_sup_g507,r103_sup_snp_g507,r103_sup_variant_g507,r1041_e82_260bps_fast_g632,r1041_e82_260bps_fast_variant_g632,r1041_e82_260bps_hac_g632,r1041_e82_260bps_hac_variant_g632,r1041_e82_260bps_sup_g632,r1041_e82_260bps_sup_variant_g632,r1041_e82_400bps_fast_g615,r1041_e82_400bps_fast_g632,r1041_e82_400bps_fast_variant_g615,r1041_e82_400bps_fast_variant_g632,r1041_e82_400bps_hac_g615,r1041_e82_400bps_hac_g632,r1041_e82_400bps_hac_variant_g615,r1041_e82_400bps_hac_variant_g632,r1041_e82_400bps_sup_g615,r1041_e82_400bps_sup_variant_g615,r104_e81_fast_g5015,r104_e81_fast_variant_g5015,r104_e81_hac_g5015,r104_e81_hac_variant_g5015,r104_e81_sup_g5015,r104_e81_sup_g610,r104_e81_sup_variant_g610,r10_min_high_g303,r10_min_high_g340,r941_e81_fast_g514,r941_e81_fast_variant_g514,r941_e81_hac_g514,r941_e81_hac_variant_g514,r941_e81_sup_g514,r941_e81_sup_variant_g514,r941_min_fast_g303,r941_min_fast_g507,r941_min_fast_snp_g507,r941_min_fast_variant_g507,r941_min_hac_g507,r941_min_hac_snp_g507,r941_min_hac_variant_g507,r941_min_high_g303,r941_min_high_g330,r941_min_high_g340_rle,r941_min_high_g344,r941_min_high_g351,r941_min_high_g360,r941_min_sup_g507,r941_min_sup_snp_g507,r941_min_sup_variant_g507,r941_prom_fast_g303,r941_prom_fast_g507,r941_prom_fast_snp_g507,r941_prom_fast_variant_g507,r941_prom_hac_g507,r941_prom_hac_snp_g507,r941_prom_hac_variant_g507,r941_prom_high_g303,r941_prom_high_g330,r941_prom_high_g344,r941_prom_high_g360,r941_prom_high_g4011,r941_prom_snp_g303,r941_prom_snp_g322,r941_prom_snp_g360,r941_prom_sup_g507,r941_prom_sup_snp_g507,r941_prom_sup_variant_g507,r941_prom_variant_g303,r941_prom_variant_g322,r941_prom_variant_g360,r941_sup_plant_g610,r941_sup_plant_variant_g610}, --medaka_model {r103_fast_g507,r103_fast_snp_g507,r103_fast_variant_g507,r103_hac_g507,r103_hac_snp_g507,r103_hac_variant_g507,r103_min_high_g345,r103_min_high_g360,r103_prom_high_g360,r103_prom_snp_g3210,r103_prom_variant_g3210,r103_sup_g507,r103_sup_snp_g507,r103_sup_variant_g507,r1041_e82_260bps_fast_g632,r1041_e82_260bps_fast_variant_g632,r1041_e82_260bps_hac_g632,r1041_e82_260bps_hac_variant_g632,r1041_e82_260bps_sup_g632,r1041_e82_260bps_sup_variant_g632,r1041_e82_400bps_fast_g615,r1041_e82_400bps_fast_g632,r1041_e82_400bps_fast_variant_g615,r1041_e82_400bps_fast_variant_g632,r1041_e82_400bps_hac_g615,r1041_e82_400bps_hac_g632,r1041_e82_400bps_hac_variant_g615,r1041_e82_400bps_hac_variant_g632,r1041_e82_400bps_sup_g615,r1041_e82_400bps_sup_variant_g615,r104_e81_fast_g5015,r104_e81_fast_variant_g5015,r104_e81_hac_g5015,r104_e81_hac_variant_g5015,r104_e81_sup_g5015,r104_e81_sup_g610,r104_e81_sup_variant_g610,r10_min_high_g303,r10_min_high_g340,r941_e81_fast_g514,r941_e81_fast_variant_g514,r941_e81_hac_g514,r941_e81_hac_variant_g514,r941_e81_sup_g514,r941_e81_sup_variant_g514,r941_min_fast_g303,r941_min_fast_g507,r941_min_fast_snp_g507,r941_min_fast_variant_g507,r941_min_hac_g507,r941_min_hac_snp_g507,r941_min_hac_variant_g507,r941_min_high_g303,r941_min_high_g330,r941_min_high_g340_rle,r941_min_high_g344,r941_min_high_g351,r941_min_high_g360,r941_min_sup_g507,r941_min_sup_snp_g507,r941_min_sup_variant_g507,r941_prom_fast_g303,r941_prom_fast_g507,r941_prom_fast_snp_g507,r941_prom_fast_variant_g507,r941_prom_hac_g507,r941_prom_hac_snp_g507,r941_prom_hac_variant_g507,r941_prom_high_g303,r941_prom_high_g330,r941_prom_high_g344,r941_prom_high_g360,r941_prom_high_g4011,r941_prom_snp_g303,r941_prom_snp_g322,r941_prom_snp_g360,r941_prom_sup_g507,r941_prom_sup_snp_g507,r941_prom_sup_variant_g507,r941_prom_variant_g303,r941_prom_variant_g322,r941_prom_variant_g360,r941_sup_plant_g610,r941_sup_plant_variant_g610}
                        Medaka model to use for polishing long reads.  (default: r941_min_hac_g507)
  -w WORKFLOW [WORKFLOW ...], --workflow WORKFLOW [WORKFLOW ...]
                        Main workflow (snakemake target rule) to run for each sample (default: ['get_bam_indices', 'recover_mags', 'annotate', 'lorikeet'])

                                                      ......:::::: BATCH ::::::......

                                             aviary batch -f batch_file.tsv -t 32 -o batch_test
                                             
                                             An example batch file can be found at: https://rhysnewell.github.io/aviary/examples
```


## aviary_isolate

### Tool Description
Step-down hybrid assembly using long and short reads, or assembly using only short or long reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/aviary:0.12.0--pyhdfd78af_0
- **Homepage**: https://github.com/rhysnewell/aviary/
- **Package**: https://anaconda.org/channels/bioconda/packages/aviary/overview
- **Validation**: PASS

### Original Help Text
```text
usage: aviary isolate [-h] [-g [GOLD_STANDARD ...]]
                      [--gsa-mappings GSA_MAPPINGS]
                      [-r [REFERENCE_FILTER ...]]
                      [--min-read-size MIN_READ_SIZE]
                      [--min-mean-q MIN_MEAN_Q] [--keep-percent KEEP_PERCENT]
                      [--min-short-read-length MIN_SHORT_READ_LENGTH]
                      [--max-short-read-length MAX_SHORT_READ_LENGTH]
                      [--disable-adpater-trimming [DISABLE_ADAPTER_TRIMMING]]
                      [--unqualified-percent-limit UNQUALIFIED_PERCENT_LIMIT]
                      [--quality-cutoff QUALITY_CUTOFF]
                      [--extra-fastp-params EXTRA_FASTP_PARAMS]
                      [--skip-qc [SKIP_QC]] [-1 [PE1 ...]] [-2 [PE2 ...]]
                      [-i [INTERLEAVED ...]] [-c [COUPLED ...]]
                      [--min-percent-read-identity-short SHORT_PERCENT_IDENTITY]
                      [-l [LONGREADS ...]] [-z {ont,ont_hq,rs,sq,ccs,hifi}]
                      [--medaka-model {r103_fast_g507,r103_fast_snp_g507,r103_fast_variant_g507,r103_hac_g507,r103_hac_snp_g507,r103_hac_variant_g507,r103_min_high_g345,r103_min_high_g360,r103_prom_high_g360,r103_prom_snp_g3210,r103_prom_variant_g3210,r103_sup_g507,r103_sup_snp_g507,r103_sup_variant_g507,r1041_e82_260bps_fast_g632,r1041_e82_260bps_fast_variant_g632,r1041_e82_260bps_hac_g632,r1041_e82_260bps_hac_variant_g632,r1041_e82_260bps_sup_g632,r1041_e82_260bps_sup_variant_g632,r1041_e82_400bps_fast_g615,r1041_e82_400bps_fast_g632,r1041_e82_400bps_fast_variant_g615,r1041_e82_400bps_fast_variant_g632,r1041_e82_400bps_hac_g615,r1041_e82_400bps_hac_g632,r1041_e82_400bps_hac_variant_g615,r1041_e82_400bps_hac_variant_g632,r1041_e82_400bps_sup_g615,r1041_e82_400bps_sup_variant_g615,r104_e81_fast_g5015,r104_e81_fast_variant_g5015,r104_e81_hac_g5015,r104_e81_hac_variant_g5015,r104_e81_sup_g5015,r104_e81_sup_g610,r104_e81_sup_variant_g610,r10_min_high_g303,r10_min_high_g340,r941_e81_fast_g514,r941_e81_fast_variant_g514,r941_e81_hac_g514,r941_e81_hac_variant_g514,r941_e81_sup_g514,r941_e81_sup_variant_g514,r941_min_fast_g303,r941_min_fast_g507,r941_min_fast_snp_g507,r941_min_fast_variant_g507,r941_min_hac_g507,r941_min_hac_snp_g507,r941_min_hac_variant_g507,r941_min_high_g303,r941_min_high_g330,r941_min_high_g340_rle,r941_min_high_g344,r941_min_high_g351,r941_min_high_g360,r941_min_sup_g507,r941_min_sup_snp_g507,r941_min_sup_variant_g507,r941_prom_fast_g303,r941_prom_fast_g507,r941_prom_fast_snp_g507,r941_prom_fast_variant_g507,r941_prom_hac_g507,r941_prom_hac_snp_g507,r941_prom_hac_variant_g507,r941_prom_high_g303,r941_prom_high_g330,r941_prom_high_g344,r941_prom_high_g360,r941_prom_high_g4011,r941_prom_snp_g303,r941_prom_snp_g322,r941_prom_snp_g360,r941_prom_sup_g507,r941_prom_sup_snp_g507,r941_prom_sup_variant_g507,r941_prom_variant_g303,r941_prom_variant_g322,r941_prom_variant_g360,r941_sup_plant_g610,r941_sup_plant_variant_g610}]
                      [--min-percent-read-identity-long LONG_PERCENT_IDENTITY]
                      [--guppy-model GUPPY_MODEL] [--genome-size GENOME_SIZE]
                      [-s MIN_CONTIG_SIZE] [-b MIN_BIN_SIZE]
                      [--semibin-model SEMIBIN_MODEL]
                      [--refinery-max-iterations REFINERY_MAX_ITERATIONS]
                      [--refinery-max-retries REFINERY_MAX_RETRIES]
                      [--extra-binners [{maxbin,maxbin2,concoct,comebin,taxvamb} ...]]
                      [--skip-binners [{rosella,semibin,metabat1,metabat2,metabat,vamb} ...]]
                      [--binning-only [BINNING_ONLY]]
                      [--skip-abundances [SKIP_ABUNDANCES]]
                      [--skip-taxonomy [SKIP_TAXONOMY]]
                      [--skip-singlem [SKIP_SINGLEM]] [--gtdb-path GTDB_PATH]
                      [--eggnog-db-path EGGNOG_DB_PATH]
                      [--singlem-metapackage-path SINGLEM_METAPACKAGE_PATH]
                      [--checkm2-db-path CHECKM2_DB_PATH] [-t MAX_THREADS]
                      [-p PPLACER_THREADS] [-n N_CORES] [-m MAX_MEMORY]
                      [--request-gpu [REQUEST_GPU]] [-o OUTPUT]
                      [--conda-prefix CONDA_PREFIX] [--tmpdir TMPDIR]
                      [--default-resources RESOURCES]
                      [--snakemake-profile SNAKEMAKE_PROFILE]
                      [--local-cores LOCAL_CORES]
                      [--cluster-retries CLUSTER_RETRIES] [--dry-run [DRYRUN]]
                      [--clean [CLEAN]] [--build [yes|no]]
                      [--download [{gtdb,eggnog,singlem,checkm2,metabuli} ...]]
                      [--rerun-triggers [{mtime,params,input,software-env,code} ...]]
                      [--snakemake-cmds CMDS] [-w WORKFLOW [WORKFLOW ...]]

Step-down hybrid assembly using long and short reads, or assembly using only short or long reads.

options:
  -h, --help            show this help message and exit
  -g [GOLD_STANDARD ...], --gold-standard-assembly [GOLD_STANDARD ...], --gold_standard_assembly [GOLD_STANDARD ...]
                        Gold standard assembly to compare either the Aviary assembly or a given input assembly against (default: ['none'])
  --gsa-mappings GSA_MAPPINGS, --gsa_mappings GSA_MAPPINGS
                        CAMI I & II GSA mappings (default: none)
  -r [REFERENCE_FILTER ...], --reference-filter [REFERENCE_FILTER ...], --reference_filter [REFERENCE_FILTER ...]
                        One or more reference filter files to aid in the assembly. Remove contaminant reads from the assembly. (default: ['none'])
  --min-read-size MIN_READ_SIZE, --min_read_size MIN_READ_SIZE
                        Minimum long read size when filtering using Filtlong (default: 100)
  --min-mean-q MIN_MEAN_Q, --min_mean_q MIN_MEAN_Q
                        Minimum long read mean quality threshold (default: 10)
  --keep-percent KEEP_PERCENT, --keep_percent KEEP_PERCENT
                        DEPRECATED: Percentage of reads passing quality thresholds kept by filtlong (default: 100)
  --min-short-read-length MIN_SHORT_READ_LENGTH, --min_short_read_length MIN_SHORT_READ_LENGTH
                        Minimum length of short reads to be kept (default: 15)
  --max-short-read-length MAX_SHORT_READ_LENGTH, --max_short_read_length MAX_SHORT_READ_LENGTH
                        Maximum length of short reads to be kept, 0 = no maximum
  --disable-adpater-trimming [DISABLE_ADAPTER_TRIMMING], --disable_adpater_trimming [DISABLE_ADAPTER_TRIMMING]
                        Disable adapter trimming of short reads
  --unqualified-percent-limit UNQUALIFIED_PERCENT_LIMIT, --unqualified_percent_limit UNQUALIFIED_PERCENT_LIMIT
                        how many percents of bases are allowed to be unqualified. Default 40 means 40 percent (default: 40)
  --quality-cutoff QUALITY_CUTOFF, --quality_cutoff QUALITY_CUTOFF
                        The short read quality value that a base is qualified. Default 15 means phred quality >=Q15 is qualified. (default: 15)
  --extra-fastp-params EXTRA_FASTP_PARAMS, --extra_fastp_params EXTRA_FASTP_PARAMS
                        Extra parameters to pass to fastp, supply as a single string e.g. --extra-fastp-params "-V -e 10"
  --skip-qc [SKIP_QC], --skip_qc [SKIP_QC]
                        Skip quality control steps
  -1 [PE1 ...], --pe-1 [PE1 ...], --paired-reads-1 [PE1 ...], --paired_reads_1 [PE1 ...], --pe1 [PE1 ...]
                        A space separated list of forwards read files  (default: none)
                        NOTE: If performing assembly and multiple files are provided then only the first file will be used for assembly. 
                              If no longreads are provided then all samples will be co-assembled 
                              with megahit or metaspades depending on the --coassemble parameter
  -2 [PE2 ...], --pe-2 [PE2 ...], --paired-reads-2 [PE2 ...], --paired_reads_2 [PE2 ...], --pe2 [PE2 ...]
                        A space separated list of reverse read files  (default: none)
                        NOTE: If performing assembly and multiple files are provided then only the first file will be used for assembly. 
                              If no longreads are provided then all samples will be co-assembled 
                              with megahit or metaspades depending on the --coassemble parameter
  -i [INTERLEAVED ...], --interleaved [INTERLEAVED ...]
                        A space separated list of interleaved read files  (default: none)
                        NOTE: If performing assembly and multiple files are provided then only the first file will be used for assembly. 
                              If no longreads are provided then all samples will be co-assembled 
                              with megahit or metaspades depending on the --coassemble parameter
  -c [COUPLED ...], --coupled [COUPLED ...]
                        Forward and reverse read files in a coupled space separated list.  (default: none)
                        NOTE: If performing assembly and multiple files are provided then only the first file will be used for assembly. 
                              If no longreads are provided then all samples will be co-assembled 
                              with megahit or metaspades depending on the --coassemble parameter
  --min-percent-read-identity-short SHORT_PERCENT_IDENTITY, --min_percent_read_identity_short SHORT_PERCENT_IDENTITY
                        Minimum percent read identity used by CoverM for short-reads  (default: 95)
                        when calculating genome abundances.
  -l [LONGREADS ...], --longreads [LONGREADS ...], --long-reads [LONGREADS ...], --long_reads [LONGREADS ...]
                        A space separated list of long-read read files. NOTE: The first file will be used for assembly unless --coassemble is set to True. Then all files will be used. (default: none)
  -z {ont,ont_hq,rs,sq,ccs,hifi}, --longread-type {ont,ont_hq,rs,sq,ccs,hifi}, --longread_type {ont,ont_hq,rs,sq,ccs,hifi}, --long_read_type {ont,ont_hq,rs,sq,ccs,hifi}, --long-read-type {ont,ont_hq,rs,sq,ccs,hifi}
                        Whether the sequencing platform and technology for the longreads.  (default: ont)
                        "rs" for PacBio RSII, "sq" for PacBio Sequel, "ccs" for PacBio CCS, "hifi" for PacBio HiFi 
                        reads, "ont" for Oxford Nanopore and "ont_hq" for Oxford Nanopore high quality reads (Guppy5+ or Q20) 
  --medaka-model {r103_fast_g507,r103_fast_snp_g507,r103_fast_variant_g507,r103_hac_g507,r103_hac_snp_g507,r103_hac_variant_g507,r103_min_high_g345,r103_min_high_g360,r103_prom_high_g360,r103_prom_snp_g3210,r103_prom_variant_g3210,r103_sup_g507,r103_sup_snp_g507,r103_sup_variant_g507,r1041_e82_260bps_fast_g632,r1041_e82_260bps_fast_variant_g632,r1041_e82_260bps_hac_g632,r1041_e82_260bps_hac_variant_g632,r1041_e82_260bps_sup_g632,r1041_e82_260bps_sup_variant_g632,r1041_e82_400bps_fast_g615,r1041_e82_400bps_fast_g632,r1041_e82_400bps_fast_variant_g615,r1041_e82_400bps_fast_variant_g632,r1041_e82_400bps_hac_g615,r1041_e82_400bps_hac_g632,r1041_e82_400bps_hac_variant_g615,r1041_e82_400bps_hac_variant_g632,r1041_e82_400bps_sup_g615,r1041_e82_400bps_sup_variant_g615,r104_e81_fast_g5015,r104_e81_fast_variant_g5015,r104_e81_hac_g5015,r104_e81_hac_variant_g5015,r104_e81_sup_g5015,r104_e81_sup_g610,r104_e81_sup_variant_g610,r10_min_high_g303,r10_min_high_g340,r941_e81_fast_g514,r941_e81_fast_variant_g514,r941_e81_hac_g514,r941_e81_hac_variant_g514,r941_e81_sup_g514,r941_e81_sup_variant_g514,r941_min_fast_g303,r941_min_fast_g507,r941_min_fast_snp_g507,r941_min_fast_variant_g507,r941_min_hac_g507,r941_min_hac_snp_g507,r941_min_hac_variant_g507,r941_min_high_g303,r941_min_high_g330,r941_min_high_g340_rle,r941_min_high_g344,r941_min_high_g351,r941_min_high_g360,r941_min_sup_g507,r941_min_sup_snp_g507,r941_min_sup_variant_g507,r941_prom_fast_g303,r941_prom_fast_g507,r941_prom_fast_snp_g507,r941_prom_fast_variant_g507,r941_prom_hac_g507,r941_prom_hac_snp_g507,r941_prom_hac_variant_g507,r941_prom_high_g303,r941_prom_high_g330,r941_prom_high_g344,r941_prom_high_g360,r941_prom_high_g4011,r941_prom_snp_g303,r941_prom_snp_g322,r941_prom_snp_g360,r941_prom_sup_g507,r941_prom_sup_snp_g507,r941_prom_sup_variant_g507,r941_prom_variant_g303,r941_prom_variant_g322,r941_prom_variant_g360,r941_sup_plant_g610,r941_sup_plant_variant_g610}, --medaka_model {r103_fast_g507,r103_fast_snp_g507,r103_fast_variant_g507,r103_hac_g507,r103_hac_snp_g507,r103_hac_variant_g507,r103_min_high_g345,r103_min_high_g360,r103_prom_high_g360,r103_prom_snp_g3210,r103_prom_variant_g3210,r103_sup_g507,r103_sup_snp_g507,r103_sup_variant_g507,r1041_e82_260bps_fast_g632,r1041_e82_260bps_fast_variant_g632,r1041_e82_260bps_hac_g632,r1041_e82_260bps_hac_variant_g632,r1041_e82_260bps_sup_g632,r1041_e82_260bps_sup_variant_g632,r1041_e82_400bps_fast_g615,r1041_e82_400bps_fast_g632,r1041_e82_400bps_fast_variant_g615,r1041_e82_400bps_fast_variant_g632,r1041_e82_400bps_hac_g615,r1041_e82_400bps_hac_g632,r1041_e82_400bps_hac_variant_g615,r1041_e82_400bps_hac_variant_g632,r1041_e82_400bps_sup_g615,r1041_e82_400bps_sup_variant_g615,r104_e81_fast_g5015,r104_e81_fast_variant_g5015,r104_e81_hac_g5015,r104_e81_hac_variant_g5015,r104_e81_sup_g5015,r104_e81_sup_g610,r104_e81_sup_variant_g610,r10_min_high_g303,r10_min_high_g340,r941_e81_fast_g514,r941_e81_fast_variant_g514,r941_e81_hac_g514,r941_e81_hac_variant_g514,r941_e81_sup_g514,r941_e81_sup_variant_g514,r941_min_fast_g303,r941_min_fast_g507,r941_min_fast_snp_g507,r941_min_fast_variant_g507,r941_min_hac_g507,r941_min_hac_snp_g507,r941_min_hac_variant_g507,r941_min_high_g303,r941_min_high_g330,r941_min_high_g340_rle,r941_min_high_g344,r941_min_high_g351,r941_min_high_g360,r941_min_sup_g507,r941_min_sup_snp_g507,r941_min_sup_variant_g507,r941_prom_fast_g303,r941_prom_fast_g507,r941_prom_fast_snp_g507,r941_prom_fast_variant_g507,r941_prom_hac_g507,r941_prom_hac_snp_g507,r941_prom_hac_variant_g507,r941_prom_high_g303,r941_prom_high_g330,r941_prom_high_g344,r941_prom_high_g360,r941_prom_high_g4011,r941_prom_snp_g303,r941_prom_snp_g322,r941_prom_snp_g360,r941_prom_sup_g507,r941_prom_sup_snp_g507,r941_prom_sup_variant_g507,r941_prom_variant_g303,r941_prom_variant_g322,r941_prom_variant_g360,r941_sup_plant_g610,r941_sup_plant_variant_g610}
                        Medaka model to use for polishing long reads.  (default: r941_min_hac_g507)
  --min-percent-read-identity-long LONG_PERCENT_IDENTITY, --min_percent_read_identity_long LONG_PERCENT_IDENTITY
                        Minimum percent read identity used by CoverM for long-readswhen calculating genome abundances. (default: 85)
  --guppy-model GUPPY_MODEL, --guppy_model GUPPY_MODEL
                        The guppy model used by medaka to perform polishing (default: r941_min_high_g360)
  --genome-size GENOME_SIZE, --genome_size GENOME_SIZE
                        Approximate size of the isolate genome to be assembled (default: 5000000)
  -s MIN_CONTIG_SIZE, --min-contig-size MIN_CONTIG_SIZE, --min_contig_size MIN_CONTIG_SIZE
                        Minimum contig size in base pairs to be considered for binning (default: 1500)
  -b MIN_BIN_SIZE, --min-bin-size MIN_BIN_SIZE, --min_bin_size MIN_BIN_SIZE
                        Minimum bin size in base pairs for a MAG (default: 200000)
  --semibin-model SEMIBIN_MODEL, --semibin_model SEMIBIN_MODEL
                        The environment model to passed to SemiBin. Can be one of:  (default: global)
                        human_gut, dog_gut, ocean, soil, cat_gut, human_oral, mouse_gut, pig_gut, built_environment, wastewater, global
  --refinery-max-iterations REFINERY_MAX_ITERATIONS, --refinery_max_iterations REFINERY_MAX_ITERATIONS
                        Maximum number of iterations for Rosella refinery. Set to 0 to skip refinery. Lower values will run faster but may result in lower quality MAGs. (default: 5)
  --refinery-max-retries REFINERY_MAX_RETRIES, --refinery_max_retries REFINERY_MAX_RETRIES
                        Maximum number of retries rosella uses to generate valid reclustering within a refinery iteration. Lower values will run faster but may result in lower quality MAGs. (default: 3)
  --extra-binners [{maxbin,maxbin2,concoct,comebin,taxvamb} ...], --extra_binners [{maxbin,maxbin2,concoct,comebin,taxvamb} ...], --extra-binner [{maxbin,maxbin2,concoct,comebin,taxvamb} ...], --extra_binner [{maxbin,maxbin2,concoct,comebin,taxvamb} ...]
                        Optional list of extra binning algorithms to run. Can be any combination of: 
                        maxbin, maxbin2, concoct, comebin, taxvamb 
                        These binners are skipped by default as they can have long runtimes 
                        N.B. specifying "maxbin" and "maxbin2" are equivalent 
                        N.B. specifying "taxvamb" will also run metabuli for contig taxonomic assignment 
  --skip-binners [{rosella,semibin,metabat1,metabat2,metabat,vamb} ...], --skip_binners [{rosella,semibin,metabat1,metabat2,metabat,vamb} ...], --skip_binner [{rosella,semibin,metabat1,metabat2,metabat,vamb} ...], --skip-binner [{rosella,semibin,metabat1,metabat2,metabat,vamb} ...]
                        Optional list of binning algorithms to skip. Can be any combination of: 
                        rosella, semibin, metabat1, metabat2, metabat, vamb 
                        N.B. specifying "metabat" will skip both MetaBAT1 and MetaBAT2. 
  --binning-only [BINNING_ONLY], --binning_only [BINNING_ONLY]
                        Only run up to the binning stage. Do not run SingleM, GTDB-tk, or CoverM
  --skip-abundances [SKIP_ABUNDANCES], --skip_abundances [SKIP_ABUNDANCES]
                        Skip CoverM post-binning abundance calculations.
  --skip-taxonomy [SKIP_TAXONOMY], --skip_taxonomy [SKIP_TAXONOMY]
                        Skip GTDB-tk post-binning taxonomy assignment.
  --skip-singlem [SKIP_SINGLEM], --skip_singlem [SKIP_SINGLEM]
                        Skip SingleM post-binning recovery assessment.
  --gtdb-path GTDB_PATH, --gtdb_path GTDB_PATH
                        Path to the local gtdb database files
  --eggnog-db-path EGGNOG_DB_PATH, --eggnog_db_path EGGNOG_DB_PATH
                        Path to the local eggnog database files
  --singlem-metapackage-path SINGLEM_METAPACKAGE_PATH, --singlem_metapackage_path SINGLEM_METAPACKAGE_PATH
                        Path to the local SingleM metapackage
  --checkm2-db-path CHECKM2_DB_PATH, --checkm2_db_path CHECKM2_DB_PATH
                        Path to Checkm2 Database
  -t MAX_THREADS, --max-threads MAX_THREADS, --max_threads MAX_THREADS
                        Maximum number of threads given to any particular process. If max_threads > n_cores then n_cores will be bumped up to max_threads. Useful if you want more fine grain control over the number of threads used by each process. (default: 8)
  -p PPLACER_THREADS, --pplacer-threads PPLACER_THREADS, --pplacer_threads PPLACER_THREADS
                        The number of threads given to pplacer, values above `--max-threads` will be scaled to equal `--max-threads` (default: 8)
  -n N_CORES, --n-cores N_CORES, --n_cores N_CORES
                        Maximum number of cores available for use. Setting to multiples of max_threads will allow for multiple processes to be run in parallel. (default: 16)
  -m MAX_MEMORY, --max-memory MAX_MEMORY, --max_memory MAX_MEMORY
                        Maximum memory for available usage in Gigabytes (default: 250)
  --request-gpu [REQUEST_GPU], --request_gpu [REQUEST_GPU]
                        Request a GPU for use with the pipeline. This will only work if the pipeline is run on a cluster
  -o OUTPUT, --output OUTPUT
                        Output directory (default: ./)
  --conda-prefix CONDA_PREFIX, --conda_prefix CONDA_PREFIX
                        Path to the location of installed conda environments, or where to install new environments. 
                        Can be configured within the `configure` subcommand
  --tmpdir TMPDIR, --tempdir TMPDIR, --tmp-dir TMPDIR, --tmp_dir TMPDIR, --tmp TMPDIR, --temp TMPDIR, --temp-dir TMPDIR, --temp_dir TMPDIR
                        Path to the location that will be treated used for temporary files. If none is specified, the TMPDIR 
                        environment variable will be used. Can be configured within the `configure` subcommand
  --default-resources RESOURCES
                        Snakemake resources used as is found at: https://snakemake.readthedocs.io/en/stable/snakefiles/rules.html?highlight=resources#standard-resources  (default:  )
                        NOTE: tmpdir is handled by the `tmpdir` command line parameter. 
  --snakemake-profile SNAKEMAKE_PROFILE
                        Snakemake profile (see https://snakemake.readthedocs.io/en/stable/executing/cli.html#profiles)
                        Create profile as `~/.config/snakemake/[CLUSTER_PROFILE]/config.yaml`. 
                        Can be used to submit rules as jobs to cluster engine (see https://snakemake.readthedocs.io/en/stable/executing/cluster.html), 
                        requires cluster, cluster-status, jobs, cluster-cancel. 
  --local-cores LOCAL_CORES, --local_cores LOCAL_CORES
                        Maximum number of cores available for use locally. Only relevant if jobs are being submitted to a cluster (e.g. see `--snakemake-profile`), in which case `--n-cores` will restrict requested cores in submitted jobs. (default: 16)
  --cluster-retries CLUSTER_RETRIES
                        Number of times to retry a failed job when using cluster submission (see `--snakemake-profile`). 
  --dry-run [DRYRUN], --dry_run [DRYRUN], --dryrun [DRYRUN]
                        Perform snakemake dry run, tests workflow order and conda environments
  --clean [CLEAN]       Clean up all temporary files. This will remove most BAM files and any FASTQ files  (default: True)
                        generated from read filtering. Setting this to False is the equivalent of the --notemp 
                        option in snakemake. Useful for when running only part of a workflow as it avoids 
                        deleting files that would likely be needed in later parts of the workflow. 
                        NOTE: Not cleaning makes reruns faster but will incur the wrath of your sysadmin
  --build [yes|no]      Build conda environments necessary to run the pipeline, and then exit. Equivalent to "--snakemake-cmds '--conda-create-envs-only True ' ". Other inputs should be specified as if running normally so that the right set of conda environments is built. (default: no)
  --download [{gtdb,eggnog,singlem,checkm2,metabuli} ...], --download [{gtdb,eggnog,singlem,checkm2,metabuli} ...]
                        Downloads the requested GTDB, EggNOG, SingleM, CheckM2, & Metabuli databases
  --rerun-triggers [{mtime,params,input,software-env,code} ...], --rerun_triggers [{mtime,params,input,software-env,code} ...]
                        Specify which kinds of modifications will trigger rules to rerun (default: ['mtime'])
  --snakemake-cmds CMDS
                        Additional commands to supplied to snakemake in the form of a single string e.g. "--print-compilation True". 
                         NOTE: Most commands in snakemake -h are valid but some commands may clash with commands 
                         aviary directly supplies to snakemake. Please make sure your additional commands don't clash.
  -w WORKFLOW [WORKFLOW ...], --workflow WORKFLOW [WORKFLOW ...]
                        Main workflow to run. This is the snakemake target rule to run. (default: ['circlator'])

                                                                             ......:::::: ISOLATE ::::::......
                                 
                                             aviary isolate -1 *.1.fq.gz -2 *.2.fq.gz --longreads *.nanopore.fastq.gz --long_read_type ont
```


## aviary_configure

### Tool Description
Sets the conda environment variables for future runs and downloads databases.

### Metadata
- **Docker Image**: quay.io/biocontainers/aviary:0.12.0--pyhdfd78af_0
- **Homepage**: https://github.com/rhysnewell/aviary/
- **Package**: https://anaconda.org/channels/bioconda/packages/aviary/overview
- **Validation**: PASS

### Original Help Text
```text
usage: aviary configure [-h] [-t MAX_THREADS] [-p PPLACER_THREADS]
                        [-n N_CORES] [-m MAX_MEMORY]
                        [--request-gpu [REQUEST_GPU]] [-o OUTPUT]
                        [--conda-prefix CONDA_PREFIX] [--tmpdir TMPDIR]
                        [--default-resources RESOURCES]
                        [--snakemake-profile SNAKEMAKE_PROFILE]
                        [--local-cores LOCAL_CORES]
                        [--cluster-retries CLUSTER_RETRIES]
                        [--dry-run [DRYRUN]] [--clean [CLEAN]]
                        [--build [yes|no]]
                        [--download [{gtdb,eggnog,singlem,checkm2,metabuli} ...]]
                        [--rerun-triggers [{mtime,params,input,software-env,code} ...]]
                        [--snakemake-cmds CMDS] [--gtdb-path GTDB_PATH]
                        [--busco-db-path BUSCO_DB_PATH]
                        [--checkm2-db-path CHECKM2_DB_PATH]
                        [--eggnog-db-path EGGNOG_DB_PATH]
                        [--singlem-metapackage-path SINGLEM_METAPACKAGE_PATH]
                        [--metabuli-db-path METABULI_DB_PATH]

Sets the conda environment variables for future runs and downloads databases. 

options:
  -h, --help            show this help message and exit
  -t MAX_THREADS, --max-threads MAX_THREADS, --max_threads MAX_THREADS
                        Maximum number of threads given to any particular process. If max_threads > n_cores then n_cores will be bumped up to max_threads. Useful if you want more fine grain control over the number of threads used by each process. (default: 8)
  -p PPLACER_THREADS, --pplacer-threads PPLACER_THREADS, --pplacer_threads PPLACER_THREADS
                        The number of threads given to pplacer, values above `--max-threads` will be scaled to equal `--max-threads` (default: 8)
  -n N_CORES, --n-cores N_CORES, --n_cores N_CORES
                        Maximum number of cores available for use. Setting to multiples of max_threads will allow for multiple processes to be run in parallel. (default: 16)
  -m MAX_MEMORY, --max-memory MAX_MEMORY, --max_memory MAX_MEMORY
                        Maximum memory for available usage in Gigabytes (default: 250)
  --request-gpu [REQUEST_GPU], --request_gpu [REQUEST_GPU]
                        Request a GPU for use with the pipeline. This will only work if the pipeline is run on a cluster
  -o OUTPUT, --output OUTPUT
                        Output directory (default: ./)
  --conda-prefix CONDA_PREFIX, --conda_prefix CONDA_PREFIX
                        Path to the location of installed conda environments, or where to install new environments. 
                        Can be configured within the `configure` subcommand
  --tmpdir TMPDIR, --tempdir TMPDIR, --tmp-dir TMPDIR, --tmp_dir TMPDIR, --tmp TMPDIR, --temp TMPDIR, --temp-dir TMPDIR, --temp_dir TMPDIR
                        Path to the location that will be treated used for temporary files. If none is specified, the TMPDIR 
                        environment variable will be used. Can be configured within the `configure` subcommand
  --default-resources RESOURCES
                        Snakemake resources used as is found at: https://snakemake.readthedocs.io/en/stable/snakefiles/rules.html?highlight=resources#standard-resources  (default:  )
                        NOTE: tmpdir is handled by the `tmpdir` command line parameter. 
  --snakemake-profile SNAKEMAKE_PROFILE
                        Snakemake profile (see https://snakemake.readthedocs.io/en/stable/executing/cli.html#profiles)
                        Create profile as `~/.config/snakemake/[CLUSTER_PROFILE]/config.yaml`. 
                        Can be used to submit rules as jobs to cluster engine (see https://snakemake.readthedocs.io/en/stable/executing/cluster.html), 
                        requires cluster, cluster-status, jobs, cluster-cancel. 
  --local-cores LOCAL_CORES, --local_cores LOCAL_CORES
                        Maximum number of cores available for use locally. Only relevant if jobs are being submitted to a cluster (e.g. see `--snakemake-profile`), in which case `--n-cores` will restrict requested cores in submitted jobs. (default: 16)
  --cluster-retries CLUSTER_RETRIES
                        Number of times to retry a failed job when using cluster submission (see `--snakemake-profile`). 
  --dry-run [DRYRUN], --dry_run [DRYRUN], --dryrun [DRYRUN]
                        Perform snakemake dry run, tests workflow order and conda environments
  --clean [CLEAN]       Clean up all temporary files. This will remove most BAM files and any FASTQ files  (default: True)
                        generated from read filtering. Setting this to False is the equivalent of the --notemp 
                        option in snakemake. Useful for when running only part of a workflow as it avoids 
                        deleting files that would likely be needed in later parts of the workflow. 
                        NOTE: Not cleaning makes reruns faster but will incur the wrath of your sysadmin
  --build [yes|no]      Build conda environments necessary to run the pipeline, and then exit. Equivalent to "--snakemake-cmds '--conda-create-envs-only True ' ". Other inputs should be specified as if running normally so that the right set of conda environments is built. (default: no)
  --download [{gtdb,eggnog,singlem,checkm2,metabuli} ...], --download [{gtdb,eggnog,singlem,checkm2,metabuli} ...]
                        Downloads the requested GTDB, EggNOG, SingleM, CheckM2, & Metabuli databases
  --rerun-triggers [{mtime,params,input,software-env,code} ...], --rerun_triggers [{mtime,params,input,software-env,code} ...]
                        Specify which kinds of modifications will trigger rules to rerun (default: ['mtime'])
  --snakemake-cmds CMDS
                        Additional commands to supplied to snakemake in the form of a single string e.g. "--print-compilation True". 
                         NOTE: Most commands in snakemake -h are valid but some commands may clash with commands 
                         aviary directly supplies to snakemake. Please make sure your additional commands don't clash.
  --gtdb-path GTDB_PATH, --gtdb_path GTDB_PATH
                        Path to the local gtdb database files
  --busco-db-path BUSCO_DB_PATH, --busco_db_path BUSCO_DB_PATH
                        Path to the local BUSCO database files
  --checkm2-db-path CHECKM2_DB_PATH, --checkm2_db_path CHECKM2_DB_PATH
                        Path to Checkm2 Database
  --eggnog-db-path EGGNOG_DB_PATH, --eggnog_db_path EGGNOG_DB_PATH
                        Path to the local eggnog database files
  --singlem-metapackage-path SINGLEM_METAPACKAGE_PATH, --singlem_metapackage_path SINGLEM_METAPACKAGE_PATH
                        Path to the local SingleM metapackage
  --metabuli-db-path METABULI_DB_PATH, --metabuli_db_path METABULI_DB_PATH
                        Path to the local metabuli database

                                                               ......:::::: CONFIGURE ::::::......

                                            aviary configure --conda-prefix ~/.conda --gtdb-path ~/gtdbtk/release207/ --temp-dir /path/to/new/temp
```


## Metadata
- **Skill**: generated
