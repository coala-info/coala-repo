# drep CWL Generation Report

## drep_dRep check_dependencies

### Tool Description
Check dependencies for dRep

### Metadata
- **Docker Image**: quay.io/biocontainers/drep:3.6.2--pyhdfd78af_0
- **Homepage**: https://github.com/MrOlm/drep
- **Package**: https://anaconda.org/channels/bioconda/packages/drep/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/drep/overview
- **Total Downloads**: 99.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/MrOlm/drep
- **Stars**: N/A
### Original Help Text
```text
mash.................................... all good        (location = /usr/local/bin/mash)
nucmer.................................. all good        (location = /usr/local/bin/nucmer)
checkm.................................. all good        (location = /usr/local/bin/checkm)
ANIcalculator........................... !!! ERROR !!!   (location = None)
prodigal................................ all good        (location = /usr/local/bin/prodigal)
centrifuge.............................. !!! ERROR !!!   (location = None)
nsimscan................................ !!! ERROR !!!   (location = None)
fastANI................................. all good        (location = /usr/local/bin/fastANI)
skani................................... all good        (location = /usr/local/bin/skani)
```


## drep_dRep compare

### Tool Description
Compare genomes to find similar ones

### Metadata
- **Docker Image**: quay.io/biocontainers/drep:3.6.2--pyhdfd78af_0
- **Homepage**: https://github.com/MrOlm/drep
- **Package**: https://anaconda.org/channels/bioconda/packages/drep/overview
- **Validation**: PASS

