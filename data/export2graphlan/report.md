# export2graphlan CWL Generation Report

## export2graphlan_export2graphlan.py

### Tool Description
Convert MetaPhlAn, LEfSe, and/or HUMAnN output to GraPhlAn input format.

### Metadata
- **Docker Image**: quay.io/biocontainers/export2graphlan:0.22--py_0
- **Homepage**: https://github.com/segatalab/export2graphlan
- **Package**: https://anaconda.org/channels/bioconda/packages/export2graphlan/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/export2graphlan/overview
- **Total Downloads**: 18.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/segatalab/export2graphlan
- **Stars**: N/A
### Original Help Text
```text
usage: export2graphlan.py [-h] [-i LEFSE_INPUT] [-o LEFSE_OUTPUT] -t TREE -a
                          ANNOTATION [--annotations ANNOTATIONS]
                          [--external_annotations EXTERNAL_ANNOTATIONS]
                          [--background_levels BACKGROUND_LEVELS]
                          [--background_clades BACKGROUND_CLADES]
                          [--background_colors BACKGROUND_COLORS]
                          [--title TITLE] [--title_font_size TITLE_FONT_SIZE]
                          [--def_clade_size DEF_CLADE_SIZE]
                          [--min_clade_size MIN_CLADE_SIZE]
                          [--max_clade_size MAX_CLADE_SIZE]
                          [--def_font_size DEF_FONT_SIZE]
                          [--min_font_size MIN_FONT_SIZE]
                          [--max_font_size MAX_FONT_SIZE]
                          [--annotation_legend_font_size ANNOTATION_LEGEND_FONT_SIZE]
                          [--abundance_threshold ABUNDANCE_THRESHOLD]
                          [--most_abundant MOST_ABUNDANT]
                          [--least_biomarkers LEAST_BIOMARKERS]
                          [--discard_otus] [--internal_levels]
                          [--biomarkers2colors BIOMARKERS2COLORS] [--sep SEP]
                          [--out_table OUT_TABLE] [--fname_row FNAME_ROW]
                          [--sname_row SNAME_ROW]
                          [--metadata_rows METADATA_ROWS]
                          [--skip_rows SKIP_ROWS] [--sperc SPERC]
                          [--fperc FPERC] [--stop STOP] [--ftop FTOP]
                          [--def_na DEF_NA]

export2graphlan.py (ver. 0.22 of 05 May 2020). Convert MetaPhlAn, LEfSe,
and/or HUMAnN output to GraPhlAn input format. Authors: Francesco Asnicar
(f.asnicar@unitn.it)

optional arguments:
  -h, --help            show this help message and exit
  --annotations ANNOTATIONS
                        List which levels should be annotated in the tree. Use
                        a comma separate values form, e.g.,
                        --annotation_levels 1,2,3. Default is None
  --external_annotations EXTERNAL_ANNOTATIONS
                        List which levels should use the external legend for
                        the annotation. Use a comma separate values form,
                        e.g., --annotation_levels 1,2,3. Default is None
  --background_levels BACKGROUND_LEVELS
                        List which levels should be highlight with a shaded
                        background. Use a comma separate values form, e.g.,
                        --background_levels 1,2,3. Default is None
  --background_clades BACKGROUND_CLADES
                        Specify the clades that should be highlight with a
                        shaded background. Use a comma separate values form
                        and surround the string with " if there are spaces.
                        Example: --background_clades "Bacteria.Actinobacteria,
                        Bacteria.Bacteroidetes.Bacteroidia,
                        Bacteria.Firmicutes.Clostridia.Clostridiales". Default
                        is None
  --background_colors BACKGROUND_COLORS
                        Set the color to use for the shaded background. Colors
                        can be either in RGB or HSV (using a semi-colon to
                        separate values, surrounded with ()) format. Use a
                        comma separate values form and surround the string
                        with " if it contains spaces. Example:
                        --background_colors "#29cc36, (150; 100; 100), (280;
                        80; 88)". To use a fixed set of colors associated to a
                        fixed set of clades, you can specify a mapping file in
                        a tab-separated format, where the first column is the
                        clade (using the same format as for the "--
                        background_clades" param) and the second colum is the
                        color associated. Default is None
  --title TITLE         If specified set the title of the GraPhlAn plot.
                        Surround the string with " if it contains spaces,
                        e.g., --title "Title example"
  --title_font_size TITLE_FONT_SIZE
                        Set the title font size. Default is 15
  --def_clade_size DEF_CLADE_SIZE
                        Set a default size for clades that are not found as
                        biomarkers by LEfSe. Default is 10
  --min_clade_size MIN_CLADE_SIZE
                        Set the minimum value of clades that are biomarkers.
                        Default is 20
  --max_clade_size MAX_CLADE_SIZE
                        Set the maximum value of clades that are biomarkers.
                        Default is 200
  --def_font_size DEF_FONT_SIZE
                        Set a default font size. Default is 10
  --min_font_size MIN_FONT_SIZE
                        Set the minimum font size to use. Default is 8
  --max_font_size MAX_FONT_SIZE
                        Set the maximum font size. Default is 12
  --annotation_legend_font_size ANNOTATION_LEGEND_FONT_SIZE
                        Set the font size for the annotation legend. Default
                        is 10
  --abundance_threshold ABUNDANCE_THRESHOLD
                        Set the minimun abundace value for a clade to be
                        annotated. Default is 20.0
  --most_abundant MOST_ABUNDANT
                        When only lefse_input is provided, you can specify how
                        many clades highlight. Since the biomarkers are
                        missing, they will be chosen from the most abundant.
                        Default is 10
  --least_biomarkers LEAST_BIOMARKERS
                        When only lefse_input is provided, you can specify the
                        minimum number of biomarkers to extract. The taxonomy
                        is parsed, and the level is choosen in order to have
                        at least the specified number of biomarkers. Default
                        is 3
  --discard_otus        If specified the OTU ids will be discarde from the
                        taxonmy. Default is True, i.e. keep OTUs IDs in
                        taxonomy
  --internal_levels     If specified sum-up from leaf to root the abundances
                        values. Default is False, i.e. do not sum-up
                        abundances on the internal nodes
  --biomarkers2colors BIOMARKERS2COLORS
                        Mapping file that associates biomarkers to a specific
                        color... I'll define later the specific format of this
                        file!

input parameters:
  You need to provide at least one of the two arguments

  -i LEFSE_INPUT, --lefse_input LEFSE_INPUT
                        LEfSe input data. A file that can be given to LEfSe
                        for biomarkers analysis. It can be the result of a
                        MetaPhlAn or HUMAnN analysis
  -o LEFSE_OUTPUT, --lefse_output LEFSE_OUTPUT
                        LEfSe output result data. The result of LEfSe analysis
                        performed on the lefse_input file

output parameters:
  -t TREE, --tree TREE  Output filename where save the input tree for GraPhlAn
  -a ANNOTATION, --annotation ANNOTATION
                        Output filename where save GraPhlAn annotation

Input data matrix parameters:
  --sep SEP
  --out_table OUT_TABLE
                        Write processed data matrix to file
  --fname_row FNAME_ROW
                        row number containing the names of the features
                        [default 0, specify -1 if no names are present in the
                        matrix
  --sname_row SNAME_ROW
                        column number containing the names of the samples
                        [default 0, specify -1 if no names are present in the
                        matrix
  --metadata_rows METADATA_ROWS
                        Row numbers to use as metadata[default None, meaning
                        no metadata
  --skip_rows SKIP_ROWS
                        Row numbers to skip (0-indexed, comma separated) from
                        the input file[default None, meaning no rows skipped
  --sperc SPERC         Percentile of sample value distribution for sample
                        selection
  --fperc FPERC         Percentile of feature value distribution for sample
                        selection
  --stop STOP           Number of top samples to select (ordering based on
                        percentile specified by --sperc)
  --ftop FTOP           Number of top features to select (ordering based on
                        percentile specified by --fperc)
  --def_na DEF_NA       Set the default value for missing values [default None
                        which means no replacement]
```

