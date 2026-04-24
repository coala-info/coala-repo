cwlVersion: v1.2
class: CommandLineTool
baseCommand: run_isoncorrect
label: isoncorrect_run_isoncorrect
doc: "De novo clustering of long-read transcriptome reads\n\nTool homepage: https://github.com/ksahlin/isONcorrect"
inputs:
  - id: exact_instance_limit
    type:
      - 'null'
      - int
    doc: Do exact correction for clusters under this threshold
    inputBinding:
      position: 101
      prefix: --exact_instance_limit
  - id: fastq_folder
    type:
      - 'null'
      - Directory
    doc: Path to input fastq folder with reads in clusters
    inputBinding:
      position: 101
      prefix: --fastq_folder
  - id: k
    type:
      - 'null'
      - int
    doc: Kmer size
    inputBinding:
      position: 101
      prefix: --k
  - id: keep_old
    type:
      - 'null'
      - boolean
    doc: Do not recompute previous results if corrected_reads.fq is found and 
      has the smae number of reads as input file (i.e., is complete).
    inputBinding:
      position: 101
      prefix: --keep_old
  - id: layers
    type:
      - 'null'
      - int
    doc: 'EXPERIMENTAL PARAMETER: Active when --randstrobes specified. How many "layers"
      with randstrobes we want per sequence to sample. More layers gives more accureate
      results but is more memory consuming and slower. It is not reccomended to specify
      more than 5.'
    inputBinding:
      position: 101
      prefix: --layers
  - id: max_seqs
    type:
      - 'null'
      - int
    doc: Maximum number of seqs to correct at a time (in case of large 
      clusters).
    inputBinding:
      position: 101
      prefix: --max_seqs
  - id: nr_cores
    type:
      - 'null'
      - int
    doc: Number of cores allocated for clustering
    inputBinding:
      position: 101
      prefix: --t
  - id: outfolder
    type:
      - 'null'
      - Directory
    doc: Outfolder with all corrected reads.
    inputBinding:
      position: 101
      prefix: --outfolder
  - id: randstrobes
    type:
      - 'null'
      - boolean
    doc: 'EXPERIMENTAL PARAMETER: IsONcorrect uses paired minimizers (described in
      isONcorrect paper). This experimental option uses randstrobes instead of paired
      minimizers to find shared regions. Randstrobes reduces memory footprint substantially
      (and runtime) with only slight increase in post correction quality.'
    inputBinding:
      position: 101
      prefix: --randstrobes
  - id: residual
    type:
      - 'null'
      - int
    doc: Run isONcorrect on cluster ids with residual (default 0) of cluster_id 
      divided by --split_mod.
    inputBinding:
      position: 101
      prefix: --residual
  - id: set_layers_manually
    type:
      - 'null'
      - boolean
    doc: 'EXPERIMENTAL PARAMETER: By default isONcorrect sets layers = 1 if nr seqs
      in batch to be corrected is >= 1000, else layers = 2. This command will manually
      pick the number of layers specified with the --layers parameter.'
    inputBinding:
      position: 101
      prefix: --set_layers_manually
  - id: set_w_dynamically
    type:
      - 'null'
      - boolean
    doc: Set w = k + max(2*k, floor(cluster_size/1000)).
    inputBinding:
      position: 101
      prefix: --set_w_dynamically
  - id: split_mod
    type:
      - 'null'
      - int
    doc: Splits cluster ids in n (default=1) partitions by computing residual of
      cluster_id divided by n. this parameter needs to be combined with 
      --residual to take effect.
    inputBinding:
      position: 101
      prefix: --split_mod
  - id: split_wrt_batches
    type:
      - 'null'
      - boolean
    doc: Process reads per batch (of max_seqs sequences) instead of per cluster.
      Significantly decrease runtime when few very large clusters are less than 
      the number of cores used.
    inputBinding:
      position: 101
      prefix: --split_wrt_batches
  - id: t_min_fraction
    type:
      - 'null'
      - float
    doc: Minimum fraction keeping substitution
    inputBinding:
      position: 101
      prefix: --T
  - id: use_racon
    type:
      - 'null'
      - boolean
    doc: Use racon to polish consensus after spoa (more time consuming but 
      higher accuracy).
    inputBinding:
      position: 101
      prefix: --use_racon
  - id: w
    type:
      - 'null'
      - int
    doc: Window size
    inputBinding:
      position: 101
      prefix: --w
  - id: xmax
    type:
      - 'null'
      - int
    doc: Upper interval length
    inputBinding:
      position: 101
      prefix: --xmax
  - id: xmin
    type:
      - 'null'
      - int
    doc: Lower interval length
    inputBinding:
      position: 101
      prefix: --xmin
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/isoncorrect:0.1.3.5--pyhdfd78af_0
stdout: isoncorrect_run_isoncorrect.out
