# autometa CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| autometa_autometa-bedtools-genomecov | PASS |  |
| autometa_autometa-benchmark | PASS |  |
| autometa_autometa-binning | PASS |  |
| autometa_autometa-binning-ldm | PASS |  |
| autometa_autometa-binning-ldm-loginfo | PASS |  |
| autometa_autometa-binning-summary | PASS |  |
| autometa_autometa-cami-format | PASS |  |
| autometa_autometa-config | Failed | image problem: autometa-config always rewrites default.config inside the image, so it fails in the read-only container and works only with cwltool --no-read-only. |
| autometa_autometa-coverage | PASS |  |
| autometa_autometa-download-dataset | PASS |  |
| autometa_autometa-hmmsearch-filter | Failed | tool bug: main() reads args.infpath and args.markersout, which the parser never defines, so every run crashes with AttributeError. |
| autometa_autometa-kmers | PASS |  |
| autometa_autometa-length-filter | PASS |  |
| autometa_autometa-markers | PASS |  |
| autometa_autometa-orfs | PASS |  |
| autometa_autometa-setup-gtdb | PASS |  |
| autometa_autometa-taxonomy | PASS |  |
| autometa_autometa-taxonomy-lca | PASS |  |
| autometa_autometa-taxonomy-majority-vote | PASS |  |
| autometa_autometa-unclustered-recruitment | PASS |  |
| autometa_autometa-update-databases | PASS |  |

## autometa_autometa-bedtools-genomecov

### Tool Description
Compute genome coverage from sorted BAM file

### Metadata
- **Docker Image**: quay.io/biocontainers/autometa:2.2.3--pyh7e72e81_0
- **Homepage**: https://github.com/KwanLab/Autometa
- **Package**: https://anaconda.org/channels/bioconda/packages/autometa/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/autometa/overview
- **Total Downloads**: 17.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/KwanLab/Autometa
- **Stars**: N/A
### Original Help Text
```text
usage: autometa-bedtools-genomecov [-h] --ibam filepath --bed filepath
                                   --output filepath [--force-bed]
                                   [--force-cov]

Compute genome coverage from sorted BAM file

options:
  -h, --help         show this help message and exit
  --ibam filepath    Path to sorted alignment.bam
  --bed filepath     Path to write alignment.bed; tab-delimited
                     cols=[contig,length]
  --output filepath  Path to output coverage.tsv
  --force-bed        force overwrite `bed`
  --force-cov        force overwrite `--output`
```


## autometa_autometa-benchmark

### Tool Description
Benchmark classification, clustering or binning-classification against reference assignments for the provided simulated/synthetic community.

### Metadata
- **Docker Image**: quay.io/biocontainers/autometa:2.2.3--pyh7e72e81_0
- **Homepage**: https://github.com/KwanLab/Autometa
- **Package**: https://anaconda.org/channels/bioconda/packages/autometa/overview
- **Validation**: PASS

### Original Help Text
```text
usage: autometa-benchmark [-h] --benchmark
                          {binning-classification,clustering,classification}
                          [--predictions [filepath ...]] --reference filepath
                          [--average-method {geometric,max,arithmetic,min}]
                          [--output-wide filepath] [--output-long filepath]
                          [--output-classification-reports dirpath]
                          [--ncbi dirpath]

Benchmark classification, clustering or binning-classification against
reference assignments for the provided simulated/synthetic community.

options:
  -h, --help            show this help message and exit
  --benchmark {binning-classification,clustering,classification}
                        Type of benchmarking to perform (default: None)
  --predictions [filepath ...]
                        Path to Autometa predictions (May specify multiple if
                        they all correspond to the same `--reference`
                        community (default: None)
  --reference filepath  Path to community reference assignments (default:
                        None)
  --average-method {geometric,max,arithmetic,min}
                        Normalizer to select for normalized mutual information
                        score clustering metric (default: max)
  --output-wide filepath
                        Path to write benchmarking evaluation metrics (each
                        metric receives its own column) (Default:
                        `benchmark_type`_benchmarks.tsv.gz (default: None)
  --output-long filepath
                        Path to write clustering evaluation metrics (metrics
                        are stacked into one 'metric' column) (default: None)
  --output-classification-reports dirpath
                        Path to write classification evaluation reports
                        (default: None)
  --ncbi dirpath        Path to NCBI databases directory (Required with
                        --benchmark=classification) (default: None)
```


## autometa_autometa-binning

### Tool Description
Perform marker gene guided binning of metagenome contigs using annotations (when available) of sequence composition, coverage and homology.

### Metadata
- **Docker Image**: quay.io/biocontainers/autometa:2.2.3--pyh7e72e81_0
- **Homepage**: https://github.com/KwanLab/Autometa
- **Package**: https://anaconda.org/channels/bioconda/packages/autometa/overview
- **Validation**: PASS

