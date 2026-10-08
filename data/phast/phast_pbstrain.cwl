cwlVersion: v1.2
class: CommandLineTool
baseCommand: pbsTrain
label: phast_pbstrain
doc: "Estimate a discrete encoding scheme for probabilistic biological sequences (PBSs)
  based on training data. Input is a table of probability vectors with a column of
  counts (it may be produced with 'prequel --suff-stats'). Output is a code file that
  can be used with pbsEncode, pbsDecode, etc.\n\nTool homepage: http://compgen.cshl.edu/phast/"
inputs:
  - id: nrows
    type:
      - 'null'
      - int
    doc: Number of rows per dimension in the simplex grid. Default is maximum possible
      for code size.
    inputBinding:
      position: 1
      prefix: --nrows
  - id: nbytes
    type:
      - 'null'
      - int
    doc: Number of bytes per encoded probabilistic base (default 1).
    inputBinding:
      position: 1
      prefix: --nbytes
  - id: no_greedy
    type:
      - 'null'
      - boolean
    doc: Skip greedy optimization; assign a single representative point to each region
      of the probability simplex.
    inputBinding:
      position: 1
      prefix: --no-greedy
  - id: no_train
    type:
      - 'null'
      - int
    doc: Ignore the data entirely; just use the centroid of each simplex partition.
      Give the dimension of the simplex; no data file is required.
    inputBinding:
      position: 1
      prefix: --no-train
  - id: log
    type:
      - 'null'
      - string
    doc: Write log of optimization procedure to specified file.
    inputBinding:
      position: 1
      prefix: --log
  - id: stats_file
    type:
      - 'null'
      - File
    doc: Table of probability vectors with counts (file.stats). Not needed with --no-train.
    inputBinding:
      position: 2
  - id: output_name
    type:
      - 'null'
      - string
    doc: Name of the code file (standard output).
    default: file.code
outputs:
  - id: code
    type: File
    doc: Code file for pbsEncode/pbsDecode.
    outputBinding:
      glob: $(inputs.output_name)
  - id: log_file
    type:
      - 'null'
      - File
    doc: Optimization log.
    outputBinding:
      glob: $(inputs.log)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phast:1.9.7--h7eac25e_0
stdout: $(inputs.output_name)
