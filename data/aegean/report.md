# aegean CWL Generation Report

## aegean_locuspocus

### Tool Description
calculate locus coordinates for the given gene annotation

### Metadata
- **Docker Image**: quay.io/biocontainers/aegean:0.16.0--h71bfec9_5
- **Homepage**: https://github.com/BrendelGroup/AEGeAn
- **Package**: https://anaconda.org/channels/bioconda/packages/aegean/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/aegean/overview
- **Total Downloads**: 5.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/BrendelGroup/AEGeAn
- **Stars**: N/A
### Original Help Text
```text
[LocusPocus] error: must provide at least one GFF3 file as input; use '-' if you want to provide data via standard input

LocusPocus: calculate locus coordinates for the given gene annotation
Usage: locuspocus [options] gff3file1 [gff3file2 gff3file3 ...]
  Basic options:
    -d|--debug             print detailed debugging messages to terminal
                           (standard error)
    -h|--help              print this help message and exit
    -v|--version           print version number and exit

  iLocus parsing:
    -l|--delta: INT        when parsing interval loci, use the following
                           delta to extend gene loci and include potential
                           regulatory regions; default is 500
    -s|--skipends          when enumerating interval loci, exclude
                           unannotated (and presumably incomplete) iLoci at
                           either end of the sequence
    -e|--endsonly          report only incomplete iLocus fragments at the
                           unannotated ends of sequences (complement of
                           --skipends)
    -y|--skipiiloci        do not report intergenic iLoci

  Refinement options:
    -r|--refine            by default genes are grouped in the same iLocus
                           if they have any overlap; 'refine' mode allows
                           for a more nuanced handling of overlapping genes
    -c|--cds               use CDS rather than UTRs for determining gene
                           overlap; implies 'refine' mode
    -m|--minoverlap: INT   the minimum number of nucleotides two genes must
                           overlap to be grouped in the same iLocus; default
                           is 1

  Output options:
    -n|--namefmt: STR     provide a printf-style format string to override
                           the default ID format for newly created loci;
                           default is 'locus%lu' (locus1, locus2, etc) for
                           loci and 'iLocus%lu' (iLocus1, iLocus2, etc) for
                           interval loci; note the format string should
                           include a single %lu specifier to be filled in
                           with a long unsigned integer value
    -i|--ilens: FILE       create a file with the lengths of each intergenic
                           iLocus
    -g|--genemap: FILE     print a mapping from each gene annotation to its
                           corresponding locus to the given file
    -o|--outfile: FILE     name of file to which results will be written;
                           default is terminal (standard output)
    -T|--retainids         retain original feature IDs from input files;
                           conflicts will arise if input contains duplicated
                           ID values
    -t|--transmap: FILE    print a mapping from each transcript annotation
                           to its corresponding locus to the given file
    -V|--verbose           include all locus subfeatures (genes, RNAs, etc)
                           in the GFF3 output; default includes only locus
                           features

  Input options:
    -f|--filter: TYPE      comma-separated list of feature types to use in
                           constructing loci/iLoci; default is 'gene'
    -p|--parent: CT:PT     if a feature of type $CT exists without a parent,
                           create a parent for this feature with type $PT;
                           for example, mRNA:gene will create a gene feature
                           as a parent for any top-level mRNA feature;
                           this option can be specified multiple times
    -u|--pseudo            correct erroneously labeled pseudogenes
```


## aegean_canon-gff3

### Tool Description
Clean up and canonicalize GFF3 data, including inferring missing gene features and resetting feature sources.

### Metadata
- **Docker Image**: quay.io/biocontainers/aegean:0.16.0--h71bfec9_5
- **Homepage**: https://github.com/BrendelGroup/AEGeAn
- **Package**: https://anaconda.org/channels/bioconda/packages/aegean/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: canon-gff3 [options] gff3file1 [gff3file2 ...]
  Options:
     -h|--help               print this help message and exit
     -i|--infer              for transcript features lacking an explicitly
                             declared gene feature as a parent, create this
                             feature on-they-fly
     -o|--outfile: STRING    name of file to which GFF3 data will be
                             written; default is terminal (stdout)
     -s|--source: STRING     reset the source of each feature to the given
                             value
     -v|--version            print version number and exit
```