### Original Help Text
```text
usage: autometa-binning [-h] --kmers filepath --coverages filepath
                        --gc-content filepath --markers filepath
                        --output-binning filepath [--output-main filepath]
                        [--clustering-method {dbscan,hdbscan}]
                        [--completeness 0 < float <= 100]
                        [--purity 0 < float <= 100] [--cov-stddev-limit float]
                        [--gc-stddev-limit float] [--taxonomy filepath]
                        [--starting-rank {superkingdom,phylum,class,order,family,genus,species}]
                        [--reverse-ranks]
                        [--rank-filter {superkingdom,phylum,class,order,family,genus,species}]
                        [--rank-name-filter RANK_NAME_FILTER] [--verbose]
                        [--cpus int]

Perform marker gene guided binning of metagenome contigs using annotations
(when available) of sequence composition, coverage and homology.

options:
  -h, --help            show this help message and exit
  --kmers filepath      Path to embedded k-mers table (default: None)
  --coverages filepath  Path to metagenome coverages table (default: None)
  --gc-content filepath
                        Path to metagenome GC contents table (default: None)
  --markers filepath    Path to Autometa annotated markers table (default:
                        None)
  --output-binning filepath
                        Path to write Autometa binning results (default: None)
  --output-main filepath
                        Path to write Autometa main table used during/after
                        binning (default: None)
  --clustering-method {dbscan,hdbscan}
                        Clustering algorithm to use for recursive binning.
                        (default: dbscan)
  --completeness 0 < float <= 100
                        completeness cutoff to retain cluster. e.g. cluster
                        completeness >= `completeness` (default: 20.0)
  --purity 0 < float <= 100
                        purity cutoff to retain cluster. e.g. cluster purity
                        >= `purity` (default: 95.0)
  --cov-stddev-limit float
                        coverage standard deviation limit to retain cluster
                        e.g. cluster coverage standard deviation <= `cov-
                        stddev-limit` (default: 25.0)
  --gc-stddev-limit float
                        GC content standard deviation limit to retain cluster
                        e.g. cluster GC content standard deviation <= `gc-
                        content-stddev-limit` (default: 5.0)
  --taxonomy filepath   Path to Autometa assigned taxonomies table (default:
                        None)
  --starting-rank {superkingdom,phylum,class,order,family,genus,species}
                        Canonical rank at which to begin subsetting taxonomy
                        (default: superkingdom)
  --reverse-ranks       Reverse order at which to split taxonomy by canonical-
                        rank. When `--reverse-ranks` is given, contigs will be
                        split in order of species, genus, family, order,
                        class, phylum, superkingdom. (default: False)
  --rank-filter {superkingdom,phylum,class,order,family,genus,species}
                        Taxonomy column canonical rank to subset by provided
                        value of `--rank-name-filter` (default: superkingdom)
  --rank-name-filter RANK_NAME_FILTER
                        Only retrieve contigs with this name corresponding to
                        `--rank-filter` column (default: bacteria)
  --verbose             log debug information (default: False)
  --cpus int            Number of cores to use by clustering method (default
                        will try to use as many as are available) (default:
                        -1)
```


## autometa_autometa-binning-ldm

### Tool Description
Autometa Large-data-mode binning by contig set selection using max-partition-size

### Metadata
- **Docker Image**: quay.io/biocontainers/autometa:2.2.3--pyh7e72e81_0
- **Homepage**: https://github.com/KwanLab/Autometa
- **Package**: https://anaconda.org/channels/bioconda/packages/autometa/overview
- **Validation**: PASS

### Original Help Text
```text
usage: autometa-binning-ldm [-h] --kmers filepath --coverages filepath
                            --gc-content filepath --markers filepath
                            --taxonomy filepath --output-binning filepath
                            [--output-main filepath]
                            [--clustering-method {dbscan,hdbscan}]
                            [--completeness 0 < float <= 100]
                            [--purity 0 < float <= 100]
                            [--cov-stddev-limit float]
                            [--gc-stddev-limit float]
                            [--norm-method {am_clr,ilr,clr}] [--pca-dims int]
                            [--embed-method {bhsne,umap,sksne,trimap}]
                            [--embed-dims int] [--max-partition-size int]
                            [--starting-rank {superkingdom,phylum,class,order,family,genus,species}]
                            [--reverse-ranks] [--cache dirpath]
                            [--binning-checkpoints filepath]
                            [--rank-filter {superkingdom,phylum,class,order,family,genus,species}]
                            [--rank-name-filter RANK_NAME_FILTER] [--verbose]
                            [--cpus int]

Autometa Large-data-mode binning by contig set selection using max-partition-
size

options:
  -h, --help            show this help message and exit
  --kmers filepath      Path to k-mer counts table (default: None)
  --coverages filepath  Path to metagenome coverages table (default: None)
  --gc-content filepath
                        Path to metagenome GC contents table (default: None)
  --markers filepath    Path to Autometa annotated markers table (default:
                        None)
  --taxonomy filepath   Path to Autometa assigned taxonomies table (default:
                        None)
  --output-binning filepath
                        Path to write Autometa binning results (default: None)
  --output-main filepath
                        Path to write Autometa main table used during/after
                        binning (default: None)
  --clustering-method {dbscan,hdbscan}
                        Clustering algorithm to use for recursive binning.
                        (default: dbscan)
  --completeness 0 < float <= 100
                        completeness cutoff to retain cluster. e.g. cluster
                        completeness >= `completeness` (default: 20.0)
  --purity 0 < float <= 100
                        purity cutoff to retain cluster. e.g. cluster purity
                        >= `purity` (default: 95.0)
  --cov-stddev-limit float
                        coverage standard deviation limit to retain cluster
                        e.g. cluster coverage standard deviation <= `cov-
                        stddev-limit` (default: 25.0)
  --gc-stddev-limit float
                        GC content standard deviation limit to retain cluster
                        e.g. cluster GC content standard deviation <= `gc-
                        content-stddev-limit` (default: 5.0)
  --norm-method {am_clr,ilr,clr}
                        kmer normalization method to use on kmer counts
                        (default: am_clr)
  --pca-dims int        PCA dimensions to reduce normalized kmer frequencies
                        prior to embedding (default: 50)
  --embed-method {bhsne,umap,sksne,trimap}
                        kmer embedding method to use on normalized kmer
                        frequencies (default: bhsne)
  --embed-dims int      Embedding dimensions to reduce normalized kmers table
                        after PCA. (default: 2)
  --max-partition-size int
                        Maximum number of contigs to consider for a recursive
                        binning batch. (default: 10000)
  --starting-rank {superkingdom,phylum,class,order,family,genus,species}
                        Canonical rank at which to begin subsetting taxonomy
                        (default: superkingdom)
  --reverse-ranks       Reverse order at which to split taxonomy by canonical-
                        rank. When `--reverse-ranks` is given, contigs will be
                        split in order of species, genus, family, order,
                        class, phylum, superkingdom. (default: False)
  --cache dirpath       Directory to store itermediate checkpoint files during
                        binning (If this is provided and the job fails, the
                        script will attempt to begin from the checkpoints in
                        this cache directory). (default: None)
  --binning-checkpoints filepath
                        File path to store itermediate contig binning results
                        (The `--cache` argument is required for this feature).
                        If `--cache` is provided without this argument, a
                        binning checkpoints file will be created. (default:
                        None)
  --rank-filter {superkingdom,phylum,class,order,family,genus,species}
                        Taxonomy column canonical rank to subset by provided
                        value of `--rank-name-filter` (default: superkingdom)
  --rank-name-filter RANK_NAME_FILTER
                        Only retrieve contigs with this name corresponding to
                        `--rank-filter` column (default: bacteria)
  --verbose             log debug information (default: False)
  --cpus int            Number of cores to use by clustering method (default
                        will try to use as many as are available) (default:
                        -1)
```


