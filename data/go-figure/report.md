# go-figure CWL Generation Report

## go-figure_gofigure.py

### Tool Description
GO enrichment visualization based on semantic similarity.

### Metadata
- **Docker Image**: quay.io/biocontainers/go-figure:1.0.2--hdfd78af_0
- **Homepage**: https://gitlab.com/evogenlab/GO-Figure
- **Package**: https://anaconda.org/channels/bioconda/packages/go-figure/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/go-figure/overview
- **Total Downloads**: 1.1K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
usage: gofigure.py [-h] -i INPUT -o OUTPUT [-a MAX_CLUSTERS]
                   [-j {topgo,gostats,standard,standard-plus}]
                   [-n {bpo,mfo,cco,all}] [-r REPRESENTATIVES]
                   [-si SIMILARITY_CUTOFF] [-v MAX_PVALUE]
                   [-so {pval,user,user-descending}] [-su {True,False}]
                   [-to TOP_LEVEL] [-nc NAME_CHANGES] [-b OPACITY]
                   [-c {pval,log10-pval,user,members,frequency,unique}]
                   [-p PALETTE] [-rs RANDOM_STATE] [-s SIZE]
                   [-sr {small,medium,big}]
                   [-u {numbered,go,go-arrows,description,description-numbered}]
                   [-x XLABEL] [-y YLABEL] [-z COLOUR_LABEL]
                   [-d {left,right,center}] [-e DESCRIPTION_LIMIT]
                   [-f {xx-small,x-small,small,medium,large,x-large,xx-large}]
                   [-g {single,double,triple}] [-l {full,go,description,none}]
                   [-m MAX_LABEL] [-dp DPI] [-q {png,pdf,tiff,svg}]
                   [-w OUTFILE_APPENDIX]
                   [-k {xx-small,x-small,small,medium,large,x-large,xx-large}]
                   [-t TITLE]

GOFigure!: GO enrichment visualization based on semantic similarity.

options:
  -h, --help            show this help message and exit

Required arguments:
  -i INPUT, --input INPUT
                        Input file in tabular format with the columns: GO ID +
                        P-value for standard input, GO ID + P-Value +
                        Significant for standard-plus input, TopGO output as
                        an input, or GoStats output as an input. Can use # or
                        ! or % to comment out lines. Change --input_type
                        accordingly. Default input is 'standard'. Example
                        input files are found in the root directory.
  -o OUTPUT, --output OUTPUT
                        Output directory

