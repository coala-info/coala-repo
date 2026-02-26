# marker-magu CWL Generation Report

## marker-magu_markermagu

### Tool Description
Marker-MAGu is a read mapping pipeline which uses marker genes to detect and measure bacteria, phages, archaea, and microeukaryotes.

### Metadata
- **Docker Image**: quay.io/biocontainers/marker-magu:0.4.0--pyhdfd78af_1
- **Homepage**: https://github.com/cmmr/Marker-MAGu
- **Package**: https://anaconda.org/channels/bioconda/packages/marker-magu/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/marker-magu/overview
- **Total Downloads**: 963
- **Last updated**: 2025-07-14
- **GitHub**: https://github.com/cmmr/Marker-MAGu
- **Stars**: N/A
### Original Help Text
```text
usage: markermagu [-h] -r READS [READS ...] -s SAMPLE -o OUTPUT_DIR
                  [--version] [-t CPU] [-q QUAL] [-f FILTER_SEQS]
                  [--filter_dir FILTER_DIR] [--temp TEMP_DIR] [--keep KEEP]
                  [--db DB] [--detection {default,relaxed}]

Marker-MAGu is a read mapping pipeline which uses marker genes to detect and
measure bacteria, phages, archaea, and microeukaryotes. Version 0.4.0

options:
  -h, --help            show this help message and exit

 REQUIRED ARGUMENTS for Marker-MAGu :
  -r READS [READS ...], --reads READS [READS ...]
                        read file(s) in .fastq format. You can specify more
                        than one separated by a space
  -s SAMPLE, --sample SAMPLE
                        Sample name. No space characters, please.
  -o OUTPUT_DIR, --output_dir OUTPUT_DIR
                        Output directory name. Will be created if it does not
                        exist. Can be shared with other samples. No space
                        characters, please.

 OPTIONAL ARGUMENTS for Marker-MAGu.:
  --version             show program's version number and exit
  -t CPU, --cpu CPU     Default: 20 -- Example: 32 -- Number of CPUs available
                        for Marker-MAGu.
  -q QUAL, --qual QUAL  True or False. Remove low-quality reads with fastp?
  -f FILTER_SEQS, --filter_seqs FILTER_SEQS
                        True or False. Remove reads aligning to sequences at
                        filter_seqs/filter_seqs.fna ?
  --filter_dir FILTER_DIR
                        path to directory of sequences to filter. If not set,
                        Marker-MAGu looks for environmental variable
                        MARKERMAGU_FILTER. Then, if this variable is unset, it
                        this is unset, DB path is assumed to be
                        /usr/local/lib/python3.10/site-packages/markermagu
  --temp TEMP_DIR       path of temporary directory. Default is
                        {OUTPUT_DIR}/{SAMPLE}_temp/
  --keep KEEP           True of False. Keep the intermediate files, located in
                        the temporary directory? These can add up, so it is
                        not recommended if space is a concern.
  --db DB               DB path. If not set, Marker-MAGu looks for
                        environmental variable MARKERMAGU_DB. Then, if this
                        variable is unset, it this is unset, DB path is
                        assumed to be /usr/local/lib/python3.10/site-
                        packages/markermagu
  --detection {default,relaxed}
                        Stringency of SGB detection. "default" setting
                        requires >=75 percent of marker genes with at least 1
                        read mapped. "relaxed" setting requires >= 33.3
                        percent of marker genes with at least 1 read mapped
                        AND at least 3 marker genes detected.
```