## autometa_autometa-binning-ldm-loginfo

### Tool Description
Retrieve clustering time stats from autometa.binning.recursive_dbscan err log

### Metadata
- **Docker Image**: quay.io/biocontainers/autometa:2.2.3--pyh7e72e81_0
- **Homepage**: https://github.com/KwanLab/Autometa
- **Package**: https://anaconda.org/channels/bioconda/packages/autometa/overview
- **Validation**: PASS

### Original Help Text
```text
usage: autometa-binning-ldm-loginfo [-h] --log LOG [--outdir OUTDIR]
                                    [--prefix PREFIX] [--overwrite]

Retrieve clustering time stats from autometa.binning.recursive_dbscan err log

options:
  -h, --help       show this help message and exit
  --log LOG        Path to binning log file (If using slurm, this is typically
                   stderr output path) (default: None)
  --outdir OUTDIR  Directory to write runtime information tables (default: .)
  --prefix PREFIX  Prefix to prepend to runtime information tables (Do not use
                   a directory path as a prefix) (default: None)
  --overwrite      Overwrite existing log info table if it already exists
                   (default: False)
```


## autometa_autometa-binning-summary

### Tool Description
Summarize Autometa results writing genome fastas and their respective taxonomies/assembly metrics for respective metagenomes

### Metadata
- **Docker Image**: quay.io/biocontainers/autometa:2.2.3--pyh7e72e81_0
- **Homepage**: https://github.com/KwanLab/Autometa
- **Package**: https://anaconda.org/channels/bioconda/packages/autometa/overview
- **Validation**: PASS

### Original Help Text
```text
usage: autometa-binning-summary [-h] --binning-main filepath --markers
                                filepath --metagenome filepath
                                [--dbdir dirpath] [--dbtype {ncbi,gtdb}]
                                [--binning-column str] --output-stats filepath
                                --output-taxonomy filepath --output-metabins
                                dirpath

Summarize Autometa results writing genome fastas and their respective
taxonomies/assembly metrics for respective metagenomes

options:
  -h, --help            show this help message and exit
  --binning-main filepath
                        Path to Autometa binning main table (output from
                        --binning-main argument) (default: None)
  --markers filepath    Path to annotated markers respective to domain
                        (bacteria or archaea) binned (default: None)
  --metagenome filepath
                        Path to metagenome assembly (default: None)
  --dbdir dirpath       Path to user taxonomy database directory (Required for
                        retrieving metabin taxonomies) (default: None)
  --dbtype {ncbi,gtdb}  Taxonomy database type to use (NOTE: must correspond
                        to the same database type used during contig taxon
                        assignment.) (default: ncbi)
  --binning-column str  Binning column to use for grouping metabins (default:
                        cluster)
  --output-stats filepath
                        Path to write metabins stats table (default: None)
  --output-taxonomy filepath
                        Path to write metabins taxonomies table (default:
                        None)
  --output-metabins dirpath
                        Path to output directory. (Directory must not exist.
                        This directory will be created.) (default: None)
```


## autometa_autometa-cami-format

### Tool Description
Format Autometa results to biobox format for compatibility with CAMI. All results tables must contain a 'contig' column and either 'taxid', or 'cluster' column.

### Metadata
- **Docker Image**: quay.io/biocontainers/autometa:2.2.3--pyh7e72e81_0
- **Homepage**: https://github.com/KwanLab/Autometa
- **Package**: https://anaconda.org/channels/bioconda/packages/autometa/overview
- **Validation**: PASS

