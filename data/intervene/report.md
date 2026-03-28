# intervene CWL Generation Report

## intervene_List

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/intervene:0.6.5--pyh3252c3a_1
- **Homepage**: https://github.com/asntech/intervene
- **Package**: https://anaconda.org/channels/bioconda/packages/intervene/overview
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/intervene/overview
- **Total Downloads**: 40.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/asntech/intervene
- **Stars**: N/A
### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
usage: intervene <subcommand> [options]
intervene: error: argument command: invalid choice: 'List' (choose from 'venn', 'upset', 'pairwise')
```


## intervene_venn

### Tool Description
Create Venn diagram upto 6-way after intersection of genomic regions in (BED/GTF/GFF) format or list sets.

### Metadata
- **Docker Image**: quay.io/biocontainers/intervene:0.6.5--pyh3252c3a_1
- **Homepage**: https://github.com/asntech/intervene
- **Package**: https://anaconda.org/channels/bioconda/packages/intervene/overview
- **Validation**: PASS

### Original Help Text
```text
usage: intervene venn [options]

Create Venn diagram upto 6-way after intersection of genomic regions in (BED/GTF/GFF) format or list sets.

optional arguments:
  -h, --help            show this help message and exit
  -i [INPUT [INPUT ...]], --input [INPUT [INPUT ...]]
                        Input genomic regions in (BED/GTF/GFF) format or lists of genes/SNPs IDs.
                        For files in a directory use *.<extension>. e.g. *.bed
                        
  --type {genomic,list}
                        Type of input sets. Genomic regions or lists of genes/SNPs. Default is "genomic"
  --names LABELS        Comma-separated list of names as labels for input files.
                        If it is not set file names will be used as labels.
                        For example: --names=A,B,C,D,E,F
                        
  --filenames           Use file names as labels instead. Default is "False"
                        
  --bedtools-options BEDTOOLS_OPTIONS
                        List any of the arguments available for bedtools intersect command.
                        Type bedtools intersect --help to view all the options.
                        For example: --bedtools-options f=0.8,r,etc
                        
  -o OUTPUT, --output OUTPUT
                        Output folder path where results will be stored. Default is current working directory.
                        
  --save-overlaps       Save overlapping regions/names for all the combinations as bed/txt. Default is "False".
                        
  --overlap-thresh OVERLAPTHRESH
                        Minimum threshold to save the overlapping regions/names as bed/txt. Default is: "1"
                        
  --title TITLE         Title of the plot. By default it is not set.
                        
  --project PROJECT     Project name for the output. Default is: "Intervene"
                        
  --colors COLORS       Comma-separated list of matplotlib-valid colors for fill. E.g., --colors=r,b,k
                        
  --bordercolors BORDERCOLORS
                        A matplotlib-valid color for venn borders. E.g., --bordercolor=red
                        
  --figtype {pdf,svg,ps,tiff,png}
                        Figure type for the plot. e.g. --figtype svg. Default is "pdf"
                        
  --figsize FIGSIZE FIGSIZE
                        Figure size as width and height.e.g. --figsize 12 12.
                        
  --fontsize FONTSIZE   Font size for the plot labels.Default is: "14"
                        
  --dpi DPI             Dots-per-inch (DPI) for the output. Default is: "300"
                        
  --fill {number,percentage}
                        Report number or  percentage of overlaps (Only if --type=list). Default is "number"
                        
  --test                This will run the program on test data.
```


## intervene_upset

### Tool Description
Create UpSet diagram after intersection of genomic regions in (BED/GTF/GFF) or list sets.

### Metadata
- **Docker Image**: quay.io/biocontainers/intervene:0.6.5--pyh3252c3a_1
- **Homepage**: https://github.com/asntech/intervene
- **Package**: https://anaconda.org/channels/bioconda/packages/intervene/overview
- **Validation**: PASS

### Original Help Text
```text
usage: intervene upset [options]

Create UpSet diagram after intersection of genomic regions in (BED/GTF/GFF) or list sets.

optional arguments:
  -h, --help            show this help message and exit
  -i [INPUT [INPUT ...]], --input [INPUT [INPUT ...]]
                        Input genomic regions in (BED/GTF/GFF) format or lists of genes/SNPs IDs.
                         For files in a directory use *.<extension>. e.g. *.bed
                        
  --type {genomic,list}
                        Type of input sets. Genomic regions or lists of genes/SNPs sets. Default is "genomic".
                        
  --names LABELS        Comma-separated list of names as labels for input files.
                        If it is not set file names will be used as labels.
                        For example: --names=A,B,C,D,E,F
                        
  --filenames           Use file names as labels instead. Default is "False".
                        
  --bedtools-options BEDTOOLS_OPTIONS
                        List any of the arguments available for bedtools intersect command.
                        Type bedtools intersect --help to view all the options.
                        For example: --bedtools-options f=0.8,r,etc
                        
  -o OUTPUT, --output OUTPUT
                        Output folder path where results will be stored. Default is current working directory.
                        
  --save-overlaps       Save overlapping regions/names for all the combinations as bed/txt.Default is "False".
                        
  --overlap-thresh OVERLAPTHRESH
                        Minimum threshold to save the overlapping regions/names as bed/txt. Default is: "1"
                        
  --project PROJECT     Project name for the output. Default is: "Intervene"
                        
  --order {freq,degree}
                        The order of intersections of sets. e.g. --order degree. Default is "freq".
                        
  --ninter NINTER       Number of top intersections to show in plot. Default is "30".
                        
  --showzero            Show empty intersection combinations. Default is "False".
                        
  --showsize            Show intersection sizes above bars. Default is "True".
                        
  --mbcolor MBCOLOR     Color of the main bar plot. Default is: "#ea5d4e".
                        
  --sbcolor SBCOLOR     Color of set size bar plot. Default is: "#317eab".
                        
  --mblabel MBLABEL     The y-axis label of the intersection size bars. Default is: "No. of Intersections".
                        
  --sxlabel SXLABEL     The x-axis label of the set size bars. Default is: "Set size".
                        
  --figtype {pdf,svg,ps,tiff,png}
                        Figure type for the plot. e.g. --figtype svg. Default is "pdf"
                        
  --figsize FIGSIZE FIGSIZE
                        Figure size for the output plot (width,height). e.g.  --figsize 14 8
                        
  --dpi DPI             Dots-per-inch (DPI) for the output. Default is: "300".
                        
  --scriptonly          Set to generate Rscript only, if R/UpSetR package is not installed. Default is "False".
                        
  --showshiny           Print the combinations of intersections to input to Shiny App. Default is "False".
                        
  --test                This will run the program on test data.
