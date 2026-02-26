# iobrpy CWL Generation Report

## iobrpy_prepare_salmon

### Tool Description
Prepare a TPM matrix from Salmon output.

### Metadata
- **Docker Image**: quay.io/biocontainers/iobrpy:0.1.7--pyhdfd78af_0
- **Homepage**: https://github.com/IOBR/IOBRpy
- **Package**: https://anaconda.org/channels/bioconda/packages/iobrpy/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/iobrpy/overview
- **Total Downloads**: 196
- **Last updated**: 2025-12-26
- **GitHub**: https://github.com/IOBR/IOBRpy
- **Stars**: N/A
### Original Help Text
```text
usage: iobrpy prepare_salmon [-h] -i ESET_PATH -o OUTPUT_MATRIX
                             [-r {ENST,ENSG,symbol}] [--remove_version]

options:
  -h, --help            show this help message and exit
  -i ESET_PATH, --input ESET_PATH
                        Path to input Salmon file (TSV or TSV.GZ)
  -o OUTPUT_MATRIX, --output OUTPUT_MATRIX
                        Path to save cleaned TPM matrix
  -r {ENST,ENSG,symbol}, --return_feature {ENST,ENSG,symbol}
                        Which gene feature to retain
  --remove_version      Remove version suffix from gene IDs
```


## iobrpy_count2tpm

### Tool Description
Convert gene counts to TPM (Transcripts Per Million)

### Metadata
- **Docker Image**: quay.io/biocontainers/iobrpy:0.1.7--pyhdfd78af_0
- **Homepage**: https://github.com/IOBR/IOBRpy
- **Package**: https://anaconda.org/channels/bioconda/packages/iobrpy/overview
- **Validation**: PASS

### Original Help Text
```text
usage: iobrpy count2tpm [-h] -i COUNT_MAT [--effLength_csv EFFLENGTH_CSV]
                        [--idtype {ensembl,entrez,symbol,mgi}]
                        [--org {hsa,mmus}] [--source {local,biomart}]
                        [--id ID_COL] [--length LENGTH_COL]
                        [--gene_symbol GENE_SYMBOL_COL] [--check_data] -o
                        OUTPUT_PATH [--remove_version]

options:
  -h, --help            show this help message and exit
  -i COUNT_MAT, --input COUNT_MAT
                        Path to input count matrix (CSV/TSV, genes×samples)
  --effLength_csv EFFLENGTH_CSV
                        Optional CSV with id, eff_length, and gene_symbol
                        columns
  --idtype {ensembl,entrez,symbol,mgi}
                        Gene ID type
  --org {hsa,mmus}      Organism: hsa or mmus
  --source {local,biomart}
                        Source of gene lengths
  --id ID_COL           Column name for gene ID in effLength CSV
  --length LENGTH_COL   Column name for gene length in effLength CSV
  --gene_symbol GENE_SYMBOL_COL
                        Column name for gene symbol in effLength CSV
  --check_data          Check and remove missing values in count matrix
  -o OUTPUT_PATH, --output OUTPUT_PATH
                        Path to save TPM matrix
  --remove_version      Remove version suffix from gene IDs before processing
```


## iobrpy_anno_eset

### Tool Description
Annotates an expression set with gene/probe information.

### Metadata
- **Docker Image**: quay.io/biocontainers/iobrpy:0.1.7--pyhdfd78af_0
- **Homepage**: https://github.com/IOBR/IOBRpy
- **Package**: https://anaconda.org/channels/bioconda/packages/iobrpy/overview
- **Validation**: PASS

