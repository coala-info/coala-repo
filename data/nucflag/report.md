# nucflag CWL Generation Report

## nucflag

### Tool Description
Use per-base read coverage to classify/plot misassemblies.

### Metadata
- **Docker Image**: quay.io/biocontainers/nucflag:0.3.8--pyhdfd78af_0
- **Homepage**: https://github.com/logsdon-lab/NucFlag
- **Package**: https://anaconda.org/channels/bioconda/packages/nucflag/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/nucflag/overview
- **Total Downloads**: 423
- **Last updated**: 2025-12-13
- **GitHub**: https://github.com/logsdon-lab/NucFlag
- **Stars**: N/A
### Original Help Text
```text
usage: nucflag [-h] -i INFILE [-b INPUT_REGIONS] [-d OUTPUT_PLOT_DIR]
               [--output_cov_dir OUTPUT_COV_DIR] [-o OUTPUT_MISASM]
               [-s OUTPUT_STATUS] [-t THREADS] [-p PROCESSES] [-c CONFIG]
               [--ignore_regions IGNORE_REGIONS]
               [--overlay_regions [OVERLAY_REGIONS ...]]
               [--ignore_mtypes [{COLLAPSE_OTHER,COLLAPSE_VAR,COLLAPSE,MISJOIN,FALSE_DUP,HET} ...]]
               [--chrom_sizes CHROM_SIZES] [--ylim YLIM] [-v]

Use per-base read coverage to classify/plot misassemblies.

options:
  -h, --help            show this help message and exit
  -i INFILE, --infile INFILE
                        Input bam file or per-base coverage tsv file with
                        3-columns (position, first, second). If a bam file is
                        provided, it must be indexed. (default: None)
  -b INPUT_REGIONS, --input_regions INPUT_REGIONS
                        Bed file with regions to check. (default: None)
  -d OUTPUT_PLOT_DIR, --output_plot_dir OUTPUT_PLOT_DIR
                        Output plot dir. (default: None)
  --output_cov_dir OUTPUT_COV_DIR
                        Output coverage dir. Generates wig or bigwig files per
                        region. (default: None)
  -o OUTPUT_MISASM, --output_misasm OUTPUT_MISASM
                        Output bed file with misassembled regions. (default:
                        <_io.TextIOWrapper name='<stdout>' mode='w'
                        encoding='utf-8'>)
  -s OUTPUT_STATUS, --output_status OUTPUT_STATUS
                        Bed file with status of contigs. With format:
                        contig,start,end,misassembled|good (default: None)
  -t THREADS, --threads THREADS
                        Threads for reading bam file. (default: 4)
  -p PROCESSES, --processes PROCESSES
                        Processes for classifying/plotting. (default: 4)
  -c CONFIG, --config CONFIG
                        Additional threshold/params as toml file. (default:
                        {'first': {'thr_min_peak_width': 20,
                        'thr_min_valley_width': 20, 'thr_misjoin_valley':
                        0.95, 'thr_collapse_peak': 2.25,
                        'valley_group_distance': 5000, 'peak_group_distance':
                        5000}, 'second': {'thr_min_perc_first': 0.05,
                        'group_distance': 10000, 'thr_min_group_size': 5,
                        'thr_het_ratio': 0.2}, 'general': {'window_size':
                        5000000}})
  --ignore_regions IGNORE_REGIONS
                        Bed file with regions to ignore. With format:
                        contig|all,start,end,label,ignore:absolute|relative
                        (default: None)
  --overlay_regions [OVERLAY_REGIONS ...]
                        Overlay additional regions as 4-column bedfile
                        alongside coverage plot. (default: None)
  --ignore_mtypes [{COLLAPSE_OTHER,COLLAPSE_VAR,COLLAPSE,MISJOIN,FALSE_DUP,HET} ...]
                        Ignore misassembly types from plot and output bedfile.
                        (default: None)
  --chrom_sizes CHROM_SIZES
                        Chromosome sizes TSV file for bigWig files. Expects at
                        minimum chrom and its length. If not provided, wig
                        files are produced with --output_cov_dir. (default:
                        None)
  --ylim YLIM           Plot y-axis limit. If float, used as a scaling factor
                        from mean. (ex. 3.0 is mean times 3) (default: 100)
  -v, --version         show program's version number and exit
```

