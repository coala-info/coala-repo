# portcullis CWL Generation Report

## portcullis_full

### Tool Description
Runs prep, junc, filter, and optionally bamfilt, as a complete pipeline. Assumes that the self-trained machine learning approach for filtering is to be used.

### Metadata
- **Docker Image**: quay.io/biocontainers/portcullis:1.2.4--py39hc87ae8a_4
- **Homepage**: https://github.com/maplesond/portcullis
- **Package**: https://anaconda.org/channels/bioconda/packages/portcullis/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/portcullis/overview
- **Total Downloads**: 250.6K
- **Last updated**: 2025-09-09
- **GitHub**: https://github.com/maplesond/portcullis
- **Stars**: N/A
### Original Help Text
```text
Portcullis V1.2.4

Portcullis Full Pipeline Mode Help

Runs prep, junc, filter, and optionally bamfilt, as a complete pipeline.  Assumes
that the self-trained machine learning approach for filtering is to be used.

Usage: portcullis full [options] <genome-file> (<bam-file>)+

System options:
  -t [ --threads ] arg (=1)             The number of threads to use.  Note that increasing the number of threads will also increase memory requirements.  Default: 1
  -v [ --verbose ]                      Print extra information
  --help                                Produce help message

Output options:
  -o [ --output ] arg (="portcullis_out")
                                        Output directory. Default: portcullis_out
  -b [ --bam_filter ]                   Filter out alignments corresponding with false junctions.  Warning: this is time consuming; make sure you really want to do this first!
  --exon_gff                            Output exon-based junctions in GFF format.
  --intron_gff                          Output intron-based junctions in GFF format.
  --source arg (=portcullis)            The value to enter into the "source" field in GFF files.

Input options:
  --force                               Whether or not to clean the output directory before processing, thereby forcing full preparation of the genome and bam files.  By default portcullis will only do what it thinks it needs to.
  --copy                                Whether to copy files from input data to prepared data where possible, otherwise will use symlinks.  Will require more time and disk space to prepare input but is potentially more robust.
  --keep_temp                           Whether keep any temporary files created during the prepare stage of portcullis.  This might include BAM files and indexes.
  --use_csi                             Whether to use CSI indexing rather than BAI indexing.  CSI has the advantage that it supports very long target sequences (probably not an issue unless you are working on huge genomes).  BAI has the advantage that it is more widely supported (useful for viewing in genome browsers).

Analysis options:
  --orientation arg (=UNKNOWN)          The orientation of the reads that produced the BAM alignments: "F" (Single-end forward orientation); "R" (single-end reverse orientation); "FR" (paired-end, with reads sequenced towards center of fragment -> <-.  This is usual setting for most Illumina paired end sequencing); "RF" (paired-end, reads sequenced away from center of fragment <- ->); "FF" (paired-end, reads both sequenced in forward orientation); "RR" (paired-end, reads both sequenced in reverse orientation); "UNKNOWN" (default, portcullis will workaround any calculations requiring orientation information)
  --strandedness arg (=UNKNOWN)         Whether BAM alignments were generated using a type of strand specific RNAseq library: "unstranded" (Standard Illumina); "firststrand" (dUTP, NSR, NNSR); "secondstrand" (Ligation, Standard SOLiD, flux sim reads); "UNKNOWN" (default, portcullis will workaround any calculations requiring strandedness information)
  --separate                            Separate spliced from unspliced reads.
  --extra                               Calculate additional metrics that take some time to generate.  Automatically activates BAM splitting mode (--separate).

Filtering options:
  -r [ --reference ] arg                Reference annotation of junctions in BED format.  Any junctions found by the junction analysis tool will be preserved if found in this reference file regardless of any other filtering criteria.  If you need to convert a reference annotation from GTF or GFF to BED format portcullis contains scripts for this.
  --max_length arg (=0)                 Filter junctions longer than this value.  Default (0) is to not filter based on length.
  --canonical arg (=OFF)                Keep junctions based on their splice site status.  Valid options: OFF,C,S,N. Where C = Canonical junctions (GT-AG), S = Semi-canonical junctions (AT-AC, or  GC-AG), N = Non-canonical.  OFF means, keep all junctions (i.e. don't filter by canonical status).  User can separate options by a comma to keep two categories.
  --min_cov arg (=1)                    Only keep junctions with a number of split reads greater than or equal to this number
  --save_bad                            Saves bad junctions (i.e. junctions that fail the filter), as well as good junctions (those that pass)
  --training_rule arg (="balanced")     Pre-set to use for the self-training. Currently supported: balanced, precise. Default: balanced.
```


## portcullis_prep

