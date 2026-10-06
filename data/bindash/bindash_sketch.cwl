cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bindash
  - sketch
label: bindash_sketch
doc: "Reduce multiple genomes into one sketch. A genome corresponds to an input sequence file. A sketch consists of a set of output files.\n\nTool homepage: https://github.com/zhaoxiaofei/bindash"
inputs:
  - id: sequence_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Zero or more filenames. If zero filenames, then read from each line in 
      listfname. Each filename specifies a path to a sequence file.
    inputBinding:
      position: 10
  - id: listfname
    type:
      - 'null'
      - File
    doc: 'Name of the file associating consecutive sequences to genomes (including metagenomes and pangenomes). Each line of this file has the following format: "Path-to-a-sequence-file(F) <TAB> [genome-name(G) <TAB> number-of-consecutive-sequences(N) ...]". If only F is provided, then use F as G and let N be the number of sequences in N [-]'
    inputBinding:
      position: 1
      prefix: --listfname=
      separate: false
  - id: listed_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Sequence files named in listfname; staged in the working directory so 
      the names in listfname (given as basenames) resolve.
  - id: nthreads
    type:
      - 'null'
      - int
    doc: 'This many threads will be spawned for processing. [20]'
    inputBinding:
      position: 1
      prefix: --nthreads=
      separate: false
  - id: dens
    type:
      - 'null'
      - int
    doc: 'This will use a specific densification strategy for minhashtype 2. 1 means optimal densification, default. 2 means reverse optimal densification. [1]'
    inputBinding:
      position: 1
      prefix: --dens=
      separate: false
  - id: minhashtype
    type:
      - 'null'
      - int
    doc: 'Type of minhash. -1 means perfect hash function for nucleotides where 5^(kmerlen) < 2^63. 0 means one hash-function with multiple min-values. 1 means multiple hash-functions and one min-value per function. 2 means one hash-function with partitioned buckets. [2]'
    inputBinding:
      position: 1
      prefix: --minhashtype=
      separate: false
  - id: bbits
    type:
      - 'null'
      - int
    doc: 'Number of bits kept as in b-bits minhash. [16]'
    inputBinding:
      position: 1
      prefix: --bbits=
      separate: false
  - id: kmerlen
    type:
      - 'null'
      - int
    doc: 'K-mer length used to generate minhash values. [16]'
    inputBinding:
      position: 1
      prefix: --kmerlen=
      separate: false
  - id: sketchsize64
    type:
      - 'null'
      - int
    doc: 'Sketch size divided by 64, or equivalently, the number of sets (each consisting of 64 minhash values) per genome). [32]'
    inputBinding:
      position: 1
      prefix: --sketchsize64=
      separate: false
  - id: isstrandpreserved
    type:
      - 'null'
      - boolean
    doc: 'Preserve strand, which means ignore reverse complement. [false]'
    inputBinding:
      position: 1
      prefix: --isstrandpreserved=true
  - id: iscasepreserved
    type:
      - 'null'
      - boolean
    doc: 'Preserve case, which means the lowercase and uppercase versions of the same letter are treated as two different letters. [false]'
    inputBinding:
      position: 1
      prefix: --iscasepreserved=true
  - id: randseed
    type:
      - 'null'
      - int
    doc: 'Seed to provide to the hash function. [41].'
    inputBinding:
      position: 1
      prefix: --randseed=
      separate: false
  - id: outfname
    type: string
    doc: Name of the file containing sketches as output [sketch-at-time-NNN 
      (time-dependent)].
    default: bindash.sketch
    inputBinding:
      position: 1
      prefix: --outfname=
      separate: false
outputs:
  - id: sketch
    type: File
    doc: Sketch file, with its .dat and .txt companion files.
    outputBinding:
      glob: $(inputs.outfname)
    secondaryFiles:
      - pattern: .dat
      - pattern: .txt
requirements:
  - class: InitialWorkDirRequirement
    listing: "$(inputs.listed_files ? inputs.listed_files : [])"
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bindash:2.6--h077b44d_0
