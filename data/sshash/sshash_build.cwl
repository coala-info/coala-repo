cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sshash
  - build
label: sshash_build
doc: "Build a SSHash dictionary (sparse and skew hashing of k-mers) from a FASTA file
  of unitigs, and write the index to disk.\n\nTool homepage: https://github.com/jermp/sshash"
inputs:
  - id: input_filename
    type: File
    doc: "REQUIRED: FASTA file (.fa/fasta extension) or CUTTLEFISH file (.cfseg
      extension), gzip-compressed or not, without duplicate nor invalid k-mers and
      with one DNA sequence per line (for example a de Bruijn graph from BCALM or
      CUTTLEFISH)."
    inputBinding:
      position: 101
      prefix: -i
  - id: k
    type: int
    doc: 'REQUIRED: K-mer length (must be <= 31).'
    inputBinding:
      position: 101
      prefix: -k
  - id: m
    type: int
    doc: 'REQUIRED: Minimizer length (must be < k).'
    inputBinding:
      position: 101
      prefix: -m
  - id: seed
    type:
      - 'null'
      - int
    doc: Seed for construction (default is 1).
    inputBinding:
      position: 101
      prefix: -s
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads (default is 1).
    inputBinding:
      position: 101
      prefix: -t
  - id: lambda
    type:
      - 'null'
      - float
    doc: A constant that trades construction speed for space effectiveness of 
      minimal perfect hashing. A reasonable value lies between 3.0 and 10.0 
      (default is 5.0).
    inputBinding:
      position: 101
      prefix: -a
  - id: tmp_dirname
    type:
      - 'null'
      - string
    doc: Temporary directory used for construction in external memory. Default 
      is directory '.'.
    inputBinding:
      position: 101
      prefix: -d
  - id: ram_limit
    type:
      - 'null'
      - int
    doc: RAM limit in GiB. Default value is 8 GiB.
    inputBinding:
      position: 101
      prefix: -g
  - id: canonical
    type:
      - 'null'
      - boolean
    doc: This option results in a trade-off between index space and lookup time.
    inputBinding:
      position: 101
      prefix: --canonical
  - id: weighted
    type:
      - 'null'
      - boolean
    doc: Also store the weights in compressed format.
    inputBinding:
      position: 101
      prefix: --weighted
  - id: check
    type:
      - 'null'
      - boolean
    doc: Check correctness after construction.
    inputBinding:
      position: 101
      prefix: --check
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output during construction.
    inputBinding:
      position: 101
      prefix: --verbose
  - id: output_filename
    type: string
    doc: Output file name where the data structure will be serialized.
    inputBinding:
      position: 102
      prefix: -o
outputs:
  - id: index
    type:
      - 'null'
      - File
    doc: Serialized SSHash index
    outputBinding:
      glob: $(inputs.output_filename)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sshash:5.0.0--haf24da9_0
stdout: sshash_build.out
