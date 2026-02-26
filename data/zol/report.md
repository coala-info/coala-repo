# zol CWL Generation Report

## zol

### Tool Description
zol is a lightweight software that can generate reports on conservation, annotation, and evolutionary statistics for defined orthologous/homologous gene clusters (e.g. BGCs, phages, MGEs, or any genomic island / operon!).

### Metadata
- **Docker Image**: quay.io/biocontainers/zol:1.6.17--py312hf731ba3_1
- **Homepage**: https://github.com/Kalan-Lab/zol
- **Package**: https://anaconda.org/channels/bioconda/packages/zol/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/zol/overview
- **Total Downloads**: 77.0K
- **Last updated**: 2026-01-17
- **GitHub**: https://github.com/Kalan-Lab/zol
- **Stars**: N/A
### Original Help Text
```text
Usage: zol [-h] -i INPUT [INPUT ...] -o OUTPUT_DIR [-sfp]
           [-it IDENTITY_THRESHOLD] [-ct COVERAGE_THRESHOLD]
           [-et EVALUE_THRESHOLD] [-ci CLUSTERING_INFLATION] [-dco]
           [-dcp DC_PARAMS] [-fl] [-fd] [-r] [-d] [-ri] [-dt DEREP_IDENTITY]
           [-dc DEREP_COVERAGE] [-di DEREP_INFLATION] [-dsg]
           [-rp REINFLATE_PARAMS] [-dom] [-cml CCDS_MIN_LENGTH]
           [-pfp PFAM_PARAMS] [-egc] [-ibc] [-ces] [-aec] [-qa] [-b] [-s]
           [-sg] [-sb] [-gto GARD_TIMEOUT] [-cd CUSTOM_DATABASE]
           [-f FOCAL_GENBANKS] [-fc COMPARATOR_GENBANKS] [-oo]
           [-po PRECOMPUTED_ORTHOGROUPS] [-sc] [-sa] [-c THREADS]
           [-mm MAX_MEMORY] [-l LENGTH] [-w WIDTH] [-fgl] [-v]

    Program: zol
    Author: Rauf Salamzade
    Affiliation: Kalan Lab, UW Madison, Department of Medical Microbiology and
        Immunology

    **************************************************************************************

                      oooooooooooo           ooooo
                     d'''''''d888'           `888'
                           .888P    .ooooo.   888
                          d888'    d88' `88b  888
                        .888P      888   888  888
                       d888'    .P 888   888  888       o
                     .8888888888P  `Y8bod8P' o888ooooood8

    **************************************************************************************

    zol is a lightweight software that can generate reports on conservation, annotation,
    and evolutionary statistics for defined orthologous/homologous gene clusters (e.g.
    BGCs, phages, MGEs, or any genomic island / operon!).

    CONSIDERATIONS:
    ---------------
    * It is advised that multiple GenBanks from the same genome/sample be concatenated into
      a multi-record GenBank to account for fragmentation of gene-clusters and properly
      calculate copy count of ortholog groups.
    * Locus tags cannot contain commas, if they do however, you can use the --rename-lt flag
      to request new locus tags!
    * Dereplication uses ANI & AF estimates by skani, which the author recommends should be
      used on contigs (or gene-clusters in this case) greater than 10 kb for accurate
      calculations.
    * "Domain mode" chops up CDS features in input GenBank files based on Pfam annotation,
      retaining domain and inter-domain regions that are of a certain length (50 aa) by
      default. This mode is not compatible with the options: --reinflate and
      --comprehensive-evo-stats.

