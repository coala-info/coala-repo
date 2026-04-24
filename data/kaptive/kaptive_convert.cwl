cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kaptive
  - convert
label: kaptive_convert
doc: "Convert Kaptive results into different formats\n\nTool homepage: https://kaptive.readthedocs.io/en/latest"
inputs:
  - id: db
    type: string
    doc: Kaptive database path or keyword
    inputBinding:
      position: 1
  - id: json
    type: File
    doc: Kaptive JSON lines file or - for stdin
    inputBinding:
      position: 2
  - id: formats
    type:
      - 'null'
      - type: array
        items: string
    doc: Formats to convert to
    inputBinding:
      position: 3
  - id: loci_filter
    type:
      - 'null'
      - type: array
        items: string
    doc: Space-separated list to filter locus names
    inputBinding:
      position: 104
      prefix: --loci
  - id: locus_regex
    type:
      - 'null'
      - string
    doc: Python regular-expression to match locus names in db source note
    inputBinding:
      position: 104
      prefix: --locus-regex
  - id: no_header
    type:
      - 'null'
      - boolean
    doc: Suppress header line
    inputBinding:
      position: 104
      prefix: --no-header
  - id: plot_format
    type:
      - 'null'
      - string
    doc: Format for locus plots
    inputBinding:
      position: 104
      prefix: --plot-fmt
  - id: regex_filter
    type:
      - 'null'
      - string
    doc: Python regular-expression to select JSON lines
    inputBinding:
      position: 104
      prefix: --regex
  - id: samples_filter
    type:
      - 'null'
      - type: array
        items: string
    doc: Space-separated list to filter sample names
    inputBinding:
      position: 104
      prefix: --samples
  - id: type_regex
    type:
      - 'null'
      - string
    doc: Python regular-expression to match locus types in db source note
    inputBinding:
      position: 104
      prefix: --type-regex
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print debug messages to stderr
    inputBinding:
      position: 104
      prefix: --verbose
outputs:
  - id: tsv_output
    type:
      - 'null'
      - File
    doc: Convert to tabular format in file
    outputBinding:
      glob: $(inputs.tsv_output)
  - id: json_output
    type:
      - 'null'
      - File
    doc: Convert to JSON lines format in file
    outputBinding:
      glob: $(inputs.json_output)
  - id: fna_output
    type:
      - 'null'
      - File
    doc: Convert to locus nucleotide sequences in fasta format
    outputBinding:
      glob: $(inputs.fna_output)
  - id: ffn_output
    type:
      - 'null'
      - File
    doc: Convert to locus gene nucleotide sequences in fasta format
    outputBinding:
      glob: $(inputs.ffn_output)
  - id: faa_output
    type:
      - 'null'
      - File
    doc: Convert to locus gene protein sequences in fasta format
    outputBinding:
      glob: $(inputs.faa_output)
  - id: plot_output_dir
    type:
      - 'null'
      - Directory
    doc: Plot results to "./{assembly}_kaptive_results.{fmt}". Optionally choose
      a directory
    outputBinding:
      glob: $(inputs.plot_output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kaptive:3.1.0--pyhdfd78af_0