### Original Help Text
```text
usage: iobrpy anno_eset [-h] -i INPUT_PATH -o OUTPUT_PATH --annotation
                        {anno_hug133plus2,anno_rnaseq,anno_illumina,anno_grch38}
                        [--annotation-file ANNOTATION_FILE]
                        [--annotation-key ANNOTATION_KEY] [--symbol SYMBOL]
                        [--probe PROBE] [--method {mean,sd,sum}]
                        [--remove_version]

options:
  -h, --help            show this help message and exit
  -i INPUT_PATH, --input INPUT_PATH
                        Path to input expression set
  -o OUTPUT_PATH, --output OUTPUT_PATH
                        Path to save annotated expression set
  --annotation {anno_hug133plus2,anno_rnaseq,anno_illumina,anno_grch38}
                        Annotation key to use (ignored if --annotation-file is
                        provided)
  --annotation-file ANNOTATION_FILE
                        Path to external annotation file (pkl/csv/tsv/xlsx).
                        Overrides built-in annotation if provided.
  --annotation-key ANNOTATION_KEY
                        If external pkl contains multiple dataframes (a dict),
                        select which key to use.
  --symbol SYMBOL       Annotation symbol column
  --probe PROBE         Annotation probe column
  --method {mean,sd,sum}
                        Dup handling method
  --remove_version      Remove version suffix from gene IDs before annotation
```


## iobrpy_calculate_sig_score

### Tool Description
Calculate signature scores from an expression matrix.

### Metadata
- **Docker Image**: quay.io/biocontainers/iobrpy:0.1.7--pyhdfd78af_0
- **Homepage**: https://github.com/IOBR/IOBRpy
- **Package**: https://anaconda.org/channels/bioconda/packages/iobrpy/overview
- **Validation**: PASS

### Original Help Text
```text
usage: iobrpy calculate_sig_score [-h] -i INPUT_PATH -o OUTPUT_PATH
                                  --signature SIGNATURE [SIGNATURE ...]
                                  [--method {pca,zscore,ssgsea,integration}]
                                  [--mini_gene_count MINI_GENE_COUNT]
                                  [--adjust_eset]
                                  [--parallel_size PARALLEL_SIZE]

options:
  -h, --help            show this help message and exit
  -i INPUT_PATH, --input INPUT_PATH
                        Path to input expression matrix
  -o OUTPUT_PATH, --output OUTPUT_PATH
                        Path to save signature scores
  --signature SIGNATURE [SIGNATURE ...]
                        One or more signature GROUP names to use. Examples:
                        signature_collection signature_tme (space-separated),
                        or signature_collection,signature_tme (comma-
                        separated). Supported groups include: go_bp, go_cc,
                        go_mf, signature_collection, signature_tme,
                        signature_sc, signature_tumor, signature_metabolism,
                        kegg, hallmark, reactome, or "all" to use all groups.
  --method {pca,zscore,ssgsea,integration}
                        Scoring method to apply
  --mini_gene_count MINI_GENE_COUNT
                        Minimum genes per signature
  --adjust_eset         Apply additional filtering after log2 transform
  --parallel_size PARALLEL_SIZE
                        Threads for scoring (PCA/zscore/ssGSEA)
```


## iobrpy_cibersort

### Tool Description
CIBERSORT analysis tool

### Metadata
- **Docker Image**: quay.io/biocontainers/iobrpy:0.1.7--pyhdfd78af_0
- **Homepage**: https://github.com/IOBR/IOBRpy
- **Package**: https://anaconda.org/channels/bioconda/packages/iobrpy/overview
- **Validation**: PASS

### Original Help Text
```text
usage: iobrpy cibersort [-h] -i INPUT_PATH [--perm PERM] [--QN QN]
                        [--absolute ABSOLUTE]
                        [--abs_method {sig.score,no.sumto1}]
                        [--threads THREADS] -o OUTPUT_PATH

options:
  -h, --help            show this help message and exit
  -i INPUT_PATH, --input INPUT_PATH
                        Path to mixture file (CSV or TSV)
  --perm PERM           Number of permutations
  --QN QN               Quantile normalization (True/False)
  --absolute ABSOLUTE   Absolute mode (True/False)
  --abs_method {sig.score,no.sumto1}
                        Absolute scoring method
  --threads THREADS     Number of parallel threads
  -o OUTPUT_PATH, --output OUTPUT_PATH
                        Path to save CIBERSORT results (CSV or TSV)
```