### Original Help Text
```text
usage: dRep compare [-p PROCESSORS] [-d] [-h] [-g [GENOMES ...]]
                    [--S_algorithm {fastANI,skani,goANI,ANImf,gANI,ANIn}]
                    [-ms MASH_SKETCH] [--SkipMash] [--SkipSecondary]
                    [--skani_extra SKANI_EXTRA] [--n_PRESET {normal,tight}]
                    [-pa P_ANI] [-sa S_ANI] [-nc COV_THRESH]
                    [-cm {total,larger}]
                    [--clusterAlg {ward,average,median,single,weighted,complete,centroid}]
                    [--low_ram_primary_clustering]
                    [--multiround_primary_clustering]
                    [--primary_chunksize PRIMARY_CHUNKSIZE]
                    [--greedy_secondary_clustering]
                    [--run_tertiary_clustering] [--gen_warnings]
                    [--warn_dist WARN_DIST] [--warn_sim WARN_SIM]
                    [--warn_aln WARN_ALN]
                    work_directory

positional arguments:
  work_directory        Directory where data and output are stored    
                        *** USE THE SAME WORK DIRECTORY FOR ALL DREP OPERATIONS ***

SYSTEM PARAMETERS:
  -p PROCESSORS, --processors PROCESSORS
                        threads (default: 6)
  -d, --debug           make extra debugging output (default: False)
  -h, --help            show this help message and exit

GENOME INPUT:
  -g [GENOMES ...], --genomes [GENOMES ...]
                        genomes to filter in .fasta format. Not necessary if
                        Bdb or Wdb already exist. Can also input a text file
                        with paths to genomes, which results in fewer OS
                        issues than wildcard expansion (default: None)

GENOME COMPARISON OPTIONS:
  --S_algorithm {fastANI,skani,goANI,ANImf,gANI,ANIn}
                        Algorithm for secondary clustering comaprisons:
                        fastANI = Kmer-based approach; very fast
                        skani = Even faster Kmer-based approacht
                        ANImf   = (DEFAULT) Align whole genomes with nucmer; filter alignment; compare aligned regions
                        ANIn    = Align whole genomes with nucmer; compare aligned regions
                        gANI    = Identify and align ORFs; compare aligned ORFS
                        goANI   = Open source version of gANI; requires nsmimscan
                         (default: fastANI)
  -ms MASH_SKETCH, --MASH_sketch MASH_SKETCH
                        MASH sketch size (default: 1000)
  --SkipMash            Skip MASH clustering, just do secondary clustering on
                        all genomes (default: False)
  --SkipSecondary       Skip secondary clustering, just perform MASH
                        clustering (default: False)
  --skani_extra SKANI_EXTRA
                        Extra arguments to pass to skani triangle (default: )
  --n_PRESET {normal,tight}
                        Presets to pass to nucmer
                        tight   = only align highly conserved regions
                        normal  = default ANIn parameters (default: normal)

GENOME CLUSTERING OPTIONS:
  -pa P_ANI, --P_ani P_ANI
                        ANI threshold to form primary (MASH) clusters
                        (default: 0.9)
  -sa S_ANI, --S_ani S_ANI
                        ANI threshold to form secondary clusters (default:
                        0.95)
  -nc COV_THRESH, --cov_thresh COV_THRESH
                        Minmum level of overlap between genomes when doing
                        secondary comparisons (default: 0.1)
  -cm {total,larger}, --coverage_method {total,larger}
                        Method to calculate coverage of an alignment
                        (for ANIn/ANImf only; gANI and fastANI can only do larger method)
                        total   = 2*(aligned length) / (sum of total genome lengths)
                        larger  = max((aligned length / genome 1), (aligned_length / genome2))
                         (default: larger)
  --clusterAlg {ward,average,median,single,weighted,complete,centroid}
                        Algorithm used to cluster genomes (passed to
                        scipy.cluster.hierarchy.linkage (default: average)
  --low_ram_primary_clustering
                        Use a memory-efficient algorithm for primary
                        clustering. This only affects primary clustering and
                        not secondary clustering. (default: False)

GREEDY CLUSTERING OPTIONS
These decrease RAM use and runtime at the expense of a minor loss in accuracy.
Recommended when clustering 5000+ genomes:
  --multiround_primary_clustering
                        Cluster each primary clunk separately and merge at the
                        end with single linkage. Decreases RAM usage and
                        increases speed, and the cost of a minor loss in
                        precision and the inability to plot
                        primary_clustering_dendrograms. Especially helpful
                        when clustering 5000+ genomes. Will be done with
                        single linkage clustering (default: False)
  --primary_chunksize PRIMARY_CHUNKSIZE
                        Impacts multiround_primary_clustering. If you have
                        more than this many genomes, process them in chunks of
                        this size. (default: 5000)
  --greedy_secondary_clustering
                        Use a heuristic to avoid pair-wise comparisons when
                        doing secondary clustering. Will be done with single
                        linkage clustering. Only works for fastANI S_algorithm
                        option at the moment (default: False)
  --run_tertiary_clustering
                        Run an additional round of clustering on the final
                        genome set. This is especially useful when greedy
                        clustering is performed and/or to handle cases where
                        similar genomes end up in different primary clusters.
                        Only works with dereplicate, not compare. (default:
                        False)

WARNINGS:
  --gen_warnings        Generate warnings (default: False)
  --warn_dist WARN_DIST
                        How far from the threshold to throw cluster warnings
                        (default: 0.25)
  --warn_sim WARN_SIM   Similarity threshold for warnings between dereplicated
                        genomes (default: 0.98)
  --warn_aln WARN_ALN   Minimum aligned fraction for warnings between
                        dereplicated genomes (ANIn) (default: 0.25)

Example: dRep compare output_dir/ -g /path/to/genomes/*.fasta
```


## drep_dRep dereplicate

### Tool Description
Dereplicate genomes based on ANI and other quality metrics.

### Metadata
- **Docker Image**: quay.io/biocontainers/drep:3.6.2--pyhdfd78af_0
- **Homepage**: https://github.com/MrOlm/drep
- **Package**: https://anaconda.org/channels/bioconda/packages/drep/overview
- **Validation**: PASS

