# phylocsfpp CWL Generation Report

## phylocsfpp_phylocsf++

### Tool Description
A fast and easy-to-use tool to compute PhyloCSF scores and tracks and annotate GFF/GTF.

### Metadata
- **Docker Image**: quay.io/biocontainers/phylocsfpp:1.2.0_9643238d--hea07040_3
- **Homepage**: https://github.com/cpockrandt/PhyloCSFpp
- **Package**: https://anaconda.org/channels/bioconda/packages/phylocsfpp/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/phylocsfpp/overview
- **Total Downloads**: 14.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/cpockrandt/PhyloCSFpp
- **Stars**: N/A
### Original Help Text
```text
[1mPhyloCSF++ v1.2.0 (build date: 2022-01-04, git commit: 9643238d)

[0mA fast and easy-to-use tool to compute PhyloCSF scores and tracks and annotate GFF/GTF.
For documentation and help, check out https://github.com/cpockrandt/PhyloCSFpp

Please consider citing:
  Pockrandt et al., PhyloCSF++: A fast and user-friendly implementation of PhyloCSF
  with annotation tools, https://doi.org/10.1093/bioinformatics/btab756, Bioinformatics 2021

Usage: phylocsf++ [OPTIONS] <tool>

Tools:

  build-tracks            Computes PhyloCSF and Power tracks for each codon and all 6
                          frames from alignments from MAF files. Outputs them in wig
                          files.

  score-msa               Computes PhyloCSF scores, ancestral sequence composition
                          sores and branch length scores for entire alignments from
                          MAF files. Outputs them in a BED-like format.

  annotate-with-tracks    Scores the CDS features in GFF/GTF files using precomputed
                          tracks (bw files) and outputs annotated GFF/GTF files.

  annotate-with-mmseqs    Scores the CDS features in GFF/GTF files by computing
                          multiple sequence alignments from scratch (requires
                          MMseqs2) and outputs annotated GFF/GTF files.

  find-cds                Takes GFF/GTF files as input and for each transcript
                          searches for CDS with high protein-coding likelihood using
                          PhyloCSF tracks.

Help options:

  --help                  Prints this help message. Run `phylocsf++ build-tracks
                          --help` for help messages on the tools
```

