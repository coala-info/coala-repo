cwlVersion: v1.2
class: CommandLineTool
baseCommand: [nextclade, sort]
label: nextclade_js_sort
doc: "Sort sequences according to the Nextclade dataset they match.

Tool homepage: https://github.com/nextstrain/nextclade"
inputs:
  - id: input_fastas
    type:
      - 'null'
      - type: array
        items: File
    doc: "Path to one or multiple FASTA files with input sequences"
    inputBinding:
      position: 100
  - id: input_minimizer_index_json
    type:
      - 'null'
      - File
    doc: "Path to input minimizer index JSON file."
    inputBinding:
      position: 10
      prefix: --input-minimizer-index-json
  - id: output_dir
    type:
      - 'null'
      - string
    doc: "Path to output directory"
    inputBinding:
      position: 11
      prefix: --output-dir
  - id: output_path
    type:
      - 'null'
      - string
    doc: "Template string for the file path to output sorted sequences. A separate file will be generated per dataset."
    inputBinding:
      position: 12
      prefix: --output-path
  - id: output_results_tsv
    type:
      - 'null'
      - string
    doc: "Path to output results TSV file"
    inputBinding:
      position: 13
      prefix: --output-results-tsv
  - id: min_score
    type:
      - 'null'
      - float
    doc: "Minimum value of the score being considered for a detection"
    inputBinding:
      position: 14
      prefix: --min-score
  - id: min_hits
    type:
      - 'null'
      - int
    doc: "Minimum number of the index hits required for a detection"
    inputBinding:
      position: 15
      prefix: --min-hits
  - id: max_score_gap
    type:
      - 'null'
      - float
    doc: "Maximum score difference between two adjacent dataset matches, after which the less fitting datasets are not considered."
    inputBinding:
      position: 16
      prefix: --max-score-gap
  - id: max_iter
    type:
      - 'null'
      - int
    doc: "Maximum number of iteration when partitioning sequences into matching datasets"
    inputBinding:
      position: 17
      prefix: --max-iter
  - id: all_matches
    type:
      - 'null'
      - boolean
    doc: "Whether to consider all datasets"
    inputBinding:
      position: 18
      prefix: --all-matches
  - id: global
    type:
      - 'null'
      - boolean
    doc: "Whether to perform global search"
    inputBinding:
      position: 19
      prefix: --global
  - id: jobs
    type:
      - 'null'
      - int
    doc: "Number of processing jobs. If not specified, all available CPU threads will be used"
    inputBinding:
      position: 20
      prefix: --jobs
  - id: server
    type:
      - 'null'
      - string
    doc: "Use custom dataset server."
    inputBinding:
      position: 21
      prefix: --server
  - id: proxy
    type:
      - 'null'
      - string
    doc: "Pass all traffic over proxy server. HTTP, HTTPS, and SOCKS5 proxies are supported"
    inputBinding:
      position: 22
      prefix: --proxy
  - id: proxy_user
    type:
      - 'null'
      - string
    doc: "Username for basic authentication on proxy server, if applicable. Only valid when `--proxy` is also supplied. `--proxy-user` and `--proxy-pass` must be either both specified or both omitted"
    inputBinding:
      position: 23
      prefix: --proxy-user
  - id: proxy_pass
    type:
      - 'null'
      - string
    doc: "Password for basic authentication on proxy server, if applicable. Only valid when `--proxy` is also supplied. `--proxy-user` and `--proxy-pass` must be either both specified or both omitted"
    inputBinding:
      position: 24
      prefix: --proxy-pass
  - id: extra_ca_certs
    type:
      - 'null'
      - string
    doc: "Path to extra CA certificates as a PEM bundle."
    inputBinding:
      position: 25
      prefix: --extra-ca-certs
outputs:
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Directory with sorted sequences.
    outputBinding:
      glob: |-
        ${ return inputs.output_dir ? inputs.output_dir : null; }
  - id: results_tsv
    type:
      - 'null'
      - File
    doc: Results TSV file.
    outputBinding:
      glob: |-
        ${ return inputs.output_results_tsv ? inputs.output_results_tsv : null; }
  - id: sorted_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Sorted sequence files written with the output_path template.
    outputBinding:
      glob: |-
        ${ return inputs.output_path ? inputs.output_path.replace('{name}', '*') : null; }
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nextclade:3.18.1--h9ee0642_0
stdout: nextclade_js_sort.out
