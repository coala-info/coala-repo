# peka CWL Generation Report

## peka

### Tool Description
Search for enriched motifs around thresholded crosslinks in CLIP data.

### Metadata
- **Docker Image**: quay.io/biocontainers/peka:1.0.2--pyhdfd78af_0
- **Homepage**: https://github.com/ulelab/peka
- **Package**: https://anaconda.org/channels/bioconda/packages/peka/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/peka/overview
- **Total Downloads**: 14.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/ulelab/peka
- **Stars**: N/A
### Original Help Text
```text
usage: peka [-h] -i INPUTPEAKS -x INPUTXLSITES -g GENOMEFASTA -gi GENOMEINDEX
            -r REGIONS [-k [{3,4,5,6,7}]] [-o [OUTPUTPATH]] [-w [WINDOW]]
            [-dw [DISTALWINDOW]] [-t [TOPN]] [-p [PERCENTILE]] [-c [CLUSTERS]]
            [-s [SMOOTHING]]
            [-re [{remove_repeats,masked,unmasked,repeats_only}]]
            [-pos [RELEVANT_POS_THRESHOLD] | -relax {True,False}]
            [-a {True,False}]
            [-sr {genome,whole_gene,intron,UTR3,other_exon,ncRNA,intergenic} [{genome,whole_gene,intron,UTR3,other_exon,ncRNA,intergenic} ...]]
            [-sub {True,False}] [-seed {True,False}]

Search for enriched motifs around thresholded crosslinks in CLIP data.

required arguments:
  -i INPUTPEAKS, --inputpeaks INPUTPEAKS
                        CLIP peaks (intervals of crosslinks) in BED file
                        format
  -x INPUTXLSITES, --inputxlsites INPUTXLSITES
                        CLIP crosslinks in BED file format
  -g GENOMEFASTA, --genomefasta GENOMEFASTA
                        genome fasta file, ideally the same as was used for
                        read alignment
  -gi GENOMEINDEX, --genomeindex GENOMEINDEX
                        genome fasta index file (.fai)
  -r REGIONS, --regions REGIONS
                        genome segmentation file produced as output of "iCount
                        segment" function

options:
  -h, --help            show this help message and exit
  -k [{3,4,5,6,7}], --kmerlength [{3,4,5,6,7}]
                        kmer length [DEFAULT 5]
  -o [OUTPUTPATH], --outputpath [OUTPUTPATH]
                        output folder [DEFAULT current directory]
  -w [WINDOW], --window [WINDOW]
                        window around thresholded crosslinks for finding
                        enriched kmers [DEFAULT 20]
  -dw [DISTALWINDOW], --distalwindow [DISTALWINDOW]
                        window around enriched kmers to calculate distribution
                        [DEFAULT 150]
  -t [TOPN], --topn [TOPN]
                        number of kmers ranked by z-score in descending order
                        for clustering and plotting [DEFAULT 20]
  -p [PERCENTILE], --percentile [PERCENTILE]
                        Percentile for considering thresholded crosslinks.
                        Accepts a value between 0 and 1 [0, 1). Percentile 0.7
                        means that a cDNA count threshold is determined at
                        which >=70 percent of the crosslink sites within the
                        region have a cDNA count equal or below the threshold.
                        Thresholded crosslinks have cDNA count above the
                        threshold. [DEFAULT 0.7]
  -c [CLUSTERS], --clusters [CLUSTERS]
                        how many enriched kmers to cluster and plot [DEFAULT
                        5]
  -s [SMOOTHING], --smoothing [SMOOTHING]
                        window used for smoothing kmer positional distribution
                        curves [DEFAULT 6]
  -re [{remove_repeats,masked,unmasked,repeats_only}], --repeats [{remove_repeats,masked,unmasked,repeats_only}]
                        how to treat repeating regions within genome (options:
                        "masked", "unmasked", "repeats_only",
                        "remove_repeats"). When applying any of the options
                        with the exception of repeats == "unmasked", a genome
                        with soft-masked repeat sequences should be used for
                        input, ie. repeats in lowercase letters. [DEFAULT
                        "unmasked"]
  -pos [RELEVANT_POS_THRESHOLD], --relevant_pos_threshold [RELEVANT_POS_THRESHOLD]
                        Percentile to set as threshold for relevant positions.
                        Accepted values are floats between 0 and 99 [0, 99].
                        If threshold is set to 0 then all positions within the
                        set window (-w, default 20 nt) will be considered for
                        enrichment calculation. If threshold is not zero, it
                        will be used to determine relevant positions for
                        enrichment calculation for each k-mer. If the -pos
                        option is not set, then the threshold will be
                        automatically assigned based on k-mer lengthand number
                        of crosslinks in region.
  -relax {True,False}, --relaxed_prtxn {True,False}
                        Whether to relax automatically calculated prtxn
                        threshold or not. Can be 'True' or 'False', default is
                        'True'. If 'True', more positions will be included for
                        PEKA-score calculation across k-mers. Using relaxed
                        threshold is recommended, unless you have data of very
                        high complexity and are using k-mer length <=5. This
                        argument can't be used together with -pos argument,
                        which sets a user-defined threshold for relevant
                        positions. [DEFAULT "True"]
  -a {True,False}, --alloutputs {True,False}
                        controls the number of outputs, can be True or False
                        [DEFAULT False]
  -sr {genome,whole_gene,intron,UTR3,other_exon,ncRNA,intergenic} [{genome,whole_gene,intron,UTR3,other_exon,ncRNA,intergenic} ...], --specificregion {genome,whole_gene,intron,UTR3,other_exon,ncRNA,intergenic} [{genome,whole_gene,intron,UTR3,other_exon,ncRNA,intergenic} ...]
                        choose to run PEKA on a specific region only, to
                        specify multiple regions enter them space separated
                        [DEFAULT None]
  -sub {True,False}, --subsample {True,False}
                        if the crosslinks file is very large, they can be
                        subsampled to reduce runtime, can be True/False
                        [DEFAULT True]
  -seed {True,False}, --set_seeds {True,False}
                        If you want to ensure reproducibility of results the
                        option set_seeds must be set to True. Can be True or
                        False [DEFAULT True]. Note that setting seeds reduces
                        the randomness of background sampling.
```

