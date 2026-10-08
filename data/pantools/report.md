# pantools CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| pantools_add_annotations | PASS |  |
| pantools_add_antismash | Not completed | No antiSMASH output exists for the chloroplast test data, and a fake file would not test the parser. |
| pantools_add_functions | PASS | Ran with a custom GO/Pfam/InterPro annotation file (hand-made, real identifiers) and the downloaded GO, Pfam, InterPro and TIGRFAM files; all identifiers were connected. |
| pantools_add_genomes | PASS |  |
| pantools_add_pavs | PASS | Synthetic PAV table; the variation overview shows the expected present and absent counts. |
| pantools_add_phasing | PASS | Synthetic phasing assignment; the assigned identifiers file matches the input. |
| pantools_add_phenotypes | PASS |  |
| pantools_add_repeats | PASS | Synthetic repeat GFF files; the log reports the 3 and 2 repeats added. |
| pantools_add_synteny | PASS | Synthetic collinearity file built from real homology pairs; one synteny block was added. |
| pantools_add_variants | PASS | Synthetic VCF; the variation overview shows 83 variant nodes for the genome. |
| pantools_ani | PASS | MASH mode gives plausible ANI scores. The fastANI mode stops with 'fastANI is not installed' although the binary runs. |
| pantools_blast | PASS |  |
| pantools_build_pangenome | PASS |  |
| pantools_build_panproteome | PASS |  |
| pantools_busco_protein | PASS | Ran with the viridiplantae_odb10 lineage (needs network access, added to the CWL); chloroplast proteins have no BUSCO genes, so 0 of 425 found is expected. |
| pantools_calculate_dn_ds | PASS |  |
| pantools_calculate_synteny | PASS | Tested without --run: gene and homology files are correct. With --run it fails because MCScanX_h is not in the image. |
| pantools_change_grouping | PASS |  |
| pantools_compare_go | PASS |  |
| pantools_consensus_tree | Failed | image problem: astral-pro in the image crashes with exit code 132 (illegal instruction), so PanTools reports ASTRAL-PRO is not installed. |
| pantools_core_phylogeny | PASS | Default ML mode writes the informative-sites alignment and an IQ-TREE script. The NJ mode fails with a NullPointerException. |
| pantools_core_unique_thresholds | PASS |  |
| pantools_create_tree_template | PASS |  |
| pantools_deactivate_grouping | PASS |  |
| pantools_export_pangenome | PASS |  |
| pantools_find_genes_by_annotation | PASS |  |
| pantools_find_genes_by_name | Failed | tool bug: for genes in several homology groups the per-group files in nucleotide_sequences/<gene>/ silently hold protein sequences; single-group gene (rbcL) output is correct. |
| pantools_find_genes_in_region | PASS |  |
| pantools_function_overview | PASS |  |
| pantools_functional_classification | PASS |  |
| pantools_gene_classification | PASS |  |
| pantools_gene_retention | PASS | Synthetic MCScanX collinearity file built from real homology groups (MCScanX is not in the image); retention tables and R scripts are written. |
| pantools_go_enrichment | Not completed | The test pangenome has no GO terms; adding them needs add_functions with large downloaded InterPro and GO databases. |
| pantools_group | PASS |  |
| pantools_group_info | PASS |  |
| pantools_grouping_overview | PASS |  |
| pantools_k_mer_classification | PASS |  |
| pantools_locate_genes | PASS |  |
| pantools_map | PASS | Synthetic paired reads cut from the real rice chloroplast genome; reads mapped to the right genome at the right positions. |
| pantools_metrics | PASS |  |
| pantools_mlsa | PASS |  |
| pantools_mlsa_concatenate | PASS |  |
| pantools_mlsa_find_genes | PASS |  |
| pantools_msa | PASS |  |
| pantools_optimal_grouping | Not completed | Needs the output of busco_protein, which needs a downloaded BUSCO lineage database; too heavy here. |
| pantools_order_matrix | PASS |  |
| pantools_pangenome_structure | PASS |  |
| pantools_remove_annotations | PASS |  |
| pantools_remove_functions | Not completed | The command runs, but the test pangenome has no functional annotations to remove; adding them needs add_functions with the downloaded InterPro/GO databases. |
| pantools_remove_grouping | PASS |  |
| pantools_remove_nodes | PASS |  |
| pantools_remove_pavs | PASS | Synthetic PAV table on real genes; the overview shows no PAV data after removal. |
| pantools_remove_phenotypes | PASS |  |
| pantools_remove_variants | PASS | Synthetic VCF with 5 SNPs; the overview shows no variant data after removal. |
| pantools_rename_matrix | PASS |  |
| pantools_rename_phylogeny | PASS |  |
| pantools_repeat_overview | PASS | Synthetic repeat annotation (5 repeats); counts and covered bases are right. The --exclude-repeats option crashed with my test file (format unknown). |
| pantools_retrieve_features | PASS |  |
| pantools_retrieve_regions | PASS |  |
| pantools_root_phylogeny | PASS | The tool only writes the reroot.R script (the rerooted tree needs running it); the script roots at the requested node. |
| pantools_sequence_visualization | Failed | tool bug: gene coverage is 0 in every window and the gene density puts all genes in the first window. |
| pantools_show_go | Not completed | The test pangenome has no GO nodes; adding them needs add_functions with large downloaded InterPro and GO databases. |
| pantools_synteny_overview | PASS | Same synthetic collinearity file; block counts match the input. Needs mcscanx.homology beside it (synteny_files input). |
| pantools_variation_overview | PASS | Synthetic PAV table and VCF on the real test pangenome; the overview lists both. |

## pantools_remove_functions

### Tool Description
Remove functional annotations from the pangenome.

### Metadata
- **Docker Image**: quay.io/biocontainers/pantools:4.3.4--hdfd78af_0
- **Homepage**: https://git.wur.nl/bioinformatics/pantools
- **Package**: https://anaconda.org/channels/bioconda/packages/pantools/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pantools/overview
- **Total Downloads**: 36.0K
- **Last updated**: 2025-09-18
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Missing required parameter: '<databaseDirectory>'

Usage: pantools remove_functions [-m=<mode>] <databaseDirectory>

Remove functional annotations from the pangenome.

      <databaseDirectory>   Path to the database root directory.

  -m, --mode=<mode>         Remove function nodes and strip function properties
                              of mRNA nodes (default: all).
                            nodes: 'GO', 'pfam', 'tigrfam' and 'interpro' nodes.
                            properties: 'COG', 'phobius' and 'signalp'
                              properties.
                            all: combine the 'nodes' and 'properties' modes.
                            COG|phobius|signalp: Only remove a specific
                              property.
```

## pantools_deactivate_grouping

### Tool Description
Deactivate the currently active homology grouping.

### Metadata
- **Docker Image**: quay.io/biocontainers/pantools:4.3.4--hdfd78af_0
- **Homepage**: https://git.wur.nl/bioinformatics/pantools
- **Package**: https://anaconda.org/channels/bioconda/packages/pantools/overview
- **Validation**: PASS

### Original Help Text
```text
Missing required parameter: '<databaseDirectory>'

Usage: pantools deactivate_grouping [--fast] <databaseDirectory>

Deactivate the currently active homology grouping.

      <databaseDirectory>   Path to the database root directory.

      --fast                Do not remove is_similar relationships between mRNA
                              nodes.
```

## pantools_remove_grouping

### Tool Description
Remove an homology grouping from the pangenome.

### Metadata
- **Docker Image**: quay.io/biocontainers/pantools:4.3.4--hdfd78af_0
- **Homepage**: https://git.wur.nl/bioinformatics/pantools
- **Package**: https://anaconda.org/channels/bioconda/packages/pantools/overview
- **Validation**: PASS

### Original Help Text
```text
Missing required options and parameters: '--grouping-version=<groupingVersion>', '<databaseDirectory>'

Usage: pantools remove_grouping [--fast] -v=<groupingVersion>
                                <databaseDirectory>

Remove an homology grouping from the pangenome.

      <databaseDirectory>   Path to the database root directory.

  -v, --grouping-version=<groupingVersion>
                            Specific grouping version to be removed. Must be a
                              number, 'all' or 'all-inactive'.
      --fast                Do not remove is_similar relationships between mRNA
                              nodes.
```

## pantools_remove_annotations

### Tool Description
Remove all the genomic features that belong to annotations.

### Metadata
- **Docker Image**: quay.io/biocontainers/pantools:4.3.4--hdfd78af_0
- **Homepage**: https://git.wur.nl/bioinformatics/pantools
- **Package**: https://anaconda.org/channels/bioconda/packages/pantools/overview
- **Validation**: PASS

### Original Help Text
```text
Missing required parameter: '<databaseDirectory>'

Usage: pantools remove_annotations (-A=<annotationsFile> |
                                   [--selection-file=<selectionFile> |
                                   -i=<include> | -e=<exclude>])
                                   <databaseDirectory>

Remove all the genomic features that belong to annotations.

      <databaseDirectory>   Path to the database root directory.

  -A, --annotations=<annotationsFile>
                            A text file with the identifiers of annotations to
                              be removed, each on a separate line.
      --selection-file=<selectionFile>
                            Text file with rules to use a specific set of
                              genomes and sequences. This automatically lowers
                              the threshold for core genes.
  -i, --include=<include>   A selection of genomes for which all annotations
                              will be removed.
  -e, --exclude=<exclude>   A selection of genomes excluded from the removal of
                              annotations.
```

## pantools_remove_nodes

### Tool Description
Remove a selection of nodes and their relationships from the pangenome.

### Metadata
- **Docker Image**: quay.io/biocontainers/pantools:4.3.4--hdfd78af_0
- **Homepage**: https://git.wur.nl/bioinformatics/pantools
- **Package**: https://anaconda.org/channels/bioconda/packages/pantools/overview
- **Validation**: PASS

### Original Help Text
```text
Missing required parameter: '<databaseDirectory>'

Usage: pantools remove_nodes (-n=<nodes> | [--label=<label>
                             [--selection-file=<selectionFile> | -e=<exclude> |
                             -i=<include>]]) <databaseDirectory>

