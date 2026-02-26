# gw CWL Generation Report

## gw

### Tool Description
Reference genome in .fasta format with .fai index file

### Metadata
- **Docker Image**: quay.io/biocontainers/gw:1.2.6--hff18be8_0
- **Homepage**: https://github.com/kcleal/gw
- **Package**: https://anaconda.org/channels/bioconda/packages/gw/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/gw/overview
- **Total Downloads**: 54.2K
- **Last updated**: 2025-10-31
- **GitHub**: https://github.com/kcleal/gw
- **Stars**: N/A
### Original Help Text
```text
Unknown argument: --h
Usage: gw [options] genome 

Positional arguments:
genome            	Reference genome in .fasta format with .fai index file [default: ""]

Optional arguments:
-h --help         	shows help message and exits [default: false]
-v --version      	prints version information and exits [default: false]
--version         	Show version information [default: false]
-b --bam          	Bam/cram alignment file. Repeat for multiple files stacked vertically [default: ""]
-r --region       	Region of alignment file to display in window. Repeat to horizontally split window into multiple regions
-v --variants     	VCF/BCF/BED file to derive regions from. Can not be used with -i [default: ""]
-i --images       	Glob path to .png images to display e.g. '*.png'. Can not be used with -v
-o --outdir       	Output folder to save images
-f --file         	Output single image to file
--ideogram        	Ideogram bed file (uncompressed). Any bed file should work
-n --no-show      	Don't display images to screen [default: false]
-d --dims         	Image dimensions (px) [default: "1366x800"]
-u --number       	Images tiles to display (used with -v and -i) [default: "3x3"]
-t --threads      	Number of threads to use [default: 4]
--theme           	Image theme igv|dark|slate [default: "dark"]
--fmt             	Output file format [default: "png"]
--track           	Track to display at bottom of window BED/VCF/GFF3/GTF/BEGBID/BIGWIG. Repeat for multiple files stacked vertically [default: ""]
--parse-label     	Label to parse from vcf file (used with -v) e.g. 'filter' or 'info.SU' or 'qual' [default: "filter"]
--labels          	Choice of labels to use. Provide as comma-separated list e.g. 'PASS,FAIL' [default: "PASS,FAIL"]
--in-labels       	Input labels from tab-separated FILE (use with -v or -i) [default: ""]
--out-vcf         	Output labelling results to vcf FILE (the -v option is required) [default: ""]
--out-labels      	Output labelling results to tab-separated FILE (use with -v or -i) [default: ""]
--session         	GW session file to load (.ini suffix) [default: ""]
--start-index     	Start labelling from -v / -i index (zero-based) [default: 0]
--resume          	Resume labelling from last user-labelled variant [default: false]
--pad             	Padding +/- in bp to add to each region from -v or -r [default: 500]
--ylim            	Maximum y limit (depth) of reads in image [default: 50]
--cov             	Maximum y limit of coverage track [default: 50]
--min-chrom-size  	Minimum chromosome size for chromosome-scale images [default: 10000000]
--no-insertions   	Insertions below --indel-length are not shown [default: false]
--no-edges        	Edge colours are not shown [default: false]
--no-mismatches   	Mismatches are not shown [default: false]
--no-soft-clips   	Soft-clips are not shown [default: false]
--mods            	Base modifications are shown [default: false]
--low-mem         	Reduce memory usage by discarding quality values [default: false]
--log2-cov        	Scale coverage track to log2 [default: false]
--split-view-size 	Max variant size before region is split into two smaller panes (used with -v only) [default: 10000]
--indel-length    	Indels >= this length (bp) will have text labels [default: 15]
--tlen-y          	Y-axis will be set to template-length (tlen) bp. Relevant for paired-end reads only [default: false]
--max-tlen        	Maximum tlen to display on plot [default: 2000]
--link            	Draw linking lines between these alignments [default: "none"]
--filter          	Filter to apply to all reads [default: ""]
-c --command      	Apply command before drawing e.g. -c 'sort strand' [default: ""]
--delay           	Delay in milliseconds before each update, useful for remote connections [default: 0]
--config          	Display path of loaded .gw.ini config [default: false]
```

