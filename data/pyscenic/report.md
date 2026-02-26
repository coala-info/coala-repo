# pyscenic CWL Generation Report

## pyscenic_grn

### Tool Description
Infer gene regulatory networks

### Metadata
- **Docker Image**: quay.io/biocontainers/pyscenic:0.12.1--pyhdfd78af_1
- **Homepage**: https://github.com/aertslab/pySCENIC
- **Package**: https://anaconda.org/channels/bioconda/packages/pyscenic/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pyscenic/overview
- **Total Downloads**: 2.4K
- **Last updated**: 2025-11-14
- **GitHub**: https://github.com/aertslab/pySCENIC
- **Stars**: N/A
### Original Help Text
```text
usage: pyscenic grn [-h] [-o OUTPUT] [-t] [-m {genie3,grnboost2}]
                    [--seed SEED] [--num_workers NUM_WORKERS]
                    [--client_or_address CLIENT_OR_ADDRESS]
                    [--cell_id_attribute CELL_ID_ATTRIBUTE]
                    [--gene_attribute GENE_ATTRIBUTE] [--sparse]
                    expression_mtx_fname tfs_fname

positional arguments:
  expression_mtx_fname  The name of the file that contains the expression
                        matrix for the single cell experiment. Two file
                        formats are supported: csv (rows=cells x
                        columns=genes) or loom (rows=genes x columns=cells).
  tfs_fname             The name of the file that contains the list of
                        transcription factors (TXT; one TF per line).

options:
  -h, --help            show this help message and exit
  -o OUTPUT, --output OUTPUT
                        Output file/stream, i.e. a table of TF-target genes
                        (CSV).
  -t, --transpose       Transpose the expression matrix (rows=genes x
                        columns=cells).
  -m {genie3,grnboost2}, --method {genie3,grnboost2}
                        The algorithm for gene regulatory network
                        reconstruction (default: grnboost2).
  --seed SEED           Seed value for regressor random state initialization.
                        Applies to both GENIE3 and GRNBoost2. The default is
                        to use a random seed.

computation arguments:
  --num_workers NUM_WORKERS
                        The number of workers to use. Only valid if using
                        dask_multiprocessing, custom_multiprocessing or local
                        as mode. (default: 20).
  --client_or_address CLIENT_OR_ADDRESS
                        The client or the IP address of the dask scheduler to
                        use. (Only required of dask_cluster is selected as
                        mode)

loom file arguments:
  --cell_id_attribute CELL_ID_ATTRIBUTE
                        The name of the column attribute that specifies the
                        identifiers of the cells in the loom file.
  --gene_attribute GENE_ATTRIBUTE
                        The name of the row attribute that specifies the gene
                        symbols in the loom file.
  --sparse              If set, load the expression data as a sparse matrix.
                        Currently applies to the grn inference step only.
```


## pyscenic_add_cor

### Tool Description
Add correlation information to GRN adjacencies.

### Metadata
- **Docker Image**: quay.io/biocontainers/pyscenic:0.12.1--pyhdfd78af_1
- **Homepage**: https://github.com/aertslab/pySCENIC
- **Package**: https://anaconda.org/channels/bioconda/packages/pyscenic/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pyscenic add_cor [-h] [-o OUTPUT] [-t]
                        [--cell_id_attribute CELL_ID_ATTRIBUTE]
                        [--gene_attribute GENE_ATTRIBUTE] [--sparse]
                        [--thresholds THRESHOLDS [THRESHOLDS ...]]
                        [--top_n_targets TOP_N_TARGETS [TOP_N_TARGETS ...]]
                        [--top_n_regulators TOP_N_REGULATORS [TOP_N_REGULATORS ...]]
                        [--min_genes MIN_GENES]
                        [--expression_mtx_fname EXPRESSION_MTX_FNAME]
                        [--mask_dropouts]
                        adjacencies expression_mtx_fname

positional arguments:
  adjacencies           The name of the file that contains the GRN adjacencies
                        (output from the GRN step).
  expression_mtx_fname  The name of the file that contains the expression
                        matrix for the single cell experiment. Two file
                        formats are supported: csv (rows=cells x
                        columns=genes) or loom (rows=genes x columns=cells).

options:
  -h, --help            show this help message and exit
  -o OUTPUT, --output OUTPUT
                        Output file/stream, i.e. the adjacencies table with
                        correlations (csv, tsv).
  -t, --transpose       Transpose the expression matrix (rows=genes x
                        columns=cells).

loom file arguments:
  --cell_id_attribute CELL_ID_ATTRIBUTE
                        The name of the column attribute that specifies the
                        identifiers of the cells in the loom file.
  --gene_attribute GENE_ATTRIBUTE
                        The name of the row attribute that specifies the gene
                        symbols in the loom file.
  --sparse              If set, load the expression data as a sparse matrix.
                        Currently applies to the grn inference step only.

