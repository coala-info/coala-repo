# cnmf CWL Generation Report

## cnmf_prepare

### Tool Description
Prepare data for cNMF analysis, including specifying input counts, components, and iterations.

### Metadata
- **Docker Image**: quay.io/biocontainers/cnmf:1.7.0--pyhdfd78af_0
- **Homepage**: https://github.com/dylkot/cNMF
- **Package**: https://anaconda.org/channels/bioconda/packages/cnmf/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cnmf/overview
- **Total Downloads**: 1.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/dylkot/cNMF
- **Stars**: N/A
### Original Help Text
```text
usage: cnmf [-h] [--name [NAME]] [--output-dir [OUTPUT_DIR]] [-c COUNTS]
            [-k COMPONENTS [COMPONENTS ...]] [-n N_ITER]
            [--total-workers TOTAL_WORKERS] [--seed SEED]
            [--genes-file GENES_FILE] [--numgenes NUMGENES] [--tpm TPM]
            [--max-nmf-iter MAX_NMF_ITER]
            [--beta-loss {frobenius,kullback-leibler,itakura-saito}]
            [--init {random,nndsvd}] [--densify] [--worker-index WORKER_INDEX]
            [--skip-completed-runs]
            [--local-density-threshold LOCAL_DENSITY_THRESHOLD]
            [--local-neighborhood-size LOCAL_NEIGHBORHOOD_SIZE]
            [--show-clustering] [--build-reference]
            {prepare,factorize,combine,consensus,k_selection_plot}

positional arguments:
  {prepare,factorize,combine,consensus,k_selection_plot}

optional arguments:
  -h, --help            show this help message and exit
  --name [NAME]         [all] Name for analysis. All output will be placed in
                        [output-dir]/[name]/...
  --output-dir [OUTPUT_DIR]
                        [all] Output directory. All output will be placed in
                        [output-dir]/[name]/...
  -c COUNTS, --counts COUNTS
                        [prepare] Input (cell x gene) counts matrix as .h5ad,
                        .mtx, df.npz, or tab delimited text file
  -k COMPONENTS [COMPONENTS ...], --components COMPONENTS [COMPONENTS ...]
                        [prepare] Numper of components (k) for matrix
                        factorization. Several can be specified with "-k 8 9
                        10"
  -n N_ITER, --n-iter N_ITER
                        [prepare] Number of factorization replicates
  --total-workers TOTAL_WORKERS
                        [all] Total number of workers to distribute jobs to
  --seed SEED           [prepare] Seed for pseudorandom number generation
  --genes-file GENES_FILE
                        [prepare] File containing a list of genes to include,
                        one gene per line. Must match column labels of counts
                        matrix.
  --numgenes NUMGENES   [prepare] Number of high variance genes to use for
                        matrix factorization.
  --tpm TPM             [prepare] Pre-computed (cell x gene) TPM values as
                        df.npz or tab separated txt file. If not provided TPM
                        will be calculated automatically
  --max-nmf-iter MAX_NMF_ITER
                        [prepare] Max number of iterations per individual NMF
                        run (default 1000)
  --beta-loss {frobenius,kullback-leibler,itakura-saito}
                        [prepare] Loss function for NMF (default frobenius)
  --init {random,nndsvd}
                        [prepare] Initialization algorithm for NMF (default
                        random)
  --densify             [prepare] Treat the input data as non-sparse (default
                        False)
  --worker-index WORKER_INDEX
                        [factorize] Index of current worker (the first worker
                        should have index 0)
  --skip-completed-runs
                        [factorize] Skip previously completed runs. Must re-
                        run prepare first to update completed runs
  --local-density-threshold LOCAL_DENSITY_THRESHOLD
                        [consensus] Threshold for the local density filtering.
                        This string must convert to a float >0 and <=2
  --local-neighborhood-size LOCAL_NEIGHBORHOOD_SIZE
                        [consensus] Fraction of the number of replicates to
                        use as nearest neighbors for local density filtering
  --show-clustering     [consensus] Produce a clustergram figure summarizing
                        the spectra clustering
  --build-reference     [consensus] Generates a reference spectra for use in
                        starCAT
```