### Original Help Text
```text
usage: autometa-cami-format [-h] --sample-predictions SAMPLE_PREDICTIONS
                            --sample-id SAMPLE_ID --results-type
                            {profiling,genome_binning,taxon_binning}
                            [--bioboxes-version BIOBOXES_VERSION] --output
                            OUTPUT

Format Autometa results to biobox format for compatibility with CAMI. Note:
All results tables must contain a 'contig' column and either 'taxid', or
'cluster' column. bioboxes formatted columns will be written for both if both
are within the provided results.

options:
  -h, --help            show this help message and exit
  --sample-predictions SAMPLE_PREDICTIONS
                        Path of autometa table containing relevant `results-
                        type` columns (default: None)
  --sample-id SAMPLE_ID
                        CAMI Sample ID corresponding to `sample-predictions`
                        (default: None)
  --results-type {profiling,genome_binning,taxon_binning}
                        Type of results for formatter to convert (default:
                        None)
  --bioboxes-version BIOBOXES_VERSION
                        bioboxes binning output format. For more info see: htt
                        ps://github.com/bioboxes/rfc/blob/4bb19a633a6a969c2332
                        f1f298852114c5f89b1b/data-format/binning.mkd (default:
                        0.9.0)
  --output OUTPUT       Path to write biobox formatted results (default: None)
```


## autometa_autometa-config

### Tool Description
Update Autometa configuration using provided arguments

### Metadata
- **Docker Image**: quay.io/biocontainers/autometa:2.2.3--pyh7e72e81_0
- **Homepage**: https://github.com/KwanLab/Autometa
- **Package**: https://anaconda.org/channels/bioconda/packages/autometa/overview
- **Validation**: PASS

### Original Help Text
```text
usage: autometa-config [-h] [--section {environ,databases,ncbi,markers,gtdb}]
                       [--option OPTION] [--value VALUE] [--print]

Update Autometa configuration using provided arguments

options:
  -h, --help            show this help message and exit

Logging:
  --print               Print configuration without updating

Updating:
  --section {environ,databases,ncbi,markers,gtdb}
                        config section to update
  --option OPTION       option in `--section` to update
  --value VALUE         Value to update `--option`
```


## autometa_autometa-coverage

### Tool Description
Construct contig coverage table given an input `assembly` and provided files: forward/reverse reads, SAM, BAM or BED alignments, or SPAdes contig names.

### Metadata
- **Docker Image**: quay.io/biocontainers/autometa:2.2.3--pyh7e72e81_0
- **Homepage**: https://github.com/KwanLab/Autometa
- **Package**: https://anaconda.org/channels/bioconda/packages/autometa/overview
- **Validation**: PASS

### Original Help Text
```text
usage: autometa-coverage [-h] -f ASSEMBLY [-1 [FWD_READS ...]]
                         [-2 [REV_READS ...]] [-U [SE_READS ...]] [--sam SAM]
                         [--bam BAM] [--bed BED] [--cpus CPUS] [--from-spades]
                         --out OUT

    Construct contig coverage table given an input `assembly` and provided files.

    Provided files may include one from the list below:
    1. `fwd_reads` and/or `rev_reads` and/or `se_reads`
    2. `sam` - alignment of `assembly` and `reads` in SAM format
    3. `bam` - alignment of `assembly` and `reads` in BAM format
    4. `bed` - alignment of `assembly` and `reads` in BED format
    

options:
  -h, --help            show this help message and exit
  -f ASSEMBLY, --assembly ASSEMBLY
                        </path/to/metagenome.fasta>
  -1 [FWD_READS ...], --fwd-reads [FWD_READS ...]
                        </path/to/forwards-reads.fastq>
  -2 [REV_READS ...], --rev-reads [REV_READS ...]
                        </path/to/reverse-reads.fastq>
  -U [SE_READS ...], --se-reads [SE_READS ...]
                        </path/to/single-end-reads.fastq>
  --sam SAM             </path/to/alignments.sam>
  --bam BAM             </path/to/alignments.bam>
  --bed BED             </path/to/alignments.bed>
  --cpus CPUS           Num processors to use. (default: 20)
  --from-spades         Extract k-mer coverages from contig IDs. (Input
                        assembly is output from SPAdes)
  --out OUT             Path to write a table of coverages
```


## autometa_autometa-download-dataset

### Tool Description
Download a simulated community file from google drive to a specified output directory

### Metadata
- **Docker Image**: quay.io/biocontainers/autometa:2.2.3--pyh7e72e81_0
- **Homepage**: https://github.com/KwanLab/Autometa
- **Package**: https://anaconda.org/channels/bioconda/packages/autometa/overview
- **Validation**: PASS

