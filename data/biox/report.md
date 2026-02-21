# biox CWL Generation Report

## biox

### Tool Description
BioX: A tool for biological sequence compression and analysis

### Metadata
- **Docker Image**: quay.io/biocontainers/biox:1.2.0--pyhdfd78af_0
- **Homepage**: https://github.com/TianMayCry9/BioX
- **Package**: https://anaconda.org/channels/bioconda/packages/biox/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/biox/overview
- **Total Downloads**: 1.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/TianMayCry9/BioX
- **Stars**: N/A
### Original Help Text
```text
usage: biox [-h] (-c | -d | -a) -i INPUT [-o OUTPUT]
            [-t {dna,rna,protein,file}] [-l {1,2,3,4,5,6,7,8,9}]
            [-ps {ignore,compress}] [--num_processes NUM_PROCESSES] [-p]
            [-s {2,3,4,5,6,7,8,9,10}] [--method {ncd,wbncd,lzjd}]
            [--tax {kingdom,phylum,class,order,family,genus,species}]
            [-k NEIGHBORS] [--alpha ALPHA] [--confidence CONFIDENCE] [-j JOBS]
            [--tree {single,average,weighted,complete}]

BioX: A tool for biological sequence compression and analysis

options:
  -h, --help            show this help message and exit
  -c, --compress        Compress mode
  -d, --decompress      Decompress mode
  -a, --analysis        Sequence analysis mode
  -i INPUT, --input INPUT
                        Input file/directory path
  -o OUTPUT, --output OUTPUT
                        Output file/directory path

Compression/Decompression options:
  -t {dna,rna,protein,file}, --type {dna,rna,protein,file}
                        Sequence type (dna/rna/protein) or regular file
  -l {1,2,3,4,5,6,7,8,9}, --level {1,2,3,4,5,6,7,8,9}
                        Compression level (1-9, default: 3)
  -ps {ignore,compress}, --plus_line {ignore,compress}
                        FASTQ plus line handling
  --num_processes NUM_PROCESSES
                        Number of parallel processes
  -p, --plant           Use plant genome compression scheme
  -s {2,3,4,5,6,7,8,9,10}, --split {2,3,4,5,6,7,8,9,10}
                        Split output into N volumes (2-10)

Sequence Analysis options:
  --method {ncd,wbncd,lzjd}, -m {ncd,wbncd,lzjd}
                        Distance calculation method
  --tax {kingdom,phylum,class,order,family,genus,species}, --taxonomy-level {kingdom,phylum,class,order,family,genus,species}
                        NCBI taxonomy level for classification
  -k NEIGHBORS, --neighbors NEIGHBORS
                        Number of neighbors for KNN classification
  --alpha ALPHA         Distance correction coefficient (0-1)
  --confidence CONFIDENCE
                        Confidence threshold for classification
  -j JOBS, --jobs JOBS  Number of parallel jobs
  --tree {single,average,weighted,complete}
                        Method for phylogenetic tree construction
```


## Metadata
- **Skill**: generated
