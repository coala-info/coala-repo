cwlVersion: v1.2
class: CommandLineTool
baseCommand: KPopTwistDB
label: kpop_KPopTwistDB
doc: "Works with twisted k-mer spectra: twists k-mer tables with an existing twister, adds, loads and writes databases, computes distances and summarizes them. The actions run in a fixed order: empty, load, add, k-mer twisting and settings, distances, summaries, binary output, table output.\n\nTool homepage: https://github.com/PaoloRibeca/KPop"
inputs:
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of concurrent computing threads to be spawned.
    inputBinding:
      position: 1
      prefix: '-T'
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Set verbose execution.
    inputBinding:
      position: 2
      prefix: '-v'
  - id: empty_twister
    type:
      - 'null'
      - boolean
    doc: Load an empty twister database into the twister register.
  - id: empty_twisted
    type:
      - 'null'
      - boolean
    doc: Load an empty twisted database into the twisted register.
  - id: empty_distance
    type:
      - 'null'
      - boolean
    doc: Load an empty distance database into the distance register.
  - id: input_twister
    type:
      - 'null'
      - File
    doc: Binary twister database (extension .KPopTwister) to load into the
      twister register.
  - id: input_twisted
    type:
      - 'null'
      - File
    doc: Binary twisted database (extension .KPopTwisted) to load into the
      twisted register.
  - id: input_distance
    type:
      - 'null'
      - File
    doc: Binary distance database (extension .KPopDMatrix) to load into the
      distance register.
  - id: input_twister_table
    type:
      - 'null'
      - File
    doc: Tabular twister database (extension .KPopTwister.txt, with
      .KPopInertia.txt beside it) to load into the twister register.
    secondaryFiles:
      - pattern: ^^.KPopInertia.txt
        required: true
  - id: input_twisted_table
    type:
      - 'null'
      - File
    doc: Tabular twisted database (extension .KPopTwisted.txt) to load into the
      twisted register.
  - id: input_distance_table
    type:
      - 'null'
      - File
    doc: Tabular distance database (extension .KPopDMatrix.txt) to load into
      the distance register.
  - id: add_twisted
    type:
      - 'null'
      - File
    doc: Binary twisted database (extension .KPopTwisted) whose contents are
      added to the twisted register.
  - id: add_distance
    type:
      - 'null'
      - File
    doc: Binary distance database (extension .KPopDMatrix) whose contents are
      added to the distance register.
  - id: add_twisted_table
    type:
      - 'null'
      - File
    doc: Tabular twisted database (extension .KPopTwisted.txt) whose contents
      are added to the twisted register.
  - id: add_distance_table
    type:
      - 'null'
      - File
    doc: Tabular distance database (extension .KPopDMatrix.txt) whose contents
      are added to the distance register.
  - id: kmer_files
    type:
      - 'null'
      - type: array
        items: File
    doc: k-mer table files (made by KPopCount) to twist through the twister in
      the register; the results are added to the twisted register.
    inputBinding:
      position: 23
      prefix: '-k'
      itemSeparator: ','
  - id: distance_function
    type:
      - 'null'
      - string
    doc: "Distance function: euclidean, cosine or
      minkowski(<non_negative_float>) (default euclidean)."
    inputBinding:
      position: 24
      prefix: '--distance'
  - id: distance_normalization
    type:
      - 'null'
      - boolean
    doc: Whether twisted vectors are normalized before computing distances
      (default true).
    inputBinding:
      position: 25
      prefix: '--distance-normalization'
      valueFrom: '${ return self ? "true" : "false"; }'
  - id: metric_function
    type:
      - 'null'
      - string
    doc: "Metric function used when computing distances: flat or
      powers(<internal_power>,<fractional_threshold>,<external_power>)
      (default powers(1,1,2))."
    inputBinding:
      position: 26
      prefix: '-m'
  - id: precision
    type:
      - 'null'
      - int
    doc: Number of precision digits used when outputting numbers (default 15).
    inputBinding:
      position: 27
      prefix: '--precision'
  - id: keep_at_most
    type:
      - 'null'
      - string
    doc: Maximum number of closest target sequences kept when summarizing
      distances, or all (default 2).
    inputBinding:
      position: 28
      prefix: '-K'
  - id: compute_distances_target
    type:
      - 'null'
      - File
    doc: Twisted database (extension .KPopTwisted) to compute distances
      against; the result goes to the distance register.
  - id: summarize_target
    type:
      - 'null'
      - File
    doc: Twisted database (extension .KPopTwisted) to compute distances against
      and summarize; needs summarize_prefix.
  - id: summarize_prefix
    type:
      - 'null'
      - string
    doc: Prefix of the summary file (written with extension .KPopSummary.txt).
  - id: summarize_distances_prefix
    type:
      - 'null'
      - string
    doc: Summarize the distances in the distance register and write them to
      this prefix (extension .KPopSummary.txt).
    inputBinding:
      position: 31
      prefix: '-S'
  - id: output_twister
    type:
      - 'null'
      - string
    doc: Prefix of the file the twister register is dumped to (extension
      .KPopTwister).
  - id: output_twisted
    type:
      - 'null'
      - string
    doc: Prefix of the file the twisted register is dumped to (extension
      .KPopTwisted).
  - id: output_distance
    type:
      - 'null'
      - string
    doc: Prefix of the file the distance register is dumped to (extension
      .KPopDMatrix).
  - id: output_twister_table
    type:
      - 'null'
      - string
    doc: Prefix of the tabular file(s) the twister register is dumped to
      (extension .KPopTwister.txt and .KPopInertia.txt).
  - id: output_twisted_table
    type:
      - 'null'
      - string
    doc: Prefix of the tabular file(s) the twisted register is dumped to
      (extension .KPopTwisted.txt).
  - id: output_distance_table
    type:
      - 'null'
      - string
    doc: Prefix of the tabular file(s) the distance register is dumped to
      (extension .KPopDMatrix.txt).
  - id: output_metric_table
    type:
      - 'null'
      - string
    doc: Prefix of the tabular file(s) the metric register is dumped to
      (extension .KPopMetrics.txt).
