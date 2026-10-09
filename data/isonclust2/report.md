# isonclust2 CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| isonclust2_cluster | PASS |  |
| isonclust2_dump | PASS |  |
| isonclust2_info | PASS |  |
| isonclust2_sort | PASS |  |

## isonclust2_sort

### Tool Description
Sort reads and write out batches for clustering.

### Metadata
- **Docker Image**: quay.io/biocontainers/isonclust2:2.3--hc9558a2_0
- **Homepage**: https://github.com/nanoporetech/isonclust2
- **Package**: https://anaconda.org/channels/bioconda/packages/isonclust2/overview
- **Validation**: PASS

### Original Help Text
```text
sort - sort reads and write out batches:
	-B --batch-size        Batch size in kilobases (default: 50000)
	-M --batch-max-seq     Maximum number of sequences per batch (default: 3000).
	-k --kmer-size         Kmer size (default: 11).
	-w --window-size       Window size (default: 15).
	-m --min-shared        Minimum number of minimizers shared between read and cluster (default: 5).
	-q --min-qual          Minimum average quality value (default: 7.0).
	-x --mode  Clustering mode:
	           * sahlin (default): use minimizers first, alignment second 
	           * fast: use minimizers only
	           * furious: always use alignment
	-g --low-cons-size     Use all sequences for consensus below this size (default: 20).
	-c --max-cons-size     Maximum number of sequences used for consensus (default: 150).
	-P --cons-period       Do not recalculate consensus after this many seuqences added (default: 500).
	-r --mapped-threshold  Minmum mapped fraction of read to be 	included in cluster (default: 0.65).
	-a --aligned-threshold Minimum aligned fraction of read to be included in cluster (default: 0.2).
	-f --min-fraction      Minimum fraction of minimizers shared compared to best hit, in order to continue mapping (default: 0.8).
	-p --min-prob-no-hits  Minimum probability for i consecutive 	minimizers to be different between read and representative (default: 0.1)
	-F --min-cls-size      Skip clusters smaller than this in the left batch (default: 3).
	-o --outfolder         Output folder (default: 	./isONclust2_batches).
	-h --help              Print help.
	-v --verbose           Verbose output.
	-d --debug             Print debug info.
	[positional argument]  Input fastq file (required).
```

## isonclust2_cluster

### Tool Description
Cluster and/or merge batches.

### Metadata
- **Docker Image**: quay.io/biocontainers/isonclust2:2.3--hc9558a2_0
- **Homepage**: https://github.com/nanoporetech/isonclust2
- **Package**: https://anaconda.org/channels/bioconda/packages/isonclust2/overview
- **Validation**: PASS

### Original Help Text
```text
cluster - cluster and/or merge batches:
	-l --left-batch        Left input batch (mandatory).
	-r --right-batch       Right input batch (optional).
	-o --outfile           Output batch.
	-x --mode  Clustering mode:
	           * sahlin (default): use minimizers first, alignment second 
	           * fast: use minimizers only
	           * furious: use alignment only
	-A --spoa-algo  spoa alignment algorithm:
	           * 0 (default): local
	           * 1 : global
	           * 1 : semi-global
	-z --min-purge         Purge minimizer database from output batch.
	-j --keep-seq          Do not purge non-representative sequences from output batches.
	-F --min-cls-size      Skip clusters smaller than this in the left batch.
	-v --verbose           Verbose output.
	-Q --quiet             Supress progress bar.
	-d --debug             Print debug info.
	-h --help              Print help.
```

## isonclust2_dump

### Tool Description
Dump a clustered batch.

### Metadata
- **Docker Image**: quay.io/biocontainers/isonclust2:2.3--hc9558a2_0
- **Homepage**: https://github.com/nanoporetech/isonclust2
- **Package**: https://anaconda.org/channels/bioconda/packages/isonclust2/overview
- **Validation**: PASS

### Original Help Text
```text
dump - dump clustered batch:
	-o --outdir            Output directory.
	-i --index             Index of sorted reads.
	-v --verbose           Verbose output.
	-d --debug             Print debug info.
	-h --help              Print help.
```

## isonclust2_info

### Tool Description
Print information about a serialized batch.

### Metadata
- **Docker Image**: quay.io/biocontainers/isonclust2:2.3--hc9558a2_0
- **Homepage**: https://github.com/nanoporetech/isonclust2
- **Package**: https://anaconda.org/channels/bioconda/packages/isonclust2/overview
- **Validation**: PASS

### Original Help Text
```text
info:
	-h --help              Print help.
	[positional argument]  Input serialized batch (required).
```

