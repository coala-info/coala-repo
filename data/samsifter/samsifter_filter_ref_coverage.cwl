cwlVersion: v1.2
class: CommandLineTool
baseCommand: filter_ref_coverage
label: samsifter_filter_ref_coverage
doc: "Filters reference accessions exceeding a Gini Index threshold.\n\nTool homepage: https://github.com/BioInf-Wuerzburg/SamSifter"
inputs:
  - id: input_sam
    type: File
    doc: "SAM file to be analysed; it is read from standard input, because the -i option of this tool crashes"
  - id: discard
    type:
      - 'null'
      - int
    doc: "keep or discard entries passing the filter criteria? (0 = discard, 1 = keep)"
    inputBinding:
      position: 2
      prefix: --discard
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "print additional information to STDERR"
    inputBinding:
      position: 3
      prefix: -v
  - id: debug
    type:
      - 'null'
      - boolean
    doc: "print debug messages to STDERR"
    inputBinding:
      position: 4
      prefix: -d
  - id: modify
    type:
      - 'null'
      - boolean
    doc: "modify header by adding PG record"
    inputBinding:
      position: 5
      prefix: -m
  - id: read_lengths
    type:
      - 'null'
      - boolean
    doc: "analyze read length distributions"
    inputBinding:
      position: 6
      prefix: -r
  - id: covered
    type:
      - 'null'
      - boolean
    doc: "covered bases only, ignore uncovered bases"
    inputBinding:
      position: 7
      prefix: -c
  - id: plot
    type:
      - 'null'
      - boolean
    doc: "plot distribution(s)"
    inputBinding:
      position: 8
      prefix: -p
  - id: lci_arg
    type:
      - 'null'
      - float
    doc: "fraction of mean coverage to use for LCI integration"
    inputBinding:
      position: 9
      prefix: -l
  - id: stats_file
    type:
      - 'null'
      - string
    doc: "override filename for tab-separated statistics"
    inputBinding:
      position: 10
      prefix: -s
  - id: min_cov
    type:
      - 'null'
      - float
    doc: "minimum average coverage"
    inputBinding:
      position: 11
      prefix: --min_cov
  - id: max_cov
    type:
      - 'null'
      - float
    doc: "maximum average coverage"
    inputBinding:
      position: 12
      prefix: --max_cov
  - id: min_lci
    type:
      - 'null'
      - float
    doc: "minimum LCI"
    inputBinding:
      position: 13
      prefix: --min_lci
  - id: max_lci
    type:
      - 'null'
      - float
    doc: "maximum LCI"
    inputBinding:
      position: 14
      prefix: --max_lci
  - id: min_gini
    type:
      - 'null'
      - float
    doc: "minimum Gini coefficient"
    inputBinding:
      position: 15
      prefix: --min_gini
  - id: max_gini
    type:
      - 'null'
      - float
    doc: "maximum Gini coefficient"
    inputBinding:
      position: 16
      prefix: --max_gini
outputs:
  - id: stdout
    type: stdout
    doc: Standard output (the processed SAM)
  - id: stderr
    type: stderr
    doc: Standard error (log messages)
  - id: extra_files
    type:
      type: array
      items: File
    doc: Statistics and plot files written by the tool
    outputBinding:
      glob: "$(inputs.stats_file ? [inputs.stats_file, '*.png', '*.pdf', '*.svg'] : ['*.csv', '*.png', '*.pdf', '*.svg'])"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/samsifter:1.0.0--py35h3978dc7_3
stdout: samsifter_filter_ref_coverage.out
stderr: samsifter_filter_ref_coverage.err
stdin: $(inputs.input_sam.path)
