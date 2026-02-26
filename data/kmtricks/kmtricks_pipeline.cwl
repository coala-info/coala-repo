cwlVersion: v1.2
class: CommandLineTool
baseCommand: kmtricks pipeline
label: kmtricks_pipeline
doc: "run all the steps, repart -> superk -> count -> merge\n\nTool homepage: https://github.com/tlemane/kmtricks"
inputs:
  - id: bf_format
    type:
      - 'null'
      - string
    doc: bloom filter format. [howdesbt|sdsl]
    default: howdesbt
    inputBinding:
      position: 101
      prefix: --bf-format
  - id: bitw
    type:
      - 'null'
      - int
    doc: entry width of cbf, with --mode hash:bfc:bin
    default: 2
    inputBinding:
      position: 101
      prefix: --bitw
  - id: bloom_size
    type:
      - 'null'
      - int
    doc: bloom filter size
    default: 10000000
    inputBinding:
      position: 101
      prefix: --bloom-size
  - id: cpr
    type:
      - 'null'
      - boolean
    doc: compression for kmtricks's tmp files.
    inputBinding:
      position: 101
      prefix: --cpr
  - id: file
    type: File
    doc: kmtricks input file, see README.md.
    inputBinding:
      position: 101
      prefix: --file
  - id: focus
    type:
      - 'null'
      - float
    doc: '0: focus on disk usage, 1: focus on speed. [0.0, 1.0]'
    default: 0.5
    inputBinding:
      position: 101
      prefix: --focus
  - id: hard_min
    type:
      - 'null'
      - int
    doc: min abundance to keep a k-mer.
    default: 2
    inputBinding:
      position: 101
      prefix: --hard-min
  - id: hist
    type:
      - 'null'
      - boolean
    doc: compute k-mer histograms.
    inputBinding:
      position: 101
      prefix: --hist
  - id: keep_tmp
    type:
      - 'null'
      - boolean
    doc: keep tmp files.
    inputBinding:
      position: 101
      prefix: --keep-tmp
  - id: kff_output
    type:
      - 'null'
      - boolean
    doc: output counted k-mers in kff format (only with --until count).
    inputBinding:
      position: 101
      prefix: --kff-output
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: size of a k-mer. [8, 255].
    default: 31
    inputBinding:
      position: 101
      prefix: --kmer-size
  - id: minimizer_size
    type:
      - 'null'
      - int
    doc: size of minimizers. [4, 15]
    default: 10
    inputBinding:
      position: 101
      prefix: --minimizer-size
  - id: minimizer_type
    type:
      - 'null'
      - int
    doc: minimizer type (0=lexi, 1=freq).
    default: 0
    inputBinding:
      position: 101
      prefix: --minimizer-type
  - id: mode
    type:
      - 'null'
      - string
    doc: matrix mode <mode:format:out>, see README
    default: kmer:count:bin
    inputBinding:
      position: 101
      prefix: --mode
  - id: nb_partitions
    type:
      - 'null'
      - int
    doc: number of partitions (0=auto).
    default: 0
    inputBinding:
      position: 101
      prefix: --nb-partitions
  - id: recurrence_min
    type:
      - 'null'
      - int
    doc: min recurrence to keep a k-mer.
    default: 1
    inputBinding:
      position: 101
      prefix: --recurrence-min
  - id: repart_from
    type:
      - 'null'
      - string
    doc: use repartition from another kmtricks run.
    inputBinding:
      position: 101
      prefix: --repart-from
  - id: repartition_type
    type:
      - 'null'
      - int
    doc: minimizer repartition (0=unordered, 1=ordered).
    default: 0
    inputBinding:
      position: 101
      prefix: --repartition-type
  - id: restrict_to
    type:
      - 'null'
      - float
    doc: Process only a fraction of partitions. [0.05, 1.0]
    default: 1.0
    inputBinding:
      position: 101
      prefix: --restrict-to
  - id: restrict_to_list
    type:
      - 'null'
      - string
    doc: Process only some partitions, comma separated.
    inputBinding:
      position: 101
      prefix: --restrict-to-list
  - id: run_dir
    type: Directory
    doc: kmtricks runtime directory.
    inputBinding:
      position: 101
      prefix: --run-dir
  - id: share_min
    type:
      - 'null'
      - int
    doc: save a non-solid k-mer if it is solid in N other samples.
    default: 0
    inputBinding:
      position: 101
      prefix: --share-min
  - id: soft_min
    type:
      - 'null'
      - string
    doc: during merge, min abundance to keep a k-mer, see README.
    default: 1
    inputBinding:
      position: 101
      prefix: --soft-min
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads.
    default: 20
    inputBinding:
      position: 101
      prefix: --threads
  - id: until
    type:
      - 'null'
      - string
    doc: run until [all|repart|superk|count|merge]
    default: all
    inputBinding:
      position: 101
      prefix: --until
  - id: verbose
    type:
      - 'null'
      - string
    doc: verbosity level [debug|info|warning|error].
    default: info
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kmtricks:1.5.1--h22625ea_0
stdout: kmtricks_pipeline.out