### Original Help Text
```text
usage: autometa-download-dataset [-h] --community-type
                                 {synthetic,simulated,all} --community-sizes
                                 {78Mbp,156Mbp,312Mbp,625Mbp,1250Mbp,2500Mbp,5000Mbp,10000Mbp,all}
                                 [{78Mbp,156Mbp,312Mbp,625Mbp,1250Mbp,2500Mbp,5000Mbp,10000Mbp,all} ...]
                                 --file-names
                                 {README.md,reference_assignments.tsv.gz,metagenome.fna.gz,master.tsv.gz,control_reads.tsv.gz,control_contigs.tsv.gz,unclustered_recruitment.tsv.gz,binning.tsv.gz,taxonomy.tsv.gz,lengths.tsv.gz,coverages.tsv.gz,gc_content.tsv.gz,kmers.embedded.tsv.gz,kmers.tsv.gz,markers.tsv.gz,Bacteria.fna.gz,orfs.faa.gz,metagenome.filtered.fna.gz,hmmscan.tsv.gz,forward_reads.fastq.gz,reverse_reads.fastq.gz,all}
                                 [{README.md,reference_assignments.tsv.gz,metagenome.fna.gz,master.tsv.gz,control_reads.tsv.gz,control_contigs.tsv.gz,unclustered_recruitment.tsv.gz,binning.tsv.gz,taxonomy.tsv.gz,lengths.tsv.gz,coverages.tsv.gz,gc_content.tsv.gz,kmers.embedded.tsv.gz,kmers.tsv.gz,markers.tsv.gz,Bacteria.fna.gz,orfs.faa.gz,metagenome.filtered.fna.gz,hmmscan.tsv.gz,forward_reads.fastq.gz,reverse_reads.fastq.gz,all} ...]
                                 --dir-path DIR_PATH [--host HOST]

Download a simulated community file from google drive to a specified output
directory

options:
  -h, --help            show this help message and exit
  --community-type {synthetic,simulated,all}
                        specify synthetic or simulated communities (currently
                        only simulated is available)
  --community-sizes {78Mbp,156Mbp,312Mbp,625Mbp,1250Mbp,2500Mbp,5000Mbp,10000Mbp,all} [{78Mbp,156Mbp,312Mbp,625Mbp,1250Mbp,2500Mbp,5000Mbp,10000Mbp,all} ...]
                        specify a community size to download from
  --file-names {README.md,reference_assignments.tsv.gz,metagenome.fna.gz,master.tsv.gz,control_reads.tsv.gz,control_contigs.tsv.gz,unclustered_recruitment.tsv.gz,binning.tsv.gz,taxonomy.tsv.gz,lengths.tsv.gz,coverages.tsv.gz,gc_content.tsv.gz,kmers.embedded.tsv.gz,kmers.tsv.gz,markers.tsv.gz,Bacteria.fna.gz,orfs.faa.gz,metagenome.filtered.fna.gz,hmmscan.tsv.gz,forward_reads.fastq.gz,reverse_reads.fastq.gz,all} [{README.md,reference_assignments.tsv.gz,metagenome.fna.gz,master.tsv.gz,control_reads.tsv.gz,control_contigs.tsv.gz,unclustered_recruitment.tsv.gz,binning.tsv.gz,taxonomy.tsv.gz,lengths.tsv.gz,coverages.tsv.gz,gc_content.tsv.gz,kmers.embedded.tsv.gz,kmers.tsv.gz,markers.tsv.gz,Bacteria.fna.gz,orfs.faa.gz,metagenome.filtered.fna.gz,hmmscan.tsv.gz,forward_reads.fastq.gz,reverse_reads.fastq.gz,all} ...]
                        specify a file name to download
  --dir-path DIR_PATH   specify a folder to start the download (several
                        directories will be generated within this folder)
  --host HOST           IP address to ping when checking internet
                        connectivity. Note: Will attempt to connect to port 53
                        on host address (Default is google.com)
```


## autometa_autometa-hmmsearch-filter

### Tool Description
Filters domtblout generated from hmmsearch using provided cutoffs

### Metadata
- **Docker Image**: quay.io/biocontainers/autometa:2.2.3--pyh7e72e81_0
- **Homepage**: https://github.com/KwanLab/Autometa
- **Package**: https://anaconda.org/channels/bioconda/packages/autometa/overview
- **Validation**: PASS

### Original Help Text
```text
usage: autometa-hmmsearch-filter [-h] --domtblout DOMTBLOUT --cutoffs CUTOFFS
                                 --seqdb SEQDB --out OUT

Filters domtblout generated from hmmsearch using provided cutoffs

options:
  -h, --help            show this help message and exit
  --domtblout DOMTBLOUT
                        Path to domtblout generated from hmmsearch -domtblout
                        <domtblout> ... <hmmfile> <seqdb>
  --cutoffs CUTOFFS     Path to cutoffs corresponding to hmmfile used with
                        hmmsearch <hmmfile> <seqdb>
  --seqdb SEQDB         Path to orfs seqdb used as input to hmmsearch ...
                        <hmmfile> <seqdb>
  --out OUT             Path to write table of markers passing provided
                        cutoffs
```


## autometa_autometa-kmers

### Tool Description
Count k-mer frequencies of given `fasta`, then optionally normalize and embed them

### Metadata
- **Docker Image**: quay.io/biocontainers/autometa:2.2.3--pyh7e72e81_0
- **Homepage**: https://github.com/KwanLab/Autometa
- **Package**: https://anaconda.org/channels/bioconda/packages/autometa/overview
- **Validation**: PASS