## iobrpy_ips

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/iobrpy:0.1.7--pyhdfd78af_0
- **Homepage**: https://github.com/IOBR/IOBRpy
- **Package**: https://anaconda.org/channels/bioconda/packages/iobrpy/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
usage: iobrpy [-h] [--version]  ...
iobrpy: error: argument : invalid choice: 'ips' (choose from prepare_salmon, count2tpm, anno_eset, calculate_sig_score, cibersort, IPS, estimate, mcpcounter, quantiseq, epic, deside, tme_cluster, LR_cal, nmf, mouse2human_eset, batch_salmon, merge_salmon, merge_star_count, batch_star_count, fastq_qc, log2_eset, trust4, spechla, extract_hla_read, hla_typing, tme_profile, runall, bayesprism)
```


## iobrpy_estimate

### Tool Description
Estimate gene expression levels from raw count matrices.

### Metadata
- **Docker Image**: quay.io/biocontainers/iobrpy:0.1.7--pyhdfd78af_0
- **Homepage**: https://github.com/IOBR/IOBRpy
- **Package**: https://anaconda.org/channels/bioconda/packages/iobrpy/overview
- **Validation**: PASS

### Original Help Text
```text
usage: iobrpy estimate [-h] -i INPUT_PATH [-p {affymetrix,agilent,illumina}]
                       -o OUTPUT_PATH

options:
  -h, --help            show this help message and exit
  -i INPUT_PATH, --input INPUT_PATH
                        Path to input matrix file (genes x samples)
  -p {affymetrix,agilent,illumina}, --platform {affymetrix,agilent,illumina}
                        Specify the platform type for the input data
  -o OUTPUT_PATH, --output OUTPUT_PATH
                        Path to save estimate results
```


## iobrpy_mcpcounter

### Tool Description
MCPcounter is a tool for estimating the abundance of immune cells in transcriptomic data.

### Metadata
- **Docker Image**: quay.io/biocontainers/iobrpy:0.1.7--pyhdfd78af_0
- **Homepage**: https://github.com/IOBR/IOBRpy
- **Package**: https://anaconda.org/channels/bioconda/packages/iobrpy/overview
- **Validation**: PASS

### Original Help Text
```text
usage: iobrpy mcpcounter [-h] -i INPUT_PATH -f
                         {affy133P2_probesets,HUGO_symbols,ENTREZ_ID,ENSEMBL_ID}
                         -o OUTPUT_PATH

options:
  -h, --help            show this help message and exit
  -i INPUT_PATH, --input INPUT_PATH
                        Path to input expression matrix (TSV, genes×samples)
  -f {affy133P2_probesets,HUGO_symbols,ENTREZ_ID,ENSEMBL_ID}, --features {affy133P2_probesets,HUGO_symbols,ENTREZ_ID,ENSEMBL_ID}
                        Type of gene identifiers
  -o OUTPUT_PATH, --output OUTPUT_PATH
                        Path to save MCPcounter results (TSV)
```


## iobrpy_quantiseq

### Tool Description
Performs deconvolution of immune cell proportions from gene expression data.

### Metadata
- **Docker Image**: quay.io/biocontainers/iobrpy:0.1.7--pyhdfd78af_0
- **Homepage**: https://github.com/IOBR/IOBRpy
- **Package**: https://anaconda.org/channels/bioconda/packages/iobrpy/overview
- **Validation**: PASS

### Original Help Text
```text
usage: iobrpy quantiseq [-h] -i INPUT -o OUTPUT [--arrays] [--signame SIGNAME]
                        [--tumor] [--scale_mrna]
                        [--method {lsei,hampel,huber,bisquare}]
                        [--rmgenes RMGENES]

options:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
                        Path to the input mixture matrix TSV/CSV file (genes x
                        samples)
  -o OUTPUT, --output OUTPUT
                        Path to save the deconvolution results TSV
  --arrays              Perform quantile normalization on array data before
                        deconvolution
  --signame SIGNAME     Name of the signature set to use (default: TIL10)
  --tumor               Remove genes with high expression in tumor samples
  --scale_mrna          Enable mRNA scaling; use raw signature proportions
                        otherwise
  --method {lsei,hampel,huber,bisquare}
                        Deconvolution method: lsei (least squares) or robust
                        norms
  --rmgenes RMGENES     Genes to remove: 'default', 'none', or comma-separated
                        list
```


## iobrpy_epic

### Tool Description
EPIC deconvolution tool

### Metadata
- **Docker Image**: quay.io/biocontainers/iobrpy:0.1.7--pyhdfd78af_0
- **Homepage**: https://github.com/IOBR/IOBRpy
- **Package**: https://anaconda.org/channels/bioconda/packages/iobrpy/overview
- **Validation**: PASS

### Original Help Text
```text
usage: iobrpy epic [-h] -i INPUT -o OUTPUT [--reference {TRef,BRef,both}]

options:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
                        Path to the bulk expression matrix (genes×samples)
  -o OUTPUT, --output OUTPUT
                        Path to save EPIC cell fractions (CSV/TSV)
  --reference {TRef,BRef,both}
                        Which reference to use for deconvolution
```


## iobrpy_deside

### Tool Description
Predicts cell fractions from gene expression data using a DeSide model.

### Metadata
- **Docker Image**: quay.io/biocontainers/iobrpy:0.1.7--pyhdfd78af_0
- **Homepage**: https://github.com/IOBR/IOBRpy
- **Package**: https://anaconda.org/channels/bioconda/packages/iobrpy/overview
- **Validation**: PASS

### Original Help Text
```text
usage: iobrpy deside [-h] -m MODEL_DIR -i INPUT -o OUTPUT
                     [--exp_type {TPM,log_space,linear}] [--gmt GMT [GMT ...]]
                     [--print_info] [--add_cell_type] [--scaling_by_constant]
                     [--scaling_by_sample] [--one_minus_alpha]
                     [--method_adding_pathway {add_to_end,convert}]
                     [--transpose] [-r RESULT_DIR]

options:
  -h, --help            show this help message and exit
  -m MODEL_DIR, --model_dir MODEL_DIR
                        Path to DeSide_model directory
  -i INPUT, --input INPUT
                        Expression file (CSV/TSV) with rows=genes and
                        columns=samples
  -o OUTPUT, --output OUTPUT
                        Output CSV for predicted cell fractions
  --exp_type {TPM,log_space,linear}
                        Input format: TPM (log2 processed), log_space (log2
                        TPM+1), or linear (TPM/counts)
  --gmt GMT [GMT ...]   Optional GMT files for pathway masking
  --print_info          Show detailed logs during prediction
  --add_cell_type       Append predicted cell type labels
  --scaling_by_constant
                        Enable division-by-constant scaling
  --scaling_by_sample   Enable per-sample min–max scaling
  --one_minus_alpha     Use 1−α transformation for all cell types
  --method_adding_pathway {add_to_end,convert}
                        How to integrate pathway profiles: add_to_end or
                        convert
  --transpose           Transpose input so that rows=samples and columns=genes
  -r RESULT_DIR, --result_dir RESULT_DIR
                        Directory to save result plots
```


## iobrpy_tme_cluster

### Tool Description
Perform TME clustering on input data.

### Metadata
- **Docker Image**: quay.io/biocontainers/iobrpy:0.1.7--pyhdfd78af_0
- **Homepage**: https://github.com/IOBR/IOBRpy
- **Package**: https://anaconda.org/channels/bioconda/packages/iobrpy/overview
- **Validation**: PASS

### Original Help Text
```text
usage: iobrpy tme_cluster [-h] -i INPUT -o OUTPUT [--features FEATURES]
                          [--pattern PATTERN] [--id ID] [--scale] [--no-scale]
                          [--min_nc MIN_NC] [--max_nc MAX_NC]
                          [--max_iter MAX_ITER] [--tol TOL] [--print_result]
                          [--input_sep INPUT_SEP] [--output_sep OUTPUT_SEP]

options:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
                        Path to input file (CSV/TSV/TXT)
  -o OUTPUT, --output OUTPUT
                        Path to save clustering results (CSV/TSV/TXT)
  --features FEATURES   Feature columns to use, e.g. '1:22' if use
                        cibersort(excluding the sample column)
  --pattern PATTERN     Regex to select feature columns by name
  --id ID               Column name for sample IDs (default: first column)
  --scale               Enable z-score scaling (default: True)
  --no-scale            Disable z-score scaling
  --min_nc MIN_NC       Minimum number of clusters
  --max_nc MAX_NC       Maximum number of clusters
  --max_iter MAX_ITER   Maximum number of iterations for the k-means algorithm
  --tol TOL             Convergence tolerance for cluster center updates
  --print_result        Print intermediate KL scores and cluster counts
  --input_sep INPUT_SEP
                        Field separator for input (auto-detect if not set)
  --output_sep OUTPUT_SEP
                        Field separator for output (auto-detect if not set)
```


## iobrpy_lr_cal

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/iobrpy:0.1.7--pyhdfd78af_0
- **Homepage**: https://github.com/IOBR/IOBRpy
- **Package**: https://anaconda.org/channels/bioconda/packages/iobrpy/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
usage: iobrpy [-h] [--version]  ...
iobrpy: error: argument : invalid choice: 'lr_cal' (choose from prepare_salmon, count2tpm, anno_eset, calculate_sig_score, cibersort, IPS, estimate, mcpcounter, quantiseq, epic, deside, tme_cluster, LR_cal, nmf, mouse2human_eset, batch_salmon, merge_salmon, merge_star_count, batch_star_count, fastq_qc, log2_eset, trust4, spechla, extract_hla_read, hla_typing, tme_profile, runall, bayesprism)
```


## iobrpy_nmf

### Tool Description
Non-negative Matrix Factorization (NMF) for dimensionality reduction and deconvolution.

### Metadata
- **Docker Image**: quay.io/biocontainers/iobrpy:0.1.7--pyhdfd78af_0
- **Homepage**: https://github.com/IOBR/IOBRpy
- **Package**: https://anaconda.org/channels/bioconda/packages/iobrpy/overview
- **Validation**: PASS

### Original Help Text
```text
usage: iobrpy nmf [-h] -i INPUT -o OUTPUT [--kmin KMIN] [--kmax KMAX]
                  [--features FEATURES] [--log1p] [--normalize]
                  [--shift SHIFT] [--random-state RANDOM_STATE]
                  [--max-iter MAX_ITER] [--skip_k_2]

options:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
                        Input matrix file (CSV or TSV). First column should be
                        sample names (index).
  -o OUTPUT, --output OUTPUT
                        Output directory where results will be saved.
  --kmin KMIN           Minimum k (inclusive). Default: 2
  --kmax KMAX           Maximum k (inclusive). Default: 8
  --features FEATURES   Columns (cell types) to use, e.g. '2-10' or '1:5'.
                        1-based inclusive.
  --log1p               Apply log1p transform to the input (useful for
                        counts).
  --normalize           Apply L1 row normalization (each sample sums to 1).
  --shift SHIFT         If input contains negatives, add a constant shift to
                        make values non-negative.
  --random-state RANDOM_STATE
                        Random state passed to NMF
  --max-iter MAX_ITER   Maximum iterations for NMF (default: 1000)
  --skip_k_2            Skip k=2 when searching for the best k (default: do
                        not skip)
```


## iobrpy_mouse2human_eset

### Tool Description
Convert mouse gene symbols to human gene symbols.

### Metadata
- **Docker Image**: quay.io/biocontainers/iobrpy:0.1.7--pyhdfd78af_0
- **Homepage**: https://github.com/IOBR/IOBRpy
- **Package**: https://anaconda.org/channels/bioconda/packages/iobrpy/overview
- **Validation**: PASS