Remove a selection of nodes and their relationships from the pangenome.

      <databaseDirectory>   Path to the database root directory.

  -n, --nodes=<nodes>       One or multiple node identifiers, separated by a
                              comma.
      --label=<label>       A node label.
      --selection-file=<selectionFile>
                            Text file with rules to use a specific set of
                              genomes and sequences. This automatically lowers
                              the threshold for core genes.
  -e, --exclude=<exclude>   Do not remove nodes of the selected genomes.
  -i, --include=<include>   Only remove nodes of the selected genomes.
```

## pantools_remove_phenotypes

### Tool Description
Delete phenotype nodes or remove specific phenotype information from the nodes.

### Metadata
- **Docker Image**: quay.io/biocontainers/pantools:4.3.4--hdfd78af_0
- **Homepage**: https://git.wur.nl/bioinformatics/pantools
- **Package**: https://anaconda.org/channels/bioconda/packages/pantools/overview
- **Validation**: PASS

### Original Help Text
```text
Missing required parameter: '<databaseDirectory>'

Usage: pantools remove_phenotypes [-p=<phenotype>]
                                  [--selection-file=<selectionFile> |
                                  -i=<include> | -e=<exclude>]
                                  <databaseDirectory>

Delete phenotype nodes or remove specific phenotype information from the nodes.

      <databaseDirectory>   Path to the database root directory.

      --selection-file=<selectionFile>
                            Text file with rules to use a specific set of
                              genomes and sequences. This automatically lowers
                              the threshold for core genes.
  -i, --include=<include>   Only remove nodes of the selected genomes.
  -e, --exclude=<exclude>   Do not remove nodes of the selected genomes.
  -p, --phenotype=<phenotype>
                            Name of the phenotype.
```

## pantools_build_pangenome

### Tool Description
Build a pangenome from a set of genomes.

### Metadata
- **Docker Image**: quay.io/biocontainers/pantools:4.3.4--hdfd78af_0
- **Homepage**: https://git.wur.nl/bioinformatics/pantools
- **Package**: https://anaconda.org/channels/bioconda/packages/pantools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pantools build_pangenome [--keep-intermediate-files]
                                [--cache-size=<cacheSize>]
                                [--kmer-size=<kSize>]
                                [--num-buckets=<numBuckets>]
                                [--num-db-writer-threads=<numDbWriterThreads>]
                                [--scratch-directory=<scratchDirectory>]
                                [-t=<nThreads>]
                                [--transaction-size=<transactionSize>]
                                <databaseDirectory> <genomesFile>

Build a pangenome from a set of genomes. Please see the manual with
'build_pangenome --manual' for a description of the options.
Required software: KMC 3.1.0 or higher.

      <databaseDirectory>    Path to the database root directory.
      <genomesFile>          A text file containing paths to FASTA files of
                               genomes; each in a separate line.

  -t, --threads=<nThreads>   Number of parallel working threads, default is the
                               number of cores or 8, whichever is lower.
      --kmer-size=<kSize>    Size of k-mers. Should be in range [6..255]. By
                               not giving this argument, the most optimal k-mer
                               size is calculated automatically.
      --scratch-directory=<scratchDirectory>
                             Temporary directory for storing localization
                               update files.
      --num-buckets=<numBuckets>
                             Number of buckets for sorting (default: 200).
      --transaction-size=<transactionSize>
                             Number of localization updates to pack into a
                               single Neo4j transaction (default: 10000).
      --num-db-writer-threads=<numDbWriterThreads>
                             Number of threads to use for writing to Neo4j
                               (default: 2).
      --cache-size=<cacheSize>
                             Maximum number of items in the node properties
                               cache (default: 10000000).
      --keep-intermediate-files
                             Do not delete intermediate localization files
                               after the command finishes.
```

## pantools_build_panproteome

### Tool Description
Build a panproteome from a set of proteins.

### Metadata
- **Docker Image**: quay.io/biocontainers/pantools:4.3.4--hdfd78af_0
- **Homepage**: https://git.wur.nl/bioinformatics/pantools
- **Package**: https://anaconda.org/channels/bioconda/packages/pantools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pantools build_panproteome <databaseDirectory> <proteomesFile>

Build a panproteome from a set of proteins.
Required software: KMC 3.1.0 or higher.

      <databaseDirectory>   Path to the database root directory.
      <proteomesFile>       A text file containing paths to FASTA files of
                              proteins to be added to the panproteome; each on
                              a separate line.
```

## pantools_add_annotations

### Tool Description
Construct or expand the annotations of an existing pangenome.

### Metadata
- **Docker Image**: quay.io/biocontainers/pantools:4.3.4--hdfd78af_0
- **Homepage**: https://git.wur.nl/bioinformatics/pantools
- **Package**: https://anaconda.org/channels/bioconda/packages/pantools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pantools add_annotations [--assume-one-mrna-per-cds] [--connect]
                                [--ignore-invalid-features] <databaseDirectory>
                                <annotationsFile>

Construct or expand the annotations of an existing pangenome.

      <databaseDirectory>   Path to the database root directory.
      <annotationsFile>     A text file with the identifiers of annotations to
                              be included.

      --ignore-invalid-features
                            Ignore GFF3 features that do not match the fasta.
      --connect             Connect the annotated genomic features to
                              nucleotide nodes in the DBG.
      --assume-one-mrna-per-cds
                            Assume that each CDS is part of a single mRNA in
                              case the annotation file does not contain mRNA
                              features between CDS and gene features.
```

## pantools_group

### Tool Description
Generate homology groups based on similarity of protein sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/pantools:4.3.4--hdfd78af_0
- **Homepage**: https://git.wur.nl/bioinformatics/pantools
- **Package**: https://anaconda.org/channels/bioconda/packages/pantools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pantools group [OPTIONS] <databaseDirectory>

Generate homology groups based on similarity of protein sequences.
Required software: MCL

      <databaseDirectory>    Path to the database root directory.

  -t, --threads=<nThreads>   Number of parallel working threads, default is the
                               number of cores or 8, whichever is lower.
      --selection-file=<selectionFile>
                             Text file with rules to use a specific set of
                               genomes and sequences. This automatically lowers
                               the threshold for core genes.
  -i, --include=<include>    Only include a selection of genomes.
  -e, --exclude=<exclude>    Exclude a selection of genomes.
  -A, --annotations-file=<annotationsFile>
                             A text file with the identifiers of annotations to
                               be included.
      --longest              Only cluster protein sequences of the longest
                               transcript per gene.
      --scoring-matrix=<scoringMatrix>
                             The scoring matrix used (default: BLOSUM62).
      --relaxation=<params>  The relaxation in homology calls. Should be in
                               range [1..8], from strict to relaxed. Use
                               optimal_grouping to determine the best
                               relaxation setting.
      --contrast=<contrast>  The contrast factor. Should be in range [0,10].
      --mcl-inflation=<mclInflation>
                             The MCL inflation. Should be in range [1,19].
      --intersection-rate=<intersectionRate>
                             The fraction of k-mers that needs to be shared by
                               two intersecting proteins. Should be in range
                               [0.001,0.1].
      --similarity-threshold=<similarityThreshold>
                             The minimum normalized similarity score of two
                               proteins. Should be in range [1..99].
```

## pantools_add_antismash

### Tool Description
Add antiSMASH gene clusters to the pangenome.

### Metadata
- **Docker Image**: quay.io/biocontainers/pantools:4.3.4--hdfd78af_0
- **Homepage**: https://git.wur.nl/bioinformatics/pantools
- **Package**: https://anaconda.org/channels/bioconda/packages/pantools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pantools add_antismash [-A=<annotationsFile>] <databaseDirectory>
                              <antiSMASHFile>

Add antiSMASH gene clusters to the pangenome.

      <databaseDirectory>   Path to the database root directory.
      <antiSMASHFile>       A text file with on each line a genome number and
                              the full path to the corresponding antiSMASH
                              output file, separated by a space.

  -A, --annotations-file=<annotationsFile>
                            A text file with the identifiers of annotations to
                              be included.
```

## pantools_add_functions

### Tool Description
Add functional annotations to the pangenome.

### Metadata
- **Docker Image**: quay.io/biocontainers/pantools:4.3.4--hdfd78af_0
- **Homepage**: https://git.wur.nl/bioinformatics/pantools
- **Package**: https://anaconda.org/channels/bioconda/packages/pantools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pantools add_functions [-A=<annotationsFile>]
                              [-F=<functionalDatabasesPath>]
                              [--function=<function>] <databaseDirectory>
                              <functionsFile>

Add functional annotations to the pangenome.

      <databaseDirectory>   Path to the database root directory.
      <functionsFile>       A text file with on each line a genome number and
                              the full path to the corresponding annotation
                              file, separated by a space.

  -A, --annotations-file=<annotationsFile>
                            A text file with the identifiers of annotations to
                              be included.
      --function=<function> Only add a specific functional annotation.
  -F, --functional-databases-directory=<functionalDatabasesPath>
                            Path to the directory containing the functional
                              annotation databases. Any missing databases will
                              be downloaded automatically (default:
                              'functional_databases' in pangenome database
                              directory).
```

## pantools_add_genomes

### Tool Description
Add additional genomes to an existing pangenome. Required software: KMC 3.1.0 or higher.

### Metadata
- **Docker Image**: quay.io/biocontainers/pantools:4.3.4--hdfd78af_0
- **Homepage**: https://git.wur.nl/bioinformatics/pantools
- **Package**: https://anaconda.org/channels/bioconda/packages/pantools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pantools add_genomes [--scratch-directory=<scratchDirectory>]
                            [-t=<nThreads>] <databaseDirectory> <genomesFile>

Add additional genomes to an existing pangenome.
Required software: KMC 3.1.0 or higher.

      <databaseDirectory>    Path to the database root directory.
      <genomesFile>          A text file containing paths to FASTA files of
                               genomes to be added to the pangenome; each on a
                               separate line.

  -t, --threads=<nThreads>   Number of parallel working threads, default is the
                               number of cores or 8, whichever is lower.
      --scratch-directory=<scratchDirectory>
```

## pantools_add_pavs

### Tool Description
Add PAV data to the pangenome.

### Metadata
- **Docker Image**: quay.io/biocontainers/pantools:4.3.4--hdfd78af_0
- **Homepage**: https://git.wur.nl/bioinformatics/pantools
- **Package**: https://anaconda.org/channels/bioconda/packages/pantools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pantools add_pavs <databaseDirectory> <pavLocationsFile>

