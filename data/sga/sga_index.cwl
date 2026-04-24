cwlVersion: v1.2
class: CommandLineTool
baseCommand: sga index
label: sga_index
doc: "Index the reads in READSFILE using a suffixarray/bwt\n\nTool homepage: https://github.com/jts/sga"
inputs:
  - id: readsfile
    type: File
    doc: Reads file to index
    inputBinding:
      position: 1
  - id: algorithm
    type:
      - 'null'
      - string
    doc: 'BWT construction algorithm. STR can be: sais - induced sort algorithm, slower
      but works for very long sequences (default); ropebwt - very fast and memory
      efficient. use this for short (<200bp) reads'
    inputBinding:
      position: 102
      prefix: --algorithm
  - id: check
    type:
      - 'null'
      - boolean
    doc: validate that the suffix array/bwt is correct
    inputBinding:
      position: 102
      prefix: --check
  - id: disk
    type:
      - 'null'
      - int
    doc: use disk-based BWT construction algorithm. The suffix array/BWT will be
      constructed for batchs of NUM reads at a time. To construct the suffix 
      array of 200 megabases of sequence requires ~2GB of memory, set this 
      parameter accordingly.
    inputBinding:
      position: 102
      prefix: --disk
  - id: gap_array
    type:
      - 'null'
      - int
    doc: use N bits of storage for each element of the gap array. Acceptable 
      values are 4,8,16 or 32. Lower values can substantially reduce the amount 
      of memory required at the cost of less predictable memory usage. When this
      value is set to 32, the memory requirement is essentially deterministic 
      and requires ~5N bytes where N is the size of the FM-index of READS2. The 
      default value is 8.
    inputBinding:
      position: 102
      prefix: --gap-array
  - id: no_forward
    type:
      - 'null'
      - boolean
    doc: suppress construction of the forward BWT. Use this option when building
      the forward and reverse index separately
    inputBinding:
      position: 102
      prefix: --no-forward
  - id: no_reverse
    type:
      - 'null'
      - boolean
    doc: suppress construction of the reverse BWT. Use this option when building
      the index for reads that will be error corrected using the k-mer 
      corrector, which only needs the forward index
    inputBinding:
      position: 102
      prefix: --no-reverse
  - id: no_sai
    type:
      - 'null'
      - boolean
    doc: suppress construction of the SAI file. This option only applies to -a 
      ropebwt
    inputBinding:
      position: 102
      prefix: --no-sai
  - id: prefix
    type:
      - 'null'
      - string
    doc: write index to file using PREFIX instead of prefix of READSFILE
    inputBinding:
      position: 102
      prefix: --prefix
  - id: threads
    type:
      - 'null'
      - int
    doc: 'use NUM threads to construct the index (default: 1)'
    inputBinding:
      position: 102
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: display verbose output
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/sga:v0.10.15-4-deb_cv1
stdout: sga_index.out
