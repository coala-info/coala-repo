# phylotoast CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| phylotoast_LDA.py | PASS | synthetic data: the mapping file with two groups of samples S1-S5 and S6-S10 was planted for the real test.biom |
| phylotoast_otu_to_tax_name.py | PASS |  |
| phylotoast_restrict_repset.py | PASS | synthetic data: real test sequences renamed to the OTU ids of a JSON subset of test.biom; the tool reads JSON BIOM only |
| phylotoast_transform_biom.py | PASS |  |

## phylotoast_LDA.py

### Tool Description
This script calculates and returns LDA plots based on normalized relative abundances or distance matrices (for e.g. unifrac distance matrix).

### Metadata
- **Docker Image**: quay.io/biocontainers/phylotoast:1.4.0rc2--py27_0
- **Homepage**: https://github.com/smdabdoub/phylotoast
- **Package**: https://anaconda.org/channels/bioconda/packages/phylotoast/overview
- **Validation**: PASS

### Original Help Text
```text
usage: LDA.py [-h] -m MAP_FP -g GROUP_BY [-c COLORS] [-ot OTU_TABLE]
              [-dm DIST_MATRIX_FILE] [--save_lda_input SAVE_LDA_INPUT]
              [--plot_title PLOT_TITLE] [-o OUT_FP] [-d {2,3}]
              [--z_angles Z_ANGLES Z_ANGLES] [--figsize FIGSIZE FIGSIZE]
              [--font_size FONT_SIZE] [--label_padding LABEL_PADDING]
              [--annotate_points] [--ggplot2_style]

This script calculates and returns LDA plots based on normalized relative
abundances or distance matrices (for e.g. unifrac distance matrix).

optional arguments:
  -h, --help            show this help message and exit
  -m MAP_FP, --map_fp MAP_FP
                        Metadata mapping file. [REQUIRED]
  -g GROUP_BY, --group_by GROUP_BY
                        A column name in the mapping file containing
                        categorical values that will be used to identify
                        groups. Each sample ID must have a group entry.
                        Default is no categories and all the data will be
                        treated as a single group. [REQUIRED]
  -c COLORS, --colors COLORS
                        A column name in the mapping file containing
                        hexadecimal (#FF0000) color values that will be used
                        to color the groups. Each sample ID must have a color
                        entry.
  -ot OTU_TABLE, --otu_table OTU_TABLE
                        Input biom file format OTU table.
  -dm DIST_MATRIX_FILE, --dist_matrix_file DIST_MATRIX_FILE
                        Input distance matrix file.
  --save_lda_input SAVE_LDA_INPUT
                        Save a CSV-format file of the transposed LDA-input
                        table to the file specifed by this option.
  --plot_title PLOT_TITLE
                        Plot title. Default is no title.
  -o OUT_FP, --out_fp OUT_FP
                        The path and file name to save the LDA plot under. If
                        specified, the figure will be saved directly instead
                        of opening a window in which the plot can be viewed
                        before saving.
  -d {2,3}, --dimensions {2,3}
                        Choose whether to plot 2D or 3D. Default is a 2D view.
  --z_angles Z_ANGLES Z_ANGLES
                        Specify the azimuth and elevation angles for a 3D
                        plot.
  --figsize FIGSIZE FIGSIZE
                        Specify the 'width height' in inches for LDA plots.
                        Default figure size is 14x8 inches.
  --font_size FONT_SIZE
                        Sets the font size for text elements in the plot.
  --label_padding LABEL_PADDING
                        Sets the spacing in points between the each axis and
                        its label.
  --annotate_points     If specified, each data point will be labeled with its
                        sample ID. Default is False.
  --ggplot2_style       Apply ggplot2 styling to the figure. Default is False.
```

## phylotoast_transform_biom.py

### Tool Description
This script applies varioustransforms to the data in a given BIOM-format table
and outputs a newBIOM table with the transformed data.

