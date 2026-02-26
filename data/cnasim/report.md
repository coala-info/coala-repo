# cnasim CWL Generation Report

## cnasim

### Tool Description
Main simulator for generating copy number profiles (CNPs), readcounts, and sequencing reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/cnasim:1.3.5--pyhdfd78af_0
- **Homepage**: https://github.com/samsonweiner/CNAsim
- **Package**: https://anaconda.org/channels/bioconda/packages/cnasim/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cnasim/overview
- **Total Downloads**: 1.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/samsonweiner/CNAsim
- **Stars**: N/A
### Original Help Text
```text
usage: cnasim [-h] [-m MODE] [-o OUT_PATH] [-t TREE_TYPE] [-T TREE_PATH]
              [-g GROWTH_RATE] [-s NUM_SWEEP] [-s1 SELECTION_STRENGTH]
              [-n NUM_CELLS] [-n1 NORMAL_FRACTION] [-n2 PSEUDONORMAL_FRACTION]
              [-c NUM_CLONES] [-c1 CLONE_CRITERIA] [-c2 CLONE_MU]
              [-c3 CLONE_SD] [-p PLACEMENT_TYPE] [-p1 PLACEMENT_PARAM]
              [-k REGION_LENGTH] [-l CN_LENGTH_MEAN] [-l1 MIN_CN_LENGTH]
              [-a CN_COPY_PARAM] [-b CN_EVENT_RATE] [-j FOUNDER_EVENT_MULT]
              [-w] [-v] [-q CHROM_ARM_RATE] [-i CHROM_RATE_FOUNDER]
              [-i1 CHROM_RATE_SUPER_CLONE] [-i2 CHROM_RATE_CLONE]
              [-u CHROM_EVENT_TYPE] [-N NUM_CHROMOSOMES] [-L CHROM_LENGTH]
              [-A CHROM_ARM_RATIO] [-B BIN_LENGTH] [-E1 ERROR_RATE_1]
              [-E2 ERROR_RATE_2] [-U] [-r1 REFERENCE] [-r2 ALT_REFERENCE] [-M]
              [-X LORENZ_X] [-Y LORENZ_Y] [-W WINDOW_SIZE] [-I INTERVAL]
              [-C COVERAGE] [-R READ_LENGTH] [-S SEQ_ERROR] [-P PROCESSORS]
              [-d] [-F PARAM_FILE]

options:
  -h, --help            show this help message and exit
  -m, --mode MODE       Main simulator mode for generating data. 0: CNPs only,
                        1: readcounts & CNPs, 2: sequencing reads & CNPs
  -o, --out-path OUT_PATH
                        Path to output directory.
  -t, --tree-type TREE_TYPE
                        0: coalescence, 1: random, 2: from file (use -T to
                        specify file path).
  -T, --tree-path TREE_PATH
                        Path to input tree.
  -g, --growth-rate GROWTH_RATE
                        Exponential growth rate for standard coalescent.
  -s, --num-sweep NUM_SWEEP
                        Number of selective sweeps in coalescent.
  -s1, --selection-strength SELECTION_STRENGTH
                        Parameter controlling the strength of selection during
                        the sweeps.
  -n, --num-cells NUM_CELLS
                        Number of observed cells in sample.
  -n1, --normal-fraction NORMAL_FRACTION
                        Proportion of cells that are normal.
  -n2, --pseudonormal-fraction PSEUDONORMAL_FRACTION
                        Proportion of cells that are pseudonormal cells.
  -c, --num-clones NUM_CLONES
                        Number of ancestral nodes to select as clonal
                        founders.
  -c1, --clone-criteria CLONE_CRITERIA
                        Criteria to choose clonal ancesters. 0: proportional
                        to number of leaves in subtree. 1: proportional to
                        edge length
  -c2, --clone-mu CLONE_MU
                        Mean number of leaves in a subclone. Must select 0 for
                        clone-criteria.
  -c3, --clone-sd CLONE_SD
                        SD in the number of leaves in a subclone. Must select
                        0 for clone-criteria.
  -p, --placement-type PLACEMENT_TYPE
                        Number of CNAs per edge. 0: draw from a Poisson with
                        fixed mean, 1: draw from a Poisson with mean prop to
                        edge length, 2: fixed per edge
  -p1, --placement-param PLACEMENT_PARAM
                        Parameter for placement choice.
  -k, --region-length REGION_LENGTH
                        Region length in bp. Essentially controls the
                        resolution of the simulated genome.
  -l, --cn-length-mean CN_LENGTH_MEAN
                        Mean copy number event length in bp.
  -l1, --min-cn-length MIN_CN_LENGTH
                        Minimum copy number event length in bp. Should be at
                        minimum the region length and less than the mean.
  -a, --cn-copy-param CN_COPY_PARAM
                        Parameter in the geometric to select number of copies.
  -b, --cn-event-rate CN_EVENT_RATE
                        Probability an event is an amplification. Deletion
                        rate is 1 - amp rate.
  -j, --founder-event-mult FOUNDER_EVENT_MULT
                        Multiplier for the number of events along edge into
                        founder cell.
  -w, --WGD             Include WGD.
  -v, --chrom-level-event
                        Include chromosomal alterations.
  -q, --chrom-arm-rate CHROM_ARM_RATE
                        Probability that a chromosomal event is a chromosome-
                        arm event.
  -i, --chrom-rate-founder CHROM_RATE_FOUNDER
                        Parameter in poisson for number of chromosome-level
                        events along the edge into the founder cell.
  -i1, --chrom-rate-super-clone CHROM_RATE_SUPER_CLONE
                        Parameter in poisson for number of chromosome-level
                        events along the edges out of the founder cell.
  -i2, --chrom-rate-clone CHROM_RATE_CLONE
                        Parameter in poisson for number of chrom-level events
                        for clonal nodes.
  -u, --chrom-event-type CHROM_EVENT_TYPE
                        Probability that a chromosomal event is a duplication.
  -N, --num-chromosomes NUM_CHROMOSOMES
                        Number of chromosomes if run in mode 0.
  -L, --chrom-length CHROM_LENGTH
                        Length of chromosomes in bp if not using hg38 static.
  -A, --chrom-arm-ratio CHROM_ARM_RATIO
                        If not using hg38 static, ratio of length within the
                        p-arm.
  -B, --bin-length BIN_LENGTH
                        Resolution of copy number profiles in bp.
  -E1, --error-rate-1 ERROR_RATE_1
                        Error rate for the boundary model.
  -E2, --error-rate-2 ERROR_RATE_2
                        Error rate for the jitter model.
  -U, --use-hg38-static
                        Use hg38 chromosome information. Excludes sex
                        chromosomes chrX and chrY.
  -r1, --reference REFERENCE
                        Path to input reference genome as the primary
                        haplotype in fasta format. Will be duplicated as both
                        haplotypes if an alternate is not provided.
  -r2, --alt-reference ALT_REFERENCE
                        Path to an alternate reference genome to be used as a
                        secondary haplotype, also in fasta format.
  -M, --use-uniform-coverage
                        Use uniform coverage across the genome.
  -X, --lorenz-x LORENZ_X
                        x-coordinate of point on lorenz curve if using non-
                        uniform coverage.
  -Y, --lorenz-y LORENZ_Y
                        y-coordinate of point on lorenz curve if using non-
                        uniform coverage.
  -W, --window-size WINDOW_SIZE
                        Number of base pairs to generate reads for in each
                        iteration.
  -I, --interval INTERVAL
                        Initializes a point in the coverage distribution every
                        interval number of windows.
  -C, --coverage COVERAGE
                        Average sequencing coverage across the genome.
  -R, --read-length READ_LENGTH
                        Paired-end short read length.
  -S, --seq-error SEQ_ERROR
                        Per base error rate for generating sequence data.
  -P, --processors PROCESSORS
                        Number of processes to use for generating reads in
                        parallel.
  -d, --disable-info    Do not output simulation log, cell types, or ground
                        truth events.
  -F, --param-file PARAM_FILE
                        Path to parameter file to specify parameters instead
                        of the command line. Must conform to the sample
                        format.
```

