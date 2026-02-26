# staden_io_lib CWL Generation Report

## staden_io_lib_scramble

### Tool Description
Convert between SAM, BAM, and CRAM formats with compression and indexing options.

### Metadata
- **Docker Image**: biocontainers/staden-io-lib-utils:v1.14.11-6-deb_cv1
- **Homepage**: https://github.com/jkbonfield/io_lib/
- **Package**: https://anaconda.org/channels/bioconda/packages/staden_io_lib/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/staden_io_lib/overview
- **Total Downloads**: 43.5K
- **Last updated**: 2025-07-16
- **GitHub**: https://github.com/jkbonfield/io_lib
- **Stars**: N/A
### Original Help Text
```text
-=- sCRAMble -=-     version 1.14.11
Author: James Bonfield, Wellcome Trust Sanger Institute. 2013-2018

Usage:    scramble [options] [input_file [output_file]]
Options:
    -I format      Set input format:  "bam", "sam" or "cram".
    -O format      Set output format: "bam", "sam" or "cram".
    -1 to -9       Set compression level.
    -0 or -u       No compression.
    -H             [SAM] Do not print header
    -R range       [Cram] Specifies the refseq:start-end range
    -r ref.fa      [Cram] Specifies the reference file.
    -b integer     [Cram] Max. bases per slice, default 5000000.
    -s integer     [Cram] Sequences per slice, default 10000.
    -S integer     [Cram] Slices per container, default 1.
    -V version     [Cram] Specify the file format version to write (eg 1.1, 2.0)
    -e             [Cram] Embed reference sequence.
    -x             [Cram] Non-reference based encoding.
    -M             [Cram] Use multiple references per slice.
    -m             [Cram] Generate MD and NM tags.
    -f             [Cram] Also compression using fqzcomp (V3.1+)
    -n             [Cram] Discard read names where possible.
    -P             Preserve all aux tags (incl RG,NM,MD)
    -p             Preserve aux tag sizes ('i', 's', 'c')
    -q             Don't add scramble @PG header line
    -N integer     Stop decoding after 'integer' sequences
    -t N           Use N threads (availability varies by format)
    -B             Enable Illumina 8 quality-binning system (lossy)
    -!             Disable all checking of checksums
    -g FILE        Convert to Bam using index (file.gzi)
    -G FILE        Output Bam index when bam input(file.gzi)
```


## staden_io_lib_scram_flagstat

### Tool Description
Calculates flag statistics for BAM, SAM, or CRAM files.

### Metadata
- **Docker Image**: biocontainers/staden-io-lib-utils:v1.14.11-6-deb_cv1
- **Homepage**: https://github.com/jkbonfield/io_lib/
- **Package**: https://anaconda.org/channels/bioconda/packages/staden_io_lib/overview
- **Validation**: PASS

### Original Help Text
```text
-=- scram_flagstat -=-     version 1.14.11
Author: James Bonfield, Wellcome Trust Sanger Institute. 2013

Usage:    scram_flagstat [options] [input_file]
Options:
    -I format      Set input format:  "bam", "sam" or "cram".
    -R range       [Cram] Specifies the refseq:start-end range
    -r ref.fa      [Cram] Specifies the reference file.
    -t N           Use N threads (availability varies by format)
```

