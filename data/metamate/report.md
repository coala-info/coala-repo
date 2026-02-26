# metamate CWL Generation Report

## metamate_find

### Tool Description
find arguments:

### Metadata
- **Docker Image**: quay.io/biocontainers/metamate:0.5.2--pyr44h7e72e81_0
- **Homepage**: https://github.com/tjcreedy/metamate
- **Package**: https://anaconda.org/channels/bioconda/packages/metamate/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/metamate/overview
- **Total Downloads**: 1.1K
- **Last updated**: 2025-12-20
- **GitHub**: https://github.com/tjcreedy/metamate
- **Stars**: N/A
### Original Help Text
```text
usage: metamate find [-h] -A path [-L [path ...]] [-M path] [-y] -o name
                     [--realign] [--overwrite] [-t n] [-d [0-1]] [-T path]
                     [--distancemodel MOD] [-G path] [--uc path]
                     [--otu_fasta path] [--otu_table path] -S path [-q metric]
                     [-g [[0-1]]] [-R path] [--refmatchlength n]
                     [--ignoreambigASVs] [--keeptemporaryfiles] [-n n] [-x n]
                     [-l n] [-b n] [-p [0-100]] [-c n] [--onlyvarybycodon]
                     [-s path] [-r {1,2,3}] [--detectionconfidence [0-1]]
                     [--detectionminstops n]

find arguments:
  -h, --help            show this help message and exit
  -S, --specification path
                        path to a text file detailing the read count binning
                        strategy and thresholds. An example can be found in
                        the github
  -q, --scoremetric metric
                        which of the three calculated scoring metrics
                        ('accuracy', 'precision' or 'recall') to use for
                        selecting the top scoring set(s) (default accuracy)
  -g, --generateASVresults [[0-1]]
                        generate fasta files of retained ASVs for for
                        threshold sets: if no value is given, generate for top
                        scoring set(s) only; otherwise generate for the given
                        proportion of top scoring sets (default 0: no ASVs
                        output)

universal inputs and options:
  -A, --asvs path       path to a fasta of unique sequences to filter
  -L, --libraries [path ...]
                        path to fastx file(s) of individual libraries/discrete
                        samples from which ASVs were drawn, or a single fastx
                        with ';samplename=NAME;' or ';barcodelabel=NAME;'
                        annotations in headers.
  -M, --readmap path    path to a comma- or tab- separated tabular text file
                        containing read counts for ASVs by library
  -y, --anyfail         reject ASVs when any incidences fail to meet a
                        threshold (default is all incidences)
  -o, --output name     the base directory/file name path to which
                        intermediate and final output data should be written,
                        file extensions will be added as necessary
  --realign             force (re)alignment of the input ASVs
  --overwrite           force overwriting of intermediate and/or final
                        output(s)
  -t, --threads n       number of threads to use (default 1)

clade binning:
  -d, --divergence [0-1]
                        divergence level to use for assigning clades (default
                        0.2)
  -T, --tree path       path to an ultrametric tree of the ASVs
  --distancemodel MOD   substitution model for UPGMA tree estimation (passed
                        to R dist.dna, default F84)

taxon binning:
  -G, --taxgroups path  path to a two-column csv file specifying the taxon for
                        each ASV

otu binning:
  --uc path             path to a .uc file (vsearch output) mapping ASVs to
                        OTUs
  --otu_fasta path      path to a fasta file containing OTU centroid sequences
  --otu_table path      path to a table (CSV/TSV) containing OTU counts per
                        library

reference-matching-based target identification:
  -R, --references path
                        path to a fasta of known correct reference sequences
  --refmatchlength n    the minimum alignment length to consider a match when
                        comparing ASVs against reference sequences (default is
                        80% of [calculated value of] -n/--minimumlength)
  --ignoreambigASVs     ASVs that match the same reference will not be
                        considered vaASV (default is to count the most
                        abundant one as verified authentic).
  --keeptemporaryfiles  don't delete the temporary bbmap result files
                        generated during reference matching

length-based non-target identification:
  -n, --minimumlength n
                        designate ASVs that are shorter than this value as
                        non-target
  -x, --maximumlength n
                        designate ASVs that are longer than this value as non-
                        target
  -l, --expectedlength n
                        the expected length of the sequences
  -b, --basesvariation n
                        the number of bases of variation from the expected
                        length outside which ASVs should be designated as non-
                        target
  -p, --percentvariation [0-100]
                        the percentage variation from the expected length
                        outside which ASVs should be designated as non-target
  -c, --codonsvariation n
                        the number of codons of variation from the expected
                        length outside which ASVs should be designated as non-
                        target
  --onlyvarybycodon     designate ASVs that fall within other length
                        thresholds but do not vary by a multiple of 3 bases
                        from the expected length as non-target

translation-based non-target identification:
  -s, --table path      the number referring to the translation table to use
                        for translation filtering
  -r, --readingframe {1,2,3}
                        coding frame of sequences, if known
  --detectionconfidence [0-1]
                        confidence level for detection of reading frame
                        (default 0.95)
  --detectionminstops n
                        minimum number of stops to encounter for detection
                        (default 100, may need to decrease for few input ASVs)
```


