cwlVersion: v1.2
class: CommandLineTool
baseCommand: isONcorrect
label: isoncorrect_isONcorrect
doc: "De novo error correction of long-read transcriptome reads\n\nTool homepage:
  https://github.com/ksahlin/isONcorrect"
inputs:
  - id: compression
    type:
      - 'null'
      - boolean
    doc: Use homopolymenr compressed reads. (Deprecated, because we will have 
      fewer minmimizer combinations to span regions in homopolymenr dense 
      regions. Solution could be to adjust upper interval legnth dynamically to 
      guarantee a certain number of spanning intervals.
    inputBinding:
      position: 101
      prefix: --compression
  - id: disable_numpy
    type:
      - 'null'
      - boolean
    doc: Do not require numpy to be installed, but this version is about 1.5x 
      slower than with numpy.
    inputBinding:
      position: 101
      prefix: --disable_numpy
  - id: exact
    type:
      - 'null'
      - boolean
    doc: Get exact solution for WIS for evary read (recalculating weights for 
      each read (much slower but slightly more accuracy, not to be used for 
      clusters with over ~500 reads)
    inputBinding:
      position: 101
      prefix: --exact
  - id: exact_instance_limit
    type:
      - 'null'
      - int
    doc: Activates slower exact mode for instance smaller than this limit
    default: 0
    inputBinding:
      position: 101
      prefix: --exact_instance_limit
  - id: fastq
    type:
      - 'null'
      - File
    doc: Path to input fastq file with reads
    default: false
    inputBinding:
      position: 101
      prefix: --fastq
  - id: k
    type:
      - 'null'
      - int
    doc: Kmer size
    default: 9
    inputBinding:
      position: 101
      prefix: --k
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
    default: 2000
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
  - id: t
    type:
      - 'null'
      - float
    doc: Minimum fraction keeping substitution
    default: 0.1
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
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print various developer stats.
    inputBinding:
      position: 101
      prefix: --verbose
  - id: w
    type:
      - 'null'
      - int
    doc: Window size
    default: 20
    inputBinding:
      position: 101
      prefix: --w
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
  - id: outfolder
    type:
      - 'null'
      - File
    doc: A fasta file with transcripts that are shared between samples and have 
      perfect illumina support.
    outputBinding:
      glob: $(inputs.outfolder)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/isoncorrect:0.1.3.5--pyhdfd78af_0
