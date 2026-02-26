cwlVersion: v1.2
class: CommandLineTool
baseCommand: sga overlap
label: sga_overlap
doc: "Compute pairwise overlap between all the sequences in READS\n\nTool homepage:
  https://github.com/jts/sga"
inputs:
  - id: reads_file
    type: File
    doc: Input file containing sequences
    inputBinding:
      position: 1
  - id: error_rate
    type:
      - 'null'
      - float
    doc: 'the maximum error rate allowed to consider two sequences aligned (default:
      exact matches only)'
    inputBinding:
      position: 102
      prefix: --error-rate
  - id: exact
    type:
      - 'null'
      - boolean
    doc: force the use of the exact-mode irreducible block algorithm. This is 
      faster but requires that no substrings are present in the input set.
    inputBinding:
      position: 102
      prefix: --exact
  - id: exhaustive
    type:
      - 'null'
      - boolean
    doc: output all overlaps, including transitive edges
    inputBinding:
      position: 102
      prefix: --exhaustive
  - id: min_overlap
    type:
      - 'null'
      - int
    doc: minimum overlap required between two reads
    default: 45
    inputBinding:
      position: 102
      prefix: --min-overlap
  - id: prefix
    type:
      - 'null'
      - string
    doc: 'use PREFIX for the names of the index files (default: prefix of the input
      file)'
    inputBinding:
      position: 102
      prefix: --prefix
  - id: sample_rate
    type:
      - 'null'
      - int
    doc: sample the symbol counts every N symbols in the FM-index. Higher values
      use significantly less memory at the cost of higher runtime. This value 
      must be a power of 2
    default: 128
    inputBinding:
      position: 102
      prefix: --sample-rate
  - id: seed_length
    type:
      - 'null'
      - int
    doc: force the seed length to be LEN. By default, the seed length in the 
      overlap step is calculated to guarantee all overlaps with --error-rate 
      differences are found. This option removes the guarantee but will be 
      (much) faster. As SGA can tolerate some missing edges, this option may be 
      preferable for some data sets.
    inputBinding:
      position: 102
      prefix: --seed-length
  - id: seed_stride
    type:
      - 'null'
      - int
    doc: force the seed stride to be LEN. This parameter will be ignored unless 
      --seed-length is specified (see above). This parameter defaults to the 
      same value as --seed-length
    inputBinding:
      position: 102
      prefix: --seed-stride
  - id: target_file
    type:
      - 'null'
      - File
    doc: perform the overlap queries against the reads in FILE
    inputBinding:
      position: 102
      prefix: --target-file
  - id: threads
    type:
      - 'null'
      - int
    doc: 'use NUM worker threads to compute the overlaps (default: no threading)'
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
stdout: sga_overlap.out