### Original Help Text
```text
usage: iobrpy mouse2human_eset [-h] -i INPUT -o OUTPUT [--is_matrix]
                               [--column_of_symbol COLUMN_OF_SYMBOL]
                               [--verbose] [--sep SEP] [--out_sep OUT_SEP]
                               [--progress]

options:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
                        Path to input file (CSV/TSV/TXT, optionally .gz)
  -o OUTPUT, --output OUTPUT
                        Path to save converted matrix (CSV/TSV/TXT, optionally
                        .gz)
  --is_matrix           Treat input as a matrix (rows=genes, cols=samples). If
                        omitted, expects a symbol column.
  --column_of_symbol COLUMN_OF_SYMBOL
                        Column name containing gene symbols when not using
                        --is_matrix.
  --verbose             Verbose output.
  --sep SEP             Input separator (',' or '\t'). If omitted, infer by
                        input extension.
  --out_sep OUT_SEP     Output separator (',' or '\t'). If omitted, infer by
                        output extension.
  --progress            Show a progress bar during saving.
```


## iobrpy_batch_salmon

### Tool Description
Run Salmon in batch mode on multiple samples.

### Metadata
- **Docker Image**: quay.io/biocontainers/iobrpy:0.1.7--pyhdfd78af_0
- **Homepage**: https://github.com/IOBR/IOBRpy
- **Package**: https://anaconda.org/channels/bioconda/packages/iobrpy/overview
- **Validation**: PASS

### Original Help Text
```text
usage: iobrpy batch_salmon [-h] --index INDEX --path_fq PATH_FQ --path_out
                           PATH_OUT [--suffix1 SUFFIX1]
                           [--batch_size BATCH_SIZE]
                           [--num_threads NUM_THREADS] [--gtf GTF]

options:
  -h, --help            show this help message and exit
  --index INDEX         Path to Salmon index
  --path_fq PATH_FQ     Directory containing FASTQ files
  --path_out PATH_OUT   Output directory for per-sample results
  --suffix1 SUFFIX1     R1 suffix; R2 inferred by replacing '1' with '2'
  --batch_size BATCH_SIZE
                        Number of concurrent samples (processes)
  --num_threads NUM_THREADS
                        Threads per Salmon process
  --gtf GTF             Optional GTF file path for Salmon (-g)
```


## iobrpy_merge_salmon

### Tool Description
Merge Salmon quant.sf files from multiple runs.

### Metadata
- **Docker Image**: quay.io/biocontainers/iobrpy:0.1.7--pyhdfd78af_0
- **Homepage**: https://github.com/IOBR/IOBRpy
- **Package**: https://anaconda.org/channels/bioconda/packages/iobrpy/overview
- **Validation**: PASS

### Original Help Text
```text
usage: iobrpy merge_salmon [-h] --path_salmon PATH_SALMON --project PROJECT
                           [--num_processes NUM_PROCESSES]

options:
  -h, --help            show this help message and exit
  --path_salmon PATH_SALMON
                        Root folder searched recursively for quant.sf
  --project PROJECT     Output file prefix
  --num_processes NUM_PROCESSES
                        Threads for loading quant.sf (I/O bound)
```


## iobrpy_merge_star_count

### Tool Description
Merge STAR counts from multiple samples.

### Metadata
- **Docker Image**: quay.io/biocontainers/iobrpy:0.1.7--pyhdfd78af_0
- **Homepage**: https://github.com/IOBR/IOBRpy
- **Package**: https://anaconda.org/channels/bioconda/packages/iobrpy/overview
- **Validation**: PASS

### Original Help Text
```text
usage: iobrpy merge_star_count [-h] --path PATH --project PROJECT

options:
  -h, --help         show this help message and exit
  --path PATH        Folder containing STAR outputs
  --project PROJECT  Output name prefix
```


## iobrpy_batch_star_count

### Tool Description
Run STAR aligner in batches for multiple samples.

