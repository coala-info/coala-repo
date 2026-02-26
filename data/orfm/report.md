# orfm CWL Generation Report

## orfm

### Tool Description
The <seq_file> can be a FASTA or FASTQ file, gzipped or uncompressed.

### Metadata
- **Docker Image**: quay.io/biocontainers/orfm:1.4.0--h577a1d6_0
- **Homepage**: https://github.com/wwood/OrfM
- **Package**: https://anaconda.org/channels/bioconda/packages/orfm/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/orfm/overview
- **Total Downloads**: 22.5K
- **Last updated**: 2025-11-07
- **GitHub**: https://github.com/wwood/OrfM
- **Stars**: N/A
### Original Help Text
```text
Usage: orfm [options] <seq_file>

  The <seq_file> can be a FASTA or FASTQ file, gzipped or uncompressed.

  Options:
   -m LENGTH   minimum number of nucleotides (not amino acids) to call
               an ORF on [default: 96]
   -t FILE     output nucleotide sequences of transcripts to this path
               [default: none]
   -l LENGTH   ignore the sequence of the read beyond this, useful when
               comparing reads from with different read lengths
               [default: none]
   -c TABLE_ID codon table for translation (see 
               http://www.ncbi.nlm.nih.gov/Taxonomy/taxonomyhome.html/index.cgi?chapter=tgencodes
               for details) [default: 1]
   -p          print the actual stop codons at sequence ends if encoded
               [default: do not]
   -s          only print those ORFs in the same frame as a stop codon
               [default: off]
   -r VERSION  do not run unless this version of OrfM is at least this version
               number (e.g. 1.4.0)
   -v          show version information
   -h          show this help

If you use OrfM in your research, thank you. If possible, can you please also
cite our publication?

  Ben J. Woodcroft, Joel A. Boyd, and Gene W. Tyson.
  OrfM: A fast open reading frame predictor for metagenomic data (2016).
  Bioinformatics. 32 (17): 2702-2703. doi:10.1093/bioinformatics/btw241.
```

