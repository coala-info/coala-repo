# bgen-cpp CWL Generation Report

## bgen-cpp_bgenix

### Tool Description
OPTIONS:

### Metadata
- **Docker Image**: quay.io/biocontainers/bgen-cpp:1.1.7--h5ca1c30_0
- **Homepage**: https://enkre.net/cgi-bin/code/bgen/
- **Package**: https://anaconda.org/channels/bioconda/packages/bgen-cpp/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bgen-cpp/overview
- **Total Downloads**: 867
- **Last updated**: 2025-09-25
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Usage: bgenix <options>

OPTIONS:
Input / output file options:
                  -g <a>: Path of bgen file to operate on.  (An optional form where "-g" is omitted and the filename is 
                          specified as the first argument, i.e. bgenix <filename>, can also be used).
                  -i <a>: Path of index file to use. If not specified, bgenix will look for an index file of the form '<f-
                          ilename>.bgen.bgi'  where '<filename>.bgen' is the bgen file name specified by the -g option.
              -table <a>: Specify the table (or view) that bgenix should read the file index from. This only affects rea-
                          ding the index file.  The named table or view should have the same schema as the Variant table
                          written by bgenix on index creation.  Defaults to "Variant".

Indexing options:
                -clobber: Specify that bgenix should overwrite existing index file if it exists.
                  -index: Specify that bgenix should build an index for the BGEN file specified by the -g option.
             -with-rowid: Create an index file that does not use the 'WITHOUT ROWID' feature. These are suitable for use
                          with sqlite versions < 3.8.2, but may be less efficient.

Variant selection options:
  -excl-range <a> <b>...: Exclude variants in the specified genomic interval from the output. See the description of -in-
                          cl-range for details.If this is specified multiple times, variants in any of the specified ran-
                          ges will be excluded.
  -excl-rsids <a> <b>...: Exclude variants with the specified rsid(s) from the output. See the description of -incl-rang-
                          e for details.If this is specified multiple times, variants with any of the specified ids will
                          be excluded.
  -incl-range <a> <b>...: Include variants in the specified genomic interval in the output. (If the argument is the name
                          of a valid readable file, the file will be opened and whitespace-separated rsids read from it 
                          instead.) Each interval must be of the form <chr>:<pos1>-<pos2> where <chr> is a chromosome id-
                          entifier  and pos1 and pos2 are positions with pos2 >= pos1.  One of pos1 and pos2 can also be
                          omitted, in which case the range extends to the start or end of the chromosome as appropriate.
                          Position ranges are treated as closed (i.e. <pos1> and <pos2> are included in the range).If th-
                          is is specified multiple times, variants in any of the specified ranges will be included.
  -incl-rsids <a> <b>...: Include variants with the specified rsid(s) in the output. If the argument is the name of a va-
                          lid readable file, the file will be opened and whitespace-separated rsids read from it instead.I-
                          f this is specified multiple times, variants with any of the specified ids will be included.

Output options:
  -compression-level <a>: Zlib compression level to use when transcoding to BGEN v1.1 format.  Defaults to "9".
                   -list: Suppress BGEN output; instead output a list of variants.
                    -v11: Transcode to BGEN v1.1 format.  (Currently, this is only supported if the input is in BGEN v1.2
                          format with 8 bits per probability, all samples are diploid, and all variants biallelic).
                    -vcf: Transcode to VCF format.  VCFs will have GP field (or 'HP' field for phased data), and a GT fi-
                          eld inferred from the probabilities by threshholding.
```


## bgen-cpp_cat-bgen

### Tool Description
Concatenate bgen files.

### Metadata
- **Docker Image**: quay.io/biocontainers/bgen-cpp:1.1.7--h5ca1c30_0
- **Homepage**: https://enkre.net/cgi-bin/code/bgen/
- **Package**: https://anaconda.org/channels/bioconda/packages/bgen-cpp/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: cat-bgen <options>

OPTIONS:
Input / output file options:
                       -clobber: Specify that cat-bgen should overwrite existing output file if it exists.
                  -g <a> <b>...: Path of bgen file(s) to concatenate. These must all be bgen files containing the same s-
                                 et of samples (in the same order). They must all be the same bgen version and be stored
                                 with the same flags.
                        -og <a>: Path of bgen file to output.
  -omit-sample-identifier-block: Specify that cat-bgen should omit the sample identifier block in the output, even if on-
                                 e is present in the first file specified to -og.
             -set-free-data <a>: Specify that cat-bgen should set free data in the resulting file to the given string va-
                                 lue.
```


## bgen-cpp_edit-bgen

### Tool Description
Edit bgen files.

### Metadata
- **Docker Image**: quay.io/biocontainers/bgen-cpp:1.1.7--h5ca1c30_0
- **Homepage**: https://enkre.net/cgi-bin/code/bgen/
- **Package**: https://anaconda.org/channels/bioconda/packages/bgen-cpp/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: edit-bgen <options>

OPTIONS:
Input / output file options:
               -g <a> <b>...: Path of bgen file(s) to edit. 

Actions:
                     -really: Really make changes (without this option a dry run is performed with no changes to files.)
  -remove-sample-identifiers: Remove sample identifiers from the file.  This zeroes out the sample ID block, if present.
          -set-free-data <a>: Set new 'free data' field. The argument must be a string with length exactly equal to the 
                              length of the existing free data field in each edited file.
```

