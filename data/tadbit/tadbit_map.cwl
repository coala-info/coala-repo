cwlVersion: v1.2
class: CommandLineTool
baseCommand: tadbit map
label: tadbit_map
doc: "Map Hi-C reads and organize results in an output working directory\n\nTool homepage:
  http://sgt.cnag.cat/3dg/tadbit/"
inputs:
  - id: chr_name
    type:
      - 'null'
      - type: array
        items: string
    doc: '[fasta header] chromosome name(s). Used in the same order as data.'
    inputBinding:
      position: 101
      prefix: --chr_name
  - id: cpus
    type:
      - 'null'
      - int
    doc: "[20] Maximum number of CPU cores available in the execution host. If\n \
      \                          higher than 1, tasks with multi-threading capabilities
      will enabled\n                           (if 0 all available) cores will be
      used"
    default: 20
    inputBinding:
      position: 101
      prefix: --cpus
  - id: descr
    type:
      - 'null'
      - type: array
        items: string
    doc: "extra descriptive fields each filed separated by coma, and inside\n    \
      \                       each, name and value separated by column:\n        \
      \                   --descr=cell:lymphoblast,flowcell:C68AEACXX,index:24nf"
    inputBinding:
      position: 101
      prefix: --descr
  - id: fast_fragment
    type:
      - 'null'
      - boolean
    doc: "(beta) use fast fragment mapping. Both fastq files are mapped using\n  \
      \                         fragment based mapping in GEM v3. The output file
      is an intersected\n                           read file than can be used directly
      in tadbit filter (no tadbit\n                           parse needed). Access
      to samtools is needed for fast_fragment to\n                           work.
      --fastq2 and --genome needs to be specified and --read value\n             \
      \              should be 0."
    inputBinding:
      position: 101
      prefix: --fast_fragment
  - id: fastq
    type: File
    doc: path to a FASTQ files (can be compressed files)
    inputBinding:
      position: 101
      prefix: --fastq
  - id: fastq2
    type:
      - 'null'
      - File
    doc: "(beta) path to a FASTQ file of read 2 (can be compressed files).\n     \
      \                      Needed for fast_fragment"
    inputBinding:
      position: 101
      prefix: --fastq2
  - id: genome
    type:
      - 'null'
      - type: array
        items: File
    doc: "paths to file(s) with FASTA files of the reference genome. Needed\n    \
      \                       for fast_fragment mapping. If many, files will be concatenated.\n\
      \                           I.e.: --genome chr_1.fa chr_2.fa In this last case,
      order is\n                           important or the rest of the analysis.
      Note: it can also be the path\n                           to a previously parsed
      genome in pickle format."
    inputBinding:
      position: 101
      prefix: --genome
  - id: index
    type:
      type: array
      items: File
    doc: paths to file(s) with indexed FASTA files of the reference genome.
    inputBinding:
      position: 101
      prefix: --index
  - id: iterative
    type:
      - 'null'
      - boolean
    doc: "default mapping strategy is fragment based use this flag for\n         \
      \                  iterative mapping"
    inputBinding:
      position: 101
      prefix: --iterative
  - id: keep_tmp
    type:
      - 'null'
      - boolean
    doc: '[DEBUG] keep temporary files.'
    inputBinding:
      position: 101
      prefix: --keep_tmp
  - id: mapper
    type:
      - 'null'
      - string
    doc: '[gem] mapper used, options are gem, bowtie2 or hisat2'
    default: gem
    inputBinding:
      position: 101
      prefix: --mapper
  - id: mapper_binary
    type:
      - 'null'
      - string
    doc: '[None] path to mapper binary'
    default: None
    inputBinding:
      position: 101
      prefix: --mapper_binary
  - id: mapper_param
    type:
      - 'null'
      - type: array
        items: string
    doc: "any parameter that could be passed to the GEM, BOWTIE2 or HISAT2\n     \
      \                      mapper. e.g. if we want to set the proportion of mismatches
      to 0.05\n                           and the maximum indel length to 10, (in
      GEM v2 it would be: -e 0.05\n                           --max-big-indel-length
      10), here we could write: \"--mapper_param\n                           e:0.05
      max-big-indel-length:10\". For BOWTIE2, GEM3 and HISAT2 you\n              \
      \             can also pass directly the parameters enclosed between quotes
      like:\n                           --mapper_param \"-e 0.05 --alignment-local-min-score
      15\" IMPORTANT:\n                           some options are incompatible with
      3C-derived experiments."
    inputBinding:
      position: 101
      prefix: --mapper_param
  - id: noX
    type:
      - 'null'
      - boolean
    doc: no display server (X screen)
    inputBinding:
      position: 101
      prefix: --noX
  - id: read
    type: int
    doc: read number
    inputBinding:
      position: 101
      prefix: --read
  - id: renz
    type:
      type: array
      items: string
    doc: "restriction enzyme name(s). Use \"--renz CHECK\" to search for most\n  \
      \                         probable and exit; and use \"--renz NONE\" to avoid
      using RE site\n                           information."
    inputBinding:
      position: 101
      prefix: --renz
  - id: skip
    type:
      - 'null'
      - boolean
    doc: '[DEBUG] in case already mapped.'
    inputBinding:
      position: 101
      prefix: --skip
  - id: skip_mapping
    type:
      - 'null'
      - boolean
    doc: generate a Hi-C specific quality plot from FASTQ and exits
    inputBinding:
      position: 101
      prefix: --skip_mapping
  - id: species
    type:
      - 'null'
      - string
    doc: species name
    inputBinding:
      position: 101
      prefix: --species
  - id: tmp
    type:
      - 'null'
      - Directory
    doc: path to a temporary directory (default next to "workdir" directory)
    inputBinding:
      position: 101
      prefix: --tmp
  - id: tmpdb
    type:
      - 'null'
      - Directory
    doc: if provided uses this directory to manipulate the database
    inputBinding:
      position: 101
      prefix: --tmpdb
  - id: windows
    type:
      - 'null'
      - type: array
        items: string
    doc: "defines windows to be used to trim the input FASTQ reads, for\n        \
      \                   example an iterative mapping can be defined as: \"--windows
      1:20 1:25\n                           1:30 1:35 1:40 1:45 1:50\". But this parameter
      can also be used for\n                           fragment based mapping if for
      example pair-end reads are both in the\n                           same FASTQ,
      for example: \"--windows 1:50\" (if the length of the\n                    \
      \       reads is 100). Note: that the numbers are both inclusive."
    inputBinding:
      position: 101
      prefix: --windows
  - id: workdir
    type: Directory
    doc: path to an output folder.
    inputBinding:
      position: 101
      prefix: --workdir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tadbit:1.0.1--py310h2a84d7f_1
stdout: tadbit_map.out