### Tool Description
Prepares a genome and bam file(s) ready for junction analysis. This involves ensuring the bam file is sorted and indexed and the genome file is indexed.

### Metadata
- **Docker Image**: quay.io/biocontainers/portcullis:1.2.4--py39hc87ae8a_4
- **Homepage**: https://github.com/maplesond/portcullis
- **Package**: https://anaconda.org/channels/bioconda/packages/portcullis/overview
- **Validation**: PASS

### Original Help Text
```text
Portcullis V1.2.4

Portcullis Prepare Mode Help.

Prepares a genome and bam file(s) ready for junction analysis.  This involves
ensuring the bam file is sorted and indexed and the genome file is indexed.

Usage: portcullis prep [options] <genome-file> (<bam-file>)+

Options:
  -o [ --output ] arg (="portcullis_prep") Output directory for prepared files.
  --force                                  Whether or not to clean the output directory before processing, thereby forcing full preparation of the genome and bam files.  By default portcullis will only do what it thinks it needs to.
  --copy                                   Whether to copy files from input data to prepared data where possible, otherwise will use symlinks.  Will require more time and disk space to prepare input but is potentially more robust.
  -c [ --use_csi ]                         Whether to use CSI indexing rather than BAI indexing.  CSI has the advantage that it supports very long target sequences (probably not an issue unless you are working on huge genomes).  BAI has the advantage that it is more widely supported (useful for viewing in genome browsers).
  -t [ --threads ] arg (=1)                The number of threads to used to sort the BAM file (if required).  Default: 1
  -v [ --verbose ]                         Print extra information
  --help                                   Produce help message
```


## portcullis_junc

### Tool Description
Analyses all potential junctions found in the input BAM file.

### Metadata
- **Docker Image**: quay.io/biocontainers/portcullis:1.2.4--py39hc87ae8a_4
- **Homepage**: https://github.com/maplesond/portcullis
- **Package**: https://anaconda.org/channels/bioconda/packages/portcullis/overview
- **Validation**: PASS

### Original Help Text
```text
Portcullis V1.2.4

Portcullis Junction Builder Mode Help

Analyses all potential junctions found in the input BAM file.
Run "portcullis prep ..." to generate data suitable for junction finding
before running "portcullis junc ..."

Usage: portcullis junc [options] <prep_data_dir>

System options:
  -t [ --threads ] arg (=1)             The number of threads to use.  Note that increasing the number of threads will also increase memory requirements.
  --separate                            Separate spliced from unspliced reads.  Creates two new BAM files.
  --orientation arg (=UNKNOWN)          The orientation of the reads that produced the BAM alignments: "F" (Single-end forward orientation); "R" (single-end reverse orientation); "FR" (paired-end, with reads sequenced towards center of fragment -> <-.  This is usual setting for most Illumina paired end sequencing); "RF" (paired-end, reads sequenced away from center of fragment <- ->); "FF" (paired-end, reads both sequenced in forward orientation); "RR" (paired-end, reads both sequenced in reverse orientation); "UNKNOWN" (default, portcullis will workaround any calculations requiring orientation information)
  --strandedness arg (=UNKNOWN)         Whether BAM alignments were generated using a type of strand specific RNAseq library: "unstranded" (Standard Illumina); "firststrand" (dUTP, NSR, NNSR); "secondstrand" (Ligation, Standard SOLiD, flux sim reads); "UNKNOWN" (default, portcullis will workaround any calculations requiring strandedness information)
  -c [ --use_csi ]                      Whether to use CSI indexing rather than BAI indexing.  CSI has the advantage that it supports very long target sequences (probably not an issue unless you are working on huge genomes).  BAI has the advantage that it is more widely supported (useful for viewing in genome browsers).
  -v [ --verbose ]                      Print extra information
  --help                                Produce help message

Output options:
  -o [ --output ] arg (=portcullis_junc/portcullis)
                                        Output prefix for files generated by this program.
  --exon_gff                            Output exon-based junctions in GFF format.
  --intron_gff                          Output intron-based junctions in GFF format.
  --source arg (=portcullis)            The value to enter into the "source" field in GFF files.
```


## portcullis_filt

### Tool Description
Filters out junctions that are unlikely to be genuine or that have too little supporting evidence. The user can control three stages of the filtering process. First the user can perform filtering based on a random forest model self-trained on the provided data, alternatively the user can provide a pre-trained model. Second the user can specify a configuration file describing a set of filtering rules to apply. Third, the user can directly through the command line filter based on junction (intron) length, or the canonical label.

