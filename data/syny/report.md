# syny CWL Generation Report

## syny_run_syny.pl

### Tool Description
Runs the SYNY pipeline

### Metadata
- **Docker Image**: quay.io/biocontainers/syny:1.3.2--py312pl5321h7e72e81_0
- **Homepage**: https://github.com/PombertLab/SYNY
- **Package**: https://anaconda.org/channels/bioconda/packages/syny/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/syny/overview
- **Total Downloads**: 28.4K
- **Last updated**: 2026-02-11
- **GitHub**: https://github.com/PombertLab/SYNY
- **Stars**: N/A
### Original Help Text
```text
NAME        run_syny.pl
VERSION     0.9a
UPDATED     2025-03-28
SYNOPSIS    Runs the SYNY pipeline

REQS        Perl / PerlIO::gzip - https://metacpan.org/pod/PerlIO::gzip
            Python3 / matplotlib / seaborn / pandas - https://www.python.org/
            Diamond - https://github.com/bbuchfink/diamond
            Minimap2 - https://github.com/lh3/minimap2
            MashMap3 - https://github.com/marbl/MashMap
            Circos - http://circos.ca/

USAGE       run_syny.pl \
              -t 16 \
              -a *.gbff \
              -o SYNY \
              -e 1e-10 \
              -g 0 1 5 \
              --circos pair

OPTIONS:
-h (--help)             Display all command line options
-t (--threads)          Number of threads to use [Default: 16]
-p (--pthreads)         Number of graphs to plot in parralel; defaults to --threads if unspecified
-a (--annot)            GenBank GBF/GBFF Annotation files (GZIP files are supported)
-o (--outdir)           Output directory [Default = SYNY]
-e (--evalue)           DIAMOND BLASTP evalue cutoff [Default = 1e-10]
-g (--gaps)             Allowable number of gaps between gene pairs [Default = 0]

--minsize               Minimum contig size (in bp) [Default: 1]
--include               Select contigs with names from input text file(s) (one name per line); i.e. exclude everything else
--ranges                Select contigs with subranges from input text file(s): name start end
--exclude               Exclude contigs with names matching the regular expression(s); e.g. --exclude '^AUX'
--aligner               Specify genome alignment tool: minimap or mashmap [Default: minimap]
--asm                   Specify minimap max divergence preset (--asm 5, 10 or 20) [Default: off]
--mpid                  Specify mashmap3 percentage identity [Default: 85]
--resume                Resume minimap/mashmap computations (skip completed alignments)
--min_asize             Filter out alignments/clusters smaller than integer value (e.g. --min_asize 5000)
--no_sec                Turn off minimap2 secondary alignments
--no_map                Skip minimap/mashmap pairwise genome alignments
--no_vcf                Skip minimap VCF file creation (files can be quite large)
--no_clus               Skip gene cluster reconstructions
--version               Display SYNY version

### Circos plots
-c (--circos)           Circos plot mode: pair (pairwise), cat (concatenated), all (cat + pair) [Default: pair]
--orientation           Karyotype orientation: normal, inverted or both [Default: normal]
--circos_prefix         Prefix for concatenated plots [Default: circos]
-r (--ref)              Reference to use for concatenated plots; uses first genome (alphabetically) if ommitted
-u (--unit)             Size unit (Kb or Mb) [Default: Mb]
--winsize               Sliding windows size (nucleotide biases) [Default: 10000]
--stepsize              Sliding windows step (nucleotide biases) [Default: 5000]
--labels                Contig label type: mixed (arabic + roman numbers), arabic, roman, or names [Default: mixed]
--label_size            Contig label size [Default: 36]
--label_font            Contig label font [Default: bold]
--custom_file           Load custom colors from file
--list_preset           List available custom color presets
--custom_preset         Use a custom color preset, e.g.: --custom_preset chloropicon
--max_ticks             Set max number of ticks [Default: 5000]
--max_ideograms         Set max number of ideograms [Default: 200]
--max_links             Set max number of links [Default: 75000]
--max_points_per_track  Set max number of points per track [Default: 75000]
--clusters              Color by cluster instead of contig/chromosome [Default: off]
--no_ntbiases           Turn off nucleotide biases and GC/AT skews subplots
--no_skews              Turn off GC / AT skews subplots
--no_cticks             Turn off ticks in Circos plots
--no_circos             Turn off Circos plots

### Barplots
-bh (--bheight)         Barplot figure height in inches [Default: 10.8]
-bw (--bwidth)          Barplot figure width in inches [Default: 19.2]
--bfsize                Barplot font size [Default: 8]
--palette               Barplot color palette [Default: Spectral]
--monobar               Use a monochrome barplot color instead: e.g. --monobar blue
--bclusters             Color clusters by alternating colors; colors are not related within/between contigs; [Default: off]
--bpmode                Barplot mode: pair (pairwise), cat (concatenated), all (cat + pair) [Default: pair]
--no_barplot            Turn off barplots

### Dotplots
-dh (--dheight)         Dotplot figure height in inches [Default: 10.8]
-dw (--dwidth)          Dotplot figure width in inches [Default: 19.2]
--dfsize                Dotplot font size [Default: 8]
-m (--multi)            Axes units multiplier (for dotplots) [Default: 1e5]
--color                 Dotplot color [Default: blue]
--dotpalette            Use a color palette instead: e.g. --dotpalette inferno
--noticks               Turn off ticks on x and y axes
--wdis                  Horizontal distance (width) between subplots [Default: 0.05]
--hdis                  Vertical distance (height) between subplots [Default: 0.1]
--no_dotplot            Turn off dotplots

### Heatmaps
-hh (--hheight)         Heatmap figure height in inches [Default: 10]
-hw (--hwidth)          Heatmap figure width in inches [Default: 10]
--hfsize                Heatmap font size [Default: 8]
--hmpalette             Heatmap color palette [Default: winter_r]
--hmax                  Set maximum color bar value [Default: 100]
--hmin                  Set minimum color bar value [Default: 0]
--hauto                 Set color bar values automatically instead
--no_heatmap            Turn off heatmaps

### Linear maps
-lh (--lheight)         Linear map figure height in inches [Default: 5]
-lw (--lwidth)          Heatmap figure width in inches [Default: 20]
--lm_rpalette           Reference genome color palette [Default: tab20]
--lm_xpalette           Target genome color palette [Default: Blues]
--lmrotation            Contig name rotation [Default: 90]
--lfsize                Font size [Default: 8]
--no_linemap            Turn off linemaps
```

