# ananse CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| ananse_binding | PASS |  |
| ananse_influence | PASS |  |
| ananse_network | PASS |  |
| ananse_plot | PASS |  |
| ananse_view | PASS |  |

## ananse_binding

### Tool Description
Predict transcription factor binding in regions from ATAC-seq and/or H3K27ac ChIP-seq signal and motif scores (writes binding.h5).

### Metadata
- **Docker Image**: quay.io/biocontainers/ananse:0.5.1--pyhdfd78af_0
- **Homepage**: https://github.com/vanheeringen-lab/ANANSE
- **Package**: https://anaconda.org/channels/bioconda/packages/ananse/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ananse/overview
- **Total Downloads**: 35.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/vanheeringen-lab/ANANSE
- **Stars**: N/A
### Original Help Text
```text
usage: ananse [-h] <command> [options] binding [-A BAM [BAM ...]]
                                               [-H BAM [BAM ...]] [-C TPM]
                                               [-g NAME] [-r [FILE ...]]
                                               [-p FILE] [-o DIR]
                                               [-c [COL ...]] [-R DIR]
                                               [--pfmscorefile FILE]
                                               [-t [TF ...]]
                                               [--jaccard-cutoff FLOAT]
                                               [-n INT] [-h]

Required arguments:
  -A BAM [BAM ...], --atac-bams BAM [BAM ...]
                        ATAC-seq input BAM file(s) (or one counts table with
                        reads per peak), can be used alone or in combination
                        with the -H option
  -H BAM [BAM ...], --histone-bams BAM [BAM ...]
                        H3K27ac ChIP-seq input BAM file(s) (or one counts
                        table with reads per peak), can be used alone or in
                        combination with the -A option
  -C TPM, --cage-tpms TPM
                        CAGE-seq bidirectional regions (TPM) generated with
                        CAGEfightR, cannot be used in combination with the -A
                        and/or -H options
  -g NAME, --genome NAME
                        Genome (genomepy name or FASTA file) used to align the
                        BAMs and regions to (default: hg38)

Required arguments (optional for hg38):
  -r [FILE ...], --regions [FILE ...]
                        Regions to analyse. Can be one or more BED format
                        files (e.g. BED, narrowPeak, broadPeak) or one file
                        with one region per line (e.g. 'chr1:100-200') or a
                        space-separated list. Optional if a pfmscorefile is
                        provided (used to filter those regions instead)
  -p FILE, --pfmfile FILE
                        PFM file of the transcription factors to search for
                        (default: gimme.vertebrate.v5.0)

Optional arguments:
  -o DIR, --outdir DIR  Directory where you wish to store the output (default:
                        ./ANANSE_binding)
  -c [COL ...], --columns [COL ...]
                        One or more (case insensitive) column names to extract
                        from the counts table(s) (default: all)
  -R DIR, --reference DIR
                        Path to reference data directory
  --pfmscorefile FILE   Use precomputed gimmemotifs scores (gimme scan -Tz
                        --gc -g GENOME REGIONS > SCAN.tsv)
  -t [TF ...], --tfs [TF ...]
                        Filter Transcription Factors to use (default: all in
                        motif2factors.txt). Either a space-separated list or
                        one or more files with one TF per line
  --jaccard-cutoff FLOAT
                        TFs with a jaccard motif similarity >= the cutoff can
                        be used as backup model. 0: any similarity, 1: perfect
                        similarity (default is 0.1)
  -n INT, --ncore INT   Number of cores to use.
  -h, --help            show this help message and exit
```


## ananse_network

### Tool Description
Infer a gene regulatory network from TF binding predictions and gene expression.

