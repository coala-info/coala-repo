# gfviewer CWL Generation Report

## gfviewer

### Tool Description
Process input arguments for the GFViewer tool.

### Metadata
- **Docker Image**: quay.io/biocontainers/gfviewer:1.0.4--pyhdfd78af_0
- **Homepage**: https://github.com/sakshar/GFViewer
- **Package**: https://anaconda.org/channels/bioconda/packages/gfviewer/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/gfviewer/overview
- **Total Downloads**: 191
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/sakshar/GFViewer
- **Stars**: N/A
### Original Help Text
```text
usage: gfviewer [-h] -d DATA_FILE -g GENOME_FILE -o OUTPUT_DIRECTORY
                [-c COLOR_MAP_FILE] [-l LEGEND_LOCATION]
                [-or LEGEND_ORIENTATION] [-t TELOMERE_LENGTH]
                [-p NUMBER_OF_CHROMOSOMES_PER_PAGE]
                [-r NUMBER_OF_ROWS_IN_LEGENDS] [-cen] [-lpp] [-conc]

Process input arguments for the GFViewer tool.

optional arguments:
  -h, --help            show this help message and exit
  -d DATA_FILE, --data_file DATA_FILE
                        A file (.xlsx/.csv/.tsv) containing gene family and
                        location information for each gene
  -g GENOME_FILE, --genome_file GENOME_FILE
                        A fasta (.fasta/.fna/.fa) file containing the genome
                        sequence or a text (.txt) file containing the
                        chromosome ids with their lengths;
                        <seq_id>,<seq_length> per line
  -o OUTPUT_DIRECTORY, --output_directory OUTPUT_DIRECTORY
                        Path to the output directory
  -c COLOR_MAP_FILE, --color_map_file COLOR_MAP_FILE
                        A text (.txt) file containing the gene family (gf) ids
                        with their color codes; <gf_id>,<color_code> or
                        <gf_id>,<[0,1]>,<[0,1]>,<[0,1]> per line
  -l LEGEND_LOCATION, --legend_location LEGEND_LOCATION
                        Specify the location (upper/lower/left/right) of
                        legends only when adding them to each page (default:
                        lower)
  -or LEGEND_ORIENTATION, --legend_orientation LEGEND_ORIENTATION
                        Specify the orientation (horizontal/vertical) of
                        legends only when plotting legends separately
                        (default: horizontal)
  -t TELOMERE_LENGTH, --telomere_length TELOMERE_LENGTH
                        The length of telomeres in bp used in the plot
                        (default: 10000)
  -p NUMBER_OF_CHROMOSOMES_PER_PAGE, --number_of_chromosomes_per_page NUMBER_OF_CHROMOSOMES_PER_PAGE
                        Number of chromosomes to be plotted per page (default:
                        3)
  -r NUMBER_OF_ROWS_IN_LEGENDS, --number_of_rows_in_legends NUMBER_OF_ROWS_IN_LEGENDS
                        Number of rows in the legends (default: 2)
  -cen, --centromeres   Plot centromeres of the chromosomes along with multi
                        gene families
  -lpp, --legends_per_page
                        Plot legends per page in the PDF
  -conc, --concatenate_pages
                        Concatenate the pages into a single PDF file
```

