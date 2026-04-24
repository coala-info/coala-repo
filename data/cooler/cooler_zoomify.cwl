cwlVersion: v1.2
class: CommandLineTool
baseCommand: cooler zoomify
label: cooler_zoomify
doc: "Generate a multi-resolution cooler file by coarsening.\n\nTool homepage: https://github.com/open2c/cooler"
inputs:
  - id: cool_path
    type: string
    doc: Path to a COOL file or Cooler URI.
    inputBinding:
      position: 1
  - id: balance
    type:
      - 'null'
      - boolean
    doc: Apply balancing to each zoom level. Off by default.
    inputBinding:
      position: 102
      prefix: --balance
  - id: balance_args
    type:
      - 'null'
      - string
    doc: Additional arguments to pass to cooler balance. To deal with space 
      ambiguity, use quotes to pass multiple arguments, e.g. ``--balance-args 
      '--nproc 8 --ignore-diags 3'``. Note that nproc for balancing must be 
      specified independently of zoomify arguments.
    inputBinding:
      position: 102
      prefix: --balance-args
  - id: base_uri
    type:
      - 'null'
      - type: array
        items: string
    doc: One or more additional base coolers to aggregate from, if needed.
    inputBinding:
      position: 102
      prefix: --base-uri
  - id: chunksize
    type:
      - 'null'
      - int
    doc: Number of pixels allocated to each process
    inputBinding:
      position: 102
      prefix: --chunksize
  - id: field
    type:
      - 'null'
      - type: array
        items: string
    doc: Specify the names of value columns to merge as '<name>'. Repeat the 
      ``--field`` option for each one. Use '<name>:dtype=<dtype>' to specify the
      dtype. Include ',agg=<agg>' to specify an aggregation function different 
      from 'sum'.
    inputBinding:
      position: 102
      prefix: --field
  - id: legacy
    type:
      - 'null'
      - boolean
    doc: Use the legacy layout of integer-labeled zoom levels.
    inputBinding:
      position: 102
      prefix: --legacy
  - id: nproc
    type:
      - 'null'
      - int
    doc: Number of processes to use for batch processing chunks of pixels
    inputBinding:
      position: 102
      prefix: --nproc
  - id: resolutions
    type:
      - 'null'
      - string
    doc: 'Comma-separated list of target resolutions. Use suffixes B or N to specify
      a progression: B for binary (geometric steps of factor 2), N for nice (geometric
      steps of factor 10 interleaved with steps of 2 and 5). Examples: 1000B=1000,2000,4000,8000,...
      1000N=1000,2000,5000,10000,... 5000N=5000,10000,25000,50000,... 4DN is an alias
      for 1000,2000,5000N'
    inputBinding:
      position: 102
      prefix: --resolutions
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: Output file or URI
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cooler:0.10.4--pyhdfd78af_0
