# frogs CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| frogs_affiliation_filters | PASS |  |
| frogs_affiliation_postprocess | PASS |  |
| frogs_affiliation_report | PASS |  |
| frogs_biom_to_stdBiom | PASS |  |
| frogs_biom_to_tsv | PASS |  |
| frogs_cluster_asv_report | PASS |  |
| frogs_cluster_filters | PASS | the contaminant option crashes because makeblastdb is missing from the image; all other filters work |
| frogs_clustering | Failed | image problem: swarm is missing from the image |
| frogs_demultiplex | PASS |  |
| frogs_deseq2_preprocess | Failed | image problem: Rscript (R and the phyloseq packages) is missing from the image |
| frogs_deseq2_visualisation | Failed | image problem: Rscript (R and the phyloseq packages) is missing from the image |
| frogs_frogsfunc_functions | Failed | image problem: PICRUSt2 and the Python module ete3 are missing from the image |
| frogs_frogsfunc_pathways | Failed | image problem: PICRUSt2 pathway_pipeline.py is missing from the image |
| frogs_frogsfunc_placeseqs | Failed | image problem: PICRUSt2 and the Python module ete3 are missing from the image |
| frogs_itsx.py | Failed | image problem: itsx.py stops with FileNotFoundError because the ITSx program is missing from the image |
| frogs_normalisation | PASS |  |
| frogs_phyloseq_alpha_diversity | Failed | image problem: Rscript (R and the phyloseq packages) is missing from the image |
| frogs_phyloseq_beta_diversity | Failed | image problem: Rscript (R and the phyloseq packages) is missing from the image |
| frogs_phyloseq_clustering | Failed | image problem: Rscript (R and the phyloseq packages) is missing from the image |
| frogs_phyloseq_composition | Failed | image problem: Rscript (R and the phyloseq packages) is missing from the image |
| frogs_phyloseq_import_data | Failed | image problem: Rscript (R and the phyloseq packages) is missing from the image |
| frogs_phyloseq_manova | Failed | image problem: Rscript (R and the phyloseq packages) is missing from the image |
| frogs_phyloseq_structure | Failed | image problem: Rscript (R and the phyloseq packages) is missing from the image |
| frogs_reads_processing | Failed | image problem: vsearch is missing from the image |
| frogs_remove_chimera | Failed | image problem: vsearch is missing from the image |
| frogs_taxonomic_affiliation | Failed | image problem: blastn and the NeedleAll aligner are missing from the image |
| frogs_tree | Failed | image problem: mafft is missing from the image |
| frogs_tsv_to_biom | PASS |  |

## frogs_itsx.py

### Tool Description
Uses ITSx to detect/extracts ITS1 or ITS2 regions from ITS sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/frogs:5.1.0--h9ee0642_0
- **Homepage**: https://github.com/geraldinepascal/FROGS
- **Package**: https://anaconda.org/channels/bioconda/packages/frogs/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/frogs/overview
- **Total Downloads**: 35.9K
- **Last updated**: 2026-01-15
- **GitHub**: https://github.com/geraldinepascal/FROGS
- **Stars**: N/A
### Original Help Text
```text
usage: itsx.py [-h] [--version] [--debug] [--nb-cpus NB_CPUS]
               [--organism-groups ORGANISM_GROUPS [ORGANISM_GROUPS ...]]
               (--region {ITS1,ITS2} | --check-its-only) --input-fasta
               INPUT_FASTA [--input-biom INPUT_BIOM]
               [--output-fasta OUTPUT_FASTA] [--output-biom OUTPUT_BIOM]
               [--output-removed-sequences OUTPUT_REMOVED_SEQUENCES]
               [--html HTML] [--log-file LOG_FILE]

Uses ITSx to detect/extracts ITS1 or ITS2 regions from ITS sequences.

optional arguments:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  --debug               Keep temporary files to debug program. [Default:
                        False]
  --nb-cpus NB_CPUS     The maximum number of CPUs used. [Default: 1]

Parameters:
  --organism-groups ORGANISM_GROUPS [ORGANISM_GROUPS ...]
                        Reduce ITSx scan to specified organim groups.
                        [Default: ['F'] , which means Fungi only]
  --region {ITS1,ITS2}  Which fungal ITS region is targeted and trimmed:
                        either ITS1 or ITS2. (mutually exclusive with --check-
                        its-only) [Default: None]
  --check-its-only      Check only if sequences seem to be an ITS (mutually
                        exclusive with --region) [Default: False]

Inputs:
  --input-fasta INPUT_FASTA
                        The cluster sequences (format: FASTA).
  --input-biom INPUT_BIOM
                        The abundance file for clusters by sample (format:
                        BIOM).

Outputs:
  --output-fasta OUTPUT_FASTA
                        sequences file out from ITSx (format: FASTA).
                        [Default: itsx.fasta]
  --output-biom OUTPUT_BIOM
                        Abundance file without chimera (format: BIOM ).
                        [Default: itsx_abundance.biom]
  --output-removed-sequences OUTPUT_REMOVED_SEQUENCES
                        sequences file removed (format: FASTA). [Default:
                        itsx_removed.fasta]
  --html HTML           The HTML file containing the graphs. [Default:
                        itsx.html]
  --log-file LOG_FILE   This output file will contain several informations on
                        executed commands. [Default: stdout]
```

## frogs_affiliation_filters

### Tool Description
Filters an abundance biom file on affiliations metrics

### Metadata
- **Docker Image**: quay.io/biocontainers/frogs:5.1.0--h9ee0642_0
- **Homepage**: https://github.com/geraldinepascal/FROGS
- **Package**: https://anaconda.org/channels/bioconda/packages/frogs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: affiliation_filters.py [-h] [--version] [--debug]
                              [--taxonomic-ranks TAXONOMIC_RANKS [TAXONOMIC_RANKS ...]]
                              [--taxonomy-tag TAXONOMY_TAG | --tax-consensus-tag TAX_CONSENSUS_TAG]
                              [--multiple-tag MULTIPLE_TAG]
                              [--bootstrap-tag BOOTSTRAP_TAG]
                              [--identity-tag IDENTITY_TAG]
                              [--coverage-tag COVERAGE_TAG]
                              [--mask | --delete]
                              [--ignore-blast-taxa [IGNORE_BLAST_TAXA [IGNORE_BLAST_TAXA ...]]
                              | --keep-blast-taxa
                              [KEEP_BLAST_TAXA [KEEP_BLAST_TAXA ...]]]
                              [--min-rdp-bootstrap TAXONOMIC_LEVEL:MIN_BOOTSTRAP]
                              [--min-blast-identity MIN_BLAST_IDENTITY]
                              [--min-blast-coverage MIN_BLAST_COVERAGE]
                              [--min-blast-subject-coverage MIN_BLAST_SUBJECT_COVERAGE]
                              [--max-blast-subject-coverage MAX_BLAST_SUBJECT_COVERAGE]
                              [--max-blast-evalue MAX_BLAST_EVALUE]
                              [--min-blast-length MIN_BLAST_LENGTH]
                              --input-biom INPUT_BIOM --input-fasta
                              INPUT_FASTA [--output-biom OUTPUT_BIOM]
                              [--output-fasta OUTPUT_FASTA] [--html HTML]
                              [--impacted IMPACTED]
                              [--impacted-multihit IMPACTED_MULTIHIT]
                              [--log-file LOG_FILE]

Filters an abundance biom file on affiliations metrics

