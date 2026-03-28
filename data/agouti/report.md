# agouti CWL Generation Report

## agouti_create_db

### Tool Description
Create a genomic annotation database from GTF or GFF3 files

### Metadata
- **Docker Image**: quay.io/biocontainers/agouti:1.0.3--pyhdfd78af_0
- **Homepage**: https://github.com/zywicki-lab/agouti
- **Package**: https://anaconda.org/channels/bioconda/packages/agouti/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/agouti/overview
- **Total Downloads**: 6.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/zywicki-lab/agouti
- **Stars**: N/A
### Original Help Text
```text
usage: agouti create_db [-h] -a ANNOTATION -f {GTF,GFF3} -d DATABASE [-l] [-i]
                        [-j]

optional arguments:
  -h, --help            show this help message and exit
  -a ANNOTATION, --annotation ANNOTATION
                        input file with the genomic annotation in either GTF
                        or GFF3
  -f {GTF,GFF3}, --format {GTF,GFF3}
                        format of the input file with the genomic annotation
  -d DATABASE, --db DATABASE
                        name for the output database
  -l, --low-ram         enable low-memory mode of the database creation
                        process (warning: slow!)
  -i, --infer_genes     infer gene features. Use only with GTF files that do
                        not have lines describing genes (warning: slow!)
  -j, --infer_transcripts
                        infer transcript features. Use only with GTF files
                        that do not have lines describing transcripts
                        (warning: slow!)
```


## agouti_annotate

### Tool Description
Annotate BED or custom column-based files using a database created with agouti create_db.

### Metadata
- **Docker Image**: quay.io/biocontainers/agouti:1.0.3--pyhdfd78af_0
- **Homepage**: https://github.com/zywicki-lab/agouti
- **Package**: https://anaconda.org/channels/bioconda/packages/agouti/overview
- **Validation**: PASS

### Original Help Text
```text
usage: agouti annotate [-h] -i BED -d DATABASE [-m CUSTOM] [-p SEP] [-b {0,1}]
                       [-n HEADER_LINES] [-t] [-f FEATURES] [-a ATTRIBUTES]
                       [-c COMBINE] [-s] [-w] [-l {1,2}] [-r] [--statistics]
                       [--stats_only]

optional arguments:
  -h, --help            show this help message and exit
  -i BED, --input BED   input file in BED or another column-based format
                        (see --custom).
  -d DATABASE, --database DATABASE
                        database file created with the agouti create_db run
                        mode
  -m CUSTOM, --custom CUSTOM
                        the input text file is in custom format, other than
                        BED. It should contain columns with information about
                        feature id (id), chromosome (chr), start (s) and end
                        (e) coordinates, and optionally about strand. User
                        should provide the proper column indexes (starting
                        from 1) in order: "id,chr,s,e[,strand]". The index of
                        the strand column is optional. Example use: --custom
                        1,2,4,5,6 or --custom 1,2,4,5. The field separator
                        used in a text file can be specified using the
                        --separator option
  -p SEP, --separator SEP
                        field separator to be used with the --custom option.
                        Default is "\t"
  -b {0,1}, --coordinates {0,1}
                        indicate the coordinate system used in the input file
                        (BED/CUSTOM). Either 0 (0-based coordinates) or 1
                        (1-based coordinates). Default is 0
  -n HEADER_LINES, --header_lines HEADER_LINES
                        the number of header lines in the input file. Default
                        is 0
  -t, --transcriptomic  transcriptomic annotation mode. In this mode,
                        transcript IDs from the GTF/GFF3 are expected to be
                        placed in the first column of provided BED file
                        instead of chromosome names. Coordinates in this mode
                        are assumed to reflect positions within the transcript
  -f FEATURES, --select_features FEATURES
                        comma-separated list of feature names to be reported,
                        e.g., "mRNA,CDS". Refer to
                        [db_name].database.structure.txt file for a list of
                        valid features. By default, all features are reported
  -a ATTRIBUTES, --select_attributes ATTRIBUTES
                        comma-separated list of attribute names to be
                        reported, e.g., "ID,description". Refer to
                        [db_name].database.structure.txt file for a list of
                        valid attributes. By default, all attributes are
                        reported
  -c COMBINE, --combine COMBINE
                        list of specific feature-attribute combinations to be
                        reported. The combinations should be specified in the
                        format:
                        feature1-attribute1:attribute2,feature2-attribute1,
                        e.g. "mRNA-ID:description,CDS-ID
  -s, --strand_specific
                        strand-specific search
  -w, --completly_within
                        the annotated BED interval must be located entirely
                        within the GTF/GFF3 feature. By default, any overlap
                        is sufficient to trigger annotation
  -l {1,2}, --level {1,2}
                        annotate results on a specific level (1 for gene
                        level, 2 for mRNA, tRNA level, etc.). For available
                        levels, refer to the tree-like representation of
                        features in [db_name].database.structure.txt file.
                        Please note that --level 1 cannot be combined with
                        –transcriptomic mode. Default is 2
  -r, --annotate_relative_location
                        annotate the relative location of the interval within
                        the feature. Designed to work with –transcriptomic
                        mode
  --statistics          calculate additional feature statistics. Those will be
                        displayed on the stderr
  --stats_only          calculate and display only feature statistics. No
                        annotation will be performed.
```


## Metadata
- **Skill**: generated
