# magmax CWL Generation Report

## magmax

### Tool Description
A tool to MAXimize the yield of Metagenome-Assembled Genomes (MAGs) through bin merging and resssembly.

### Metadata
- **Docker Image**: quay.io/biocontainers/magmax:1.3.0--ha6fb395_0
- **Homepage**: https://github.com/soedinglab/MAGmax
- **Package**: https://anaconda.org/channels/bioconda/packages/magmax/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/magmax/overview
- **Total Downloads**: 1.3K
- **Last updated**: 2026-02-11
- **GitHub**: https://github.com/soedinglab/MAGmax
- **Stars**: N/A
### Original Help Text
```text
MAGmax: A tool to MAXimize the yield of Metagenome-Assembled Genomes (MAGs) through bin merging and resssembly.

Usage: magmax [OPTIONS] --bindir <BINDIR>

Options:
  -b, --bindir <BINDIR>
          Directory containing fasta files of bins
  -r, --readdir <READDIR>
          Directory containing read files
  -m, --mapdir <MAPDIR>
          Directory containing mapids files
  -i, --ani <ANI>
          ANI for clustering bins (%) [default: 99]
  -c, --completeness <COMPLETENESS_CUTOFF>
          Minimum completeness of bins (%) [default: 50]
  -p, --purity <PURITY_CUTOFF>
          Mininum purity (1- contamination) of bins (%) [default: 95]
  -a, --alignedfrac <ALIGNEDFRAC>
          Mininum aligned fraction of (both reference and query) genomes covered in the ANI calculation [default: 0]
  -f, --format <FORMAT>
          Bin file extension [default: fasta]
  -t, --threads <THREADS>
          Number of threads to use [default: 8]
      --no-reassembly
          Perform dereplication without bin merging and reassembly
      --sensitive
          Select representatives based on high connectivity. Bin merging and reassembly steps are disabled
      --split
          Split clusters into sample-wise bins before processing
  -q, --qual <QUAL>
          Quality file produced by CheckM2 (quality_report.tsv)
      --anifile <ANIFILE>
          ANI file produced by skani using command: skani triangle <bindir> -E -o <anifile>
  -o, --outdir <OUTPUT>
          Directory of output
      --assembler <ASSEMBLER>
          Assembler choice for reassembly step (spades|megahit), spades is recommended [default: spades]
  -h, --help
          Print help
  -V, --version
          Print version
```

