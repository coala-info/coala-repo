cwlVersion: v1.2
class: CommandLineTool
baseCommand: FeGenie.py
label: fegenie_FeGenie.py
doc: "FeGenie: a pipeline for identifying iron-related genes in genomic and metagenomic
  data.\n\nTool homepage: https://github.com/Arkadiy-Garber/FeGenie"
inputs:
  - id: bam_file
    type:
      - 'null'
      - File
    doc: BAM file. This option is only required if you would like to create a 
      heatmap that summarizes the abundance of a certain gene that is based on 
      read coverage, rather than gene counts. If you have more than one BAM 
      filecorresponding to different genomes that you are providing, please use 
      the '-bams' argument to provide a tab-delimited file that denotes which 
      BAM file (or files) belongs with which genome
    inputBinding:
      position: 101
      prefix: -bam
  - id: bams_file
    type:
      - 'null'
      - File
    doc: "a tab-delimited file with two columns: first column has the genome or metagenome
      file names; second column has the corresponding BAM file (provide full path
      to the BAM file). Use this option if you have genomes that each have different
      BAM files associated with them. If you have a set of bins from a single metagenome
      sample and, thus, have only one BAM file, then use the '-bam' option. BAM files
      are only required if you would like to create a heatmap that summarizes the
      abundance of a certain gene that is based on read coverage, rather than gene
      counts."
    inputBinding:
      position: 101
      prefix: -bams
  - id: bin_dir
    type:
      - 'null'
      - Directory
    doc: directory of bins
    inputBinding:
      position: 101
      prefix: -bin_dir
  - id: bin_ext
    type:
      - 'null'
      - string
    doc: extension for bins (do not include the period)
    inputBinding:
      position: 101
      prefix: -bin_ext
  - id: categories
    type:
      - 'null'
      - string
    doc: comma-separated list of iron gene categories you'd like FeGenie to look
      for (default = all categories)
    inputBinding:
      position: 101
      prefix: -cat
  - id: contig_names_file
    type:
      - 'null'
      - File
    doc: contig names in your provided FASTA files. Use this optionif you are 
      providing gene calls in amino acid format (don't forgetto add the '--orfs'
      flag)
    inputBinding:
      position: 101
      prefix: -contig_names
  - id: find_hematite_motifs
    type:
      - 'null'
      - boolean
    doc: find all genes with hematite-binding motifs, and output them to a 
      separate summary file
    inputBinding:
      position: 101
      prefix: --hematite
  - id: find_heme_motifs
    type:
      - 'null'
      - boolean
    doc: find all genes with heme-binding motifs (CXXCH), and output them to a 
      separate summary file
    inputBinding:
      position: 101
      prefix: --heme
  - id: genbank_format
    type:
      - 'null'
      - boolean
    doc: include this flag if your bins are in Genbank format
    inputBinding:
      position: 101
      prefix: --gbk
  - id: inflation_factor
    type:
      - 'null'
      - int
    doc: inflation factor for final gene category counts
    default: 1000
    inputBinding:
      position: 101
      prefix: -inflation
  - id: make_plots
    type:
      - 'null'
      - boolean
    doc: 'include this flag if you would like FeGenie to make some figures from your
      data?. To take advantage of this part of the pipeline, you will need to have
      Rscipt installed. It is a way for R to be called directly from the command line.
      Please be sure to install all the required R packages as instrcuted in the FeGenie
      Wiki: https://github.com/Arkadiy-Garber/FeGenie/wiki/Installation. If you see
      error or warning messages associated with Rscript, you can still expect to see
      the main output (CSV files) from FeGenie.'
    inputBinding:
      position: 101
      prefix: --makeplots
  - id: max_distance
    type:
      - 'null'
      - int
    doc: maximum distance between genes to be considered in a genomic 
      'cluster'.This number should be an integer and should reflect the maximum 
      number of genes in between putative iron-related genes identified by the 
      HMM database
    default: 5
    inputBinding:
      position: 101
      prefix: -d
  - id: metagenomic
    type:
      - 'null'
      - boolean
    doc: include this flag if the provided contigs are from 
      metagenomic/metatranscriptomic assemblies
    inputBinding:
      position: 101
      prefix: --meta
  - id: nohup_mode
    type:
      - 'null'
      - boolean
    doc: include this flag if you are running FeGenie under 'nohup', and would 
      like to re-write a currently existing directory.
    inputBinding:
      position: 101
      prefix: --nohup
  - id: normalize_gene_counts
    type:
      - 'null'
      - boolean
    doc: include this flag if you would like the gene counts for each iron gene 
      category to be normalized to the number of predicted ORFs in each genome 
      or metagenome. Without normalization, FeGenie will create a 
      heatmap-compatible CSV output with raw gene counts. With normalization, 
      FeGenie will create a heatmap-compatible with 'normalized gene abundances'
    inputBinding:
      position: 101
      prefix: --norm
  - id: orfs
    type:
      - 'null'
      - boolean
    doc: include this flag if you are providing bins as open-reading frames or 
      genes in FASTA amino-acid format
    inputBinding:
      position: 101
      prefix: --orfs
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: name output directory
    default: fegenie_out
    inputBinding:
      position: 101
      prefix: -out
  - id: reference_db
    type:
      - 'null'
      - File
    doc: path to a reference protein database, which must be in FASTA format
    inputBinding:
      position: 101
      prefix: -ref
  - id: report_all_results
    type:
      - 'null'
      - boolean
    doc: report all results, regardless of clustering patterns and operon 
      structure
    inputBinding:
      position: 101
      prefix: --all_results
  - id: skip_main_algorithm
    type:
      - 'null'
      - boolean
    doc: skip the main part of the algorithm (ORF prediction and HMM searching) 
      and re-summarize previously produced results (for example, if you want to 
      re-run using the --norm flag, or providing a BAM file). All other 
      flags/arguments need to be provided (e.g. -bin_dir, -bin_ext, -out, etc.)
    inputBinding:
      position: 101
      prefix: --skip
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads to use for DIAMOND BLAST and HMMSEARCH
    default: 1
    inputBinding:
      position: 101
      prefix: -t
  - id: which_bam
    type:
      - 'null'
      - int
    doc: if you provided a tab-delimited file specifying multiple BAM files for 
      your metagenome assemblies or bins/genomes, FeGenie will, by default, make
      the heatmap CSV and dotplot based on the average depth across all of BAM 
      files. However, with this argument, you can specify which bam in that file
      that you want FeGenie to use for the generation of a heatmap/dotplot. For 
      example, if only coverage from the first BAM file is desired, then you can
      specify '-which_bams 1'. For the third BAM file in the provided 
      tab-delimited file, '-which_bams 3\ should be specified'
    inputBinding:
      position: 101
      prefix: -which_bams
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fegenie:1.2--py313r40hdfd78af_5
stdout: fegenie_FeGenie.py.out