### Metadata
- **Docker Image**: quay.io/biocontainers/iobrpy:0.1.7--pyhdfd78af_0
- **Homepage**: https://github.com/IOBR/IOBRpy
- **Package**: https://anaconda.org/channels/bioconda/packages/iobrpy/overview
- **Validation**: PASS

### Original Help Text
```text
usage: iobrpy batch_star_count [-h] --index INDEX --path_fq PATH_FQ --path_out
                               PATH_OUT [--suffix1 SUFFIX1]
                               [--batch_size BATCH_SIZE]
                               [--num_threads NUM_THREADS]

options:
  -h, --help            show this help message and exit
  --index INDEX         STAR genome index directory
  --path_fq PATH_FQ     Folder containing FASTQs (R1 endswith suffix1)
  --path_out PATH_OUT   Output folder for STAR results
  --suffix1 SUFFIX1     R1 suffix; R2 is inferred by 1→2
  --batch_size BATCH_SIZE
                        #samples per batch (sequential batches)
  --num_threads NUM_THREADS
                        Threads for STAR and BAM sorting
```


## iobrpy_fastq_qc

### Tool Description
Perform quality control on FASTQ files using fastp.

### Metadata
- **Docker Image**: quay.io/biocontainers/iobrpy:0.1.7--pyhdfd78af_0
- **Homepage**: https://github.com/IOBR/IOBRpy
- **Package**: https://anaconda.org/channels/bioconda/packages/iobrpy/overview
- **Validation**: PASS

### Original Help Text
```text
usage: iobrpy fastq_qc [-h] --path1_fastq PATH1_FASTQ --path2_fastp
                       PATH2_FASTP [--num_threads NUM_THREADS]
                       [--suffix1 SUFFIX1] [--batch_size BATCH_SIZE] [--se]
                       [--length_required LENGTH_REQUIRED]

options:
  -h, --help            show this help message and exit
  --path1_fastq PATH1_FASTQ
                        Directory containing raw FASTQ files
  --path2_fastp PATH2_FASTP
                        Output directory for cleaned FASTQ files
  --num_threads NUM_THREADS
                        Threads per fastp process
  --suffix1 SUFFIX1     R1 suffix; R2 inferred by replacing '1' with '2'
  --batch_size BATCH_SIZE
                        Number of concurrent samples (processes)
  --se                  Single-end sequencing; omit for paired-end
  --length_required LENGTH_REQUIRED
                        Minimum read length to keep
```


## iobrpy_log2_eset

### Tool Description
Applies log2(x+1) transformation to an expression set matrix.

### Metadata
- **Docker Image**: quay.io/biocontainers/iobrpy:0.1.7--pyhdfd78af_0
- **Homepage**: https://github.com/IOBR/IOBRpy
- **Package**: https://anaconda.org/channels/bioconda/packages/iobrpy/overview
- **Validation**: PASS

### Original Help Text
```text
usage: iobrpy log2_eset [-h] -i INPUT -o OUTPUT

options:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
                        Path to input matrix (CSV/TSV/TXT, optionally .gz).
                        Rows=genes, cols=samples.
  -o OUTPUT, --output OUTPUT
                        Path to save the log2(x+1) matrix. Extension selects
                        delimiter (.csv/.tsv or mirror input).
```


## iobrpy_trust4

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/iobrpy:0.1.7--pyhdfd78af_0
- **Homepage**: https://github.com/IOBR/IOBRpy
- **Package**: https://anaconda.org/channels/bioconda/packages/iobrpy/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
#########################################################
 IOBRpy: Immuno-Oncology Biological Research using Python 
 If you encounter any issues, please report them at 
 https://github.com/IOBR/IOBRpy/issues 
#########################################################
 Author: Haonan Huang, Dongqiang Zeng
 Email: interlaken@smu.edu.cn 
#########################################################
```


## iobrpy_spechla

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/iobrpy:0.1.7--pyhdfd78af_0
- **Homepage**: https://github.com/IOBR/IOBRpy
- **Package**: https://anaconda.org/channels/bioconda/packages/iobrpy/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
usage: iobrpy spechla [-h]

options:
  -h, --help  show this help message and exit
```


