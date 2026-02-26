cwlVersion: v1.2
class: CommandLineTool
baseCommand: KPopTwistDB
label: kpop_KPopTwistDB
doc: "This is KPopTwistDB version 29 (18-Mar-2024)\n\nTool homepage: https://github.com/PaoloRibeca/KPop"
inputs:
  - id: add_db_type
    type:
      - 'null'
      - string
    doc: 'add the contents of the specified binary database to the specified register
      (t=twisted; d=distance). File extension is automatically determined depending
      on database type (will be: .KPopTwisted; or .KPopDMatrix, respectively)'
    inputBinding:
      position: 101
      prefix: --add
  - id: add_table_db_type
    type:
      - 'null'
      - string
    doc: 'add the contents of the specified tabular database to the specified register
      (t=twisted; d=distance). File extension is automatically determined depending
      on database type (will be: .KPopTwisted.txt; or .KPopDMatrix.txt, respectively)'
    inputBinding:
      position: 101
      prefix: --Add
  - id: compute_and_summarize_distances_args
    type:
      - 'null'
      - string
    doc: compute distances between all the vectors present in the twisted 
      register and all the vectors present in the specified twisted binary file 
      (which must have extension .KPopTwisted) using the metric provided by the 
      twister present in the twister register; summarize them and write the 
      result to the specified tabular file. File extension is automatically 
      assigned (will be .KPopSummary.txt)
    inputBinding:
      position: 101
      prefix: --compute-and-summarize-distances
  - id: compute_distances_file
    type:
      - 'null'
      - File
    doc: compute distances between all the vectors present in the twisted 
      register and all the vectors present in the specified twisted binary file 
      (which must have extension .KPopTwisted) using the metric provided by the 
      twister present in the twister register. The result will be placed in the 
      distance register
    inputBinding:
      position: 101
      prefix: --distances
  - id: distance_function
    type:
      - 'null'
      - string
    doc: set the function to be used when computing distances. The parameter for
      'minkowski' is the power. Note that 'euclidean' is the same as 
      'minkowski(2)', and 'cosine' is the same as ('euclidean'^2)/2
    default: euclidean
    inputBinding:
      position: 101
      prefix: --distance
  - id: distance_normalization
    type:
      - 'null'
      - boolean
    doc: set whether twisted vectors should be normalized prior to computing 
      distances
    default: true
    inputBinding:
      position: 101
      prefix: --distance-normalization
  - id: empty_db_type
    type:
      - 'null'
      - string
    doc: load an empty database into the specified register (T=twister; 
      t=twisted; d=distance)
    inputBinding:
      position: 101
      prefix: --empty
  - id: input_db_type
    type:
      - 'null'
      - string
    doc: 'load the specified binary database into the specified register (T=twister;
      t=twisted; d=distance). File extension is automatically determined depending
      on database type (will be: .KPopTwister; .KPopTwisted; or .KPopDMatrix, respectively)'
    inputBinding:
      position: 101
      prefix: --input
  - id: input_table_db_type
    type:
      - 'null'
      - string
    doc: 'load the specified tabular database(s) into the specified register (T=twister;
      t=twisted; d=distance). File extension is automatically determined depending
      on database type (will be: .KPopTwister.txt and .KPopInertia.txt; .KPopTwisted.txt;
      or .KPopDMatrix.txt, respectively)'
    inputBinding:
      position: 101
      prefix: --Input
  - id: keep_at_most
    type:
      - 'null'
      - string
    doc: set the maximum number of closest target sequences to be kept when 
      summarizing distances. Note that more might be printed anyway in case of 
      ties
    default: '2'
    inputBinding:
      position: 101
      prefix: --keep-at-most
  - id: kmer_files
    type:
      - 'null'
      - type: array
        items: File
    doc: twist k-mers from the specified files through the transformation 
      present in the twister register, and add the results to the database 
      present in the twisted register
    inputBinding:
      position: 101
      prefix: --kmers
  - id: metric_function
    type:
      - 'null'
      - string
    doc: 'set the metric function to be used when computing distances. Parameters
      are: internal power; fractional accumulative threshold; external power.'
    default: powers(1,1,2)
    inputBinding:
      position: 101
      prefix: --metric
  - id: output_db_type
    type:
      - 'null'
      - string
    doc: 'dump the database present in the specified register (T=twister; t=twisted;
      d=distance) to the specified binary file. File extension is automatically assigned
      depending on database type (will be: .KPopTwister; .KPopTwisted; or .KPopDMatrix,
      respectively)'
    inputBinding:
      position: 101
      prefix: --output
  - id: output_table_db_type
    type:
      - 'null'
      - string
    doc: 'dump the database present in the specified register (T=twister; t=twisted;
      d=distance; m=metric) to the specified tabular file(s). File extension is automatically
      assigned depending on database type (will be: .KPopTwister.txt and .KPopInertia.txt;
      .KPopTwisted.txt; .KPopDMatrix.txt; or .KPopMetrics.txt, respectively)'
    inputBinding:
      position: 101
      prefix: --Output
  - id: precision
    type:
      - 'null'
      - int
    doc: set the number of precision digits to be used when outputting numbers
    default: 15
    inputBinding:
      position: 101
      prefix: --precision
  - id: summarize_distances_file
    type:
      - 'null'
      - File
    doc: summarize the distances present in the distance register and write the 
      result to the specified tabular file. File extension is automatically 
      assigned (will be .KPopSummary.txt)
    inputBinding:
      position: 101
      prefix: --summarize-distances
  - id: threads
    type:
      - 'null'
      - int
    doc: number of concurrent computing threads to be spawned (default 
      automatically detected from your configuration)
    default: 20
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: set verbose execution
    default: false
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kpop:1.1.1--h9ee0642_1
stdout: kpop_KPopTwistDB.out