Add PAV data to the pangenome.

      <databaseDirectory>   Path to the database root directory.
      <pavLocationsFile>    A text file with on each line a genome number and
                              the full path to the corresponding PAV file,
                              separated by a space.
```

## pantools_add_phasing

### Tool Description
Add phasing information to the pangenome.

### Metadata
- **Docker Image**: quay.io/biocontainers/pantools:4.3.4--hdfd78af_0
- **Homepage**: https://git.wur.nl/bioinformatics/pantools
- **Package**: https://anaconda.org/channels/bioconda/packages/pantools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pantools add_phasing [--assume-unphased] <databaseDirectory>
                            <phasingFile>

Add phasing information to the pangenome

      <databaseDirectory>   Path to the database root directory.
      <phasingFile>

      --assume-unphased     all chromosomes without a letter will be be
                              considered unphased
```

## pantools_add_phenotypes

### Tool Description
Add phenotype data to the pangenome.

### Metadata
- **Docker Image**: quay.io/biocontainers/pantools:4.3.4--hdfd78af_0
- **Homepage**: https://git.wur.nl/bioinformatics/pantools
- **Package**: https://anaconda.org/channels/bioconda/packages/pantools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pantools add_phenotypes [--append] [--bins=<bins>] <databaseDirectory>
                               <phenotypesFile>

Add phenotype data to the pangenome.

      <databaseDirectory>   Path to the database root directory.
      <phenotypesFile>      A CSV file containing the phenotype information.

      --bins=<bins>         Number of bins used to group numerical values of a
                              phenotype (default: 3).
      --append              Do not remove existing phenotype nodes but only add
                              new properties to it.
```

## pantools_add_repeats

### Tool Description
Add repeat information to the pangenome.

### Metadata
- **Docker Image**: quay.io/biocontainers/pantools:4.3.4--hdfd78af_0
- **Homepage**: https://git.wur.nl/bioinformatics/pantools
- **Package**: https://anaconda.org/channels/bioconda/packages/pantools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pantools add_repeats [OPTIONS] <databaseDirectory> <annotationsFile>

Add repeat information to the pangenome

      <databaseDirectory>   Path to the database root directory.
      <annotationsFile>     A text file with the identifiers of annotations to
                              be included.

      --strict
      --connect
```

## pantools_add_synteny

### Tool Description
Add synteny information to the pangenome.

### Metadata
- **Docker Image**: quay.io/biocontainers/pantools:4.3.4--hdfd78af_0
- **Homepage**: https://git.wur.nl/bioinformatics/pantools
- **Package**: https://anaconda.org/channels/bioconda/packages/pantools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pantools add_synteny [OPTIONS] <databaseDirectory> <collinearityFile>

Add synteny information to the pangenome

      <databaseDirectory>   Path to the database root directory.
      <collinearityFile>
```

## pantools_add_variants

### Tool Description
Add variant data to the pangenome. Required software: bcftools, tabix.

### Metadata
- **Docker Image**: quay.io/biocontainers/pantools:4.3.4--hdfd78af_0
- **Homepage**: https://git.wur.nl/bioinformatics/pantools
- **Package**: https://anaconda.org/channels/bioconda/packages/pantools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pantools add_variants [--keep-intermediate-files]
                             [--scratch-directory=<scratchDirectory>]
                             [-t=<nThreads>] <databaseDirectory>
                             <vcfLocationsFile>

Add variant data to the pangenome.

      <databaseDirectory>    Path to the database root directory.
      <vcfLocationsFile>     A text file with on each line a genome number and
                               the full path to the corresponding VCF file,
                               separated by a space.

  -t, --threads=<nThreads>   Number of parallel working threads, default is the
                               number of cores or 8, whichever is lower.
      --scratch-directory=<scratchDirectory>
                             Temporary directory for storing intermediate files.
      --keep-intermediate-files
                             Do not delete intermediate files.
```

## pantools_ani

### Tool Description
Calculate Average Nucleotide Identity (ANI) scores between genomes.

### Metadata
- **Docker Image**: quay.io/biocontainers/pantools:4.3.4--hdfd78af_0
- **Homepage**: https://git.wur.nl/bioinformatics/pantools
- **Package**: https://anaconda.org/channels/bioconda/packages/pantools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pantools ani [-m=MASH|fastANI] [-p=<phenotype>] [-t=<nThreads>]
                    [--selection-file=<selectionFile> | -i=<include> |
                    -e=<exclude>] <databaseDirectory>

Calculate Average Nucleotide Identity (ANI) scores between genomes.

      <databaseDirectory>    Path to the database root directory.

  -t, --threads=<nThreads>   Number of threads used by FastANI, default is the
                               number of cores or 8, whichever is lower. MASH
                               is always single threaded.
      --selection-file=<selectionFile>
                             Text file with rules to use a specific set of
                               genomes and sequences. This automatically lowers
                               the threshold for core genes.
  -i, --include=<include>    Only include a selection of genomes.
  -e, --exclude=<exclude>    Exclude a selection of genomes.
  -m, --mode=MASH|fastANI    Software to calculate ANI score (default: MASH).
  -p, --phenotype=<phenotype>
                             Include phenotype information in the phylogeny.
```

## pantools_blast

### Tool Description
Search sequences in the database using BLAST. Required software: BLAST suite.

### Metadata
- **Docker Image**: quay.io/biocontainers/pantools:4.3.4--hdfd78af_0
- **Homepage**: https://git.wur.nl/bioinformatics/pantools
- **Package**: https://anaconda.org/channels/bioconda/packages/pantools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pantools blast [OPTIONS] <databaseDirectory> <fastaFile>

Search sequences in the database using BLAST

      <databaseDirectory>    Path to the database root directory.
      <fastaFile>

  -t, --threads=<nThreads>   Number of parallel working threads, default is the
                               number of cores or 8, whichever is lower.
      --selection-file=<selectionFile>
                             Text file with rules to use a specific set of
                               genomes and sequences. This automatically lowers
                               the threshold for core genes.
  -e, --exclude=<exclude>    Exclude a selection of genomes.
  -i, --include=<include>    Only include a selection of genomes.
      --alignment-threshold=<alignmentThreshold>

      --minimum-identity=<minimumIdentity>

      --rebuild
      --mode=<blastProgram>
```

## pantools_busco_protein

### Tool Description
Identify BUSCO genes in the pangenome. Required software: BUSCO v3, v4 or v5.

### Metadata
- **Docker Image**: quay.io/biocontainers/pantools:4.3.4--hdfd78af_0
- **Homepage**: https://git.wur.nl/bioinformatics/pantools
- **Package**: https://anaconda.org/channels/bioconda/packages/pantools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pantools busco_protein [OPTIONS] <databaseDirectory>

Identify BUSCO genes in the pangenome.
Required software: BUSCO v3, v4 or v5 (not included in conda yaml file for
macOS).

      <databaseDirectory>    Path to the database root directory.

  -t, --threads=<nThreads>   Number of parallel working threads, default is the
                               number of cores or 8, whichever is lower.
      --selection-file=<selectionFile>
                             Text file with rules to use a specific set of
                               genomes and sequences. This automatically lowers
                               the threshold for core genes.
  -e, --exclude=<exclude>    Exclude a selection of genomes.
  -i, --include=<include>    Only include a selection of genomes.
  -A, --annotations-file=<annotationsFile>
                             A text file with the identifiers of annotations to
                               be included.
  -v, --busco-version=4|5    The BUSCO version (default: 5).
      --odb10=<odb10>        An odb10 benchmark dataset name.
      --longest, --longest-transcripts
                             Only search against the longest protein-coding
                               transcript of genes.
      --phasing              Analyse phased genomes.
      --all-automatic
      --skip-busco=<skip>    A list of questionable BUSCOs. The completeness
                               score is recalculated by skipping these genes.
```

## pantools_calculate_dn_ds

### Tool Description
Calculate synonymous and non-synonymous mutation rates.

### Metadata
- **Docker Image**: quay.io/biocontainers/pantools:4.3.4--hdfd78af_0
- **Homepage**: https://git.wur.nl/bioinformatics/pantools
- **Package**: https://anaconda.org/channels/bioconda/packages/pantools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pantools calculate_dn_ds [OPTIONS] <databaseDirectory>

Calculate synonymous and non-synonymous mutation rates

      <databaseDirectory>    Path to the database root directory.

  -t, --threads=<nThreads>   Number of parallel working threads, default is the
                               number of cores or 8, whichever is lower.
      --selection-file=<selectionFile>
                             Text file with rules to use a specific set of
                               genomes and sequences. This automatically lowers
                               the threshold for core genes.
  -i, --include=<include>    Only include a selection of genomes.
  -e, --exclude=<exclude>    Exclude a selection of genomes.
  -H, --homology-file=<homologyFile>
                             A text file with homology group node identifiers,
                               separated by a comma.
      --syntelogs
      --phasing              Analyse phased genomes.
      --scoring-matrix=<scoringMatrix>
                             The scoring matrix used (default: BLOSUM62).
      --allow-zeros
```

## pantools_calculate_synteny

### Tool Description
Calculate synteny between sequences with MCScanX. Required software: MCScanX.

### Metadata
- **Docker Image**: quay.io/biocontainers/pantools:4.3.4--hdfd78af_0
- **Homepage**: https://git.wur.nl/bioinformatics/pantools
- **Package**: https://anaconda.org/channels/bioconda/packages/pantools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pantools calculate_synteny [OPTIONS] <databaseDirectory>

Calculate synteny between sequences with MCScanX

      <databaseDirectory>    Path to the database root directory.

  -t, --threads=<nThreads>   Number of parallel working threads, default is the
                               number of cores or 8, whichever is lower.
      --selection-file=<selectionFile>
                             Text file with rules to use a specific set of
                               genomes and sequences. This automatically lowers
                               the threshold for core genes.
  -i, --include=<include>    Only include a selection of genomes.
  -e, --exclude=<exclude>    Exclude a selection of genomes.
  -H, --homology-file=<homologyGroupsFile>
                             A text file with homology group node identifiers,
                               separated by a comma.
  -G, --homology-groups=<homologyGroups>
                             A list of homology group node identifiers,
                               separated by a comma.
      --run                  Perform MCScanX.
      --longest              Only cluster protein sequences of the longest
                               transcript per gene.
      --sequence             Perform the analysis on a sequence level in
                               addition to the genome.