## cnmf_factorize

### Tool Description
Factorize the counts matrix into gene expression programs using NMF as part of the cNMF pipeline.

### Metadata
- **Docker Image**: quay.io/biocontainers/cnmf:1.7.0--pyhdfd78af_0
- **Homepage**: https://github.com/dylkot/cNMF
- **Package**: https://anaconda.org/channels/bioconda/packages/cnmf/overview
- **Validation**: PASS

### Original Help Text
```text
usage: cnmf [-h] [--name [NAME]] [--output-dir [OUTPUT_DIR]] [-c COUNTS]
            [-k COMPONENTS [COMPONENTS ...]] [-n N_ITER]
            [--total-workers TOTAL_WORKERS] [--seed SEED]
            [--genes-file GENES_FILE] [--numgenes NUMGENES] [--tpm TPM]
            [--max-nmf-iter MAX_NMF_ITER]
            [--beta-loss {frobenius,kullback-leibler,itakura-saito}]
            [--init {random,nndsvd}] [--densify] [--worker-index WORKER_INDEX]
            [--skip-completed-runs]
            [--local-density-threshold LOCAL_DENSITY_THRESHOLD]
            [--local-neighborhood-size LOCAL_NEIGHBORHOOD_SIZE]
            [--show-clustering] [--build-reference]
            {prepare,factorize,combine,consensus,k_selection_plot}

positional arguments:
  {prepare,factorize,combine,consensus,k_selection_plot}

optional arguments:
  -h, --help            show this help message and exit
  --name [NAME]         [all] Name for analysis. All output will be placed in
                        [output-dir]/[name]/...
  --output-dir [OUTPUT_DIR]
                        [all] Output directory. All output will be placed in
                        [output-dir]/[name]/...
  -c COUNTS, --counts COUNTS
                        [prepare] Input (cell x gene) counts matrix as .h5ad,
                        .mtx, df.npz, or tab delimited text file
  -k COMPONENTS [COMPONENTS ...], --components COMPONENTS [COMPONENTS ...]
                        [prepare] Numper of components (k) for matrix
                        factorization. Several can be specified with "-k 8 9
                        10"
  -n N_ITER, --n-iter N_ITER
                        [prepare] Number of factorization replicates
  --total-workers TOTAL_WORKERS
                        [all] Total number of workers to distribute jobs to
  --seed SEED           [prepare] Seed for pseudorandom number generation
  --genes-file GENES_FILE
                        [prepare] File containing a list of genes to include,
                        one gene per line. Must match column labels of counts
                        matrix.
  --numgenes NUMGENES   [prepare] Number of high variance genes to use for
                        matrix factorization.
  --tpm TPM             [prepare] Pre-computed (cell x gene) TPM values as
                        df.npz or tab separated txt file. If not provided TPM
                        will be calculated automatically
  --max-nmf-iter MAX_NMF_ITER
                        [prepare] Max number of iterations per individual NMF
                        run (default 1000)
  --beta-loss {frobenius,kullback-leibler,itakura-saito}
                        [prepare] Loss function for NMF (default frobenius)
  --init {random,nndsvd}
                        [prepare] Initialization algorithm for NMF (default
                        random)
  --densify             [prepare] Treat the input data as non-sparse (default
                        False)
  --worker-index WORKER_INDEX
                        [factorize] Index of current worker (the first worker
                        should have index 0)
  --skip-completed-runs
                        [factorize] Skip previously completed runs. Must re-
                        run prepare first to update completed runs
  --local-density-threshold LOCAL_DENSITY_THRESHOLD
                        [consensus] Threshold for the local density filtering.
                        This string must convert to a float >0 and <=2
  --local-neighborhood-size LOCAL_NEIGHBORHOOD_SIZE
                        [consensus] Fraction of the number of replicates to
                        use as nearest neighbors for local density filtering
  --show-clustering     [consensus] Produce a clustergram figure summarizing
                        the spectra clustering
  --build-reference     [consensus] Generates a reference spectra for use in
                        starCAT
```