### Metadata
- **Docker Image**: quay.io/biocontainers/phylotoast:1.4.0rc2--py27_0
- **Homepage**: https://github.com/smdabdoub/phylotoast
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: transform_biom.py [-h] -i BIOM_TABLE_FP
                         [-t {arcsin_sqrt,log10,ra,ra_log10}]
                         [--fmt {hdf5,json,tsv}] [--gzip] -o OUTPUT_FP [-v]

This script applies varioustransforms to the data in a given BIOM-format table
and outputs a newBIOM table with the transformed data.

optional arguments:
  -h, --help            show this help message and exit
  -i BIOM_TABLE_FP, --biom_table_fp BIOM_TABLE_FP
                        Path to the input BIOM-format table. [REQUIRED]
  -t {arcsin_sqrt,log10,ra,ra_log10}, --transform {arcsin_sqrt,log10,ra,ra_log10}
                        The transform to apply to the data. Default: arcsine
                        square root.
  --fmt {hdf5,json,tsv}
                        Set the output format of the BIOM table. Default is
                        HDF5.
  --gzip                Compress the output BIOM table with gzip. HDF5 BIOM
                        (v2.x) files are internally compressed by default, so
                        this option is not needed when specifying --fmt hdf5.
  -o OUTPUT_FP, --output_fp OUTPUT_FP
                        Output path for the transformed BIOM table.[REQUIRED]
  -v, --verbose
```


## phylotoast_restrict_repset.py

### Tool Description
Take a subset BIOM table (e.g. from a core calculation) and a representative set (repset) FASTA file and create a new repset restricted to the OTUs in the BIOM table.

### Metadata
- **Docker Image**: quay.io/biocontainers/phylotoast:1.4.0rc2--py27_0
- **Homepage**: https://github.com/smdabdoub/phylotoast
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: restrict_repset.py [-h] -i BIOM_FP -r REPSET_FP [-o REPSET_OUT_FP]

Take a subset BIOM table (e.g. from a core calculation) and a representative
set (repset) FASTA file and create a new repset restricted to the OTUs in the
BIOM table.

optional arguments:
  -h, --help            show this help message and exit
  -i BIOM_FP, --biom_fp BIOM_FP
                        Path to a biom-format file with OTU-Sample abundance
                        data.
  -r REPSET_FP, --repset_fp REPSET_FP
                        Path to a FASTA-format file containing the
                        representative set of OTUs
  -o REPSET_OUT_FP, --repset_out_fp REPSET_OUT_FP
                        Path to the new restricted repset file
```


## phylotoast_otu_to_tax_name.py

### Tool Description
Convert a list of OTU IDs to a list of OTU IDs paired with Genus_Species identifiers and perform reverse lookup, if needed.

### Metadata
- **Docker Image**: quay.io/biocontainers/phylotoast:1.4.0rc2--py27_0
- **Homepage**: https://github.com/smdabdoub/phylotoast
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: otu_to_tax_name.py [-h] -i OTU_TABLE -oid OTU_ID_FP [-o OUTPUT_FP]
                          [--reverse_lookup]

Convert a list of OTU IDs to a list of OTU IDs paired with Genus_Species
identifiers and perform reverse lookup, if needed.

optional arguments:
  -h, --help            show this help message and exit
  -i OTU_TABLE, --otu_table OTU_TABLE
                        Input biom file format OTU table. [REQUIRED]
  -oid OTU_ID_FP, --otu_id_fp OTU_ID_FP
                        A single or multi-column (tab-separated) file
                        containing the OTU IDs to be converted in the first
                        column. [REQUIRED]
  -o OUTPUT_FP, --output_fp OUTPUT_FP
                        For a list input, a new file containing a list of OTU
                        IDs and their corresponding short taxonomic
                        identifiers separated by tabs. For a BIOM file input,
                        a new mapping file with all the OTU IDs replaced by
                        the short identifier.[REQUIRED]
  --reverse_lookup      Get OTUIDs from genus-species OTU name.
```


## Metadata
- **Skill**: generated