### Original Help Text
```text
usage: autometa-kmers [-h] [--fasta filepath] [--kmers filepath] [--size int]
                      [--norm-output filepath]
                      [--norm-method {ilr,clr,am_clr}] [--pca-dimensions int]
                      [--embedding-output filepath]
                      [--embedding-method {sksne,bhsne,umap,densmap,trimap}]
                      [--embedding-dimensions int] [--force] [--cpus int]
                      [--seed int]

Count k-mer frequencies of given `fasta`

options:
  -h, --help            show this help message and exit
  --fasta filepath      Metagenomic assembly fasta file (default: None)
  --kmers filepath      K-mers frequency tab-delimited table (will skip if
                        file exists) (default: None)
  --size int            k-mer size in bp (default: 5)
  --norm-output filepath
                        Path to normalized kmers table (will skip if file
                        exists) (default: None)
  --norm-method {ilr,clr,am_clr}
                        Normalization method to transform kmer counts prior to
                        PCA and embedding. ilr: isometric log-ratio transform
                        (scikit-bio implementation). clr: center log-ratio
                        transform (scikit-bio implementation). am_clr: center
                        log-ratio transform (Autometa implementation).
                        (default: am_clr)
  --pca-dimensions int  Number of dimensions to reduce to PCA feature space
                        after normalization and prior to embedding (NOTE:
                        Setting to zero will skip PCA step) (default: 50)
  --embedding-output filepath
                        Path to write embedded kmers table (will skip if file
                        exists) (default: None)
  --embedding-method {sksne,bhsne,umap,densmap,trimap}
                        embedding method [sk,bh]sne are corresponding
                        implementations from scikit-learn and tsne,
                        respectively. (default: bhsne)
  --embedding-dimensions int
                        Number of dimensions of which to reduce k-mer
                        frequencies (default: 2)
  --force               Whether to overwrite existing annotations (default:
                        False)
  --cpus int            num. processors to use. (default: 20)
  --seed int            Seed to set random state for dimension reduction
                        determinism. (default: 42)
```


## autometa_autometa-length-filter

### Tool Description
This script handles filtering by length and can calculate various metagenome statistics.

### Metadata
- **Docker Image**: quay.io/biocontainers/autometa:2.2.3--pyh7e72e81_0
- **Homepage**: https://github.com/KwanLab/Autometa
- **Package**: https://anaconda.org/channels/bioconda/packages/autometa/overview
- **Validation**: PASS

### Original Help Text
```text
usage: autometa-length-filter [-h] --assembly filepath --output-fasta filepath
                              [--output-stats filepath]
                              [--output-gc-content filepath] [--cutoff int]
                              [--force] [--verbose]

This script handles filtering by length and can calculate various metagenome
statistics.

options:
  -h, --help            show this help message and exit
  --assembly filepath   Path to metagenome assembly (nucleotide fasta).
                        (default: None)
  --output-fasta filepath
                        Path to output length-filtered assembly fasta file.
                        (default: None)
  --output-stats filepath
                        Path to output assembly stats table. (default: None)
  --output-gc-content filepath
                        Path to output assembly contigs' GC content and
                        length. (default: None)
  --cutoff int          Cutoff to apply to length filter (default: 3000)
  --force               Overwrite existing files (default: False)
  --verbose             Log more information to terminal. (default: False)
```


## autometa_autometa-markers

### Tool Description
Annotate ORFs with kingdom-specific marker information

### Metadata
- **Docker Image**: quay.io/biocontainers/autometa:2.2.3--pyh7e72e81_0
- **Homepage**: https://github.com/KwanLab/Autometa
- **Package**: https://anaconda.org/channels/bioconda/packages/autometa/overview
- **Validation**: PASS

### Original Help Text
```text
usage: autometa-markers [-h] [--orfs ORFS] [--kingdom {bacteria,archaea}]
                        [--hmmscan HMMSCAN] [--out OUT] [--dbdir DBDIR]
                        [--hmmdb HMMDB] [--cutoffs CUTOFFS] [--force]
                        [--parallel] [--gnu-parallel] [--cpus CPUS]
                        [--seed SEED]

Annotate ORFs with kingdom-specific marker information

options:
  -h, --help            show this help message and exit
  --orfs ORFS           Path to a fasta file containing amino acid sequences
                        of open reading frames (default: None)
  --kingdom {bacteria,archaea}
                        kingdom to search for markers (default: bacteria)
  --hmmscan HMMSCAN     Path to hmmscan output table containing the respective
                        `kingdom` single-copy marker annotations. (default:
                        None)
  --out OUT             Path to write filtered annotated markers corresponding
                        to `kingdom`. (default: None)
  --dbdir DBDIR         Path to directory containing the single-copy marker
                        HMM databases. (default: ./autometa/databases/markers)
  --hmmdb HMMDB         Path to single-copy marker HMM databases. (default:
                        None)
  --cutoffs CUTOFFS     Path to single-copy marker cutoff tsv. (default: None)
  --force               Whether to overwrite existing provided annotations.
                        (default: False)
  --parallel            Whether to use hmmscan parallel option. (default:
                        False)
  --gnu-parallel        Whether to run hmmscan using GNU parallel. (default:
                        False)
  --cpus CPUS           Number of cores to use for parallel execution.
                        (default: 8)
  --seed SEED           Seed to set random state for hmmscan. (default: 42)
```


## autometa_autometa-orfs

### Tool Description
Calls ORFs with provided input assembly

### Metadata
- **Docker Image**: quay.io/biocontainers/autometa:2.2.3--pyh7e72e81_0
- **Homepage**: https://github.com/KwanLab/Autometa
- **Package**: https://anaconda.org/channels/bioconda/packages/autometa/overview
- **Validation**: PASS

### Original Help Text
```text
usage: autometa-orfs [-h] --assembly filepath --output-nucls filepath
                     --output-prots filepath [--cpus int] [--force]

Calls ORFs with provided input assembly

options:
  -h, --help            show this help message and exit
  --assembly filepath   Path to metagenome assembly (default: None)
  --output-nucls filepath
                        Path to output nucleotide ORFs (default: None)
  --output-prots filepath
                        Path to output amino-acid ORFs (default: None)
  --cpus int            Number of processors to use. (If more than one this
                        will parallelize prodigal using GNU parallel)
                        (default: 1)
  --force               Overwrite existing output ORF filepaths (default:
                        False)
```


