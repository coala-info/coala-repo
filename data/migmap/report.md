# migmap CWL Generation Report

## migmap

### Tool Description
MIGMAP aligns immune receptor sequences to reference databases.

### Metadata
- **Docker Image**: quay.io/biocontainers/migmap:1.0.3--0
- **Homepage**: https://github.com/mikessh/migmap
- **Package**: https://anaconda.org/channels/bioconda/packages/migmap/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/migmap/overview
- **Total Downloads**: 19.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/mikessh/migmap
- **Stars**: N/A
### Original Help Text
```text
usage: migmap [options] input.(fa/fastq)[.gz] (output_file/- for stdout)
    --all-alleles                       Will use all alleles during
                                        alignment (this is going to be
                                        slower). [default = use only major
                                        (*01) alleles]
    --allow-incomplete                  Report clonotypes with partial
                                        CDR3 mapping.
    --allow-no-cdr3                     Report clonotypes with no CDR3
                                        mapping.
    --allow-noncanonical                Report clonotypes that have
                                        non-canonical CDR3 (do not start
                                        with C or end with F/W residues).
    --allow-noncoding                   Report clonotypes that have either
                                        stop codon or frameshift in their
                                        receptor sequence.
    --blast-dir <path>                  Path to folder that contains
                                        'igblastn' and 'makeblastdb'
                                        binaries. [default = assume they
                                        are added to $PATH and execute
                                        them directly]
    --by-read                           Will output mapping details for
                                        each read. [default = assemble
                                        clonotypes and output clonotype
                                        abundance table]
    --custom-database <path>            Path to a custom segments
                                        database. [default = use built-in
                                        database]
    --data-dir <path>                   Path to folder that contains data
                                        bundle (internal_data/ and
                                        optional_file/ directories).
                                        [default = $install_dir/data/]
    --details <field1,field2,.../all>   Additional fields to provide for
                                        output, allowed values:
                                        fr1nt,cdr1nt,fr2nt,cdr2nt,fr3nt,fr
                                        4nt,contignt,fr1aa,cdr1aa,fr2aa,cd
                                        r2aa,fr3aa,fr4aa,contigaa.
 -h                                     Display this help message
 -n <int>                               Number of reads to take. [default
                                        = all]
 -p <int>                               Number of cores to use. [default =
                                        all available processors]
 -q <2..40>                             Threshold for average quality of
                                        mutations and N-regions of CDR3
                                        [default = 25]
 -R <chain1,...>                        Receptor gene and chain. Several
                                        chains can be specified, separated
                                        with commas. Allowed values: [TRA,
                                        TRB, TRG, TRD, IGH, IGL, IGK].
                                        [required]
    --report <file>                     File to store MIGMAP report. Will
                                        append report line if file exists.
 -S <name>                              Species. Allowed values: [human,
                                        mouse, rat, rabbit,
                                        rhesus_monkey]. [required]
    --unmapped <fastq[.gz]>             Output unmapped reads in specified
                                        file.
    --use-kabat                         Will use KABAT nomenclature for
                                        CDR/FW partitioning. [default =
                                        use IMGT nomenclature]
```

