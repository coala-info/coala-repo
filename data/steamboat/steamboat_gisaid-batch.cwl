cwlVersion: v1.2
class: CommandLineTool
baseCommand: gisaid-batch
label: steamboat_gisaid-batch
doc: "Format data for GISAID submission.\n\nTool homepage: https://github.com/rpetit3/steamboat-py"
inputs:
  - id: assemblies
    type: Directory
    doc: Directory of FASTA assemblies to be uploaded
    inputBinding:
      position: 101
      prefix: --assemblies
  - id: extension
    type:
      - 'null'
      - string
    doc: The extension used for assemblies.
    inputBinding:
      position: 101
      prefix: --extension
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite existing reports
    inputBinding:
      position: 101
      prefix: --force
  - id: max_ns
    type:
      - 'null'
      - int
    doc: Minimum percent identity to count a hit
    inputBinding:
      position: 101
      prefix: --max-ns
  - id: metadata
    type: string
    doc: A TSV or CSV file of metadata associated with input samples
    inputBinding:
      position: 101
      prefix: --metadata
  - id: min_coverage
    type:
      - 'null'
      - float
    doc: Minimum percent coverage to count a hit
    inputBinding:
      position: 101
      prefix: --min-coverage
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Directory to write output
    inputBinding:
      position: 101
      prefix: --outdir
  - id: pipeline
    type:
      - 'null'
      - string
    doc: Pipeline used for analysis.
    inputBinding:
      position: 101
      prefix: --pipeline
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix to use for output files
    inputBinding:
      position: 101
      prefix: --prefix
  - id: results
    type: string
    doc: A CSV or TSV file with the results of pipeline analysis
    inputBinding:
      position: 101
      prefix: --results
  - id: sample_prefix
    type:
      - 'null'
      - string
    doc: Add this to the beginning on sample names in the metadata file.
    inputBinding:
      position: 101
      prefix: --sample-prefix
  - id: sequencer
    type: string
    doc: Sequencer used to generate sequences.
    inputBinding:
      position: 101
      prefix: --sequencer
  - id: silent
    type:
      - 'null'
      - boolean
    doc: Only critical errors will be printed
    inputBinding:
      position: 101
      prefix: --silent
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Increase the verbosity of output
    inputBinding:
      position: 101
      prefix: --verbose
  - id: yaml
    type: string
    doc: A YAML formatted file containing constant information for GISAID 
      fields.
    inputBinding:
      position: 101
      prefix: --yaml
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/steamboat:1.1.1--pyhdfd78af_0
stdout: steamboat_gisaid-batch.out