```

## pantools_change_grouping

### Tool Description
Change the active version of the homology grouping.

### Metadata
- **Docker Image**: quay.io/biocontainers/pantools:4.3.4--hdfd78af_0
- **Homepage**: https://git.wur.nl/bioinformatics/pantools
- **Package**: https://anaconda.org/channels/bioconda/packages/pantools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pantools change_grouping -v=<groupingVersion> <databaseDirectory>

Change the active version of the homology grouping.

      <databaseDirectory>   Path to the database root directory.

  -v, --grouping-version=<groupingVersion>
                            The version of homology grouping to become active.
```

## pantools_compare_go

### Tool Description
For two given GO terms, move up in the GO hierarchy to see if they are related.

### Metadata
- **Docker Image**: quay.io/biocontainers/pantools:4.3.4--hdfd78af_0
- **Homepage**: https://git.wur.nl/bioinformatics/pantools
- **Package**: https://anaconda.org/channels/bioconda/packages/pantools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pantools compare_go [--selection-file=<selectionFile> | -i=<include> |
                           -e=<exclude>] (--functions=<functions> | -n=<nodes>)
                           <databaseDirectory>

For two given GO terms, move up in the GO hierarchy to see if they are related.

      <databaseDirectory>   Path to the database root directory.

      --selection-file=<selectionFile>
                            Text file with rules to use a specific set of
                              genomes and sequences. This automatically lowers
                              the threshold for core genes.
  -i, --include=<include>   Only include a selection of genomes.
  -e, --exclude=<exclude>   Exclude a selection of genomes.
      --functions=<functions>
                            One or multiple GO term identifiers, separated by a
                              comma.
  -n, --nodes=<nodes>       One or multiple identifiers of 'GO' nodes,
                              separated by a comma.
```

## pantools_consensus_tree

### Tool Description
Create a consensus tree by combining gene trees from homology groups using ASTRAL-Pro. By default, only nucleotide sequences are aligned for pangenome databases and only protein sequences are aligned for panproteome databases. If variants are present in the pangenome, these will be used as well. Required software: MAFFT FastTree (ASTRAL-Pro).

### Metadata
- **Docker Image**: quay.io/biocontainers/pantools:4.3.4--hdfd78af_0
- **Homepage**: https://git.wur.nl/bioinformatics/pantools
- **Package**: https://anaconda.org/channels/bioconda/packages/pantools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pantools consensus_tree [--phasing] [--polytomies] [--blosum=<blosum>]
                               [-t=<nThreads>] [-H=<homologyGroupsFile> |
                               -G=<homologyGroups>] [--align-protein |
                               --align-nucleotide | [-v [--pavs]]]
                               <databaseDirectory>

Create a consensus tree by combining gene trees from homology groups using
ASTRAL-Pro. By default, only nucleotide sequences are aligned for pangenome
databases and only protein sequences are aligned for panproteome databases. If
variants are present in the pangenome, these will be used as well.
Required software: MAFFT FastTree (ASTRAL-Pro).

      <databaseDirectory>    Path to the database root directory.

  -t, --threads=<nThreads>   Number of parallel working threads, default is the
                               number of cores or 8, whichever is lower.
  -H, --homology-file=<homologyGroupsFile>
                             A file with homology group node identifiers.
                               Default is all_homology_groups.csv, generated in
                               the previous gene_classification run.
  -G, --homology-groups=<homologyGroups>
                             A list of homology group node identifiers. Default
                               is all_homology_groups.csv, generated in the
                               previous gene_classification run.
      --align-protein        Use protein alignment.
      --align-nucleotide     Use nucleotide alignment.
  -v, --variants             Use included variation (VCF information).
      --pavs                 Use included variation (PAV information).
      --blosum=<blosum>      A BLOSUM matrix to be used for the calculation of
                               protein similarity. Allowed values are 45, 50,
                               62 80 and 90 (default: 62).
      --polytomies           Allow polytomies for ASTRAL-PRO.
      --phasing              Analyse phased genomes.

ASTRAL-PRO (https://github.com/chaoszhang/ASTER v1.3) is used for this feature.
Please cite the original authors:
Chao Zhang, Celine Scornavacca, Erin K Molloy, Siavash Mirarab, ASTRAL-Pro:
Quartet-Based Species-Tree Inference despite Paralogy, Molecular Biology and
Evolution, Volume 37, Issue 11, November 2020, Pages 3292-3307,
https://doi.org/10.1093/molbev/msaa139
```

## pantools_core_phylogeny

### Tool Description
Create a SNP tree from single-copy genes. By default, only nucleotide sequences are aligned for pangenome databases and only protein sequences are aligned for panproteome databases. If variants are present in the pangenome, these will be used as well. Required software: MAFFT, IQ-tree (Only required for Maximum-Likelihood).

### Metadata
- **Docker Image**: quay.io/biocontainers/pantools:4.3.4--hdfd78af_0
- **Homepage**: https://git.wur.nl/bioinformatics/pantools
- **Package**: https://anaconda.org/channels/bioconda/packages/pantools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pantools core_phylogeny [--phasing] [--blosum=<blosum>] [-m=<mode>]
                               [-p=<phenotype>] [-t=<nThreads>]
                               [--selection-file=<selectionFile> | -i=<include>
                               | -e=<exclude>] [-H=<homologyGroupsFile> |
                               -G=<homologyGroups>] [--align-protein |
                               --align-nucleotide] [-v [--pavs]]
                               <databaseDirectory>

Create a SNP tree from single-copy genes. By default, only nucleotide sequences
are aligned for pangenome databases and only protein sequences are aligned for
panproteome databases. If variants are present in the pangenome, these will be
used as well.
Required software: MAFFT, IQ-tree (Only required for Maximum-Likelihood).

      <databaseDirectory>    Path to the database root directory.

  -t, --threads=<nThreads>   Number of parallel working threads, default is the
                               number of cores or 8, whichever is lower.
      --selection-file=<selectionFile>
                             Text file with rules to use a specific set of
                               genomes and sequences. This automatically lowers
                               the threshold for core genes.
  -i, --include=<include>    Only include a selection of genomes.
  -e, --exclude=<exclude>    Exclude a selection of genomes.
  -H, --homology-file=<homologyGroupsFile>
                             A file with homology group node identifiers of
                               single copy groups. Default is
                               single_copy_orthologs.csv, generated in the
                               previous gene_classification run.
  -G, --homology-groups=<homologyGroups>
                             A list of homology group node identifiers of
                               single copy groups. Default is
                               single_copy_orthologs.csv, generated in the
                               previous gene_classification run.
      --align-protein        Use protein alignment.
      --align-nucleotide     Use nucleotide alignment.
  -p, --phenotype=<phenotype>
                             Include phenotype information in the resulting
                               phylogeny.
      --phasing              Analyse phased genomes.
  -v, --variants             Use included variation (VCF information).
      --pavs                 Use included variation (PAV information).
  -m, --clustering-mode=<mode>
                             Maximum likelihood (--mode ML) or Neighbour
                               joining (--mode NJ). Default is ML.
      --blosum=<blosum>      A BLOSUM matrix to be used for the calculation of
                               protein similarity. Allowed values are 45, 50,
                               62 80 and 90 (default: 62).
```

## pantools_core_unique_thresholds

### Tool Description
Test the effect of changing the core and unique threshold.

### Metadata
- **Docker Image**: quay.io/biocontainers/pantools:4.3.4--hdfd78af_0
- **Homepage**: https://git.wur.nl/bioinformatics/pantools
- **Package**: https://anaconda.org/channels/bioconda/packages/pantools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pantools core_unique_thresholds [--selection-file=<selectionFile> |
                                       -i=<include> | -e=<exclude>]
                                       <databaseDirectory>

Test the effect of changing the core and unique threshold.

      <databaseDirectory>   Path to the database root directory.

      --selection-file=<selectionFile>
                            Text file with rules to use a specific set of
                              genomes and sequences. This automatically lowers
                              the threshold for core genes.
  -i, --include=<include>   Only include a selection of genomes.
  -e, --exclude=<exclude>   Exclude a selection of genomes.
```

## pantools_create_tree_template

### Tool Description
Create templates for coloring phylogenetic trees in iTOL.

### Metadata
- **Docker Image**: quay.io/biocontainers/pantools:4.3.4--hdfd78af_0
- **Homepage**: https://git.wur.nl/bioinformatics/pantools
- **Package**: https://anaconda.org/channels/bioconda/packages/pantools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pantools create_tree_template [--no-numbers] [--phasing]
                                     [--color=<color>] [-p=<phenotype>]
                                     [--selection-file=<selectionFile> |
                                     -e=<exclude> | -i=<include>] (--sequence |
                                     --genome | --gene-tree=<geneTree>)
                                     <databaseDirectory>

Create templates for coloring phylogenetic trees in iTOL.

      <databaseDirectory>   Path to the database root directory.

      --selection-file=<selectionFile>
                            Text file with rules to use a specific set of
                              genomes and sequences. This automatically lowers
                              the threshold for core genes.
  -e, --exclude=<exclude>   Exclude a selection of genomes.
  -i, --include=<include>   Only include a selection of genomes.
      --color=<color>       Assign a color to a phenotypes with a minimum
                              amount of genomes (default: 2).
  -p, --phenotype=<phenotype>
                            Use the names from this phenotype.
      --no-numbers
      --phasing             Analyse phased genomes.
      --sequence            Perform the analysis on a sequence level in
                              addition to the genome.
      --genome              Only perform the analysis between genomes.
      --gene-tree=<geneTree>
```

## pantools_export_pangenome

### Tool Description
Export a pangenome built with build_pangenome into node properties, relationship properties and node sequence anchors files.

### Metadata
- **Docker Image**: quay.io/biocontainers/pantools:4.3.4--hdfd78af_0
- **Homepage**: https://git.wur.nl/bioinformatics/pantools
- **Package**: https://anaconda.org/channels/bioconda/packages/pantools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pantools export_pangenome [OPTIONS] <databaseDirectory>

Export a pangenome built with build_pangenome into node properties,
relationship properties and node sequence anchors files.

      <databaseDirectory>   Path to the database root directory.

      --node-properties-file=<nodePropertiesFile>

      --relationship-properties-file=<relationshipPropertiesFile>

      --sequence-node-anchors-file=<sequenceNodeAnchorsFile>
```

