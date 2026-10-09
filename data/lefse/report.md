# lefse CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| lefse_lefse2circlader.py | PASS | converted the HMP LEfSe result to Circlader input (1091 rows) |
| lefse_lefse_format_input.py | PASS | ran on the HMP aerobiosis example table; formatted file feeds lefse_run |
| lefse_lefse_plot_cladogram.py | PASS | baseCommand fixed (plot_cladogram.py does not exist); cladogram of the HMP result is correct |
| lefse_lefse_plot_features.py | PASS | ran on the HMP example data; one image per biomarker (51 files) |
| lefse_lefse_plot_res.py | PASS | ran on the HMP example result; bar plot of 51 biomarkers is correct |
| lefse_lefse_run.py | Failed | tool bug: the -o option writes no text file; the main run finds the same 51 biomarkers and classes as the expected HMP result |
| lefse_qiime2lefse.py | PASS | synthetic data: small QIIME OTU table and metadata cut from the HMP example; output has class rows and taxa rows |

## lefse_lefse_run.py

### Tool Description
LEfSe: linear discriminant analysis effect size, to find biomarkers that explain differences between classes.

### Metadata
- **Docker Image**: quay.io/biocontainers/lefse:1.1.2--pyhdfd78af_0
- **Homepage**: https://github.com/SegataLab/lefse
- **Package**: https://anaconda.org/channels/bioconda/packages/lefse/overview
- **Validation**: PASS

### Original Help Text
```text
usage: lefse_run.py [-h] [-o str] [-a float] [-w float] [-l float]
                    [--nlogs int] [--verbose int] [--wilc int] [-r str]
                    [--svm_norm int] [-b int] [-e int] [-c int] [-f float]
                    [-s {0,1,2}] [--min_c int] [-t str] [-y {0,1}]
                    INPUT_FILE OUTPUT_FILE

LEfSe 1.1.01

positional arguments:
  INPUT_FILE      the input file
  OUTPUT_FILE     the output file containing the data for the visualization
                  module

optional arguments:
  -h, --help      show this help message and exit
  -o str          set the file for exporting the result (only concise textual
                  form)
  -a float        set the alpha value for the Anova test (default 0.05)
  -w float        set the alpha value for the Wilcoxon test (default 0.05)
  -l float        set the threshold on the absolute value of the logarithmic
                  LDA score (default 2.0)
  --nlogs int     max log ingluence of LDA coeff
  --verbose int   verbose execution (default 0)
  --wilc int      wheter to perform the Wicoxon step (default 1)
  -r str          select LDA or SVM for effect size (default LDA)
  --svm_norm int  whether to normalize the data in [0,1] for SVM feature
                  waiting (default 1 strongly suggested)
  -b int          set the number of bootstrap iteration for LDA (default 30)
  -e int          set whether perform the wilcoxon test only among the
                  subclasses with the same name (default 0)
  -c int          set whether perform the wilcoxon test ing the Curtis's
                  approach [BETA VERSION] (default 0)
  -f float        set the subsampling fraction value for each bootstrap
                  iteration (default 0.66666)
  -s {0,1,2}      set the multiple testing correction options. 0 no correction
                  (more strict, default), 1 correction for independent
                  comparisons, 2 correction for dependent comparison
  --min_c int     minimum number of samples per subclass for performing
                  wilcoxon test (default 10)
  -t str          set the title of the analysis (default input file without
                  extension)
  -y {0,1}        (for multiclass tasks) set whether the test is performed in
                  a one-against-one ( 1 - more strict!) or in a one-against-
                  all setting ( 0 - less strict) (default 0)
```

## lefse_lefse_format_input.py

### Tool Description
Format a feature table (features on rows or columns, with class, subclass and subject rows) for LEfSe.

### Metadata
- **Docker Image**: quay.io/biocontainers/lefse:1.1.2--pyhdfd78af_0
- **Homepage**: https://github.com/SegataLab/lefse
- **Package**: https://anaconda.org/channels/bioconda/packages/lefse/overview
- **Validation**: PASS

