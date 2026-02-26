# koeken CWL Generation Report

## koeken_koeken.py

### Tool Description
Performs Linear Discriminant Analysis (LEfSe) on A Longitudinal Dataset.

### Metadata
- **Docker Image**: quay.io/biocontainers/koeken:0.2.6--py27h24bf2e0_1
- **Homepage**: https://github.com/twbattaglia/koeken
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/koeken/overview
- **Total Downloads**: 6.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/twbattaglia/koeken
- **Stars**: N/A
### Original Help Text
```text
usage: koeken.py [-h] [-v] [-d] -i INPUT_BIOM -o OUTPUTDIR -m MAP_FP
                 [-l {2,3,4,5,6,7}] -cl CLASSID [-sc SUBCLASSID]
                 [-su SUBJECTID] [-p P_CUTOFF] [-e LDA_CUTOFF] [-str {0,1}]
                 [-c COMPARE [COMPARE ...]] -sp SPLIT [-pc]
                 [-it {png,pdf,svg}] [-dp DPI] [-pi]

Performs Linear Discriminant Analysis (LEfSe) on A Longitudinal Dataset.

optional arguments:
  -h, --help            show this help message and exit
  -v, --version         show program's version number and exit
  -d, --debug           Enable debugging
  -i INPUT_BIOM, --input INPUT_BIOM
                        Location of the OTU Table for main analysis. (Must be
                        .biom format)
  -o OUTPUTDIR, --output OUTPUTDIR
                        Location of the folder to place all resulting files.
                        If folder does not exist, the program will create it.
  -m MAP_FP, --map MAP_FP
                        Location of the mapping file associated with OTU
                        Table.
  -l {2,3,4,5,6,7}, --level {2,3,4,5,6,7}
                        Level for which to use for summarize_taxa.py. [default
                        = 6]
  -cl CLASSID, --class CLASSID
                        Location of the OTU Table for main analysis. (Must be
                        .biom format)
  -sc SUBCLASSID, --subclass SUBCLASSID
                        Directory to place all the files.
  -su SUBJECTID, --subject SUBJECTID
                        Only change if your Sample-ID column names differs.
                        [default] = #SampleID.
  -p P_CUTOFF, --pval P_CUTOFF
                        Change alpha value for the Anova test (default 0.05)
  -e LDA_CUTOFF, --effect LDA_CUTOFF
                        Change the cutoff for logarithmic LDA score (default
                        2.0).
  -str {0,1}, --strict {0,1}
                        Change the strictness of the comparisons. Can be
                        changed to less strict (1). [default = 0](more-
                        strict).
  -c COMPARE [COMPARE ...], --compare COMPARE [COMPARE ...]
                        Which groups should be kept to be compared against one
                        another. [default = all factors]
  -sp SPLIT, --split SPLIT
                        The name of the timepoint variable in you mapping
                        file. This variable will be used to split the table
                        for each value in this variable.
  -pc, --clade          Plot Lefse Cladogram for each output time point.
                        Outputs are placed in a new folder created in the
                        lefse results location.
  -it {png,pdf,svg}, --image {png,pdf,svg}
                        Set the file type for the image create when using
                        cladogram setting
  -dp DPI, --dpi DPI    Set DPI resolution for cladogram
  -pi, --picrust        Run analysis with PICRUSt biom file. Must use the
                        cateogirze by function level 3. Next updates will
                        reflect the difference levels.
```

