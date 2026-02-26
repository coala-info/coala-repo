# binny CWL Generation Report

## binny

### Tool Description
Run binny on target assembly.

### Metadata
- **Docker Image**: quay.io/biocontainers/binny:2.2.18--pyhdfd78af_0
- **Homepage**: https://github.com/a-h-b/binny
- **Package**: https://anaconda.org/channels/bioconda/packages/binny/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/binny/overview
- **Total Downloads**: 1.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/a-h-b/binny
- **Stars**: N/A
### Original Help Text
```text
usage: binny [-h] (-a ASSEMBLY | -s) [-b [BAM ...] | --contig_depth
             CONTIG_DEPTH] [-o OUTPUTDIR] [--sample SAMPLE]
             [--tmp_dir TMP_DIR] [-t THREADS] [--big_mem_avail]
             [--big_mem_per_core_gb BIG_MEM_PER_CORE_GB]
             [--normal_mem_per_core_gb NORMAL_MEM_PER_CORE_GB]
             [-c CONFIG_FILE] [-m] [-csc CLUSTER_SUBMISSION_COMMAND]
             [-spp SCHEDULER_PRESET_PATH] [-jn JOB_NAME] [-r] [-d] [-u] [-f]
             [--db_path DB_PATH] [--kmers KMERS] [--mask_disruptive_sequences]
             [--extract_scmags] [--coassembly_mode {auto,on,off}]
             [--NX_value NX_VALUE]
             [--min_cont_length_cutoff MIN_CONT_LENGTH_CUTOFF]
             [--max_cont_length_cutoff MAX_CONT_LENGTH_CUTOFF]
             [--min_cont_length_cutoff_marker MIN_CONT_LENGTH_CUTOFF_MARKER]
             [--max_cont_length_cutoff_marker MAX_CONT_LENGTH_CUTOFF_MARKER]
             [--max_n_contigs MAX_N_CONTIGS]
             [--max_marker_lineage_depth_lvl {0,1,2,3,4,5,6}]
             [--distance_metric {cityblock,cosine,euclidean,haversine,l1,l2,manhattan,nan_euclidean}]
             [--max_iterations MAX_ITERATIONS]
             [--hdbscan_epsilon_range HDBSCAN_EPSILON_RANGE]
             [--hdbscan_min_samples_range HDBSCAN_MIN_SAMPLES_RANGE]
             [--include_depth_initial] [--include_depth_main]
             [--min_completeness MIN_COMPLETENESS]
             [--start_completeness START_COMPLETENESS] [--purity PURITY]
             [--write_contig_data]

Run binny on target assembly.

options:
  -h, --help            show this help message and exit
  -a ASSEMBLY, --assembly ASSEMBLY
                        Path to an assembly fasta. (default: None)
  -s, --setup           Setup CheckM database, Mantis and Prokka container.
                        (default: False)
  -b [BAM ...], --bam [BAM ...]
                        Path to a bam file(s) to calculate depth from. Use
                        wildcards for multiple samples, e.g.:
                        "path/to/my/mappings/*.bam" or "path/to/my/mappings/wi
                        th/*/different/folder/*/structure/*.bam" or
                        "path/to/my/mappings/my_mapping.bam. Leave empty if
                        you have an average depth per contig file to supply to
                        binny. (default: None)
  --contig_depth CONTIG_DEPTH
                        Path to an average depth per contig tsv file. Leave
                        empty if you supply a bam file for binny to calculate
                        average contig depth from. First column needs to be
                        the contig ids, subsequent column(s) for depht(s).
                        (default: )

Output:
  Other arguments required to run binny.

  -o OUTPUTDIR, --outputdir OUTPUTDIR
                        Path to desired output dir binny should create and
                        store results in. (default: None)
  --sample SAMPLE       Sample name. (default: sample)
  --tmp_dir TMP_DIR     Path to a temporary directory to write to. Defaults to
                        outputdir/tmp (default: )

Computing resources:
  Parameters concerning computing resoures.

  -t THREADS, --threads THREADS
                        Maximum number of cpus/threads to use. (default: 1)
  --big_mem_avail       Set to use high memory capacity computer node.
                        (default: False)
  --big_mem_per_core_gb BIG_MEM_PER_CORE_GB
                        Specify the amount of memory per core for high memory
                        capacity node. Use with '--big-mem'. (default: 26)
  --normal_mem_per_core_gb NORMAL_MEM_PER_CORE_GB
                        Specify the amount of memory per core for your system.
                        (default: 2)

Snakemake arguments:
  Arguments concerning the execution of Snakemake.

  -c CONFIG_FILE, --config_file CONFIG_FILE
                        Path to config file. A default config file to use as
                        template can be found at:
                        /usr/local/lib/python3.10/site-
                        packages/binny/config/config.default.yaml. (default: )
  -m, --use_cluster     Use cluster to submit jobs to instead of running
                        locally. (default: False)
  -csc CLUSTER_SUBMISSION_COMMAND, --cluster_submission_command CLUSTER_SUBMISSION_COMMAND
                        Submission command of a cluster or batch system to use
                        (Atm only slurm support. (default: {cluster.call}
                        {cluster.runtime}{resources.runtime}
                        {cluster.mem_per_cpu}{resources.mem} {cluster.nodes}
                        {cluster.qos} {cluster.threads}{threads}
                        {cluster.partition} {cluster.stdout})
  -spp SCHEDULER_PRESET_PATH, --scheduler_preset_path SCHEDULER_PRESET_PATH
                        Path to the scheduler preset file for cluster
                        submission. (default: /usr/local/lib/python3.10/site-
                        packages/binny/config/slurm.config.yaml)
  -jn JOB_NAME, --job_name JOB_NAME
                        Naming scheme for cluster job scripts. (default:
                        binny.{rulename}.{jobid}.sh)
  -r, --report          Generate a report (it's recommended to run -c, -f and
                        -l with -r). (default: False)
  -d, --dry-run         Perform a dry-run. (default: False)
  -u, --unlock          Unlock working directory (only necessary for
                        crash/kill recovery). (default: False)
  -f, --force           Force all output files to be re-created. (default:
                        False)

Environment arguments:
  Arguments concerning the execution environment.

  --db_path DB_PATH     Absolute path to put binny dbs in. If left empty they
                        will be put into 'database' in the binny main dir.
                        (default: /usr/local/lib/python3.10/site-
                        packages/binny/database)

binny arguments:
  Arguments concerning parameters for binny.

  --kmers KMERS         Input a list of kmers, e.g. '2,3,4'. (default: 2,3,4)
  --mask_disruptive_sequences
                        Toggle masking of potentially disruptive contig
                        regions (e.g. rRNA and CRISPR elements) from k-mer
                        counting (default: True)
  --extract_scmags      Extract single contig MAGs of at least 90% purity and
                        92.5% completeness. (default: True)
  --coassembly_mode {auto,on,off}
                        Will use coassembly mode, starting with contigs >= 500
                        bp instead of high threshold, decreasing, if set to
                        'on' or if 'auto' and multiple depth files are
                        detected. Choose between, 'auto', 'on' , 'off'.
                        (default: auto)
  --NX_value NX_VALUE   binny prefilters assemblies based on N<X> value to try
                        and take as much information as possible into account,
                        while minimizing the amount of noise. Be aware that,
                        depending on the assembly quality, low values as the
                        N<X> might results in leaving out a large proportion
                        of the assembly (if the max_cont_length cutoffs are
                        set high as well). (default: 90)
  --min_cont_length_cutoff MIN_CONT_LENGTH_CUTOFF
                        Minimum contig length. Caps NX filtering value.
                        (default: 2250)
  --max_cont_length_cutoff MAX_CONT_LENGTH_CUTOFF
                        Maximum contig length. Caps NX filtering value.
                        (default: 2250)
  --min_cont_length_cutoff_marker MIN_CONT_LENGTH_CUTOFF_MARKER
                        Minimum contig length containing CheckM markers. Caps
                        NX filtering value. (default: 2250)
  --max_cont_length_cutoff_marker MAX_CONT_LENGTH_CUTOFF_MARKER
                        Maximum contig length containing CheckM markers. Caps
                        NX filtering value. (default: 2250)
  --max_n_contigs MAX_N_CONTIGS
                        Maximum number of contigs binny uses. If the number of
                        available contigs after minimum size filtering exceeds
                        this, binny will increase the minimum size threshold
                        until the maximum is reached. Prevents use of
                        excessive amounts of memory on large
                        assemblies.Default should ensure adequate performance,
                        adjust according to available memory. (default:
                        500000.0)
  --max_marker_lineage_depth_lvl {0,1,2,3,4,5,6}
                        Maximum marker set lineage depth to check bin quality
                        with:0: 'domain', 1: 'phylum', 2: 'class', 3: 'order',
                        4: 'family', 5: 'genus', 6: 'species'. (default: 2)
  --distance_metric {cityblock,cosine,euclidean,haversine,l1,l2,manhattan,nan_euclidean}
                        Distance metric for opentSNE and HDBSCAN. (default:
                        manhattan)
  --max_iterations MAX_ITERATIONS
                        Maximum number of binny iterations. (default: 50)
  --hdbscan_epsilon_range HDBSCAN_EPSILON_RANGE
                        Increasing the HDBSCAN cluster selection epsilon
                        beyond 0.5 is not advised as it might massively
                        increase run time, but it might help recover
                        fragmented genomes that would be missed with lower
                        settings. (default: 0.250,0.000)
  --hdbscan_min_samples_range HDBSCAN_MIN_SAMPLES_RANGE
                        Adapted from the HDBSCAN manual: 'Measure of how
                        conservative the clustering should be. With larger
                        values, more points will be declared as noise, and
                        clusters will be restricted to progressively more
                        dense areas.'. (default: 1,5,10)
  --include_depth_initial
                        Use depth as additional dimension during the initial
                        clustering. (default: False)
  --include_depth_main  Use depth as additional dimension during the main
                        clusterings. (default: False)
  --min_completeness MIN_COMPLETENESS
                        Minimum value binny will lower completeness to while
                        running. (default: 72.5)
  --start_completeness START_COMPLETENESS
                        Completeness threshold binny wilt begin with.
                        (default: 92.5)
  --purity PURITY       Minimum purity for bins to be selected. (default: 95)
  --write_contig_data   Write all contig data to compressed tsv. Might create
                        large file. (default: True)
```

