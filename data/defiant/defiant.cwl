cwlVersion: v1.2
class: CommandLineTool
baseCommand: ./defiant
label: defiant
doc: "Differential methylation: Easy, Fast, Identification and ANnoTation\n\nTool
  homepage: https://github.com/hhg7/defiant"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: Start reading input files. This is the only required argument. All 
      further entries to the command line are assumed to be files.
    inputBinding:
      position: 1
  - id: annotation_file
    type:
      - 'null'
      - File
    doc: Specify annotation file, e.g. "-a mm10.gtf"
    inputBinding:
      position: 102
      prefix: -a
  - id: cpu
    type:
      - 'null'
      - int
    doc: Set number of CPU when running multiple options, e.g. "-cpu 4". "CPU" 
      is case insensitive and accepts integers > 0.
    inputBinding:
      position: 102
      prefix: -cpu
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Turn on debugging mode. This slows down the execution significantly, 
      but can help diagnose problems if they arise. This option does not accept 
      any arguments.
    inputBinding:
      position: 102
      prefix: --debug
  - id: fdr_method
    type:
      - 'null'
      - string
    doc: Calculate FDR-adjusted q-value for each CpN. 'FDR' is case insensitive.
      This option can take case-insensitive arguments 'fdr' or 'bh' for 
      Benjamini-Hothberg method, 'Bonferroni', 'Hochberg', 'Hommel', 'Holm', or 
      'BY' for Benjamini & Yekutieli. If no argument is given, 'Holm' is 
      assumed. This function is a translation of R's 'p.adjust'. I recommend 
      against using this option as for genome-scale CpG measurements, almost 
      everything will be q = 1 and no DMRs will be obtained in any case. This 
      option will substantially increase RAM use and slow execution. 'Hommel' is
      so slow I strongly recommend against it.
    inputBinding:
      position: 102
      prefix: -fdr
  - id: heatmap
    type:
      - 'null'
      - boolean
    doc: Make heatmap. Requires R be available from command line, and that 
      `library(gplots)` will work.
    inputBinding:
      position: 102
      prefix: --heatmap
  - id: include_random_chromosomes
    type:
      - 'null'
      - boolean
    doc: include "Random" chromosomes. This option does not accept an argument.
    inputBinding:
      position: 102
      prefix: -R
  - id: include_un_chromosomes
    type:
      - 'null'
      - boolean
    doc: Include "Un" chromosomes (default is to ignore them). This option does 
      not accept an argument.
    inputBinding:
      position: 102
      prefix: -U
  - id: list_cpn_in_dmr
    type:
      - 'null'
      - boolean
    doc: list CpG Nucleotides in the DMR in output file. This option does not 
      take an argument.
    inputBinding:
      position: 102
      prefix: -N
  - id: make_eps_figures
    type:
      - 'null'
      - boolean
    doc: "make EPS figures for each DMR. Warning: requires R installation. This option
      does not take an argument, and will slow defiant's execution."
    inputBinding:
      position: 102
      prefix: -f
  - id: max_consecutive_similar_cpn
    type:
      - 'null'
      - int
    doc: Maximum allowed consecutive similar CpN, default is 5 CpN. This accepts
      non-negative integers, e.g. "-s 3".
    inputBinding:
      position: 102
      prefix: -s
  - id: max_consecutive_skips
    type:
      - 'null'
      - int
    doc: Allow some number of consecutive skips of low coverage, default is 0. 
      This accepts positive integers, e.g. "-S 1".
    inputBinding:
      position: 102
      prefix: -S
  - id: max_gap_cpn
    type:
      - 'null'
      - int
    doc: Maximum allowed gap between CpN, e.g. "-G 1000"
    inputBinding:
      position: 102
      prefix: -G
  - id: max_p_value
    type:
      - 'null'
      - float
    doc: Maximum p-value, which is 0<=p<=1. This option can be parallelized to 
      test multiple options.
    inputBinding:
      position: 102
      prefix: -p
  - id: max_parallel_options
    type:
      - 'null'
      - int
    doc: Maximum non-default options in a parallel run, e.g. "-D 4"
    inputBinding:
      position: 102
      prefix: -D
  - id: min_coverage
    type:
      - 'null'
      - int
    doc: minimum coverage, e.g. "-c 10". This option accepts positive integers 
      and can be parallelized to test multiple options.
    inputBinding:
      position: 102
      prefix: -c
  - id: min_cpn
    type:
      - 'null'
      - int
    doc: minimum CpN/CpG/CH/CHH in a DMR, e.g. "-CpN 10". This option accepts 
      positive integers and can parallelized. "CpN" is case insensitive.
    inputBinding:
      position: 102
      prefix: -CpN
  - id: min_diff_nucleotide_count
    type:
      - 'null'
      - int
    doc: Minimum differential nucleotide count in a DMR, e.g. "-d 3". This 
      option can be parallelized.
    inputBinding:
      position: 102
      prefix: -d
  - id: min_nucleotide_range
    type:
      - 'null'
      - int
    doc: Minimum nucleotide range, which accepts a non-negative integer. Default
      range is 1 nucleotide.
    inputBinding:
      position: 102
      prefix: -r
  - id: min_percent_methylation_diff
    type:
      - 'null'
      - float
    doc: Minimum Percent methylation difference (0 <= P <= 100). This option can
      be parallelized to test multiple options (default 10%).
    inputBinding:
      position: 102
      prefix: -P
  - id: output_bed
    type:
      - 'null'
      - boolean
    doc: Output DMRs in bed file.
    inputBinding:
      position: 102
      prefix: -b
  - id: output_label
    type:
      - 'null'
      - string
    doc: Set output file(s) label, e.g. "-l new"
    inputBinding:
      position: 102
      prefix: -l
  - id: print_pvalue_fdr
    type:
      - 'null'
      - string
    doc: Print a p-value & FDR-adjusted p-value for each DMR. This option 
      accepts the same arguments that the '-FDR' option does.
    inputBinding:
      position: 102
      prefix: -v
  - id: print_stats_per_cpn
    type:
      - 'null'
      - boolean
    doc: print statistics for every CpN. This option does not take an argument. 
      This slows Defiant down significantly.
    inputBinding:
      position: 102
      prefix: -E
  - id: promoter_cutoff
    type:
      - 'null'
      - int
    doc: Promoter cutoff for gene assignment of intergenic DMRs (default 10,000 
      nucleotides). This option accepts positive integers, e.g. "-q 15000".
    inputBinding:
      position: 102
      prefix: -q
  - id: set_labels
    type:
      - 'null'
      - string
    doc: give labels for each set in a comma-delimited string, e.g. "-L 
      case,control"
    inputBinding:
      position: 102
      prefix: -L
  - id: x_axis_label
    type:
      - 'null'
      - string
    doc: This option accepts a string which will become the x-axis in figures. 
      "-x" activates "-f" option and requires an R installation.
    inputBinding:
      position: 102
      prefix: -x
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/defiant:1.1.4--h7b50bb2_6
stdout: defiant.out
