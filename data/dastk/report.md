# dastk CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| dastk_barcode_plot | PASS |  |
| dastk_differential_md_score | Failed | image problem: matplotlib 3.6.3 in the image rejects plt.xscale(basex=2), so the MA plot step crashes (exit 1) after the scores table is written. |
| dastk_ma_plot | Failed | image problem: matplotlib 3.6.3 in the image rejects plt.xscale(basex=2), so ma_plot crashes (exit 1) before it saves the plot. |
| dastk_process_atac | PASS |  |
| dastk_tf_intersect | PASS |  |
| dastk_tf_result_explanations | Failed | image problem: networkx 3.0 in the image has no read_gpickle, and the prot_reactome_interactions.pkl knowledge graph is missing from the package, so the tool crashes at start. |

## Metadata
- **Skill**: generated

## dastk_differential_md_score

### Tool Description
Calculate differential MD-scores between two conditions using the DAStk (Differential ATAC-seq Toolkit).

### Metadata
- **Docker Image**: quay.io/biocontainers/dastk:1.0.1--pyh7cba7a3_0
- **Homepage**: https://github.com/Dowell-Lab/DAStk
- **Package**: https://anaconda.org/channels/bioconda/packages/dastk/overview
- **Validation**: PASS
### Original Help Text
```text
usage: differential_md_score [-h] [-p P_VALUE] -1 ASSAY_1 -2 ASSAY_2
                             [-m LABEL_1] [-n LABEL_2] [-w WINDOW] [-b] -o
                             OUTPUT_DIR [-t THREADS] [-c] [-g] [-v]

This script produces an MA plot of TFs from ATAC-Seq data, for DMSO vs. treatment conditions.

options:
  -h, --help            show this help message and exit
  -p P_VALUE, --p-value P_VALUE
                        p-value cutoff to define which motifs to label in the MA plot. Defaults to 0.00001.
  -1 ASSAY_1, --assay-1 ASSAY_1
                        Control file generated from process_atac ending in the extension "md_scores.txt" (e.g. "DMSO", "control", "wildtype").
  -2 ASSAY_2, --assay-2 ASSAY_2
                        Perturbation file generated from process_atac ending in the extension "md_scores.txt" (e.g., "doxycyclin", "p53_knockout").
  -m LABEL_1, --label-1 LABEL_1
                        Label for the MA plot title corresponding to assay 1
  -n LABEL_2, --label-2 LABEL_2
                        Label for the MA plot title corresponding to assay 2
  -w WINDOW, --window WINDOW
                        Label for the MA plot title corresponding to window size (str). Default = '3kb'
  -b, --barcodes        Generate a barcode plot for each significant motif
  -o OUTPUT_DIR, --output OUTPUT_DIR
                        Path to where output files will be saved.
  -t THREADS, --threads THREADS
                        Number of threads for multi-processing. Defaults to 1.
  -c, --chip            If the input is ChIP data, it may be useful to specify this flag as it will change the variance calulation because a large difference in sites between control and treatment will be expected.
  -g, --global-normalization
                        When specified, output barcodes will be normalized according to total number of motif hits throughout the genome (i.e. total significantly called regions from FIMO scan).
  -v, --version         show program's version number and exit

IMPORTANT: Please ensure that ALL files used with this script are sorted by the same criteria.

Example:
For your files:
     * mcf7_DMSO_md_scores.txt
     * mcf7_Nutlin_md_scores.txt
... you can use the following arguments to generate an MA plot with barcodes at a p-value cutoff of 1e-4:

$ python differential_md_score.py -x mcf7 -1 DMSO -2 Nutlin -p 0.0001 -b
```

## dastk_process_atac

### Tool Description
This script analyzes ATAC-Seq and GRO-Seq data and produces various plots for further data analysis.