arguments:
  - position: 10
    valueFrom: '${ return inputs.empty_twister ? [''-e'', ''T''] : null; }'
  - position: 11
    valueFrom: '${ return inputs.empty_twisted ? [''-e'', ''t''] : null; }'
  - position: 12
    valueFrom: '${ return inputs.empty_distance ? [''-e'', ''d''] : null; }'
  - position: 13
    valueFrom: '${ return inputs.input_twister ? [''-i'', ''T'', inputs.input_twister.path.replace(/\.KPopTwister$/, "")] : null; }'
  - position: 14
    valueFrom: '${ return inputs.input_twisted ? [''-i'', ''t'', inputs.input_twisted.path.replace(/\.KPopTwisted$/, "")] : null; }'
  - position: 15
    valueFrom: '${ return inputs.input_distance ? [''-i'', ''d'', inputs.input_distance.path.replace(/\.KPopDMatrix$/, "")] : null; }'
  - position: 16
    valueFrom: '${ return inputs.input_twister_table ? [''-I'', ''T'', inputs.input_twister_table.path.replace(/\.KPopTwister\.txt$/, "")] : null; }'
  - position: 17
    valueFrom: '${ return inputs.input_twisted_table ? [''-I'', ''t'', inputs.input_twisted_table.path.replace(/\.KPopTwisted\.txt$/, "")] : null; }'
  - position: 18
    valueFrom: '${ return inputs.input_distance_table ? [''-I'', ''d'', inputs.input_distance_table.path.replace(/\.KPopDMatrix\.txt$/, "")] : null; }'
  - position: 19
    valueFrom: '${ return inputs.add_twisted ? [''-a'', ''t'', inputs.add_twisted.path.replace(/\.KPopTwisted$/, "")] : null; }'
  - position: 20
    valueFrom: '${ return inputs.add_distance ? [''-a'', ''d'', inputs.add_distance.path.replace(/\.KPopDMatrix$/, "")] : null; }'
  - position: 21
    valueFrom: '${ return inputs.add_twisted_table ? [''-A'', ''t'', inputs.add_twisted_table.path.replace(/\.KPopTwisted\.txt$/, "")] : null; }'
  - position: 22
    valueFrom: '${ return inputs.add_distance_table ? [''-A'', ''d'', inputs.add_distance_table.path.replace(/\.KPopDMatrix\.txt$/, "")] : null; }'
  - position: 29
    valueFrom: '${ return inputs.compute_distances_target ? [''-d'', inputs.compute_distances_target.path.replace(/\.KPopTwisted$/, "")] : null; }'
  - position: 30
    valueFrom: '${ return inputs.summarize_target ? [''-s'', inputs.summarize_target.path.replace(/\.KPopTwisted$/, ""), inputs.summarize_prefix] : null; }'
  - position: 32
    valueFrom: '${ return inputs.output_twister ? [''-o'', ''T'', inputs.output_twister] : null; }'
  - position: 33
    valueFrom: '${ return inputs.output_twisted ? [''-o'', ''t'', inputs.output_twisted] : null; }'
  - position: 34
    valueFrom: '${ return inputs.output_distance ? [''-o'', ''d'', inputs.output_distance] : null; }'
  - position: 35
    valueFrom: '${ return inputs.output_twister_table ? [''-O'', ''T'', inputs.output_twister_table] : null; }'
  - position: 36
    valueFrom: '${ return inputs.output_twisted_table ? [''-O'', ''t'', inputs.output_twisted_table] : null; }'
  - position: 37
    valueFrom: '${ return inputs.output_distance_table ? [''-O'', ''d'', inputs.output_distance_table] : null; }'
  - position: 38
    valueFrom: '${ return inputs.output_metric_table ? [''-O'', ''m'', inputs.output_metric_table] : null; }'
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: out_twister
    type:
      - 'null'
      - File
    doc: Twister written with -o T
    outputBinding:
      glob: '$(inputs.output_twister).KPopTwister'
  - id: out_twisted
    type:
      - 'null'
      - File
    doc: Twisted database written with -o t
    outputBinding:
      glob: '$(inputs.output_twisted).KPopTwisted'
  - id: out_distance
    type:
      - 'null'
      - File
    doc: Distance database written with -o d
    outputBinding:
      glob: '$(inputs.output_distance).KPopDMatrix'
  - id: out_twister_table
    type:
      - 'null'
      - type: array
        items: File
    doc: Tabular twister files written with -O T
    outputBinding:
      glob: '$(inputs.output_twister_table).KPop*.txt'
  - id: out_twisted_table
    type:
      - 'null'
      - File
    doc: Tabular twisted file written with -O t
    outputBinding:
      glob: '$(inputs.output_twisted_table).KPopTwisted.txt'
  - id: out_distance_table
    type:
      - 'null'
      - File
    doc: Tabular distance file written with -O d
    outputBinding:
      glob: '$(inputs.output_distance_table).KPopDMatrix.txt'
  - id: out_metric_table
    type:
      - 'null'
      - File
    doc: Tabular metric file written with -O m
    outputBinding:
      glob: '$(inputs.output_metric_table).KPopMetrics.txt'
  - id: out_summary
    type:
      - 'null'
      - File
    doc: Summary written with -s
    outputBinding:
      glob: '$(inputs.summarize_prefix).KPopSummary.txt'
  - id: out_summary_distances
    type:
      - 'null'
      - File
    doc: Summary written with -S
    outputBinding:
      glob: '$(inputs.summarize_distances_prefix).KPopSummary.txt'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kpop:1.1.1--h9ee0642_1
stdout: kpop_KPopTwistDB.out
