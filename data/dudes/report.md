# dudes CWL Generation Report

## dudes

### Tool Description
DUDes is a tool for taxonomic profiling of sequencing reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/dudes:0.10.0--pyhdfd78af_0
- **Homepage**: https://github.com/pirovc/dudes
- **Package**: https://anaconda.org/channels/bioconda/packages/dudes/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/dudes/overview
- **Total Downloads**: 24.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/pirovc/dudes
- **Stars**: N/A
### Original Help Text
```text
usage: dudes [-h] (-s <sam_file> | -c <custom_blast_file>) -d <database_file>
             [-i <sam_format>] [-t <threads>] [-x <taxid_start>]
             [-m <max_read_matches>] [-a <min_reference_matches>]
             [-l <last_rank>] [-b <bin_size>] [-o <output_prefix>] [--debug]
             [--debug_plots_dir DEBUG_PLOTS_DIR] [-v]

options:
  -h, --help            show this help message and exit
  -s <sam_file>         Alignment/mapping file in SAM format. DUDes does not
                        depend on any specific read mapper, but it requires
                        header information (@SQ
                        SN:gi|556555098|ref|NC_022650.1| LN:55956) and
                        mismatch information (check -i)
  -c <custom_blast_file>
                        Alignment/mapping file in custom BLAST format. The
                        required columns and their order are: 'qseqid',
                        'sseqid', 'slen', 'sstart', 'evalue'. Additional
                        columns are ignored. Example command for creating
                        appropriate file with diamond: 'diamond blastp -q
                        {query_fasta} -d {diamond_database} --outfmt 6 qseqid
                        sseqid slen sstart evalue'
  -d <database_file>    Database file (output from DUDesDB [.npz])
  -i <sam_format>       SAM file format, ignored for cumstom blast files
                        ['nm': sam file with standard cigar string plus NM
                        flag (NM:i:[0-9]*) for mismatches count | 'ex': just
                        the extended cigar string]. Default: 'nm'
  -t <threads>          # of threads. Default: 1
  -x <taxid_start>      Taxonomic Id used to start the analysis (1 = root).
                        Default: 1
  -m <max_read_matches>
                        Keep reads up to this number/percentile of matches (0:
                        off / 0-1: percentile / >=1: match count). Default: 0
  -a <min_reference_matches>
                        Minimum number/percentage of supporting matches to
                        consider the reference (0: off / 0-1: percentage /
                        >=1: read number). Default: 0.001
  -l <last_rank>        Last considered rank [superkingdom,phylum,class,order,
                        family,genus,species,strain]. Default: 'species'
  -b <bin_size>         Bin size (0-1: percentile from the lengths of all
                        references in the database / >=1: bp). Default: 0.25
  -o <output_prefix>    Output prefix. Default: STDOUT
  --debug               print debug info to STDERR
  --debug_plots_dir DEBUG_PLOTS_DIR
                        path to directory for writing debug plots to.
  -v                    show program's version number and exit
```