## iobrpy_extract_hla_read

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/iobrpy:0.1.7--pyhdfd78af_0
- **Homepage**: https://github.com/IOBR/IOBRpy
- **Package**: https://anaconda.org/channels/bioconda/packages/iobrpy/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
usage: iobrpy extract_hla_read [-h]

options:
  -h, --help  show this help message and exit
```


## iobrpy_hla_typing

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/iobrpy:0.1.7--pyhdfd78af_0
- **Homepage**: https://github.com/IOBR/IOBRpy
- **Package**: https://anaconda.org/channels/bioconda/packages/iobrpy/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
usage: iobrpy hla_typing [-h]

options:
  -h, --help  show this help message and exit
```


## iobrpy_tme_profile

### Tool Description
TPM matrix (genes x samples). CSV/TSV/.gz supported.

### Metadata
- **Docker Image**: quay.io/biocontainers/iobrpy:0.1.7--pyhdfd78af_0
- **Homepage**: https://github.com/IOBR/IOBRpy
- **Package**: https://anaconda.org/channels/bioconda/packages/iobrpy/overview
- **Validation**: PASS

### Original Help Text
```text
usage: iobrpy tme_profile [-h] -i INPUT -o OUTPUT [--threads THREADS]

options:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
                        TPM matrix (genes x samples). CSV/TSV/.gz supported.
  -o OUTPUT, --output OUTPUT
                        Output directory (01-signatures, 02-tme, 03-LR_cal).
  --threads THREADS     Threads for ssGSEA and CIBERSORT (default: 1).
```


## iobrpy_runall

### Tool Description
Run iobrpy in different modes.

### Metadata
- **Docker Image**: quay.io/biocontainers/iobrpy:0.1.7--pyhdfd78af_0
- **Homepage**: https://github.com/IOBR/IOBRpy
- **Package**: https://anaconda.org/channels/bioconda/packages/iobrpy/overview
- **Validation**: PASS

### Original Help Text
```text
usage: iobrpy runall [-h] --mode {salmon,star} --outdir OUTDIR --fastq FASTQ
                     [--resume] [--dry_run]

options:
  -h, --help            show this help message and exit
  --mode {salmon,star}
  --outdir OUTDIR
  --fastq FASTQ
  --resume
  --dry_run
```


## iobrpy_bayesprism

### Tool Description
BayesPrism is a tool for deconvolution of bulk RNA-seq data using single-cell RNA-seq data as a reference.

### Metadata
- **Docker Image**: quay.io/biocontainers/iobrpy:0.1.7--pyhdfd78af_0
- **Homepage**: https://github.com/IOBR/IOBRpy
- **Package**: https://anaconda.org/channels/bioconda/packages/iobrpy/overview
- **Validation**: PASS

### Original Help Text
```text
usage: iobrpy bayesprism [-h] -i INPUT -o OUTPUT [--threads THREADS]
                         [--sc_dat SC_DAT]
                         [--cell_state_labels CELL_STATE_LABELS]
                         [--cell_type_labels CELL_TYPE_LABELS] [--key KEY]

options:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
                        Bulk expression matrix (genes x samples). Rows=genes,
                        cols=samples.
  -o OUTPUT, --output OUTPUT
                        Output directory for BayesPrism results (theta.csv,
                        theta_cv.csv, Z_tumor.csv).
  --threads THREADS     Number of CPU cores for BayesPrism (n_cores).
  --sc_dat SC_DAT       Custom single-cell count matrix (genes x cells).
  --cell_state_labels CELL_STATE_LABELS
                        Custom cell_state_labels file (one label per line).
  --cell_type_labels CELL_TYPE_LABELS
                        Custom cell_type_labels file (one label per line).
  --key KEY             Tumor key forwarded to prism.Prism.new. Required when
                        using a custom single-cell reference via --sc_dat;
                        defaults to 'Malignant_cells' when the bundled
                        reference is used.
```

