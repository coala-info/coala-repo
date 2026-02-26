# treesapp CWL Generation Report

## treesapp_abundance

### Tool Description
Calculate query sequence abundances from read coverage.

### Metadata
- **Docker Image**: quay.io/biocontainers/treesapp:0.11.4--py39h2de1943_2
- **Homepage**: https://github.com/hallamlab/TreeSAPP
- **Package**: https://anaconda.org/channels/bioconda/packages/treesapp/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/treesapp/overview
- **Total Downloads**: 85.1K
- **Last updated**: 2025-05-07
- **GitHub**: https://github.com/hallamlab/TreeSAPP
- **Stars**: N/A
### Original Help Text
```text
usage: treesapp abundance [--overwrite] [-v] [-h] [--metric {fpkm,tpm}]
                          [-r READS [READS ...]] [-2 REVERSE [REVERSE ...]]
                          [-p {pe,se}] [--refpkg_dir REFPKG_DIR]
                          [-n NUM_THREADS] [--delete] --treesapp_output OUTPUT
                          [--report {update,nothing,append}]
                          [--stage {continue,align_map,sam_sum,summarise}]

Calculate query sequence abundances from read coverage.

Required parameters:
  --treesapp_output OUTPUT
                        Path to the directory containing TreeSAPP outputs,
                        including sequences to be used for the update.

Abundance options:
  --metric {fpkm,tpm}   Selects which normalization metric to use, FPKM or
                        TPM. [ DEFAULT = tpm ]
  -r READS [READS ...], --reads READS [READS ...]
                        FASTQ file containing to be aligned to predicted genes
                        using BWA MEM
  -2 REVERSE [REVERSE ...], --reverse REVERSE [REVERSE ...]
                        FASTQ file containing to reverse mate-pair reads to be
                        aligned using BWA MEM
  -p {pe,se}, --pairing {pe,se}
                        Indicating whether the reads are paired-end (pe) or
                        single-end (se). [ DEFAULT = pe ]

Optional arguments:
  --refpkg_dir REFPKG_DIR
                        Path to the directory containing reference package
                        pickle (.pkl) files. [ DEFAULT = treesapp/data/ ]
  --report {update,nothing,append}
                        What should be done with the abundance values? The
                        TreeSAPP classification table can be overwritten
                        (update), appended or left unchanged. [ DEFAULT =
                        append ]
  --stage {continue,align_map,sam_sum,summarise}
                        The stage(s) for TreeSAPP to execute [DEFAULT =
                        continue]

Miscellaneous options:
  --overwrite           Overwrites previously written output files and
                        directories
  -v, --verbose         Prints a more verbose runtime log
  -h, --help            Show this help message and exit
  -n NUM_THREADS, --num_procs NUM_THREADS
                        The number of CPU threads or parallel processes to use
                        in various pipeline steps [ DEFAULT = 2 ]
  --delete              Delete all intermediate files to save disk space.
```


## treesapp_assign

### Tool Description
Classify sequences through evolutionary placement.

### Metadata
- **Docker Image**: quay.io/biocontainers/treesapp:0.11.4--py39h2de1943_2
- **Homepage**: https://github.com/hallamlab/TreeSAPP
- **Package**: https://anaconda.org/channels/bioconda/packages/treesapp/overview
- **Validation**: PASS

