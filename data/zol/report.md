# zol CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| zol | Failed | image problem: hmmbuild in the image lacks libopenblas.so.0, so zol stops at the profile step |
| zol_abon | Not completed | needs antiSMASH or GECCO results; no such real results available |
| zol_apos | Not completed | needs MOB-suite or geNomad results; no such real results available |
| zol_atpoc | Not completed | needs PhiSpy, VIBRANT or geNomad results; no such real results available |
| zol_cgc | Failed | image problem: needs zol results, and zol stops at hmmbuild (libopenblas.so.0 missing) |
| zol_cgcg | Failed | image problem: needs zol results, and zol stops at hmmbuild (libopenblas.so.0 missing) |
| zol_fai | PASS |  |
| zol_prepTG | PASS |  |
| zol_salt | Failed | image problem: step 4 needs the ribosomal protein HMM database, which the image does not ship; zol tries to download it into the read-only image db folder and curl fails on write; with fai results staged at the same fixed path (/zol_work) salt gets through step 3 |
| zol_zol-scape | Not completed | needs BiG-SCAPE input and results; none available |

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

## zol_prepTG

### Tool Description
Prepares a directory of target genomes for being searched for query gene clusters using fai.

### Metadata
- **Docker Image**: quay.io/biocontainers/zol:1.6.17--py312hf731ba3_1
- **Homepage**: https://github.com/Kalan-Lab/zol
- **Package**: https://anaconda.org/channels/bioconda/packages/zol/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: prepTG [-h] [-i INPUT_DIR] [-g GTDB_TAXON] [-gr GTDB_RELEASE]
              [-d DOWNLOAD_PREMADE] -o OUTPUT_DIR [-r] [-enl] [-ent]
              [-l LOCUS_TAG_LENGTH] [-gcm GENE_CALLING_METHOD] [-m]
              [-rp REFERENCE_PROTEOME] [-cst] [-ma] [-cp COLLAPSING_PARAMS]
              [-sd] [-rc] [-c THREADS] [-mm MAX_MEMORY] [-v]

Program: prepTG
Author: Rauf Salamzade
Affiliation: Kalan Lab, UW Madison, Department of Medical Microbiology and Immunology

Prepares a directory of target genomes for being searched for query gene clusters using fai.

Premade databases of representative genomes are available for the following genera:

Acinetobacter (n = 1, 643), Bacillales (n = 3, 150), Corynebacterium (n = 726),
Enterobacter (n = 878), Enterococcus (n = 937), Escherichia (n = 2, 436),
Klebsiella (n = 1, 022), Listeria (n = 353), Mycobacterium (n = 744),
Pseudomonas (n = 2, 666), Salmonella (n = 308), Staphylococcus (n = 496),
Streptomyces (n = 1, 555), Streptococcus (n = 2, 452), Cutibacterium (n = 27),
Neisseria (n = 414), Lactobacillus (n = 541), and Micromonospora (n = 211).

In addition, users can simply request all genomes belonging to a specific species/genus
in GTDB to be downloaded.

---------------------------------------------------------------------------------------
> Example commands:

1. Setup a prepTG database which includes some local genomes in FASTA format

    $ prepTG -i User_Genomes_Directory/

2. Setup a prepTG database which includes some local genomes and all Cutibacterium
   granulosum genomes in GTDB:

   $ prepTG -i User_Genomes_Directory/ -g "Cutibacterium granulosum" -o prepTG_Database/

3. Setup local prepTG database by downloading a premade one of representative
   Cutibacterium genomes:

   $ prepTG -d Cutibacterium -o prepTG_Database/

---------------------------------------------------------------------------------------
> Considerations
- If FASTA format is provided, assumption is that genomes are prokaryotic and
  pyrodigal/prodigal will be used to perform gene-calling. Eukaryotic genomes can
  be provided as FASTA format but the --reference-proteome file should be used in
  such case to map proteins from a reference proteome (from the same species ideally)
  onto the target genomes. This will prevent detection of new genes in gene-clusters
  detected by fai but synchronize gene-calling and allow for better similarity
  assessment between orthologous genes.

- If you are interested in inferring horizontal gene transfer using salt downstream
  and are working with bacterial genomes - consider issuing the "--mge-annotation"
  flag to annotate phage, plasmid and IS element associated proteins in target
  genomes.

- If GenBank files are provided, CDS features are expected and further each CDS
  feature should contain a "translation" qualifier which features the protein sequence
  and optionally a "locus_tag" qualifier. Options to consider when providing GenBank
  files as input include --rename-locus-tags, --error-no-lt, and --error-no-translation.
  Note, by default, if a CDS does not feature a locus tag, it will be given an arbitrary
  one. Also, if a CDS does not feature a translation, the CDS feature will be skipped.
  If >10% of CDS features are skipped for lacking a translation, then the entire genome
  will be skipped.

- DIAMOND linclust (on by default) is an approximate clustering, for more information on
  its impact, please see the prepTG wiki page:
  https://github.com/Kalan-Lab/zol/wiki/1.-more-info-on-prepTG