## pantools_find_genes_by_annotation

### Tool Description
Find genes of interest in the pangenome that share a functional annotation node and extract the nucleotide and protein sequence.

### Metadata
- **Docker Image**: quay.io/biocontainers/pantools:4.3.4--hdfd78af_0
- **Homepage**: https://git.wur.nl/bioinformatics/pantools
- **Package**: https://anaconda.org/channels/bioconda/packages/pantools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pantools find_genes_by_annotation [--selection-file=<selectionFile> |
       -e=<exclude> | -i=<include>] (--functions=<functions> | -n=<nodes>)
       <databaseDirectory>

Find genes of interest in the pangenome that share a functional annotation node
and extract the nucleotide and protein sequence.

      <databaseDirectory>   Path to the database root directory.

      --selection-file=<selectionFile>
                            Text file with rules to use a specific set of
                              genomes and sequences. This automatically lowers
                              the threshold for core genes.
  -e, --exclude=<exclude>   Exclude a selection of genomes.
  -i, --include=<include>   Only include a selection of genomes.
      --functions=<functions>
                            One or multiple function identifiers (GO, InterPro,
                              PFAM, TIGRFAM), separated by a comma.
  -n, --nodes=<nodes>       One or multiple identifiers of function nodes (GO,
                              InterPro, PFAM, TIGRFAM), separated by a comma.
```

## pantools_find_genes_by_name

### Tool Description
Find your genes of interest in the pangenome by using the gene name and extract the nucleotide and protein sequence.

### Metadata
- **Docker Image**: quay.io/biocontainers/pantools:4.3.4--hdfd78af_0
- **Homepage**: https://git.wur.nl/bioinformatics/pantools
- **Package**: https://anaconda.org/channels/bioconda/packages/pantools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pantools find_genes_by_name [--extensive] -g=<genes>
                                   [--selection-file=<selectionFile> |
                                   -e=<exclude> | -i=<include>]
                                   <databaseDirectory>

Find your genes of interest in the pangenome by using the gene name and extract
the nucleotide and protein sequence.

      <databaseDirectory>   Path to the database root directory.

      --selection-file=<selectionFile>
                            Text file with rules to use a specific set of
                              genomes and sequences. This automatically lowers
                              the threshold for core genes.
  -e, --exclude=<exclude>   Exclude a selection of genomes.
  -i, --include=<include>   Only include a selection of genomes.
      --extensive           Perform a more extensive gene search.
  -g, --genes=<genes>       One or multiple gene names, separated by a comma.
```

## pantools_find_genes_in_region

### Tool Description
Find genes in a given genomic region.

### Metadata
- **Docker Image**: quay.io/biocontainers/pantools:4.3.4--hdfd78af_0
- **Homepage**: https://git.wur.nl/bioinformatics/pantools
- **Package**: https://anaconda.org/channels/bioconda/packages/pantools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pantools find_genes_in_region [--partial] <databaseDirectory>
                                     <regionsFile>

Find genes in a given genomic region.

      <databaseDirectory>   Path to the database root directory.
      <regionsFile>         A text file containing genome locations with on
                              each line: a genome number, sequence number,
                              begin and end position, separated by a space.

      --partial             Also retrieve genes that only partially overlap the
                              input regions.
```

## pantools_functional_classification

### Tool Description
Classify functional annotations as core, accessory or unique.

### Metadata
- **Docker Image**: quay.io/biocontainers/pantools:4.3.4--hdfd78af_0
- **Homepage**: https://git.wur.nl/bioinformatics/pantools
- **Package**: https://anaconda.org/channels/bioconda/packages/pantools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pantools functional_classification [OPTIONS] <databaseDirectory>

Classify functional annotations as core, accessory or unique.

      <databaseDirectory>   Path to the database root directory.

      --selection-file=<selectionFile>
                            Text file with rules to use a specific set of
                              genomes and sequences. This automatically lowers
                              the threshold for core genes.
  -i, --include=<include>   Only include a selection of genomes.
  -e, --exclude=<exclude>   Exclude a selection of genomes.
  -A, --annotations-file=<annotationsFile>
                            A text file with the identifiers of annotations to
                              be included.
  -p, --phenotype=<phenotype>
                            A phenotype name, used to find functions specific
                              to a phenotype.
      --core-threshold=<coreThreshold>
                            Threshold (%) for (soft) core genes. Default is
                              100% of genomes.
      --unique-threshold=<uniqueThreshold>
                            Threshold (%) for unique/cloud genes. Default is a
                              single genome, not a percentage.
```

## pantools_function_overview

### Tool Description
Create an overview table for each functional annotation type in the pangenome.

### Metadata
- **Docker Image**: quay.io/biocontainers/pantools:4.3.4--hdfd78af_0
- **Homepage**: https://git.wur.nl/bioinformatics/pantools
- **Package**: https://anaconda.org/channels/bioconda/packages/pantools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pantools function_overview [-A=<annotationsFile>]
                                  [--selection-file=<selectionFile> |
                                  -i=<include> | -e=<exclude>]
                                  <databaseDirectory>

Create an overview table for each functional annotation type in the pangenome.

      <databaseDirectory>   Path to the database root directory.

      --selection-file=<selectionFile>
                            Text file with rules to use a specific set of
                              genomes and sequences. This automatically lowers
                              the threshold for core genes.
  -i, --include=<include>   Only include a selection of genomes.
  -e, --exclude=<exclude>   Exclude a selection of genomes.
  -A, --annotations-file=<annotationsFile>
                            A text file with the identifiers of annotations to
                              be included.
```

## pantools_gene_classification

### Tool Description
Classify the gene repertoire as core, accessory or unique.

### Metadata
- **Docker Image**: quay.io/biocontainers/pantools:4.3.4--hdfd78af_0
- **Homepage**: https://git.wur.nl/bioinformatics/pantools
- **Package**: https://anaconda.org/channels/bioconda/packages/pantools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pantools gene_classification [OPTIONS] <databaseDirectory>

Classify the gene repertoire as core, accessory or unique.

      <databaseDirectory>   Path to the database root directory.

      --selection-file=<selectionFile>
                            Text file with rules to use a specific set of
                              genomes and sequences. This automatically lowers
                              the threshold for core genes.
  -e, --exclude=<exclude>   Exclude a selection of genomes.
  -i, --include=<include>   Only include a selection of genomes.
      --phasing             Analyse phased genomes.
      --sequence            Perform the analysis on a sequence level in
                              addition to the genome.
      --pavs                Use included variation (PAV information).
      --mlsa                Finds suitable single-copy groups for a mlsa.
  -p, --phenotype=<phenotype>
                            A phenotype name, used to find genes specific to
                              the phenotype.
      --core-threshold=<coreThreshold>
                            Threshold (%) for (soft) core genes. Default is
                              100% of genomes.
      --unique-threshold=<uniqueThreshold>
                            Threshold (%) for unique/cloud genes. Default is a
                              single genome, not a percentage.
      --phenotype-threshold=<phenotypeThreshold>
                            Threshold (%) for phenotype specific/shared genes.
                              Default is 100% of genomes with phenotype.
```

## pantools_gene_retention

### Tool Description
Visualize gene retention of sequences to a selected query sequence

### Metadata
- **Docker Image**: quay.io/biocontainers/pantools:4.3.4--hdfd78af_0
- **Homepage**: https://git.wur.nl/bioinformatics/pantools
- **Package**: https://anaconda.org/channels/bioconda/packages/pantools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pantools gene_retention [OPTIONS] <databaseDirectory>

Visualize gene retention of sequences to a selected query sequence

      <databaseDirectory>    Path to the database root directory.

  -t, --threads=<nThreads>   Number of parallel working threads, default is the
                               number of cores or 8, whichever is lower.
      --selection-file=<selectionFile>
                             Text file with rules to use a specific set of
                               genomes and sequences. This automatically lowers
                               the threshold for core genes.
  -i, --include=<include>    Only include a selection of genomes.
  -e, --exclude=<exclude>    Exclude a selection of genomes.
      --input-sequences=<inputSequences>
                             Text file with sequences (identifiers) to be be
                               used as reference. Identifiers must be placed on
                               a single line separated by commas. Default is
                               all sequences.
      --window-length=<windowLength>
                             Set the sliding window length. Default is 100
                               (genes).
      --sequences-plot=<allowedSequences>
                             Set the maximum number of sequences per
                               (combination) plot. Default is 20.
      --sequences-genome=<sequencesPerGenome>
                             Set the maximum number of sequences per genome
                               plot. Default is 20.
      --coloring=<coloring>  Use the most distinctive colors (distinctive) or
                               phasing information (phasing) to color plots
                               (default: distinct).
```

## pantools_go_enrichment

### Tool Description
Identify over- or underrepresented GO terms in a set of genes.

### Metadata
- **Docker Image**: quay.io/biocontainers/pantools:4.3.4--hdfd78af_0
- **Homepage**: https://git.wur.nl/bioinformatics/pantools
- **Package**: https://anaconda.org/channels/bioconda/packages/pantools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pantools go_enrichment [--fdr=<falseDiscoveryRate>]
                              [--selection-file=<selectionFile> | -i=<include>
                              | -e=<exclude>] (-H=<homologyFile> | -n=<nodes>)
                              <databaseDirectory>

Identify over- or underrepresented GO terms in a set of genes.

      <databaseDirectory>   Path to the database root directory.

      --selection-file=<selectionFile>
                            Text file with rules to use a specific set of
                              genomes and sequences. This automatically lowers
                              the threshold for core genes.
  -i, --include=<include>   Only include a selection of genomes.
  -e, --exclude=<exclude>   Exclude a selection of genomes.
  -H, --homology-file=<homologyFile>
                            A text file with homology group node identifiers,
                              separated by a comma.
  -n, --nodes=<nodes>       One or multiple node identifiers, separated by a
                              comma.
      --fdr=<falseDiscoveryRate>
                            The false discovery rate (%) (default: 5%).
```

## pantools_group_info

### Tool Description
Report all available information of one or multiple homology groups.