Options:
  -h, --help            show this help message and exit
  -i, --input INPUT [INPUT ...]
                        Either a directory or set of files with orthologous/
                        homologous locus-specific GenBanks. Files must end with
                        '.gbk', '.gbff', or '.genbank'.
  -o, --output-dir OUTPUT_DIR
                        Output directory.
  -sfp, --select-fai-params-mode
                        Mode for determining recommeded parameters for running
                        fai to find more instances of the focal gene cluster.
  -it, --identity-threshold IDENTITY_THRESHOLD
                        Minimum identity coverage for an alignment between protein
                        pairs from two gene-clusters to consider in search for
                        orthologs. [Default is 30].
  -ct, --coverage-threshold COVERAGE_THRESHOLD
                        Minimum query coverage for an alignment between protein
                        pairs from two gene-clusters to consider in search for
                        orthologs. [Default is 50].
  -et, --evalue-threshold EVALUE_THRESHOLD
                        Maximum E-value for an alignment between protein pairs from
                        two gene-clusters to consider in search for orthologs.
                        [Default is 0.001].
  -ci, --clustering-inflation CLUSTERING_INFLATION
                        Inflation parameter for MCL clustering of ortholog groups.
                        Can be set to -1 for single-linkage clustering
                        [Default is 1.5].
  -dco, --dc-orthogroup
                        Cluster proteins using diamond cluster instead of using the
                        standard InParanoid-like ortholog group prediction approach.
                        This approach is faster and can use less memory, but is less
                        accurate. Memory can be controlled via the --max-memory option.
  -dcp, --dc-params DC_PARAMS
                        Parameters for performing diamond cluster based ortholog group
                        clustering if requested via --dco-orthogroup.
                        [Default is "--approx-id 50 --mutual-cover 25"].
  -fl, --filter-low-quality
                        Filter gene-clusters which feature alot of missing
                        bases ( > 10 percent).
  -fd, --filter-draft-quality
                        Filter records of gene-clusters which feature CDS
                        features on the edge of contigs (those marked with
                        attribute near_contig_edge = True by fai) or which are
                        multi-record.
  -r, --rename-lt       Rename locus-tags for CDS features in GenBanks.
  -d, --dereplicate     Perform dereplication of input GenBanks using skani
                        and single-linkage clustering or MCL.
  -ri, --reinflate      Perform ortholog group re-inflation to incorporate CDS
                        from non-representative gene-clusters following
                        dereplication.
  -dt, --derep-identity DEREP_IDENTITY
                        skani ANI threshold to use for dereplication. [Default
                        is 99.0].
  -dc, --derep-coverage DEREP_COVERAGE
                        skani aligned fraction threshold to use for
                        dereplication. [Default is 95.0].
  -di, --derep-inflation DEREP_INFLATION
                        Inflation parameter for MCL to use for dereplication of
                        gene clusters. If not specified single-linkage clustering
                        will be used instead.
  -dsg, --derep-small-genomes
                        Run skani with the --small-genomes preset for
                        dereplication - recommended if dealing
                        with lots of gene cluster instances that are < 20 kb
                        in length (requires skani version > 0.2.2).
  -rp, --reinflate-params REINFLATE_PARAMS
                        Parameters for running DIAMOND blastp-based re-inflation,
                        please surround argument input with double quotes.
                        First value should be the DIAMOND blastp search mode,
                        second should be identity threshold to match non-rep
                        proteins to rep proteins, and third should be the
                        non-rep protein coverage threshold to the rep [Default
                        is "fast 98.0 95.0"].
  -dom, --domain-mode   Run zol in domain mode instead of standard full
                        protein/CDS mode.
  -cml, --ccds-min-length CCDS_MIN_LENGTH
                        Minimum length of chopped CDS (cCDS) features to keep.
                        Relavent to 'domain-mode'. [Default is 50aa].
  -pfp, --pfam-params PFAM_PARAMS
                        Parameters for controlling Pfam domain annotation with
                        PyHMMER. String with three space-separated parts:
                        1) Domain filtering mode (Domain or Full)
                        2) Score cutoff (Gathering, Trusted, Noise, or None)
                        3) E-value threshold (float)
                        [Default is "Domain Gathering 10.0"].
  -egc, --eukaryotic-gene-cluster
                        Specify if input are eukaryotic gene clusters.
                        Tells zol to avoid converting V or L residues to M when
                        translating cCDS nucleotides in domain mode.
  -ibc, --impute-broad-conservation
                        Impute weighted conservation stats based on cluster
                        size associated with dereplicated representatives.
  -ces, --comprehensive-evo-stats
                        Compute evolutionary statistics for non-single-copy
                        ortholog groups.
  -aec, --allow-edge-cds
                        Include CDS features within gene-cluster GenBanks with the
                        attribute "near_scaffold_edge = True", which is set by fai
                        for features within 2kb of contig edges.
  -qa, --quality-align  Use MUSCLE align instead of super5 for alignments - slower
                        but more accurate.
  -b, --betard-analysis
                        Compute Beta-RD-gc statsitics - off by default because
                        it requires a lot of memory for large gene
                        cluster sets.
  -s, --selection-analysis
                        Run selection analysis using HyPhy's GARD
                        BUSTED, and FUBAR methods. Warning, can take a while
                        to run.
  -sg, --skip-gard      Skip GARD detection of recombination breakpoints
                        prior to running FUBAR selection analysis. Less
                        accurate than running with GARD preliminary analysis,
                        but much faster.
  -sb, --skip-busted    Skip BUSTED selection analysis.
  -gto, --gard-timeout GARD_TIMEOUT
                        Minutes to allow GARD to run before timing out
                        and using the initial alilgnment for downstream
                        selection analyses instead [Default is 60].
  -cd, --custom-database CUSTOM_DATABASE
                        Path to FASTA file of protein sequences corresponding
                        to a custom annotation database.
  -f, --focal-genbanks FOCAL_GENBANKS
                        File with focal gene clusters listed by GenBank
                        file name (one per line).
  -fc, --comparator-genbanks COMPARATOR_GENBANKS
                        Optional file with comparator gene clusters listed.
                        Default is to use remaining GenBanks as comparators
                        to focal listing.
  -oo, --only-orthogroups
                        Only compute ortholog groups and stop (runs up to step 2).
  -po, --precomputed-orthogroups PRECOMPUTED_ORTHOGROUPS
                        Path to two-column tab delimited file where the first
                        column corresponds to locus_tags and the second column
                        to corresponding orthogroup identifiers. Requires
                        locus tags to be non-overlapping across input gene
                        cluster GenBank files and ortholog designations
                        for all CDS locus tags.
  -sc, --skip-cleanup   Whether to skip cleanup of temporary files in the
                        'Determine_Orthogroups/' subdirectory.
  -sa, --skip-annotations
                        Whether to skip performing functional annotations.
  -c, --threads THREADS
                        The number of threads to use.
  -mm, --max-memory MAX_MEMORY
                        Uses resource module to set soft memory limit. Provide in
                        Giga-bytes. Configured in the shell environment
                        [Default is None].
  -l, --length LENGTH   Specify the height/length of the heatmap plot [Default
                        is 7; experimental].
  -w, --width WIDTH     Specify the width of the heatmap plot [Default is 14].
  -fgl, --full-genbank-labels
                        Use full GenBank labels instead of just the first 20
                        characters for heatmap plot.
  -v, --version         Get version and exit.
```