### Original Help Text
```text
usage: dRep dereplicate [-p PROCESSORS] [-d] [-h] [-g [GENOMES ...]]
                        [-l LENGTH] [-comp COMPLETENESS] [-con CONTAMINATION]
                        [--ignoreGenomeQuality] [--genomeInfo GENOMEINFO]
                        [--checkM_method {lineage_wf,taxonomy_wf}]
                        [--set_recursion SET_RECURSION]
                        [--checkm_group_size CHECKM_GROUP_SIZE]
                        [--S_algorithm {skani,ANIn,ANImf,gANI,goANI,fastANI}]
                        [-ms MASH_SKETCH] [--SkipMash] [--SkipSecondary]
                        [--skani_extra SKANI_EXTRA]
                        [--n_PRESET {normal,tight}] [-pa P_ANI] [-sa S_ANI]
                        [-nc COV_THRESH] [-cm {total,larger}]
                        [--clusterAlg {ward,average,centroid,median,weighted,single,complete}]
                        [--low_ram_primary_clustering]
                        [--multiround_primary_clustering]
                        [--primary_chunksize PRIMARY_CHUNKSIZE]
                        [--greedy_secondary_clustering]
                        [--run_tertiary_clustering]
                        [-comW COMPLETENESS_WEIGHT]
                        [-conW CONTAMINATION_WEIGHT]
                        [-strW STRAIN_HETEROGENEITY_WEIGHT] [-N50W N50_WEIGHT]
                        [-sizeW SIZE_WEIGHT] [-centW CENTRALITY_WEIGHT]
                        [-extraW EXTRA_WEIGHT_TABLE] [--gen_warnings]
                        [--warn_dist WARN_DIST] [--warn_sim WARN_SIM]
                        [--warn_aln WARN_ALN] [--skip_plots]
                        work_directory

positional arguments:
  work_directory        Directory where data and output are stored    
                        *** USE THE SAME WORK DIRECTORY FOR ALL DREP OPERATIONS ***

SYSTEM PARAMETERS:
  -p PROCESSORS, --processors PROCESSORS
                        threads (default: 6)
  -d, --debug           make extra debugging output (default: False)
  -h, --help            show this help message and exit

GENOME INPUT:
  -g [GENOMES ...], --genomes [GENOMES ...]
                        genomes to filter in .fasta format. Not necessary if
                        Bdb or Wdb already exist. Can also input a text file
                        with paths to genomes, which results in fewer OS
                        issues than wildcard expansion (default: None)

GENOME FILTERING OPTIONS:
  -l LENGTH, --length LENGTH
                        Minimum genome length (default: 50000)
  -comp COMPLETENESS, --completeness COMPLETENESS
                        Minimum genome completeness (default: 75)
  -con CONTAMINATION, --contamination CONTAMINATION
                        Maximum genome contamination (default: 25)

GENOME QUALITY ASSESSMENT OPTIONS:
  --ignoreGenomeQuality
                        Don't run checkM or do any quality filtering. NOT
                        RECOMMENDED! This is useful for use with
                        bacteriophages or eukaryotes or things where checkM
                        scoring does not work. Will only choose genomes based
                        on length and N50 (default: False)
  --genomeInfo GENOMEINFO
                        location of .csv file containing quality information
                        on the genomes. Must contain: ["genome"(basename of
                        .fasta file of that genome), "completeness"(0-100
                        value for completeness of the genome),
                        "contamination"(0-100 value of the contamination of
                        the genome)] (default: None)
  --checkM_method {lineage_wf,taxonomy_wf}
                        Either lineage_wf (more accurate) or taxonomy_wf
                        (faster) (default: lineage_wf)
  --set_recursion SET_RECURSION
                        Increases the python recursion limit. NOT RECOMMENDED
                        unless checkM is crashing due to recursion issues.
                        Recommended to set to 2000 if needed, but setting this
                        could crash python (default: 0)
  --checkm_group_size CHECKM_GROUP_SIZE
                        The number of genomes passed to checkM at a time.
                        Increasing this increases RAM but makes checkM faster
                        (default: 2000)

GENOME COMPARISON OPTIONS:
  --S_algorithm {skani,ANIn,ANImf,gANI,goANI,fastANI}
                        Algorithm for secondary clustering comaprisons:
                        fastANI = Kmer-based approach; very fast
                        skani = Even faster Kmer-based approacht
                        ANImf   = (DEFAULT) Align whole genomes with nucmer; filter alignment; compare aligned regions
                        ANIn    = Align whole genomes with nucmer; compare aligned regions
                        gANI    = Identify and align ORFs; compare aligned ORFS
                        goANI   = Open source version of gANI; requires nsmimscan
                         (default: fastANI)
  -ms MASH_SKETCH, --MASH_sketch MASH_SKETCH
                        MASH sketch size (default: 1000)
  --SkipMash            Skip MASH clustering, just do secondary clustering on
                        all genomes (default: False)
  --SkipSecondary       Skip secondary clustering, just perform MASH
                        clustering (default: False)
  --skani_extra SKANI_EXTRA
                        Extra arguments to pass to skani triangle (default: )
  --n_PRESET {normal,tight}
                        Presets to pass to nucmer
                        tight   = only align highly conserved regions
                        normal  = default ANIn parameters (default: normal)

GENOME CLUSTERING OPTIONS:
  -pa P_ANI, --P_ani P_ANI
                        ANI threshold to form primary (MASH) clusters
                        (default: 0.9)
  -sa S_ANI, --S_ani S_ANI
                        ANI threshold to form secondary clusters (default:
                        0.95)
  -nc COV_THRESH, --cov_thresh COV_THRESH
                        Minmum level of overlap between genomes when doing
                        secondary comparisons (default: 0.1)
  -cm {total,larger}, --coverage_method {total,larger}
                        Method to calculate coverage of an alignment
                        (for ANIn/ANImf only; gANI and fastANI can only do larger method)
                        total   = 2*(aligned length) / (sum of total genome lengths)
                        larger  = max((aligned length / genome 1), (aligned_length / genome2))
                         (default: larger)
  --clusterAlg {ward,average,centroid,median,weighted,single,complete}
                        Algorithm used to cluster genomes (passed to
                        scipy.cluster.hierarchy.linkage (default: average)
  --low_ram_primary_clustering
                        Use a memory-efficient algorithm for primary
                        clustering. This only affects primary clustering and
                        not secondary clustering. (default: False)

GREEDY CLUSTERING OPTIONS
These decrease RAM use and runtime at the expense of a minor loss in accuracy.
Recommended when clustering 5000+ genomes:
  --multiround_primary_clustering
                        Cluster each primary clunk separately and merge at the
                        end with single linkage. Decreases RAM usage and
                        increases speed, and the cost of a minor loss in
                        precision and the inability to plot
                        primary_clustering_dendrograms. Especially helpful
                        when clustering 5000+ genomes. Will be done with
                        single linkage clustering (default: False)
  --primary_chunksize PRIMARY_CHUNKSIZE
                        Impacts multiround_primary_clustering. If you have
                        more than this many genomes, process them in chunks of
                        this size. (default: 5000)
  --greedy_secondary_clustering
                        Use a heuristic to avoid pair-wise comparisons when
                        doing secondary clustering. Will be done with single
                        linkage clustering. Only works for fastANI S_algorithm
                        option at the moment (default: False)
  --run_tertiary_clustering
                        Run an additional round of clustering on the final
                        genome set. This is especially useful when greedy
                        clustering is performed and/or to handle cases where
                        similar genomes end up in different primary clusters.
                        Only works with dereplicate, not compare. (default:
                        False)

SCORING CRITERIA
Based off of the formula: 
A*Completeness - B*Contamination + C*(Contamination * (strain_heterogeneity/100)) + D*log(N50) + E*log(size) + F*(centrality - S_ani)

A = completeness_weight; B = contamination_weight; C = strain_heterogeneity_weight; D = N50_weight; E = size_weight; F = cent_weight:
  -comW COMPLETENESS_WEIGHT, --completeness_weight COMPLETENESS_WEIGHT
                        completeness weight (default: 1)
  -conW CONTAMINATION_WEIGHT, --contamination_weight CONTAMINATION_WEIGHT
                        contamination weight (default: 5)
  -strW STRAIN_HETEROGENEITY_WEIGHT, --strain_heterogeneity_weight STRAIN_HETEROGENEITY_WEIGHT
                        strain heterogeneity weight (default: 1)
  -N50W N50_WEIGHT, --N50_weight N50_WEIGHT
                        weight of log(genome N50) (default: 0.5)
  -sizeW SIZE_WEIGHT, --size_weight SIZE_WEIGHT
                        weight of log(genome size) (default: 0)
  -centW CENTRALITY_WEIGHT, --centrality_weight CENTRALITY_WEIGHT
                        Weight of (centrality - S_ani) (default: 1)
  -extraW EXTRA_WEIGHT_TABLE, --extra_weight_table EXTRA_WEIGHT_TABLE
                        Path to a tab-separated file with two-columns, no
                        headers, listing genome and extra score to apply to
                        that genome (default: None)

WARNINGS:
  --gen_warnings        Generate warnings (default: False)
  --warn_dist WARN_DIST
                        How far from the threshold to throw cluster warnings
                        (default: 0.25)
  --warn_sim WARN_SIM   Similarity threshold for warnings between dereplicated
                        genomes (default: 0.98)
  --warn_aln WARN_ALN   Minimum aligned fraction for warnings between
                        dereplicated genomes (ANIn) (default: 0.25)

ANALYZE:
  --skip_plots          Dont make plots (default: False)

Example: dRep dereplicate output_dir/ -g /path/to/genomes/*.fasta
```