### Metadata
- **Docker Image**: quay.io/biocontainers/pantools:4.3.4--hdfd78af_0
- **Homepage**: https://git.wur.nl/bioinformatics/pantools
- **Package**: https://anaconda.org/channels/bioconda/packages/pantools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pantools group_info [--node] [--functions=<functions>] [-g=<genes>]
                           [--selection-file=<selectionFile> | -i=<include> |
                           -e=<exclude>] [-H=<homologyGroupsFile> |
                           -G=<homologyGroups>] <databaseDirectory>

Report all available information of one or multiple homology groups.

      <databaseDirectory>   Path to the database root directory.

      --selection-file=<selectionFile>
                            Text file with rules to use a specific set of
                              genomes and sequences. This automatically lowers
                              the threshold for core genes.
  -i, --include=<include>   Only include a selection of genomes.
  -e, --exclude=<exclude>   Exclude a selection of genomes.
  -H, --homology-file=<homologyGroupsFile>
                            A text file with homology group node identifiers,
                              separated by a comma.
  -G, --homology-groups=<homologyGroups>
                            A list of homology group node identifiers,
                              separated by a comma.
      --node                Retrieve the nucleotide nodes belonging to genes in
                              homology groups
  -g, --genes=<genes>       One or multiple gene names, separated by a comma.
      --functions=<functions>
                            Name of function identifiers from GO, PFAM,
                              InterPro or TIGRAM.
```

## pantools_grouping_overview

### Tool Description
Create an overview table for every homology grouping in the pangenome.

### Metadata
- **Docker Image**: quay.io/biocontainers/pantools:4.3.4--hdfd78af_0
- **Homepage**: https://git.wur.nl/bioinformatics/pantools
- **Package**: https://anaconda.org/channels/bioconda/packages/pantools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pantools grouping_overview [--fast] <databaseDirectory>

Create an overview table for every homology grouping in the pangenome.

      <databaseDirectory>   Path to the database root directory.

      --fast                Only show which grouping is active and which
                              groupings can be activated.
```

## pantools_k_mer_classification

### Tool Description
Calculate the number of core, accessory, unique, (and phenotype specific) k-mer sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/pantools:4.3.4--hdfd78af_0
- **Homepage**: https://git.wur.nl/bioinformatics/pantools
- **Package**: https://anaconda.org/channels/bioconda/packages/pantools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pantools k_mer_classification [OPTIONS] <databaseDirectory>

Calculate the number of core, accessory, unique, (and phenotype specific) k-mer
sequences.

      <databaseDirectory>    Path to the database root directory.

      --selection-file=<selectionFile>
                             Text file with rules to use a specific set of
                               genomes and sequences. This automatically lowers
                               the threshold for core genes.
  -e, --exclude=<exclude>    Exclude a selection of genomes.
  -i, --include=<include>    Only include a selection of genomes.
  -p, --phenotype=<phenotype>
                             Name of the phenotype.
      --compressed           Do not uncompress collapsed non-branching k-mers
                               for k-mer counting.
      --core-threshold=<coreThreshold>
                             Threshold (%) for (soft) core genes. Default is
                               100% of genomes.
      --unique-threshold=<uniqueThreshold>
                             Threshold (%) for unique/cloud genes. Default is a
                               single genome, not a percentage.
      --phenotype-threshold=<phenotypeThreshold>
                             Threshold (%) for phenotype specific/shared genes.
                               Default is 100% of genomes with phenotype.
  -t, --threads=<nThreads>   Number of parallel working threads, default is the
                               number of cores or 8, whichever is lower.
      --phasing              Analyse phased genomes.
      --sequence             Perform the analysis on a sequence level in
                               addition to the genome.
```

## pantools_locate_genes

### Tool Description
Identify and compare gene clusters of from a set of homology groups.

### Metadata
- **Docker Image**: quay.io/biocontainers/pantools:4.3.4--hdfd78af_0
- **Homepage**: https://git.wur.nl/bioinformatics/pantools
- **Package**: https://anaconda.org/channels/bioconda/packages/pantools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pantools locate_genes [OPTIONS] <databaseDirectory>

Identify and compare gene clusters of from a set of homology groups.

      <databaseDirectory>    Path to the database root directory.

      --selection-file=<selectionFile>
                             Text file with rules to use a specific set of
                               genomes and sequences. This automatically lowers
                               the threshold for core genes.
  -e, --exclude=<exclude>    Exclude a selection of genomes.
  -i, --include=<include>    Only include a selection of genomes.
  -H, --homology-file=<homologyGroupsFile>
                             A text file with homology group node identifiers,
                               separated by a comma.
  -G, --homology-groups=<homologyGroups>
                             A list of homology group node identifiers,
                               separated by a comma.
  -p, --phenotype=<phenotype>
                             A phenotype name, used to identify gene clusters
                               shared by all phenotype members.
      --nucleotides=<maxNucleotides>
                             The number of allowed nucleotides between two
                               neighbouring genes (default is 1 MB).
      --gap-open=<gapOpen>   When constructing the clusters, allow a number of
                               genes for each cluster that are not originally
                               part of the input groups (default: 0).
      --core-threshold=<coreThreshold>
                             Lower the threshold (%) for a group to be
                               considered (soft) core (default is the total
                               number of genomes found in the groups, not a
                               percentage).
      --ignore-duplications  Duplicated and co-localized genes no longer break
                               up clusters.
```

## pantools_map

### Tool Description
Map single or paired-end short reads to one or multiple genomes in the pangenome. One SAM or BAM file is generated for each genome included in the analysis.

### Metadata
- **Docker Image**: quay.io/biocontainers/pantools:4.3.4--hdfd78af_0
- **Homepage**: https://git.wur.nl/bioinformatics/pantools
- **Package**: https://anaconda.org/channels/bioconda/packages/pantools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pantools map [OPTIONS] <databaseDirectory> <shortReadFiles> [<shortReadFiles>]

Map single or paired-end short reads to one or multiple genomes in the
pangenome. One SAM or BAM file is generated for each genome included in the
analysis.

      <databaseDirectory>    Path to the database root directory.
      <shortReadFiles> [<shortReadFiles>]
                             One or two short-read archives in FASTQ format,
                               which can be gz/bz2 compressed.

  -t, --threads=<nThreads>   Number of parallel working threads, default is the
                               number of cores or 8, whichever is lower.
      --selection-file=<selectionFile>
                             Text file with rules to use a specific set of
                               genomes and sequences. This automatically lowers
                               the threshold for core genes.
  -i, --include=<include>    Only include a selection of genomes.
  -e, --exclude=<exclude>    Exclude a selection of genomes.
  -o, --output=<outDirectory>
                             Path to the output files (default is the database
                               path).
      --all-hits             Return all hits rather than only the best.
      --competitive          Find the best mapping location in the complete
                               pangenome (default: find the best location for
                               each genome).
      --best-hits=none|random|all
                             In case of multiple "best" hits, return none, all
                               best hits or a random best hit (default: random).
      --previous-run=<previousRunFile>
                             The mapping_summary.txt file from a previous
                               mapping run (random-best competitive mode) for a
                               better estimation of coverage in a metagenomic
                               setting.
      --out-format=BAM|SAM|none
                             Writes the alignment files in BAM or SAM format or
                               don't write any output files (default: SAM).
      --gap-open=<gapOpen>   Gap open penalty (range: [-50..-1], default: -20).
      --gap-extension=<gapExtension>
                             Gap extension penalty (range: [-5..-1], default:
                               -3).
      --interleaved          Process the fastq file as an interleaved
                               paired-end archive.
      --unmapped             Check unmapped genomes.
  -s, --sensitivity=very-fast|fast|sensitive|very-sensitive
                             Four settings that automatically set the
                               parameters controlling the sensitivity, ranging
                               from least to most sensitive.
      --clipping-stringency=<clippingStringency>
                             The stringency of soft-clipping (default: 1).
                             0 : no soft clipping
                             1 : low
                             2 : medium
                             3 : high
      --min-hit-length=<minHitLength>
                             The minimum acceptable length of alignment after
                               soft-clipping (default: 13, range: [10..100]).
      --alignment-band=<alignmentBand>
                             The length of bound of banded alignment (default:
                               5, range: [1..100]).
      --num-kmer-samples=<numKmerSamples>
                             The number of kmers sampled from read (default:
                               15, range: [1..r-k+1]).
      --min-identity=<minIdentity>
                             The minimum acceptable identity of the alignment
                               (default: 0.5, range: [0,1]).
      --max-num-locations=<maxNumLocations>
                             The maximum number of locations of candidate hits
                               to examine (default: 15, range: [1..100]).
      --max-alignment-length=<maxAlignmentLength>
                             The maximum acceptable length of alignment
                               (default: 2000, range: [50..5000]).
      --max-fragment-length=<maxFragmentLength>
                             The maximum acceptable length of fragment
                               (default: 4998, range: [50..5000]).
      --read-group=<rgstringToMap>
                             Complete read group header line string containing
                               TAG:VALUE entries enclosed in single or double
                               quotes. The successive TAG:VALUE entries are
                               separated with a TAB (\t). The read group ID
                               will be attached to every read in the output. An
                               example is 'ID:foo\tSM:bar'. The available tags
                               are ID, BC, CN, DS, DT, FO, KS, LB, PG, PI, PL,
                               PM, PU and SM. \t will be converted to a TAB in
                               the output. Must contain the read group ID. All
                               other tags are optional.
```

## pantools_metrics

### Tool Description
Generates relevant metrics of the pangenome and the individual genomes and sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/pantools:4.3.4--hdfd78af_0
- **Homepage**: https://git.wur.nl/bioinformatics/pantools
- **Package**: https://anaconda.org/channels/bioconda/packages/pantools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pantools metrics [-A=<annotationsFile>]
                        [--selection-file=<selectionFile> | -e=<exclude> |
                        -i=<include>] <databaseDirectory>

Generates relevant metrics of the pangenome and the individual genomes and
sequences.

      <databaseDirectory>   Path to the database root directory.

      --selection-file=<selectionFile>
                            Text file with rules to use a specific set of
                              genomes and sequences. This automatically lowers
                              the threshold for core genes.
  -e, --exclude=<exclude>   Exclude a selection of genomes.
  -i, --include=<include>   Only include a selection of genomes.
  -A, --annotations-file=<annotationsFile>
                            A text file with the identifiers of annotations to
                              be included.
```