```


## intervene_pairwise

### Tool Description
Pairwise intersection and heatmap of N genomic region sets in (BED/GTF/GFF) format or list/name sets.

### Metadata
- **Docker Image**: quay.io/biocontainers/intervene:0.6.5--pyh3252c3a_1
- **Homepage**: https://github.com/asntech/intervene
- **Package**: https://anaconda.org/channels/bioconda/packages/intervene/overview
- **Validation**: PASS

### Original Help Text
```text
usage: intervene pairwise [options]

Pairwise intersection and heatmap of N genomic region sets in (BED/GTF/GFF) format or list/name sets.

optional arguments:
  -h, --help            show this help message and exit
  -i [INPUT [INPUT ...]], --input [INPUT [INPUT ...]]
                        Input genomic regions in (BED/GTF/GFF) format. 
                        For files in a directory use *.<extension>. e.g. *.bed
  --type {genomic,list}
                        Type of input sets. Genomic regions or lists of genes/SNPs sets. Default is "genomic".
                        
  --compute {count,frac,jaccard,fisher,reldist}
                        Compute count/fraction of overlaps or other statistical relationships. 
                        count: calculates the number of overlaps. 
                        frac: calculates the fraction of overlap. (Default)
                        jaccard: calculate the Jaccard statistic. 
                        reldist: calculate the distribution of relative distances.
                        fisher: calculate Fisher`s statistic. 
                        Note: For jaccard and reldist regions should be pre-shorted or set --sort.
                        
  --bedtools-options BEDTOOLS_OPTIONS
                        List any of the arguments available for bedtools subcommands: interset, jaccard, fisher, reldist.
                        Type bedtools <subcommand> --help to view all the options.
                        For example: --bedtools-options f=0.8,r,etc
                        
  --corr                Compute the correlation. 
                        Default is "False".
                        
  --corrtype {pearson,kendall,spearman}
                        Select the type of correlation. 
                        pearson: computes the Pearson correlation. (Default) 
                        kendall: computes the Kendall correlation. 
                        spearman: computes the Spearman correlation. 
                        Note: This only works if --corr is set.
                        
  --htype {tribar,dendrogram,color,pie,circle,square,ellipse,number,shade}
                        Heatmap plot type. Default is "tribar".
                        
  --triangle {lower,upper}
                        Show lower/upper triangle of the matrix as heatmap if --htype=tribar. Default is "lower".
                        
  --diagonal            Show the diagonal values in the heatmap. 
                        Default is "False".
                        
  --names LABELS        Comma-separated list of names as labels for input files.
                        If it is not set file names will be used as labels.
                        For example: --names=A,B,C,D,E,F
                        
  --filenames           Use file names as labels instead. 
                        Default is "False".
                        
  --sort                Set this only if your files are not sorted. 
                        Default is "False".
                        
  --genome GENOME       Required argument if --compute=fisher.
                        Needs to be a string assembly name like "mm10" or "hg38"
                        
  -o OUTPUT, --output OUTPUT
                        Output folder path where results will be stored. 
                        Default is current working directory.
                        
  --project PROJECT     Project name for the output. Default is: "Intervene"
                        
  --barlabel BLABEL     x-axis label of boxplot if --htype=tribar. Default is "Set size"
                        
  --barcolor BARCOLOR   Boxplot color (hex vlaue or name, e.g. blue). Default is "#53cfff".
                        
  --fontsize FONTSIZE   Label font size. Default is "8".
                        
  --title TITLE         Heatmap main title. Default is "Pairwise intersection".
                        
  --space SPACE         White space between barplt and heatmap, if --htype=tribar. Default is "1.3".
                        
  --figtype {pdf,svg,ps,tiff,png}
                        Figure type for the plot. e.g. --figtype svg. Default is "pdf"
                        
  --figsize FIGSIZE FIGSIZE
                        Figure size for the output plot (width,height). e.g.  --figsize 8 8
                        
  --dpi DPI             Dots-per-inch (DPI) for the output. Default is: "300".
                        
  --scriptonly          Set to generate Rscript only, if R/Corrplot package are not installed. Default is "False".
                        
  --test                This will run the program on test data.
```


## Metadata
- **Skill**: generated
