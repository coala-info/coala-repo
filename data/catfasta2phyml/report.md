# catfasta2phyml CWL Generation Report

## catfasta2phyml

### Tool Description
Concatenate fasta files to a phyml readable format

### Metadata
- **Docker Image**: quay.io/biocontainers/catfasta2phyml:1.2.1--hdfd78af_0
- **Homepage**: https://github.com/nylander/catfasta2phyml
- **Package**: https://anaconda.org/channels/bioconda/packages/catfasta2phyml/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/catfasta2phyml/overview
- **Total Downloads**: 2.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/nylander/catfasta2phyml
- **Stars**: N/A
### Original Help Text
```text
Usage:
    catfasta2phyml.pl [options] [files]

Options:
    -h, -?, --help
            Print a brief help message and exits.

    -m, --man
            Prints the manual page and exits.

    -c, --concatenate
            Concatenate files even when number of taxa differ among
            alignments. Missing data will be filled with all gap (-)
            sequences.

    -i, --intersect
            Concatenate sequences for sequence labels occuring in all input
            files (intersection).

    -f, --fasta
            Print output in FASTA format (default is PHYML format).

    -p, --phylip
            Print output in a strict PHYLIP format. See
            <http://evolution.genetics.washington.edu/phylip/doc/sequence.ht
            ml>.

            Note: The current output is not entirely strict for the
            interleaved format. Left to do is to efficiently print sequences
            in blocks of 10 characters. The sequential PHYLIP format works,
            on the other hand (use -s in combination with -p).

    -s, --sequential
            Print output in sequential format (default is interleaved).

    -b, --basename=suffix
            Ensure the basename is used as partition definition. If the
            provided "suffix" (required) matches the file suffix, it will be
            removed from the output string.

            Note: If the suffix it to be kept, one may use this format:
            "--basename=' '" (basically providing a string that will not
            match the file suffix).

    -v, --verbose
            Be verbose by showing some useful output. See the combination
            with -n.

    -n, --noprint
            Do not print the concatenation, just check if all files have the
            same sequence lables and lengths. Program returns 1 on exit. See
            also the combination with -v.

    -V, --version
            Print version number and exit.

Usage:
    To concatenate fasta files to a phyml readable format:

        catfasta2phyml.pl file1.fas file2.fas > out.phy
        catfasta2phyml.pl *.fas > out.phy 2> partitions.txt
        catfasta2phyml.pl --sequential *.fas > out.phy
        catfasta2phyml.pl --verbose *.fas > out.phy

    To concatenate fasta files to fasta format:

        catfasta2phyml.pl -f file1.fas file2.fas > out.fasta
        catfasta2phyml.pl -f *.fas > out.fasta

    To check fasta alignments:

        catfasta2phyml.pl --noprint --verbose *.fas
        catfasta2phyml.pl -nv *.fas
        catfasta2phyml.pl -n *.fas

    To concatenate fasta files, while filling in missing taxa:

        catfasta2phyml.pl --concatenate --verbose *.fas

    To concatenate sequences for sequence labels occuring in all files:

        catfasta2phyml.pl --intersect *.fas

    To ensure basename as name and suffix removal in partition definition:

        catfasta2phyml.pl -b.fas dat/file1.fas dat/file2.fas > out.phy
```