### Original Help Text
```text
usage: treesapp assign [--overwrite] [-v] [-h] -i INPUT [INPUT ...]
                       [-o OUTPUT] [--delete] [--refpkg_dir REFPKG_DIR]
                       [-t TARGETS] [--metric {fpkm,tpm}]
                       [-r READS [READS ...]] [-2 REVERSE [REVERSE ...]]
                       [-p {pe,se}] [--trim_align] [-w MIN_SEQ_LENGTH]
                       [-m {prot,dna,rrna}] [-s {relaxed,strict}]
                       [-P HMM_COVERAGE] [-Q QUERY_COVERAGE]
                       [--min_like_weight_ratio MIN_LWR]
                       [--max_pendant_length MAX_PD]
                       [--max_evol_distance MAX_EVO]
                       [--placement_summary {aelw,max_lwr,lca}]
                       [-n NUM_THREADS] [-k {lin,rbf,poly}] [--svm]
                       [-c {meta,single}]
                       [--stage {continue,orf-call,search,align,place,classify}]
                       [--rel_abund] [-R REFTREE] [--silent]

Classify sequences through evolutionary placement.

Required parameters:
  -i INPUT [INPUT ...], --fastx_input INPUT [INPUT ...]
                        An input file containing DNA or protein sequences in
                        either FASTA or FASTQ format

Homology search arguments:
  -s {relaxed,strict}, --stringency {relaxed,strict}
                        HMM-threshold mode affects the number of query
                        sequences that advance [DEFAULT = relaxed]
  -P HMM_COVERAGE, --hmm_coverage HMM_COVERAGE
                        Minimum percentage of a profile HMM that a query
                        alignment must cover for it to be considered. [
                        DEFAULT = 80 ]
  -Q QUERY_COVERAGE, --query_coverage QUERY_COVERAGE
                        Minimum percentage of a query sequence that an
                        alignment must cover to be retained. [ DEFAULT = 80 ]

Phylogenetic placement arguments:
  --min_like_weight_ratio MIN_LWR
                        The minimum likelihood weight ratio required for an
                        EPA placement. [ DEFAULT = 0.1 ]
  --max_pendant_length MAX_PD
                        The maximum pendant length distance threshold, beyond
                        which EPA placements are unclassified. [ DEFAULT = Inf
                        ]
  --max_evol_distance MAX_EVO
                        The maximum total evolutionary distance between a
                        query and reference(s), beyond which EPA placements
                        are unclassified. [ DEFAULT = Inf ]
  --placement_summary {aelw,max_lwr,lca}
                        Controls the algorithm for consolidating multiple
                        phylogenetic placements. Max LWR will take use the
                        phylogenetic placement with greatest LWR. aELW uses
                        the taxon with greatest accumulated LWR across
                        placements.

Abundance options:
  --metric {fpkm,tpm}   Selects which normalization metric to use, FPKM or
                        TPM. [ DEFAULT = tpm ]
  -r READS [READS ...], --reads READS [READS ...]
                        FASTQ file containing to be aligned to predicted genes
                        using BWA MEM
  -2 REVERSE [REVERSE ...], --reverse REVERSE [REVERSE ...]
                        FASTQ file containing to reverse mate-pair reads to be
                        aligned using BWA MEM
  -p {pe,se}, --pairing {pe,se}
                        Indicating whether the reads are paired-end (pe) or
                        single-end (se). [ DEFAULT = pe ]
  --rel_abund           Flag indicating relative abundance values should be
                        calculated for the sequences detected

Optional arguments:
  -o OUTPUT, --output OUTPUT
                        Path to an output directory [DEFAULT = ./output/]
  --refpkg_dir REFPKG_DIR
                        Path to the directory containing reference package
                        pickle (.pkl) files. [ DEFAULT = treesapp/data/ ]
  -t TARGETS, --targets TARGETS
                        A comma-separated list specifying which reference
                        packages to use. They are to be referenced by their
                        'prefix' attribute. Use `treesapp info -v` to get the
                        available list [ DEFAULT = ALL ]
  --trim_align          Flag to turn on position masking of the multiple
                        sequence alignment [DEFAULT = False]
  -w MIN_SEQ_LENGTH, --min_seq_length MIN_SEQ_LENGTH
                        minimal sequence length after alignment trimming
                        [DEFAULT = 0]
  -m {prot,dna,rrna}, --molecule {prot,dna,rrna}
                        Type of input sequences (prot = protein; dna =
                        nucleotide; rrna = rRNA). TreeSAPP will guess by
                        default but this may be required if ambiguous.
  --svm                 Uses the support vector machine (SVM) classification
                        filter. WARNING: Unless you *really* know your refpkg,
                        you don't want this.
  -c {meta,single}, --composition {meta,single}
                        Sample composition being either a single organism or a
                        metagenome.
  --stage {continue,orf-call,search,align,place,classify}
                        The stage(s) for TreeSAPP to execute [DEFAULT =
                        continue]

Classifier arguments:
  -k {lin,rbf,poly}, --svm_kernel {lin,rbf,poly}
                        Specifies the kernel type to be used in the SVM
                        algorithm. It must be either 'lin' 'poly' or 'rbf'. [
                        DEFAULT = lin ]

Miscellaneous options:
  --overwrite           Overwrites previously written output files and
                        directories
  -v, --verbose         Prints a more verbose runtime log
  -h, --help            Show this help message and exit
  --delete              Delete all intermediate files to save disk space.
  -n NUM_THREADS, --num_procs NUM_THREADS
                        The number of CPU threads or parallel processes to use
                        in various pipeline steps [ DEFAULT = 2 ]
  -R REFTREE, --reftree REFTREE
                        [IN PROGRESS] Reference package that all queries
                        should be immediately and directly classified as (i.e.
                        homology search step is skipped).
  --silent              treesapp assign will not log anything to the console
                        if used.
```


## treesapp_colour

### Tool Description
Generates colour style and strip files for visualizing a reference package's phylogeny in iTOL based on taxonomic or phenotypic data.

### Metadata
- **Docker Image**: quay.io/biocontainers/treesapp:0.11.4--py39h2de1943_2
- **Homepage**: https://github.com/hallamlab/TreeSAPP
- **Package**: https://anaconda.org/channels/bioconda/packages/treesapp/overview
- **Validation**: PASS

### Original Help Text
```text
usage: treesapp colour [--overwrite] [-v] [-h] -r PKG_PATH [PKG_PATH ...]
                       [-n ATTRIBUTE] [-o OUTPUT]
                       [-l {domain,phylum,class,order,family,genus,species}]
                       [-p PALETTE] [--unknown_colour UN_COL] [-m MIN_PROP]
                       [-f TAXA_FILTER] [-s {u,i}] [--no_polyphyletic]

Generates colour style and strip files for visualizing a reference package's
phylogeny in iTOL based on taxonomic or phenotypic data.

Required parameters:
  -r PKG_PATH [PKG_PATH ...], --refpkg_path PKG_PATH [PKG_PATH ...]
                        Path to the reference package pickle (.pkl) file.

Inputs and Outputs:
  -n ATTRIBUTE, --attribute ATTRIBUTE
                        The reference package attribute to colour by. Either
                        'taxonomy' or a reference package's layering
                        annotation name. [ DEFAULT = 'taxonomy' ]
  -o OUTPUT, --output_dir OUTPUT
                        Path to the output directory to write the output
                        files. [ DEFAULT = ./ ]

Aesthetic options:
  -l {domain,phylum,class,order,family,genus,species}, --rank_level {domain,phylum,class,order,family,genus,species}
                        The rank to generate unique colours for [ DEFAULT =
                        'order' ]
  -p PALETTE, --palette PALETTE
                        The Seaborn colour palette to use [ DEFAULT = BrBG ]
  --unknown_colour UN_COL
                        Colour of the 'Unknown' category. [ DEFAULT = None ]

Optional arguments:
  -m MIN_PROP, --min_proportion MIN_PROP
                        Minimum proportion of sequences a group contains to be
                        coloured [ DEFAULT = 0 ]
  -f TAXA_FILTER, --filter TAXA_FILTER
                        Keywords for excluding specific taxa from the colour
                        palette. [ DEFAULT is no filter ]
  -s {u,i}, --taxa_set_operation {u,i}
                        When multiple reference packages are provided, should
                        the union (u) or intersection (i) of all labelled taxa
                        (post-filtering) be coloured? [ DEFAULT = 'u' ]
  --no_polyphyletic     Flag forcing the omission of all polyphyletic taxa
                        from the colours file.

Miscellaneous options:
  --overwrite           Overwrites previously written output files and
                        directories
  -v, --verbose         Prints a more verbose runtime log
  -h, --help            Show this help message and exit
```


