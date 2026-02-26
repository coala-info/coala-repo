cwlVersion: v1.2
class: CommandLineTool
baseCommand: sierrapy_patterns
label: sierrapy_patterns
doc: "Run drug resistance and other analysis for one or more files contains lines
  of PR, RT and/or IN mutations based on HIV-1 type B consensus. Each line is treated
  as a unique pattern.\n\nTool homepage: https://github.com/hivdb/sierra-client/tree/master/python"
inputs:
  - id: patterns
    type:
      type: array
      items: string
    doc: One or more files containing lines of PR, RT and/or IN mutations.
    inputBinding:
      position: 1
  - id: no_sharding
    type:
      - 'null'
      - boolean
    doc: Save JSON result to a single file.
    inputBinding:
      position: 102
      prefix: --no-sharding
  - id: query_file
    type:
      - 'null'
      - File
    doc: A file contains GraphQL fragment definition on `MutationsAnalysis`.
    inputBinding:
      position: 102
      prefix: --query
  - id: sharding
    type:
      - 'null'
      - int
    doc: Save JSON result files per n patterns.
    inputBinding:
      position: 102
      prefix: --sharding
  - id: skip
    type:
      - 'null'
      - int
    doc: Skip first n patterns.
    inputBinding:
      position: 102
      prefix: --skip
  - id: step
    type:
      - 'null'
      - int
    doc: Send batch requests per n patterns.
    inputBinding:
      position: 102
      prefix: --step
  - id: total
    type:
      - 'null'
      - int
    doc: Total number of patterns; specify one to visualize a progress bar.
    inputBinding:
      position: 102
      prefix: --total
  - id: ugly
    type:
      - 'null'
      - boolean
    doc: Output compressed JSON result.
    inputBinding:
      position: 102
      prefix: --ugly
  - id: url
    type:
      - 'null'
      - string
    doc: URL of Sierra GraphQL Web Service.
    default: production URL varied by virus
    inputBinding:
      position: 102
      prefix: --url
  - id: virus
    type:
      - 'null'
      - string
    doc: Specify virus to be analyzed.
    default: HIV1
    inputBinding:
      position: 102
      prefix: --virus
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: File path to store the JSON result.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sierrapy:0.4.3--pyh7cba7a3_0