### Metadata
- **Docker Image**: quay.io/biocontainers/ananse:0.5.1--pyhdfd78af_0
- **Homepage**: https://github.com/vanheeringen-lab/ANANSE
- **Package**: https://anaconda.org/channels/bioconda/packages/ananse/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ananse/overview
- **Total Downloads**: 35.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/vanheeringen-lab/ANANSE
- **Stars**: N/A
### Original Help Text
```text
usage: ananse [-h] <command> [options] network [-e FILE [FILE ...]] [-g NAME]
                                               [-a BED] [-o FILE]
                                               [-t [TF ...]] [-r [FILE ...]]
                                               [-c [COL ...]] [-f]
                                               [--include-promoter]
                                               [--include-enhancer] [-n INT]
                                               [-h]
                                               FILE

required arguments:
  FILE                  TF binding prediction file (ANANSE binding output)
  -e FILE [FILE ...], --expression FILE [FILE ...]
                        Gene expression file(s) with genes as first column and
                        expression column(s) in TPM values (column name(s)
                        specified below). Genes must be in HGNC symbols,
                        unless a genomepy gene annotation is provided. Files
                        can include transcript-level TPMs (the quant.sf from
                        salmon or the abundances.tsv from kallisto), or gene-
                        level TPMs tables (summarized with e.g. tximeta).

Required arguments (optional for hg38):
  -g NAME, --genome NAME
                        Genome (genomepy name or FASTA file) used to align the
                        BAMs and regions to (default: hg38)
  -a BED, --annotation BED
                        Gene annotation (genomepy name or BED12 file) used to
                        quantify expression levels. Optional when a genomepy
                        genome (with annotation) is providing.

optional arguments:
  -o FILE, --outfile FILE
                        Name of the output network file (default:
                        ./ANANSE_network.tsv)
  -t [TF ...], --tfs [TF ...]
                        Filter Transcription Factors to use (default: all in
                        motif2factors.txt). Either a space-separated list or
                        one or more files with one TF per line
  -r [FILE ...], --regions [FILE ...]
                        Filter regions to use (default: all in binding.h5).
                        Either one region/BED format file or a space-separated
                        list.
  -c [COL ...], --columns [COL ...]
                        One or more (case insensitive) column names to extract
                        from the expression file(s) (default: tpm)
  -f, --full-output     Export the full GRN output to the output file
  --include-promoter, --exclude-promoter
                        Include or exclude promoter peaks (<= TSS +/- 2kb) in
                        network inference. By default promoter peaks are
                        included.
  --include-enhancer, --exclude-enhancer
                        Include or exclude enhancer peaks (> TSS +/- 2kb) in
                        network inference. By default enhancer peaks are
                        included.
  -n INT, --ncore INT   Number of cores to use.
  -h, --help            show this help message and exit
```


## ananse_influence

### Tool Description
Prioritize transcription factors that explain the difference between two cell types (source and target networks plus differential expression).

### Metadata
- **Docker Image**: quay.io/biocontainers/ananse:0.5.1--pyhdfd78af_0
- **Homepage**: https://github.com/vanheeringen-lab/ANANSE
- **Package**: https://anaconda.org/channels/bioconda/packages/ananse/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ananse/overview
- **Total Downloads**: 35.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/vanheeringen-lab/ANANSE
- **Stars**: N/A
### Original Help Text
```text
usage: ananse [-h] <command> [options] influence -t FILE -d FILE [-s FILE]
                                                 [-o FILE] [-f] [-a GTF]
                                                 [-i INT]
                                                 [--select-after-join]
                                                 [-w [...]] [-j FLOAT]
                                                 [-c STR] [-n INT] [-h]

required arguments:
  -t FILE, --target FILE
                        Network of target cell type.
  -d FILE, --degenes FILE
                        File with differential gene expression (DEseq2 output
                        file). Genes must be in HGNC symbols, unless a
                        genomepy gene annotation is provided.

optional arguments:
  -s FILE, --source FILE
                        Network of source cell type.
  -o FILE, --outfile FILE
                        Name of the output influence file (default:
                        ./ANANSE_influence.tsv)
  -f, --full-output     Export the full GRN output to the output file
  -a GTF, --annotation GTF
                        Gene annotation (genomepy name or GTF file) used to
                        quantify expression levels.
  -i INT, --interactions INT
                        Number of top TF-gene interactions used (default:
                        500.000).
  --select-after-join   Select top interactions on differential network,
                        instead of input networks.
  -w [ ...], --whitelist [ ...]
                        Include these genes/interactions after filtering top
                        interactions. Either a space-separated list or a file
                        with one TF/gene/TF—gene interaction per line.
  -j FLOAT, --padj FLOAT
                        Adjusted p-value below which genes classify as
                        differential (default: 0.05).
  -c STR, --column STR  Column of the network file(s) to select top
                        interactions (default: prob).
  -n INT, --ncore INT   Number of cores to use.
  -h, --help            show this help message and exit
```