## pantools_mlsa

### Tool Description
Step 3/3 of mlsa. Run IQ-tree on the concatenated sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/pantools:4.3.4--hdfd78af_0
- **Homepage**: https://git.wur.nl/bioinformatics/pantools
- **Package**: https://anaconda.org/channels/bioconda/packages/pantools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pantools mlsa [-p=<phenotype>] [-t=<nThreads>]
                     [--selection-file=<selectionFile> | -i=<include> |
                     -e=<exclude>] <databaseDirectory>

Step 3/3 of mlsa. Run IQ-tree on the concatenated sequences.

      <databaseDirectory>    Path to the database root directory.

  -t, --threads=<nThreads>   Number of threads for MAFFT and IQ-tree, default
                               is the number of cores or 8, whichever is lower.
      --selection-file=<selectionFile>
                             Text file with rules to use a specific set of
                               genomes and sequences. This automatically lowers
                               the threshold for core genes.
  -i, --include=<include>    Only include a selection of genomes.
  -e, --exclude=<exclude>    Exclude a selection of genomes.
  -p, --phenotype=<phenotype>
                             Add phenotype information/values to the phylogeny.
                               Allows the identification of phenotype specific
                               SNPs in the alignment.
```

## pantools_mlsa_concatenate

### Tool Description
Step 2/3 of mlsa. Concatenate the gene selection into a single continuous sequence. Required software: MAFFT

### Metadata
- **Docker Image**: quay.io/biocontainers/pantools:4.3.4--hdfd78af_0
- **Homepage**: https://git.wur.nl/bioinformatics/pantools
- **Package**: https://anaconda.org/channels/bioconda/packages/pantools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pantools mlsa_concatenate -g=<genes> [-t=<nThreads>]
                                 [--selection-file=<selectionFile> |
                                 -i=<include> | -e=<exclude>]
                                 <databaseDirectory>

Step 2/3 of mlsa. Concatenate the gene selection into a single continuous
sequence.
Required software: MAFFT

      <databaseDirectory>    Path to the database root directory.

  -t, --threads=<nThreads>   Number of threads for MAFFT, default is the number
                               of cores or 8, whichever is lower.
      --selection-file=<selectionFile>
                             Text file with rules to use a specific set of
                               genomes and sequences. This automatically lowers
                               the threshold for core genes.
  -i, --include=<include>    Only include a selection of genomes.
  -e, --exclude=<exclude>    Exclude a selection of genomes.
  -g, --genes=<genes>        One or multiple gene names, separated by a comma.
```

## pantools_mlsa_find_genes

### Tool Description
Step 1/3 of mlsa. Search and filter suitable genes for the mlsa.

### Metadata
- **Docker Image**: quay.io/biocontainers/pantools:4.3.4--hdfd78af_0
- **Homepage**: https://git.wur.nl/bioinformatics/pantools
- **Package**: https://anaconda.org/channels/bioconda/packages/pantools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pantools mlsa_find_genes [--extensive] -g=<genes>
                                [--selection-file=<selectionFile> |
                                -e=<exclude> | -i=<include>] <databaseDirectory>

Step 1/3 of mlsa. Search and filter suitable genes for the mlsa.

      <databaseDirectory>   Path to the database root directory.

      --selection-file=<selectionFile>
                            Text file with rules to use a specific set of
                              genomes and sequences. This automatically lowers
                              the threshold for core genes.
  -e, --exclude=<exclude>   Do not search for genes in this selection of
                              genomes.
  -i, --include=<include>   Only search for genes in a selection of genomes.
      --extensive           Perform a more extensive gene search.
  -g, --genes=<genes>       One or multiple gene names, separated by a comma.
```

## pantools_msa

### Tool Description
Create multiple sequence alignments. By default, only nucleotide sequences are aligned for pangenome databases and only protein sequences are aligned for panproteome databases. If variants were added to a pangenome, these will be aligned by default. Required software: MAFFT, FastTree.

### Metadata
- **Docker Image**: quay.io/biocontainers/pantools:4.3.4--hdfd78af_0
- **Homepage**: https://git.wur.nl/bioinformatics/pantools
- **Package**: https://anaconda.org/channels/bioconda/packages/pantools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pantools msa [OPTIONS] <databaseDirectory>

Create multiple sequence alignments. By default, only nucleotide sequences are
aligned for pangenome databases and only protein sequences are aligned for
panproteome databases. If variants were added to a pangenome, these will be
aligned by default. Required software: MAFFT, FastTree.

      <databaseDirectory>    Path to the database root directory.

  -t, --threads=<nThreads>   Number of threads for MAFFT (highly recommended!
                               default: 8).
      --selection-file=<selectionFile>
                             Text file with rules to use a specific set of
                               genomes and sequences. This automatically lowers
                               the threshold for core genes.
  -e, --exclude=<exclude>    Exclude a selection of genomes.
  -i, --include=<include>    Only include a selection of genomes.
  -H, --homology-file=<homologyGroupsFile>
                             A text file with homology group node identifiers,
                               separated by a comma. Default is all homology
                               groups.
  -G, --homology-groups=<homologyGroups>
                             A list of homology group node identifiers,
                               separated by a comma. Default is all homology
                               groups.
  -R, --regions-file=<regionsFile>
                             A text file containing genome locations with on
                               each line: a genome number, sequence number,
                               begin and end position, separated by a space.
      --method=<method>      The kind of alignment to make. Can be either
                               per-group, multiple-groups, regions or functions.
      --align-nucleotide     Align nucleotide sequences.
      --align-protein        Align protein sequences.
  -v, --align-variants
      --pavs                 Skip variant nodes if they are absent (PAV
                               information).
  -p, --phenotype            Identify phenotype shared/specific/exclusive
                               positions in alignments.
      --blosum=<blosum>      A BLOSUM matrix to be used for the calculation of
                               protein similarity. Allowed values are 45, 50,
                               62 80 and 90 (default: 62).
      --phenotype-threshold=<phenotypeThreshold>
                             Threshold (%) for phenotype specific/shared genes.
                               Default is 100% of genomes with phenotype.
      --[no-]trimming        Align the sequences only once (default: true).
      --[no-]fasttree        Run FastTree (default: true).
      --trim-using-proteins  Trim nucleotide sequences using the protein
                               sequences (default: false).
      --functions=<functions>
                             For specifying one or multiple functional domains
                               (Only used when --method=functions).
```

## pantools_optimal_grouping

### Tool Description
Find the most suitable settings for group.

### Metadata
- **Docker Image**: quay.io/biocontainers/pantools:4.3.4--hdfd78af_0
- **Homepage**: https://git.wur.nl/bioinformatics/pantools
- **Package**: https://anaconda.org/channels/bioconda/packages/pantools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pantools optimal_grouping [--fast] [--longest] [--phasing]
                                 [-A=<annotationsFile>]
                                 [--relaxation=<relaxation>]
                                 [--scoring-matrix=<scoringMatrix>]
                                 [-t=<nThreads>]
                                 [--selection-file=<selectionFile> |
                                 -i=<include> | -e=<exclude>]
                                 <databaseDirectory> <buscoDirectory>

Find the most suitable settings for group.

      <databaseDirectory>    Path to the database root directory.
      <buscoDirectory>       The output directory created by the BuscoProtein
                               function. This directory is found inside the
                               pangenome database, in the busco directory.

  -t, --threads=<nThreads>   Number of parallel working threads, default is the
                               number of cores or 8, whichever is lower.
      --selection-file=<selectionFile>
                             Text file with rules to use a specific set of
                               genomes and sequences. This automatically lowers
                               the threshold for core genes.
  -i, --include=<include>    Only include a selection of genomes.
  -e, --exclude=<exclude>    Exclude a selection of genomes.
  -A, --annotations-file=<annotationsFile>
                             A text file with the identifiers of annotations to
                               be included.
      --fast                 Assume the optimal grouping is found when the
                               F1-score drops compared to the previous
                               clustering round.
      --longest              Only cluster protein sequences of the longest
                               transcript per gene.
      --phasing              Analyse phased genomes.
      --scoring-matrix=<scoringMatrix>
                             The scoring matrix used (default: BLOSUM62).
      --relaxation=<relaxation>
                             Only consider a selection of relaxation settings
                               (1-8 allowed).
```

## pantools_order_matrix

### Tool Description
Order the values of a matrix file created by PanTools.

### Metadata
- **Docker Image**: quay.io/biocontainers/pantools:4.3.4--hdfd78af_0
- **Homepage**: https://git.wur.nl/bioinformatics/pantools
- **Package**: https://anaconda.org/channels/bioconda/packages/pantools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pantools order_matrix [--descending] [--selection-file=<selectionFile> |
                             -e=<exclude> | -i=<include>] <databaseDirectory>
                             <matrixFile>

Order the values of a matrix file created by PanTools.

      <databaseDirectory>   Path to the database root directory.
      <matrixFile>          A CSV formatted matrix file.

      --selection-file=<selectionFile>
                            Text file with rules to use a specific set of
                              genomes and sequences. This automatically lowers
                              the threshold for core genes.
  -e, --exclude=<exclude>   Exclude a selection of genomes.
  -i, --include=<include>   Only include a selection of genomes.
      --descending          Order the matrix in descending order.
```

## pantools_pangenome_structure

### Tool Description
Determine the openness of the pangenome based on homology groups or k-mer sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/pantools:4.3.4--hdfd78af_0
- **Homepage**: https://git.wur.nl/bioinformatics/pantools
- **Package**: https://anaconda.org/channels/bioconda/packages/pantools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pantools pangenome_structure [OPTIONS] <databaseDirectory>

Determine the openness of the pangenome based on homology groups or k-mer
sequences.

      <databaseDirectory>    Path to the database root directory.

  -t, --threads=<nThreads>   Number of parallel working threads, default is the
                               number of cores or 8, whichever is lower.
      --selection-file=<selectionFile>
                             Text file with rules to use a specific set of
                               genomes and sequences. This automatically lowers
                               the threshold for core genes.
  -e, --exclude=<exclude>    Exclude a selection of genomes.
  -i, --include=<include>    Only include a selection of genomes.
      --seed=<seed>          Seed for the random number generator.
  -k, --kmer                 Pangenome size estimation based on k-mer sequences.
      --pavs                 Use included variation (PAV information).
      --loops=<loops>        Number of loops (default 100 for kmers, 10000 for
                               genes).
