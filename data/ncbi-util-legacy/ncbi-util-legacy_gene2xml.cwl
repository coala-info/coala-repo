cwlVersion: v1.2
class: CommandLineTool
baseCommand: gene2xml
label: ncbi-util-legacy_gene2xml
doc: "Converts NCBI gene information files to XML format.\n\nTool homepage: ftp://ftp.ncbi.nih.gov/toolbox/ncbi_tools/"
inputs:
  - id: combine_agc_to_binary_ags_then_gzip
    type:
      - 'null'
      - string
    doc: Combine .agc -> binary .ags, then gzip (T or F)
    inputBinding:
      position: 101
      prefix: -z
  - id: combine_agc_to_text_ags_for_testing
    type:
      - 'null'
      - string
    doc: Combine .agc -> text .ags (for testing) (T or F)
    inputBinding:
      position: 101
      prefix: -y
  - id: extract_ags_to_text_agc
    type:
      - 'null'
      - string
    doc: Extract .ags -> text .agc (T or F)
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
      - string
    doc: File is Binary (T or F)
    inputBinding:
      position: 101
      prefix: -b
  - id: is_compressed
    type:
      - 'null'
      - string
    doc: File is Compressed (T or F)
    inputBinding:
      position: 101
      prefix: -c
  - id: log_processing
    type:
      - 'null'
      - string
    doc: Log Processing (T or F)
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
  - id: output_file_path
    type:
      - 'null'
      - string
    doc: Single Output File [File Out]  Optional
    inputBinding:
      position: 102
      prefix: -o
  - id: path_for_results_path
    type:
      - 'null'
      - string
    doc: Path for Results [String]  Optional
    inputBinding:
      position: 103
      prefix: -r
outputs:
  - id: path_for_results
    type:
      - 'null'
      - Directory
    doc: Path for Results
    outputBinding:
      glob: $(inputs.path_for_results_path)
  - id: output_file
    type:
      - 'null'
      - File
    doc: Single Output File
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: |
      ${
        return inputs.path_for_results_path ? [{entryname: inputs.path_for_results_path, entry: {class: 'Directory', listing: []}, writable: true}] : [];
      }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ncbi-util-legacy:6.1--h0e27e84_3
