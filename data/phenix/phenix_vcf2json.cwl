cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phenix.py
  - vcf2json
label: phenix_vcf2json
doc: "Converts the positions of variants and ignored/missing positions in either a raw or filtered VCF file to a json string and writes it to a file. The json contains 6 arrays for each chromosome in the VCF file: g_positions, a_positions, t_positions, c_positions, gap_positions, n_positions.\n\nTool homepage: https://github.com/phe-bioinformatics/PHEnix"
inputs:
  - id: input
    type: File
    doc: "path to a VCF file"
    inputBinding:
      position: 1
      prefix: --input
  - id: output_file_prefix
    type:
      - 'null'
      - string
    doc: "Path to the json output file (without file extension). Default: sample_name"
    inputBinding:
      position: 2
      prefix: --output_file_prefix
  - id: nozip
    type:
      - 'null'
      - boolean
    doc: "Do not gzip json when writing file. (default: Yes, gzip it.)"
    inputBinding:
      position: 3
      prefix: --nozip
  - id: vcf_is_filtered
    type:
      - 'null'
      - boolean
    doc: "Required: Confirm that the input vcf is filtered. It is strongly recommended to filter the file with Phenix using the same parameters that are used throughout the database this json file is meant for."
    inputBinding:
      position: 4
      prefix: --vcf_is_filtered
  - id: summary_info
    type:
      - 'null'
      - boolean
    doc: "Print summary of the json string"
    inputBinding:
      position: 5
      prefix: --summary_info
outputs:
  - id: stdout
    type: stdout
    doc: "Standard output (the summary when summary_info is set)"
  - id: json_files
    type:
      type: array
      items: File
    doc: "The json file written, gzipped unless nozip is set"
    outputBinding:
      glob: '*.json*'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phenix:1.4.1a--py27h24bf2e0_0
stdout: phenix_vcf2json.out
