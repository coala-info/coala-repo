cwlVersion: v1.2
class: CommandLineTool
baseCommand: xyalign
label: xyalign_analyze_bam
doc: "Limit XYalign to only analyzing the bam file for depth, mapq, and (optionally)\
  \ read balance and outputting plots.\n\nTool homepage: https://github.com/WilsonSayresLab/XYalign"
inputs:
  - id: bam
    type:
      type: array
      items: File
    doc: Full path to input bam files (indexed). If more than one provided, only the
      first will be used for modules other than CHROM_STATS
    inputBinding:
      position: 101
      prefix: --bam
    secondaryFiles:
      - pattern: .bai
        required: false
      - pattern: ^.bai
        required: false
  - id: bedtools_path
    type:
      - 'null'
      - string
    doc: Path to bedtools. Default is 'bedtools'
    inputBinding:
      position: 101
      prefix: --bedtools_path
  - id: chromosomes
    type:
      type: array
      items: string
    doc: Chromosomes to analyze (names must match reference exactly). For humans,
      we recommend at least chr19, chrX, chrY. Generally, we suggest including the
      sex chromosomes and at least one autosome. To analyze all chromosomes use '--chromosomes
      ALL' or '--chromosomes all'.
    inputBinding:
      position: 101
      prefix: --chromosomes
  - id: coordinate_scale
    type:
      - 'null'
      - float
    doc: For genome-wide scatter plots, divide all coordinates by this value.Default
      is 1000000, which will plot everything in megabases.
    inputBinding:
      position: 101
      prefix: --coordinate_scale
  - id: cpus
    type:
      - 'null'
      - int
    doc: Number of cores/threads to use. Default is 1
    inputBinding:
      position: 101
      prefix: --cpus
  - id: exact_depth
    type:
      - 'null'
      - boolean
    doc: Calculate exact depth within windows, else use much faster approximation.
      *Currently exact is not implemented*. Default is False.
    inputBinding:
      position: 101
      prefix: --exact_depth
  - id: homogenize_read_balance
    type:
      - 'null'
      - string
    doc: If True, read balance values will be transformed by subtracting each value
      from 1. For example, 0.25 and 0.75 would be treated equivalently. Default is
      False. The program reads any non-empty value as True.
    inputBinding:
      position: 101
      prefix: --homogenize_read_balance
  - id: ignore_duplicates
    type:
      - 'null'
      - boolean
    doc: Ignore duplicate reads in bam analyses. Default is to include duplicates.
    inputBinding:
      position: 101
      prefix: --ignore_duplicates
  - id: include_fixed
    type:
      - 'null'
      - string
    doc: Default is False, which removes read balances less than or equal to 0.05
      and equal to 1.0 for histogram plotting. True will include all values. Extreme
      values removed by default because they often swamp out the signal of the rest
      of the distribution. The program reads any non-empty value as True.
    inputBinding:
      position: 101
      prefix: --include_fixed
  - id: logfile
    type:
      - 'null'
      - string
    doc: Name of logfile. Will overwrite if exists. Default is sample_xyalign.log
    inputBinding:
      position: 101
      prefix: --logfile
  - id: mapq_cutoff
    type:
      - 'null'
      - int
    doc: Minimum mean mapq threshold for a window to be considered high quality. Default
      is 20.
    inputBinding:
      position: 101
      prefix: --mapq_cutoff
  - id: marker_size
    type:
      - 'null'
      - int
    doc: Marker size for genome-wide plots in matplotlib. Default is 10.
    inputBinding:
      position: 101
      prefix: --marker_size
  - id: marker_transparency
    type:
      - 'null'
      - float
    doc: Transparency of markers in genome-wide plots. Alpha in matplotlib. Default
      is 0.5
    inputBinding:
      position: 101
      prefix: --marker_transparency
  - id: max_depth_filter
    type:
      - 'null'
      - float
    doc: Maximum depth threshold for a window to be considered high quality. Calculated
      as mean depth * max_depth_filter. So, a max_depth_filter of 4 would require
      depths to be less than or equal to 40 if the mean depth was 10. Default is 10000.0
      to consider all windows.
    inputBinding:
      position: 101
      prefix: --max_depth_filter
  - id: min_depth_filter
    type:
      - 'null'
      - float
    doc: Minimum depth threshold for a window to be considered high quality. Calculated
      as mean depth * min_depth_filter. So, a min_depth_filter of 0.2 would require
      at least a minimum depth of 2 if the mean depth was 10. Default is 0.0 to consider
      all windows.
    inputBinding:
      position: 101
      prefix: --min_depth_filter
  - id: min_variant_count
    type:
      - 'null'
      - int
    doc: Minimum number of variants in a window for the read balance of that window
      to be plotted. Note that this does not affect plotting of variant counts. Default
      is 1, though we note that many window averages will be meaningless at this setting.
    inputBinding:
      position: 101
      prefix: --min_variant_count
  - id: no_bam_analysis
    type:
      - 'null'
      - boolean
    doc: Include flag to prevent depth/mapq analysis of bam file. Used to isolate
      platypus_calling.
    inputBinding:
      position: 101
      prefix: --no_bam_analysis
  - id: no_cleanup
    type:
      - 'null'
      - boolean
    doc: Include flag to preserve temporary files.
    inputBinding:
      position: 101
      prefix: --no_cleanup
  - id: no_variant_plots
    type:
      - 'null'
      - boolean
    doc: Include flag to prevent plotting read balance from VCF files.
    inputBinding:
      position: 101
      prefix: --no_variant_plots
  - id: platypus_calling
    type:
      - 'null'
      - string
    doc: 'Platypus calling withing the pipeline (before processing, after processing,
      both, or neither). Options: both, none, before, after.'
    inputBinding:
      position: 101
      prefix: --platypus_calling
  - id: platypus_logfile
    type:
      - 'null'
      - string
    doc: Prefix to use for Platypus log files. Will default to the sample_id argument
      provided
    inputBinding:
      position: 101
      prefix: --platypus_logfile
  - id: platypus_path
    type:
      - 'null'
      - string
    doc: Path to platypus. Default is 'platypus'. If platypus is not directly callable
      (e.g., '/path/to/platypus' or '/path/to/Playpus.py'), then provide path to python
      as well (e.g., '/path/to/python /path/to/platypus'). In addition, be sure provided
      python is version 2. See the documentation for more information about setting
      up an anaconda environment.
    inputBinding:
      position: 101
      prefix: --platypus_path
  - id: ref
    type: File
    doc: Path to reference sequence (including file name). Must have a .fai index
      beside it.
    inputBinding:
      position: 101
      prefix: --ref
    secondaryFiles:
      - pattern: .fai
        required: false
  - id: reporting_level
    type:
      - 'null'
      - string
    doc: Set level of messages printed to console. Default is 'INFO'. Choose from
      (in decreasing amount of reporting) DEBUG, INFO, ERROR or CRITICAL
    inputBinding:
      position: 101
      prefix: --reporting_level
  - id: sambamba_path
    type:
      - 'null'
      - string
    doc: Path to sambamba. Default is 'sambamba'
    inputBinding:
      position: 101
      prefix: --sambamba_path
  - id: sample_id
    type:
      - 'null'
      - string
    doc: Name/ID of sample - for use in plot titles and file naming. Default is sample
    inputBinding:
      position: 101
      prefix: --sample_id
  - id: samtools_path
    type:
      - 'null'
      - string
    doc: Path to samtools. Default is 'samtools'
    inputBinding:
      position: 101
      prefix: --samtools_path
  - id: skip_compatibility_check
    type:
      - 'null'
      - boolean
    doc: Include flag to prevent check of compatibility between input bam and reference
      fasta
    inputBinding:
      position: 101
      prefix: --skip_compatibility_check
  - id: target_bed
    type:
      - 'null'
      - File
    doc: Bed file containing targets to use in sliding window analyses instead of
      a fixed window width. Either this or --window_size needs to be set. Default
      is None, which will use window size provided with --window_size. If not None,
      and --window_size is None, analyses will use targets in provided file. Must
      be typical bed format, 0-based indexing, with the first three columns containing
      the chromosome name, start coordinate, stop coordinate.
    inputBinding:
      position: 101
      prefix: --target_bed
  - id: variant_depth
    type:
      - 'null'
      - int
    doc: Consider all SNPs with a sample depth greater than or equal to this value.
      Default is 4.
    inputBinding:
      position: 101
      prefix: --variant_depth
  - id: variant_genotype_quality
    type:
      - 'null'
      - int
    doc: Consider all SNPs with a sample genotype quality greater than or equal to
      this value. Default is 30.
    inputBinding:
      position: 101
      prefix: --variant_genotype_quality
  - id: variant_site_quality
    type:
      - 'null'
      - int
    doc: Consider all SNPs with a site quality (QUAL) greater than or equal to this
      value. Default is 30.
    inputBinding:
      position: 101
      prefix: --variant_site_quality
  - id: whole_genome_threshold
    type:
      - 'null'
      - boolean
    doc: This flag will calculate the depth filter threshold based on all values from
      across the genome. By default, thresholds are calculated per chromosome.
    inputBinding:
      position: 101
      prefix: --whole_genome_threshold
  - id: window_size
    type:
      - 'null'
      - int
    doc: Window size (integer) for sliding window calculations. Default is 50000.
      Default is None. If set to None, will use targets provided using --target_bed.
    inputBinding:
      position: 101
      prefix: --window_size
  - id: x_chromosome
    type:
      - 'null'
      - type: array
        items: string
    doc: Names of x-linked scaffolds in reference fasta (must match reference exactly).
    inputBinding:
      position: 101
      prefix: --x_chromosome
  - id: y_chromosome
    type:
      - 'null'
      - type: array
        items: string
    doc: Names of y-linked scaffolds in reference fasta (must match reference exactly).
      Defaults to chrY. Give None if using an assembly without a Y chromosome
    inputBinding:
      position: 101
      prefix: --y_chromosome
  - id: output_dir
    type: string
    default: xyalign_output
    doc: Output directory. XYalign will create a directory structure within this directory
    inputBinding:
      position: 101
      prefix: --output_dir
outputs:
  - id: output_dir_dir
    type:
      - 'null'
      - Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output_dir)
  - id: stdout
    type: stdout
    doc: Standard output
arguments:
  - position: 1
    valueFrom: --ANALYZE_BAM
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/xyalign:1.1.5--py_1
stdout: xyalign_analyze_bam.out