## metamate_dump

### Tool Description
Dump filtered ASVs based on specifications.

### Metadata
- **Docker Image**: quay.io/biocontainers/metamate:0.5.2--pyr44h7e72e81_0
- **Homepage**: https://github.com/tjcreedy/metamate
- **Package**: https://anaconda.org/channels/bioconda/packages/metamate/overview
- **Validation**: PASS

### Original Help Text
```text
usage: metamate dump [-h] -A path [-L [path ...]] [-M path] [-y] -o name
                     [--realign] [--overwrite] [-t n] [-d [0-1]] [-T path]
                     [--distancemodel MOD] [-G path] [--uc path]
                     [--otu_fasta path] [--otu_table path] [-C path]
                     [-i [n ...]] [-S ['[C(s);M;T]' ...]]

arguments:
  -h, --help            show this help message and exit
  -C, --resultcache path
                        path to the _resultcache file from a previous run
  -i, --resultindex [n ...]
                        one or more indices of result(s) from a previous run
                        from which to generate filtered ASVs
  -S, --specification ['[C(s);M;T]' ...]
                        one or more [category(/ies); metric; threshold]
                        strings denoting the (multiplicative) specification
                        for dumping errors. If provided via CLI, each []
                        string must be quoted

universal inputs and options:
  -A, --asvs path       path to a fasta of unique sequences to filter
  -L, --libraries [path ...]
                        path to fastx file(s) of individual libraries/discrete
                        samples from which ASVs were drawn, or a single fastx
                        with ';samplename=NAME;' or ';barcodelabel=NAME;'
                        annotations in headers.
  -M, --readmap path    path to a comma- or tab- separated tabular text file
                        containing read counts for ASVs by library
  -y, --anyfail         reject ASVs when any incidences fail to meet a
                        threshold (default is all incidences)
  -o, --output name     the base directory/file name path to which
                        intermediate and final output data should be written,
                        file extensions will be added as necessary
  --realign             force (re)alignment of the input ASVs
  --overwrite           force overwriting of intermediate and/or final
                        output(s)
  -t, --threads n       number of threads to use (default 1)

clade binning:
  -d, --divergence [0-1]
                        divergence level to use for assigning clades (default
                        0.2)
  -T, --tree path       path to an ultrametric tree of the ASVs
  --distancemodel MOD   substitution model for UPGMA tree estimation (passed
                        to R dist.dna, default F84)

taxon binning:
  -G, --taxgroups path  path to a two-column csv file specifying the taxon for
                        each ASV

otu binning:
  --uc path             path to a .uc file (vsearch output) mapping ASVs to
                        OTUs
  --otu_fasta path      path to a fasta file containing OTU centroid sequences
  --otu_table path      path to a table (CSV/TSV) containing OTU counts per
                        library
```


## metamate_filter-adaptive

### Tool Description
adaptive filtering arguments

### Metadata
- **Docker Image**: quay.io/biocontainers/metamate:0.5.2--pyr44h7e72e81_0
- **Homepage**: https://github.com/tjcreedy/metamate
- **Package**: https://anaconda.org/channels/bioconda/packages/metamate/overview
- **Validation**: PASS

