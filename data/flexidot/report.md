# flexidot CWL Generation Report

## flexidot

### Tool Description
FlexiDot: Flexible dotplot generation tool

### Metadata
- **Docker Image**: quay.io/biocontainers/flexidot:2.1.0--pyhdfd78af_0
- **Homepage**: https://github.com/flexidot-bio/flexidot
- **Package**: https://anaconda.org/channels/bioconda/packages/flexidot/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/flexidot/overview
- **Total Downloads**: 210
- **Last updated**: 2026-01-28
- **GitHub**: https://github.com/flexidot-bio/flexidot
- **Stars**: N/A
### Original Help Text
```text
usage: flexidot [-h] -i INFILES [INFILES ...] [-o OUTPUT_PREFIX]
                [--outdir OUTDIR] [-c] [--n_col N_COL] [--n_row N_ROW]
                [-f {png,pdf,svg}] [-s] [-k WORDSIZE] [-m {0,1,2}]
                [-t {aa,nuc}] [-w] [-S SUBSTITUTION_COUNT] [--max_n MAX_N]
                [-r] [-O] [-a ALIGNMENT_FILE]
                [--alignment_format {blast6,paf}]
                [--min_identity MIN_IDENTITY] [--min_length MIN_LENGTH]
                [-A LINE_WIDTH] [-B LINE_COL_FOR] [-C LINE_COL_REV]
                [-D {top,bottom}] [-E LABEL_SIZE] [-F SPACING] [-L] [-M]
                [-P PLOT_SIZE] [-R {0,1,2}] [-T TITLE_LENGTH]
                [-g GFF [GFF ...]] [-G GFF_COLOR_CONFIG] [-x]
                [-X LCS_SHADING_NUM] [-y {0,1,2}]
                [-Y LCS_SHADING_INTERVAL_LEN] [-z {0,1,2}]
                [-u USER_MATRIX_FILE] [-U]
                [--loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL}] [-v]
                [--logfile LOGFILE]

FlexiDot: Flexible dotplot generation tool

options:
  -h, --help            show this help message and exit
  -i, --infiles INFILES [INFILES ...]
                        Input fasta files (fasta file name or space-separated
                        file list.) (default: None)
  -o, --output_prefix OUTPUT_PREFIX
                        File prefix to be added to the generated filenames.
                        (default: flexidot_output)
  --outdir OUTDIR       Output directory. Default: current directory.
                        (default: .)
  -c, --collage         Combine multiple dotplots in a collage. (default:
                        False)
  --n_col N_COL         Number of columns per page (if collage is ON.
                        (default: 4)
  --n_row N_ROW         Number of rows per page (if collage is ON). (default:
                        5)
  -f, --filetype {png,pdf,svg}
                        Output file format: png, pdf, svg (default: png)
  -s, --sort            Sort sequences alphabetically by name. (default:
                        False)
  -k, --wordsize WORDSIZE
                        Wordsize (kmer length) for dotplot comparison.
                        (default: 10)
  -m, --mode {0,1,2}    Mode of FlexiDot dotplotting. 0 = self [default], 1 =
                        paired, 2 = poly (matrix with all-against-all
                        dotplots). Call -m multiple times to run multiple
                        modes. (default: None)
  -t, --type_seq {aa,nuc}
                        Biological sequence type: aa (amino acid) or nuc
                        (nucleotide). (default: nuc)
  -w, --wobble_conversion
                        Ambiguity handling for relaxed matching. Note: This
                        may make kmer matching slower. (default: False)
  -S, --substitution_count SUBSTITUTION_COUNT
                        Number of substitutions allowed per window. (default:
                        0)
  --max_n MAX_N         Maximum percentage of Ns allowed in a kmer window.
                        Applies only if --wobble_conversion is set, else kmers
                        with Ns are skipped. Default: 10 (default: 10)
  -r, --norev           Do not calculate reverse complementary matches (only
                        for nucleotide sequences.) (default: False)
  -O, --only_vs_first_seq
                        Limit pairwise comparisons to the 1st sequence only
                        (if plotting mode=1 paired.) (default: False)
  -a, --alignment_file ALIGNMENT_FILE
                        Pre-calculated alignment file (BLAST6 or PAF format).
                        When provided, alignments from this file will be
                        plotted instead of performing k-mer matching.
                        (default: None)
  --alignment_format {blast6,paf}
                        Format of the alignment file: 'blast6' or 'paf'. If
                        not specified, format is auto-detected from file
                        extension. (default: None)
  --min_identity MIN_IDENTITY
                        Minimum percent identity for filtering alignments
                        (0-100). Default: 0.0 (default: 0.0)
  --min_length MIN_LENGTH
                        Minimum alignment length for filtering. Default: 0
                        (default: 0)
  -A, --line_width LINE_WIDTH
                        Line width (default: 1)
  -B, --line_col_for LINE_COL_FOR
                        Line color (default: black)
  -C, --line_col_rev LINE_COL_REV
                        Reverse line color (default: green)
  -D, --x_label_pos {top,bottom}
                        Position of the X-label. Default: 'top' (default: top)
  -E, --label_size LABEL_SIZE
                        Font size (default: 10)
  -F, --spacing SPACING
                        Spacing between dotplots (if plotting mode=2
                        polyplot). (default: 0.04)
  -L, --length_scaling  Scale plot size for pairwise comparison. (default:
                        False)
  -M, --mirror_y_axis   Flip y-axis (bottom-to-top or top-to-bottom) (default:
                        False)
  -P, --plot_size PLOT_SIZE
                        Plot size (default: 10)
  -R, --representation {0,1,2}
                        Region of plot to display. Only if plotting mode is 2:
                        polyplot 0 = full [default] 1 = upper 2 = lower
                        (default: 0)
  -T, --title_length TITLE_LENGTH
                        Limit title length for comparisons. Default: 50
                        characters (default: 50)
  -g, --gff GFF [GFF ...]
                        GFF3 files for markup in self-dotplots. Provide a
                        space-delimited list of GFF files. (default: None)
  -G, --gff_color_config GFF_COLOR_CONFIG
                        Config file for custom GFF shading. (default: None)
  -x, --lcs_shading     Shade subdotplot based on longest common subsequence
                        (LCS). (default: False)
  -X, --lcs_shading_num LCS_SHADING_NUM
                        Number of shading intervals. (default: 5)
  -y, --lcs_shading_ref {0,1,2}
                        Reference for LCS shading. 0 = maximal LCS length
                        [default] 1 = maximally possible length (length of
                        shorter sequence in pairwise comparison) 2 = given
                        interval sizes - DNA [default 100 bp] or proteins
                        [default 10 aa] - see -Y (default: 0)
  -Y, --lcs_shading_interval_len LCS_SHADING_INTERVAL_LEN
                        Length of intervals for LCS shading (only if
                        --lcs_shading_ref=2) [default for nucleotides = 50;
                        default for amino acids = 10] (default: 50)
  -z, --lcs_shading_ori {0,1,2}
                        Shade subdotplots based on LCS 0 = forward [default] 1
                        = reverse, or 2 = both strands (forward shading above
                        diagonal, reverse shading on diagonal and below; if
                        using --user_matrix_file, best LCS is used below
                        diagonal) (default: 0)
  -u, --user_matrix_file USER_MATRIX_FILE
                        Matrix file for shading above diagonal. (default:
                        None)
  -U, --user_matrix_print
                        Display matrix entries above diagonal. (default:
                        False)
  --loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set logging level. Default: 'INFO' (default: INFO)
  -v, --version         show program's version number and exit
  --logfile LOGFILE     Name of log file (default: None)
```


## Metadata
- **Skill**: generated