## treesapp_create

### Tool Description
Create a reference package for TreeSAPP.

### Metadata
- **Docker Image**: quay.io/biocontainers/treesapp:0.11.4--py39h2de1943_2
- **Homepage**: https://github.com/hallamlab/TreeSAPP
- **Package**: https://anaconda.org/channels/bioconda/packages/treesapp/overview
- **Validation**: PASS

### Original Help Text
```text
usage: treesapp create [--overwrite] [-v] [-h] -i INPUT [INPUT ...]
                       [-o OUTPUT] [--delete] [--trim_align]
                       [-w MIN_SEQ_LENGTH] [-m {prot,dna,rrna}] [-s SCREEN]
                       [-f FILTER] [--min_taxonomic_rank {r,d,p,c,o,f,g,s}]
                       [--taxa_lca] [--taxa_norm TAXA_NORM] [--cluster]
                       [-p SIMILARITY] [--seqs2lineage SEQ_NAMES_TO_TAXA]
                       [-b BOOTSTRAPS] [-e RAXML_MODEL] [--fast]
                       [--outdet_align] [--accession2taxid ACC_TO_TAXID]
                       [-a ACC_TO_LIN] [-n NUM_THREADS] [-k {lin,rbf,poly}]
                       [--max_examples MAX_EXAMPLES] -c REFPKG_NAME
                       [--deduplicate] [--multiple_alignment] [-d PROFILE]
                       [-g GUARANTEE] [--kind {functional,taxonomic}]
                       [--stage {continue,search,lineages,clean,cluster,build,evaluate,support,train,update}]
                       [--headless]

Create a reference package for TreeSAPP.

Required parameters:
  -i INPUT [INPUT ...], --fastx_input INPUT [INPUT ...]
                        An input file containing DNA or protein sequences in
                        either FASTA or FASTQ format
  -c REFPKG_NAME, --refpkg_name REFPKG_NAME
                        Unique name to be used by TreeSAPP internally. NOTE:
                        Must be <=6 characters. Examples are 'McrA', 'DsrAB',
                        and 'p_amoA'.

Sequence operation arguments:
  --cluster             Cluster input sequences at the proportional similarity
                        indicated by identity
  -p SIMILARITY, --similarity SIMILARITY
                        Proportional similarity (between 0.50 and 1.0) to
                        cluster sequences.
  --deduplicate         Deduplicate the input sequences at 99.9 percent
                        similarity. This is a pre-processing step to require
                        fewer Entrez queries - clustering at lower resolution
                        with '--cluster' is still suggested.
  --multiple_alignment  The FASTA input is also the multiple alignment file to
                        be used.
  -d PROFILE, --profile PROFILE
                        An HMM profile representing a specific domain. Domains
                        will be excised from input sequences based on
                        hmmsearch alignments.
  -g GUARANTEE, --guarantee GUARANTEE
                        A FASTA file containing sequences that need to be
                        included in the tree after all clustering and
                        filtering

Optional arguments:
  -o OUTPUT, --output OUTPUT
                        Path to an output directory [DEFAULT = ./output/]
  --trim_align          Flag to turn on position masking of the multiple
                        sequence alignment [DEFAULT = False]
  -w MIN_SEQ_LENGTH, --min_seq_length MIN_SEQ_LENGTH
                        minimal sequence length after alignment trimming
                        [DEFAULT = 0]
  -m {prot,dna,rrna}, --molecule {prot,dna,rrna}
                        Type of input sequences (prot = protein; dna =
                        nucleotide; rrna = rRNA). TreeSAPP will guess by
                        default but this may be required if ambiguous.
  -b BOOTSTRAPS, --bootstraps BOOTSTRAPS
                        The maximum number of bootstrap replicates RAxML-NG
                        should perform using the autoMRE algorithm. [ DEFAULT
                        = 0 ]
  -e RAXML_MODEL, --raxml_model RAXML_MODEL
                        The evolutionary model for RAxML-NG to use [ Proteins
                        = LG+G4 | Nucleotides = GTR+G ]
  --fast                A flag indicating the tree should be built rapidly,
                        using FastTree.
  --outdet_align        Flag to activate outlier detection and removal from
                        multiple sequence alignments using OD-seq. [ DEFAULT =
                        False ]
  --kind {functional,taxonomic}
                        The broad classification of marker gene type, either
                        functional or taxonomic. [ DEFAULT = functional ]
  --stage {continue,search,lineages,clean,cluster,build,evaluate,support,train,update}
                        The stage(s) for TreeSAPP to execute [DEFAULT =
                        continue]

Taxonomic-lineage arguments:
  -s SCREEN, --screen SCREEN
                        Keywords for including specific taxa in the tree. To
                        only include Bacteria and Archaea use `--screen
                        Bacteria,Archaea` [ DEFAULT is no screen ]
  -f FILTER, --filter FILTER
                        Keywords for removing specific taxa; the opposite of
                        `--screen`. [ DEFAULT is no filter ]
  --min_taxonomic_rank {r,d,p,c,o,f,g,s}
                        The minimum taxonomic resolution for reference
                        sequences [ DEFAULT = r ].
  --taxa_lca            Set taxonomy of representative sequences to LCA of
                        cluster member's taxa. [ --cluster REQUIRED ]
  --taxa_norm TAXA_NORM
                        [ IN DEVELOPMENT ] Subsample leaves by taxonomic
                        lineage. A comma-separated argument with the Rank
                        (e.g. Phylum) and number of representatives is
                        required.
  --seqs2lineage SEQ_NAMES_TO_TAXA
                        Path to a file mapping sequence names to taxonomic
                        lineages.
  --accession2taxid ACC_TO_TAXID
                        Path to an NCBI accession2taxid file for more rapid
                        accession-to-lineage mapping.
  -a ACC_TO_LIN, --accession2lin ACC_TO_LIN
                        Path to a file that maps sequence accessions to
                        taxonomic lineages, possibly made by `treesapp
                        create`...

Classifier arguments:
  -k {lin,rbf,poly}, --svm_kernel {lin,rbf,poly}
                        Specifies the kernel type to be used in the SVM
                        algorithm. It must be either 'lin' 'poly' or 'rbf'. [
                        DEFAULT = lin ]
  --max_examples MAX_EXAMPLES
                        Limits the number of examples used for training
                        models. [ DEFAULT = 1000 ]

Miscellaneous options:
  --overwrite           Overwrites previously written output files and
                        directories
  -v, --verbose         Prints a more verbose runtime log
  -h, --help            Show this help message and exit
  --delete              Delete all intermediate files to save disk space.
  -n NUM_THREADS, --num_procs NUM_THREADS
                        The number of CPU threads or parallel processes to use
                        in various pipeline steps [ DEFAULT = 2 ]
  --headless            Do not require any user input during runtime.
```


