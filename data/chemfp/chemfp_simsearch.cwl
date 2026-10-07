cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - simsearch
label: chemfp_simsearch
doc: "Search an FPS or FPB file for similar fingerprints\n\nTool homepage: https://chemfp.com"
inputs:
  - id: target_filename
    type: File
    doc: target filename
    inputBinding:
      position: 10
  - id: k_nearest
    type:
      - 'null'
      - string
    doc: select the k nearest neighbors (use 'all' for all neighbors)
    inputBinding:
      position: 1
      prefix: --k-nearest
  - id: threshold
    type:
      - 'null'
      - float
    doc: minimum similarity score threshold
    inputBinding:
      position: 1
      prefix: --threshold
  - id: queries
    type:
      - 'null'
      - File
    doc: filename containing the query fingerprints
    inputBinding:
      position: 1
      prefix: --queries
  - id: nxn
    type:
      - 'null'
      - boolean
    doc: use the targets as the queries, and exclude the self-similarity term
    inputBinding:
      position: 1
      prefix: --NxN
  - id: query
    type:
      - 'null'
      - string
    doc: "query as a structure record (default format: 'smi')"
    inputBinding:
      position: 1
      prefix: --query
  - id: hex_query
    type:
      - 'null'
      - string
    doc: query in hex
    inputBinding:
      position: 1
      prefix: --hex-query
  - id: query_id
    type:
      - 'null'
      - string
    doc: "id for the query or hex-query (default: 'Query1')"
    inputBinding:
      position: 1
      prefix: --query-id
  - id: query_structures
    type:
      - 'null'
      - File
    doc: read query structures from this file
    inputBinding:
      position: 1
      prefix: --query-structures
  - id: query_format
    type:
      - 'null'
      - string
    doc: input query format (default uses the file extension, else 'fps' for 
      --queries and 'smi' for query structures)
    inputBinding:
      position: 1
      prefix: --query-format
  - id: target_format
    type:
      - 'null'
      - string
    doc: input target format (default uses the file extension, else 'fps')
    inputBinding:
      position: 1
      prefix: --target-format
  - id: id_tag
    type:
      - 'null'
      - string
    doc: tag containing the record id if --query-structures is an SD file
    inputBinding:
      position: 1
      prefix: --id-tag
  - id: errors
    type:
      - 'null'
      - string
    doc: how should structure parse errors be handled? (strict, report, ignore;
      default=ignore)
    inputBinding:
      position: 1
      prefix: --errors
  - id: output_filename
    type: string
    doc: output filename
    default: simsearch_hits.txt
    inputBinding:
      position: 1
      prefix: --output
  - id: count
    type:
      - 'null'
      - boolean
    doc: report counts
    inputBinding:
      position: 1
      prefix: --count
  - id: batch_size
    type:
      - 'null'
      - int
    doc: batch size
    inputBinding:
      position: 1
      prefix: --batch-size
  - id: scan
    type:
      - 'null'
      - boolean
    doc: scan the file to find matches (low memory overhead)
    inputBinding:
      position: 1
      prefix: --scan
  - id: memory
    type:
      - 'null'
      - boolean
    doc: build and search an in-memory data structure (faster for multiple 
      queries)
    inputBinding:
      position: 1
      prefix: --memory
  - id: times
    type:
      - 'null'
      - boolean
    doc: report load and execution times to stderr
    inputBinding:
      position: 1
      prefix: --times
outputs:
  - id: hits
    type: File
    doc: similarity search results
    outputBinding:
      glob: $(inputs.output_filename)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chemfp:1.6.1--py27h9801fc8_2