## ananse_plot

### Tool Description
Plot TF influence scores and the differential gene regulatory network of the top TFs.

### Metadata
- **Docker Image**: quay.io/biocontainers/ananse:0.5.1--pyhdfd78af_0
- **Homepage**: https://github.com/vanheeringen-lab/ANANSE
- **Package**: https://anaconda.org/channels/bioconda/packages/ananse/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ananse/overview
- **Total Downloads**: 35.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/vanheeringen-lab/ANANSE
- **Stars**: N/A
### Original Help Text
```text
usage: ananse [-h] <command> [options] plot [-d FILE] [-o DIR]
                                            [--edge-info EDGE_INFO]
                                            [--edge-min EDGE_MIN]
                                            [--node-placement NETWORK_ALGORITHM]
                                            [--n-tfs N_TFS] [-c CMAP] [-f]
                                            [-t FTYPE] [-h]
                                            FILE

required arguments:
  FILE                  TF influence file (ANANSE influence output)
  -d FILE, --diff-network FILE
                        TF influence diffnetwork file (also ANANSE influence
                        output)

optional arguments:
  -o DIR, --outdir DIR  Directory where you wish to store the output (default:
                        ./ANANSE_plot)
  --edge-info EDGE_INFO
                        Column to use for edges of GRN, default: 'weight'.
                        When full_output is specified, options are 'wb_diff'
                        ,'tf_act_diff', 'tf_expr_diff', 'tg_expr_diff'
  --edge-min EDGE_MIN   Minimum value for an edge to be included in the GRN
                        image
  --node-placement NETWORK_ALGORITHM
                        pyviz cluster algorithm used for node placement,
                        options include: neato, dot, fdp, twopi, sfdp, circo
  --n-tfs N_TFS         Amount of TFs to plot in the GRN, default is top 20
                        differential TFs
  -c CMAP, --cmap CMAP  matlotlib colour library
  -f, --full-output     Select if the diffnetwork is a full output file
  -t FTYPE, --type FTYPE
                        Specify the output filetype (default: pdf)
  -h, --help            show this help message and exit
```


## ananse_view

### Tool Description
Explore the contents of an ANANSE binding file.

### Metadata
- **Docker Image**: quay.io/biocontainers/ananse:0.5.1--pyhdfd78af_0
- **Homepage**: https://github.com/vanheeringen-lab/ANANSE
- **Package**: https://anaconda.org/channels/bioconda/packages/ananse/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ananse/overview
- **Total Downloads**: 35.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/vanheeringen-lab/ANANSE
- **Stars**: N/A
### Original Help Text
```text
usage: ananse [-h] <command> [options] view [-o FILE] [-t [TF ...]]
                                            [-r [REGION ...]] [-F FORMAT]
                                            [-n INT] [-lr] [-lt] [-a] [-h]
                                            FILE

Explore the contents of an ANANSE binding file.

required arguments:
  FILE                  TF binding prediction file (ANANSE binding output)

optional arguments:
  -o FILE, --outfile FILE
                        Output file (tab-separated text, default: stdout)
  -t [TF ...], --tfs [TF ...]
                        Transcription factor(s) to display (default: all)
  -r [REGION ...], --regions [REGION ...]
                        Region(s) to display (default: all)
  -F FORMAT, --format FORMAT
                        Display format: wide (n columns) or long (3 columns)
                        (default: wide)
  -n INT                Number of regions and tfs to display (default: all)
  -lr, --list-regions   Return a list of regions
  -lt, --list-tfs       Return a list of transcription factors
  -a, --activity        Return activity scores of transcription factors
  -h, --help            show this help message and exit
```


