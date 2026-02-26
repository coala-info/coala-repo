# srf-n-trf CWL Generation Report

## srf-n-trf_monomers

### Tool Description
Parses TRF output to identify tandem repeats within SRF-elongated motifs.

### Metadata
- **Docker Image**: quay.io/biocontainers/srf-n-trf:0.1.2--h4349ce8_0
- **Homepage**: https://github.com/koisland/srf-n-trf
- **Package**: https://anaconda.org/channels/bioconda/packages/srf-n-trf/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/srf-n-trf/overview
- **Total Downloads**: 2.2K
- **Last updated**: 2025-10-12
- **GitHub**: https://github.com/koisland/srf-n-trf
- **Stars**: N/A
### Original Help Text
```text
Usage: srf-n-trf monomers [OPTIONS] --paf <PAF> --monomers <MONOMERS>

Options:
  -p, --paf <PAF>
          PAF file of alignment of assembly as query and `srf` enlonged motifs as target. Requires `cg` extended cigar string. With `minimap2`, use `--eqx`

  -m, --monomers <MONOMERS>
          `trf` monomers TSV file on `srf` monomers with columns: `chrom (query), motif (target), st, end, period, copyNum, fracMatch, fracGap, score, entropy, pattern`

  -o, --outfile <OUTFILE>
          Output BED9 file with columns: `chrom, st, end, comma-delimited_monomers, 0, strand, st, end, '0,0,0'`

  -s, --sizes <SIZES>...
          Monomer size in base pairs to search for
          
          [default: 170 340 510 680 850 1020 42]

  -d, --diff <DIFF>
          Percent difference in monomer period length allowed. ex. `0.02` results in valid periods for `170`: `167 < 170 < 173`
          
          [default: 0.02]

  -c, --cov <COV>
          Percent coverage of srf motif required for a given trf monomer.
          
          Example: `prefix#circ7-1364       2       1364    342     3.99` * This trf monomer has 100% coverage (`1.0`) * `342 * 3.99 = 1364.58` * `1364.58 / 1364` * `1.0 >= 0.8`
          
          [default: 0.8]

  -m, --max-seq-div <MAX_SEQ_DIV>
          Maximum gap-compressed sequence divergence between aligned motif and region
          
          [default: 0.2]

  -h, --help
          Print help (see a summary with '-h')
```


## srf-n-trf_motifs

### Tool Description
Fasta file of srf detected motifs

### Metadata
- **Docker Image**: quay.io/biocontainers/srf-n-trf:0.1.2--h4349ce8_0
- **Homepage**: https://github.com/koisland/srf-n-trf
- **Package**: https://anaconda.org/channels/bioconda/packages/srf-n-trf/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: srf-n-trf motifs [OPTIONS] --fa <FA> --monomers <MONOMERS>

Options:
  -f, --fa <FA>              Fasta file of srf detected motifs
  -m, --monomers <MONOMERS>  `trf` monomers TSV file on `srf` monomers with columns: `chrom (query), motif (target), st, end, period, copyNum, fracMatch, fracGap, score, entropy, pattern`
  -o, --outfile <OUTFILE>    Output fasta file filtered to only motifs composed of monomers of given size
  -s, --sizes <SIZES>...     Monomer size in base pairs to search for [default: 170 340 510 680 850 1020]
  -d, --diff <DIFF>          Percent difference in monomer period length allowed. ex. `0.02` results in valid periods for `170`: `167 < 170 < 173` [default: 0.02]
      --require-all          Require all monomers to be within size range
  -h, --help                 Print help
```


## srf-n-trf_regions

### Tool Description
Generates regions based on TRF output, merging and filtering based on monomer composition and distance.

### Metadata
- **Docker Image**: quay.io/biocontainers/srf-n-trf:0.1.2--h4349ce8_0
- **Homepage**: https://github.com/koisland/srf-n-trf
- **Package**: https://anaconda.org/channels/bioconda/packages/srf-n-trf/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: srf-n-trf regions [OPTIONS] --bed <BED>

Options:
  -b, --bed <BED>          Bed file from extract command
  -o, --outfile <OUTFILE>  Output BED9 file with columns: `chrom, st, end, comma-delimited_monomers, 0, strand, st, end, '0,0,0'`
  -d, --dst <DST>          Distance to merge in base pairs [default: 100000]
  -m, --min-len <MIN_LEN>  Minimum length in base pairs [default: 30000]
  -s, --sizes <SIZES>...   Required monomers in merged blocks. Merges iff one of these monomer periods is in block. Also filters out monomers not within this period [default: 170 340 510 680 850 1020]
      --diff <DIFF>        Difference in required monomer size [default: 0.02]
  -h, --help               Print help
```

