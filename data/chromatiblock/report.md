# chromatiblock CWL Generation Report

## chromatiblock

### Tool Description
Large scale whole genome visualisation using colinear blocks.

### Metadata
- **Docker Image**: quay.io/biocontainers/chromatiblock:1.0.0--py_0
- **Homepage**: http://github.com/mjsull/chromatiblock/
- **Package**: https://anaconda.org/channels/bioconda/packages/chromatiblock/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/chromatiblock/overview
- **Total Downloads**: 17.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/mjsull/chromatiblock
- **Stars**: N/A
### Original Help Text
```text
usage: chromatiblock 1.0.0 [-h]
                           (-d INPUT_DIRECTORY | -f FASTA_FILES [FASTA_FILES ...])
                           [-l ORDER_LIST] [-w WORKING_DIRECTORY]
                           [-s SIBELIA_PATH] [-sm SIBELIA_MODE]
                           [-e EXTENSIONS] [-o OUT]
                           [-of {html,svg,png,pdf,all}] [-q PPI]
                           [-m MIN_BLOCK_SIZE] [-c CATEGORISE]
                           [-gb GENES_OF_INTEREST_BLAST]
                           [-gf GENES_OF_INTEREST_FILE] [-gh GENOME_HEIGHT]
                           [-vg GAP] [-ss] [-sb] [-maf MAF_ALIGNMENT]
                           [-pz SVG_PAN_ZOOM_LOCATION] [-v] [-hs HUE_START]
                           [-he HUE_END] [-t] [--force] [--keep]

chromatiblock: Large scale whole genome visualisation using colinear blocks.

Version: 1.0.0

License: GPLv3

USAGE: chromatiblock -f genome1.fasta genome2.fasta .... genomeN.fasta -w working_dir -o figure.html 

        or
     
       chromatiblock -d /path/to/fasta_directory/ -w working_dir -o figure.svg -of svg

optional arguments:
  -h, --help            show this help message and exit
  -d INPUT_DIRECTORY, --input_directory INPUT_DIRECTORY
                        Directory of fasta files to use as input.
  -f FASTA_FILES [FASTA_FILES ...], --fasta_files FASTA_FILES [FASTA_FILES ...]
                        List of fasta/genbank files to use as input
  -l ORDER_LIST, --order_list ORDER_LIST
                        List of fasta files in desired order.
  -w WORKING_DIRECTORY, --working_directory WORKING_DIRECTORY
                        Folder to write intermediate files.
  -s SIBELIA_PATH, --sibelia_path SIBELIA_PATH
                        Specify path to sibelia (does not need to be set if
                        Sibelia binary is in path).
  -sm SIBELIA_MODE, --sibelia_mode SIBELIA_MODE
                        mode for running sibelia <loose|fine|far>
  -e EXTENSIONS, --extensions EXTENSIONS
                        When -d is used for input files, chromatiblock will
                        check against this comma seperated list to determine
                        whether to add file to the list of input sequences.
  -o OUT, --out OUT     Location to write output.
  -of {html,svg,png,pdf,all}, --output_format {html,svg,png,pdf,all}
                        file format to write to, if all is selected --out will
                        be a prefix and extension will be added
  -q PPI, --ppi PPI     pixels per inch (only used for png, figure width is 8
                        inches)
  -m MIN_BLOCK_SIZE, --min_block_size MIN_BLOCK_SIZE
                        Minimum size of syntenic block.
  -c CATEGORISE, --categorise CATEGORISE
                        color blocks by category
  -gb GENES_OF_INTEREST_BLAST, --genes_of_interest_blast GENES_OF_INTEREST_BLAST
                        mark genes of interest using BLASTx
  -gf GENES_OF_INTEREST_FILE, --genes_of_interest_file GENES_OF_INTEREST_FILE
                        mark genes of interest using a file
  -gh GENOME_HEIGHT, --genome_height GENOME_HEIGHT
                        Height of genome blocks
  -vg GAP, --gap GAP    gap between genomes
  -ss, --skip_sibelia   Use sibelia output already in working directory
  -sb, --skip_blast     use existing BLASTx file for annotation
  -maf MAF_ALIGNMENT, --maf_alignment MAF_ALIGNMENT
                        use a maf file for alignment.
  -pz SVG_PAN_ZOOM_LOCATION, --svg_pan_zoom_location SVG_PAN_ZOOM_LOCATION
                        location of svg-pan-zoom.min.js
  -v, --version         print version and exit
  -hs HUE_START, --hue_start HUE_START
  -he HUE_END, --hue_end HUE_END
  -t, --add_fasta_labels
                        add fasta names to figure
  --force               overwrite working directory and output
  --keep                keep working directory

Thanks for using chromatiblock
```