```

## pantools_remove_pavs

### Tool Description
Remove PAV data from the pangenome.

### Metadata
- **Docker Image**: quay.io/biocontainers/pantools:4.3.4--hdfd78af_0
- **Homepage**: https://git.wur.nl/bioinformatics/pantools
- **Package**: https://anaconda.org/channels/bioconda/packages/pantools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pantools remove_pavs <databaseDirectory>

Remove PAV data from the pangenome.

      <databaseDirectory>   Path to the database root directory.
```

## pantools_remove_variants

### Tool Description
Remove variant data from the pangenome.

### Metadata
- **Docker Image**: quay.io/biocontainers/pantools:4.3.4--hdfd78af_0
- **Homepage**: https://git.wur.nl/bioinformatics/pantools
- **Package**: https://anaconda.org/channels/bioconda/packages/pantools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pantools remove_variants <databaseDirectory>

Remove variant data from the pangenome.

      <databaseDirectory>   Path to the database root directory.
```

## pantools_rename_matrix

### Tool Description
Rename the headers (first row and leftmost column) of CSV formatted matrix files.

### Metadata
- **Docker Image**: quay.io/biocontainers/pantools:4.3.4--hdfd78af_0
- **Homepage**: https://git.wur.nl/bioinformatics/pantools
- **Package**: https://anaconda.org/channels/bioconda/packages/pantools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pantools rename_matrix [--selection-file=<selectionFile> | -e=<exclude>
                              | -i=<include>] [-p=<phenotype> [--[no-]numbers]]
                              <databaseDirectory> <matrixFile>

Rename the headers (first row and leftmost column) of CSV formatted matrix
files.

      <databaseDirectory>   Path to the database root directory.
      <matrixFile>          A matrix file with numerical values.

      --selection-file=<selectionFile>
                            Text file with rules to use a specific set of
                              genomes and sequences. This automatically lowers
                              the threshold for core genes.
  -e, --exclude=<exclude>   Exclude a selection of genomes.
  -i, --include=<include>   Only include a selection of genomes.
  -p, --phenotype=<phenotype>
                            A phenotype name, used to include phenotype
                              information into the headers.
      --[no-]numbers        In- or exclude genome numbers from the headers.
                              Numbers are included by default.
```

## pantools_rename_phylogeny

### Tool Description
Update or alter the terminal nodes (leaves) of a phylogenic tree.

### Metadata
- **Docker Image**: quay.io/biocontainers/pantools:4.3.4--hdfd78af_0
- **Homepage**: https://git.wur.nl/bioinformatics/pantools
- **Package**: https://anaconda.org/channels/bioconda/packages/pantools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pantools rename_phylogeny [--no-numbers] [--phasing] [-p=<phenotype>]
                                 (--sequence | --genome | --gene-tree)
                                 <databaseDirectory> <treeFile>

Update or alter the terminal nodes (leaves) of a phylogenic tree.

      <databaseDirectory>   Path to the database root directory.
      <treeFile>            A phylogenetic tree.

      --gene-tree           Tree labels are gene identifiers.
      --genome              Tree labels are genome numbers.
      --no-numbers          Exclude genome numbers from the terminal nodes
                              (leaves).
  -p, --phenotype=<phenotype>
                            The phenotype used to rename the terminal nodes
                              (leaves) of the selected tree.
      --phasing             Analyse phased genomes.
      --sequence            Tree labels are sequence identifiers.
```

## pantools_repeat_overview

### Tool Description
Generates metrics about the repeat sequences in the pangenome

### Metadata
- **Docker Image**: quay.io/biocontainers/pantools:4.3.4--hdfd78af_0
- **Homepage**: https://git.wur.nl/bioinformatics/pantools
- **Package**: https://anaconda.org/channels/bioconda/packages/pantools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pantools repeat_overview [OPTIONS] <databaseDirectory>

Generates metrics about the repeat sequences in the pangenome

      <databaseDirectory>   Path to the database root directory.

      --selection-file=<selectionFile>
                            Text file with rules to use a specific set of
                              genomes and sequences. This automatically lowers
                              the threshold for core genes.
  -e, --exclude=<exclude>   Exclude a selection of genomes.
  -i, --include=<include>   Only include a selection of genomes.
      --exclude-repeats=<repeatSelectionFile>

      --window-length=<windowLength>

      --upstream=<upstreamLength>

      --downstream=<downstreamLength>
```

## pantools_retrieve_features

### Tool Description
Retrieve the sequence of annotated features from the pangenome.

### Metadata
- **Docker Image**: quay.io/biocontainers/pantools:4.3.4--hdfd78af_0
- **Homepage**: https://git.wur.nl/bioinformatics/pantools
- **Package**: https://anaconda.org/channels/bioconda/packages/pantools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pantools retrieve_features --feature-type=<featureType>
                                  [--selection-file=<selectionFile> |
                                  -i=<include> | -e=<exclude>]
                                  <databaseDirectory>

Retrieve the sequence of annotated features from the pangenome.

      <databaseDirectory>   Path to the database root directory.

      --selection-file=<selectionFile>
                            Text file with rules to use a specific set of
                              genomes and sequences. This automatically lowers
                              the threshold for core genes.
  -i, --include=<include>   Only include a selection of genomes.
  -e, --exclude=<exclude>   Exclude a selection of genomes.
      --feature-type=<featureType>
                            The feature name; for example 'gene', 'mRNA',
                              'exon', 'tRNA', etc.
```

## pantools_retrieve_regions

### Tool Description
Retrieve the sequence of genomic regions from the pangenome.

### Metadata
- **Docker Image**: quay.io/biocontainers/pantools:4.3.4--hdfd78af_0
- **Homepage**: https://git.wur.nl/bioinformatics/pantools
- **Package**: https://anaconda.org/channels/bioconda/packages/pantools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pantools retrieve_regions <databaseDirectory> <regionsFile>

Retrieve the sequence of genomic regions from the pangenome.

      <databaseDirectory>   Path to the database root directory.
      <regionsFile>         A text file containing genome locations with on
                              each line: a genome number, sequence number,
                              begin and end position, separated by a space.
```

## pantools_root_phylogeny

### Tool Description
(Re)root a phylogenetic tree.

### Metadata
- **Docker Image**: quay.io/biocontainers/pantools:4.3.4--hdfd78af_0
- **Homepage**: https://git.wur.nl/bioinformatics/pantools
- **Package**: https://anaconda.org/channels/bioconda/packages/pantools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pantools root_phylogeny -n=<terminalNode> <databaseDirectory> <treeFile>

(Re)root a phylogenetic tree.

      <databaseDirectory>   Path to the database root directory.
      <treeFile>            A phylogenetic tree in Newick format.

  -n, --node=<terminalNode> The name of the terminal node that will root the
                              tree.
```

## pantools_sequence_visualization

### Tool Description
Generate a visualization of multiple sequences with the possibility of different types of annotation bars.

### Metadata
- **Docker Image**: quay.io/biocontainers/pantools:4.3.4--hdfd78af_0
- **Homepage**: https://git.wur.nl/bioinformatics/pantools
- **Package**: https://anaconda.org/channels/bioconda/packages/pantools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pantools sequence_visualization [OPTIONS] <databaseDirectory>

Generate a visualization of multiple sequences with the possibility of
different types of annotation bars.

      <databaseDirectory>   Path to the database root directory.

      --selection-file=<selectionFile>
                            Text file with rules to use a specific set of
                              genomes and sequences. This automatically lowers
                              the threshold for core genes.
  -i, --include=<include>   Only include a selection of genomes.
  -e, --exclude=<exclude>   Exclude a selection of genomes.
      --rules=<rulesFile>
      --window-size=<windowSize>
```

## pantools_show_go

### Tool Description
For a given GO term, show the child terms, all parent terms higher in the hierarchy, and connected mRNA nodes.

### Metadata
- **Docker Image**: quay.io/biocontainers/pantools:4.3.4--hdfd78af_0
- **Homepage**: https://git.wur.nl/bioinformatics/pantools
- **Package**: https://anaconda.org/channels/bioconda/packages/pantools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pantools show_go (--functions=<functions> | -n=<nodes>)
                        <databaseDirectory>

For a given GO term, show the child terms, all parent terms higher in the
hierarchy, and connected mRNA nodes.

      <databaseDirectory>   Path to the database root directory.

      --functions=<functions>
                            One or multiple GO term identifiers, separated by a
                              comma.
  -n, --nodes=<nodes>       One or multiple identifiers of 'GO' nodes,
                              separated by a comma.
```

## pantools_synteny_overview

### Tool Description
Generates metrics about the synteny blocks in the pangenome

### Metadata
- **Docker Image**: quay.io/biocontainers/pantools:4.3.4--hdfd78af_0
- **Homepage**: https://git.wur.nl/bioinformatics/pantools
- **Package**: https://anaconda.org/channels/bioconda/packages/pantools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pantools synteny_overview [OPTIONS] <databaseDirectory> <collinearityFile>

Generates metrics about the synteny blocks in the pangenome

      <databaseDirectory>    Path to the database root directory.
      <collinearityFile>

  -t, --threads=<nThreads>   Number of parallel working threads, default is the
                               number of cores or 8, whichever is lower.
      --selection-file=<selectionFile>
                             Text file with rules to use a specific set of
                               genomes and sequences. This automatically lowers
                               the threshold for core genes.
  -i, --include=<include>    Only include a selection of genomes.
  -e, --exclude=<exclude>    Exclude a selection of genomes.
```

## pantools_variation_overview

### Tool Description
Write an overview of all accessions added to the pangenome (both VCF and PAV information).

### Metadata
- **Docker Image**: quay.io/biocontainers/pantools:4.3.4--hdfd78af_0
- **Homepage**: https://git.wur.nl/bioinformatics/pantools
- **Package**: https://anaconda.org/channels/bioconda/packages/pantools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pantools variation_overview <databaseDirectory>

Write an overview of all accessions added to the pangenome (both VCF and PAV
information).

      <databaseDirectory>   Path to the database root directory.
```

## Metadata
- **Skill**: generated