### Metadata
- **Docker Image**: quay.io/biocontainers/dastk:1.0.1--pyh7cba7a3_0
- **Homepage**: https://github.com/Dowell-Lab/DAStk
- **Package**: https://anaconda.org/channels/bioconda/packages/dastk/overview
- **Validation**: PASS
### Original Help Text
```text
usage: process_atac [-h] -e ATAC_PEAKS_FILENAME -m TF_MOTIF_PATH [-r RADIUS]
                    [-g GENOME] [-c CHROMOSOMES] [-t MP_THREADS] -o OUTPUT_DIR
                    [-v]

This script analyzes ATAC-Seq and GRO-Seq data and produces various plots for
further data analysis.

options:
  -h, --help            show this help message and exit
  -e ATAC_PEAKS_FILENAME, --atac-peaks ATAC_PEAKS_FILENAME
                        Full path to the ATAC-Seq broadPeak file.
  -m TF_MOTIF_PATH, --motif-path TF_MOTIF_PATH
                        Path to the location of the motif sites for the
                        desired reference genome (i.e.,
                        "/usr/local/motifs/human/hg19/*").
  -r RADIUS, --radius RADIUS
                        Radius around BED regions for which to scan for
                        motifs. Default = 1500
  -g GENOME, --genome GENOME
                        Genome to which the organism is mapped (e.g. hg38,
                        mm10)
  -c CHROMOSOMES, --chromosomes CHROMOSOMES
                        Chromosome size file. See README for details in
                        generating this file.
  -t MP_THREADS, --threads MP_THREADS
                        Number of CPUs to use for multiprocessing of MD-score
                        calculations. Depends on your hardware architecture.
  -o OUTPUT_DIR, --output OUTPUT_DIR
                        Path to where scores file will be saved. Save output
                        will be your peak file rootname + _md_scores.txt.
  -v, --version         show program's version number and exit

IMPORTANT: Please ensure that ALL bed files used with this script are sorted
by the same criteria.
```

## dastk_ma_plot

### Tool Description
Generate an MA plot of TFs from a DAStk differential MD score stats file.

### Metadata
- **Docker Image**: quay.io/biocontainers/dastk:1.0.1--pyh7cba7a3_0
- **Homepage**: https://github.com/Dowell-Lab/DAStk
- **Package**: https://anaconda.org/channels/bioconda/packages/dastk/overview
- **Validation**: PASS
### Original Help Text
```text
usage: ma_plot [-h] -s STATS_FILE -m LABEL_1 -n LABEL_2 [-w WINDOW]
               [-p P_VALUE] [-l] -o OUTPUT_DIR [-v]

This script generates barcodes using the output from DAStk.

options:
  -h, --help            show this help message and exit
  -s STATS_FILE, --stats STATS_FILE
                        First MD score file generated from DAStk.
  -m LABEL_1, --label-1 LABEL_1
                        Label for the MA plot title corresponding to assay 1
  -n LABEL_2, --label-2 LABEL_2
                        Label for the MA plot title corresponding to assay 2
  -w WINDOW, --window WINDOW
                        Label for the MA plot title corresponding to window size (str). Default = '3kb'
  -p P_VALUE, --p-value P_VALUE
                        p-value cutoff to define which motifs to label in the MA plot. Defaults to 0.00001.
  -l, --label_p-value   Label all TFs falling below the specified p-value cutoff.
  -o OUTPUT_DIR, --output OUTPUT_DIR
                        Path to directory where plot will be saved.
  -v, --version         show program's version number and exit
```

## dastk_barcode_plot

### Tool Description
This script generates barcodes using the output from DAStk.

### Metadata
- **Docker Image**: quay.io/biocontainers/dastk:1.0.1--pyh7cba7a3_0
- **Homepage**: https://github.com/Dowell-Lab/DAStk
- **Package**: https://anaconda.org/channels/bioconda/packages/dastk/overview
- **Validation**: PASS
### Original Help Text
```text
usage: barcode_plot [-h] -md ASSAY_1 [-MD ASSAY_1] -a ASSAY_1 [-A ASSAY_2] -tf
                    TF -o OUTPUT_DIR [-g] [-s] [-v]

This script generates barcodes using the output from DAStk.

options:
  -h, --help            show this help message and exit
  -md ASSAY_1, --scores-1 ASSAY_1
                        First MD score file generated from DAStk.
  -MD ASSAY_1, --scores-2 ASSAY_1
                        Second MD score file generated from DAStk. Not required if argument '-s/--single' is specified.
  -a ASSAY_1, --assay-1 ASSAY_1
                        Assay name of first MD score file.
  -A ASSAY_2, --assay-2 ASSAY_2
                        Assay name of second MD score file. Will be title of barcode plot. Not required if argument '-s/--single' is specified.
  -tf TF, --transcription-factor TF
                        Transcription factor you would like to plot. Should be full prefix before the .bed extension printed in the MD score output (e.g. JUND_HUMAN.H11MO.0.A).
  -o OUTPUT_DIR, --output OUTPUT_DIR
                        Path to directory where plot will be saved.
  -g, --global-normalization
                        When specified, output barcodes will be normalized according to total number of motif hits throughout the genome (i.e. total significantly called regions from FIMO scan).
  -s, --single          Generate a single barcode rather than a side-by-side comparison.
  -v, --version         show program's version number and exit
```

## dastk_tf_intersect

### Tool Description
Generates a Venn Diagram for lists of significant TFs coming out of the DAStk differential MD score stats file results.

