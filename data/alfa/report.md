# alfa CWL Generation Report

## alfa

### Tool Description
ALFA (Automated Labelling of Feature Annotations) is a tool for genome-wide annotation of sequencing data, providing a global overview of the distribution of reads across genomic features.

### Metadata
- **Docker Image**: quay.io/biocontainers/alfa:1.1.1--pyh5e36f6f_0
- **Homepage**: https://github.com/biocompibens/ALFA
- **Package**: https://anaconda.org/channels/bioconda/packages/alfa/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/alfa/overview
- **Total Downloads**: 3.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/biocompibens/ALFA
- **Stars**: N/A
### Original Help Text
```text
usage: 
    README on GitHub: https://github.com/biocompibens/ALFA/blob/master/README.md
    
    Generate ALFA genome indexes:
         alfa -a GTF [-g GENOME_INDEX_BASENAME]
                                        [--chr_len CHR_LENGTHS_FILE]
                                        [-p NB_PROCESSORS]
    Process BAM file(s):
         alfa -g GENOME_INDEX_BASENAME --bam BAM1 LABEL1 [BAM2 LABEL2 ...]
                                        [--bedgraph] [-s STRAND]
                                        [-d {1,2,3,4}] [-t YMIN YMAX]
                                        [--keep_ambiguous]
                                        [-n] [--pdf output.pdf] [--svg output.svg] [--png output.png]
                                        [-p NB_PROCESSORS]
    Index genome + process BAM files(s):
         alfa -a GTF [-g GENOME_INDEX_BASENAME] [--chr_len CHR_LENGTHS_FILE]
                                        --bam BAM1 LABEL1 [BAM2 LABEL2 ...]
                                        [--bedgraph][-s STRAND]
                                        [-d {1,2,3,4}] [-t YMIN YMAX]
                                        [--keep_ambiguous]
                                        [-n] [--pdf output.pdf] [--svg output.svg] [--png output.png]
                                        [-p NB_PROCESSORS]

    Process previously created ALFA count file(s):
         alfa -c COUNTS1 [COUNTS2 ...]
                                        [-s STRAND]
                                        [-d {1,2,3,4}] [-t YMIN YMAX]
                                        [-n] [--pdf output.pdf] [--svg output.svg] [--png output.png]

        

optional arguments:
  -h, --help            show this help message and exit
  --version             Show ALFA version number and exit.
                        
                        -----------
                        
  -g GENOME_INDEX_BASENAME, --genome_index GENOME_INDEX_BASENAME
                        Genome index files path and basename for existing index, or path and basename for new index creation.
                        
  -a GTF_FILE, --annotation GTF_FILE
                        Genomic annotations file (GTF format).
                        
  --chr_len CHR_LEN     Tabulated file containing chromosome names and lengths.
                        
                        -----------
                        
  --bam BAM1 LABEL1 [ ...]
                        Input BAM file(s) and label(s). The BAM files must be sorted by position.
                        
  --bedgraph BEDGRAPH1 LABEL1 [ ...]
                        Use this options if your input(s) is/are BedGraph file(s). If stranded, provide the BedGraph files
                        for each strand for all samples (e.g. '--bedgraph file.plus.bedgraph file.minus.bedgraph LABEL').
                        
  -c COUNTS1 [ ...], --counts COUNTS1 [ ...]
                        Use this options instead of '--bam/--bedgraph' to provide ALFA counts files as input 
                        instead of bam/bedgraph files.
                        
  -s , --strandness     Library orientation. Choose within: 'unstranded', 'forward'/'fr-firststrand' 
                        or 'reverse'/'fr-secondstrand'. (Default: 'unstranded')
                        
                        -----------
                        
  -d {1,2,3,4}, --categories_depth {1,2,3,4}
                        Use this option to set the hierarchical level that will be considered in the GTF file (default=3): 
                        (1) gene,intergenic; 
                        (2) intron,exon,intergenic; 
                        (3) 5'UTR,CDS,3'UTR,intron,intergenic; 
                        (4) start_codon,5'UTR,CDS,3'UTR,stop_codon,intron,intergenic. 
                        
  --pdf [PDF]           Save produced plots in PDF format at the specified path ('categories_plots.pdf' if no argument provided).
                        
  --png [PNG]           Save produced plots in PNG format with the provided argument as basename 
                        ('categories.png' and 'biotypes.png' if no argument provided).
                        
  --svg [SVG]           Save produced plots in SVG format with the provided argument as basename 
                        or 'categories.svg' and 'biotypes.svg' if no argument provided.
                        
  -n, --no_display      Do not display plots.
                        
  -t YMIN YMAX, --threshold YMIN YMAX
                        Set ordinate axis limits for enrichment plots.
                        
  -p NB_PROCESSORS, --processors NB_PROCESSORS
                        Set the number of processors used for multi-processing operations.
                        
  --keep_ambiguous      Keep reads mapping to different features (discarded by default).
                        
  --temp_dir TEMP_DIR   Temp directory to store pybedtools files ('/tmp/' by default).
                        
  -o OUTPUT_DIR         Output directory for all files created by ALFA (current dir by default).
```