### Original Help Text
```text
usage: lefse_format_input.py [-h] [--output_table OUTPUT_TABLE] [-f {c,r}]
                             [-c [1..n_feats]] [-s [1..n_feats]] [-o float]
                             [-u [1..n_feats]] [-m {f,s}] [-n int]
                             [-biom_c BIOM_CLASS] [-biom_s BIOM_SUBCLASS]
                             INPUT_FILE OUTPUT_FILE

LEfSe formatting modules

positional arguments:
  INPUT_FILE            the input file, feature hierarchical level can be
                        specified with | or . and those symbols must not be
                        present for other reasons in the input file.
  OUTPUT_FILE           the output file containing the data for LEfSe

optional arguments:
  -h, --help            show this help message and exit
  --output_table OUTPUT_TABLE
                        the formatted table in txt format
  -f {c,r}              set whether the features are on rows (default) or on
                        columns
  -c [1..n_feats]       set which feature use as class (default 1)
  -s [1..n_feats]       set which feature use as subclass (default -1 meaning
                        no subclass)
  -o float              set the normalization value (default -1.0 meaning no
                        normalization)
  -u [1..n_feats]       set which feature use as subject (default -1 meaning
                        no subject)
  -m {f,s}              set the policy to adopt with missing values: f removes
                        the features with missing values, s removes samples
                        with missing values (default f)
  -n int                set the minimum cardinality of each subclass
                        (subclasses with low cardinalities will be grouped
                        together, if the cardinality is still low, no pairwise
                        comparison will be performed with them)
  -biom_c BIOM_CLASS    For biom input files: Set which feature use as class
  -biom_s BIOM_SUBCLASS
                        For biom input files: set which feature use as
                        subclass
```

## lefse_lefse_plot_res.py

### Tool Description
Plot the LEfSe result as a histogram of the effect sizes (LDA scores).

### Metadata
- **Docker Image**: quay.io/biocontainers/lefse:1.1.2--pyhdfd78af_0
- **Homepage**: https://github.com/SegataLab/lefse
- **Package**: https://anaconda.org/channels/bioconda/packages/lefse/overview
- **Validation**: PASS

### Original Help Text
```text
usage: lefse_plot_res.py [-h] [--feature_font_size FEATURE_FONT_SIZE]
                         [--format {png,svg,pdf}] [--dpi DPI] [--title TITLE]
                         [--title_font_size TITLE_FONT_SIZE]
                         [--class_legend_font_size CLASS_LEGEND_FONT_SIZE]
                         [--width WIDTH] [--height HEIGHT] [--left_space LS]
                         [--right_space RS] [--orientation {h,v}]
                         [--autoscale {0,1}] [--background_color {k,w}]
                         [--subclades N_SCL]
                         [--max_feature_len MAX_FEATURE_LEN]
                         [--all_feats ALL_FEATS] [--otu_only]
                         [--report_features]
                         INPUT_FILE OUTPUT_FILE

Plot results

positional arguments:
  INPUT_FILE            tab delimited input file
  OUTPUT_FILE           the file for the output image

optional arguments:
  -h, --help            show this help message and exit
  --feature_font_size FEATURE_FONT_SIZE
                        the file for the output image
  --format {png,svg,pdf}
                        the format for the output file
  --dpi DPI
  --title TITLE
  --title_font_size TITLE_FONT_SIZE
  --class_legend_font_size CLASS_LEGEND_FONT_SIZE
  --width WIDTH
  --height HEIGHT       only for vertical histograms
  --left_space LS
  --right_space RS
  --orientation {h,v}
  --autoscale {0,1}
  --background_color {k,w}
                        set the color of the background
  --subclades N_SCL     number of label levels to be dislayed (starting from
                        the leaves, -1 means all the levels, 1 is default )
  --max_feature_len MAX_FEATURE_LEN
                        Maximum length of feature strings (def 60)
  --all_feats ALL_FEATS
  --otu_only            Plot only species resolved OTUs (as opposed to all
                        levels)
  --report_features     Report important features to STDOUT
```

## lefse_lefse_plot_features.py

### Tool Description
Plot the raw-data representation of the features found by LEfSe.