## treesapp_evaluate

### Tool Description
Evaluate classification performance using clade-exclusion analysis.

### Metadata
- **Docker Image**: quay.io/biocontainers/treesapp:0.11.4--py39h2de1943_2
- **Homepage**: https://github.com/hallamlab/TreeSAPP
- **Package**: https://anaconda.org/channels/bioconda/packages/treesapp/overview
- **Validation**: PASS

### Original Help Text
```text
usage: treesapp evaluate [--overwrite] [-v] [-h] -i INPUT [INPUT ...]
                         [-o OUTPUT] [--delete] [--trim_align]
                         [-w MIN_SEQ_LENGTH] [-m {prot,dna,rrna}] -r PKG_PATH
                         [PKG_PATH ...] [--accession2taxid ACC_TO_TAXID]
                         [-a ACC_TO_LIN] [-n NUM_THREADS]
                         [--min_like_weight_ratio MIN_LWR]
                         [--max_pendant_length MAX_PD]
                         [--max_evol_distance MAX_EVO]
                         [--placement_summary {aelw,max_lwr,lca}]
                         [--taxonomic_ranks {domain,phylum,class,order,family,genus,species} [{domain,phylum,class,order,family,genus,species} ...]]
                         [--fresh] [--tool {treesapp,graftm,diamond}]
                         [-l LENGTH]
                         [--stage {continue,lineages,classify,calculate}]

Evaluate classification performance using clade-exclusion analysis.

Required parameters:
  -i INPUT [INPUT ...], --fastx_input INPUT [INPUT ...]
                        An input file containing DNA or protein sequences in
                        either FASTA or FASTQ format
  -r PKG_PATH [PKG_PATH ...], --refpkg_path PKG_PATH [PKG_PATH ...]
                        Path to the reference package pickle (.pkl) file.

Phylogenetic placement arguments:
  --min_like_weight_ratio MIN_LWR
                        The minimum likelihood weight ratio required for an
                        EPA placement. [ DEFAULT = 0.1 ]
  --max_pendant_length MAX_PD
                        The maximum pendant length distance threshold, beyond
                        which EPA placements are unclassified. [ DEFAULT = Inf
                        ]
  --max_evol_distance MAX_EVO
                        The maximum total evolutionary distance between a
                        query and reference(s), beyond which EPA placements
                        are unclassified. [ DEFAULT = Inf ]
  --placement_summary {aelw,max_lwr,lca}
                        Controls the algorithm for consolidating multiple
                        phylogenetic placements. Max LWR will take use the
                        phylogenetic placement with greatest LWR. aELW uses
                        the taxon with greatest accumulated LWR across
                        placements.

Optional arguments:
  -o OUTPUT, --output OUTPUT
                        Path to an output directory [DEFAULT = ./output/]
  --trim_align          Flag to turn on position masking of the multiple
                        sequence alignment [DEFAULT = False]
  -w MIN_SEQ_LENGTH, --min_seq_length MIN_SEQ_LENGTH
                        minimal sequence length after alignment trimming
                        [DEFAULT = 0]
  -m {prot,dna,rrna}, --molecule {prot,dna,rrna}
                        Type of input sequences (prot = protein; dna =
                        nucleotide; rrna = rRNA). TreeSAPP will guess by
                        default but this may be required if ambiguous.
  --taxonomic_ranks {domain,phylum,class,order,family,genus,species} [{domain,phylum,class,order,family,genus,species} ...]
                        A list of the taxonomic ranks (space-separated) to
                        test. [ DEFAULT = class species ]
  --fresh               Recalculate a fresh phylogenetic tree with the target
                        clades removed instead of removing the leaves
                        corresponding to targets from the reference tree.
  --tool {treesapp,graftm,diamond}
                        Classify using one of the tools: treesapp [DEFAULT],
                        graftm, or diamond.
  -l LENGTH, --length LENGTH
                        Arbitrarily slice the input sequences to this length.
                        Useful for testing classification accuracy for
                        fragments.
  --stage {continue,lineages,classify,calculate}
                        The stage(s) for TreeSAPP to execute [DEFAULT =
                        continue]

Taxonomic-lineage arguments:
  --accession2taxid ACC_TO_TAXID
                        Path to an NCBI accession2taxid file for more rapid
                        accession-to-lineage mapping.
  -a ACC_TO_LIN, --accession2lin ACC_TO_LIN
                        Path to a file that maps sequence accessions to
                        taxonomic lineages, possibly made by `treesapp
                        create`...

Miscellaneous options:
  --overwrite           Overwrites previously written output files and
                        directories
  -v, --verbose         Prints a more verbose runtime log
  -h, --help            Show this help message and exit
  --delete              Delete all intermediate files to save disk space.
  -n NUM_THREADS, --num_procs NUM_THREADS
                        The number of CPU threads or parallel processes to use
                        in various pipeline steps [ DEFAULT = 2 ]
```


