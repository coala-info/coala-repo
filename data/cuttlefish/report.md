# cuttlefish CWL Generation Report

## cuttlefish_build

### Tool Description
Efficiently construct the compacted de Bruijn graph from sequencing reads or reference sequences

### Metadata
- **Docker Image**: quay.io/biocontainers/cuttlefish:2.2.0--h6b3f7d6_5
- **Homepage**: https://github.com/COMBINE-lab/cuttlefish
- **Package**: https://anaconda.org/channels/bioconda/packages/cuttlefish/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cuttlefish/overview
- **Total Downloads**: 14.2K
- **Last updated**: 2025-07-31
- **GitHub**: https://github.com/COMBINE-lab/cuttlefish
- **Stars**: N/A
### Original Help Text
```text
Argument ‘--h’ starts with a - but has incorrect syntax

Usage :
Efficiently construct the compacted de Bruijn graph from sequencing reads or reference sequences
Usage:
  cuttlefish build [OPTION...]

 common options:
  -s, --seq arg            input files
  -l, --list arg           input file lists
  -d, --dir arg            input file directories
  -k, --kmer-len arg       k-mer length (default: 27)
  -t, --threads arg        number of threads to use (default: 5)
  -o, --output arg         output file
  -w, --work-dir arg       working directory (default: .)
  -m, --max-memory arg     soft maximum memory limit in GB (default: 3)
      --unrestrict-memory  do not impose memory usage restriction
  -h, --help               print usage

 cuttlefish_1 options:
  -f, --format arg        output format (0: FASTA, 1: GFA 1.0, 2: GFA 2.0, 3:
                          GFA-reduced)
      --track-short-seqs  track existence of sequences shorter than k bases
      --poly-N-stretch    includes information of polyN stretches in the
                          tiling output

 cuttlefish_2 options:
      --read        construct a compacted read de Bruijn graph (for FASTQ
                    input)
      --ref         construct a compacted reference de Bruijn graph (for
                    FASTA input)
  -c, --cutoff arg  frequency cutoff for (k + 1)-mers (default: refs: 1,
                    reads: 2)
      --path-cover  extract a maximal path cover of the de Bruijn graph

 debug options:
      --vertex-set arg  set of vertices, i.e. k-mers (KMC database) prefix
                        (default: "")
      --edge-set arg    set of edges, i.e. (k + 1)-mers (KMC database) prefix
                        (default: "")

 specialized options:
      --save-mph       save the minimal perfect hash (BBHash) over the vertex
                       set
      --save-buckets   save the DFA-states collection of the vertices
      --save-vertices  save the vertex set of the graph
```

