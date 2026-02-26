cwlVersion: v1.2
class: CommandLineTool
baseCommand: hafez_hafeZ.py
label: hafez_hafeZ.py
doc: "Identify inducible prophages through bacterial genomic read mapping. Minimum
  required input outlined above.\n\nTool homepage: https://github.com/Chrisjrt/hafeZ"
inputs:
  - id: all_zscores
    type:
      - 'null'
      - boolean
    doc: make graphs of all contig Z-scores even if no roi found (useful for 
      manual inspection). N.B. This will make graphs for each contig, so if you 
      have 100 contigs you will get 100 graphs.
    inputBinding:
      position: 101
      prefix: --all_Zscores
  - id: assembly_fasta
    type: File
    doc: path to genome assembly in fasta format
    inputBinding:
      position: 101
      prefix: --fasta
  - id: bin_size
    type:
      - 'null'
      - int
    doc: set bin size in bp to use for coverage depth smoothing. Must be an odd 
      number.
    default: 3001
    inputBinding:
      position: 101
      prefix: --bin_size
  - id: coverage
    type:
      - 'null'
      - float
    doc: set desired coverage of genome to be used for subsampling reads 
      (default = 100.0). N.B. Must be used with -S\--sub_sample flag
    default: 100.0
    inputBinding:
      position: 101
      prefix: --coverage
  - id: cutoff
    type:
      - 'null'
      - float
    doc: set Z-score cutoff for initially detecting rois
    default: 3.5
    inputBinding:
      position: 101
      prefix: --cutoff
  - id: db_path
    type: Directory
    doc: path to the directory containing the pVOGs files
    inputBinding:
      position: 101
      prefix: --db_path
  - id: db_type
    type: string
    doc: choose which database you want to download, currently available ones 
      are pVOGs or PHROGs
    inputBinding:
      position: 101
      prefix: --db_type
  - id: expect_mad_zero
    type:
      - 'null'
      - boolean
    doc: allow MAD == 0 to exit without non-zero exit code. Will also cause 
      coverage plots for each contig to be output to help with debugging. Useful
      for uninduced lysates.
    inputBinding:
      position: 101
      prefix: --expect_mad_zero
  - id: get_db
    type: Directory
    doc: use this option to get and format pVOGs database in the given directory
    inputBinding:
      position: 101
      prefix: --get_db
  - id: keep_threshold
    type:
      - 'null'
      - int
    doc: set threshold for number of best soft clip combinations to keep for 
      each roi
    default: 50
    inputBinding:
      position: 101
      prefix: --keep_threshold
  - id: median_z_cutoff
    type:
      - 'null'
      - float
    doc: set minimum median Z-score for an roi to be retained
    default: 3.5
    inputBinding:
      position: 101
      prefix: --median_z_cutoff
  - id: memory_limit
    type:
      - 'null'
      - string
    doc: set upper bound per thread memory limit for samtools, suffix K/M/G 
      recognized
    default: 768M
    inputBinding:
      position: 101
      prefix: --memory_limit
  - id: min_orfs
    type:
      - 'null'
      - int
    doc: set minimum number of ORFs needed in an roi
    default: 6
    inputBinding:
      position: 101
      prefix: --min_orfs
  - id: no_extra
    type:
      - 'null'
      - boolean
    doc: use to turn off extra accuracy checks using clipped sequences, might 
      give same results, might give extra rois
    inputBinding:
      position: 101
      prefix: --no_extra
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: force overwrite of ouput folder if already exists
    inputBinding:
      position: 101
      prefix: --overwrite
  - id: pvog_fract
    type:
      - 'null'
      - float
    doc: set minimum fraction of ORFs in an roi showing homology to pVOGs
    default: 0.1
    inputBinding:
      position: 101
      prefix: --pvog_fract
  - id: reads1
    type: File
    doc: path to read set in fastq/fastq.gz format.
    inputBinding:
      position: 101
      prefix: --reads1
  - id: reads2
    type: File
    doc: path to second read set in fastq/fastq.gz format
    inputBinding:
      position: 101
      prefix: --reads2
  - id: sub_sample
    type:
      - 'null'
      - boolean
    doc: Randomly sub-sample reads to adjust overall mapping coverage of genome.
      N.B. Use -C/--coverage to adjust coverage desired
    inputBinding:
      position: 101
      prefix: --sub_sample
  - id: threads
    type:
      - 'null'
      - int
    doc: set number of threads to use
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
  - id: width
    type:
      - 'null'
      - int
    doc: set minimum width (bp) of roi that passes Z-score cutoff for initially 
      detecting rois.
    default: 4000
    inputBinding:
      position: 101
      prefix: --width
outputs:
  - id: output_folder
    type: Directory
    doc: desired output folder path
    outputBinding:
      glob: $(inputs.output_folder)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hafez:1.0.4--pyh7cba7a3_0
