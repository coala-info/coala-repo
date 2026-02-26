# damidseq_pipeline CWL Generation Report

## damidseq_pipeline

### Tool Description
Copyright 2013-25, Owen Marshall

### Metadata
- **Docker Image**: quay.io/biocontainers/damidseq_pipeline:1.6.2--pl5321hdfd78af_0
- **Homepage**: https://github.com/owenjm/damidseq_pipeline
- **Package**: https://anaconda.org/channels/bioconda/packages/damidseq_pipeline/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/damidseq_pipeline/overview
- **Total Downloads**: 11.1K
- **Last updated**: 2025-08-28
- **GitHub**: https://github.com/owenjm/damidseq_pipeline
- **Stars**: N/A
### Original Help Text
```text
damidseq_pipeline v1.6.2
Copyright 2013-25, Owen Marshall

** Inline::C not found; falling back on Perl KDE implementation ...
 --as_gatc             Output files at GATC resolution
                         [Current value: 1]
 --bamfiles            Only process BAM files
 --bedtools_path       path to BEDTools executable (leave blank if in path)
 --bins                Width of bins to use for mapping reads
                         [Current value: 75]
 --bowtie              Perform bowtie2 alignment [1/0]
                         [Current value: 1]
 --bowtie2_add_flags   Additional flags to use for bowtie2 alignment
 --bowtie2_genome_dir  Directory and basename for bowtie2 .bt2 indices
 --bowtie2_path        path to bowtie2 executable (leave blank if in path)
 --catada              Generate coverage files for CATaDa. Alias for --
                         just_coverage
 --chipseq             Process ChIP-seq data
                         (Equivalent to --just_coverage --as_gatc=0 --remdups --
                         unique --extension_method=full --full_data_files)
 --coverage            Save individual coverage bedgraphs
 --dam                 Specify file to use as Dam control
 --datadir             Process all files in this directory
 --exp_prefix          Common text string immediately preceding experiment name
                         (e.g. if filename is Dam_Exp1_n1.fq.gz, use _ as the
                         prefix)
                         [Current value: _]
 --exp_suffix          Common text string immediately proceding experiment name
                         (Takes --rep_prefix if not set; or, if filename is
                         Dam_Exp1_some-other-text_n1.fq.gz, use _ as the suffix)
 --extend_reads        Perform read extension [1/0]
                         [Current value: 1]
 --extension_method    Read extension method to use; options are:
                         full: Method used by version 1.3 and earlier.  Extends
                         all reads to the value set with --len.
                         gatc: Default for version 1.4 and above. Extends reads
                         to --len or to the next GATC site, whichever is
                         shorter.  Using this option increases peak resolution.
                         [Current value: gatc]
 --full_data_files     Output full binned ratio files (not only GATC array)
 --gatc_frag_file      GFF file containing all instances of the sequence GATC
 --just_align          Just align the FASTQ files, generate BAM files, and exit
 --just_coverage       Align, generate BAMs and calculate coverage; do generate
                         ratio files
 --kde_inline          Use Inline::C for KDE normalisation calculations
                         [Current value: 1]
 --kde_plot            create an Rplot of the kernel density fit for
                         normalisation (requires R)
 --keep_original_bams  Keep unextended BAM files if using single-end reads
 --len                 Length to extend reads to
                         [Current value: 300]
 --load_defaults       Load this saved set of defaults
                         (use 'list' to list current saved options)
 --markdup             Mark PCR duplicate reads with samtools.
                         *NB: for ChIP-seq alignment only; do NOT use with DamID
                         data.
 --max_norm_value      Maximum log2 value to limit normalisation search at
                         (default = +5)
                         [Current value: 5]
 --method_subtract     Output values are (Dam_fusion - Dam) instead of
                         log2(Dam_fusion/Dam) (not recommended)
 --min_norm_value      Minimum log2 value to limit normalisation search at
                         (default = -5)
                         [Current value: -5]
 --n                   Dry-run only; do not process files
 --ncbam               Don't clobber BAM files, skip if existing
 --no_file_filters     Do not trim filenames for output
                         [Current value: 1]
 --nogroups            Do not try to group experiments and replicates, and just
                         process all samples as per v1.5.3 and earlier
 --norm_method         Normalisation method to use; options are:
                         kde: use kernel density estimation of log2 GATC
                         fragment ratio (default)
                         rpm: use readcounts per million reads (not recommended
                         for most use cases)
                         rawbins: process raw counts with external normalisation
                         command (set with --rawbins_cmd)
                         [Current value: kde]
 --norm_override       Normalise by this amount instead
 --norm_steps          Number of points in normalisation routine (default = 300)
                         [Current value: 300]
 --out_name            Use this as the fusion-protein name when saving the final
                         ratio
 --output_format       Output tracks in this format [gff/bedgraph]
                         [Current value: bedgraph]
 --paired              Process paired-end reads (deprecated: PE/SE detection
                         should happen automagically)
 --paired_match        characters to search for that, directly in front of
                         [1|2], that marks paired-reads (regex format)
                         [Current value: R|_]
 --ps_debug            Print extra debugging info on pseudocount calculations in
                         log file
 --ps_factor           Value of c in c*(reads/bins) formula for calculating
                         pseudocounts (default = 10)
                         [Current value: 10]
 --pseudocounts        Add this value of psuedocounts instead (default: optimal
                         number of pseudocounts determined algorithmically)
 --q                   Cutoff average Q score for aligned reads
                         [Current value: 30]
 --qscore1max          max decile for normalising from Dam array
                         [Current value: 1]
 --qscore1min          min decile for normalising from Dam array
                         [Current value: 0.4]
 --qscore2max          max decile for normalising from fusion-protein array
                         [Current value: 0.9]
 --rawbins_cmd         Command to process raw tsv counts for --
                         norm_method=rawbins
                         Output of command should be the normalisation factor
                         (use with caution)
 --remdups             Remove PCR duplicate reads (implies --markdup).
                         *NB: for ChIP-seq alignment only; do NOT use with DamID
                         data.
 --rep_prefix          Common text string denoting replicates
                         (e.g. if filename is Dam_Exp1_n1.fq.gz, use _n as the
                         rep_prefix)
                         [Current value: _n]
 --reset_defaults      Delete user-defined parameters
 --samtools_path       path to samtools executable (leave blank if in path)
 --save_defaults       Save runtime parameters as default
                         (provide a name to differentiate different genomes --
                         these can be loaded with 'load_defaults')
 --scores_as_rpm       Calculate coverage scores (before normalisation) as reads
                         per million (RPM)
                         [Current value: 1]
 --threads             threads for bowtie2 to use
                         [Current value: 7]
 --unique              Only map uniquely aligning reads
 --version             Print version and exit
 --write_raw           Write TSV file with raw counts for each Dam, sample pair

More details and latest version available at https://owenjm.github.io/damidseq_pipeline
```