### Metadata
- **Docker Image**: quay.io/biocontainers/lefse:1.1.2--pyhdfd78af_0
- **Homepage**: https://github.com/SegataLab/lefse
- **Package**: https://anaconda.org/channels/bioconda/packages/lefse/overview
- **Validation**: PASS

### Original Help Text
```text
usage: lefse_plot_features.py [-h] [--width WIDTH] [--height HEIGHT]
                              [--top TOP] [--bot BOT]
                              [--title_font_size TITLE_FONT_SIZE]
                              [--class_font_size CLASS_FONT_SIZE]
                              [--class_label_pos {up,down}]
                              [--subcl_mean {y,n}] [--subcl_median {y,n}]
                              [--font_size FONT_SIZE] [-n flt]
                              [--format {png,pdf,svg}] [-f {all,diff,one}]
                              [--feature_name FEATURE_NAME]
                              [--feature_num FEATURE_NUM]
                              [--archive {zip,none}]
                              [--background_color {k,w}] [--dpi DPI]
                              INPUT_FILE INPUT_FILE OUTPUT_FILE

Cladoplot

positional arguments:
  INPUT_FILE            dataset files
  INPUT_FILE            LEfSe output file
  OUTPUT_FILE           the file for the output (the zip file if an archive is
                        required, the output directory otherwise)

optional arguments:
  -h, --help            show this help message and exit
  --width WIDTH
  --height HEIGHT
  --top TOP             set maximum y limit (-1.0 means automatic limit)
  --bot BOT             set minimum y limit (default 0.0, -1.0 means automatic
                        limit)
  --title_font_size TITLE_FONT_SIZE
  --class_font_size CLASS_FONT_SIZE
  --class_label_pos {up,down}
  --subcl_mean {y,n}
  --subcl_median {y,n}
  --font_size FONT_SIZE
  -n flt                unused
  --format {png,pdf,svg}
                        the format for the output file
  -f {all,diff,one}     wheter to plot all features (all), only those
                        differentially abundant according to LEfSe or only one
                        (the one given with --feature_name)
  --feature_name FEATURE_NAME
                        The name of the feature to plot (levels separated by
                        .)
  --feature_num FEATURE_NUM
                        The number of the feature to plot
  --archive {zip,none}
  --background_color {k,w}
                        set the color of the background
  --dpi DPI
```

## lefse_lefse2circlader.py

### Tool Description
Convert LEfSe output to Circlader input.

### Metadata
- **Docker Image**: quay.io/biocontainers/lefse:1.1.2--pyhdfd78af_0
- **Homepage**: https://github.com/SegataLab/lefse
- **Package**: https://anaconda.org/channels/bioconda/packages/lefse/overview
- **Validation**: PASS

### Original Help Text
```text
usage: lefse2circlader.py [-h] [-l levels with label]
                          [INPUT_FILE] [OUTPUT_FILE]

Convert LEfSe output to Circlader input

positional arguments:
  INPUT_FILE            the input file [stdin if not present]
  OUTPUT_FILE           the output file [stdout if not present]

optional arguments:
  -h, --help            show this help message and exit
  -l levels with label
```

## lefse_qiime2lefse.py

### Tool Description
Convert a QIIME TSV BIOM table for use with LEfSe.

### Metadata
- **Docker Image**: quay.io/biocontainers/lefse:1.1.2--pyhdfd78af_0
- **Homepage**: https://github.com/SegataLab/lefse
- **Package**: https://anaconda.org/channels/bioconda/packages/lefse/overview
- **Validation**: PASS

### Original Help Text
```text
usage: qiime2lefse.py [-h] [--in [INPUT_FILE]] [--md [METADATA_FILE]]
                      [--out [OUTPUT_FILE]] [-c class attribute]
                      [-s subclass attribute] [-u subject attribute]

Script will convert QIIME TSV BIOM table for use with lefse. It is imperative
that this table has taxa metadata associated with it named 'Consensus
Lineage', this can be down with e.g. the follow biom convert script: ---- biom
convert -i otu.biom -o otu.txt --to-tsv --header-key Taxonomy --output-
metadata-id 'Consensus Lineage'

optional arguments:
  -h, --help            show this help message and exit
  --in [INPUT_FILE]     the Qiime OTU table file [ stdin if not present ]
  --md [METADATA_FILE]  the Qiime OTU table file [ only OTU table without
                        metadata if not present ]
  --out [OUTPUT_FILE]   the output file [stdout if not present]
  -c class attribute    the attribute to use as class
  -s subclass attribute
                        the attribute to use as subclass
  -u subject attribute  the attribute to use as subject
```

