cwlVersion: v1.2
class: CommandLineTool
baseCommand: gene2xml
label: ncbi-util-legacy_gene2xml
doc: "Converts NCBI gene information files to XML format.\n\nTool homepage: ftp://ftp.ncbi.nih.gov/toolbox/ncbi_tools/"
inputs:
  - id: combine_agc_to_binary_ags_then_gzip
    type:
      - 'null'
      - boolean
    doc: Combine .agc -> binary .ags, then gzip
    inputBinding:
      position: 101
      prefix: -z
  - id: combine_agc_to_text_ags_for_testing
    type:
      - 'null'
      - boolean
    doc: Combine .agc -> text .ags (for testing)
    inputBinding:
      position: 101
      prefix: -y
  - id: extract_ags_to_text_agc
    type:
      - 'null'
      - boolean
    doc: Extract .ags -> text .agc
    inputBinding:
      position: 101
      prefix: -x
  - id: input_file
    type:
      - 'null'
      - File
    doc: Single Input File
    inputBinding:
      position: 101
      prefix: -i
  - id: is_binary
    type:
      - 'null'
      - boolean
    doc: File is Binary
    inputBinding:
      position: 101
      prefix: -b
  - id: is_compressed
    type:
      - 'null'
      - boolean
    doc: File is Compressed
    inputBinding:
      position: 101
      prefix: -c
  - id: log_processing
    type:
      - 'null'
      - boolean
    doc: Log Processing
    inputBinding:
      position: 101
      prefix: -l
  - id: path_to_files
    type:
      - 'null'
      - Directory
    doc: Path to Files
    inputBinding:
      position: 101
      prefix: -p
  - id: taxon_id_filter
    type:
      - 'null'
      - int
    doc: Taxon ID to Filter
    inputBinding:
      position: 101
      prefix: -t
outputs:
  - id: path_for_results
    type:
      - 'null'
      - Directory
    doc: Path for Results
    outputBinding:
      glob: $(inputs.path_for_results)
  - id: output_file
    type:
      - 'null'
      - File
    doc: Single Output File
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ncbi-util-legacy:6.1--h0e27e84_3
