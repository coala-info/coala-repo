# virusrecom CWL Generation Report

## virusrecom

### Tool Description
Detecting recombination of viral lineages (or subtypes) using information theory.

### Metadata
- **Docker Image**: quay.io/biocontainers/virusrecom:1.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/ZhijianZhou01/virusrecom
- **Package**: https://anaconda.org/channels/bioconda/packages/virusrecom/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/virusrecom/overview
- **Total Downloads**: 10.6K
- **Last updated**: 2025-12-26
- **GitHub**: https://github.com/ZhijianZhou01/virusrecom
- **Stars**: N/A
### Original Help Text
```text
-------------------------------------------------
  Name: Virus Recombination (VirusRecom)
  Description: Detecting recombination of viral lineages (or subtypes) using information theory.
  Version: 1.4.0 (2025-12-15)
  Author: Zhi-Jian Zhou
  Citation: Brief Bioinform. 2023 Jan 19;24(1)
-------------------------------------------------

usage: virusrecom [-h] [-a ALIGNMENT] [-ua UNALIGNMENT] [-at ALIGN_TOOL]
                  [-iwic INPUT_WIC] [-q QUERY] [-map MAPPING] [-g GAP]
                  [-m METHOD] [-w WINDOW] [-s STEP] [-mr MAX_REGION]
                  [-cp PERCENTAGE] [-cu CUMULATIVE] [-b BREAKPOINT]
                  [-bw BREAKWIN] [-t THREAD] [-y Y_START] [-le LEGEND]
                  [-owic ONLY_WIC] [-e ENGRAVE] [-en EXPORT_NAME] [-o OUTDIR]
                  [--block BLOCK_SIZE] [--no_wic_fig] [--no_mwic_fig]

options:
  -h, --help          show this help message and exit
  -a ALIGNMENT        Aligned sequence file (*.fasta). Note, each sequence
                      name requires containing lineage mark.
  -ua UNALIGNMENT     Unaligned (non-alignment) sequence file (*.fasta). Note,
                      each sequence name requires containing lineage mark.
  -at ALIGN_TOOL      Program used for multiple sequence alignments (MSA).
                      Supporting mafft, muscle and clustalo, such as ‘-at
                      mafft’.
  -iwic INPUT_WIC     Using the already obtained WIC values of reference
                      lineages directly by a *.csv input-file.
  -q QUERY            Name of query lineage (usually potential recombinant),
                      such as ‘-q xxxx’. Besides, ‘-q auto’ can scan all
                      lineages as potential recombinant in turn.
  -map MAPPING        The table of sequence-to-lineage mapping.
  -g GAP              Reserve sites containing gaps(-) in analyses? ‘-g y’
                      means to reserve, and ‘-g n’ means to delete.
  -m METHOD           Method for site scanning. ‘-m p’ uses polymorphic sites
                      only, ‘-m a’ uses all the sites.
  -w WINDOW           Number of nucleotides sites per sliding window. Note: if
                      the ‘-m p’ has been used, -w refers to the number of
                      polymorphic sites per windows.
  -s STEP             Step size of the sliding window. Note: if the ‘-m p’ has
                      been used, -s refers to the number of polymorphic sites
                      per jump.
  -mr MAX_REGION      The maximum allowed recombination region. Note: if the
                      ‘-m p’ method has been used, it refers the maximum
                      number of polymorphic sites contained in a recombinant
                      region.
  -cp PERCENTAGE      The cutoff threshold of proportion (cp, default: 0.9)
                      used for searching recombination regions when mWIC/EIC
                      >= cp, the maximum value of cp is 1.
  -cu CUMULATIVE      Simply using the max cumulative WIC of all sites to
                      identify the major parent. Off by default. If required,
                      specify ‘-cu y’.
  -b BREAKPOINT       Possible breakpoint scan of recombination. ‘-b y’ means
                      yes, ‘-b n’ means no. Note: this option only takes
                      effect when ‘-m p’ has been specified.
  -bw BREAKWIN        The window size (default: 200) used for breakpoint scan,
                      and step size is fixed at 1.
  -t THREAD           Number of threads (or cores) for calculations, default:
                      4.
  -y Y_START          Starting value (default: 0) of the Y-axis in plot
                      diagram.
  -le LEGEND          The location of the legend, the default is adaptive.
                      '-le r' indicates placed on the right.
  -owic ONLY_WIC      Only calculate site WIC value. Off by default. If
                      required, please specify ‘-owic y’.
  -e ENGRAVE          Write the file name to sequence names in batches. By
                      specifying a directory containing one or multiple
                      sequence files (*.fasta).
  -en EXPORT_NAME     Export all sequence name of a *.fasta file.
  -o OUTDIR           Output directory to store all results.
  --block BLOCK_SIZE  Specifies the maximum number of sites per sub-block,
                      different sub-blocks in sequence file will be
                      sequentially loaded to calculate WIC. Default: 40000
                      sites.
  --no_wic_fig        Do not draw the image of WICs.
  --no_mwic_fig       Do not draw the image of mWICs.

----------------☆ Example of use ☆-----------------

  (1) If the input sequence-data has been aligned:
      virusrecom -a alignment.fasta -q query_name -map sequence_lineage_mapping.txt -g n -m p -w 100 -s 20 -o outdir
      
  (2) If the input sequence-data was not aligned: 
      virusrecom -ua unalignment.fasta -at mafft -q query_name -map sequence_lineage_mapping.txt -g n -m p -w 100 -s 20 -t 2 -o outdir
      
  (3) If you have a *csv file with site’s WIC value:
      virusrecom -iwic *csv -g n (or -g y) -q query_name -w 100 -s 20 -o outdir
  
  Tip: the input-file and output-directory is recommended absolute path.
  
  Above is just a conceptual example, detailed usage in website: https://github.com/ZhijianZhou01/virusrecom
  
----------------------☆  End  ☆---------------------
```