## Metadata
- **Skill**: generated

## lefse_lefse_plot_cladogram.py

### Tool Description
Plot the LEfSe result as a cladogram on the feature hierarchy.

### Metadata
- **Docker Image**: quay.io/biocontainers/lefse:1.1.2--pyhdfd78af_0
- **Homepage**: https://github.com/SegataLab/lefse
- **Package**: https://anaconda.org/channels/bioconda/packages/lefse/overview
- **Validation**: PASS

### Original Help Text
```text
usage: lefse_plot_cladogram.py [-h] [--clade_sep CLADE_SEP]
                               [--max_lev MAX_LEV]
                               [--max_point_size MAX_POINT_SIZE]
                               [--min_point_size MIN_POINT_SIZE]
                               [--point_edge_width MARKEREDGEWIDTH]
                               [--siblings_connector_width SIBLINGS_CONNECTOR_WIDTH]
                               [--parents_connector_width PARENTS_CONNECTOR_WIDTH]
                               [--radial_start_lev RADIAL_START_LEV]
                               [--labeled_start_lev LABELED_START_LEV]
                               [--labeled_stop_lev LABELED_STOP_LEV]
                               [--abrv_start_lev ABRV_START_LEV]
                               [--abrv_stop_lev ABRV_STOP_LEV]
                               [--expand_void_lev EXPAND_VOID_LEV]
                               [--class_legend_vis CLASS_LEGEND_VIS]
                               [--colored_connector COLORED_CONNECTORS]
                               [--alpha ALPHA] [--title TITLE]
                               [--sub_clade SUB_CLADE]
                               [--title_font_size TITLE_FONT_SIZE]
                               [--right_space_prop R_PROP]
                               [--left_space_prop L_PROP]
                               [--label_font_size LABEL_FONT_SIZE]
                               [--background_color {k,w}]
                               [--colored_labels {0,1}]
                               [--class_legend_font_size CLASS_LEGEND_FONT_SIZE]
                               [--dpi DPI] [--format {png,svg,pdf}]
                               [--all_feats ALL_FEATS]
                               INPUT_FILE OUTPUT_FILE

Cladoplot

positional arguments:
  INPUT_FILE            tab delimited input file
  OUTPUT_FILE           the file for the output image

optional arguments:
  -h, --help            show this help message and exit
  --clade_sep CLADE_SEP
  --max_lev MAX_LEV
  --max_point_size MAX_POINT_SIZE
  --min_point_size MIN_POINT_SIZE
  --point_edge_width MARKEREDGEWIDTH
  --siblings_connector_width SIBLINGS_CONNECTOR_WIDTH
  --parents_connector_width PARENTS_CONNECTOR_WIDTH
  --radial_start_lev RADIAL_START_LEV
  --labeled_start_lev LABELED_START_LEV
  --labeled_stop_lev LABELED_STOP_LEV
  --abrv_start_lev ABRV_START_LEV
  --abrv_stop_lev ABRV_STOP_LEV
  --expand_void_lev EXPAND_VOID_LEV
  --class_legend_vis CLASS_LEGEND_VIS
  --colored_connector COLORED_CONNECTORS
  --alpha ALPHA
  --title TITLE
  --sub_clade SUB_CLADE
  --title_font_size TITLE_FONT_SIZE
  --right_space_prop R_PROP
  --left_space_prop L_PROP
  --label_font_size LABEL_FONT_SIZE
  --background_color {k,w}
                        set the color of the background
  --colored_labels {0,1}
                        draw the label with class color (1) or in black (0)
  --class_legend_font_size CLASS_LEGEND_FONT_SIZE
  --dpi DPI
  --format {png,svg,pdf}
                        the format for the output file
  --all_feats ALL_FEATS
```

