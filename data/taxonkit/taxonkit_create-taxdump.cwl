cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - taxonkit
  - create-taxdump
label: taxonkit_create-taxdump
doc: "Create NCBI-style taxdump files for custom taxonomy, e.g., GTDB and ICTV\n\nTool homepage: https://github.com/shenwei356/taxonkit"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: 'Tab-delimited taxonomy file(s), one column per rank (or GTDB taxonomy files with gtdb)'
    inputBinding:
      position: 1
  - id: field_accession
    type:
      - 'null'
      - int
    doc: 'Field index of assembly accession (genome ID), for outputting taxid.map'
    inputBinding:
      position: 101
      prefix: --field-accession
  - id: field_accession_as_subspecies
    type:
      - 'null'
      - boolean
    doc: 'Treat the accession as subspecies rank'
    inputBinding:
      position: 101
      prefix: --field-accession-as-subspecies
  - id: field_accession_re
    type:
      - 'null'
      - string
    doc: 'Regular expression to extract assembly accession (default ''^(.+)$'')'
    inputBinding:
      position: 101
      prefix: --field-accession-re
  - id: force
    type:
      - 'null'
      - boolean
    doc: 'Overwrite existing output directory'
    inputBinding:
      position: 101
      prefix: --force
  - id: gtdb
    type:
      - 'null'
      - boolean
    doc: 'Input files are GTDB taxonomy file'
    inputBinding:
      position: 101
      prefix: --gtdb
  - id: gtdb_re_subs
    type:
      - 'null'
      - string
    doc: 'Regular expression to extract assembly accession as the subspecies'
    inputBinding:
      position: 101
      prefix: --gtdb-re-subs
  - id: line_chunk_size
    type:
      - 'null'
      - int
    doc: 'Number of lines to process for each thread (default 5000)'
    inputBinding:
      position: 101
      prefix: --line-chunk-size
  - id: null_values
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Null value of taxa (default empty string, NULL, NA)'
    inputBinding:
      position: 101
      prefix: --null
      itemSeparator: ','
  - id: old_taxdump_dir
    type:
      - 'null'
      - Directory
    doc: 'Taxdump directory of the previous version, for generating merged.dmp and delnodes.dmp'
    inputBinding:
      position: 101
      prefix: --old-taxdump-dir
  - id: out_dir
    type:
      - 'null'
      - string
    doc: 'Output directory'
    inputBinding:
      position: 101
      prefix: --out-dir
  - id: rank_names
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Names of all ranks, leave it empty to use the (lowercase) first row of input as rank names'
    inputBinding:
      position: 101
      prefix: --rank-names
      itemSeparator: ','
  - id: data_dir
    type:
      - 'null'
      - Directory
    doc: 'Directory containing nodes.dmp and names.dmp (NCBI taxdump files)'
    inputBinding:
      position: 101
      prefix: --data-dir
  - id: line_buffered
    type:
      - 'null'
      - boolean
    doc: 'Use line buffering on output, i.e., immediately writing to stdin/file for every line of output'
    inputBinding:
      position: 101
      prefix: --line-buffered
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of CPUs. 4 is enough'
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: 'Print verbose information'
    inputBinding:
      position: 101
      prefix: --verbose
  - id: out_file_path
    type:
      - 'null'
      - string
    doc: 'Output file name (suffix .gz for gzipped output)'
    inputBinding:
      position: 102
      prefix: --out-file
outputs:
  - id: out_file
    type:
      - 'null'
      - File
    doc: Output file
    outputBinding:
      glob: $(inputs.out_file_path)
  - id: out_dir_dir
    type:
      - 'null'
      - Directory
    doc: Directory with the new taxdump files
    outputBinding:
      glob: $(inputs.out_dir)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/taxonkit:0.20.0--h9ee0642_1
