# tipp CWL Generation Report

## tipp_TIPPo.v2.3.pl

### Tool Description
TIPPo.v2.3.pl is a tool for analyzing HiFi reads, potentially for chloroplast or organelle genomes.

### Metadata
- **Docker Image**: quay.io/biocontainers/tipp:1.3.0--py38pl5321h077b44d_0
- **Homepage**: https://github.com/Wenfei-Xian/TIPP
- **Package**: https://anaconda.org/channels/bioconda/packages/tipp/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/tipp/overview
- **Total Downloads**: 1.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/Wenfei-Xian/TIPP
- **Stars**: N/A
### Original Help Text
```text
Usage: /usr/local/bin/TIPPo.v2.3.pl [options]
  -h: Show this help message.
  -f: HiFi reads (required).
  -g: chloroplast or organelle (default: organelle).
  -t: Threads for tiara, flye, KMC3 and readskmercount.
  -n: Number of reads in each downsample for chloroplast.
  -r: Number of random downsamplings (default: 5).
  -i: Assume the presence of the inverted repeats (default: 1).
  -l: lower kmer count - lkc (default: 0.3).
  -c: high kmer count - hkc (default: 5).
  -y: parameter for flye (default: --pacbio-hifi).
  -a: parameter for minimap2 (default: map-hifi).
  -m: minimum overlap in repeat graph construction (default:800)
  -b: reference sequence (default: No).
  -v: version.
```

