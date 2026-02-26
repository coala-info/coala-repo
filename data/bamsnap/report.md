# bamsnap CWL Generation Report

## bamsnap

### Tool Description
convert bam (or cram) to image

### Metadata
- **Docker Image**: quay.io/biocontainers/bamsnap:0.2.19--py_0
- **Homepage**: https://github.com/danielmsk/bamsnap
- **Package**: https://anaconda.org/channels/bioconda/packages/bamsnap/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bamsnap/overview
- **Total Downloads**: 8.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/danielmsk/bamsnap
- **Stars**: N/A
### Original Help Text
```text
usage: bamsnap <sub-command> [options]

bamsnap ver0.2.19 (2021-03-02): convert bam (or cram) to image

optional arguments:
  -h, --help            show this help message and exit
  -v, --version         show program's version number and exit
  -bam [BAM [BAM ...]]  bam or cram file(s)
  -bamlist BAMLIST      list file with bam (or cram) file paths
  -title [TITLE [TITLE ...]]
                        title (name) of bam (or cram) file(s)
  -no_title             do not draw label.
  -title_fontsize TITLE_FONTSIZE
                        font size of title
  -pos [POS [POS ...]]  genomic position (ex. 1:816687-818057, 12:7462545)
  -vcf VCF              list file with genomic positions with VCF format
  -bed BED              list file with genomic positions with BED format
  -out OUT              output file or title of output file
  -imagetype IMAGETYPE  output file type
  -conf CONF            configuration file
  -ref REF              Reference sequence fasta file (ex. hg19.fa)
  -ref_index_rebuild    if you want to rebuild fasta index file (.fai), when
                        it is older than the fasta file. (Default: false)
  -refversion REFVERSION
                        Reference version (default: hg38)
  -margin MARGIN        genomic margin size
  -save_image_only      save image only
  -image_dir_name IMAGE_DIR_NAME
                        image directory name
  -zipout               make a single zip file
  -separator_height SEPARATOR_HEIGHT
                        separator's height
  -process PROCESS      number of process for multi-processing (default: 1)
  -draw [DRAW [DRAW ...]]
                        track composition (default: -draw coordinates bamplot
                        base gene)
  -bamplot [BAMPLOT [BAMPLOT ...]]
                        track composition of bamplot (default: -bamplot
                        coverage base read)
  -width WIDTH          image width (unit:px, default: 1000)
  -height HEIGHT        image height (unit:px)
  -bgcolor BGCOLOR      background color (default: FFFFFF)
  -plot_margin_top PLOT_MARGIN_TOP
                        top margin size of plot (default: 20)
  -plot_margin_bottom PLOT_MARGIN_BOTTOM
                        bottom margin size of plot (default: 20)
  -plot_margin_left PLOT_MARGIN_LEFT
                        left margin size of plot (default: 0)
  -plot_margin_right PLOT_MARGIN_RIGHT
                        right margin size of plot (default: 0)
  -border               draw border in plot (default: false)
  -grid GRID            draw grid in plot (default: 0 (grid size))
  -read_thickness READ_THICKNESS
                        read thickness (unit:px)
  -read_gap_height READ_GAP_HEIGHT
                        read gap height (unit:px)
  -read_gap_width READ_GAP_WIDTH
                        min size of read gap width (unit:px)
  -read_bgcolor READ_BGCOLOR
                        read background color
  -read_color READ_COLOR
                        read color
  -read_pos_color READ_POS_COLOR
                        positive strand read color
  -read_neg_color READ_NEG_COLOR
                        negative strand read color
  -read_color_deletion READ_COLOR_DELETION
                        read color of deletion
  -read_color_inversion READ_COLOR_INVERSION
                        read color of inversion
  -insert_size_del_threshold INSERT_SIZE_DEL_THRESHOLD
                        insert size threshold for deletion (default: 1000)
  -insert_size_ins_threshold INSERT_SIZE_INS_THRESHOLD
                        insert size threshold for insertion (default: 50)
  -read_group READ_GROUP
                        read group
  -read_color_by READ_COLOR_BY
                        read color by
  -read_color_interchrom_chr1 READ_COLOR_INTERCHROM_CHR1
                        paired read color located in chromosome 1
  -read_color_interchrom_chr2 READ_COLOR_INTERCHROM_CHR2
                        paired read color located in chromosome 2
  -read_color_interchrom_chr3 READ_COLOR_INTERCHROM_CHR3
                        paired read color located in chromosome 3
  -read_color_interchrom_chr4 READ_COLOR_INTERCHROM_CHR4
                        paired read color located in chromosome 4
  -read_color_interchrom_chr5 READ_COLOR_INTERCHROM_CHR5
                        paired read color located in chromosome 5
  -read_color_interchrom_chr6 READ_COLOR_INTERCHROM_CHR6
                        paired read color located in chromosome 6
  -read_color_interchrom_chr7 READ_COLOR_INTERCHROM_CHR7
                        paired read color located in chromosome 7
  -read_color_interchrom_chr8 READ_COLOR_INTERCHROM_CHR8
                        paired read color located in chromosome 8
  -read_color_interchrom_chr9 READ_COLOR_INTERCHROM_CHR9
                        paired read color located in chromosome 9
  -read_color_interchrom_chr10 READ_COLOR_INTERCHROM_CHR10
                        paired read color located in chromosome 10
  -read_color_interchrom_chr11 READ_COLOR_INTERCHROM_CHR11
                        paired read color located in chromosome 11
  -read_color_interchrom_chr12 READ_COLOR_INTERCHROM_CHR12
                        paired read color located in chromosome 12
  -read_color_interchrom_chr13 READ_COLOR_INTERCHROM_CHR13
                        paired read color located in chromosome 13
  -read_color_interchrom_chr14 READ_COLOR_INTERCHROM_CHR14
                        paired read color located in chromosome 14
  -read_color_interchrom_chr15 READ_COLOR_INTERCHROM_CHR15
                        paired read color located in chromosome 15
  -read_color_interchrom_chr16 READ_COLOR_INTERCHROM_CHR16
                        paired read color located in chromosome 16
  -read_color_interchrom_chr17 READ_COLOR_INTERCHROM_CHR17
                        paired read color located in chromosome 17
  -read_color_interchrom_chr18 READ_COLOR_INTERCHROM_CHR18
                        paired read color located in chromosome 18
  -read_color_interchrom_chr19 READ_COLOR_INTERCHROM_CHR19
                        paired read color located in chromosome 19
  -read_color_interchrom_chr20 READ_COLOR_INTERCHROM_CHR20
                        paired read color located in chromosome 20
  -read_color_interchrom_chr21 READ_COLOR_INTERCHROM_CHR21
                        paired read color located in chromosome 21
  -read_color_interchrom_chr22 READ_COLOR_INTERCHROM_CHR22
                        paired read color located in chromosome 22
  -read_color_interchrom_chrX READ_COLOR_INTERCHROM_CHRX
                        paired read color located in chromosome X
  -read_color_interchrom_chrY READ_COLOR_INTERCHROM_CHRY
                        paired read color located in chromosome Y
  -read_color_interchrom_other READ_COLOR_INTERCHROM_OTHER
                        paired read color located in other chromosome
  -show_soft_clipped    show soft clipped part (default: false)
  -show_hard_clipped    show hard clipped part (default: false)
  -show_clipped         show soft and hard clipped part (default: false)
  -center_line          draw center line
  -no_target_line       do not draw target line
  -base_fontsize BASE_FONTSIZE
                        font size of base track
  -base_height BASE_HEIGHT
                        base track height
  -base_margin_top BASE_MARGIN_TOP
                        top margin size of base track
  -base_margin_bottom BASE_MARGIN_BOTTOM
                        bottom margin size of base track
  -coverage_height COVERAGE_HEIGHT
                        coverage track height
  -coverage_fontsize COVERAGE_FONTSIZE
                        coverage font size
  -coverage_vaf COVERAGE_VAF
                        coverage variant allele fraction threshold (default:
                        0.2)
  -coverage_color COVERAGE_COLOR
                        coverage color
  -coverage_bgcolor COVERAGE_BGCOLOR
                        coverage track background color
  -heatmap_height HEATMAP_HEIGHT
                        coverage heatmap height
  -heatmap_bgcolor HEATMAP_BGCOLOR
                        coverage heatmap background color
  -gene_height GENE_HEIGHT
                        gene track height
  -gene_fontsize GENE_FONTSIZE
                        font size of gene track
  -gene_pos_color GENE_POS_COLOR
                        positive strand color
  -gene_neg_color GENE_NEG_COLOR
                        negative strand color
  -coordinates_height COORDINATES_HEIGHT
                        coordinate height
  -coordinates_fontsize COORDINATES_FONTSIZE
                        coordinate font size
  -coordinates_axisloc COORDINATES_AXISLOC
                        coordinate axis location
  -coordinates_bgcolor COORDINATES_BGCOLOR
                        coordinate background color
  -coordinates_labelcolor COORDINATES_LABELCOLOR
                        coordinate label color
  -separated_bam        draw a plot for each bam
  -debug                turn on the debugging mode
  -silence              don't print any log.
```