## cnmf_combine

### Tool Description
Combine NMF iterations into a single file as part of the cNMF pipeline.

### Metadata
- **Docker Image**: quay.io/biocontainers/cnmf:1.7.0--pyhdfd78af_0
- **Homepage**: https://github.com/dylkot/cNMF
- **Package**: https://anaconda.org/channels/bioconda/packages/cnmf/overview
- **Validation**: PASS

### Original Help Text
```text
usage: cnmf [-h] [--name [NAME]] [--output-dir [OUTPUT_DIR]] [-c COUNTS]
            [-k COMPONENTS [COMPONENTS ...]] [-n N_ITER]
            [--total-workers TOTAL_WORKERS] [--seed SEED]
            [--genes-file GENES_FILE] [--numgenes NUMGENES] [--tpm TPM]
            [--max-nmf-iter MAX_NMF_ITER]
            [--beta-loss {frobenius,kullback-leibler,itakura-saito}]
            [--init {random,nndsvd}] [--densify] [--worker-index WORKER_INDEX]
            [--skip-completed-runs]
            [--local-density-threshold LOCAL_DENSITY_THRESHOLD]
            [--local-neighborhood-size LOCAL_NEIGHBORHOOD_SIZE]
            [--show-clustering] [--build-reference]
            {prepare,factorize,combine,consensus,k_selection_plot}

positional arguments:
  {prepare,factorize,combine,consensus,k_selection_plot}

optional arguments:
  -h, --help            show this help message and exit
  --name [NAME]         [all] Name for analysis. All output will be placed in
                        [output-dir]/[name]/...
  --output-dir [OUTPUT_DIR]
                        [all] Output directory. All output will be placed in
                        [output-dir]/[name]/...
  -c COUNTS, --counts COUNTS
                        [prepare] Input (cell x gene) counts matrix as .h5ad,
                        .mtx, df.npz, or tab delimited text file
  -k COMPONENTS [COMPONENTS ...], --components COMPONENTS [COMPONENTS ...]
                        [prepare] Numper of components (k) for matrix
                        factorization. Several can be specified with "-k 8 9
                        10"
  -n N_ITER, --n-iter N_ITER
                        [prepare] Number of factorization replicates
  --total-workers TOTAL_WORKERS
                        [all] Total number of workers to distribute jobs to
  --seed SEED           [prepare] Seed for pseudorandom number generation
  --genes-file GENES_FILE
                        [prepare] File containing a list of genes to include,
                        one gene per line. Must match column labels of counts
                        matrix.
  --numgenes NUMGENES   [prepare] Number of high variance genes to use for
                        matrix factorization.
  --tpm TPM             [prepare] Pre-computed (cell x gene) TPM values as
                        df.npz or tab separated txt file. If not provided TPM
                        will be calculated automatically
  --max-nmf-iter MAX_NMF_ITER
                        [prepare] Max number of iterations per individual NMF
                        run (default 1000)
  --beta-loss {frobenius,kullback-leibler,itakura-saito}
                        [prepare] Loss function for NMF (default frobenius)
  --init {random,nndsvd}
                        [prepare] Initialization algorithm for NMF (default
                        random)
  --densify             [prepare] Treat the input data as non-sparse (default
                        False)
  --worker-index WORKER_INDEX
                        [factorize] Index of current worker (the first worker
                        should have index 0)
  --skip-completed-runs
                        [factorize] Skip previously completed runs. Must re-
                        run prepare first to update completed runs
  --local-density-threshold LOCAL_DENSITY_THRESHOLD
                        [consensus] Threshold for the local density filtering.
                        This string must convert to a float >0 and <=2
  --local-neighborhood-size LOCAL_NEIGHBORHOOD_SIZE
                        [consensus] Fraction of the number of replicates to
                        use as nearest neighbors for local density filtering
  --show-clustering     [consensus] Produce a clustergram figure summarizing
                        the spectra clustering
  --build-reference     [consensus] Generates a reference spectra for use in
                        starCAT
```