module generation arguments:
  --thresholds THRESHOLDS [THRESHOLDS ...]
                        The first method to create the TF-modules based on the
                        best targets for each transcription factor (default:
                        0.75 0.90).
  --top_n_targets TOP_N_TARGETS [TOP_N_TARGETS ...]
                        The second method is to select the top targets for a
                        given TF. (default: 50)
  --top_n_regulators TOP_N_REGULATORS [TOP_N_REGULATORS ...]
                        The alternative way to create the TF-modules is to
                        select the best regulators for each gene. (default: 5
                        10 50)
  --min_genes MIN_GENES
                        The minimum number of genes in a module (default: 20).
  --expression_mtx_fname EXPRESSION_MTX_FNAME
                        The name of the file that contains the expression
                        matrix for the single cell experiment. Two file
                        formats are supported: csv (rows=cells x
                        columns=genes) or loom (rows=genes x columns=cells).
                        (Only required if modules need to be generated)
  --mask_dropouts       If modules need to be generated, this controls whether
                        cell dropouts (cells in which expression of either TF
                        or target gene is 0) are masked when calculating the
                        correlation between a TF-target pair. This affects
                        which target genes are included in the initial
                        modules, and the final pruned regulon (by default only
                        positive regulons are kept (see --all_modules
                        option)). The default value in pySCENIC 0.9.16 and
                        previous versions was to mask dropouts when
                        calculating the correlation; however, all cells are
                        now kept by default, to match the R version.
```


## pyscenic_ctx

### Tool Description
Enrich motifs in modules and generate regulons.

### Metadata
- **Docker Image**: quay.io/biocontainers/pyscenic:0.12.1--pyhdfd78af_1
- **Homepage**: https://github.com/aertslab/pySCENIC
- **Package**: https://anaconda.org/channels/bioconda/packages/pyscenic/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pyscenic ctx [-h] [-o OUTPUT] [-n] [--chunk_size CHUNK_SIZE]
                    [--mode {custom_multiprocessing,dask_multiprocessing,dask_cluster}]
                    [-a] [-t] [--rank_threshold RANK_THRESHOLD]
                    [--auc_threshold AUC_THRESHOLD]
                    [--nes_threshold NES_THRESHOLD]
                    [--min_orthologous_identity MIN_ORTHOLOGOUS_IDENTITY]
                    [--max_similarity_fdr MAX_SIMILARITY_FDR]
                    --annotations_fname ANNOTATIONS_FNAME
                    [--num_workers NUM_WORKERS]
                    [--client_or_address CLIENT_OR_ADDRESS]
                    [--thresholds THRESHOLDS [THRESHOLDS ...]]
                    [--top_n_targets TOP_N_TARGETS [TOP_N_TARGETS ...]]
                    [--top_n_regulators TOP_N_REGULATORS [TOP_N_REGULATORS ...]]
                    [--min_genes MIN_GENES]
                    [--expression_mtx_fname EXPRESSION_MTX_FNAME]
                    [--mask_dropouts] [--cell_id_attribute CELL_ID_ATTRIBUTE]
                    [--gene_attribute GENE_ATTRIBUTE] [--sparse]
                    module_fname database_fname [database_fname ...]

positional arguments:
  module_fname          The name of the file that contains the signature or
                        the co-expression modules. The following formats are
                        supported: CSV or TSV (adjacencies), YAML, GMT and DAT
                        (modules)
  database_fname        The name(s) of the regulatory feature databases. Two
                        file formats are supported: feather or db (legacy).

options:
  -h, --help            show this help message and exit
  -o OUTPUT, --output OUTPUT
                        Output file/stream, i.e. a table of enriched motifs
                        and target genes (csv, tsv) or collection of regulons
                        (yaml, gmt, dat, json).
  -n, --no_pruning      Do not perform pruning, i.e. find enriched motifs.
  --chunk_size CHUNK_SIZE
                        The size of the module chunks assigned to a node in
                        the dask graph (default: 100).
  --mode {custom_multiprocessing,dask_multiprocessing,dask_cluster}
                        The mode to be used for computing (default:
                        custom_multiprocessing).
  -a, --all_modules     Included positive and negative regulons in the
                        analysis (default: no, i.e. only positive).
  -t, --transpose       Transpose the expression matrix (rows=genes x
                        columns=cells).

motif enrichment arguments:
  --rank_threshold RANK_THRESHOLD
                        The rank threshold used for deriving the target genes
                        of an enriched motif (default: 5000).
  --auc_threshold AUC_THRESHOLD
                        The threshold used for calculating the AUC of a
                        feature as fraction of ranked genes (default: 0.05).
  --nes_threshold NES_THRESHOLD
                        The Normalized Enrichment Score (NES) threshold for
                        finding enriched features (default: 3.0).

motif annotation arguments:
  --min_orthologous_identity MIN_ORTHOLOGOUS_IDENTITY
                        Minimum orthologous identity to use when annotating
                        enriched motifs (default: 0.0).
  --max_similarity_fdr MAX_SIMILARITY_FDR
                        Maximum FDR in motif similarity to use when annotating
                        enriched motifs (default: 0.001).
  --annotations_fname ANNOTATIONS_FNAME
                        The name of the file that contains the motif
                        annotations to use.

computation arguments:
  --num_workers NUM_WORKERS
                        The number of workers to use. Only valid if using
                        dask_multiprocessing, custom_multiprocessing or local
                        as mode. (default: 20).
  --client_or_address CLIENT_OR_ADDRESS
                        The client or the IP address of the dask scheduler to
                        use. (Only required of dask_cluster is selected as
                        mode)

module generation arguments:
  --thresholds THRESHOLDS [THRESHOLDS ...]
                        The first method to create the TF-modules based on the
                        best targets for each transcription factor (default:
                        0.75 0.90).
  --top_n_targets TOP_N_TARGETS [TOP_N_TARGETS ...]
                        The second method is to select the top targets for a
                        given TF. (default: 50)
  --top_n_regulators TOP_N_REGULATORS [TOP_N_REGULATORS ...]
                        The alternative way to create the TF-modules is to
                        select the best regulators for each gene. (default: 5
                        10 50)
  --min_genes MIN_GENES
                        The minimum number of genes in a module (default: 20).
  --expression_mtx_fname EXPRESSION_MTX_FNAME
                        The name of the file that contains the expression
                        matrix for the single cell experiment. Two file
                        formats are supported: csv (rows=cells x
                        columns=genes) or loom (rows=genes x columns=cells).
                        (Only required if modules need to be generated)
  --mask_dropouts       If modules need to be generated, this controls whether
                        cell dropouts (cells in which expression of either TF
                        or target gene is 0) are masked when calculating the
                        correlation between a TF-target pair. This affects
                        which target genes are included in the initial
                        modules, and the final pruned regulon (by default only
                        positive regulons are kept (see --all_modules
                        option)). The default value in pySCENIC 0.9.16 and
                        previous versions was to mask dropouts when
                        calculating the correlation; however, all cells are
                        now kept by default, to match the R version.

loom file arguments:
  --cell_id_attribute CELL_ID_ATTRIBUTE
                        The name of the column attribute that specifies the
                        identifiers of the cells in the loom file.
  --gene_attribute GENE_ATTRIBUTE
                        The name of the row attribute that specifies the gene
                        symbols in the loom file.
  --sparse              If set, load the expression data as a sparse matrix.
                        Currently applies to the grn inference step only.
```


