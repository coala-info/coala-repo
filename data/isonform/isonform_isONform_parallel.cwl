cwlVersion: v1.2
class: CommandLineTool
baseCommand: isonform_parallel
label: isonform_isONform_parallel
doc: "De novo reconstruction of long-read transcriptome reads\n\nTool homepage: https://github.com/aljpetri/isONform"
inputs:
  - id: clustered
    type:
      - 'null'
      - boolean
    doc: Indicates whether we use the output of isONclust (i.e. we have 
      uncorrected data)
    default: false
    inputBinding:
      position: 101
      prefix: --clustered
  - id: delta
    type:
      - 'null'
      - float
    doc: diversity rate used to compare sequences
    default: 0.1
    inputBinding:
      position: 101
      prefix: --delta
  - id: delta_iso_len_3
    type:
      - 'null'
      - int
    doc: 'Cutoff parameter: maximum length difference at 3prime end, for which subisoforms
      are still merged into longer isoforms'
    default: 30
    inputBinding:
      position: 101
      prefix: --delta_iso_len_3
  - id: delta_iso_len_5
    type:
      - 'null'
      - int
    doc: 'Cutoff parameter: maximum length difference at 5prime end, for which subisoforms
      are still merged into longer isoforms'
    default: 50
    inputBinding:
      position: 101
      prefix: --delta_iso_len_5
  - id: delta_len
    type:
      - 'null'
      - int
    doc: Maximum length difference between two reads intervals for which they 
      would still be merged
    default: 5
    inputBinding:
      position: 101
      prefix: --delta_len
  - id: exact_instance_limit
    type:
      - 'null'
      - int
    doc: Do exact correction for clusters under this threshold
    default: 50
    inputBinding:
      position: 101
      prefix: --exact_instance_limit
  - id: fastq_folder
    type:
      - 'null'
      - Directory
    doc: Path to input fastq folder with reads in clusters
    default: 'False'
    inputBinding:
      position: 101
      prefix: --fastq_folder
  - id: iso_abundance
    type:
      - 'null'
      - int
    doc: 'Cutoff parameter: abundance of reads that have to support an isoform to
      show in results'
    default: 5
    inputBinding:
      position: 101
      prefix: --iso_abundance
  - id: k
    type:
      - 'null'
      - int
    doc: Kmer size
    default: 20
    inputBinding:
      position: 101
      prefix: --k
  - id: keep_old
    type:
      - 'null'
      - boolean
    doc: Do not recompute previous results if corrected_reads.fq is found and 
      has the smae number of reads as input file (i.e., is complete).
    default: false
    inputBinding:
      position: 101
      prefix: --keep_old
  - id: max_seqs
    type:
      - 'null'
      - int
    doc: Maximum number of seqs to correct at a time (in case of large 
      clusters).
    default: 1000
    inputBinding:
      position: 101
      prefix: --max_seqs
  - id: max_seqs_to_spoa
    type:
      - 'null'
      - int
    doc: Maximum number of seqs to spoa
    default: 200
    inputBinding:
      position: 101
      prefix: --max_seqs_to_spoa
  - id: nr_cores
    type:
      - 'null'
      - int
    doc: Number of cores allocated for clustering
    default: 8
    inputBinding:
      position: 101
      prefix: --t
  - id: outfolder
    type:
      - 'null'
      - Directory
    doc: Outfolder with all corrected reads.
    default: None
    inputBinding:
      position: 101
      prefix: --outfolder
  - id: set_w_dynamically
    type:
      - 'null'
      - boolean
    doc: Set w = k + max(2*k, floor(cluster_size/1000)).
    default: false
    inputBinding:
      position: 101
      prefix: --set_w_dynamically
  - id: split_wrt_batches
    type:
      - 'null'
      - boolean
    doc: Process reads per batch (of max_seqs sequences) instead of per cluster.
      Significantly decrease runtime when few very large clusters are less than 
      the number of cores used.
    default: false
    inputBinding:
      position: 101
      prefix: --split_wrt_batches
  - id: tmpdir
    type:
      - 'null'
      - Directory
    doc: 'OPTIONAL PARAMETER: Absolute path to custom folder in which to store temporary
      files. If tmpdir is not specified, isONform will attempt to write the temporary
      files into the tmp folder on your system. It is advised to only use this parameter
      if the symlinking does not work on your system.'
    default: None
    inputBinding:
      position: 101
      prefix: --tmpdir
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print various developer stats.
    default: false
    inputBinding:
      position: 101
      prefix: --verbose
  - id: w
    type:
      - 'null'
      - int
    doc: Window size
    default: 31
    inputBinding:
      position: 101
      prefix: --w
  - id: write_fastq
    type:
      - 'null'
      - boolean
    doc: 'Indicates that we want to ouptut the final output (transcriptome) as fastq
      file (New standard: fasta)'
    default: false
    inputBinding:
      position: 101
      prefix: --write_fastq
  - id: xmax
    type:
      - 'null'
      - int
    doc: Upper interval length
    default: 80
    inputBinding:
      position: 101
      prefix: --xmax
  - id: xmin
    type:
      - 'null'
      - int
    doc: Lower interval length
    default: 18
    inputBinding:
      position: 101
      prefix: --xmin
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/isonform:0.3.4--pyh7cba7a3_0
stdout: isonform_isONform_parallel.out