## treesapp_layer

### Tool Description
This script adds extra feature annotations, such as Subgroup and Metabolic Pathway, to an existing classification table made by treesapp assign. A new column is bound to the table for each feature.

### Metadata
- **Docker Image**: quay.io/biocontainers/treesapp:0.11.4--py39h2de1943_2
- **Homepage**: https://github.com/hallamlab/TreeSAPP
- **Package**: https://anaconda.org/channels/bioconda/packages/treesapp/overview
- **Validation**: PASS

### Original Help Text
```text
usage: treesapp layer [--overwrite] [-v] [-h] [--refpkg_dir REFPKG_DIR] -o
                      OUTPUT

This script adds extra feature annotations, such as Subgroup and Metabolic
Pathway, to an existing classification table made by treesapp assign. A new
column is bound to the table for each feature.

Required parameters:
  -o OUTPUT, --treesapp_output OUTPUT
                        The TreeSAPP output directory.

Optional arguments:
  --refpkg_dir REFPKG_DIR
                        Path to the directory containing reference package
                        pickle (.pkl) files. [ DEFAULT = treesapp/data/ ]

Miscellaneous options:
  --overwrite           Overwrites previously written output files and
                        directories
  -v, --verbose         Prints a more verbose runtime log
  -h, --help            Show this help message and exit
```


## treesapp_package

### Tool Description
Facilitate operations on reference packages

### Metadata
- **Docker Image**: quay.io/biocontainers/treesapp:0.11.4--py39h2de1943_2
- **Homepage**: https://github.com/hallamlab/TreeSAPP
- **Package**: https://anaconda.org/channels/bioconda/packages/treesapp/overview
- **Validation**: PASS

### Original Help Text
```text
usage: treesapp package [--overwrite] [-v] [-h] [{view,edit,rename}]

Facilitate operations on reference packages

positional arguments:
  {view,edit,rename}  A subcommand specifying the type of operation to
                      perform. `treesapp package rename` must be followed only
                      by 'prefix' and the new value. Example: `treesapp
                      package rename prefix Xyz -r path/to/Xyz_build.pkl`

Miscellaneous options:
  --overwrite         Overwrites previously written output files and
                      directories
  -v, --verbose       Prints a more verbose runtime log
  -h, --help          Show this help message and exit
```


## treesapp_phylotu

### Tool Description
A tool for sorting query sequences placed on a phylogeny into phylogenetically-inferred clusters.

### Metadata
- **Docker Image**: quay.io/biocontainers/treesapp:0.11.4--py39h2de1943_2
- **Homepage**: https://github.com/hallamlab/TreeSAPP
- **Package**: https://anaconda.org/channels/bioconda/packages/treesapp/overview
- **Validation**: PASS