## pyscenic_aucell

### Tool Description
Calculate AUC for each cell and each gene signature.

### Metadata
- **Docker Image**: quay.io/biocontainers/pyscenic:0.12.1--pyhdfd78af_1
- **Homepage**: https://github.com/aertslab/pySCENIC
- **Package**: https://anaconda.org/channels/bioconda/packages/pyscenic/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pyscenic aucell [-h] [-o OUTPUT] [-t] [-w] [--num_workers NUM_WORKERS]
                       [--seed SEED] [--rank_threshold RANK_THRESHOLD]
                       [--auc_threshold AUC_THRESHOLD]
                       [--nes_threshold NES_THRESHOLD]
                       [--cell_id_attribute CELL_ID_ATTRIBUTE]
                       [--gene_attribute GENE_ATTRIBUTE] [--sparse]
                       expression_mtx_fname signatures_fname

positional arguments:
  expression_mtx_fname  The name of the file that contains the expression
                        matrix for the single cell experiment. Two file
                        formats are supported: csv (rows=cells x
                        columns=genes) or loom (rows=genes x columns=cells).
  signatures_fname      The name of the file that contains the gene
                        signatures. Three file formats are supported: gmt,
                        yaml or dat (pickle).

options:
  -h, --help            show this help message and exit
  -o OUTPUT, --output OUTPUT
                        Output file/stream, a matrix of AUC values. Two file
                        formats are supported: csv or loom. If loom file is
                        specified the loom file while contain the original
                        expression matrix and the calculated AUC values as
                        extra column attributes.
  -t, --transpose       Transpose the expression matrix if supplied as csv
                        (rows=genes x columns=cells).
  -w, --weights         Use weights associated with genes in recovery
                        analysis. Is only relevant when gene signatures are
                        supplied as json format.
  --num_workers NUM_WORKERS
                        The number of workers to use (default: 20).
  --seed SEED           Seed for the expression matrix ranking step. The
                        default is to use a random seed.

motif enrichment arguments:
  --rank_threshold RANK_THRESHOLD
                        The rank threshold used for deriving the target genes
                        of an enriched motif (default: 5000).
  --auc_threshold AUC_THRESHOLD
                        The threshold used for calculating the AUC of a
                        feature as fraction of ranked genes (default: 0.05).
  --nes_threshold NES_THRESHOLD
                        The Normalized Enrichment Score (NES) threshold for
                        finding enriched features (default: 3.0).

loom file arguments:
  --cell_id_attribute CELL_ID_ATTRIBUTE
                        The name of the column attribute that specifies the
                        identifiers of the cells in the loom file.
  --gene_attribute GENE_ATTRIBUTE
                        The name of the row attribute that specifies the gene
                        symbols in the loom file.
  --sparse              If set, load the expression data as a sparse matrix.
                        Currently applies to the grn inference step only.
```

