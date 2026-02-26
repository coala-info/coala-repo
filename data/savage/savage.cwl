cwlVersion: v1.2
class: CommandLineTool
baseCommand: savage.py
label: savage
doc: "SAVAGE - Strain Aware VirAl GEnome assembly. SAVAGE assembles individual (viral)
  haplotypes from NGS data. It expects as input single- and/or paired-end Illumina
  sequencing reads. Please note that the paired-end reads are expected to be in forward-forward
  format, as output by PEAR.\n\nTool homepage: https://github.com/HaploConduct/HaploConduct/tree/master/savage"
inputs:
  - id: average_read_len
    type:
      - 'null'
      - int
    doc: average length of the input reads; will be computed from the input if 
      not specified
    inputBinding:
      position: 101
      prefix: --average_read_len
  - id: contig_len_stage_c
    type:
      - 'null'
      - int
    doc: minimum contig length required for stage c input contigs
    inputBinding:
      position: 101
      prefix: --contig_len_stage_c
  - id: count_strains
    type:
      - 'null'
      - boolean
    doc: 'compute a lower bound on the number of strains in this sample; note: this
      requires a reference genome.'
    inputBinding:
      position: 101
      prefix: --count_strains
  - id: diploid
    type:
      - 'null'
      - boolean
    doc: use this option for diploid genome assembly
    inputBinding:
      position: 101
      prefix: --diploid
  - id: diploid_contig_len
    type:
      - 'null'
      - int
    doc: minimum contig length required for diploid step contigs
    inputBinding:
      position: 101
      prefix: --diploid_contig_len
  - id: diploid_overlap_len
    type:
      - 'null'
      - int
    doc: min_overlap_len used in diploid assembly step
    inputBinding:
      position: 101
      prefix: --diploid_overlap_len
  - id: ignore_subreads
    type:
      - 'null'
      - boolean
    doc: ignore subread info from previous stage
    inputBinding:
      position: 101
      prefix: --ignore_subreads
  - id: input_p1
    type:
      - 'null'
      - File
    doc: path to input fastq containing paired-end reads (/1)
    inputBinding:
      position: 101
      prefix: --p1
  - id: input_p2
    type:
      - 'null'
      - File
    doc: path to input fastq containing paired-end reads (/2)
    inputBinding:
      position: 101
      prefix: --p2
  - id: input_s
    type:
      - 'null'
      - File
    doc: path to input fastq containing single-end reads
    inputBinding:
      position: 101
      prefix: --s
  - id: keep_branches
    type:
      - 'null'
      - boolean
    doc: disable merging along branches by removing them from the graph (stage b
      & c)
    inputBinding:
      position: 101
      prefix: --keep_branches
  - id: max_tip_len
    type:
      - 'null'
      - int
    doc: maximum extension length for a sequence to be called a tip
    inputBinding:
      position: 101
      prefix: --max_tip_len
  - id: merge_contigs
    type:
      - 'null'
      - int
    doc: specify maximal distance between contigs for merging into master 
      strains (stage c)
    inputBinding:
      position: 101
      prefix: --merge_contigs
  - id: min_clique_size
    type:
      - 'null'
      - int
    doc: minimum clique size used during error correction
    inputBinding:
      position: 101
      prefix: --min_clique_size
  - id: min_overlap_len
    type:
      - 'null'
      - int
    doc: minimum overlap length required between reads
    inputBinding:
      position: 101
      prefix: --min_overlap_len
  - id: no_assembly
    type:
      - 'null'
      - boolean
    doc: skip all assembly steps; only use this option when using 
      --count_strains separate from assembly (e.g. on a denovo assembly)
    inputBinding:
      position: 101
      prefix: --no_assembly
  - id: no_filtering
    type:
      - 'null'
      - boolean
    doc: disable kallisto-based filtering of contigs
    inputBinding:
      position: 101
      prefix: --no_filtering
  - id: no_overlaps
    type:
      - 'null'
      - boolean
    doc: skip overlap computations (use existing overlaps file instead)
    inputBinding:
      position: 101
      prefix: --no_overlaps
  - id: no_preprocessing
    type:
      - 'null'
      - boolean
    doc: skip preprocessing procedure (i.e. creating data patches)
    inputBinding:
      position: 101
      prefix: --no_preprocessing
  - id: no_stage_a
    type:
      - 'null'
      - boolean
    doc: skip Stage a (initial contig formation)
    inputBinding:
      position: 101
      prefix: --no_stage_a
  - id: no_stage_b
    type:
      - 'null'
      - boolean
    doc: skip Stage b (extending initial contigs)
    inputBinding:
      position: 101
      prefix: --no_stage_b
  - id: no_stage_c
    type:
      - 'null'
      - boolean
    doc: skip Stage c (merging maximized contigs into master strains)
    inputBinding:
      position: 101
      prefix: --no_stage_c
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: specify output directory
    inputBinding:
      position: 101
      prefix: --outdir
  - id: overlap_len_stage_c
    type:
      - 'null'
      - int
    doc: min_overlap_len used in stage c
    inputBinding:
      position: 101
      prefix: --overlap_len_stage_c
  - id: reference
    type:
      - 'null'
      - File
    doc: reference genome in fasta format
    inputBinding:
      position: 101
      prefix: --ref
  - id: revcomp
    type:
      - 'null'
      - boolean
    doc: use this option when paired-end input reads are in forward-reverse 
      orientation; this option will take reverse complements of /2 reads 
      (specified with -p2) please see the SAVAGE manual for more information 
      about input read orientations
    inputBinding:
      position: 101
      prefix: --revcomp
  - id: sfo_mm
    type:
      - 'null'
      - float
    doc: 'input parameter -e=SFO_MM for sfo: maximal mismatch rate 1/SFO_MM'
    inputBinding:
      position: 101
      prefix: --sfo_mm
  - id: split
    type: int
    doc: split the data set into patches s.t. 500 < coverage/split_num < 1000
    inputBinding:
      position: 101
      prefix: --split
  - id: threads
    type:
      - 'null'
      - int
    doc: allowed number of cores
    inputBinding:
      position: 101
      prefix: --num_threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/savage:0.4.2--py27h3e4de3e_0
stdout: savage.out