Options:
  -h, --help            show this help message and exit
  -i, --input-dir INPUT_DIR
                        Directory with target genomes (either featuring GenBanks or FASTAs).
  -g, --gtdb-taxon GTDB_TAXON
                        Name of a GTDB valid genus or species to incorporate genomes from.
                        Should be surrounded by
                        quotes (e.g. 'Escherichia coli').
  -gr, --gtdb-release GTDB_RELEASE
                        GTDB release to use. [Current default is R226].
  -d, --download-premade DOWNLOAD_PREMADE
                        Download and setup pre-made databases of representative genomes
                        for specific taxon/genus. Provide name of the taxon,
                        e.g. "Escherichia"
  -o, --output-dir OUTPUT_DIR
                        Output directory, which can then be provided as input for the
                        "-tg" argument in fai.
  -r, --rename-locus-tags
                        Whether to rename all locus tags for CDS features if provided
                        GenBanks as input.
  -enl, --error-no-lt   Do not rename locus tags if not found/other issue -
                        will result in skipping inclusion of entire genome.
  -ent, --error-no-translation
                        Do not skip CDS without translation -
                        will result in skipping inclusion of entire genome.
  -l, --locus-tag-length LOCUS_TAG_LENGTH
                        Length of locus tags to set. [Default is 3,
                        allows for < ~18k genomes].
  -gcm, --gene-calling-method GENE_CALLING_METHOD
                        Method to use for gene calling. Options are: pyrodigal, prodigal,
                        or prodigal-gv. [Default is pyrodigal].
  -m, --meta-mode       Flag to use meta mode instead of single for pyrodigal/prodigal.
  -rp, --reference-proteome REFERENCE_PROTEOME
                        Provide path to a reference proteome to use for protein/
                        gene-calling in target genomes - which should be in FASTA
                        format.
  -cst, --create-species-tree
                        Use skani to infer a neighbor-joing based species
                        tree for the genomes.
  -ma, --mge-annotation
                        Perform MGE annotation of proteins - for
                        bacterial genomes only.
  -cp, --collapsing-params COLLAPSING_PARAMS
                        DIAMOND linclust parameters used for collapsing proteins for
                        creating DIAMOND database. [Default is "--approx-id 90
                        --mutual-cover 90"].
  -sd, --skip-diamond-linclust
                        Skip DIAMOND linclust clustering of proteins.
  -rc, --recluster      Perform DIAMOND recluster to improve protein clustering.
  -c, --threads THREADS
                        The number of threads to use. [Default is 1].
  -mm, --max-memory MAX_MEMORY
                        Uses resource module to set soft memory limit. Provide
                        in Giga-bytes. Configured in the shell environment. For
                        DIAMOND linclust if this parameter is not set it will default
                        to using a memory of 16GB. [Default is None].
  -v, --version         Get version and exit.
```

## zol_fai

### Tool Description
Finds additional instances of a query gene cluster in target genomes prepared by prepTG.

### Metadata
- **Docker Image**: quay.io/biocontainers/zol:1.6.17--py312hf731ba3_1
- **Homepage**: https://github.com/Kalan-Lab/zol
- **Package**: https://anaconda.org/channels/bioconda/packages/zol/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: fai [-h] -tg TARGET_GENOMES_DB [-i QUERY_INPUTS [QUERY_INPUTS ...]]
           [-r REFERENCE_GENOME] [-rc REFERENCE_CONTIG] [-rs REFERENCE_START]
           [-re REFERENCE_END] [-pq PROTEIN_QUERIES] [-sq SINGLE_QUERY] -o
           OUTPUT_DIR [-dm] [-fp] [-rgv] [-e EVALUE_CUTOFF] [-m MIN_PROP]
           [-kpq KEY_PROTEIN_QUERIES] [-skpv] [-kpe KEY_PROTEIN_EVALUE_CUTOFF]
           [-kpm KEY_PROTEIN_MIN_PROP] [-sct SYNTENIC_CORRELATION_THRESHOLD]
           [-gdm GC_DELINEATION_MODE] [-f FLANKING_CONTEXT]
           [-mgd MAX_GENES_DISCONNECT] [-mdg MIN_DISTINCT_GENES]
           [-gt GC_TRANSITION] [-bt BG_TRANSITION] [-ge GC_EMISSION]
           [-be BG_EMISSION] [-gp] [-ds DIAMOND_SENSITIVITY]
           [-dbs DIAMOND_BLOCK_SIZE] [-st SPECIES_TREE]
           [-phl PHYLOHEATMAP_LENGTH] [-phw PHYLOHEATMAP_WIDTH] [-c THREADS]
           [-cl] [-mm MAX_MEMORY] [-v]

    Program: fai
    Author: Rauf Salamzade
    Affiliation: Kalan Lab, UW Madison, Department of Medical Microbiology and
        Immunology

         .o88o.            o8o
         888 `"            `"'
        o888oo   .oooo.   oooo
         888    `P  )88b  `888
         888     .oP"888   888
         888    d8(  888   888
        o888o   `Y888""8o o888o

    MODES OF INPUT:
    *********************************************************************************

    Type 1: Directory of Homologous Gene-Cluster GenBanks
    (GenBanks must have CDS features with locus_tag or protein_id names)
    -----------------------------------------------------
    $ fai -i Known_GeneCluster.gbk -tg prepTG_Database/ -o fai_Results/

    Type 2: Reference Genome with Gene-Cluster/Locus Coordinates
    (proteins are collapsed for high-similarity using diamond linclust)
    -----------------------------------------------------
    $ fai -r Reference.fasta -rc scaffold01 -rs 40201 -re 45043 \
          -tg prepTG_Database/ -o fai_Results/

    Type 3: Set of Query Proteins (not compatible with the syntenic similarity cutoff)
    (proteins are collapsed for high-similarity using diamond linclust)
    Similar to input for cblaster
    -----------------------------------------------------
    $ fai -pq Gene-Cluster_Query_Proteins.faa -tg prepTG_Database/ -o fai_Results/

    Type 4: Single Query (provide the amino acid sequence directly)
    Similar to CORASON
    ----------------------------------------------------
    $ fai -sq Single_Query_Protein.fa -tg prepTG_Database/ -o fai_Results/

    The final set of homologous gene cluster instances within target genomes which meet
    the specified criteria can be found in the subdirectory named:
    Final_Results/Homologous_Gene_Cluster_GenBanks/

Options:
  -h, --help            show this help message and exit
  -tg, --target-genomes-db TARGET_GENOMES_DB
                        Result directory from running prepTG for target genomesof interest.
  -i, --query-inputs QUERY_INPUTS [QUERY_INPUTS ...]
                        Paths to locus-specific GenBank(s)  to use as queries for searching for
                        homologous/orthologous instances in target genomes.
                        Files must end with ".gbk", ".gbff", or ".genbank".
  -r, --reference-genome REFERENCE_GENOME
                        Path to reference genome in FASTA or GenBank format on
                        which to define query gene cluster coordinates.
  -rc, --reference-contig REFERENCE_CONTIG
                        Scaffold name (up to first space) in refernece genome
                        which features the query gene cluster.
  -rs, --reference-start REFERENCE_START
                        Start position of query gene cluster on scaffold in
                        reference genome.
  -re, --reference-end REFERENCE_END
                        End position of query gene cluster on scaffold in
                        reference genome.
  -pq, --protein-queries PROTEIN_QUERIES
                        Path to protein multi-FASTA file to use as query.
  -sq, --single-query SINGLE_QUERY
                        Path to protein FASTA file containing a single protein
                        to use as a query.
  -o, --output-dir OUTPUT_DIR
                        Output directory.
  -dm, --draft-mode     Run in draft-mode to also report segments on scaffold
                        edges which in aggregate (with other such segments) they
                        meet criteria for reporting.
  -fp, --filter-paralogs
                        Filter paralogous instances of gene-cluster identified
                        in a single target genome.
  -rgv, --use-prodigal-gv-for-reference
                        If the --reference-genome option is used to define gene
                        cluster coordinates, use prodigal-gv instead of pyrodigal
                        to call genes in the region.
  -e, --evalue-cutoff EVALUE_CUTOFF
                        E-value cutoff for DIAMOND blastp to consider a gene in a
                        target genome a hit to a query protein. [Default is 1e-5].
  -m, --min-prop MIN_PROP
                        The minimum proportion of distinct proteins/ortholog groups
                        needed to report discrete segments of the gene-cluster.
                        Note, that a minimum of 3 distinct query proteins/homolog
                        groups are needed per segment reported [Default is 0.5].
  -kpq, --key-protein-queries KEY_PROTEIN_QUERIES
                        Path to protein multi-FASTA file containing key query
                        sequences which some proportion of are required to be
                        present in a gene cluster at a specific E-value cutoff.
                        Note, these genes must be sub-contained in the set of total
                        query proteins. Otherwise, they will be ignored.
  -skpv, --skip-key-protein-validation
                        Skip validation of key protein queries against query proteins.
                        This is useful if the key protein queries are already validated
                        against the query proteins.
  -kpe, --key-protein-evalue-cutoff KEY_PROTEIN_EVALUE_CUTOFF
                        E-value cutoff for finding key query sequences in putative
                        gene cluster homolog segments. [Default is 1e-5]. Disregarded
                        if less strict than the general --evalue-cutoff.
  -kpm, --key-protein-min-prop KEY_PROTEIN_MIN_PROP
                        The minimum proportion of distinct ortholog groups matching
                        key proteins needed to report a homologous gene-cluster.
                        [Default is 0.0].
  -sct, --syntenic-correlation-threshold SYNTENIC_CORRELATION_THRESHOLD
                        The minimum syntenic correlation needed to at least
                        one known GCF instance to report segment. [Default
                        is 0.0; no syntenic assessment performed]
  -gdm, --gc-delineation-mode GC_DELINEATION_MODE
                        Method/mode for delineation of gene-cluster boundaries.
                        Options are "Gene-Clumper" or "HMM" [Default is
                        Gene-Clumper].
  -f, --flanking-context FLANKING_CONTEXT
                        Number of bases to append to the beginning/end of the
                        gene-cluster segments identified [Default is 1000].
  -mgd, --max-genes-disconnect MAX_GENES_DISCONNECT
                        Maximum number of genes between gene cluster segments
                        detected by HMM to merge segments together. Alternatively
                        the number of genes separating hits if Gene-Clumper mode
                        is used. Allows for more inclusivity of novel auxiliary
                        genes. [Default is 5].
  -mdg, --min-distinct-genes MIN_DISTINCT_GENES
                        Minimum number of distinct genes per scaffold/genome to
                        consider it further for gene-cluster containment if not
                        using -sq mode. [Default and minimum is 3].
  -gt, --gc-transition GC_TRANSITION
                        Probability for gene-cluster to gene cluster transition
                        in HMM. Should be between 0.0 and 1.0. [Default is 0.9].
  -bt, --bg-transition BG_TRANSITION
                        Probability for background to background transition
                        in HMM. Should be between 0.0 and 1.0. [Default is 0.9].
  -ge, --gc-emission GC_EMISSION
                        Emission probability of gene being in gene cluster
                        state assuming a orthologis found at the e-value cutoff.
                        [Default is 0.95].
  -be, --bg-emission BG_EMISSION
                        Emission probability of gene being in gene cluster
                        state assuming no homolog is found at the e-value cutoff.
                        [Default is 0.2].
  -gp, --generate-plots
                        Generate red barplots for assessing gene cluster
                        segments identified.
  -ds, --diamond-sensitivity DIAMOND_SENSITIVITY
                        DIAMOND alignment sensitivity. Options include: default,
                        fast, mid-sensitive, sensitive, more-sensitive,
                        very-sensitive, and ultra-sensitive [Default is
                        very-sensitive].
  -dbs, --diamond-block-size DIAMOND_BLOCK_SIZE
                        DIAMOND block size - increased value will result in increased
                        memory usage but faster execution. Check out the DIAMOND wiki
                        for more details. [Default is None, use whatever the DIAMOND
                        default is for the sensitivity mode selected.]
  -st, --species-tree SPECIES_TREE
                        Phylogeny in Newick format - with names matching
                        target genomes db [Optional]. Will be used for
                        creating an extra visual.
  -phl, --phyloheatmap-length PHYLOHEATMAP_LENGTH
                        Specify the height/length of the phylo-heatmap
                        plot [Default is 7].
  -phw, --phyloheatmap-width PHYLOHEATMAP_WIDTH
                        Specify the width of the phylo-heatmap plot
                        [Default is 10].
  -c, --threads THREADS
                        The number of threads to use [Default is 1].
  -cl, --clean-up       Clean up disk-heavy files/folders.
  -mm, --max-memory MAX_MEMORY
                        Uses resource module to set soft memory limit. Provide
                        in Giga-bytes. Configured in the shell environment
                        [Default is None; experimental].
  -v, --version         Get version and exit.
```

## zol_cgc

### Tool Description
Plots a comparative gene cluster schematic from zol results.

### Metadata
- **Docker Image**: quay.io/biocontainers/zol:1.6.17--py312hf731ba3_1
- **Homepage**: https://github.com/Kalan-Lab/zol
- **Package**: https://anaconda.org/channels/bioconda/packages/zol/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: cgc [-h] -i ZOL_RESULTS_DIR -o OUTDIR [-t TRACKS [TRACKS ...]]
           [-c COLOR_SCHEMES [COLOR_SCHEMES ...]]
           [-cc CUSTOM_COLOR_SCHEME_FILE] [-d ANNOTATION_DB_FAA]
           [-ol OG_LABEL_FILE] [-m MIN_CONSERVATION]
           [-rh RELATIVE_HEIGHTS [RELATIVE_HEIGHTS ...]] [-sl]
           [-ld LABEL_DISTANCE] [-lts LABEL_TEXT_SIZE] [-sc]
           [-q SQUISH_FACTOR] [-b BOTTOM_SPACING] [-fl FOCAL_SET_TITLE]
           [-cl COMPARATOR_SET_TITLE] [-lgs LEGEND_TITLE_SIZE] [-nl] [-p]
           [-l LENGTH] [-w WIDTH]

    Program: cgc
    Author: Rauf Salamzade
    Affiliation: Kalan Lab, UW Madison, Department of Medical Microbiology and
        Immunology

    collapsed gene clusters (cgc; pun: see(ಠಠ)-gc)

    cgc is a visualization tool that takes as input zol results and uses R libraries for
    plotting to generate a customizable figure that collapses information across hundreds
    to thousands of gene cluster instances in a "collapsed" figure.

    ---------------------------------------------------------------------------------------------
    Accepted tracks:
    ---------------------------------------------------------------------------------------------
    - conservation, tajimas_d, entropy, upstream_entropy, median_beta_rd, max_beta_rd, median_gc,
      bgc_score, viral_score, busted_pval.

    If comparative analysis was performed in zol, then addtional tracks include:
    - focal_conservation, alternate_conservation, fst

    ---------------------------------------------------------------------------------------------
    Color scheme options:
    ---------------------------------------------------------------------------------------------
    - white_to_black, red_white_blue, light_to_dark_gold, light_to_dark_blue, light_to_dark_green,
    light_to_dark_purple, light_to_dark_red, grey, black, blue, red, purple, green, gold.

    Color scheme detailed customization can be performed by providing a tab delimited file with
    four columns: (1) track_name,
        (2) low-value color (hex code),
        (3) mid-value color (hex code),

    (4) high-value color (hex-code).

    ---------------------------------------------------------------------------------------------
    Example command:
    ---------------------------------------------------------------------------------------------
    cgc -i zol_Results_Directory/ -t conservation tajimas_d -c white_to_black blue_white_red

Options:
  -h, --help            show this help message and exit
  -i, --zol-results-dir ZOL_RESULTS_DIR
                        Path to zol results directory.
  -o, --outdir OUTDIR   Output directory for cgc analysis.
  -t, --tracks TRACKS [TRACKS ...]
                        Tracks to use, note the first track is used to color the gene
                        schematic directly. Should be provided in desired order (bottom
                        to top) [Default is 'conservation tajimas_d']
  -c, --color-schemes COLOR_SCHEMES [COLOR_SCHEMES ...]
                        Specify default color schemes avaibility by name in desired
                        order matching --tracks [Default is 'white_to_black blue_white_red'].
  -cc, --custom-color-scheme-file CUSTOM_COLOR_SCHEME_FILE
                        Tab-delimited file with 4 columns: (1) track_name, (2) low-value
                        color hexcode, (3) mid-value color hexcode, (4) high-value color hexcode.
  -d, --annotation-db-faa ANNOTATION_DB_FAA
                        A FASTA file of proteins with headers to match to ortholog group
                        consensus sequences. Will then use headers of matches (up until first
                        space) as ortholog labels.
  -ol, --og-label-file OG_LABEL_FILE
                        Tab-delimited file with 2 columns: (1) ortholog group ID, (2) desired
                        label.
  -m, --min-conservation MIN_CONSERVATION
                        Minimum proportion of gene clusters an ortholog group needs to be found
                        in to be shown in the figure [Default is 0.1].
  -rh, --relative-heights RELATIVE_HEIGHTS [RELATIVE_HEIGHTS ...]
                        Relative heights of individual tracks [Default is '1 1']
  -sl, --show-labels    Show labels which by default are OG identifiers, if --og_label_file
                        or --annotatIon_db_faa are not specified.
  -ld, --label-distance LABEL_DISTANCE
                        The distance between genes and labels [Default is 0.025].
  -lts, --label-text-size LABEL_TEXT_SIZE
                        Label text size [Default is 2.0].
  -sc, --show-copy-count-status
                        Show whether genes are single-copy or not.
  -q, --squish-factor SQUISH_FACTOR
                        A numeric value controlling vertical squishing of tracks in the plot - this
                        value should be negative to squish or positive to give more space and
                        proportional to the values provided for relative heights [Default is 0]
  -b, --bottom-spacing BOTTOM_SPACING
                        Extra space for bottom of the plot to make sure legend does not get cut off.
                        Should be proportional to values for relative heights [Default is 0.1].
  -fl, --focal-set-title FOCAL_SET_TITLE
                        Title to use for the focal set conservation track if requested.
                        If spaces present, surround by quotes [Default is 'Focal Set Conservation'].
  -cl, --comparator-set-title COMPARATOR_SET_TITLE
                        Title to use for the alternate set conservation track if requested. If spaces
                        present, surround by quotes [Default is 'Comparator Set Conservation'].
  -lgs, --legend-title-size LEGEND_TITLE_SIZE
                        Change legend title size [Default is 10].
  -nl, --no-legend      Do not show legend for coloring of the gene schematic.
  -p, --png             Create plot as PNG, default is PDF.
  -l, --length LENGTH   Specify the height/length of the heatmap plot in inches [Default is 7].
  -w, --width WIDTH     Specify the width of the heatmap plot in inches [Default is 7].
```

## zol_cgcg

### Tool Description
Builds a collapsed gene clusters graph from zol results.

### Metadata
- **Docker Image**: quay.io/biocontainers/zol:1.6.17--py312hf731ba3_1
- **Homepage**: https://github.com/Kalan-Lab/zol
- **Package**: https://anaconda.org/channels/bioconda/packages/zol/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: cgcg [-h] -i ZOL_RESULTS_DIR -o OUTDIR [-c COLOR_TRACK] [-vl LOW_VALUE]
            [-vh HIGH_VALUE] [-cl LOW_VALUE_COLOR] [-ch HIGH_VALUE_COLOR]
            [-nc NA_VALUE_COLOR] [-mc MIN_CONSERVATION] [-mer MIN_EDGE_RATIO]
            [-sl] [-cul CUSTOM_LABELS] [-cuc CUSTOM_COLORS] [-as ARROW_SIZE]
            [-nbs NODE_BORDER_SIZE] [-f] [-u] [-bc BACKGROUND_COLOR] [-sm]

    Program: cgcg
    Author: Rauf Salamzade
    Affiliation: Kalan Lab, UW Madison, Department of Medical Microbiology and
        Immunology

    collapsed gene clusters graph (cgcg; pun: see(ಠಠ)-gcg)

    cgcg takes as input a zol results directory and uses the gravis library to summarize
    gene clusters into a graphical representation where nodes are ortholog groups and
        edges
    indicate the Markovian information determined by zol as part of its algorithm for
    determining consensus order/direction. The coloring of the node corresponds to a
    quantitative evolutionary statistic. The size of the node is the median length in 100 bp
    units. The border color of the node indicates whether it is in the sense or
        antisense
    direction. It is inspired by various pangenome graph visualization software and
        the STRING
    web application by the Bork lab.

    Note, if you want to remove border colors - you can do so by setting --node-border-size to 0,
    but then you should probably also switch to an undirected graph to avoid misintrepretation
    of gene order/directionality.

    Also, the "major path" which can be shown in gold is simply the path which is most supported
    across gene cluster instances, it is not all inclusive of every ortholog group like the
    consensus path calculated in zol.
    ---------------------------------------------------------------------------------------------
    Example command:
    ---------------------------------------------------------------------------------------------
    $ cgcg -i zol_Results_Directory/ -o cgcg_Results/ --color-track conservation
    ---------------------------------------------------------------------------------------------
    Citation notice:
    ---------------------------------------------------------------------------------------------
    - gravis: Interactive graph visualizations with Python and HTML/CSS/JS.
      https: //github.com/robert-haas/gravis by Haas 2021.

    - zol & fai: large-scale targeted detection and
        evolutionary investigation of gene clusters
        NAR, Salamzade et al. 2025

Options:
  -h, --help            show this help message and exit
  -i, --zol-results-dir ZOL_RESULTS_DIR
                        Path to zol results directory.
  -o, --outdir OUTDIR   Output directory.
  -c, --color-track COLOR_TRACK
                        The track from the zol spreadsheet to use for coloring.
                        Options include: conservation, tajimas_d, entorpy,
                        upstream_entropy, median_beta_rd, max_beta_rd, fst,
                        alternative_conservation, bgc_score, viral_score,
                        busrted_pval. [Default is conservation].
  -vl, --low-value LOW_VALUE
                        Low value [Default is 0.0].
  -vh, --high-value HIGH_VALUE
                        High value [Default is 1.0].
  -cl, --low-value-color LOW_VALUE_COLOR
                        Hex code for color for low-value. Surround by quotes
                        [Default is '#a2b7e8'].
  -ch, --high-value-color HIGH_VALUE_COLOR
                        Hex code for color for high-value. Surround by quotes
                        [Default is '#102f75'].
  -nc, --na-value-color NA_VALUE_COLOR
                        The hex code for setting color of NA/non-numeric values.
                        Suround by quotes. [Default is '#adadad'].
  -mc, --min-conservation MIN_CONSERVATION
                        Minimum conservation of ortholog group to be shown
                        [Default is 0.25].
  -mer, --min-edge-ratio MIN_EDGE_RATIO
                        Minimum ratio of weight between two ortholog groups
                        to the maximum weight observed to be shown [Default is 0.05].
  -sl, --show-labels    Show orthogroup labels.
  -cul, --custom-labels CUSTOM_LABELS
                        Tab-separated file with OG identifiers as first column
                        and labels to use as the second column.
  -cuc, --custom-colors CUSTOM_COLORS
                        Tab-separated file with OG identifiers as first column
                        and hex-code for colors to use as the second column.
  -as, --arrow-size ARROW_SIZE
                        Arrow size [Default is 10].
  -nbs, --node-border-size NODE_BORDER_SIZE
                        Node border size [Default is 1].
  -f, --flip            Flag to flip the direction of arrows and the border
                        coloring for orthogroup consensus direction.
  -u, --undirected-graph
                        Flag for hiding arrows.
  -bc, --background-color BACKGROUND_COLOR
                        The background color. Surround by quotes [Default is
                        "#FFFFFF"].
  -sm, --show-major-path
                        Flag to show edges which belong to the major path in
                        gold.
```

## zol_abon

### Tool Description
Assesses the conservation of the biosynthetic gene clusters of a sample genome across target genomes.

### Metadata
- **Docker Image**: quay.io/biocontainers/zol:1.6.17--py312hf731ba3_1
- **Homepage**: https://github.com/Kalan-Lab/zol
- **Package**: https://anaconda.org/channels/bioconda/packages/zol/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: abon [-h] [-a ANTISMASH_RESULTS] [-g GECCO_RESULTS] -tg
            TARGET_GENOMES_DB [-fo FAI_OPTIONS] [-s]
            [-si SIMPLE_BLASTP_IDENTITY_CUTOFF]
            [-sc SIMPLE_BLASTP_COVERAGE_CUTOFF]
            [-se SIMPLE_BLASTP_EVALUE_CUTOFF]
            [-sk SIMPLE_BLASTP_KEY_PROTEINS_PROPORTION_CUTOFF]
            [-sm SIMPLE_BLASTP_SENSITIVITY_MODE] -o OUTDIR [-c THREADS]

    Program: abon
    Author: Rauf Salamzade
    Affiliation: Kalan Lab, UW Madison, Department of Medical Microbiology and Immunology

    abon - Assess BGC-Ome Novelty

    abon wraps fai to assess the novelty of a sample's BGC-ome relative to a set of target genomes.
    Alternatively, it can run a simple DIAMOND BLASTp analysis to just assess the presence of BGC genes
    individually - without the requirement they are co-located like in the focal sample's BGCs.

Options:
  -h, --help            show this help message and exit
  -a, --antismash-results ANTISMASH_RESULTS
                        Path to antiSMASH BGC prediction results directory for a
                        single sample/genome.
  -g, --gecco-results GECCO_RESULTS
                        Path to GECCO BGC prediction results directory for a
                        single sample/genome.
  -tg, --target-genomes-db TARGET_GENOMES_DB
                        prepTG database directory for target genomes of interest.
  -fo, --fai-options FAI_OPTIONS
                        Provide fai options to run. Should be surrounded by quotes.
                        [Default is '-skpv -kpm 0.75 -kpe 1e-10 -e 1e-10 -m 0.5 -dm -sct 0.6']
  -s, --use-simple-blastp
                        Use a simple DIAMOND BLASTp search with no requirement for
                        co-localization of hits.
  -si, --simple-blastp-identity-cutoff SIMPLE_BLASTP_IDENTITY_CUTOFF
                        If simple BLASTp mode requested: cutoff for identity between
                        query proteins and matches in target genomes [Default is 40.0].
  -sc, --simple-blastp-coverage-cutoff SIMPLE_BLASTP_COVERAGE_CUTOFF
                        If simple BLASTp mode requested: cutoff for coverage between
                        query proteins and matches in target genomes [Default is 70.0].
  -se, --simple-blastp-evalue-cutoff SIMPLE_BLASTP_EVALUE_CUTOFF
                        If simple BLASTp mode requested: cutoff for E-value between query
                        proteins and matches in target genomes [Default is 1e-5].
  -sk, --simple-blastp-key-proteins-proportion-cutoff SIMPLE_BLASTP_KEY_PROTEINS_PROPORTION_CUTOFF
                        If simple BLASTp mode requested: cutoff for proportion of key proteins
                        needed to consider a BGC as present in a target genome [Default is 0.75].
  -sm, --simple-blastp-sensitivity-mode SIMPLE_BLASTP_SENSITIVITY_MODE
                        Sensitivity mode for DIAMOND BLASTp. [Default is "very-sensititve"].
  -o, --outdir OUTDIR   Output directory.
  -c, --threads THREADS
                        The number of threads to use [Default is 1].
```

## zol_atpoc

### Tool Description
Assesses the conservation of the temperate phage-ome of a sample genome in target genomes.

### Metadata
- **Docker Image**: quay.io/biocontainers/zol:1.6.17--py312hf731ba3_1
- **Homepage**: https://github.com/Kalan-Lab/zol
- **Package**: https://anaconda.org/channels/bioconda/packages/zol/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: atpoc [-h] -i SAMPLE_GENOME [-vi VIBRANT_RESULTS] [-ps PHISPY_RESULTS]
             [-gn GENOMAD_RESULTS] -tg TARGET_GENOMES_DB [-up]
             [-fo FAI_OPTIONS] [-s] [-si SIMPLE_BLASTP_IDENTITY_CUTOFF]
             [-sc SIMPLE_BLASTP_COVERAGE_CUTOFF]
             [-se SIMPLE_BLASTP_EVALUE_CUTOFF]
             [-sm SIMPLE_BLASTP_SENSITIVITY_MODE] -o OUTDIR [-c THREADS]

    Program: atpoc
    Author: Rauf Salamzade
    Affiliation: Kalan Lab, UW Madison, Department of Medical Microbiology and
        Immunology

    atpoc - Assess Temperate Phage-Ome Conservation

    atpoc wraps fai to assess the conservation of a sample's temperate/pro-phage-ome
    relative to a set of target genomes (e.g. genomes belonging to the same genus). Alternatively,

    it can run a simple DIAMOND BLASTp analysis to just assess the presence of prophage genes
    individually - without the requirement they are co-located like in the focal sample.

Options:
  -h, --help            show this help message and exit
  -i, --sample-genome SAMPLE_GENOME
                        Path to sample genome in GenBank or FASTA format.
  -vi, --vibrant-results VIBRANT_RESULTS
                        Path to VIBRANT results directory for a single sample/genome.
  -ps, --phispy-results PHISPY_RESULTS
                        Path to PhiSpy results directory for a single sample/genome.
  -gn, --genomad-results GENOMAD_RESULTS
                        Path to GeNomad results directory for a single sample/genome.
  -tg, --target-genomes-db TARGET_GENOMES_DB
                        prepTG database directory for target genomes of interest.
  -up, --use-pyrodigal  Use default pyrodigal instead of prodigal-gv to call genes in
                        phage regions to use as queries in fai/simple-blast. This is
                        perhaps preferable if target genomes db was created with default
                        pyrodigal/prodigal.
  -fo, --fai-options FAI_OPTIONS
                        Provide fai options to run. Should be surrounded by quotes.
                        [Default is '-skpv -e 1e-10 -m 0.5 -dm -sct 0.4'].
  -s, --use-simple-blastp
                        Use a simple DIAMOND BLASTp search with no requirement for
                        co-localization of hits.
  -si, --simple-blastp-identity-cutoff SIMPLE_BLASTP_IDENTITY_CUTOFF
                        If simple BLASTp mode requested: cutoff for identity between
                        query proteins and matches in target genomes [Default is 40.0].
  -sc, --simple-blastp-coverage-cutoff SIMPLE_BLASTP_COVERAGE_CUTOFF
                        If simple BLASTp mode requested: cutoff for coverage between
                        query proteins and matches in target genomes [Default is 70.0].
  -se, --simple-blastp-evalue-cutoff SIMPLE_BLASTP_EVALUE_CUTOFF
                        If simple BLASTp mode requested: cutoff for E-value between query
                        proteins and matches in target genomes [Default is 1e-5].
  -sm, --simple-blastp-sensitivity-mode SIMPLE_BLASTP_SENSITIVITY_MODE
                        Sensitivity mode for DIAMOND BLASTp. [Default is 'very-sensititve'].
  -o, --outdir OUTDIR   Output directory.
  -c, --threads THREADS
                        The number of threads to use [Default is 1].
```

## zol_apos

### Tool Description
Assesses the conservation of the plasmids of a sample genome in target genomes.

### Metadata
- **Docker Image**: quay.io/biocontainers/zol:1.6.17--py312hf731ba3_1
- **Homepage**: https://github.com/Kalan-Lab/zol
- **Package**: https://anaconda.org/channels/bioconda/packages/zol/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: apos [-h] -i SAMPLE_GENOME [-ms MOBSUITE_RESULTS] [-gn GENOMAD_RESULTS]
            -tg TARGET_GENOMES_DB [-fo FAI_OPTIONS] [-s]
            [-si SIMPLE_BLASTP_IDENTITY_CUTOFF]
            [-sc SIMPLE_BLASTP_COVERAGE_CUTOFF]
            [-se SIMPLE_BLASTP_EVALUE_CUTOFF]
            [-sm SIMPLE_BLASTP_SENSITIVITY_MODE] -o OUTDIR [-c THREADS]

    Program: apos
    Author: Rauf Salamzade
    Affiliation: Kalan Lab, UW Madison, Department of Medical Microbiology and
        Immunology

    apos - Assess Plasmid-Ome Similarity

    apos wraps fai to assess the conservation of a sample's plasmid-ome
    relative to a set of target genomes (e.g. genomes belonging to the same genus). Alternatively,

    it can run a simple DIAMOND BLASTp analysis to just assess the presence of plasmid genes
    individually - without the requirement they are co-located in one scaffold like in the focal sample.

Options:
  -h, --help            show this help message and exit
  -i, --sample-genome SAMPLE_GENOME
                        Path to sample genome in GenBank or FASTA format.
  -ms, --mobsuite-results MOBSUITE_RESULTS
                        Path to MOB-suite (mob_recon) results directory for a single sample/genome.
  -gn, --genomad-results GENOMAD_RESULTS
                        Path to GeNomad results directory for a single sample/genome.
  -tg, --target-genomes-db TARGET_GENOMES_DB
                        prepTG database directory for target genomes of interest.
  -fo, --fai-options FAI_OPTIONS
                        Provide fai options to run. Should be surrounded by quotes. [Default is
                        "-skpv -e 1e-10 -m 0.5 -dm -sct 0.0"].
  -s, --use-simple-blastp
                        Use a simple DIAMOND BLASTp search with no requirement for co-localization
                        of hits.
  -si, --simple-blastp-identity-cutoff SIMPLE_BLASTP_IDENTITY_CUTOFF
                        If simple BLASTp mode requested: cutoff for identity between query proteins
                        and matches in target genomes [Default is 40.0].
  -sc, --simple-blastp-coverage-cutoff SIMPLE_BLASTP_COVERAGE_CUTOFF
                        If simple BLASTp mode requested: cutoff for coverage between query proteins
                        and matches in target genomes [Default is 70.0].
  -se, --simple-blastp-evalue-cutoff SIMPLE_BLASTP_EVALUE_CUTOFF
                        If simple BLASTp mode requested: cutoff for E-value between query proteins
                        and matches in target genomes [Default is 1e-5].
  -sm, --simple-blastp-sensitivity-mode SIMPLE_BLASTP_SENSITIVITY_MODE
                        Sensitivity mode for DIAMOND BLASTp. [Default is "very-sensititve"].
  -o, --outdir OUTDIR   Output directory.
  -c, --threads THREADS
                        The number of threads to use [Default is 1].
```

## zol_salt

### Tool Description
Assesses support for lateral transfer of a gene cluster across genomes searched with fai.

### Metadata
- **Docker Image**: quay.io/biocontainers/zol:1.6.17--py312hf731ba3_1
- **Homepage**: https://github.com/Kalan-Lab/zol
- **Package**: https://anaconda.org/channels/bioconda/packages/zol/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: salt [-h] -f FAI_RESULTS_DIR -tg TARGET_GENOMES_DB -o OUTDIR
            [-c THREADS]

    Program: salt
    Author: Rauf Salamzade
    Affiliation: Kalan Lab, UW Madison, Department of Medical Microbiology and Immunology

    salt - Support Assessment for Lateral Transfer

    salt performs various analyses to assess support for horizontal vs. vertical evolution
    of a gene cluster across target genomes searched using fai. It takes as input the result
    directory from fai as well as the prepTG database searched.

    salt will: (1) run codoff to assess codon usage similarities between gene clusters detected
    and their respective background genomes,
        (2) infer similarity between query gene cluster
    searched for in fai and
        detected homolog with respect to expected similarity based on
    universal ribosomal proteins,
        and (3) assess whether the scaffold the detected gene cluster is on
    features insertion-elements, phage proteins, or
        plasmid proteins (assumming --mge_annotation
    was requestd for prepTG).

    Similar to other zol programs, the final result is an auto-color-formatted XLSX spreadsheet.

Options:
  -h, --help            show this help message and exit
  -f, --fai-results-dir FAI_RESULTS_DIR
                        Path to antiSMASH BGC prediction results directory
                        for a single sample/genome.
  -tg, --target-genomes-db TARGET_GENOMES_DB
                        Result directory from running prepTG for target
                        genomes of interest.
  -o, --outdir OUTDIR   Output directory for salt analysis.
  -c, --threads THREADS
                        The number of threads to use [Default is 1].
```

## zol_zol-scape

### Tool Description
Runs zol for each gene cluster family found by BiG-SCAPE.

### Metadata
- **Docker Image**: quay.io/biocontainers/zol:1.6.17--py312hf731ba3_1
- **Homepage**: https://github.com/Kalan-Lab/zol
- **Package**: https://anaconda.org/channels/bioconda/packages/zol/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: zol-scape [-h] -i BIG_SCAPE_INPUT -r BIG_SCAPE_RESULTS -o OUTDIR
                 [-z ZOL_PARAMETERS] [-p] [-c THREADS] [-j JOBS]

    Program: zol-scape
    Author: Rauf Salamzade
    Affiliation: Kalan Lab, UW Madison, Department of Medical Microbiology and
        Immunology

    zolscape is a wrapper which runs zol for each GCF identified by BiG-SCAPE analysis to
    complement CORASON analysis.

    You can run from start to finish as such (will run 10 zol jobs at once, each using
    4 threads):

    zol-scape -i Input_Folder_to_BiG-SCAPE/ -r Result_Folder_to_BiG-SCAPE/ \
              -o ZOL-SCAPE_Results/ -j 10 -c 4

    If you are have access to an HPC and would like to parallelize using that - you
    can use the --print-mode option to create a task file which lists individual zol
    commands per line which can be parallelized on an HPC via a job array:

    zol-scape -i Input_Folder_to_BiG-SCAPE/ -r Result_Folder_to_BiG-SCAPE/ \
              -o ZOL-SCAPE_Results/ -p -c 4

    Then, after you run the printed list of zol commands, to create a finalized
    consolidated tsv/xlsx of zol results across all GCFs, simply run the command
    again, same as before:

    zol-scape -i Input_Folder_to_BiG-SCAPE/ -r Result_Folder_to_BiG-SCAPE/ \
              -o ZOL-SCAPE_Results/ -p -c 4

Options:
  -h, --help            show this help message and exit
  -i, --big-scape-input BIG_SCAPE_INPUT
                        Path to folder which was input into BiG-SCAPE.
  -r, --big-scape-results BIG_SCAPE_RESULTS
                        Path to BiG-SCAPE results directory - will be searched recursively for 'clustering' files.
  -o, --outdir OUTDIR   Output directory.
  -z, --zol-parameters ZOL_PARAMETERS
                        Parameters to pass to zol - please surround by double quotes [Default is ''].
  -p, --print-mode      Print zol commands - one per line - and exit - to allow for
                        parallelizing on an HPC using a job array.
  -c, --threads THREADS
                        The number of threads to use per zol job [Default is 1].
  -j, --jobs JOBS       The number of parallel zol jobs to run at once [Default is 1].
```