## autometa_autometa-setup-gtdb

### Tool Description
Combine GTDB representative genome protein files (*_protein.faa.gz) and format them as a diamond database

### Metadata
- **Docker Image**: quay.io/biocontainers/autometa:2.2.3--pyh7e72e81_0
- **Homepage**: https://github.com/KwanLab/Autometa
- **Package**: https://anaconda.org/channels/bioconda/packages/autometa/overview
- **Validation**: PASS

### Original Help Text
```text
usage: autometa-setup-gtdb [-h] --reps-faa REPS_FAA --dbdir DBDIR
                           [--cpus CPUS]

options:
  -h, --help           show this help message and exit
  --reps-faa REPS_FAA  Path to directory containing GTDB ref genome animo acid
                       data sequences. Can be tarballed.
  --dbdir DBDIR        Path to output GTDB database directory
  --cpus CPUS          Number of cpus to use for diamond-formatting GTDB
                       database
```


## autometa_autometa-taxonomy

### Tool Description
Filter metagenome by taxonomy.

### Metadata
- **Docker Image**: quay.io/biocontainers/autometa:2.2.3--pyh7e72e81_0
- **Homepage**: https://github.com/KwanLab/Autometa
- **Package**: https://anaconda.org/channels/bioconda/packages/autometa/overview
- **Validation**: PASS

### Original Help Text
```text
usage: autometa-taxonomy [-h] --votes filepath --assembly filepath --output
                         dirpath [--prefix str]
                         [--split-rank-and-write {superkingdom,phylum,class,order,family,genus,species}]
                         [--dbdir dirpath] [--dbtype {ncbi,gtdb}]

Filter metagenome by taxonomy.

options:
  -h, --help            show this help message and exit
  --votes filepath      Input path to voted taxids table. should contain (at
                        least) 'contig' and 'taxid' columns (default: None)
  --assembly filepath   Path to metagenome assembly (nucleotide fasta).
                        (default: None)
  --output dirpath      Output directory to write specified canonical ranks
                        fasta files and taxon-binning results table (default:
                        None)
  --prefix str          prefix to use for each file written e.g.
                        `prefix`.taxonomy.tsv. Note: Do not use a directory
                        prefix. (default: None)
  --split-rank-and-write {superkingdom,phylum,class,order,family,genus,species}
                        If specified, will split contigs by provided
                        canonical-rank column then write to `output` directory
                        (default: None)
  --dbdir dirpath       Path to taxonomy database directory. (default:
                        ./autometa/databases/ncbi)
  --dbtype {ncbi,gtdb}  Taxonomy database to use (default: ncbi)
```


## autometa_autometa-taxonomy-lca

### Tool Description
Script to determine Lowest Common Ancestor

### Metadata
- **Docker Image**: quay.io/biocontainers/autometa:2.2.3--pyh7e72e81_0
- **Homepage**: https://github.com/KwanLab/Autometa
- **Package**: https://anaconda.org/channels/bioconda/packages/autometa/overview
- **Validation**: PASS

### Original Help Text
```text
usage: autometa-taxonomy-lca [-h] --blast filepath [--dbdir dirpath]
                             [--dbtype {ncbi,gtdb}] --lca-output filepath
                             [--sseqid2taxid-output filepath]
                             [--lca-error-taxids filepath] [--verbose]
                             [--force] [--cache dirpath]
                             [--only-prepare-cache] [--force-cache-overwrite]

Script to determine Lowest Common Ancestor

options:
  -h, --help            show this help message and exit
  --blast filepath      Path to BLAST results table respective to `orfs`.
                        (Note: The table provided must be in outfmt=6)
                        (default: None)
  --dbdir dirpath       Path to taxonomy databases directory. (default:
                        ./autometa/databases/ncbi)
  --dbtype {ncbi,gtdb}  Taxonomy database to use (default: ncbi)
  --lca-output filepath
                        Path to write LCA results. (default: None)
  --sseqid2taxid-output filepath
                        Path to write qseqids sseqids to taxids translations
                        table (default: None)
  --lca-error-taxids filepath
                        Path to write table of blast table qseqids that were
                        assigned root due to a missing taxid (default: None)
  --verbose             Add verbosity to logging stream. (default: False)
  --force               Force overwrite if results already exist. (default:
                        False)
  --cache dirpath       Path to cache pickled LCA database objects. (default:
                        None)
  --only-prepare-cache  Only prepare the LCA database objects and write to
                        provided --cache parameter (default: False)
  --force-cache-overwrite
                        Force overwrite if results already exist. (default:
                        False)
```


## autometa_autometa-taxonomy-majority-vote

### Tool Description
Script to assign taxonomy via a modified majority voting algorithm.

### Metadata
- **Docker Image**: quay.io/biocontainers/autometa:2.2.3--pyh7e72e81_0
- **Homepage**: https://github.com/KwanLab/Autometa
- **Package**: https://anaconda.org/channels/bioconda/packages/autometa/overview
- **Validation**: PASS

