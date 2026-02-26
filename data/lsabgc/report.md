# lsabgc CWL Generation Report

## lsabgc_lsaBGC-Pan

### Tool Description
Workflow to run a pan-genome analysis of biosynthetic gene clusters for a single genus or species.

### Metadata
- **Docker Image**: quay.io/biocontainers/lsabgc:1.1.10--pyhdfd78af_0
- **Homepage**: https://github.com/Kalan-Lab/lsaBGC-Pan
- **Package**: https://anaconda.org/channels/bioconda/packages/lsabgc/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/lsabgc/overview
- **Total Downloads**: 9.1K
- **Last updated**: 2025-11-21
- **GitHub**: https://github.com/Kalan-Lab/lsaBGC-Pan
- **Stars**: N/A
### Original Help Text
```text
Usage: lsaBGC-Pan [-h] [-a ANTISMASH_RESULTS_DIRECTORY]
                  [-g GENOMES [GENOMES ...]] -o OUTPUT_DIRECTORY [-f] [-k]
                  [-rg] [-up] [-omc] [-ohq] [-hqp] [-cs CORE_PROPORTION]
                  [-mcs MAX_CORE_GENES] [-pic POPULATION_IDENTITY_CUTOFF]
                  [-mpf MANUAL_POPULATIONS_FILE] [-ci CLUSTER_INFLATION]
                  [-cj CLUSTER_JACCARD] [-cr CLUSTER_SYNTENIC_CORRELATION]
                  [-cc CLUSTER_CONTAINMENT] [-nb] [-zp ZOL_PARAMETERS] [-zhq]
                  [-zl] [-ed EDGE_DISTANCE] [-hqr] [-rash]
                  [-at ALIGNMENT_TIMEOUT] [-py] [-c THREADS]

       __              ___   _____  _____
      / /  ___ ___ _  / _ ) / ___/ / ___/
     / /  (_-</ _ `/ / _  |/ (_ / / /__
    /_/  /___/\_,_/ /____/ \___/  \___/
    **********************************************************************************************************
    Program: lsaBGC-Pan
    Author: Rauf Salamzade
    Affiliation: Kalan Lab, UW Madison, Department of Medical Microbiology and Immunology

    QUICK DESCRIPTION:
    Workflow to run a pan-genome analysis of biosynthetic gene clusters for a single genus or species.
    https://github.com/Kalan-Lab/lsaBGC-Pan/

    **********************************************************************************************************
    NOTES & CONSIDERATIONS:

    * Check out the documentation at: https://github.com/Kalan-Lab/lsaBGC-Pan/wiki
    * Either provide an antiSMASH results directory or a directory with genomes (not both!).
    * lsaBGC-Pan does not have all the  functionalities of the original lsaBGC suite to make things simpler
      and more straightforward. In particular, lsaBGC-(Auto)Expansion, which helped with scalability is
      discluded because its usage generally requires more careful consideration and manual curation. Thus, to
      make sure your analysis runs in a relatively timely manner, the program is restricted to handling data
      from 4-200 genomes.
          - Consider using tools for dereplication/strain-clustering (such as skDER/CiDDER, dRep, PopPunk,
            or treemmer) to prune down your set of genomes if you have more than 200.
    * Panaroo should only be used if working with genomes belonging to a single bacterial species. If working
      with multiple bacterial species or fungal genomes, please use OrthoFinder instead.
    * Specifying fungal mode makes sure OrthoFinder is being used and that antiSMASH results were provided.
      GECCO is not designed for fungal genomes. In addition, customized processing designed for bacterial
      genomics is not performed and a more direct extraction of hierarchical orthogroups is applied.
        * The name of the sample-specific antiSMASH results directory will be used as the sample name, not the
          name of the full-genome GenBank file within it. So the sample name will be controlled by the antiSMASH
          argument --output-dir and not --output-basename.

    **********************************************************************************************************
    OVERVIEW OF WORKFLOW STEPS:

    PART 1
    ----------------------------------------------------------------------------------------------------------
        - Step 1: Assess inputs provided
        - Step 1a: If genomes are provided, perform gene-calling with p(y)rodigal and annotate BGCs with GECCO
        - Step 1b: If antiSMASH results are provided, extracted genes from full genome GenBank files. If GECCO
                   is requested, then it will also be run and overlapping GECCO and antiSMASH BGC regions will
                   be consolidated by taking
                   the larger region.
        - Step 2: Run OrthoFinder/Panaroo for orthology inference.
        - Step 3: Create species tree/phyogeny from (near-) core ortholog groups.
        - Step 4: Infer populations (will do so at multiple "core AAI" cutoffs) .
        - Step 5: Run lsaBGC-Cluster.py to determine evolutionary GCFs (by default in testing mode unless
                  --auto-cluster specified) .

    BREAK (optional - but recommended - can be skipped by issuing --no-break)
    ----------------------------------------------------------------------------------------------------------
        - Step 6a: Manually examine which parameters make the most sense for evolutionary clustering of GCFs.
                   Restart the workflow after with parameters for gene cluster clustering adapted.
        - Step 6b: Manually assess how population designations structure along the species tree with different
                   core AAI cutoffs and, if desired, adjust population designations.

    PART 2
    ----------------------------------------------------------------------------------------------------------
        - Step 7: Parallel running of zol and cgc per GCF.
        - Step 8: Parallel running of GSeeF, lsaBGC-See, and lsaBGC-ComprehenSeeIve per GCF.
        - Step 9: Parallel running of lsaBGC-MIBiGMapper.
        - Step 10: Run lsaBGC-Reconcile.
                - Step 11: Run lsaBGC-Sociate.
        - Step 12: Create consolidated report of zol, lsaBGC-MIBiGMapper, lsaBGC-Reconcile, and lsaBGC-Sociate
                   results .
    **********************************************************************************************************

Options:
  -h, --help            show this help message and exit
  -a, --antismash-results-directory ANTISMASH_RESULTS_DIRECTORY
                        A directory with subdirectories corresponding to antiSMASH results
                        per sample/genome [Optional].
  -g, --genomes GENOMES [GENOMES ...]
                        Paths to genomes or directories with genomes in FASTA format.
                        Will run GECCO for BGC-predictions [Optional].
  -o, --output-directory OUTPUT_DIRECTORY
                        Parent output/workspace directory.
  -f, --fungal          Specify if input are from fungal genomes. Only possible
                        if antiSMASH results are provided.
  -k, --keep-locus-tags
                        Attempt to keep original locus tags in antiSMASH GenBank
                        files - if locus tag is missing for one or more CDS
                        features new ones will be generated for the sample (experimental).
  -rg, --run-gecco      If antiSMASH results are provided also run GECCO for
                        annotation of BGCs.
  -up, --use-panaroo    Use Panaroo instead of OrthoFinder for orthology inference.
                        Recommended if investigating a single bacterial species.
  -omc, --run-coarse-orthofinder
                        Use coarse clustering for orthogroups in OrthoFinder instead
                        of the more resolute hierarchical determined homolog groups.
                        There are some advantages to coarse OGs, including their
                        construction being deterministic.
  -ohq, --run-msa-orthofinder
                        Run OrthoFinder using multiple sequence alignments instead of
                        DendroBlast to determine hierarchical ortholog groups.
  -hqp, --high-quality-phylogeny
                        Prioritize quality over speed for phylogeny construction.
  -cs, --core-proportion CORE_PROPORTION
                        What proportion of genomes single-copy orthogroups need to be
                        found in to be used for species tree construction [Default is 0.9].
  -mcs, --max-core-genes MAX_CORE_GENES
                        The maximum number of single copy (near-)core orthogroups to
                        use [Default is 500].
  -pic, --population-identity-cutoff POPULATION_IDENTITY_CUTOFF
                        The core-genome identity cutoff used to define pairs of genomes as
                        belonging to the same group/population [Default is 99.0].
  -mpf, --manual-populations-file MANUAL_POPULATIONS_FILE
                        Tab delimited file for manual mapping of samples to different
                        populations/clades.
  -ci, --cluster-inflation CLUSTER_INFLATION
                        The MCL inflation parameter for clustering BGCs into GCFs [Default
                        is 0.8].
  -cj, --cluster-jaccard CLUSTER_JACCARD
                        Cutoff for Jaccard similarity of homolog groups shared between two
                        BGCs [Default is 50.0].
  -cr, --cluster-syntenic-correlation CLUSTER_SYNTENIC_CORRELATION
                        The minimal correlation coefficient needed between for considering them
                        as a pair prior to MCL [Default is 0.4].
  -cc, --cluster-containment CLUSTER_CONTAINMENT
                        Cutoff for percentage of OGs for a gene cluster near a contig edge
                        to be found within the comparing gene cluster for the pair to be
                        considered in MCL (a minimum of 3 OGs shared are still required) [Default
                        is 70.0]
  -nb, --no-break       No break after step 5 to assess GCF clustering and population
                        stratification and adapt parameters.
  -zp, --zol-parameters ZOL_PARAMETERS
                        The parameters to run zol analyses with - please surround by quotes
                        [Defaut is ""].
  -zhq, --zol-high-quality-preset
                        Use preset of options for performing high-quality and comprehensive zol
                        analyses instead of prioritizing speed.
  -zl, --zol-keep-multi-copy
                        Include all GCF instances in zol analysis, not just the most
                        representative instance from each sample/genome.
  -ed, --edge-distance EDGE_DISTANCE
                        Distance in bp to scaffold/contig edge to be considered potentially
                        fragmented. Used in GCF clustering (related to --cluster-containment
                        parameter) and zol conservation computations [Default is 5000].
  -hqr, --high-quality-reconcile
                        Perform high-quality alignment for reconcile analysis.
  -rash, --report-all-sociate-hits
                        Report all signficant pyseer hits with 'notes' - usually
                        indicate some general issue - should be examined with caution:
                        https://pyseer.readthedocs.io/en/master/usage.html#notes-field.
  -at, --alignment-timeout ALIGNMENT_TIMEOUT
                        The timeout in seconds for constructing proteins alignments using
                        MUSCLE during lsaBGC-Reconcile and lsaBGC-Sociate - to prevent long
                        runs due to stragglers/abnormally large orthogroups [Default is
                        1800 (30 minutes)].
  -py, --use-prodigal   Use prodigal instead of pyrodigal (only if genomes are provided - not
                        relevant if antiSMASH results provided).
  -c, --threads THREADS
                        Total number of threads/processes to use. Recommend inreasing as much
                        as possible. [Default is 4].
```

