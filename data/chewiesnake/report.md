# chewiesnake CWL Generation Report

## chewiesnake

### Tool Description
chewiesnake is a pipeline for cgMLST analysis.

### Metadata
- **Docker Image**: quay.io/biocontainers/chewiesnake:3.0.0--hdfd78af_2
- **Homepage**: https://gitlab.com/bfr_bioinformatics/chewieSnake
- **Package**: https://anaconda.org/channels/bioconda/packages/chewiesnake/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/chewiesnake/overview
- **Total Downloads**: 3.6K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
usage: chewiesnake [-h] -l SAMPLE_LIST -d WORKING_DIRECTORY
                   [--condaprefix CONDAPREFIX] [--reads] --scheme SCHEME
                   --prodigal PRODIGAL [--bsr_threshold BSR_THRESHOLD]
                   [--size_threshold SIZE_THRESHOLD]
                   [--distance_method DISTANCE_METHOD]
                   [--clustering_method CLUSTERING_METHOD]
                   [--distance_threshold DISTANCE_THRESHOLD]
                   [--address_range ADDRESS_RANGE] [--report] [--comparison]
                   [--comparison_db COMPARISON_DB]
                   [--joining_threshold JOINING_THRESHOLD] [-f]
                   [--allele_length_threshold ALLELE_LENGTH_THRESHOLD]
                   [--frameshift_mode FRAMESHIFT_MODE]
                   [--min_trimmed_length MIN_TRIMMED_LENGTH]
                   [--assembler ASSEMBLER]
                   [--shovill_output_options SHOVILL_OUTPUT_OPTIONS]
                   [--shovill_extraopts SHOVILL_EXTRAOPTS]
                   [--shovill_modules SHOVILL_MODULES]
                   [--shovill_depth SHOVILL_DEPTH]
                   [--shovill_tmpdir SHOVILL_TMPDIR] [--use_conda]
                   [--conda_frontend] [--threads_sample THREADS_SAMPLE]
                   [-t THREADS] [-n] [--forceall] [--unlock] [--logdir LOGDIR]

optional arguments:
  -h, --help            show this help message and exit
  -l SAMPLE_LIST, --sample_list SAMPLE_LIST
                        List of samples to analyze, as a two column tsv file
                        with columns sample and assembly. Can be generated
                        with provided script create_sampleSheet,sh
  -d WORKING_DIRECTORY, --working_directory WORKING_DIRECTORY
                        Working directory where results are saved
  --condaprefix CONDAPREFIX
                        Path of default conda environment, enables recycling
                        built environments, default is in folder conda_env in
                        repository directory.
  --reads               Input data is reads. Assemble (using shovill) prior to
                        allele calling (default is contigs)
  --scheme SCHEME       Path to directory of the cgmlst scheme
  --prodigal PRODIGAL   Path to prodigal_training_file (e.g. provided in
                        chewbbaca, path/to/chewieSnake/chewBBACA/CHEWBBACA/pro
                        digal_training_files, e.g. /usr/local/opt/chewiesnake/
                        chewBBACA/CHEWBBACA/prodigal_training_files/Salmonella
                        _enterica.trn
  --bsr_threshold BSR_THRESHOLD
                        blast scoring ratio threshold to use , default = 0.6
  --size_threshold SIZE_THRESHOLD
                        size threshold, default at 0.2 means alleles with size
                        variation of +-20 percent will be tagged as ASM/ALM ,
                        default = 0.2
  --distance_method DISTANCE_METHOD
                        Grapetree distance method; default = 3
  --clustering_method CLUSTERING_METHOD
                        The agglomeration method to be used for hierarchical
                        clustering. This should be (an unambiguous
                        abbreviation of) one of "ward.D", "ward.D2", "single",
                        "complete", "average" (= UPGMA), "mcquitty" (= WPGMA),
                        "median" (= WPGMC) or "centroid" (= UPGMC); default =
                        single
  --distance_threshold DISTANCE_THRESHOLD
                        A single distance threshold for the extraction of sub-
                        trees; default = 10
  --address_range ADDRESS_RANGE
                        A comma separated set of cutoff values for defining
                        the clustering address (Default:
                        1,5,10,20,50,100,200,1000)
  --report              Create html report
  --comparison          Compare these results to pre-computed allele database
  --comparison_db COMPARISON_DB
                        Path to pre-computed allele database for comparison
  --joining_threshold JOINING_THRESHOLD
                        A distance threshold for joining data with
                        comparsion_db; default = 30
  -f, --remove_frameshifts
                        remove frameshift alleles by deviating allele length
  --allele_length_threshold ALLELE_LENGTH_THRESHOLD
                        Maximum tolerated allele length deviance compared to
                        median allele length of locus; choose integer for
                        "absolute frameshift mode and float (0..1) for
                        "relative" frameshift mode ; default=0.1
  --frameshift_mode FRAMESHIFT_MODE
                        Whether to consider absolute or relative differences
                        of allele length for frameshifts removal. Choose from
                        "absolute" and "relative", default="relative"
  --min_trimmed_length MIN_TRIMMED_LENGTH
                        Minimum length of a read to keep, default = 15
  --assembler ASSEMBLER
                        Assembler to use in shovill, choose from megahit
                        velvet skesa spades (default: spades)
  --shovill_output_options SHOVILL_OUTPUT_OPTIONS
                        Extra output options for shovill (default: "")
  --shovill_extraopts SHOVILL_EXTRAOPTS
                        Extra options for shovill (default: "")
  --shovill_modules SHOVILL_MODULES
                        Module options for shovill, choose from --noreadcorr
                        --trim --nostitch --nocorr --noreadcorr (default: "--
                        noreadcorr")
  --shovill_depth SHOVILL_DEPTH
                        Sub-sample --R1/--R2 to this depth. Disable with
                        --depth 0 (default: 100)
  --shovill_tmpdir SHOVILL_TMPDIR
                        Fast temporary directory (default: "")
  --use_conda           Utilize "--useconda" option, i.e. all software
                        dependencies are available in a single env
  --conda_frontend      Do not mamba but conda as frontend to create
                        individual module' software environments
  --threads_sample THREADS_SAMPLE
                        Number of Threads to use per sample, default = 10
  -t THREADS, --threads THREADS
                        Number of Threads to use. Note that samples can only
                        be processed sequentially due to the required database
                        access. However the allele calling can be executed in
                        parallel for the different loci, default = 10
  -n, --dryrun          Snakemake dryrun. Only calculate graph without
                        executing anything
  --forceall            Snakemake force. Force recalculation of all steps
  --unlock              unlock snakemake
  --logdir LOGDIR       Path to directory whete .snakemake output is to be
                        saved
```