Optional input file and data handling arguments:
  -a MAX_CLUSTERS, --max_clusters MAX_CLUSTERS
                        Maximum amount of clusters to plot (integer value).
                        Default = 50.
  -j {topgo,gostats,standard,standard-plus}, --input_type {topgo,gostats,standard,standard-plus}
                        Type of input file. Use 'topgo' for standard TopGO
                        input, 'gostats' for standard GOStats input,
                        'standard' for an input file where the first column is
                        the GO ID and the second is the p-value, and
                        'standard-plus' for standard input but with a third
                        column containing a user defined numerical value (for
                        TopGO and GOStats input, this is the 'significant'
                        value). Default = standard
  -n {bpo,mfo,cco,all}, --ontology {bpo,mfo,cco,all}
                        Which ontology to use: biological process ('bpo'),
                        molecular function ('mfo'), cellular component
                        ('cco'), or all ontologies ('all'). Default is all.
  -r REPRESENTATIVES, --representatives REPRESENTATIVES
                        A list of GO terms that have priority for being a
                        representative of a cluster. I.e. if one term in a
                        cluster has priority, that term will always be the
                        representative. If two terms in a cluster have
                        priority, only those two will be considered. Input is
                        a list of GO terms separated by a comma, such as
                        'GO:0000001,GO:0000002'.
  -si SIMILARITY_CUTOFF, --similarity_cutoff SIMILARITY_CUTOFF
                        Similarity cutoff to be used between GO terms, a value
                        between 0 and 1. Default = 0.5.
  -v MAX_PVALUE, --max_pvalue MAX_PVALUE
                        Maximum p-value to consider (floating value). Default
                        = 99999.99999.
  -so {pval,user,user-descending}, --sort_by {pval,user,user-descending}
                        Which values to use for sorting the clusters: 'pval'
                        (p-value) or 'user' (user-defined value) or 'user-
                        descending' (user-defined value descending). Default =
                        pval.
  -su {True,False}, --sum_user {True,False}
                        To sum the user-defined values (column 3) for each
                        member of a cluster. Either 'True' or 'False'. Default
                        = False.
  -to TOP_LEVEL, --top_level TOP_LEVEL
                        Set top level GO terms for clusters as given by the GO
                        DAG (see https://www.ebi.ac.uk/QuickGO). Top level GO
                        terms have to be given separated by comma's, without
                        spaces. E.g.: 'GO:000001,GO:000008'.
  -nc NAME_CHANGES, --name_changes NAME_CHANGES
                        A list of GO terms that will be used as representative
                        of a cluster specifically for naming purposes, but not
                        for internal calculations. This is opposed to the'--
                        representatives option, which provides GO terms to be
                        used as representatives of a cluster both internally
                        and externally. This specific option allows for the
                        renaming of clusters without recalculating the
                        clusters when there is a need to reproduce the
                        original figure. Input is a list of GO terms separated
                        by a comma, such as 'GO:0000001,GO:0000002'.

Optional legend arguments:
  -d {left,right,center}, --legend_position {left,right,center}
                        Position the legend at the bottom left ('left'),
                        bottom right ('right'), or bottom center ('center').
                        Default = center.
  -e DESCRIPTION_LIMIT, --description_limit DESCRIPTION_LIMIT
                        Integer character limit of GO term descriptions in the
                        legend. Default = 35.
  -f {xx-small,x-small,small,medium,large,x-large,xx-large}, --font_size {xx-small,x-small,small,medium,large,x-large,xx-large}
                        Font size of the legend. 'xx-small', 'x-small',
                        'small', 'medium', 'large' , 'x-large', or 'xx-large'.
                        Default = medium
  -g {single,double,triple}, --legend_columns {single,double,triple}
                        Legend as a single ('single') column or double
                        ('double') column. Default = double.
  -l {full,go,description,none}, --legend {full,go,description,none}
                        Option to show GO terms and descriptions in the legend
                        ('full'), GO term only 'go', description only
                        ('description'), or no legend ('none'). Default =
                        description.
  -m MAX_LABEL, --max_label MAX_LABEL
                        Maximum labels to display in the legend. Default = 10.

Optional scatterplot arguments:
  -b OPACITY, --opacity OPACITY
                        Set opacity for the clusters, floating point from 0 to
                        1. Default = 1
  -c {pval,log10-pval,user,members,frequency,unique}, --colours {pval,log10-pval,user,members,frequency,unique}
                        Color GO clusters based on p-value ('pval'), log10
                        p-value ('log10-pval'), number of GO terms that are a
                        member of the cluster ('members'), frequency of the GO
                        term in the GOA database ('frequency'), a unique
                        colour per cluster ('unique'), or a user defined value
                        ('user'). Default = 'log10-pval'.
  -p PALETTE, --palette PALETTE
                        Set to any color brewer palette available for
                        MatPlotLib (https://matplotlib.org/3.1.1/tutorials/col
                        ors/colormaps.html). Default = plasma
  -rs RANDOM_STATE, --random_state RANDOM_STATE
                        Set random state for the calculation of the X and Y
                        label. Useful if you want the figures to be exactly
                        the same. Needs to be an integer or None. Specifying
                        'None' will create a different orientation of the plot
                        every time. Default = 1
  -s SIZE, --size SIZE  Size of GO clusters based on how many GO terms are a
                        member of the cluster ('members'), frequency in GOA
                        database ('frequency'), p-value where smaller = larger
                        size ('pval'), the user defined value ('user'), or a
                        fixed integer for every cluster. Default = 'members'.
  -sr {small,medium,big}, --size_range {small,medium,big}
                        Set cluster size range to 'small', 'medium', or 'big'.
                        Default = medium.
  -u {numbered,go,go-arrows,description,description-numbered}, --cluster_labels {numbered,go,go-arrows,description,description-numbered}
                        Label clusters numbered based on the sorting option
                        ('numbered'), based on the representative GO term
                        ('go'), based on the representative GO term with
                        arrows ('go-arrows') based on the representative GO
                        term name ('description'), or based on the
                        representative GO term name with arrows ('description-
                        numbered'). Default = numbered.
  -x XLABEL, --xlabel XLABEL
                        X-axis label. Default = 'Semantic space X'
  -y YLABEL, --ylabel YLABEL
                        Y-axis label. Default = 'Semantic space Y'
  -z COLOUR_LABEL, --colour_label COLOUR_LABEL
                        Colourbar label. Default is the description of the
                        input used for --colours

Optional title arguments:
  -k {xx-small,x-small,small,medium,large,x-large,xx-large}, --title_size {xx-small,x-small,small,medium,large,x-large,xx-large}
                        Set title size. 'xx-small', 'x-small', 'small',
                        'medium', 'large' , 'x-large', or 'xx-large'. Default
                        = medium
  -t TITLE, --title TITLE
                        Set figure title. Has to be between single or double
                        quotation marks.

Optional outfile arguments:
  -dp DPI, --dpi DPI    Set DPI for outfiles. Default = 400
  -q {png,pdf,tiff,svg}, --file_type {png,pdf,tiff,svg}
                        Image file type. 'png', 'pdf', 'svg', or 'tiff'.
                        Default = 'png'
  -w OUTFILE_APPENDIX, --outfile_appendix OUTFILE_APPENDIX
                        What to add to the outfiles after
                        'biological_process', 'molecular_function', or
                        'cellular_component'. By default it will add the value
                        given for --outdir, replacing '/' with '_'.
```

