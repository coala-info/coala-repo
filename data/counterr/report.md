# counterr CWL Generation Report

## counterr

### Tool Description
Counterr is a tool for analyzing BAM files.

### Metadata
- **Docker Image**: quay.io/biocontainers/counterr:0.1--py_0
- **Homepage**: https://github.com/dayzerodx/counterr
- **Package**: https://anaconda.org/channels/bioconda/packages/counterr/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/counterr/overview
- **Total Downloads**: 2.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/dayzerodx/counterr
- **Stars**: N/A
### Original Help Text
```text
usage: counterr [-h] -bam BAM -genome GENOME -output_dir OUTPUT_DIR
                [-no_figures] [-bai BAI] [-verbose]
                [-len_min_contig LEN_MIN_CONTIG] [-mapq_thres MAPQ_THRES]
                [-len_min_read LEN_MIN_READ] [-len_min_aln LEN_MIN_ALN]
                [-bitflag BITFLAG] [-len_min_hp LEN_MIN_HP]
                [-len_max_hp LEN_MAX_HP] [-len_context_sub LEN_CONTEXT_SUB]
                [-len_context_ins LEN_CONTEXT_INS]
                [-len_max_indel LEN_MAX_INDEL]
                [-len_trim_contig_edge LEN_TRIM_CONTIG_EDGE] [-use_recorded]
                [-lim LIM] [-num_pts_max NUM_PTS_MAX]
                [-report_name REPORT_NAME]

optional arguments:
  -h, --help            show this help message and exit
  -bam BAM              the input bam file (default: None)
  -genome GENOME        the input fasta file (default: None)
  -output_dir OUTPUT_DIR
                        the output directory for figures and stats (default:
                        None)
  -no_figures           pass this flag to not generate figures (default:
                        False)
  -bai BAI              the input bai filename if non-conventionally named
                        (default: )
  -verbose              pass this flag to follow progress in the terminal
                        (default: False)
  -len_min_contig LEN_MIN_CONTIG
                        minimum contig length (default: 1500)
  -mapq_thres MAPQ_THRES
                        minimum mapq threshold (default: 40)
  -len_min_read LEN_MIN_READ
                        minimum read length (default: 1500)
  -len_min_aln LEN_MIN_ALN
                        minimum length aligned (default: 1000)
  -bitflag BITFLAG      bit flag for read filter (as specified in SAM doc)
                        (default: 3845)
  -len_min_hp LEN_MIN_HP
                        minimum homopolymer length (default: 3)
  -len_max_hp LEN_MAX_HP
                        maximum homopolymer length (default: 20)
  -len_context_sub LEN_CONTEXT_SUB
                        length of the k-mer context for context dependent
                        substitution table (default: 5)
  -len_context_ins LEN_CONTEXT_INS
                        length of the k-mer context for context dependent
                        insertion table (default: 6)
  -len_max_indel LEN_MAX_INDEL
                        maximum length of indels to consider (default: 20)
  -len_trim_contig_edge LEN_TRIM_CONTIG_EDGE
                        length of the contig edge to trim before computing
                        various statistics (default: 1)
  -use_recorded         pass this flag to NOT perform reverse complementing of
                        the reverse complement mapped reads (default: False)
  -lim LIM              pass this flag to run the program with 'lim' randomly
                        selected reads (both pass and fail) (default: -1)
  -num_pts_max NUM_PTS_MAX
                        maximum number of points to be plotted for any scatter
                        plots (default: 100000)
  -report_name REPORT_NAME
                        the name of the output PDF report if the user wishes
                        to use a non-default name. (default: report.pdf)
```