### Original Help Text
```text
usage: treesapp phylotu [--overwrite] [-v] [-h]
                        [--refpkg_path PKG_PATH | --refpkg_name PKG_TARGET]
                        [-o OUTPUT] [-j JPLACE [JPLACE ...] | --assign_output
                        TS_OUT [TS_OUT ...]] [-m {de_novo,ref_guided,local}]
                        [-p {psc,align}]
                        [-t {class,order,family,genus,species}] [-a ALPHA]
                        [-s SAMPLE_REGEX]
                        [--centroid_proportion CENTROID_P_HMM]
                        [-n NUM_THREADS] [--delete]

A tool for sorting query sequences placed on a phylogeny into
phylogenetically-inferred clusters.

Required parameters:
  --refpkg_path PKG_PATH
                        Path to the reference package pickle (.pkl) file.
  --refpkg_name PKG_TARGET
                        Name of the reference package to use, referenced by
                        its 'prefix' attribute, from the set packaged with
                        TreeSAPP. Use `treesapp info -v` to get the available
                        list.
  -j JPLACE [JPLACE ...], --jplace JPLACE [JPLACE ...]
                        Path to one or more JPlace files generated by
                        placement on a reference package's phylogeny.
  --assign_output TS_OUT [TS_OUT ...]
                        Path to one or more output directories of treesapp
                        assign.

Optional arguments:
  -o OUTPUT, --output OUTPUT
                        Path to an output directory [DEFAULT = ./output/]
  -m {de_novo,ref_guided,local}, --mode {de_novo,ref_guided,local}
                        The phylogentic clustering mode to use. [ DEFAULT =
                        ref_guided ].
  -p {psc,align}, --pre_cluster {psc,align}
                        The method to use for pre-clustering the classified
                        sequences, based on either placement-space ('psc') or
                        pairwise alignment ('align'). [ DEFAULT = 'psc' ]
  -t {class,order,family,genus,species}, --tax_rank {class,order,family,genus,species}
                        The taxonomic rank the cluster radius should
                        approximately represent. [ DEFAULT = 'species' ].
  -a ALPHA, --alpha ALPHA
                        The evolutionary distance threshold defining the
                        cluster boundaries. [ DEFAULT = auto ].
  -s SAMPLE_REGEX, --sample_regex SAMPLE_REGEX
                        A regular expression for parsing the sample name from
                        a query sequence name. Example: '^(\d+)\.a:.*'. [
                        DEFAULT = None ].
  --centroid_proportion CENTROID_P_HMM
                        The proportion of the reference package profile HMM a
                        candidate centroid must exceed.No sequence convering
                        less than this proportion will be used as a centroid.[
                        DEFAULT = 0.6 ]

Miscellaneous options:
  --overwrite           Overwrites previously written output files and
                        directories
  -v, --verbose         Prints a more verbose runtime log
  -h, --help            Show this help message and exit
  -n NUM_THREADS, --num_procs NUM_THREADS
                        The number of CPU threads or parallel processes to use
                        in various pipeline steps [ DEFAULT = 2 ]
  --delete              Delete all intermediate files to save disk space.
```


## treesapp_purity

### Tool Description
Validate the functional purity of a reference package.

### Metadata
- **Docker Image**: quay.io/biocontainers/treesapp:0.11.4--py39h2de1943_2
- **Homepage**: https://github.com/hallamlab/TreeSAPP
- **Package**: https://anaconda.org/channels/bioconda/packages/treesapp/overview
- **Validation**: PASS

### Original Help Text
```text
usage: treesapp purity [--overwrite] [-v] [-h] -i INPUT [INPUT ...]
                       [-o OUTPUT] [--delete] -r PKG_PATH [PKG_PATH ...]
                       [--trim_align] [-w MIN_SEQ_LENGTH] [-m {prot,dna,rrna}]
                       [-n NUM_THREADS] [-x EXTRA_INFO]
                       [--stage {continue,lineages,classify,calculate}]

Validate the functional purity of a reference package.

Required parameters:
  -i INPUT [INPUT ...], --fastx_input INPUT [INPUT ...]
                        An input file containing DNA or protein sequences in
                        either FASTA or FASTQ format
  -r PKG_PATH [PKG_PATH ...], --refpkg_path PKG_PATH [PKG_PATH ...]
                        Path to the reference package pickle (.pkl) file.

Optional arguments:
  -o OUTPUT, --output OUTPUT
                        Path to an output directory [DEFAULT = ./output/]
  --trim_align          Flag to turn on position masking of the multiple
                        sequence alignment [DEFAULT = False]
  -w MIN_SEQ_LENGTH, --min_seq_length MIN_SEQ_LENGTH
                        minimal sequence length after alignment trimming
                        [DEFAULT = 0]
  -m {prot,dna,rrna}, --molecule {prot,dna,rrna}
                        Type of input sequences (prot = protein; dna =
                        nucleotide; rrna = rRNA). TreeSAPP will guess by
                        default but this may be required if ambiguous.
  -x EXTRA_INFO, --extra_info EXTRA_INFO
                        File mapping header prefixes to description
                        information.
  --stage {continue,lineages,classify,calculate}
                        The stage(s) for TreeSAPP to execute [DEFAULT =
                        continue]

Miscellaneous options:
  --overwrite           Overwrites previously written output files and
                        directories
  -v, --verbose         Prints a more verbose runtime log
  -h, --help            Show this help message and exit
  --delete              Delete all intermediate files to save disk space.
  -n NUM_THREADS, --num_procs NUM_THREADS
                        The number of CPU threads or parallel processes to use
                        in various pipeline steps [ DEFAULT = 2 ]
```


## treesapp_train

### Tool Description
Model evolutionary distances across taxonomic ranks.

### Metadata
- **Docker Image**: quay.io/biocontainers/treesapp:0.11.4--py39h2de1943_2
- **Homepage**: https://github.com/hallamlab/TreeSAPP
- **Package**: https://anaconda.org/channels/bioconda/packages/treesapp/overview
- **Validation**: PASS

