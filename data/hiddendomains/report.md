# hiddendomains CWL Generation Report

## hiddendomains_hiddenDomains

### Tool Description
Call enriched domains from sequencing data.

### Metadata
- **Docker Image**: quay.io/biocontainers/hiddendomains:3.1--pl526r36_0
- **Homepage**: http://hiddendomains.sourceforge.net/
- **Package**: https://anaconda.org/channels/bioconda/packages/hiddendomains/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/hiddendomains/overview
- **Total Downloads**: 8.7K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
/usr/local/bin/hiddenDomains version [unknown] calling Getopt::Std::getopts (version 1.12 [paranoid]),
running under Perl version 5.26.2.

Usage: hiddenDomains [-OPTIONS [-MORE_OPTIONS]] [--] [PROGRAM_ARG1 ...]

The following single-character options are accepted:
	With arguments: -b -c -C -g -o -p -t -q
	Boolean (without arguments): -h -B

Options may be merged together.  -- stops processing of options.
Space is not required between options and their arguments.
  [Now continuing due to backward compatibility and excessive paranoia.
   See 'perldoc Getopt::Std' about $Getopt::Std::STANDARD_HELP_VERSION.]
binWidth: 1000 (change with -b option)
minQualScore: 30 (change with -q option)

You must specify -g ChromInfo.txt


Usage: hiddenDomains [options] -g ChromInfo -t TreatmentReads -o OutputPrefix

Options

-h
    Print this help information.

-b  BIN_WIDTH
    The width of the bin. Default is 1000bp.

-B
    The input file(s) is(are) in BED format (the default is BAM). NOTE: All
    read files have to have to same format (either BED or BAM). Use
    binReads.pl as a stand alone program if you have a more complicated set up.

-c  ControlReads
    A BED or BAM file that contains aligned read reads. Use the -B option to
    speicfy BED format. BAM format is the default.

-C  ControlReadsBins
    If you have already binned your control reads, you can pass them in
    with this option and they will be used directly.

-g  ChromInfo.txt
    If you get an out of bounds error when uploading a bed file to the UCSC
    genome browser, you can use this option to trim the bounds to the size of 
    the chromosomes.
    ChromInfo.txt should be a tab delimited file with the chromosome names
    in the first column and their sizes in the second column.  Here is an 
    example ChromInfo.txt file for a genome with 3 chromosomes:

    chr1    197195432
    chr2    181748087
    chr3    159599783    

-o  OutputPrefix
    hiddenDomains generates four or five files with names that start with
    OutputPrefix. 
    
    1) "_domains.txt": A text file with all of the enriched domains and
    posterior probabilities.
    2) "_vis.bed": A BED file for visualization, which contains one line per 
    significantly enriched bin - this allows for color coding based on the 
    posterior probability.
    3) "_analysis.bed": The second BED file is for analysis, and this merges 
    all consecutive bins with posterior probabiliites greater than 
    MIN_POSTERIOR (as specified with the -p option) or the default value, 
    0 - which merges all consecutive significat bins.
    4) "_treatment_bins.txt": A file with the read counts per bin.
    5) "_control_bins.txt": A file with the read counts per bin.

-p  MIN_POSTERIOR
    Toss out parts of domains that have posterior values that are less
    than MIN_POSTERIOR. You can set this to any value you want, but for
    reference, domainsToBed bins according the following scale:
    >= 0.9
    0.9 > posterior >= 0.8
    0.8 > posterior >= 0.7
    0.7 > posterior >= min posterior for significance

    The default value is 0; everything is merged by default.

-q  MIN_MAPQ
    The minimum MAPQ score. Default is 30.

-t  TreatmentReads
    A BED or BAM file that contains aligned read reads. Use the -B option to
    speicfy BED format. BAM format is the default.