### Metadata
- **Docker Image**: quay.io/biocontainers/dastk:1.0.1--pyh7cba7a3_0
- **Homepage**: https://github.com/Dowell-Lab/DAStk
- **Package**: https://anaconda.org/channels/bioconda/packages/dastk/overview
- **Validation**: PASS
### Original Help Text
```text
usage: tf_intersect --stats <stats files> --rootname <rootname> --output /path/to/out

Venn Diagram Generator

===============================================================================================================

Generates a Venn Diagram for lists of significant TFs coming out of the DAStk differential MD score stats file results.

options:
  -h, --help            show this help message and exit

Required Arguments:
  -s STATS_FILES [STATS_FILES ...], --stats STATS_FILES [STATS_FILES ...]
                        Full path to stats files (minimum of two) separated by a space. Limit of 9. EITHER results from differential_md_score OR process_atac may be used, but file types should not be combined. File type will be determined based on presense or absense of 'differential' from the filename (included as an extension by default in the differential_md_score stats file output).
  -r <ROOTNAME>, --rootname <ROOTNAME>
                        Rootname for saving plots.
  -o /path/to/out/dir, --output /path/to/out/dir
                        Directory where plots will be saves.

Optional Arguments:
  -uw, --unweighted     Produce an unweighted (vs. propotional, default) venn diagram. Default = False
  -sig, --significant   Intersect motifs which are significant (differential MD score stats files only). Default = False.
  -e, --enriched        Intersect motifs which are enriched (either differentially or raw MD scores). Default = False
  -d, --depleted        Intersect motifs which are depleted (either differentially or raw MD scores). Default = False
  -p <PVALUE>, --pvalue <PVALUE>
                        p-value threshold for significant values which will be plotted. Default = pe-6.
  -m <PVALUE>, --md-score-threshold <PVALUE>
                        Differential MD score threshold for values which will be plotted (positive OR negative). Default = 0.1.
  -md <PVALUE>, --depleted-threshold <PVALUE>
                        Threshold for depletion raw MD score files. Default = 0.08.
  -me <PVALUE>, --enriched-threshold <PVALUE>
                        Threshold for enrichment raw MD score files. Default = 0.2.
  -l <PLOT_LABELS> [<PLOT_LABELS> ...], --labels <PLOT_LABELS> [<PLOT_LABELS> ...]
                        Plot labels for files provided. Number of labels provided must match the number of files provided.
  -c <COLORS> [<COLORS> ...], --colors <COLORS> [<COLORS> ...]
                        Hex colors for files provided. Number of labels provided must match the number of files provided for venn diagrams (2 or 3 files) or equal 2 for the upset catplots (4 or more files).
```

## dastk_tf_result_explanations

### Tool Description
Find known relations between the TFs with a significant activity change in DAStk differential MD score results.

### Metadata
- **Docker Image**: quay.io/biocontainers/dastk:1.0.1--pyh7cba7a3_0
- **Homepage**: https://github.com/Dowell-Lab/DAStk
- **Package**: https://anaconda.org/channels/bioconda/packages/dastk/overview
- **Validation**: PASS
### Original Help Text
```text
usage: tf_result_explanations [-h] [-p P_VAL] -d DASTK_RESULTS -o
                              OUTPUT_FILENAME [-u UNINTERESTING_NODES]
                              [-e EXTRA_CONCEPTS]

options:
  -h, --help            show this help message and exit
  -p P_VAL, --p-value P_VAL
                        P-value cutoff to determine which TFs to include from
                        DAStk's output (default=0.05).
  -d DASTK_RESULTS, --dastk-results DASTK_RESULTS
                        Results file from DAStk (*differential_md_scores.txt)
                        used to find relations between the most significant TF
                        changes in activity.
  -o OUTPUT_FILENAME, --output OUTPUT_FILENAME
                        Output filename for the report.
  -u UNINTERESTING_NODES, --uninteresting-nodes UNINTERESTING_NODES
                        File listing ontology concept URIs to ignore during
                        the pathway searches, because they are uninformative
                        for TFs (e.g."binds to DNA") or they don't apply to
                        the current study, just to minimize noise. One URI per
                        line, can optionally add a description after a TAB to
                        track the label of the ignored intersecting concepts.
                        See the example file for a format guide.
  -e EXTRA_CONCEPTS, --extra-concepts EXTRA_CONCEPTS
                        File listing extra ontology concepts to include in the
                        pathway searches, that are relevant to this study.
                        This is a two-column (TAB-separated) list, first the
                        ontology URI and second a label you'd like to use in
                        the report.
```