optional arguments:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  --debug               Keep temporary files to debug program. [Default:
                        False]
  --taxonomic-ranks TAXONOMIC_RANKS [TAXONOMIC_RANKS ...]
                        The ordered ranks levels used in the metadata
                        taxonomy. [Default: ['Domain', 'Phylum', 'Class',
                        'Order', 'Family', 'Genus', 'Species']]
  --taxonomy-tag TAXONOMY_TAG
                        The metadata tag used in BIOM file to store the
                        taxonomy. Use this parameter if the taxonomic
                        affiliation has been processed by a software that adds
                        only one affiliation or if you does not have a
                        metadata with the consensus taxonomy (see "--tax-
                        consensus-tag").Not allowed with --tax-consensus-tag.
                        [Default: None]
  --tax-consensus-tag TAX_CONSENSUS_TAG
                        The metadata tag used in BIOM file to store the
                        consensus taxonomy. This parameter is used instead of
                        "--taxonomy-tag" when you have several affiliations
                        for each ASV. [Default: blast_taxonomy]
  --multiple-tag MULTIPLE_TAG
                        The metadata tag used in BIOM file to store the list
                        of possible taxonomies. Use this parameter if the
                        taxonomic affiliation has been processed by a software
                        that adds several affiliation in the BIOM file
                        (example: same score ambiguity). [Default: None]
  --bootstrap-tag BOOTSTRAP_TAG
                        The metadata tag used in BIOM file to store the
                        taxonomy bootstraps. [Default: None]
  --identity-tag IDENTITY_TAG
                        The metadata tag used in BIOM file to store the
                        alignment identity. [Default: None]
  --coverage-tag COVERAGE_TAG
                        The metadata tag used in BIOM file to store the
                        alignment observation coverage. [Default: None]

Filters behavior:
  --mask                If affiliations do not respect one of the filter they
                        are replaced by NA (mutually exclusive with --delete)
                        [Default: False]
  --delete              If affiliations do not respect one of the filter the
                        entire ASV is deleted.(mutually exclusive with --mask)
                        [Default: False]

Filters:
  --ignore-blast-taxa [IGNORE_BLAST_TAXA [IGNORE_BLAST_TAXA ...]]
                        Taxon list to masks/delete in Blast affiliations
  --keep-blast-taxa [KEEP_BLAST_TAXA [KEEP_BLAST_TAXA ...]]
                        Taxon list to keep in Blast affiliations. All others
                        affiliations will be masks/delete.
  --min-rdp-bootstrap TAXONOMIC_LEVEL:MIN_BOOTSTRAP
                        The TAXONOMIC_LEVEL must be one of the --taxonomic-
                        ranks. The minimal RDP bootstrap must be between 0 and
                        1.
  --min-blast-identity MIN_BLAST_IDENTITY
                        The number corresponding to the blast percentage
                        identity (between 0 and 100).
  --min-blast-coverage MIN_BLAST_COVERAGE
                        The number corresponding to the query blast percentage
                        coverage (between 0 and 100).
  --min-blast-subject-coverage MIN_BLAST_SUBJECT_COVERAGE
                        The number min corresponding to the subject blast
                        percentage coverage (between 0 and 100).
  --max-blast-subject-coverage MAX_BLAST_SUBJECT_COVERAGE
                        The number max corresponding to the subject blast
                        percentage coverage (between 0 and 100).
  --max-blast-evalue MAX_BLAST_EVALUE
                        The number corresponding to the blast e value (between
                        0 and 1).
  --min-blast-length MIN_BLAST_LENGTH
                        The number corresponding to the blast length.

Inputs:
  --input-biom INPUT_BIOM
                        The input biom file.
  --input-fasta INPUT_FASTA
                        The input fasta file.

Outputs:
  --output-biom OUTPUT_BIOM
                        The Biom file output. [Default: affiliation-
                        filtered.biom]
  --output-fasta OUTPUT_FASTA
                        The fasta output file. [Default: affiliation-
                        filtered.fasta]
  --html HTML           The HTML file containing the graphs. [Default:
                        summary.html]
  --impacted IMPACTED   The abundance file that summarizes all the clusters
                        impacted (deleted or with affiliations masked).
                        [Default: impacted_clusters.tsv]
  --impacted-multihit IMPACTED_MULTIHIT
                        The multihit TSV file associated with impacted ASV.
                        [Default: impacted_clusters_multihit.tsv]
  --log-file LOG_FILE   The list of commands executed. [Default: stdout]
```

## frogs_affiliation_postprocess

### Tool Description
Refine affiliations, to manage ampli1con included in other sequence, and to deal with surnumerary ASV (ASV with same affiliations).

### Metadata
- **Docker Image**: quay.io/biocontainers/frogs:5.1.0--h9ee0642_0
- **Homepage**: https://github.com/geraldinepascal/FROGS
- **Package**: https://anaconda.org/channels/bioconda/packages/frogs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: affiliation_postprocess.py [-h] [--version] [--debug]
                                  [--identity IDENTITY] [--coverage COVERAGE]
                                  [--taxon-ignored [TAXON_IGNORED [TAXON_IGNORED ...]]]
                                  --input-biom INPUT_BIOM --input-fasta
                                  INPUT_FASTA [--reference REFERENCE]
                                  [--output-biom OUTPUT_BIOM]
                                  [--output-compo OUTPUT_COMPO]
                                  [--output-fasta OUTPUT_FASTA]
                                  [--log-file LOG_FILE]

Refine affiliations, to manage ampli1con included in other sequence, and to
deal with surnumerary ASV (ASV with same affiliations).

optional arguments:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  --debug               Keep temporary files to debug program. [Default:
                        False]
  --identity IDENTITY   Min percentage identity to agggregate ASV. [Default:
                        99.0]
  --coverage COVERAGE   Min percentage coverage to agggregate ASV. [Default:
                        99.0]
  --taxon-ignored [TAXON_IGNORED [TAXON_IGNORED ...]]
                        Taxon list to ignore when ASVs agggregation

Inputs:
  --input-biom INPUT_BIOM
                        Abundance table with affiliations metadata from the
                        affiliation_ASV program (format: BIOM).
  --input-fasta INPUT_FASTA
                        ASV seed sequence file (format: FASTA).
  --reference REFERENCE
                        amplicon reference file, to resolve inclusive amplicon
                        affiliations (format: FASTA)

Outputs:
  --output-biom OUTPUT_BIOM
                        BIOM file whith refind affiliation annotations.
                        (format: BIOM) [Default:
                        affiliation_postprocess_abundance.biom]
  --output-compo OUTPUT_COMPO
                        Aggregated ASV composition (format: TSV) [Default:
                        affiliation_postprocess_asv_composition.tsv]
  --output-fasta OUTPUT_FASTA
                        Updated ASV FASTA file (format: FASTA) [Default:
                        affiliation_postprocess_ASV.fasta]
  --log-file LOG_FILE   The list of commands executed. [Default: stdout]
```

## frogs_affiliation_report

### Tool Description
Produces several metrics describing ASVs based on their taxonomies and the quality of the affiliations.

### Metadata
- **Docker Image**: quay.io/biocontainers/frogs:5.1.0--h9ee0642_0
- **Homepage**: https://github.com/geraldinepascal/FROGS
- **Package**: https://anaconda.org/channels/bioconda/packages/frogs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: affiliation_report.py [-h] [--version] [--debug]
                             [--taxonomic-ranks [TAXONOMIC_RANKS [TAXONOMIC_RANKS ...]]]
                             [--rarefaction-ranks [RAREFACTION_RANKS [RAREFACTION_RANKS ...]]]
                             [--taxonomy-tag TAXONOMY_TAG | --tax-consensus-tag TAX_CONSENSUS_TAG]
                             [--multiple-tag MULTIPLE_TAG]
                             [--bootstrap-tag BOOTSTRAP_TAG]
                             [--identity-tag IDENTITY_TAG]
                             [--coverage-tag COVERAGE_TAG] --input-biom
                             INPUT_BIOM [--html HTML] [--log-file LOG_FILE]

Produces several metrics describing ASVs based on their taxonomies and the
quality of the affiliations.

optional arguments:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  --debug               Keep temporary files to debug program. [Default:
                        False]
  --taxonomic-ranks [TAXONOMIC_RANKS [TAXONOMIC_RANKS ...]]
                        The ordered ranks levels used in the metadata
                        taxonomy. [Default: ['Domain', 'Phylum', 'Class',
                        'Order', 'Family', 'Genus', 'Species']]
  --rarefaction-ranks [RAREFACTION_RANKS [RAREFACTION_RANKS ...]]
                        The ranks that will be evaluated in rarefaction.
                        [Default: ['Genus']]
  --taxonomy-tag TAXONOMY_TAG
                        The metadata tag used in BIOM file to store the
                        taxonomy. Use this parameter if the taxonomic
                        affiliation has been processed by a software that adds
                        only one affiliation or if you don't have a metadata
                        with the consensus taxonomy (see "--tax-consensus-
                        tag").Not allowed with --tax-consensus-tag. ex:
                        rdp_taxonomy
  --tax-consensus-tag TAX_CONSENSUS_TAG
                        The metadata tag used in BIOM file to store the
                        consensus taxonomy. This parameter is used instead of
                        "--taxonomy-tag" when you have several affiliations
                        for each ASV. ex: blast_taxonomy
  --multiple-tag MULTIPLE_TAG
                        The metadata tag used in BIOM file to store the list
                        of possible taxonomies. Use this parameter if the
                        taxonomic affiliation has been processed by a software
                        that adds several affiliation in the BIOM file
                        (example: same score ambiguity). ex blast_affiliations
  --bootstrap-tag BOOTSTRAP_TAG
                        The metadata tag used in BIOM file to store the
                        taxonomy bootstraps. ex: rdp_bootstrap
  --identity-tag IDENTITY_TAG
                        The metadata tag used in BIOM file to store the
                        alignment identity. ex: perc_identity
  --coverage-tag COVERAGE_TAG
                        The metadata tag used in BIOM file to store the
                        alignment observation coverage. ex:
                        perc_query_coverage

Inputs:
  --input-biom INPUT_BIOM
                        The input abundance file (format: BIOM).

Outputs:
  --html HTML           The HTML file containing the graphs. [Default:
                        affiliation_report.html]
  --log-file LOG_FILE   The list of commands executed. [Default: stdout]
```

## frogs_biom_to_stdBiom

### Tool Description
The detailed FROGS blast affiliations can trigger problem with tools like Qiime. This script extracts the problematic metadata in a second file and writes a BIOM usable in every tool using BIOM.

### Metadata
- **Docker Image**: quay.io/biocontainers/frogs:5.1.0--h9ee0642_0
- **Homepage**: https://github.com/geraldinepascal/FROGS
- **Package**: https://anaconda.org/channels/bioconda/packages/frogs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: biom_to_stdBiom.py [-h] [--version] --input-biom INPUT_BIOM
                          [--output-biom OUTPUT_BIOM]
                          [--output-metadata OUTPUT_METADATA]
                          [--log-file LOG_FILE]

The detailed FROGS blast affiliations can trigger problem with tools like
Qiime. This script extracts the problematic metadata in a second file and
writes a BIOM usable in every tool using BIOM.

optional arguments:
  -h, --help            show this help message and exit
  --version             show program's version number and exit

Inputs:
  --input-biom INPUT_BIOM
                        The abundance file (format: BIOM).

Outputs:
  --output-biom OUTPUT_BIOM
                        The fully compatible abundance file (format: BIOM).
                        [Default: abundance.std.biom]
  --output-metadata OUTPUT_METADATA
                        The blast affiliations informations (format: TSV).
                        [Default: blast_informations.std.tsv]
  --log-file LOG_FILE   This output file will contain several information on
                        executed commands. [Default: stdout]
```

## frogs_biom_to_tsv

### Tool Description
Converts a BIOM file in TSV file.

### Metadata
- **Docker Image**: quay.io/biocontainers/frogs:5.1.0--h9ee0642_0
- **Homepage**: https://github.com/geraldinepascal/FROGS
- **Package**: https://anaconda.org/channels/bioconda/packages/frogs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: biom_to_tsv.py [-h] [--version] [--header] --input-biom INPUT_BIOM
                      [--input-fasta INPUT_FASTA] [--output-tsv OUTPUT_TSV]
                      [--output-multi-affi OUTPUT_MULTI_AFFI]
                      [--log-file LOG_FILE]

Converts a BIOM file in TSV file.

optional arguments:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  --header              Print header only

Inputs:
  --input-biom INPUT_BIOM
                        The abundance file (format: BIOM).
  --input-fasta INPUT_FASTA
                        The sequences file (format: FASTA). If you use this
                        option the sequences will be add in TSV.

Outputs:
  --output-tsv OUTPUT_TSV
                        This output file will contain the abundance and
                        metadata (format: TSV). [Default: abundance.tsv]
  --output-multi-affi OUTPUT_MULTI_AFFI
                        This output file will contain information about
                        multiple alignements (format: TSV). Use this option
                        only if your affiliation has been produced by FROGS.
                        [Default: multihits.tsv]
  --log-file LOG_FILE   This output file will contain several informations on
                        executed commands. [Default: stdout]
```

## frogs_cluster_asv_report

### Tool Description
Process several metrics on abundance from BIOM file.

### Metadata
- **Docker Image**: quay.io/biocontainers/frogs:5.1.0--h9ee0642_0
- **Homepage**: https://github.com/geraldinepascal/FROGS
- **Package**: https://anaconda.org/channels/bioconda/packages/frogs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: cluster_asv_report.py [-h] [--version] [--debug]
                             [--hierarchical-clustering]
                             [--distance-method {euclidean,cityblock,seuclidean,sqeuclidean,cosine,correlation,hamming,jaccard,chebyshev,canberra,braycurtis,mahalanobis,yule,matching,dice,kulsinski,rogerstanimoto,russellrao,sokalmichener,sokalsneath,wminkowski}]
                             [--linkage-method {single,complete,average,weighted,centroid,median,ward}]
                             --input-biom INPUT_BIOM [--html HTML]
                             [--log-file LOG_FILE]

Process several metrics on abundance from BIOM file.

optional arguments:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  --debug               Keep temporary files to debug program.
  --hierarchical-clustering
                        Perform Hierarchical classification on observation
                        proportions. [Default: False]
  --distance-method {euclidean,cityblock,seuclidean,sqeuclidean,cosine,correlation,hamming,jaccard,chebyshev,canberra,braycurtis,mahalanobis,yule,matching,dice,kulsinski,rogerstanimoto,russellrao,sokalmichener,sokalsneath,wminkowski}
                        Used distance method for classify (see http://docs.sci
                        py.org/doc/scipy-0.14.0/reference/generated/generated/
                        scipy.spatial.distance.pdist.html#scipy.spatial.distan
                        ce.pdist). [Default: braycurtis]
  --linkage-method {single,complete,average,weighted,centroid,median,ward}
                        Used linkage method for classify (see http://docs.scip
                        y.org/doc/scipy-0.14.0/reference/generated/scipy.clust
                        er.hierarchy.linkage.html). [Default: average]

Inputs:
  --input-biom INPUT_BIOM
                        The BIOM file to process.

Outputs:
  --html HTML           The HTML file containing the graphs. [Default:
                        cluster_asv_report.html]
  --log-file LOG_FILE   This output file will contain several informations on
                        executed commands. [Default: stdout]
```

## frogs_cluster_filters

### Tool Description
Filters an abundance file

### Metadata
- **Docker Image**: quay.io/biocontainers/frogs:5.1.0--h9ee0642_0
- **Homepage**: https://github.com/geraldinepascal/FROGS
- **Package**: https://anaconda.org/channels/bioconda/packages/frogs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: cluster_filters.py [-h] [--version] [--debug] [--nb-cpus NB_CPUS]
                          [--nb-biggest-clusters NB_BIGGEST_CLUSTERS]
                          [--min-sample-presence MIN_SAMPLE_PRESENCE]
                          [--min-replicate-presence MIN_REPLICATE_PRESENCE]
                          [--min-abundance MIN_ABUNDANCE] --input-biom
                          INPUT_BIOM --input-fasta INPUT_FASTA
                          [--contaminant CONTAMINANT]
                          [--replicate-tsv REPLICATE_TSV]
                          [--output-biom OUTPUT_BIOM]
                          [--output-fasta OUTPUT_FASTA] [--html HTML]
                          [--excluded EXCLUDED] [--log-file LOG_FILE]

Filters an abundance file

optional arguments:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  --debug               Keep temporary files to debug program. [Default:
                        False]
  --nb-cpus NB_CPUS     The maximum number of CPUs used. [Default: 1]

Filters:
  --nb-biggest-clusters NB_BIGGEST_CLUSTERS
                        Number of most abundant clusters you want to keep,
                        after all others filters applied.
  --min-sample-presence MIN_SAMPLE_PRESENCE
                        Keep cluster present in at least this number of
                        samples.
  --min-replicate-presence MIN_REPLICATE_PRESENCE
                        Keep cluster present in at least this proportion of
                        replicates in at least one group (please indicate a
                        proportion between 0 and 1). Replicates must be
                        defined with --replicate_file REPLICATE FILE
  --min-abundance MIN_ABUNDANCE
                        Minimum percentage/number of sequences, comparing to
                        the total number of sequences, of a cluster (between 0
                        and 1 if percentage desired).

Inputs:
  --input-biom INPUT_BIOM
                        The input BIOM file. (format: BIOM)
  --input-fasta INPUT_FASTA
                        The input FASTA file. (format: FASTA)
  --contaminant CONTAMINANT
                        Use this databank to filter sequence before
                        affiliation. (format: FASTA)
  --replicate-tsv REPLICATE_TSV
                        Sample replicate tsv file must be specified if --min-
                        replicate-presence is set. First column indicates the
                        sample name, and the second column the group name.

Outputs:
  --output-biom OUTPUT_BIOM
                        The BIOM file output. (format: BIOM) [Default:
                        cluster_filters_abundance.biom]
  --output-fasta OUTPUT_FASTA
                        The FASTA output file. (format: FASTA) [Default:
                        cluster_filters.fasta]
  --html HTML           The HTML file containing the graphs. [Default:
                        cluster_filters.html]
  --excluded EXCLUDED   The TSV file that summarizes all the discarded
                        clusters. (format: TSV) [Default:
                        cluster_filters_excluded.tsv]
  --log-file LOG_FILE   This output file will contain several information on
                        executed commands. [Default: stdout]
```

## frogs_clustering

### Tool Description
Single-linkage clustering on sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/frogs:5.1.0--h9ee0642_0
- **Homepage**: https://github.com/geraldinepascal/FROGS
- **Package**: https://anaconda.org/channels/bioconda/packages/frogs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: clustering.py [-h] [--nb-cpus NB_CPUS] [--debug] [--version]
                     [--distance DISTANCE] [--fastidious] [--denoising]
                     --input-fasta INPUT_FASTA --input-count INPUT_COUNT
                     [--output-biom OUTPUT_BIOM] [--output-fasta OUTPUT_FASTA]
                     [--output-compo OUTPUT_COMPO] [--log-file LOG_FILE]

Single-linkage clustering on sequences.

optional arguments:
  -h, --help            show this help message and exit
  --nb-cpus NB_CPUS     The maximum number of CPUs used. [Default: 1]
  --debug               Keep temporary files to debug program.
  --version             show program's version number and exit

Recommended options:
  --distance DISTANCE   Maximum distance between sequences in each aggregation
                        step. RECOMMENDED : d=1 in combination with
                        --fastidious option [Default: 1]
  --fastidious          use the fastidious option of swarm to refine ASV.
                        RECOMMENDED in combination with a distance equal to 1
                        (-d). it is only usable with d=1 and mutually
                        exclusive with --denoising.

other clustering option:
  --denoising           denoise data by clustering read with distance=1 before
                        perform real clustering. It is mutually exclusive with
                        --fastidious.

Inputs:
  --input-fasta INPUT_FASTA
                        The sequences file (format: FASTA).
  --input-count INPUT_COUNT
                        The count file for 'fasta-file' (format: TSV). It
                        contains the count by sample for each sequence.

Outputs:
  --output-biom OUTPUT_BIOM
                        This output file will contain the abondance by sample
                        for each cluster (format: BIOM). [Default:
                        clustering_abundance.biom]
  --output-fasta OUTPUT_FASTA
                        This output file will contain the seed sequence for
                        each cluster (format: FASTA). [Default:
                        clustering_seeds.fasta]
  --output-compo OUTPUT_COMPO
                        This output file will contain the composition of each
                        cluster (format: TSV). One Line is a cluster ; each
                        column is a sequence ID. [Default:
                        clustering_swarms_composition.tsv]
  --log-file LOG_FILE   This output file will contain several information on
                        executed commands.
```

## frogs_demultiplex

### Tool Description
Divide the reads into samples based on their internal barcode.

### Metadata
- **Docker Image**: quay.io/biocontainers/frogs:5.1.0--h9ee0642_0
- **Homepage**: https://github.com/geraldinepascal/FROGS
- **Package**: https://anaconda.org/channels/bioconda/packages/frogs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: demultiplex.py [-h] [--version] [--debug] [--mismatches MISMATCHES]
                      [--end END] --input-R1 INPUT_R1 [--input-R2 INPUT_R2]
                      [--input-barcode INPUT_BARCODE]
                      [--output-demultiplexed OUTPUT_DEMULTIPLEXED]
                      [--output-undemultiplexed OUTPUT_UNDEMULTIPLEXED]
                      [--summary SUMMARY] [--log-file LOG_FILE]

Divide the reads into samples based on their internal barcode.

optional arguments:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  --debug               Keep temporary files to debug program. [Default:
                        False]
  --mismatches MISMATCHES
                        Number of mismatches allowed in barcode. [Default: 0]
  --end END             barcode is at the begining of the forward end (bol) or
                        of the reverse (eol) or both (both). [Default: bol]

Inputs:
  --input-R1 INPUT_R1   The R1 sequence file with all samples (format: fastq).
  --input-R2 INPUT_R2   The R2 sequence file with all samples (format: fastq).
  --input-barcode INPUT_BARCODE
                        This file describes barcodes and samples (one line by
                        sample). Line format : SAMPLE_NAME<TAB>BARCODE or
                        SAMPLE_NAME<TAB>BARCODE_FW<TAB>BARCODE_RV.

Outputs:
  --output-demultiplexed OUTPUT_DEMULTIPLEXED
                        The tar file containing R1 files and R2 files for each
                        sample (format: tar). [Default:
                        demultiplexed_read.tar.gz]
  --output-undemultiplexed OUTPUT_UNDEMULTIPLEXED
                        The tar file containing R1 files and R2 files not
                        demultiplexed (format: tar). [Default:
                        undemultiplexed_read.tar.gz]
  --summary SUMMARY     TSV file with summary of filters results (format:
                        TSV). [Default: demultiplex_summary.tsv]
  --log-file LOG_FILE   This output file will contain several informations on
                        executed commands. [Default: stdout]
```

## frogs_deseq2_preprocess

### Tool Description
Launch Rscript to generate dataframe of DESEq2 from a phyloseq object in RData file

### Metadata
- **Docker Image**: quay.io/biocontainers/frogs:5.1.0--h9ee0642_0
- **Homepage**: https://github.com/geraldinepascal/FROGS
- **Package**: https://anaconda.org/channels/bioconda/packages/frogs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: deseq2_preprocess.py [-h] [--version] [--debug] --var-exp VAR_EXP
                            --analysis-type {ASV,FUNCTION}
                            [--phyloseq-rdata PHYLOSEQ_RDATA]
                            [--input-functions-abund INPUT_FUNCTIONS_ABUND]
                            [--sample-metadata-tsv SAMPLE_METADATA_TSV]
                            [--output-phyloseq-rdata OUTPUT_PHYLOSEQ_RDATA]
                            [--output-deseq-rdata OUTPUT_DESEQ_RDATA]
                            [--log-file LOG_FILE]

Launch Rscript to generate dataframe of DESEq2 from a phyloseq object in RData
file

optional arguments:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  --debug               Keep temporary files to debug program.
  --var-exp VAR_EXP     Experimental variable suspected to have an impact on
                        abundances. You may precise complexe string such as
                        variables with confounding effect (ex:
                        Treatment+Gender or Treatmet*Gender)
  --analysis-type {ASV,FUNCTION}
                        Differential analysis on ASV (see phyloseq_import.py)
                        or on Function abundance (see frogsfunc_functions.py).

# Inputs for ASV analysis type :
  --phyloseq-rdata PHYLOSEQ_RDATA
                        The path of RData file containing a phyloseq object-
                        the result of phyloseq_import.py. Required.

# Inputs for FUNCTION analysis type :
  --input-functions-abund INPUT_FUNCTIONS_ABUND
                        Input file of metagenome function prediction
                        abundances (frogsfunc_functions_unstrat.tsv from
                        frogsfunc_functions.py). Required.
  --sample-metadata-tsv SAMPLE_METADATA_TSV
                        path to sample file (format: TSV). Required.

# Outputs:
  --output-deseq-rdata OUTPUT_DESEQ_RDATA
                        The path to store resulting dataframe of DESeq2.
                        [Default: None]
  --log-file LOG_FILE   This output file will contain several information on
                        executed commands. [Default: stdout]

  ## Outputs specific of FUNCTION analysis type :
  --output-phyloseq-rdata OUTPUT_PHYLOSEQ_RDATA
                        Rdata file path to store phyloseq-class object based
                        on functions abundances and annotation. [Default:
                        phyloseq_fun.Rdata]
```

## frogs_deseq2_visualisation

### Tool Description
Launch Rmarkdown to visualise differential abundance analysis.

### Metadata
- **Docker Image**: quay.io/biocontainers/frogs:5.1.0--h9ee0642_0
- **Homepage**: https://github.com/geraldinepascal/FROGS
- **Package**: https://anaconda.org/channels/bioconda/packages/frogs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: deseq2_visualisation.py [-h] [--version] [--debug] --var-exp VAR_EXP
                               [--mod1 MOD1] [--mod2 MOD2] [--padj PADJ]
                               --analysis-type {ASV,FUNCTION} --phyloseq-rdata
                               PHYLOSEQ_RDATA --deseq-rdata DESEQ_RDATA
                               [--output-ipath-over OUTPUT_IPATH_OVER]
                               [--output-ipath-under OUTPUT_IPATH_UNDER]
                               [--html HTML] [--log-file LOG_FILE]

Launch Rmarkdown to visualise differential abundance analysis.

optional arguments:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  --debug               Keep temporary files to debug program.
  --var-exp VAR_EXP     variable that you want to test.
  --mod1 MOD1           one value of the tested variable you want to compare
                        (if more than 2 value in your experiement variable
                        analyzed.) [Default: None]
  --mod2 MOD2           second value of the tested variable you want to
                        compare.(if more than 2 value in your experiement
                        variable analyzed.) [Default: None]
  --padj PADJ           the adjusted p-value threshold to defined ASV as
                        differentially abundant. [Default: 0.05]
  --analysis-type {ASV,FUNCTION}
                        Type of data to perform the differential analysis.
                        ASV: DESeq2 is run on the ASVs abundances table. FUNC:
                        DESeq2 is run on FROGSFUNC function abundances table
                        (frogsfunc_functions_unstrat.tsv from FROGSFUNC
                        function step). [Default: ASV]

# Inputs:
  --phyloseq-rdata PHYLOSEQ_RDATA
                        Phyloseq RData file containing the either ASV or
                        FUNCTION abundances (see phyloseq_import.py or
                        deseq2_visualisation.py
  --deseq-rdata DESEQ_RDATA
                        DESeq RData file containing dds object (see
                        deseq_preprocess.py)

# Outputs:
  --html HTML           The HTML file containing the graphs. [Default:
                        DESeq2_visualisation.html]
  --log-file LOG_FILE   This output file will contain several informations on
                        executed commands. [Default: stdout]

  ## Outputs specific of FUNCTION analysis type :
  --output-ipath-over OUTPUT_IPATH_OVER
                        The tsv file of over abundants functions
                        [Default:ipath_over.tsv]
  --output-ipath-under OUTPUT_IPATH_UNDER
                        The tsv file of under abundants functions
                        [Default:ipath_under.tsv]
```

## frogs_frogsfunc_functions

### Tool Description
Per-sample functional profiles prediction.

### Metadata
- **Docker Image**: quay.io/biocontainers/frogs:5.1.0--h9ee0642_0
- **Homepage**: https://github.com/geraldinepascal/FROGS
- **Package**: https://anaconda.org/channels/bioconda/packages/frogs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: frogsfunc_functions.py [-h] [--version] [--debug] [--nb-cpus NB_CPUS]
                              [--strat-contrib] --input-biom INPUT_BIOM
                              --input-fasta INPUT_FASTA --input-tree
                              INPUT_TREE --input-marker-copy INPUT_MARKER_COPY
                              --marker-type {16S,ITS,18S}
                              [--functions {EC,KO,COG,PFAM,TIGRFAM,PHENO} [{EC,KO,COG,PFAM,TIGRFAM,PHENO} ...]]
                              [--input-function-table INPUT_FUNCTION_TABLE]
                              [--hsp-method {mp,emp_prob,pic,scp,subtree_average}]
                              [--max-nsti MAX_NSTI]
                              [--min-blast-ident MIN_BLAST_IDENT]
                              [--min-blast-cov MIN_BLAST_COV]
                              [--min-reads INT] [--min-samples INT]
                              [--prefix-function-abund PREFIX_FUNCTION_ABUND]
                              [--prefix-contrib PREFIX_CONTRIB]
                              [--output-asv-copy-norm OUTPUT_ASV_COPY_NORM]
                              [--output-weighted-nsti OUTPUT_WEIGHTED_NSTI]
                              [--output-biom OUTPUT_BIOM]
                              [--output-fasta OUTPUT_FASTA]
                              [--output-excluded OUTPUT_EXCLUDED]
                              [--log-file LOG_FILE] [--html HTML]

Per-sample functional profiles prediction.

optional arguments:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  --debug               Keep temporary files to debug program. [Default:
                        False]
  --nb-cpus NB_CPUS     The maximum number of CPUs used. [Default: 1]
  --strat-contrib       If activated, a new table is built:contribution of
                        each ASV in each sample in each function abundances.
                        [Default: False]

Inputs:
  --input-biom INPUT_BIOM
                        frogsfunc_placeseqs Biom output file
                        (frogsfunc_placeseqs.biom).
  --input-fasta INPUT_FASTA
                        frogsfunc_placeseqs Fasta output file
                        (frogsfunc_placeseqs.fasta).
  --input-tree INPUT_TREE
                        frogsfunc_placeseqs output tree in newick format
                        containing both studied sequences (i.e. ASVs) and
                        reference sequences.
  --input-marker-copy INPUT_MARKER_COPY
                        Table of predicted marker gene copy numbers
                        (frogsfunc_placeseqs output :
                        frogsfunc_marker_copy_per_asv.tsv).
  --marker-type {16S,ITS,18S}
                        Marker gene to be analyzed.
  --hsp-method {mp,emp_prob,pic,scp,subtree_average}
                        HSP method to use. mp: predict discrete traits using
                        max parsimony. emp_prob: predict discrete traits based
                        on empirical state probabilities across tips.
                        subtree_average: predict continuous traits using
                        subtree averaging. pic: predict continuous traits with
                        phylogentic independent contrast. scp: reconstruct
                        continuous traits using squared-change parsimony
                        [Default: mp].
  --max-nsti MAX_NSTI   Sequences with NSTI values above this value will be
                        excluded [Default: 2.0].
  --min-blast-ident MIN_BLAST_IDENT
                        Sequences with blast percentage identity against the
                        PICRUSt2 closest ref above this value will be excluded
                        (between 0 and 1). [Default: None]
  --min-blast-cov MIN_BLAST_COV
                        Sequences with blast percentage coverage against the
                        PICRUSt2 closest ref above this value will be excluded
                        (between 0 and 1). [Default: None]
  --min-reads INT       Minimum number of reads across all samples for each
                        input ASV. ASVs below this cut-off will be counted as
                        part of the "RARE" category in the stratified output.
                        If you choose 1, none ASV will be grouped in “RARE”
                        category. [Default: 1].
  --min-samples INT     Minimum number of samples that an ASV needs to be
                        identfied within. ASVs below this cut-off will be
                        counted as part of the "RARE" category in the
                        stratified output. If you choose 1, none ASV will be
                        grouped in “RARE” category. [Default: 1].

16S :
  --functions {EC,KO,COG,PFAM,TIGRFAM,PHENO} [{EC,KO,COG,PFAM,TIGRFAM,PHENO} ...]
                        Specifies which function databases should be used. EC
                        is used by default because it is necessary for
                        frogsfunc_pathways. At least EC or KO is
                        required.[Default: ['EC']]

ITS and 18S :
  --input-function-table INPUT_FUNCTION_TABLE
                        The path to input functions table describing directly
                        observed functions, in tab-delimited format.(ex $PICRU
                        St2_PATH/default_files/fungi/ec_ITS_counts.txt.gz).

Outputs:
  --prefix-function-abund PREFIX_FUNCTION_ABUND
                        prefix for function abundances table and function copy
                        numbers(TSV format). [Default: unstrat_abundance].
  --prefix-contrib PREFIX_CONTRIB
                        prefix for stratified ASV contribution in function
                        abundances. Warning this output is memory intensive
                        and so only generated if --stat-out is used [Default:
                        strat_contrib_and_abundance]
  --output-asv-copy-norm OUTPUT_ASV_COPY_NORM
                        Output file with asv abundances normalized by marker
                        copies number. [Default:
                        frogsfunc_functions_asv_ccopy_norm_abundance.tsv]
  --output-weighted-nsti OUTPUT_WEIGHTED_NSTI
                        Output file with the mean of nsti value per sample
                        (format: TSV). [Default:
                        frogsfunc_functions_weighted_nsti.tsv]
  --output-biom OUTPUT_BIOM
                        Biom file of kept ASVs (NSTI, blast perc identity or
                        blast perc coverage thresholds). (format: BIOM)
                        [Default: frogsfunc_function_asv_abundance.biom]
  --output-fasta OUTPUT_FASTA
                        Fasta file of kept ASVs (NSTI, blast perc identity or
                        blast perc coverage thresholds). (format: FASTA).
                        [Default: frogsfunc_function_asv.fasta]
  --output-excluded OUTPUT_EXCLUDED
                        List of ASVs with NSTI values above NSTI threshold (
                        --max_NSTI NSTI ).[Default:
                        frogsfunc_functions_asv_excluded.txt]
  --log-file LOG_FILE   List of commands executed. [Default: stdout]
  --html HTML           Path to store resulting html file. [Default:
                        frogsfunc_functions_summary.html]
```

## frogs_frogsfunc_pathways

### Tool Description
Infer the presence and abundances of pathways based on gene family abundances in a sample.

### Metadata
- **Docker Image**: quay.io/biocontainers/frogs:5.1.0--h9ee0642_0
- **Homepage**: https://github.com/geraldinepascal/FROGS
- **Package**: https://anaconda.org/channels/bioconda/packages/frogs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: frogsfunc_pathways.py [-h] [--version] [--debug] [--nb-cpus NB_CPUS]
                             [--strat-contrib]
                             [--hierarchy-ranks [HIERARCHY_RANKS [HIERARCHY_RANKS ...]]]
                             [--normalisation] --input-tsv INPUT_TSV
                             [--map MAP]
                             [--input-asv-copy-norm INPUT_ASV_COPY_NORM]
                             [--input-fun-copy INPUT_FUN_COPY]
                             [--output-pathways-contrib OUTPUT_PATHWAYS_CONTRIB]
                             [--output-pathways-predictions OUTPUT_PATHWAYS_PREDICTIONS]
                             [--output-pathways-abund-per-seq OUTPUT_PATHWAYS_ABUND_PER_SEQ]
                             [--output-pathways-abund OUTPUT_PATHWAYS_ABUND]
                             [--log-file LOG_FILE] [--html HTML]

Infer the presence and abundances of pathways based on gene family abundances
in a sample.

optional arguments:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  --debug               Keep temporary files to debug program. [Default:
                        False]
  --nb-cpus NB_CPUS     The maximum number of CPUs used. [Default: 1]
  --strat-contrib       If stratified option is activated, a new table is
                        built. It will contain the abundances of each function
                        of each ASV in each sample. (in contrast to the
                        default stratified output, which is the contribution
                        to the community-wide pathway abundances.) Options
                        --input-asv-copy-norm and --input-fun-copy need to be
                        set when this option is used. [Default: False]
  --hierarchy-ranks [HIERARCHY_RANKS [HIERARCHY_RANKS ...]]
                        The ordered annotation pathways ranks. [Default:
                        ['Level1', 'Level2', 'Level3', 'Pathway']]
  --normalisation       To normalise pathway abundances. Values are divided by
                        sum of columns, then multiplied by 10^6 (CPM values).
                        [Default: False]

Inputs:
  --input-tsv INPUT_TSV
                        Input TSV function abundances table from
                        FROGSFUNC_function (unstratified table :
                        unstrat_abundance_EC.tsv or unstrat_abundance_KO.tsv).
  --map MAP             File required if you are not analyzing 16S sequences
                        with the Metacyc ("EC" function in the previous step)
                        database. IF MARKER STUDYED STILL 16S: it must
                        indicate the path to the PICRUSt2 KEGG pathways
                        mapfile, if you chose "KO" in the previous step (the
                        mapfile is available here : $PICRUSt2_PATH/default_fil
                        es/pathway_mapfiles/KEGG_pathways_to_KO.tsv) IF MARKER
                        STUDYED IS ITS OR 18S: Path to mapping file of
                        pathways to fungi reactions (the mapfile is available
                        here : $PICRUSt2_PATH/default_files/pathway_mapfiles/m
                        etacyc_path2rxn_struc_filt_fungi.txt ).
  --input-asv-copy-norm INPUT_ASV_COPY_NORM
                        ASV abunndances normalized by marker copy number
                        (frogsfunc_functions --output-asv-copy-norm option:
                        frogsfunc_functions_asv_copy_norm_abundance.tsv by
                        default). This input is required when the --strat-
                        contrib option is set. [Default: None]
  --input-fun-copy INPUT_FUN_COPY
                        Function copy number per ASV
                        ([FUN]_copynumbers_predicted.tsv output from
                        frogsfunc_functions.py)). This input is required when
                        the --strat-contrib option is set. [Default: None]

Outputs if --strat-contrib option is set:
  --output-pathways-contrib OUTPUT_PATHWAYS_CONTRIB
                        Stratified output corresponding to contribution of
                        predicted gene family abundances within each predicted
                        genome. [Default: None]
  --output-pathways-predictions OUTPUT_PATHWAYS_PREDICTIONS
                        Stratified output corresponding to contribution of
                        predicted gene family abundances within each predicted
                        genome. [Default: None]
  --output-pathways-abund-per-seq OUTPUT_PATHWAYS_ABUND_PER_SEQ
                        Pathway abundance file output per sequences (if
                        --strat-contrib set). [Default: None]

Outputs:
  --output-pathways-abund OUTPUT_PATHWAYS_ABUND
                        Pathway abundance file output. [Default:
                        frogsfunc_pathways_unstrat.tsv]
  --log-file LOG_FILE   This output file will contain several information on
                        executed commands. [Default: stdout]
  --html HTML           Path to store resulting html file. [Default:
                        frogsfunc_pathways_summary.html]
```

## frogs_frogsfunc_placeseqs

### Tool Description
place studies sequences (i.e. ASVs) into a reference tree.

### Metadata
- **Docker Image**: quay.io/biocontainers/frogs:5.1.0--h9ee0642_0
- **Homepage**: https://github.com/geraldinepascal/FROGS
- **Package**: https://anaconda.org/channels/bioconda/packages/frogs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: frogsfunc_placeseqs.py [-h] [--version] [--debug] [--nb-cpus NB_CPUS]
                              [--placement-tool {epa-ng,sepp}]
                              [--min-align MIN_ALIGN]
                              [--hsp-method {mp,emp_prob,pic,scp,subtree_average}]
                              --input-fasta INPUT_FASTA --input-biom
                              INPUT_BIOM [--ref-dir REF_DIR]
                              [--input-marker-table INPUT_MARKER_TABLE]
                              [--output-tree OUTPUT_TREE]
                              [--excluded EXCLUDED]
                              [--output-fasta OUTPUT_FASTA]
                              [--output-biom OUTPUT_BIOM]
                              [--closests-ref CLOSESTS_REF] [--html HTML]
                              [--output-marker-copy OUTPUT_MARKER_COPY]
                              [--log-file LOG_FILE]

place studies sequences (i.e. ASVs) into a reference tree.

optional arguments:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  --debug               Keep temporary files to debug program. [Default:
                        False]
  --nb-cpus NB_CPUS     The maximum number of CPUs used. [Default: 1]
  --placement-tool {epa-ng,sepp}
                        Tool to place sequences into reference tree. Note that
                        epa-ng is more sensitiv but very memory and computing
                        power intensive. Warning : sepp is not usable for ITS
                        and 18S analysis [Default: epa-ng]
  --min-align MIN_ALIGN
                        Proportion of the total length of an input query
                        sequence that must align with reference sequences. Any
                        sequences with lengths below this value after making
                        an alignment with reference sequences will be excluded
                        from the placement and all subsequent steps. [Default:
                        0.8].
  --hsp-method {mp,emp_prob,pic,scp,subtree_average}
                        HSP method to use. mp: predict discrete traits using
                        max parsimony. emp_prob: predict discrete traits based
                        on empirical state probabilities across tips.
                        subtree_average: predict continuous traits using
                        subtree averaging. pic: predict continuous traits with
                        phylogentic independent contrast. scp: reconstruct
                        continuous traits using squared-change parsimony
                        [Default: mp].

Inputs:
  --input-fasta INPUT_FASTA
                        Input fasta file of unaligned studies sequences.
  --input-biom INPUT_BIOM
                        Input biom file of unaligned studies sequences.
  --ref-dir REF_DIR     If marker studied is not 16S, the directory containing
                        reference sequence files (for ITS, see:
                        $PICRUST2_PATH/default_files/fungi/fungi_ITS
  --input-marker-table INPUT_MARKER_TABLE
                        If marker studied is not 16S, the marker table
                        describing copy number by genome assembly. (ex:
                        $PICRUSt2_PATH/default_files/fungi/ITS_counts.txt.gz).

Outputs:
  --output-tree OUTPUT_TREE
                        Reference and ASV phylogentic tree (format: newick).
                        [Default: frogsfunc_placeseqs_tree.nwk]
  --excluded EXCLUDED   Excluded ASV list. [Default:
                        frogsfunc_placeseqs_asv_excluded.txt]
  --output-fasta OUTPUT_FASTA
                        Kept ASV sequence file. (format: FASTA). [Default:
                        frogsfunc_placeseqs.fasta]
  --output-biom OUTPUT_BIOM
                        Kept ASV abundance file. (format: BIOM) [Default:
                        frogsfunc_placeseqs.biom]
  --closests-ref CLOSESTS_REF
                        Informations about Clusters (i.e ASVs) and PICRUSt2
                        closest reference from cluster sequences
                        (identifiants, taxonomies, phylogenetic distance from
                        reference, nucleotidics sequences). [Default:
                        frogsfunc_placeseqs_closests_ref_sequences.txt]
  --html HTML           HTML report. [Default:
                        frogsfunc_placeseqs_summary.html]
  --output-marker-copy OUTPUT_MARKER_COPY
                        Predicted marker gene copy numbers per kept ASV. If
                        the extension ".gz" is added the table will
                        automatically be gzipped. [Default:
                        frogsfunc_marker_copy_per_asv.tsv]
  --log-file LOG_FILE   List of commands executed. [Default: stdout]
```

## frogs_normalisation

### Tool Description
Normalisation in BIOM by random sampling.

### Metadata
- **Docker Image**: quay.io/biocontainers/frogs:5.1.0--h9ee0642_0
- **Homepage**: https://github.com/geraldinepascal/FROGS
- **Package**: https://anaconda.org/channels/bioconda/packages/frogs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: normalisation.py [-h] [--version] [--debug] [--num-reads NUM_READS]
                        [--sampling-by-min] [--delete-samples] --input-biom
                        INPUT_BIOM --input-fasta INPUT_FASTA
                        [--output-biom OUTPUT_BIOM]
                        [--output-fasta OUTPUT_FASTA] [--html HTML]
                        [--log-file LOG_FILE]

Normalisation in BIOM by random sampling.

optional arguments:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  --debug               Keep temporary files to debug program. [Default:
                        False]
  --num-reads NUM_READS
                        Number of sampled sequences by sample.
  --sampling-by-min     Sampling by the number of sequences of the smallest
                        sample. [Default: False]
  --delete-samples      Delete samples that have a number of sequences below
                        the selected filter. [Default: False]

Inputs:
  --input-biom INPUT_BIOM
                        Abundances file to normalise (format: BIOM).
  --input-fasta INPUT_FASTA
                        Sequences file to normalise (format: FASTA).

Outputs:
  --output-biom OUTPUT_BIOM
                        Normalised abundances (format: BIOM). [Default:
                        normalisation_abundance.biom]
  --output-fasta OUTPUT_FASTA
                        Normalised sequences (format: FASTA). [Default:
                        normalisation.fasta]
  --html HTML           The HTML file containing the graphs. [Default:
                        normalisation.html]
  --log-file LOG_FILE   The list of commands executed. [Default: stdout]
```

## frogs_phyloseq_alpha_diversity

### Tool Description
To compute and present the data alpha diversity with plot_richness of Phyloseq.

### Metadata
- **Docker Image**: quay.io/biocontainers/frogs:5.1.0--h9ee0642_0
- **Homepage**: https://github.com/geraldinepascal/FROGS
- **Package**: https://anaconda.org/channels/bioconda/packages/frogs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyloseq_alpha_diversity.py [-h] [--version] [--debug] --var-exp
                                   VAR_EXP
                                   [--alpha-measures [ALPHA_MEASURES [ALPHA_MEASURES ...]]]
                                   --phyloseq-rdata PHYLOSEQ_RDATA
                                   [--html HTML]
                                   [--output-alpha-tsv OUTPUT_ALPHA_TSV]
                                   [--log-file LOG_FILE]

To compute and present the data alpha diversity with plot_richness of
Phyloseq.

optional arguments:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  --debug               Keep temporary files to debug program. [Default:
                        False]
  --var-exp VAR_EXP     The experiment variable used to aggregate sample
                        diversities. [Default: None]
  --alpha-measures [ALPHA_MEASURES [ALPHA_MEASURES ...]]
                        The indices of alpha diversity. Available indices :
                        Observed, Chao1, Shannon, InvSimpson, Simpson, ACE,
                        Fisher. [Default: ['Observed', 'Chao1', 'Shannon',
                        'InvSimpson']]

Inputs:
  --phyloseq-rdata PHYLOSEQ_RDATA
                        The path of RData file containing a phyloseq object-
                        the result of phyloseq_import.py. [Default: None]

Outputs:
  --html HTML           The HTML file containing the graphs. [Default:
                        phyloseq_alpha_diversity.nb.html]
  --output-alpha-tsv OUTPUT_ALPHA_TSV
                        The path to store resulting data file containing alpha
                        diversity table. [Default:
                        phyloseq_alpha_diversity.tsv]
  --log-file LOG_FILE   This output file will contain several informations on
                        executed commands. [Default: stdout]
```

## frogs_phyloseq_beta_diversity

### Tool Description
To present the data beta diversity with phyloseq.

### Metadata
- **Docker Image**: quay.io/biocontainers/frogs:5.1.0--h9ee0642_0
- **Homepage**: https://github.com/geraldinepascal/FROGS
- **Package**: https://anaconda.org/channels/bioconda/packages/frogs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyloseq_beta_diversity.py [-h] [--version] [--debug] --var-exp VAR_EXP
                                  --beta-distance-methods
                                  BETA_DISTANCE_METHODS
                                  [BETA_DISTANCE_METHODS ...] --phyloseq-rdata
                                  PHYLOSEQ_RDATA --matrix-outdir MATRIX_OUTDIR
                                  [--html HTML] [--log-file LOG_FILE]

To present the data beta diversity with phyloseq.

optional arguments:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  --debug               Keep temporary files to debug program. [Default:
                        False]
  --var-exp VAR_EXP     The experiment variable you want to analyse. [Default:
                        None]
  --beta-distance-methods BETA_DISTANCE_METHODS [BETA_DISTANCE_METHODS ...]
                        Beta diversity methods to use (list available in
                        Phyloseq manual, see https://www.bioconductor.org/pack
                        ages/devel/bioc/manuals/phyloseq/man/phyloseq.pdf).
                        [Default: ['bray', 'cc', 'unifrac', 'wunifrac']].

Inputs:
  --phyloseq-rdata PHYLOSEQ_RDATA
                        The path of RData file containing a phyloseq object-
                        the result of phyloseq_import.py. [Default: None]

Outputs:
  --matrix-outdir MATRIX_OUTDIR
                        Path to output matrix file
  --html HTML           The HTML file containing the graphs. [Default:
                        phyloseq_beta_diversity.nb.html]
  --log-file LOG_FILE   This output file will contain several informations on
                        executed commands. [Default: stdout]
```

## frogs_phyloseq_clustering

### Tool Description
Clustering of samples using different linkage method.

### Metadata
- **Docker Image**: quay.io/biocontainers/frogs:5.1.0--h9ee0642_0
- **Homepage**: https://github.com/geraldinepascal/FROGS
- **Package**: https://anaconda.org/channels/bioconda/packages/frogs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyloseq_clustering.py [-h] [--version] [--debug] --var-exp VAR_EXP
                              --phyloseq-rdata PHYLOSEQ_RDATA
                              --beta-distance-matrix BETA_DISTANCE_MATRIX
                              [--html HTML] [--log-file LOG_FILE]

Clustering of samples using different linkage method.

optional arguments:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  --debug               Keep temporary files to debug program. [Default:
                        False]
  --var-exp VAR_EXP     The experiment variable you want to analyse. [Default:
                        None]

Inputs:
  --phyloseq-rdata PHYLOSEQ_RDATA
                        The path of RData file containing a phyloseq object-
                        the result of phyloseq_import.py. [Default: None]
  --beta-distance-matrix BETA_DISTANCE_MATRIX
                        The path of data file containing beta diversity
                        distance matrix. These file is the result of FROGS
                        Phyloseq Beta Diversity. [Default: None]

Outputs:
  --html HTML           The HTML file containing the graphs. [Default:
                        phyloseq_clustering.nb.html]
  --log-file LOG_FILE   This output file will contain several informations on
                        executed commands. [Default: stdout]
```

## frogs_phyloseq_composition

### Tool Description
Present the composition of data with package phyloseq

### Metadata
- **Docker Image**: quay.io/biocontainers/frogs:5.1.0--h9ee0642_0
- **Homepage**: https://github.com/geraldinepascal/FROGS
- **Package**: https://anaconda.org/channels/bioconda/packages/frogs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyloseq_composition.py [-h] [--version] [--debug] --var-exp VAR_EXP
                               --taxa-rank-1 TAXA_RANK_1 --taxa-set-1
                               [TAXA_SET_1 [TAXA_SET_1 ...]] --taxa-rank-2
                               TAXA_RANK_2 --number-of-taxa NUMBER_OF_TAXA
                               --phyloseq-rdata PHYLOSEQ_RDATA [--html HTML]
                               [--log-file LOG_FILE]

Present the composition of data with package phyloseq

optional arguments:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  --debug               Keep temporary files to debug program. [Default:
                        False]
  --var-exp VAR_EXP     The experiment variable used to split plot.
  --taxa-rank-1 TAXA_RANK_1
                        Select taxonomic rank name to subset your data. [ex:
                        Kingdom]
  --taxa-set-1 [TAXA_SET_1 [TAXA_SET_1 ...]]
                        Select taxon name among taxaRank1 to subset your data.
                        [ex: Bacteria]
  --taxa-rank-2 TAXA_RANK_2
                        Select sub taxonomic rank name to aggregate your data.
                        [ex: Phylum]"
  --number-of-taxa NUMBER_OF_TAXA
                        The number of the most abundant taxa to keep at
                        taxaRank2. [ex: 9]"

Inputs:
  --phyloseq-rdata PHYLOSEQ_RDATA
                        The path of RData file containing a phyloseq object-
                        the result of phyloseq_import.py. [Default: None]

Outputs:
  --html HTML           The HTML file containing the graphs. [Default:
                        phyloseq_composition.nb.html]
  --log-file LOG_FILE   This output file will contain several information on
                        executed commands. [Default: stdout]
```

## frogs_phyloseq_import_data

### Tool Description
Launch Rmardown script to import data from 3 files: biomfile, samplefile, treefile into a phyloseq object

### Metadata
- **Docker Image**: quay.io/biocontainers/frogs:5.1.0--h9ee0642_0
- **Homepage**: https://github.com/geraldinepascal/FROGS
- **Package**: https://anaconda.org/channels/bioconda/packages/frogs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyloseq_import_data.py [-h] [--version] [--debug] [--normalisation]
                               [--ranks [RANKS [RANKS ...]]] --input-biom
                               INPUT_BIOM --sample-metadata-tsv
                               SAMPLE_METADATA_TSV [--tree-nwk TREE_NWK]
                               [--output-phyloseq-rdata OUTPUT_PHYLOSEQ_RDATA]
                               [--html HTML] [--log-file LOG_FILE]

Launch Rmardown script to import data from 3 files: biomfile, samplefile,
treefile into a phyloseq object

optional arguments:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  --debug               Keep temporary files to debug program. [Default:
                        False]
  --normalisation       To normalise data before analysis. Use this option if
                        you didnt do it in FROGS Abundance normalisation.
                        [Default: False]
  --ranks [RANKS [RANKS ...]]
                        The ordered taxonomic ranks levels stored in BIOM.
                        Each rank is separated by one space. [Default:
                        ['Kingdom', 'Phylum', 'Class', 'Order', 'Family',
                        'Genus', 'Species']]

Inputs:
  --input-biom INPUT_BIOM
                        path to the abundance BIOM file.
  --sample-metadata-tsv SAMPLE_METADATA_TSV
                        path to sample file (format: TSV).
  --tree-nwk TREE_NWK   path to tree file from FROGS Tree (format: Newick
                        "nhx" or "nwk" ).

Outputs:
  --output-phyloseq-rdata OUTPUT_PHYLOSEQ_RDATA
                        path to store phyloseq-class object in Rdata file.
                        [Default: phyloseq_asv.Rdata]
  --html HTML           The HTML file containing the graphs. [Default:
                        phyloseq_import_summary.nb.html]
  --log-file LOG_FILE   This output file will contain several informations on
                        executed commands. [Default: stdout]
```

## frogs_phyloseq_manova

### Tool Description
Multivariate Analysis of Variance (MANOVA) test with CAP (Canonical Analysis of Principal Coordinates) by adonis.

### Metadata
- **Docker Image**: quay.io/biocontainers/frogs:5.1.0--h9ee0642_0
- **Homepage**: https://github.com/geraldinepascal/FROGS
- **Package**: https://anaconda.org/channels/bioconda/packages/frogs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyloseq_manova.py [-h] [--version] [--debug] --var-exp VAR_EXP
                          --phyloseq-rdata PHYLOSEQ_RDATA
                          --beta-distance-matrix BETA_DISTANCE_MATRIX
                          [--html HTML] [--log-file LOG_FILE]

Multivariate Analysis of Variance (MANOVA) test with CAP (Canonical Analysis
of Principal Coordinates) by adonis.

optional arguments:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  --debug               Keep temporary files to debug program. [Default:
                        False]
  --var-exp VAR_EXP     The experiment variable you want to analyse. [Default:
                        None]

Inputs:
  --phyloseq-rdata PHYLOSEQ_RDATA
                        The path of RData file containing a phyloseq object-
                        the result of phyloseq_import.py. [Default: None]
  --beta-distance-matrix BETA_DISTANCE_MATRIX
                        The path of data file containing beta diversity
                        distance matrix. These file is the result of FROGS
                        Phyloseq Beta Diversity. [Default: None]

Outputs:
  --html HTML           The HTML file containing the graphs. [Default:
                        phyloseq_manova.nb.html]
  --log-file LOG_FILE   This output file will contain several informations on
                        executed commands. [Default: stdout]
```

## frogs_phyloseq_structure

### Tool Description
Visulization of data structure with heatmap plot and ordination plot of Phyloseq.

### Metadata
- **Docker Image**: quay.io/biocontainers/frogs:5.1.0--h9ee0642_0
- **Homepage**: https://github.com/geraldinepascal/FROGS
- **Package**: https://anaconda.org/channels/bioconda/packages/frogs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyloseq_structure.py [-h] [--version] [--debug] --var-exp VAR_EXP
                             [--ordination-method {MDS,NMDS,DPCoA,PCoA}]
                             --phyloseq-rdata PHYLOSEQ_RDATA
                             --beta-distance-matrix BETA_DISTANCE_MATRIX
                             [--html HTML] [--log-file LOG_FILE]

Visulization of data structure with heatmap plot and ordination plot of
Phyloseq.

optional arguments:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  --debug               Keep temporary files to debug program. [Default:
                        False]
  --var-exp VAR_EXP     The experiment variable you want to analyse. [Default:
                        None]
  --ordination-method {MDS,NMDS,DPCoA,PCoA}
                        The ordination methods. [Default: MDS]

Inputs:
  --phyloseq-rdata PHYLOSEQ_RDATA
                        The path of RData file containing a phyloseq object-
                        the result of phyloseq_import.py. [Default: None]
  --beta-distance-matrix BETA_DISTANCE_MATRIX
                        Path of data file containing beta diversity distance
                        matrix. These file is the result of FROGS Phyloseq
                        Beta Diversity. [Default: None]

Outputs:
  --html HTML           The HTML file containing the graphs. [Default:
                        phyloseq_structure.nb.html]
  --log-file LOG_FILE   This output file will contain several informations on
                        executed commands. [Default: stdout]
```

## frogs_reads_processing

### Tool Description
Pre-process reads and denoise or cluster them. Run as reads_processing.py <illumina|longreads|454> [options].

### Metadata
- **Docker Image**: quay.io/biocontainers/frogs:5.1.0--h9ee0642_0
- **Homepage**: https://github.com/geraldinepascal/FROGS
- **Package**: https://anaconda.org/channels/bioconda/packages/frogs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: reads_processing.py [-h] [--version] {illumina,longreads,454} ...

Pre-process reads and denoise or cluster them.

positional arguments:
  {illumina,longreads,454}
    illumina            Illumina sequencers.
    longreads           longreads sequencers (dada2 process is however not
                        compatible with ONT data)
    454                 454 sequencers.

optional arguments:
  -h, --help            show this help message and exit
  --version             show program's version number and exit

### reads_processing.py illumina --help
usage: 
  For samples archive:
    reads_processing.py illumina
      [--nb-cpus NB_CPUS] [--debug] [--version]
      --input-archive ARCHIVE_FILE
        # if single-end ou already-contiged
        --already-contiged
        # else
        --R1-size R1_SIZE --R2-size R2_SIZE
        [--merge-software {vsearch,flash,pear}] [--quality-scale SCALE ] [--expected-amplicon-size] [--keep-unmerged]
      # primers
      --without-primers | --five-prim-primer FIVE_PRIM_PRIMER --three-prim-primer THREE_PRIM_PRIMER [--mismatch-rate RATE ]
      # filter
      --min-amplicon-size MIN_AMPLICON_SIZE --max-amplicon-size MAX_AMPLICON_SIZE
      # clustering or denoising
      [--process {swarm, dada2, preprocess-only}]
        # if swarm
        [--pre-clustering] [--distance DISTANCE] [--fastidious] 
        # if dada2
        [--sample-inference {pseudo-pooling, independent, pooling}]
      # outputs
      [--output-biom BIOM_FILE] [--output-fasta FASTA_FILE]
        # if swarm
        [--output-compo OUTPUT_COMPO]
      [--html SUMMARY_FILE] [--log-file LOG_FILE]

      
  For samples files:
      reads_processing.py illumina
      [--nb-cpus NB_CPUS] [--debug] [--version]
      --input-R1 R1_FILE [R1_FILE ...]
      --samples-names SAMPLE_NAME [SAMPLE_NAME ...]
        # if single-end ou already-contiged
        --already-contiged
        # else
        --input-R2 R2_FILE [R2_FILE ...]
        --R1-size R1_SIZE --R2-size R2_SIZE
        [--merge-software {vsearch,flash,pear}] [--quality-scale SCALE ] [--expected-amplicon-size] [--keep-unmerged]
      # primers
      --without-primers | --five-prim-primer FIVE_PRIM_PRIMER --three-prim-primer THREE_PRIM_PRIMER [--mismatch-rate RATE ]
      # filter
      --min-amplicon-size MIN_AMPLICON_SIZE --max-amplicon-size MAX_AMPLICON_SIZE
      # clustering or denoising
      [--process {swarm, dada2, preprocess-only}]
        # if swarm
        [--pre-clustering] [--distance DISTANCE] [--fastidious] 
        # if dada2
        [--sample-inference {pseudo-pooling, independent, pooling}]
      # outputs
      [--output-biom BIOM_FILE] [--output-fasta FASTA_FILE]
        # if swarm
        [--output-compo OUTPUT_COMPO]
      [--html SUMMARY_FILE] [--log-file LOG_FILE]

optional arguments:
  -h, --help            show this help message and exit
  --nb-cpus NB_CPUS     The maximum number of CPUs used. [Default: 1]
  --debug               Keep temporary files to debug program. [Default:
                        False]
  --R1-size R1_SIZE     The read1 size.
  --R2-size R2_SIZE     The read2 size.
  --already-contiged    The archive contains 1 file by sample : Reads 1 and
                        Reads 2 are already contiged by pair. [Default: False]
  --merge-software {vsearch,flash,pear}
                        Software used to merge paired reads
  --quality-scale {33,64}
                        The phred base quality scale, either 33 or 64 if using
                        Vsearch as read pair merge software [Default: 33]
  --expected-amplicon-size EXPECTED_AMPLICON_SIZE
                        The expected size for the majority of the amplicons
                        (with primers), if using Flash as read pair merge
                        software.
  --keep-unmerged       In case of uncontiged paired reads, keep unmerged, and
                        artificially combined them with 100 Ns. [Default:
                        False]
  --five-prim-primer FIVE_PRIM_PRIMER
                        The 5' primer sequence (wildcards are accepted).
  --three-prim-primer THREE_PRIM_PRIMER
                        The 3' primer sequence (wildcards are accepted).
  --without-primers     Use this option when you use custom sequencing primers
                        and these primers are the PCR primers. In this case
                        the reads do not contain the PCR primers. [Default:
                        False]
  --mismatch-rate MISMATCH_RATE
                        Maximum mismatch rate in overlap region. [Default:
                        0.1; must be expressed as decimal, between 0 and 1]
  --min-amplicon-size MIN_AMPLICON_SIZE
                        The minimum size for the amplicons (with primers).
  --max-amplicon-size MAX_AMPLICON_SIZE
                        The maximum size for the amplicons (with primers).

Clustering or Denoising option:
  --process {swarm,dada2,preprocess-only}
                        Choose between performing only dereplication and using
                        swarm or dada2 to build ASVs [Default: swarm]

Clustering options:
  --pre-clustering      denoise data by clustering read with distance=1 before
                        perform real clustering. It is mutually exclusive with
                        --fastidious. [Default: False]
  --distance DISTANCE   Maximum distance between sequences in each aggregation
                        step. RECOMMENDED : d=1 in combination with
                        --fastidious option [Default: 1]
  --fastidious          use the fastidious option of swarm to refine cluster.
                        RECOMMENDED in combination with a distance equal to 1
                        (-d). it is only usable with d=1 and mutually
                        exclusive with --pre-clustering. [Default: False]

Clustering output:
  --output-compo OUTPUT_COMPO
                        This output file will contain the composition of each
                        cluster (format: TSV). One Line is a cluster ; each
                        column is a sequence ID. [Default:
                        clustering_swarms_composition.tsv]

Denoising options:
  --sample-inference {pseudo-pooling,independent,pooling}
                        Independent, pseudo-pooling of full pooling for dada2
                        samples processing. [Default: pseudo-pooling]

Inputs:
  --samples-names SAMPLES_NAMES [SAMPLES_NAMES ...]
                        The sample name for each R1/R2-files.
  --input-archive INPUT_ARCHIVE
                        The tar file containing R1 file and R2 file for each
                        sample.
  --input-R1 INPUT_R1 [INPUT_R1 ...]
                        The R1 sequence file for each sample (format: fastq).
  --input-R2 INPUT_R2 [INPUT_R2 ...]
                        The R2 sequence file for each sample (format: fastq).

Outputs:
  --output-biom OUTPUT_BIOM
                        This output file will contain the abundance by sample
                        for each cluster or ASV (format: BIOM). [Default:
                        reads_processing_abundance.biom]
  --output-fasta OUTPUT_FASTA
                        This output file will contain the sequence for each
                        cluster or ASV (format: FASTA). [Default:
                        sequences.fasta]
  --html HTML           The HTML file containing the graphs. [Default:
                        reads_processing.html]
  --log-file LOG_FILE   This output file will contain several information on
                        executed commands.

### reads_processing.py longreads --help
usage: 
    reads_processing.py longreads
    --input-archive ARCHIVE_FILE | --input-R1 R1_FILE [R1_FILE ...]
    --min-amplicon-size MIN_AMPLICON_SIZE
    --max-amplicon-size MAX_AMPLICON_SIZE
    [--process {swarm, dada2, preprocess-only}]
    [--pre-clustering] [--distance DISTANCE] [--fastidious] | [--sample-inference {pseudo-pooling, independent, pooling}]
    --without-primers | --five-prim-primer FIVE_PRIM_PRIMER --three-prim-primer THREE_PRIM_PRIMER
    [--nb-cpus NB_CPUS] [--debug] [--version]
    [--process PROCESS]
    [--output-biom BIOM_FILE] [--output-fasta FASTA_FILE]
    [--html SUMMARY_FILE] [--log-file LOG_FILE]

optional arguments:
  -h, --help            show this help message and exit
  --process {swarm,preprocess-only,dada2}
                        Choose between performing only dereplication and using
                        swarm or dada2 to build ASVs [Default: swarm]
  --min-amplicon-size MIN_AMPLICON_SIZE
                        The minimum size for the amplicons (with primers).
  --max-amplicon-size MAX_AMPLICON_SIZE
                        The maximum size for the amplicons (with primers).
  --five-prim-primer FIVE_PRIM_PRIMER
                        The 5' primer sequence (wildcards are accepted).
  --three-prim-primer THREE_PRIM_PRIMER
                        The 3' primer sequence (wildcards are accepted).
  --without-primers     Use this option when you use custom sequencing primers
                        and these primers are the PCR primers. In this case
                        the reads do not contain the PCR primers. [Default:
                        False]
  --nb-cpus NB_CPUS     The maximum number of CPUs used. [Default: 1]
  --debug               Keep temporary files to debug program. [Default:
                        False]

Inputs:
  --input-archive INPUT_ARCHIVE
                        The tar file containing R1 file and R2 file for each
                        sample (format: tar).
  --samples-names SAMPLES_NAMES [SAMPLES_NAMES ...]
                        The sample name for each R1/R2-files.
  --input-R1 INPUT_R1 [INPUT_R1 ...]
                        The R1 sequence file for each sample (format: fastq).
                        Required for single-ends OR paired-ends data.

Clustering options:
  --pre-clustering      denoise data by clustering read with distance=1 before
                        perform real clustering. It is mutually exclusive with
                        --fastidious. [Default: False]
  --distance DISTANCE   Maximum distance between sequences in each aggregation
                        step. RECOMMENDED : d=1 in combination with
                        --fastidious option [Default: 1]
  --fastidious          use the fastidious option of swarm to refine cluster.
                        RECOMMENDED in combination with a distance equal to 1
                        (-d). it is only usable with d=1 and mutually
                        exclusive with --pre-clustering. [Default: False]
  --output-compo OUTPUT_COMPO
                        This output file will contain the composition of each
                        cluster (format: TSV). One Line is a cluster ; each
                        column is a sequence ID. [Default:
                        clustering_swarms_composition.tsv]

Denoising options:
  --sample-inference {pseudo-pooling,independent,pooling}
                        Independent, pseudo-pooling of full pooling for dada2
                        samples processing. [Default: pseudo-pooling]

Outputs:
  --html HTML           The HTML file containing the graphs. [Default:
                        reads_processing.html]
  --log-file LOG_FILE   This output file will contain several information on
                        executed commands.
  --output-biom OUTPUT_BIOM
                        This output file will contain the abundance by sample
                        for each cluster or ASV (format: BIOM). [Default:
                        reads_processing_abundance.biom]
  --output-fasta OUTPUT_FASTA
                        This output file will contain the sequence for each
                        cluster or ASV (format: FASTA). [Default:
                        sequences.fasta]

### reads_processing.py 454 --help
usage: 
  reads_processing.py 454
    --input-archive ARCHIVE_FILE | --input-R1 R1_FILE [R1_FILE ...]
    --min-amplicon-size MIN_AMPLICON_SIZE
    --max-amplicon-size MAX_AMPLICON_SIZE
    --five-prim-primer FIVE_PRIM_PRIMER
    --three-prim-primer THREE_PRIM_PRIMER
    [--process PROCESS]
    [--nb-cpus NB_CPUS] [--debug] [--version]
    [--output-biom BIOM_FILE] [--output-fasta FASTA_FILE]
    [--html SUMMARY_FILE] [--log-file LOG_FILE]

optional arguments:
  -h, --help            show this help message and exit
  --min-amplicon-size MIN_AMPLICON_SIZE
                        The minimum size for the amplicons (with primers).
  --max-amplicon-size MAX_AMPLICON_SIZE
                        The maximum size for the amplicons (with primers).
  --five-prim-primer FIVE_PRIM_PRIMER
                        The 5' primer sequence (wildcards are accepted).
  --three-prim-primer THREE_PRIM_PRIMER
                        The 3' primer sequence (wildcards are accepted).
  --process {swarm,preprocess-only}
                        Choose between performing only dereplication and using
                        swarm to build ASVs [Default: swarm]
  --nb-cpus NB_CPUS     The maximum number of CPUs used. [Default: 1]
  --debug               Keep temporary files to debug program. [Default:
                        False]

Inputs:
  --samples-names SAMPLES_NAMES [SAMPLES_NAMES ...]
                        The sample name for each R1/R2-files.
  --input-archive INPUT_ARCHIVE
                        The tar file containing R1 file and R2 file for each
                        sample (format: tar).
  --input-R1 INPUT_R1 [INPUT_R1 ...]
                        The sequence file for each sample (format: fastq).

Clustering options:
  --pre-clustering      denoise data by clustering read with distance=1 before
                        perform real clustering. It is mutually exclusive with
                        --fastidious. [Default: False]
  --distance DISTANCE   Maximum distance between sequences in each aggregation
                        step. RECOMMENDED : d=1 in combination with
                        --fastidious option [Default: 1]
  --fastidious          use the fastidious option of swarm to refine cluster.
                        RECOMMENDED in combination with a distance equal to 1
                        (-d). it is only usable with d=1 and mutually
                        exclusive with --pre-clustering. [Default: False]
  --output-compo OUTPUT_COMPO
                        This output file will contain the composition of each
                        cluster (format: TSV). One Line is a cluster ; each
                        column is a sequence ID. [Default:
                        clustering_swarms_composition.tsv]

Outputs:
  --output-biom OUTPUT_BIOM
                        This output file will contain the abundance by sample
                        for each cluster or ASV (format: BIOM). [Default:
                        abundance.biom]
  --output-fasta OUTPUT_FASTA
                        This output file will contain the sequence for each
                        cluster or ASV (format: FASTA). [Default:
                        sequences.fasta]
  --html HTML           The HTML file containing the graphs. [Default:
                        reads_processing.html]
  --log-file LOG_FILE   This output file will contain several information on
                        executed commands.
```

## frogs_remove_chimera

### Tool Description
Removes PCR chimera.

### Metadata
- **Docker Image**: quay.io/biocontainers/frogs:5.1.0--h9ee0642_0
- **Homepage**: https://github.com/geraldinepascal/FROGS
- **Package**: https://anaconda.org/channels/bioconda/packages/frogs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: remove_chimera.py [-h] [--version] [--debug] [--nb-cpus NB_CPUS]
                         [--long-reads] --input-fasta INPUT_FASTA --input-biom
                         INPUT_BIOM [--output-fasta OUTPUT_FASTA]
                         [--output-biom OUTPUT_BIOM] [--html HTML]
                         [--log-file LOG_FILE]

Removes PCR chimera.

optional arguments:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  --debug               Keep temporary files to debug program. [Default:
                        False]
  --nb-cpus NB_CPUS     The maximum number of CPUs used. [Default: 1]
  --long-reads          If original sequences were long reads, use
                        chimera_denovo algorithm to detect chimera, else, i.e
                        for short reads, use uchime_denovo [Default: False]

Inputs:
  --input-fasta INPUT_FASTA
                        The cluster sequences (format: FASTA).
  --input-biom INPUT_BIOM
                        The abundance file for clusters by sample (format:
                        BIOM).

Outputs:
  --output-fasta OUTPUT_FASTA
                        sequences file without chimera (format: FASTA).
                        [Default: remove_chimera.fasta]
  --output-biom OUTPUT_BIOM
                        Abundance file without chimera (format: BIOM).
                        [Default: remove_chimera_abundance.biom]
  --html HTML           The HTML file containing the graphs. [Default:
                        remove_chimera.html]
  --log-file LOG_FILE   This output file will contain several informations on
                        executed commands. [Default: stdout]
```

## frogs_taxonomic_affiliation

### Tool Description
Taxonomic affiliation of each ASV's seed by RDPtools and BLAST.

### Metadata
- **Docker Image**: quay.io/biocontainers/frogs:5.1.0--h9ee0642_0
- **Homepage**: https://github.com/geraldinepascal/FROGS
- **Package**: https://anaconda.org/channels/bioconda/packages/frogs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: taxonomic_affiliation.py [-h] [--version] [--debug] [--nb-cpus NB_CPUS]
                                [--java-mem JAVA_MEM]
                                [--taxonomy-ranks [TAXONOMY_RANKS [TAXONOMY_RANKS ...]]]
                                [--rdp]
                                [--taxonomy-tag TAXONOMY_TAG | --tax-consensus-tag TAX_CONSENSUS_TAG]
                                [--multiple-tag MULTIPLE_TAG]
                                [--bootstrap-tag BOOTSTRAP_TAG]
                                [--identity-tag IDENTITY_TAG]
                                [--coverage-tag COVERAGE_TAG] --reference
                                REFERENCE --input-biom INPUT_BIOM
                                --input-fasta INPUT_FASTA
                                [--output-biom OUTPUT_BIOM] [--html HTML]
                                [--log-file LOG_FILE]

Taxonomic affiliation of each ASV's seed by RDPtools and BLAST.

optional arguments:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  --debug               Keep temporary files to debug program. [Default:
                        False]
  --nb-cpus NB_CPUS     The maximum number of CPUs used. [Default: 1]
  --java-mem JAVA_MEM   Java memory allocation in Go. [Default: 2]
  --taxonomy-ranks [TAXONOMY_RANKS [TAXONOMY_RANKS ...]]
                        The ordered ranks levels present in the reference
                        databank. [Default: ['Domain', 'Phylum', 'Class',
                        'Order', 'Family', 'Genus', 'Species']]
  --rdp                 Use RDP classifier to affiliate ASV [Default: False]
  --taxonomy-tag TAXONOMY_TAG
                        The metadata tag used in BIOM file to store the
                        taxonomy. Use this parameter if the taxonomic
                        affiliation has been processed by a software that adds
                        only one affiliation or if you does not have a
                        metadata with the consensus taxonomy (see "--tax-
                        consensus-tag").Not allowed with --tax-consensus-tag.
                        [Default: None]
  --tax-consensus-tag TAX_CONSENSUS_TAG
                        The metadata tag used in BIOM file to store the
                        consensus taxonomy. This parameter is used instead of
                        "--taxonomy-tag" when you have several affiliations
                        for each ASV. [Default: blast_taxonomy]
  --multiple-tag MULTIPLE_TAG
                        The metadata tag used in BIOM file to store the list
                        of possible taxonomies. Use this parameter if the
                        taxonomic affiliation has been processed by a software
                        that adds several affiliation in the BIOM file
                        (example: same score ambiguity). [Default: None]
  --bootstrap-tag BOOTSTRAP_TAG
                        The metadata tag used in BIOM file to store the
                        taxonomy bootstraps. [Default: None]
  --identity-tag IDENTITY_TAG
                        The metadata tag used in BIOM file to store the
                        alignment identity. [Default: None]
  --coverage-tag COVERAGE_TAG
                        The metadata tag used in BIOM file to store the
                        alignment observation coverage. [Default: None]

Inputs:
  --reference REFERENCE
                        Preformated reference file (format: blast-indexed
                        FASTA).
  --input-biom INPUT_BIOM
                        BIOM file (format: BIOM).
  --input-fasta INPUT_FASTA
                        FASTA file of ASV's seed (format: FASTA).

Outputs:
  --output-biom OUTPUT_BIOM
                        BIOM file with added affiliation annotations from
                        blast/needleall and/or RDPtools. [Default:
                        affiliation_abundance.biom]
  --html HTML           The HTML file containing the graphs. [Default:
                        taxonomic_affiliation.html]
  --log-file LOG_FILE   The list of commands executed. [Default: stdout]
```

## frogs_tree

### Tool Description
Phylogenetic tree reconstruction

### Metadata
- **Docker Image**: quay.io/biocontainers/frogs:5.1.0--h9ee0642_0
- **Homepage**: https://github.com/geraldinepascal/FROGS
- **Package**: https://anaconda.org/channels/bioconda/packages/frogs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tree.py [-h] [--version] [--debug] [--nb-cpus NB_CPUS] --input-fasta
               INPUT_FASTA --input-biom INPUT_BIOM [--output-tree OUTPUT_TREE]
               [--html HTML] [--log-file LOG_FILE]

Phylogenetic tree reconstruction

optional arguments:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  --debug               Keep temporary files to debug program.
  --nb-cpus NB_CPUS     The maximum number of CPUs used. [Default: 1]

Inputs:
  --input-fasta INPUT_FASTA
                        Path to input FASTA file of ASV seed sequences.
                        Warning: FROGS Tree is only working on less than 10000
                        sequences!
  --input-biom INPUT_BIOM
                        Path to the abundance BIOM file.

Outputs:
  --output-tree OUTPUT_TREE
                        Path to store resulting Newick tree file. (format:
                        nwk) [Default: tree.nwk]
  --html HTML           The HTML file containing the graphs. [Default:
                        tree.html]
  --log-file LOG_FILE   This output file will contain several informations on
                        executed commands. [Default: stdout]
```

## frogs_tsv_to_biom

### Tool Description
Converts a TSV file in BIOM file.

### Metadata
- **Docker Image**: quay.io/biocontainers/frogs:5.1.0--h9ee0642_0
- **Homepage**: https://github.com/geraldinepascal/FROGS
- **Package**: https://anaconda.org/channels/bioconda/packages/frogs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tsv_to_biom.py [-h] [--version] --input-tsv INPUT_TSV
                      [--input-multi-affi INPUT_MULTI_AFFI]
                      [--output-biom OUTPUT_BIOM]
                      [--output-fasta OUTPUT_FASTA] [--log-file LOG_FILE]

Converts a TSV file in BIOM file.

optional arguments:
  -h, --help            show this help message and exit
  --version             show program's version number and exit

Inputs:
  --input-tsv INPUT_TSV
                        This input file contain the abundance and metadata
                        (format: TSV).
  --input-multi-affi INPUT_MULTI_AFFI
                        This input file will contain information about
                        multiple alignements (format: TSV). Use this option
                        only if your affiliation has been produced by FROGS.
                        [Default: None]

Outputs:
  --output-biom OUTPUT_BIOM
                        The output abundance file (format: BIOM). [Default:
                        abundance.biom]
  --output-fasta OUTPUT_FASTA
                        The output sequences file (format: FASTA). If
                        sequences exist in your input TSV with tag
                        seed_sequence. [Default: None]
  --log-file LOG_FILE   This output file will contain several informations on
                        executed commands. [Default: stdout]
```

