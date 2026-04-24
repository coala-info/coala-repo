cwlVersion: v1.2
class: CommandLineTool
baseCommand: bio-vcf
label: bio-vcf
doc: "Vcf parser\n\nTool homepage: https://github.com/vcflib/bio-vcf"
inputs:
  - id: filename
    type: File
    doc: Input VCF filename
    inputBinding:
      position: 1
  - id: add_filter
    type:
      - 'null'
      - string
    doc: Set/add filter field to name
    inputBinding:
      position: 102
      prefix: --add-filter
  - id: add_header_tag
    type:
      - 'null'
      - boolean
    doc: Add bio-vcf status tag to header output
    inputBinding:
      position: 102
      prefix: --add-header-tag
  - id: bedfile
    type:
      - 'null'
      - File
    doc: Filter on BED elements
    inputBinding:
      position: 102
      prefix: --bed
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Show debug messages and keep intermediate output
    inputBinding:
      position: 102
      prefix: --debug
  - id: efilter
    type:
      - 'null'
      - string
    doc: Exclude filter
    inputBinding:
      position: 102
      prefix: --efilter
  - id: efilter_cmd
    type:
      - 'null'
      - string
    doc: Exclude filter
    inputBinding:
      position: 102
      prefix: --efilter
  - id: efilter_samples
    type:
      - 'null'
      - string
    doc: Exclude set - overrides exclude set
    inputBinding:
      position: 102
      prefix: --efilter-samples
  - id: eval
    type:
      - 'null'
      - string
    doc: Evaluate command on each record
    inputBinding:
      position: 102
      prefix: --eval
  - id: eval_once
    type:
      - 'null'
      - string
    doc: Evaluate command once (usually for header info)
    inputBinding:
      position: 102
      prefix: --eval-once
  - id: filter
    type:
      - 'null'
      - string
    doc: Evaluate filter on each record
    inputBinding:
      position: 102
      prefix: --filter
  - id: id
    type:
      - 'null'
      - string
    doc: Identifier
    inputBinding:
      position: 102
      prefix: --id
  - id: ifilter
    type:
      - 'null'
      - string
    doc: Include filter
    inputBinding:
      position: 102
      prefix: --ifilter
  - id: ifilter_cmd
    type:
      - 'null'
      - string
    doc: Include filter
    inputBinding:
      position: 102
      prefix: --ifilter
  - id: ifilter_samples
    type:
      - 'null'
      - string
    doc: Include set - implicitely defines exclude set
    inputBinding:
      position: 102
      prefix: --ifilter-samples
  - id: ignore_missing
    type:
      - 'null'
      - boolean
    doc: Ignore missing data
    inputBinding:
      position: 102
      prefix: --ignore-missing
  - id: names
    type:
      - 'null'
      - boolean
    doc: Output sample names
    inputBinding:
      position: 102
      prefix: --names
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Multi-core version (default ALL)
    inputBinding:
      position: 102
      prefix: --num-threads
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Run quietly
    inputBinding:
      position: 102
      prefix: --quiet
  - id: rdf
    type:
      - 'null'
      - boolean
    doc: Generate Turtle RDF (also check out --template!)
    inputBinding:
      position: 102
      prefix: --rdf
  - id: rewrite
    type:
      - 'null'
      - string
    doc: Rewrite INFO
    inputBinding:
      position: 102
      prefix: --rewrite
  - id: samples
    type:
      - 'null'
      - string
    doc: Output selected samples
    inputBinding:
      position: 102
      prefix: --samples
  - id: set_header
    type:
      - 'null'
      - string
    doc: Set a special tab delimited output header (#samples expands to sample 
      names)
    inputBinding:
      position: 102
      prefix: --set-header
  - id: seval
    type:
      - 'null'
      - string
    doc: Evaluate command on each sample
    inputBinding:
      position: 102
      prefix: --seval
  - id: sfilter
    type:
      - 'null'
      - string
    doc: Evaluate filter on each sample
    inputBinding:
      position: 102
      prefix: --sfilter
  - id: sfilter_samples
    type:
      - 'null'
      - string
    doc: Filter on selected samples (e.g., 0,1
    inputBinding:
      position: 102
      prefix: --sfilter-samples
  - id: skip_header
    type:
      - 'null'
      - boolean
    doc: Do not output VCF header info
    inputBinding:
      position: 102
      prefix: --skip-header
  - id: statistics
    type:
      - 'null'
      - boolean
    doc: Output statistics
    inputBinding:
      position: 102
      prefix: --statistics
  - id: tags
    type:
      - 'null'
      - string
    doc: Add tags
    inputBinding:
      position: 102
      prefix: --tags
  - id: template
    type:
      - 'null'
      - string
    doc: Use ERB template for output
    inputBinding:
      position: 102
      prefix: --template
  - id: thread_lines
    type:
      - 'null'
      - int
    doc: Fork thread on num lines (default 40000)
    inputBinding:
      position: 102
      prefix: --thread-lines
  - id: timeout
    type:
      - 'null'
      - int
    doc: Timeout waiting for thread to complete (default 180)
    inputBinding:
      position: 102
      prefix: --timeout
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Run verbosely
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bio-vcf:0.9.5--hdfd78af_0
stdout: bio-vcf.out