### Original Help Text
```text
usage: autometa-taxonomy-majority-vote [-h] --lca LCA --output OUTPUT
                                       [--dbdir DBDIR] [--dbtype {ncbi,gtdb}]
                                       [--orfs ORFS] [--verbose]

Script to assign taxonomy via a modified majority voting algorithm.

options:
  -h, --help            show this help message and exit
  --lca LCA             Path to LCA results table. (default: None)
  --output OUTPUT       Path to write voted taxid results table. (default:
                        None)
  --dbdir DBDIR         Path to taxonomy database directory. (default:
                        ./autometa/databases/ncbi)
  --dbtype {ncbi,gtdb}  Taxonomy database to use (default: ncbi)
  --orfs ORFS           Path to ORFs fasta containing amino-acid sequences to
                        be annotated. (Only required for prodigal version <
                        2.6) (default: None)
  --verbose             Add verbosity to logging stream. (default: False)
```


## autometa_autometa-unclustered-recruitment

### Tool Description
Recruit unclustered contigs given metagenome annotations and Autometa binning results. All tables must contain a 'contig' column.

### Metadata
- **Docker Image**: quay.io/biocontainers/autometa:2.2.3--pyh7e72e81_0
- **Homepage**: https://github.com/KwanLab/Autometa
- **Package**: https://anaconda.org/channels/bioconda/packages/autometa/overview
- **Validation**: PASS

### Original Help Text
```text
usage: autometa-unclustered-recruitment [-h] --kmers KMERS --coverage COVERAGE
                                        --binning BINNING --markers MARKERS
                                        --output-binning OUTPUT_BINNING
                                        [--output-main OUTPUT_MAIN]
                                        [--output-features OUTPUT_FEATURES]
                                        [--taxonomy TAXONOMY]
                                        [--taxa-dimensions TAXA_DIMENSIONS]
                                        [--additional-features [ADDITIONAL_FEATURES ...]]
                                        [--confidence CONFIDENCE]
                                        [--num-classifications NUM_CLASSIFICATIONS]
                                        [--classifier {decision_tree,random_forest}]
                                        [--kmer-dimensions KMER_DIMENSIONS]
                                        [--seed SEED]

Recruit unclustered contigs given metagenome annotations and Autometa binning
results. Note: All tables must contain a 'contig' column to be used as the
unique table index

options:
  -h, --help            show this help message and exit
  --kmers KMERS         Path to normalized kmer frequencies table. (default:
                        None)
  --coverage COVERAGE   Path to coverage table. (default: None)
  --binning BINNING     Path to autometa binning output [will look for
                        col='cluster'] (default: None)
  --markers MARKERS     Path to domain-specific markers table. (default: None)
  --output-binning OUTPUT_BINNING
                        Path to output unclustered recruitment table.
                        (default: None)
  --output-main OUTPUT_MAIN
                        Path to write Autometa main table used during/after
                        unclustered recruitment. (default: None)
  --output-features OUTPUT_FEATURES
                        Path to write Autometa features table used during
                        unclustered recruitment. (default: None)
  --taxonomy TAXONOMY   Path to taxonomy table. (default: None)
  --taxa-dimensions TAXA_DIMENSIONS
                        Num of dimensions to reduce taxonomy encodings
                        (default: None)
  --additional-features [ADDITIONAL_FEATURES ...]
                        Path to additional features with which to add to
                        classifier training data. (default: [])
  --confidence CONFIDENCE
                        Percent confidence to allow classification (confidence
                        = num. consistent predictions/num. classifications)
                        (default: 1.0)
  --num-classifications NUM_CLASSIFICATIONS
                        Num classifications for predicting/validating contig
                        cluster recruitment (default: 10)
  --classifier {decision_tree,random_forest}
                        classifier to use for recruitment of contigs (default:
                        decision_tree)
  --kmer-dimensions KMER_DIMENSIONS
                        Num of dimensions to reduce normalized k-mer
                        frequencies (default: 50)
  --seed SEED           Seed to use for RandomState when initializing
                        classifiers. (default: 42)
```


## autometa_autometa-update-databases

### Tool Description
Main script to configure Autometa database dependencies. With no arguments, downloads/formats databases into the default databases directory.

### Metadata
- **Docker Image**: quay.io/biocontainers/autometa:2.2.3--pyh7e72e81_0
- **Homepage**: https://github.com/KwanLab/Autometa
- **Package**: https://anaconda.org/channels/bioconda/packages/autometa/overview
- **Validation**: PASS

### Original Help Text
```text
usage: autometa-update-databases [-h] [--config CONFIG] [--dryrun]
                                 [--update-all] [--update-markers]
                                 [--update-ncbi] [--update-gtdb]
                                 [--check-dependencies] [--no-checksum]
                                 [--nproc NPROC] [--out OUT]

Main script to configure Autometa database dependencies.

options:
  -h, --help            show this help message and exit
  --config CONFIG       </path/to/input/database.config> (default:
                        /usr/local/lib/python3.12/site-
                        packages/autometa/config/default.config)
  --dryrun              Log configuration actions but do not perform them.
                        (default: False)
  --update-all          Update all out-of-date databases. (NOTE: Does not
                        update GTDB) (default: False)
  --update-markers      Update out-of-date markers databases. (default: False)
  --update-ncbi         Update out-of-date ncbi databases. (default: False)
  --update-gtdb         Download and format the user-configured GTDB release
                        databases (default: False)
  --check-dependencies  Check database dependencies are satisfied. (default:
                        False)
  --no-checksum         Do not perform remote checksum comparisons to validate
                        databases are up-to-date. (default: False)
  --nproc NPROC         num. cpus to use for DB formatting. (default: 20)
  --out OUT             </path/to/output/database.config> (default: None)

By default, with no arguments, will download/format databases into default
databases directory.
```


## Metadata
- **Skill**: generated
