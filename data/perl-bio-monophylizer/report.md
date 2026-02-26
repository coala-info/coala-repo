# perl-bio-monophylizer CWL Generation Report

## perl-bio-monophylizer_monophylizer.pl

### Tool Description
A tool to analyze monophyly in phylogenetic trees, supporting various formats and metadata integration.

### Metadata
- **Docker Image**: quay.io/biocontainers/perl-bio-monophylizer:1.0.0--hdfd78af_0
- **Homepage**: https://metacpan.org/pod/Bio::Monophylizer
- **Package**: https://anaconda.org/channels/bioconda/packages/perl-bio-monophylizer/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/perl-bio-monophylizer/overview
- **Total Downloads**: 72
- **Last updated**: 2025-12-14
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Usage:
        # to get help on the command line
        $ perl monophylizer.pl --help
    
        # example run
        $ perl monophylizer.pl \
            -infile tree.nwk \
            -format newick \
            -astsv \
            -verbose \ 
                > outfile.tsv

Options and Arguments:
    -infile <file>
        A tree file, usually in Newick format. Required.

    -format <newick|nexus|nexml|phyloxml>
        Optional argument to specify the tree file format. By default the
        Newick format is used.

    -metadata <file>
        Optional argument to provide the location of a tab-separated
        spreadsheet with per-taxon metadata.

    -separator <character>
        Optional argument to specific the character that separates the taxon
        name from any additional metdata (such as sequence IDs) in leaf
        labels. By default this is the pipe symbol: '|'.

    -comments
        Optional flag to treat square brackets as opaque strings, not
        comments, default: true.

    -quotes
        Optional flag to treat quotes as opaque strings, default: true.

    -whitespace
        Optional flag to treat whitespace as opaque strings, default: true.

    -trinomials
        Optional flag to include subspecific epithets in taxa, default:
        false.

    -astsv
        Optional flag to set output as TSV regardless whether running as
        CGI, default: false. This is only available when running under CGI.

    -verbose
        Influences how verbose the script is. By default, only warning
        messages are emitted. When this flag is used once, also
        informational messages are emitted. When used twice, also debugging
        messages.

    -help
        Prints usage message and quits, only available when running on
        command line.
```