### Original Help Text
```text
usage: treesapp train [--overwrite] [-v] [-h] -i INPUT [INPUT ...] [-o OUTPUT]
                      [--delete] -r PKG_PATH [PKG_PATH ...] [--trim_align]
                      [-w MIN_SEQ_LENGTH] [-m {prot,dna,rrna}]
                      [--accession2taxid ACC_TO_TAXID] [-a ACC_TO_LIN]
                      [--seqs2lineage SEQ_NAMES_TO_TAXA]
                      [--taxonomic_ranks {domain,phylum,class,order,family,genus,species} [{domain,phylum,class,order,family,genus,species} ...]]
                      [-n NUM_THREADS] [-k {lin,rbf,poly}]
                      [--max_examples MAX_EXAMPLES] [--grid_search] [--tsne]
                      [--classifier {occ,bin}] [--annot_map ANNOT_MAP] [-d]
                      [--stage {continue,clean,search,lineages,place,train,update}]

Model evolutionary distances across taxonomic ranks.

Required parameters:
  -i INPUT [INPUT ...], --fastx_input INPUT [INPUT ...]
                        An input file containing DNA or protein sequences in
                        either FASTA or FASTQ format
  -r PKG_PATH [PKG_PATH ...], --refpkg_path PKG_PATH [PKG_PATH ...]
                        Path to the reference package pickle (.pkl) file.

Sequence operation arguments:
  -d, --profile         Input sequences will be purified with the reference
                        package's profile HMM.

Optional arguments:
  -o OUTPUT, --output OUTPUT
                        Path to an output directory [DEFAULT = ./output/]
  --trim_align          Flag to turn on position masking of the multiple
                        sequence alignment [DEFAULT = False]
  -w MIN_SEQ_LENGTH, --min_seq_length MIN_SEQ_LENGTH
                        minimal sequence length after alignment trimming
                        [DEFAULT = 0]
  -m {prot,dna,rrna}, --molecule {prot,dna,rrna}
                        Type of input sequences (prot = protein; dna =
                        nucleotide; rrna = rRNA). TreeSAPP will guess by
                        default but this may be required if ambiguous.
  --taxonomic_ranks {domain,phylum,class,order,family,genus,species} [{domain,phylum,class,order,family,genus,species} ...]
                        A list of the taxonomic ranks (space-separated) to
                        test. [ DEFAULT = class species ]
  --annot_map ANNOT_MAP
                        Path to a tabular file mapping reference (refpkg)
                        package names being tested to database corresponding
                        sequence names, indicating a true positive
                        relationship. First column is the refpkg name, second
                        is the orthologous group name and third is the query
                        sequence name.
  --stage {continue,clean,search,lineages,place,train,update}
                        The stage(s) for TreeSAPP to execute [DEFAULT =
                        continue]

Taxonomic-lineage arguments:
  --accession2taxid ACC_TO_TAXID
                        Path to an NCBI accession2taxid file for more rapid
                        accession-to-lineage mapping.
  -a ACC_TO_LIN, --accession2lin ACC_TO_LIN
                        Path to a file that maps sequence accessions to
                        taxonomic lineages, possibly made by `treesapp
                        create`...
  --seqs2lineage SEQ_NAMES_TO_TAXA
                        Path to a file mapping sequence names to taxonomic
                        lineages.

Classifier arguments:
  -k {lin,rbf,poly}, --svm_kernel {lin,rbf,poly}
                        Specifies the kernel type to be used in the SVM
                        algorithm. It must be either 'lin' 'poly' or 'rbf'. [
                        DEFAULT = lin ]
  --max_examples MAX_EXAMPLES
                        Limits the number of examples used for training
                        models. [ DEFAULT = 1000 ]
  --grid_search         Perform a grid search across hyperparameters. Binary
                        classifier only.
  --tsne                Generate a tSNE plot. Output will be in the same
                        directory as the model file. Binary classifier only.
  --classifier {occ,bin}
                        Specify the kind of classifier to be trained: one-
                        class classifier (OCC) or a binary classifier (bin). [
                        DEFAULT = occ ]

Miscellaneous options:
  --overwrite           Overwrites previously written output files and
                        directories
  -v, --verbose         Prints a more verbose runtime log
  -h, --help            Show this help message and exit
  --delete              Delete all intermediate files to save disk space.
  -n NUM_THREADS, --num_procs NUM_THREADS
                        The number of CPU threads or parallel processes to use
                        in various pipeline steps [ DEFAULT = 2 ]
```


## treesapp_update

### Tool Description
Update a reference package with assigned sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/treesapp:0.11.4--py39h2de1943_2
- **Homepage**: https://github.com/hallamlab/TreeSAPP
- **Package**: https://anaconda.org/channels/bioconda/packages/treesapp/overview
- **Validation**: PASS

