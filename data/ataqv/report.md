# ataqv CWL Generation Report

## ataqv

### Tool Description
QC metrics for ATAC-seq data

### Metadata
- **Docker Image**: quay.io/biocontainers/ataqv:1.3.1--py310h50a2689_5
- **Homepage**: https://parkerlab.github.io/ataqv/
- **Package**: https://anaconda.org/channels/bioconda/packages/ataqv/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ataqv/overview
- **Total Downloads**: 47.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/ParkerLab/ataqv
- **Stars**: N/A
### Original Help Text
```text
ataqv 1.3.1: QC metrics for ATAC-seq data

Usage:

ataqv [options] organism alignment-file

where:
    organism is the subject of the experiment, which determines the list of autosomes
    (see "Reference Genome Configuration" below).

    alignment-file is a BAM file with duplicate reads marked.

Basic options
-------------

--help: show this usage message.
--verbose: show more details and progress updates.
--version: print the version of the program.
--threads <n>: the maximum number of threads to use (right now, only for calculating TSS enrichment).

Optional Input
--------------

--peak-file "file name"
    A BED file of peaks called for alignments in the BAM file. Specify "auto" to use the
    BAM file name with ".peaks" appended, or if the BAM file contains read groups, to
    assume each read group has a peak file whose name is the read group ID with ".peaks"
    appended. If you specify a single filename instead of "auto" with read groups, the 
    same peaks will be used for all reads -- be sure this is what you want.

--tss-file "file name"
    A BED file of transcription start sites for the experiment organism. If supplied,
    a TSS enrichment score will be calculated according to the ENCODE data standards.
    This calculation requires that the BAM file of alignments be indexed.

--tss-extension "size"
    If a TSS enrichment score is requested, it will be calculated for a region of 
    "size" bases to either side of transcription start sites. The default is 1000bp.

--excluded-region-file "file name"
    A BED file containing excluded regions. Peaks or TSS overlapping these will be ignored.
    May be given multiple times.

Output
------

--metrics-file "file name"
    The JSON file to which metrics will be written. The default filename will be based on
    the BAM file, with the suffix ".ataqv.json".

--log-problematic-reads
    If given, problematic reads will be logged to a file per read group, with names
    derived from the read group IDs, with ".problems" appended. If no read groups
    are found, the reads will be written to one file named after the BAM file.

--less-redundant
    If given, output a subset of metrics that should be less redundant. If this flag is used,
    the same flag should be passed to mkarv when making the viewer.

Metadata
--------

The following options provide metadata to be included in the metrics JSON file.
They make it easier to compare results in the ataqv web interface.

--name "name"
    A label to be used for the metrics when there are no read groups. If there are read
    groups, each will have its metrics named using its ID field. With no read groups and
    no --name given, your metrics will be named after the alignment file.

--ignore-read-groups
    Even if read groups are present in the BAM file, ignore them and combine metrics
    for all reads under a single sample and library named with the --name option. This
    also implies that a single peak file will be used for all reads; see the --peak option.

--nucleus-barcode-tag "nucleus_barcode_tag"
    Data is single-nucleus, with the barcode stored in this BAM tag.
    In this case, metrics will be collected per barcode.

--description "description"
    A short description of the experiment.

--url "URL"
    A URL for more detail on the experiment (perhaps using a DOI).

--library-description "description"
    Use this description for all libraries in the BAM file, instead of using the DS
    field from each read group.


Reference Genome Configuration
------------------------------

ataqv includes lists of autosomes for several organisms:

    Organism  Autosomal References
     -------  ------------------
         fly  2R 2L 3R 3L 4 
       human  1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 
       mouse  1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 
         rat  1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 
        worm  I II III IV V 
       yeast  I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI 

    The default autosomal reference lists contain names with "chr" prefixes
    ("chr1") and without ("1"). If you need a different set of autosomes, you can
    supply a list with --autosomal-reference-file.

--autosomal-reference-file "file name"
    A file containing autosomal reference names, one per line. The names must match
    the reference names in the alignment file exactly, or the metrics based on counts
    of autosomal alignments will be wrong.

--mitochondrial-reference-name "name"
    If the reference name for mitochondrial DNA in your alignment file is not "chrM",.
    use this option to supply the correct name. Again, if this name is wrong, all the
    measurements involving mitochondrial alignments will be wrong.
```

