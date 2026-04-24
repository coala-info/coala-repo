cwlVersion: v1.2
class: CommandLineTool
baseCommand: cmph
label: cmph
doc: "Minimum perfect hashing tool\n\nTool homepage: https://github.com/zvelo/cmph"
inputs:
  - id: keys_file
    type: File
    doc: line separated file with keys
    inputBinding:
      position: 1
  - id: algorithm
    type:
      - 'null'
      - string
    doc: 'algorithm - valid values are: bmz, bmz8, chm, brz, fch, bdz, bdz_ph, chd_ph,
      chd'
    inputBinding:
      position: 102
      prefix: -a
  - id: algorithm_dependent_value
    type:
      - 'null'
      - int
    doc: 'Meaning depends on algorithm: BRZ (max keys in bucket [64,175], default
      128), BDZ (rank info size [3,10], default 7), CHD/CHD_PH (avg keys per bucket
      [1,32], default 4)'
    inputBinding:
      position: 102
      prefix: -b
  - id: c_value
    type:
      - 'null'
      - float
    doc: 'c value determines: the number of vertices in the graph for BMZ and CHM,
      the number of bits per key in FCH, or the load factor in CHD_PH'
    inputBinding:
      position: 102
      prefix: -c
  - id: generation_mode
    type:
      - 'null'
      - boolean
    doc: generation mode
    inputBinding:
      position: 102
      prefix: -g
  - id: hash_function
    type:
      - 'null'
      - type: array
        items: string
    doc: 'hash function (may be used multiple times) - valid values are: jenkins'
    inputBinding:
      position: 102
      prefix: -f
  - id: keys_per_bin
    type:
      - 'null'
      - int
    doc: set the number of keys per bin for a t-perfect hashing function (CHD 
      and CHD_PH only, range [1,128])
    inputBinding:
      position: 102
      prefix: -t
  - id: memory_mb
    type:
      - 'null'
      - int
    doc: main memory availability (in MB) used in BRZ algorithm
    inputBinding:
      position: 102
      prefix: -M
  - id: n_keys
    type:
      - 'null'
      - int
    doc: number of keys
    inputBinding:
      position: 102
      prefix: -k
  - id: seed
    type:
      - 'null'
      - int
    doc: random seed
    inputBinding:
      position: 102
      prefix: -s
  - id: tmp_dir
    type:
      - 'null'
      - Directory
    doc: temporary directory used in BRZ algorithm
    inputBinding:
      position: 102
      prefix: -d
  - id: verbosity
    type:
      - 'null'
      - type: array
        items: boolean
    doc: increase verbosity (may be used multiple times)
    inputBinding:
      position: 102
      prefix: -v
outputs:
  - id: mph_file
    type:
      - 'null'
      - File
    doc: minimum perfect hash function file
    outputBinding:
      glob: $(inputs.mph_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cmph:2.0--h7b50bb2_7