### Metadata
- **Docker Image**: quay.io/biocontainers/portcullis:1.2.4--py39hc87ae8a_4
- **Homepage**: https://github.com/maplesond/portcullis
- **Package**: https://anaconda.org/channels/bioconda/packages/portcullis/overview
- **Validation**: PASS

### Original Help Text
```text
Portcullis V1.2.4

Portcullis Filter Mode Help

Filters out junctions that are unlikely to be genuine or that have too little
supporting evidence.  The user can control three stages of the filtering
process.  First the user can perform filtering based on a random forest model
self-trained on the provided data, alternatively the user can provide a pre-
trained model.  Second the user can specify a configuration file describing a
set of filtering rules to apply.  Third, the user can directly through the
command line filter based on junction (intron) length, or the canonical label.

This stage requires the prep directory and the tab file generated from the
stage as input.

Usage: portcullis filter [options] <prep_data_dir> <junction_tab_file>

System options:
  -t [ --threads ] arg (=1)             The number of threads to use during testing (only applies if using forest model).
  -v [ --verbose ]                      Print extra information
  --help                                Produce help message

Output options:
  -o [ --output ] arg (="portcullis_filter/portcullis")
                                        Output prefix for files generated by this program.
  -b [ --save_bad ]                     Saves bad junctions (i.e. junctions that fail the filter), as well as good junctions (those that pass)
  --exon_gff                            Output exon-based junctions in GFF format.
  --intron_gff                          Output intron-based junctions in GFF format.
  --source arg (=portcullis)            The value to enter into the "source" field in GFF files.

Filtering options:
  -f [ --filter_file ] arg              If you wish to custom rule-based filter the junctions file, use this option to provide a list of the rules you wish to use.  By default we don't filter using a rule-based method, we instead filter via a self-trained random forest model.  See manual for more details.
  -r [ --reference ] arg                Reference annotation of junctions in BED format.  Any junctions found by the junction analysis tool will be preserved if found in this reference file regardless of any other filtering criteria.  If you need to convert a reference annotation from GTF or GFF to BED format portcullis contains scripts for this.
  -n [ --no_ml ]                        Disables machine learning filtering
  --max_length arg (=0)                 Filter junctions longer than this value.  Default (0) is to not filter based on length.
  --canonical arg (=OFF)                Keep junctions based on their splice site status.  Valid options: OFF,C,S,N. Where C = Canonical junctions (GT-AG), S = Semi-canonical junctions (AT-AC, or GC-AG), N = Non-canonical.  OFF means, keep all junctions (i.e. don't filter by canonical status).  User can separate options by a comma to keep two categories.
  --min_cov arg (=1)                    Only keep junctions with a number of split reads greater than or equal to this number
  --threshold arg (=0.5)                The threshold score at which we determine a junction to be genuine or not.  Increase value towards 1.0 to increase precision, decrease towards 0.0 to increase sensitivity.  We generally find that increasing sensitivity helps when using high coverage data, or when the aligner has already performed some form of junction filtering.
  --training_rule arg (="balanced")     Pre-set to use for the self-training. Currently supported: balanced, precise. Default: balanced.
```


## portcullis_bamfilt

### Tool Description
Removes alignments associated with bad junctions from BAM file

### Metadata
- **Docker Image**: quay.io/biocontainers/portcullis:1.2.4--py39hc87ae8a_4
- **Homepage**: https://github.com/maplesond/portcullis
- **Package**: https://anaconda.org/channels/bioconda/packages/portcullis/overview
- **Validation**: PASS

### Original Help Text
```text
Portcullis V1.2.4

Portcullis BAM Filter Mode Help.

Removes alignments associated with bad junctions from BAM file

Usage: portcullis bamfilt [options] <junction-file> <bam-file>

Options:
  -o [ --output ] arg (="filtered.bam") Output BAM file generated by this program.
  -c [ --clip_mode ] arg (=HARD)        How to clip reads associated with bad junctions: "HARD" (Hard clip reads at junction boundary - suitable for cufflinks); "SOFT" (Soft clip reads at junction boundaries); "COMPLETE" (Remove reads associated exclusively with bad junctions, MSRs covering both good and bad junctions are kept)  Default: "HARD"
  -m [ --save_msrs ]                    Whether or not to output modified MSRs to a separate file.  If true will output to a file with name specified by output with ".msr.bam" extension
  -c [ --use_csi ]                      Whether to use CSI indexing rather than BAI indexing.  CSI has the advantage that it supports very long target sequences (probably not an issue unless you are working on huge genomes).  BAI has the advantage that it is more widely supported (useful for viewing in genome browsers).
  -v [ --verbose ]                      Print extra information
  --help                                Produce help message
```

