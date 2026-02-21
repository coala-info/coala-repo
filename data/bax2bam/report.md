# bax2bam CWL Generation Report

## bax2bam

### Tool Description
bax2bam converts the legacy PacBio basecall format (bax.h5) into the BAM basecall format.

### Metadata
- **Docker Image**: quay.io/biocontainers/bax2bam:0.0.11--0
- **Homepage**: https://github.com/PacificBiosciences/bax2bam
- **Package**: https://anaconda.org/channels/bioconda/packages/bax2bam/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bax2bam/overview
- **Total Downloads**: 15.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/PacificBiosciences/bax2bam
- **Stars**: N/A
### Original Help Text
```text
Usage: bax2bam [options]

bax2bam converts the legacy PacBio basecall format (bax.h5) into the BAM
basecall format.

Options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit

  Input/output files:
    movie.1.bax.h5 movie.2.bax.h5 ...
                        Input files which should be from the same movie
    --xml=STRING        DataSet XML file containing a list of movie names
    -f STRING, --fofn=STRING
                        File-of-file-names containing a list of input files
    -o STRING           Prefix of output filenames. Movie name will be used if
                        no prefix provided
    --output-xml=STRING
                        Explicit output XML name. If none provided via this arg,
                        bax2bam will use -o prefix (<prefix>.dataset.xml). If
                        that is not specified either, the output XML filename
                        will be <moviename>.dataset.xml

  Output read types (mutually exclusive):
    --subread           Output subreads (default)
    --hqregion          Output HQ regions
    --polymeraseread    Output full polymerase read
    --ccs               Output CCS sequences (requires ccs.h5 input)

  Pulse feature options:
    Configure pulse features in the output BAM. Supported features include:
        Pulse Feature:    BAM tag:  Default:
        DeletionQV        dq        Y
        DeletionTag       dt        Y
        InsertionQV       iq        Y
        IPD               ip        Y
        PulseWidth        pw        Y*
        MergeQV           mq        Y
        SubstitutionQV    sq        Y
        SubstitutionTag   st        N
    
    * - PulseWidth will be ignored in CCS mode.
    
    If this option is used, then only those features listed will be included,
    regardless of the default state.

    --pulsefeatures=STRING
                        Comma-separated list of desired pulse features, using
                        the names listed above.
                        
    --losslessframes    Store full, 16-bit IPD/PulseWidth data, instead of
                        (default) downsampled, 8-bit encoding.

  Output BAM file type:
    --internal          Output BAMs in internal mode. Currently this indicates
                        that non-sequencing ZMWs should be included in the
                        output scraps BAM file, if applicable.

  Additional options:
    --allowUnrecognizedChemistryTriple
                        By default, bax2bam only allows the conversion of files
                        with chemistries that are supported in SMRT Analysis 3.
                        Set this flag to disable the strict check and allow
                        generation of BAM files containing legacy chemistries.
```


## Metadata
- **Skill**: generated
