cwlVersion: v1.2
class: CommandLineTool
baseCommand: var pubs summarize-variants
label: varpubs_summarize-variants
doc: "SummarizeArgs ['args']: Command-line arguments for summarizing PubMed articles
  related to variants.\n\nTool homepage: https://github.com/koesterlab/varpubs"
inputs:
  - id: api_key
    type:
      - 'null'
      - string
    doc: Hugging Face API token for model access.
    default: ''
    inputBinding:
      position: 101
      prefix: --api_key
  - id: cache
    type:
      - 'null'
      - type: array
        items: Directory
    doc: Path to cache file to look up summary results instead of LLM usage
    inputBinding:
      position: 101
      prefix: --cache
  - id: db_path
    type: Directory
    doc: Path to the existing DuckDB database file.
    inputBinding:
      position: 101
      prefix: --db_path
  - id: judges
    type:
      - 'null'
      - type: array
        items: string
    doc: List of judges for ranking articles (e.g., "therapy relevance"1)
    inputBinding:
      position: 101
      prefix: --judges
  - id: llm_url
    type: string
    doc: Base URL for LLM API (Must follow the openai API format)
    inputBinding:
      position: 101
      prefix: --llm_url
  - id: model
    type:
      - 'null'
      - string
    doc: 'The LLM model used for summarization (default: medgemma-27b-it).'
    default: medgemma-27b-it
    inputBinding:
      position: 101
      prefix: --model
  - id: role
    type:
      - 'null'
      - string
    doc: 'The professional role or perspective the LLM should take (default: physician).'
    default: physician
    inputBinding:
      position: 101
      prefix: --role
  - id: species
    type:
      - 'null'
      - string
    doc: 'Species for variant annotation (default: human).'
    default: human
    inputBinding:
      position: 101
      prefix: --species
  - id: vcf_path
    type: File
    doc: A single annotated VCF file with variant terms.
    inputBinding:
      position: 101
      prefix: --vcf_path
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Optional path to save the final variant summary file (CSV).
    outputBinding:
      glob: $(inputs.output)
  - id: output_cache
    type:
      - 'null'
      - Directory
    doc: Optional path to save the cache file for storing new summary results.
    outputBinding:
      glob: $(inputs.output_cache)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/varpubs:0.5.0--pyhdfd78af_0