## cnmf_consensus

### Tool Description
Consensus clustering and analysis for cNMF

### Metadata
- **Docker Image**: quay.io/biocontainers/cnmf:1.7.0--pyhdfd78af_0
- **Homepage**: https://github.com/dylkot/cNMF
- **Package**: https://anaconda.org/channels/bioconda/packages/cnmf/overview
- **Validation**: PASS

### Original Help Text
```text
usage: cnmf [-h] [--name [NAME]] [--output-dir [OUTPUT_DIR]] [-c COUNTS]
            [-k COMPONENTS [COMPONENTS ...]] [-n N_ITER]
            [--total-workers TOTAL_WORKERS] [--seed SEED]
            [--genes-file GENES_FILE] [--numgenes NUMGENES] [--tpm TPM]
            [--max-nmf-iter MAX_NMF_ITER]
            [--beta-loss {frobenius,kullback-leibler,itakura-saito}]
            [--init {random,nndsvd}] [--densify] [--worker-index WORKER_INDEX]
            [--skip-completed-runs]
            [--local-density-threshold LOCAL_DENSITY_THRESHOLD]
            [--local-neighborhood-size LOCAL_NEIGHBORHOOD_SIZE]
            [--show-clustering] [--build-reference]
            {prepare,factorize,combine,consensus,k_selection_plot}

positional arguments:
  {prepare,factorize,combine,consensus,k_selection_plot}

optional arguments:
  -h, --help            show this help message and exit
  --name [NAME]         [all] Name for analysis. All output will be placed in
                        [output-dir]/[name]/...
  --output-dir [OUTPUT_DIR]
                        [all] Output directory. All output will be placed in
                        [output-dir]/[name]/...
  -c COUNTS, --counts COUNTS
                        [prepare] Input (cell x gene) counts matrix as .h5ad,
                        .mtx, df.npz, or tab delimited text file
  -k COMPONENTS [COMPONENTS ...], --components COMPONENTS [COMPONENTS ...]
                        [prepare] Numper of components (k) for matrix
                        factorization. Several can be specified with "-k 8 9
                        10"
  -n N_ITER, --n-iter N_ITER
                        [prepare] Number of factorization replicates
  --total-workers TOTAL_WORKERS
                        [all] Total number of workers to distribute jobs to
  --seed SEED           [prepare] Seed for pseudorandom number generation
  --genes-file GENES_FILE
                        [prepare] File containing a list of genes to include,
                        one gene per line. Must match column labels of counts
                        matrix.
  --numgenes NUMGENES   [prepare] Number of high variance genes to use for
                        matrix factorization.
  --tpm TPM             [prepare] Pre-computed (cell x gene) TPM values as
                        df.npz or tab separated txt file. If not provided TPM
                        will be calculated automatically
  --max-nmf-iter MAX_NMF_ITER
                        [prepare] Max number of iterations per individual NMF
                        run (default 1000)
  --beta-loss {frobenius,kullback-leibler,itakura-saito}
                        [prepare] Loss function for NMF (default frobenius)
  --init {random,nndsvd}
                        [prepare] Initialization algorithm for NMF (default
                        random)
  --densify             [prepare] Treat the input data as non-sparse (default
                        False)
  --worker-index WORKER_INDEX
                        [factorize] Index of current worker (the first worker
                        should have index 0)
  --skip-completed-runs
                        [factorize] Skip previously completed runs. Must re-
                        run prepare first to update completed runs
  --local-density-threshold LOCAL_DENSITY_THRESHOLD
                        [consensus] Threshold for the local density filtering.
                        This string must convert to a float >0 and <=2
  --local-neighborhood-size LOCAL_NEIGHBORHOOD_SIZE
                        [consensus] Fraction of the number of replicates to
                        use as nearest neighbors for local density filtering
  --show-clustering     [consensus] Produce a clustergram figure summarizing
                        the spectra clustering
  --build-reference     [consensus] Generates a reference spectra for use in
                        starCAT
```