### Original Help Text
```text
usage: treesapp update [--overwrite] [-v] [-h] [-o OUTPUT] [--delete]
                       [--trim_align] [-w MIN_SEQ_LENGTH] [-m {prot,dna,rrna}]
                       [--cluster] [-p SIMILARITY] [-s SCREEN] [-f FILTER]
                       [--min_taxonomic_rank {r,d,p,c,o,f,g,s}] [--taxa_lca]
                       [--taxa_norm TAXA_NORM] -r PKG_PATH [PKG_PATH ...]
                       [--min_like_weight_ratio MIN_LWR]
                       [--max_pendant_length MAX_PD]
                       [--max_evol_distance MAX_EVO]
                       [--seqs2lineage SEQ_NAMES_TO_TAXA] [-b BOOTSTRAPS]
                       [-e RAXML_MODEL] [--fast] [--outdet_align]
                       [-n NUM_THREADS] [-k {lin,rbf,poly}]
                       [--max_examples MAX_EXAMPLES] --treesapp_output TS_OUT
                       [-i INPUT [INPUT ...]] [--skip_assign] [--resolve]
                       [--stage {continue,lineages,rebuild}] [--headless]

Update a reference package with assigned sequences.

Required parameters:
  -r PKG_PATH [PKG_PATH ...], --refpkg_path PKG_PATH [PKG_PATH ...]
                        Path to the reference package pickle (.pkl) file.
  --treesapp_output TS_OUT
                        Path to the directory containing TreeSAPP outputs,
                        including sequences to be used for the update.

Sequence operation arguments:
  --cluster             Cluster input sequences at the proportional similarity
                        indicated by identity
  -p SIMILARITY, --similarity SIMILARITY
                        Proportional similarity (between 0.50 and 1.0) to
                        cluster sequences.

Phylogenetic placement arguments:
  --min_like_weight_ratio MIN_LWR
                        The minimum likelihood weight ratio required for an
                        EPA placement. [ DEFAULT = 0.1 ]
  --max_pendant_length MAX_PD
                        The maximum pendant length distance threshold, beyond
                        which EPA placements are unclassified. [ DEFAULT = Inf
                        ]
  --max_evol_distance MAX_EVO
                        The maximum total evolutionary distance between a
                        query and reference(s), beyond which EPA placements
                        are unclassified. [ DEFAULT = Inf ]

Optional arguments:
  -o OUTPUT, --output OUTPUT
                        Path to an output directory [DEFAULT = ./output/]
  --trim_align          Flag to turn on position masking of the multiple
                        sequence alignment [DEFAULT = False]
  -w MIN_SEQ_LENGTH, --min_seq_length MIN_SEQ_LENGTH
                        minimal sequence length after alignment trimming
                        [DEFAULT = 0]
  -m {prot,dna,rrna}, --molecule {prot,dna,rrna}
                        Type of input sequences (prot = protein; dna =
                        nucleotide; rrna = rRNA). TreeSAPP will guess by
                        default but this may be required if ambiguous.
  -b BOOTSTRAPS, --bootstraps BOOTSTRAPS
                        The maximum number of bootstrap replicates RAxML-NG
                        should perform using the autoMRE algorithm. [ DEFAULT
                        = 0 ]
  -e RAXML_MODEL, --raxml_model RAXML_MODEL
                        The evolutionary model for RAxML-NG to use [ Proteins
                        = LG+G4 | Nucleotides = GTR+G ]
  --fast                A flag indicating the tree should be built rapidly,
                        using FastTree.
  --outdet_align        Flag to activate outlier detection and removal from
                        multiple sequence alignments using OD-seq. [ DEFAULT =
                        False ]
  -i INPUT [INPUT ...], --fastx_input INPUT [INPUT ...]
                        An input file containing candidate reference sequences
                        in either FASTA format. Will trigger re-training the
                        reference package if provided.
  --skip_assign         The assigned sequences are from a database and their
                        database lineages should be used instead of the
                        TreeSAPP-assigned lineages.
  --resolve             Flag indicating candidate references with better
                        resolved lineages and comparable sequence lengths can
                        replace old references. Useful when updating with
                        sequences from isolates, SAGs and quality MAGs.
  --stage {continue,lineages,rebuild}
                        The stage(s) for TreeSAPP to execute [DEFAULT =
                        continue]

Taxonomic-lineage arguments:
  -s SCREEN, --screen SCREEN
                        Keywords for including specific taxa in the tree. To
                        only include Bacteria and Archaea use `--screen
                        Bacteria,Archaea` [ DEFAULT is no screen ]
  -f FILTER, --filter FILTER
                        Keywords for removing specific taxa; the opposite of
                        `--screen`. [ DEFAULT is no filter ]
  --min_taxonomic_rank {r,d,p,c,o,f,g,s}
                        The minimum taxonomic resolution for reference
                        sequences [ DEFAULT = r ].
  --taxa_lca            Set taxonomy of representative sequences to LCA of
                        cluster member's taxa. [ --cluster REQUIRED ]
  --taxa_norm TAXA_NORM
                        [ IN DEVELOPMENT ] Subsample leaves by taxonomic
                        lineage. A comma-separated argument with the Rank
                        (e.g. Phylum) and number of representatives is
                        required.
  --seqs2lineage SEQ_NAMES_TO_TAXA
                        Path to a file mapping sequence names to taxonomic
                        lineages.

Classifier arguments:
  -k {lin,rbf,poly}, --svm_kernel {lin,rbf,poly}
                        Specifies the kernel type to be used in the SVM
                        algorithm. It must be either 'lin' 'poly' or 'rbf'. [
                        DEFAULT = lin ]
  --max_examples MAX_EXAMPLES
                        Limits the number of examples used for training
                        models. [ DEFAULT = 1000 ]

Miscellaneous options:
  --overwrite           Overwrites previously written output files and
                        directories
  -v, --verbose         Prints a more verbose runtime log
  -h, --help            Show this help message and exit
  --delete              Delete all intermediate files to save disk space.
  -n NUM_THREADS, --num_procs NUM_THREADS
                        The number of CPU threads or parallel processes to use
                        in various pipeline steps [ DEFAULT = 2 ]
  --headless            Do not require any user input during runtime.
```