```


## hiddendomains_binReads.pl

### Tool Description
Binning reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/hiddendomains:3.1--pl526r36_0
- **Homepage**: http://hiddendomains.sourceforge.net/
- **Package**: https://anaconda.org/channels/bioconda/packages/hiddendomains/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/binReads.pl version [unknown] calling Getopt::Std::getopts (version 1.12 [paranoid]),
running under Perl version 5.26.2.

Usage: binReads.pl [-OPTIONS [-MORE_OPTIONS]] [--] [PROGRAM_ARG1 ...]

The following single-character options are accepted:
	With arguments: -b -c -q
	Boolean (without arguments): -h -m -M -H -B

Options may be merged together.  -- stops processing of options.
Space is not required between options and their arguments.
  [Now continuing due to backward compatibility and excessive paranoia.
   See 'perldoc Getopt::Std' about $Getopt::Std::STANDARD_HELP_VERSION.]
binWidth: 1000 (change with -b option)
minQualScore: 30 (change with -q option)
Default: Using mouse chromosomes.  Change this with -m, -h or -c
Use of uninitialized value $bamFile in concatenation (.) or string at /usr/local/bin/binReads.pl line 125.
Binning reads.samtools: error while loading shared libraries: libcrypto.so.1.0.0: cannot open shared object file: No such file or directory

binned 0 reads

None of the reads in the BAM file passed the quality threshold, 30.
Use the -q option to set a lower threshold
```


## hiddendomains_domainsToBed.pl

### Tool Description
Converts a domain file generated by the hiddenDomains R function into a BED file.

### Metadata
- **Docker Image**: quay.io/biocontainers/hiddendomains:3.1--pl526r36_0
- **Homepage**: http://hiddendomains.sourceforge.net/
- **Package**: https://anaconda.org/channels/bioconda/packages/hiddendomains/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: domainsToBed.pl [options] domainFile.txt > domainFile.bed

NOTE: domainFile.txt should be a file generated by the hiddenDomains R function.

Options

-h
    Print this help information.

-b  BIN_WIDTH
    The width of the bin.  Default is 1000bp.

-g  ChromInfo.txt
    If you get an out of bounds error when uploading a bed file to the UCSC
    genome browser, you can use this option to trim the bounds to the size of 
    the chromosomes.
    ChromInfo.txt should be a tab delimited file with the chromosome names
    in the first column and their sizes in the second column.  Here is an 
    example ChromInfo.txt file for a genome with 3 chromosomes:

    chr1    197195432
    chr2    181748087
    chr3    159599783    

-t
    Create a trackline.

-n  TRACK_NAME
    The name you want to give your track. The default is to use the name of
    the domainFile (without the .txt suffix)
```


## hiddendomains_domainsMergeToBed.pl

### Tool Description
This program merges all consecutive domains with posterior greater than a threshold (default is 0; all domains are merged) into a single domain.

### Metadata
- **Docker Image**: quay.io/biocontainers/hiddendomains:3.1--pl526r36_0
- **Homepage**: http://hiddendomains.sourceforge.net/
- **Package**: https://anaconda.org/channels/bioconda/packages/hiddendomains/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: domainsMergeToBed.pl [options] domainFile.txt > domainFile.bed

This program merges all consecutive domains with posterior greater than
a threshold (default is 0; all domains are merged) into a single domain.

NOTE: domainFile.txt should be a file generated by the hiddenDomains R function.

Options

-h
    Print this help information.

-b  BIN_WIDTH
    The width of the bin.  Default is 1000bp.

-p  MIN_POSTERIOR
    Toss out parts of domains that have posterior values that are less
    than MIN_POSTERIOR. You can set this to any value you want, but for
    reference, domainsToBed bins according the following scale:
    >= 0.9
    0.9 > posterior >= 0.8
    0.8 > posterior >= 0.7
    0.7 > posterior >= min posterior for significance

    The default value is 0; everything is merged by default.

-g  ChromInfo.txt
    If you get an out of bounds error when uploading a bed file to the UCSC
    genome browser, you can use this option to trim the bounds to the size of 
    the chromosomes.
    ChromInfo.txt should be a tab delimited file with the chromosome names
    in the first column and their sizes in the second column.  Here is an 
    example ChromInfo.txt file for a genome with 3 chromosomes:

    chr1    197195432
    chr2    181748087
    chr3    159599783    

-t
    Create a trackline.

-n  TRACK_NAME
    The name you want to give your track. The default is to use the name of
    the domainFile (without the .txt suffix)
```

