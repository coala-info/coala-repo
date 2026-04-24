cwlVersion: v1.2
class: CommandLineTool
baseCommand: bamsnap
label: bamsnap
doc: "convert bam (or cram) to image\n\nTool homepage: https://github.com/danielmsk/bamsnap"
inputs:
  - id: sub_command
    type: string
    doc: sub-command
    inputBinding:
      position: 1
  - id: bam_files
    type:
      - 'null'
      - type: array
        items: File
    doc: bam or cram file(s)
    inputBinding:
      position: 102
      prefix: -bam
  - id: bamlist
    type:
      - 'null'
      - File
    doc: list file with bam (or cram) file paths
    inputBinding:
      position: 102
      prefix: -bamlist
  - id: bamplot
    type:
      - 'null'
      - type: array
        items: string
    doc: 'track composition of bamplot (default: -bamplot coverage base read)'
    inputBinding:
      position: 102
      prefix: -bamplot
  - id: base_fontsize
    type:
      - 'null'
      - int
    doc: font size of base track
    inputBinding:
      position: 102
      prefix: -base_fontsize
  - id: base_height
    type:
      - 'null'
      - int
    doc: base track height
    inputBinding:
      position: 102
      prefix: -base_height
  - id: base_margin_bottom
    type:
      - 'null'
      - int
    doc: bottom margin size of base track
    inputBinding:
      position: 102
      prefix: -base_margin_bottom
  - id: base_margin_top
    type:
      - 'null'
      - int
    doc: top margin size of base track
    inputBinding:
      position: 102
      prefix: -base_margin_top
  - id: bed_file
    type:
      - 'null'
      - File
    doc: list file with genomic positions with BED format
    inputBinding:
      position: 102
      prefix: -bed
  - id: bgcolor
    type:
      - 'null'
      - string
    doc: 'background color (default: FFFFFF)'
    inputBinding:
      position: 102
      prefix: -bgcolor
  - id: border
    type:
      - 'null'
      - boolean
    doc: 'draw border in plot (default: false)'
    inputBinding:
      position: 102
      prefix: -border
  - id: center_line
    type:
      - 'null'
      - boolean
    doc: draw center line
    inputBinding:
      position: 102
      prefix: -center_line
  - id: conf
    type:
      - 'null'
      - File
    doc: configuration file
    inputBinding:
      position: 102
      prefix: -conf
  - id: coordinates_axisloc
    type:
      - 'null'
      - string
    doc: coordinate axis location
    inputBinding:
      position: 102
      prefix: -coordinates_axisloc
  - id: coordinates_bgcolor
    type:
      - 'null'
      - string
    doc: coordinate background color
    inputBinding:
      position: 102
      prefix: -coordinates_bgcolor
  - id: coordinates_fontsize
    type:
      - 'null'
      - int
    doc: coordinate font size
    inputBinding:
      position: 102
      prefix: -coordinates_fontsize
  - id: coordinates_height
    type:
      - 'null'
      - int
    doc: coordinate height
    inputBinding:
      position: 102
      prefix: -coordinates_height
  - id: coordinates_labelcolor
    type:
      - 'null'
      - string
    doc: coordinate label color
    inputBinding:
      position: 102
      prefix: -coordinates_labelcolor
  - id: coverage_bgcolor
    type:
      - 'null'
      - string
    doc: coverage track background color
    inputBinding:
      position: 102
      prefix: -coverage_bgcolor
  - id: coverage_color
    type:
      - 'null'
      - string
    doc: coverage color
    inputBinding:
      position: 102
      prefix: -coverage_color
  - id: coverage_fontsize
    type:
      - 'null'
      - int
    doc: coverage font size
    inputBinding:
      position: 102
      prefix: -coverage_fontsize
  - id: coverage_height
    type:
      - 'null'
      - int
    doc: coverage track height
    inputBinding:
      position: 102
      prefix: -coverage_height
  - id: coverage_vaf
    type:
      - 'null'
      - float
    doc: 'coverage variant allele fraction threshold (default: 0.2)'
    inputBinding:
      position: 102
      prefix: -coverage_vaf
  - id: debug
    type:
      - 'null'
      - boolean
    doc: turn on the debugging mode
    inputBinding:
      position: 102
      prefix: -debug
  - id: draw
    type:
      - 'null'
      - type: array
        items: string
    doc: 'track composition (default: -draw coordinates bamplot base gene)'
    inputBinding:
      position: 102
      prefix: -draw
  - id: gene_fontsize
    type:
      - 'null'
      - int
    doc: font size of gene track
    inputBinding:
      position: 102
      prefix: -gene_fontsize
  - id: gene_height
    type:
      - 'null'
      - int
    doc: gene track height
    inputBinding:
      position: 102
      prefix: -gene_height
  - id: gene_neg_color
    type:
      - 'null'
      - string
    doc: negative strand color
    inputBinding:
      position: 102
      prefix: -gene_neg_color
  - id: gene_pos_color
    type:
      - 'null'
      - string
    doc: positive strand color
    inputBinding:
      position: 102
      prefix: -gene_pos_color
  - id: grid
    type:
      - 'null'
      - int
    doc: 'draw grid in plot (default: 0 (grid size))'
    inputBinding:
      position: 102
      prefix: -grid
  - id: heatmap_bgcolor
    type:
      - 'null'
      - string
    doc: coverage heatmap background color
    inputBinding:
      position: 102
      prefix: -heatmap_bgcolor
  - id: heatmap_height
    type:
      - 'null'
      - int
    doc: coverage heatmap height
    inputBinding:
      position: 102
      prefix: -heatmap_height
  - id: height
    type:
      - 'null'
      - int
    doc: image height (unit:px)
    inputBinding:
      position: 102
      prefix: -height
  - id: image_dir_name
    type:
      - 'null'
      - string
    doc: image directory name
    inputBinding:
      position: 102
      prefix: -image_dir_name
  - id: imagetype
    type:
      - 'null'
      - string
    doc: output file type
    inputBinding:
      position: 102
      prefix: -imagetype
  - id: insert_size_del_threshold
    type:
      - 'null'
      - int
    doc: 'insert size threshold for deletion (default: 1000)'
    inputBinding:
      position: 102
      prefix: -insert_size_del_threshold
  - id: insert_size_ins_threshold
    type:
      - 'null'
      - int
    doc: 'insert size threshold for insertion (default: 50)'
    inputBinding:
      position: 102
      prefix: -insert_size_ins_threshold
  - id: margin
    type:
      - 'null'
      - int
    doc: genomic margin size
    inputBinding:
      position: 102
      prefix: -margin
  - id: no_target_line
    type:
      - 'null'
      - boolean
    doc: do not draw target line
    inputBinding:
      position: 102
      prefix: -no_target_line
  - id: no_title
    type:
      - 'null'
      - boolean
    doc: do not draw label.
    inputBinding:
      position: 102
      prefix: -no_title
  - id: plot_margin_bottom
    type:
      - 'null'
      - int
    doc: 'bottom margin size of plot (default: 20)'
    inputBinding:
      position: 102
      prefix: -plot_margin_bottom
  - id: plot_margin_left
    type:
      - 'null'
      - int
    doc: 'left margin size of plot (default: 0)'
    inputBinding:
      position: 102
      prefix: -plot_margin_left
  - id: plot_margin_right
    type:
      - 'null'
      - int
    doc: 'right margin size of plot (default: 0)'
    inputBinding:
      position: 102
      prefix: -plot_margin_right
  - id: plot_margin_top
    type:
      - 'null'
      - int
    doc: 'top margin size of plot (default: 20)'
    inputBinding:
      position: 102
      prefix: -plot_margin_top
  - id: positions
    type:
      - 'null'
      - type: array
        items: string
    doc: genomic position (ex. 1:816687-818057, 12:7462545)
    inputBinding:
      position: 102
      prefix: -pos
  - id: process
    type:
      - 'null'
      - int
    doc: 'number of process for multi-processing (default: 1)'
    inputBinding:
      position: 102
      prefix: -process
  - id: read_bgcolor
    type:
      - 'null'
      - string
    doc: read background color
    inputBinding:
      position: 102
      prefix: -read_bgcolor
  - id: read_color
    type:
      - 'null'
      - string
    doc: read color
    inputBinding:
      position: 102
      prefix: -read_color
  - id: read_color_by
    type:
      - 'null'
      - string
    doc: read color by
    inputBinding:
      position: 102
      prefix: -read_color_by
  - id: read_color_deletion
    type:
      - 'null'
      - string
    doc: read color of deletion
    inputBinding:
      position: 102
      prefix: -read_color_deletion
  - id: read_color_interchrom_chr1
    type:
      - 'null'
      - string
    doc: paired read color located in chromosome 1
    inputBinding:
      position: 102
      prefix: -read_color_interchrom_chr1
  - id: read_color_interchrom_chr10
    type:
      - 'null'
      - string
    doc: paired read color located in chromosome 10
    inputBinding:
      position: 102
      prefix: -read_color_interchrom_chr10
  - id: read_color_interchrom_chr11
    type:
      - 'null'
      - string
    doc: paired read color located in chromosome 11
    inputBinding:
      position: 102
      prefix: -read_color_interchrom_chr11
  - id: read_color_interchrom_chr12
    type:
      - 'null'
      - string
    doc: paired read color located in chromosome 12
    inputBinding:
      position: 102
      prefix: -read_color_interchrom_chr12
  - id: read_color_interchrom_chr13
    type:
      - 'null'
      - string
    doc: paired read color located in chromosome 13
    inputBinding:
      position: 102
      prefix: -read_color_interchrom_chr13
  - id: read_color_interchrom_chr14
    type:
      - 'null'
      - string
    doc: paired read color located in chromosome 14
    inputBinding:
      position: 102
      prefix: -read_color_interchrom_chr14
  - id: read_color_interchrom_chr15
    type:
      - 'null'
      - string
    doc: paired read color located in chromosome 15
    inputBinding:
      position: 102
      prefix: -read_color_interchrom_chr15
  - id: read_color_interchrom_chr16
    type:
      - 'null'
      - string
    doc: paired read color located in chromosome 16
    inputBinding:
      position: 102
      prefix: -read_color_interchrom_chr16
  - id: read_color_interchrom_chr17
    type:
      - 'null'
      - string
    doc: paired read color located in chromosome 17
    inputBinding:
      position: 102
      prefix: -read_color_interchrom_chr17
  - id: read_color_interchrom_chr18
    type:
      - 'null'
      - string
    doc: paired read color located in chromosome 18
    inputBinding:
      position: 102
      prefix: -read_color_interchrom_chr18
  - id: read_color_interchrom_chr19
    type:
      - 'null'
      - string
    doc: paired read color located in chromosome 19
    inputBinding:
      position: 102
      prefix: -read_color_interchrom_chr19
  - id: read_color_interchrom_chr2
    type:
      - 'null'
      - string
    doc: paired read color located in chromosome 2
    inputBinding:
      position: 102
      prefix: -read_color_interchrom_chr2
  - id: read_color_interchrom_chr20
    type:
      - 'null'
      - string
    doc: paired read color located in chromosome 20
    inputBinding:
      position: 102
      prefix: -read_color_interchrom_chr20
  - id: read_color_interchrom_chr21
    type:
      - 'null'
      - string
    doc: paired read color located in chromosome 21
    inputBinding:
      position: 102
      prefix: -read_color_interchrom_chr21
  - id: read_color_interchrom_chr22
    type:
      - 'null'
      - string
    doc: paired read color located in chromosome 22
    inputBinding:
      position: 102
      prefix: -read_color_interchrom_chr22
  - id: read_color_interchrom_chr3
    type:
      - 'null'
      - string
    doc: paired read color located in chromosome 3
    inputBinding:
      position: 102
      prefix: -read_color_interchrom_chr3
  - id: read_color_interchrom_chr4
    type:
      - 'null'
      - string
    doc: paired read color located in chromosome 4
    inputBinding:
      position: 102
      prefix: -read_color_interchrom_chr4
  - id: read_color_interchrom_chr5
    type:
      - 'null'
      - string
    doc: paired read color located in chromosome 5
    inputBinding:
      position: 102
      prefix: -read_color_interchrom_chr5
  - id: read_color_interchrom_chr6
    type:
      - 'null'
      - string
    doc: paired read color located in chromosome 6
    inputBinding:
      position: 102
      prefix: -read_color_interchrom_chr6
  - id: read_color_interchrom_chr7
    type:
      - 'null'
      - string
    doc: paired read color located in chromosome 7
    inputBinding:
      position: 102
      prefix: -read_color_interchrom_chr7
  - id: read_color_interchrom_chr8
    type:
      - 'null'
      - string
    doc: paired read color located in chromosome 8
    inputBinding:
      position: 102
      prefix: -read_color_interchrom_chr8
  - id: read_color_interchrom_chr9
    type:
      - 'null'
      - string
    doc: paired read color located in chromosome 9
    inputBinding:
      position: 102
      prefix: -read_color_interchrom_chr9
  - id: read_color_interchrom_chrX
    type:
      - 'null'
      - string
    doc: paired read color located in chromosome X
    inputBinding:
      position: 102
      prefix: -read_color_interchrom_chrX
  - id: read_color_interchrom_chrY
    type:
      - 'null'
      - string
    doc: paired read color located in chromosome Y
    inputBinding:
      position: 102
      prefix: -read_color_interchrom_chrY
  - id: read_color_interchrom_other
    type:
      - 'null'
      - string
    doc: paired read color located in other chromosome
    inputBinding:
      position: 102
      prefix: -read_color_interchrom_other
  - id: read_color_inversion
    type:
      - 'null'
      - string
    doc: read color of inversion
    inputBinding:
      position: 102
      prefix: -read_color_inversion
  - id: read_gap_height
    type:
      - 'null'
      - int
    doc: read gap height (unit:px)
    inputBinding:
      position: 102
      prefix: -read_gap_height
  - id: read_gap_width
    type:
      - 'null'
      - int
    doc: min size of read gap width (unit:px)
    inputBinding:
      position: 102
      prefix: -read_gap_width
  - id: read_group
    type:
      - 'null'
      - string
    doc: read group
    inputBinding:
      position: 102
      prefix: -read_group
  - id: read_neg_color
    type:
      - 'null'
      - string
    doc: negative strand read color
    inputBinding:
      position: 102
      prefix: -read_neg_color
  - id: read_pos_color
    type:
      - 'null'
      - string
    doc: positive strand read color
    inputBinding:
      position: 102
      prefix: -read_pos_color
  - id: read_thickness
    type:
      - 'null'
      - int
    doc: read thickness (unit:px)
    inputBinding:
      position: 102
      prefix: -read_thickness
  - id: ref
    type:
      - 'null'
      - File
    doc: Reference sequence fasta file (ex. hg19.fa)
    inputBinding:
      position: 102
      prefix: -ref
  - id: ref_index_rebuild
    type:
      - 'null'
      - boolean
    doc: 'if you want to rebuild fasta index file (.fai), when it is older than the
      fasta file. (Default: false)'
    inputBinding:
      position: 102
      prefix: -ref_index_rebuild
  - id: refversion
    type:
      - 'null'
      - string
    doc: 'Reference version (default: hg38)'
    inputBinding:
      position: 102
      prefix: -refversion
  - id: save_image_only
    type:
      - 'null'
      - boolean
    doc: save image only
    inputBinding:
      position: 102
      prefix: -save_image_only
  - id: separated_bam
    type:
      - 'null'
      - boolean
    doc: draw a plot for each bam
    inputBinding:
      position: 102
      prefix: -separated_bam
  - id: separator_height
    type:
      - 'null'
      - int
    doc: separator's height
    inputBinding:
      position: 102
      prefix: -separator_height
  - id: show_clipped
    type:
      - 'null'
      - boolean
    doc: 'show soft and hard clipped part (default: false)'
    inputBinding:
      position: 102
      prefix: -show_clipped
  - id: show_hard_clipped
    type:
      - 'null'
      - boolean
    doc: 'show hard clipped part (default: false)'
    inputBinding:
      position: 102
      prefix: -show_hard_clipped
  - id: show_soft_clipped
    type:
      - 'null'
      - boolean
    doc: 'show soft clipped part (default: false)'
    inputBinding:
      position: 102
      prefix: -show_soft_clipped
  - id: silence
    type:
      - 'null'
      - boolean
    doc: don't print any log.
    inputBinding:
      position: 102
      prefix: -silence
  - id: title_fontsize
    type:
      - 'null'
      - int
    doc: font size of title
    inputBinding:
      position: 102
      prefix: -title_fontsize
  - id: titles
    type:
      - 'null'
      - type: array
        items: string
    doc: title (name) of bam (or cram) file(s)
    inputBinding:
      position: 102
      prefix: -title
  - id: vcf_file
    type:
      - 'null'
      - File
    doc: list file with genomic positions with VCF format
    inputBinding:
      position: 102
      prefix: -vcf
  - id: width
    type:
      - 'null'
      - int
    doc: 'image width (unit:px, default: 1000)'
    inputBinding:
      position: 102
      prefix: -width
  - id: zipout
    type:
      - 'null'
      - boolean
    doc: make a single zip file
    inputBinding:
      position: 102
      prefix: -zipout
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: output file or title of output file
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bamsnap:0.2.19--py_0