### Original Help Text
```text
usage: metamate filter-adaptive [-h] -A path [-L [path ...]] [-M path] [-y]
                                -o name [--realign] [--overwrite] [-t n]
                                [-d [0-1]] [-T path] [--distancemodel MOD]
                                [-G path] [--uc path] [--otu_fasta path]
                                [--otu_table path] [-R path]
                                [--refmatchlength n] [--ignoreambigASVs]
                                [--keeptemporaryfiles] [-n n] [-x n] [-l n]
                                [-b n] [-p [0-100]] [-c n] [--onlyvarybycodon]
                                [-s path] [-r {1,2,3}]
                                [--detectionconfidence [0-1]]
                                [--detectionminstops n] [--percentile [0-1]]
                                [--criteria {verified_removed,estimated_removed}]

adaptive filtering arguments:
  -h, --help            show this help message and exit
  --percentile [0-1]    percentile of non-authentic ASVs to filter out
                        (default 0.95)
  --criteria {verified_removed,estimated_removed}
                        criteria for filtering: 'verified_removed' (default)
                        or 'estimated_removed'

universal inputs and options:
  -A, --asvs path       path to a fasta of unique sequences to filter
  -L, --libraries [path ...]
                        path to fastx file(s) of individual libraries/discrete
                        samples from which ASVs were drawn, or a single fastx
                        with ';samplename=NAME;' or ';barcodelabel=NAME;'
                        annotations in headers.
  -M, --readmap path    path to a comma- or tab- separated tabular text file
                        containing read counts for ASVs by library
  -y, --anyfail         reject ASVs when any incidences fail to meet a
                        threshold (default is all incidences)
  -o, --output name     the base directory/file name path to which
                        intermediate and final output data should be written,
                        file extensions will be added as necessary
  --realign             force (re)alignment of the input ASVs
  --overwrite           force overwriting of intermediate and/or final
                        output(s)
  -t, --threads n       number of threads to use (default 1)

clade binning:
  -d, --divergence [0-1]
                        divergence level to use for assigning clades (default
                        0.2)
  -T, --tree path       path to an ultrametric tree of the ASVs
  --distancemodel MOD   substitution model for UPGMA tree estimation (passed
                        to R dist.dna, default F84)

taxon binning:
  -G, --taxgroups path  path to a two-column csv file specifying the taxon for
                        each ASV

otu binning:
  --uc path             path to a .uc file (vsearch output) mapping ASVs to
                        OTUs
  --otu_fasta path      path to a fasta file containing OTU centroid sequences
  --otu_table path      path to a table (CSV/TSV) containing OTU counts per
                        library

reference-matching-based target identification:
  -R, --references path
                        path to a fasta of known correct reference sequences
  --refmatchlength n    the minimum alignment length to consider a match when
                        comparing ASVs against reference sequences (default is
                        80% of [calculated value of] -n/--minimumlength)
  --ignoreambigASVs     ASVs that match the same reference will not be
                        considered vaASV (default is to count the most
                        abundant one as verified authentic).
  --keeptemporaryfiles  don't delete the temporary bbmap result files
                        generated during reference matching

length-based non-target identification:
  -n, --minimumlength n
                        designate ASVs that are shorter than this value as
                        non-target
  -x, --maximumlength n
                        designate ASVs that are longer than this value as non-
                        target
  -l, --expectedlength n
                        the expected length of the sequences
  -b, --basesvariation n
                        the number of bases of variation from the expected
                        length outside which ASVs should be designated as non-
                        target
  -p, --percentvariation [0-100]
                        the percentage variation from the expected length
                        outside which ASVs should be designated as non-target
  -c, --codonsvariation n
                        the number of codons of variation from the expected
                        length outside which ASVs should be designated as non-
                        target
  --onlyvarybycodon     designate ASVs that fall within other length
                        thresholds but do not vary by a multiple of 3 bases
                        from the expected length as non-target

translation-based non-target identification:
  -s, --table path      the number referring to the translation table to use
                        for translation filtering
  -r, --readingframe {1,2,3}
                        coding frame of sequences, if known
  --detectionconfidence [0-1]
                        confidence level for detection of reading frame
                        (default 0.95)
  --detectionminstops n
                        minimum number of stops to encounter for detection
                        (default 100, may need to decrease for few input ASVs)
```