## cnmf_k_selection_plot

### Tool Description
Generate k-selection plots for cNMF analysis to help determine the optimal number of components.

### Metadata
- **Docker Image**: quay.io/biocontainers/cnmf:1.7.0--pyhdfd78af_0
- **Homepage**: https://github.com/dylkot/cNMF
- **Package**: https://anaconda.org/channels/bioconda/packages/cnmf/overview
- **Validation**: PASS

### Original Help Text
```text
usage: cnmf [-h] [--name [NAME]] [--output-dir [OUTPUT_DIR]] [-c COUNTS]
            [-k COMPONENTS [COMPONENTS ...]] [-n N_ITER]
            [--total-workers TOTAL_WORKERS] [--seed SEED]
            [--genes-file GENES_FILE] [--numgenes NUMGENES] [--tpm TPM]
            [--max-nmf-iter MAX_NMF_ITER]
            [--beta-loss {frobenius,kullback-leibler,itakura-saito}]
            [--init {random,nndsvd}] [--densify] [--worker-index WORKER_INDEX]
            [--skip-completed-runs]
            [--local-density-threshold LOCAL_DENSITY_THRESHOLD]
            [--local-neighborhood-size LOCAL_NEIGHBORHOOD_SIZE]
            [--show-clustering] [--build-reference]
            {prepare,factorize,combine,consensus,k_selection_plot}

positional arguments:
  {prepare,factorize,combine,consensus,k_selection_plot}

optional arguments:
  -h, --help            show this help message and exit
  --name [NAME]         [all] Name for analysis. All output will be placed in
                        [output-dir]/[name]/...
  --output-dir [OUTPUT_DIR]
                        [all] Output directory. All output will be placed in
                        [output-dir]/[name]/...
  -c COUNTS, --counts COUNTS
                        [prepare] Input (cell x gene) counts matrix as .h5ad,
                        .mtx, df.npz, or tab delimited text file
  -k COMPONENTS [COMPONENTS ...], --components COMPONENTS [COMPONENTS ...]
                        [prepare] Numper of components (k) for matrix
                        factorization. Several can be specified with "-k 8 9
                        10"
  -n N_ITER, --n-iter N_ITER
                        [prepare] Number of factorization replicates
  --total-workers TOTAL_WORKERS
                        [all] Total number of workers to distribute jobs to
  --seed SEED           [prepare] Seed for pseudorandom number generation
  --genes-file GENES_FILE
                        [prepare] File containing a list of genes to include,
                        one gene per line. Must match column labels of counts
                        matrix.
  --numgenes NUMGENES   [prepare] Number of high variance genes to use for
                        matrix factorization.
  --tpm TPM             [prepare] Pre-computed (cell x gene) TPM values as
                        df.npz or tab separated txt file. If not provided TPM
                        will be calculated automatically
  --max-nmf-iter MAX_NMF_ITER
                        [prepare] Max number of iterations per individual NMF
                        run (default 1000)
  --beta-loss {frobenius,kullback-leibler,itakura-saito}
                        [prepare] Loss function for NMF (default frobenius)
  --init {random,nndsvd}
                        [prepare] Initialization algorithm for NMF (default
                        random)
  --densify             [prepare] Treat the input data as non-sparse (default
                        False)
  --worker-index WORKER_INDEX
                        [factorize] Index of current worker (the first worker
                        should have index 0)
  --skip-completed-runs
                        [factorize] Skip previously completed runs. Must re-
                        run prepare first to update completed runs
  --local-density-threshold LOCAL_DENSITY_THRESHOLD
                        [consensus] Threshold for the local density filtering.
                        This string must convert to a float >0 and <=2
  --local-neighborhood-size LOCAL_NEIGHBORHOOD_SIZE
                        [consensus] Fraction of the number of replicates to
                        use as nearest neighbors for local density filtering
  --show-clustering     [consensus] Produce a clustergram figure summarizing
                        the spectra clustering
  --build-reference     [consensus] Generates a reference spectra for use in
                        starCAT
```

