# reprof CWL Generation Report

## reprof

### Tool Description
Predicts protein sequence profiles.

### Metadata
- **Docker Image**: biocontainers/reprof:v1.0.1-6-deb_cv1
- **Homepage**: https://github.com/ephmo/reprofed
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/reprof/overview
- **Total Downloads**: N/A
- **Last updated**: N/A
- **GitHub**: https://github.com/ephmo/reprofed
- **Stars**: N/A
### Original Help Text
```text
Usage:
    reprof -i [query.blastPsiMat] [OPTIONS]

    reprof -i [query.fasta] [OPTIONS]

    reprof -i [query.blastPsiMat|query.fasta] --mutations [mutations.txt]
    [OPTIONS]

Options:
    -i, --input=FILE
        Input BLAST PSSM matrix file (from Blast -Q option) or input
        (single) FASTA file.

    -o, --out=FILE
        Either an output file or a directory. If not provided or a
        directory, the suffix of the input filename (i.e. .fasta or
        .blastPsiMat) is replaced to create an output filename.

    --mutations=[all|FILE]
        Either the keyword "all" to predict all possible mutations or a file
        containing mutations one per line such as "C12M" for C is mutated to
        M on position 12:

         C30Y
         R31W
         G48D

        This mutation code is also attached to the output filename using
        "_". An additional file ending "_ORI" contains the prediction using
        no evolutionary information even if a BLAST PSSM matrix was
        provided.

    --modeldir=DIR
        Directory where the model and feature files are stored. Default:
        /usr/share/reprof.
```

