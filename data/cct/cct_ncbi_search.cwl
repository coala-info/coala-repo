cwlVersion: v1.2
class: CommandLineTool
baseCommand: ncbi_search
label: cct_ncbi_search
doc: "Uses NCBI's eSearch to download collections of sequences.\n\nTool homepage: https://github.com/paulstothard/cgview_comparison_tool"
inputs:
  - id: query
    type: string
    doc: Raw query text.
    inputBinding:
      position: 1
      prefix: -q
  - id: output
    type: string
    doc: Output file to create. If the split option is given, this should be a 
      directory, where the returned records will be written.
    inputBinding:
      position: 1
      prefix: -o
  - id: database
    type: string
    doc: Name of the NCBI database to search, such as 'nucleotide', 'protein', or
      'gene'.
    inputBinding:
      position: 1
      prefix: -d
  - id: return_type
    type: string
    doc: The type of information requested. For sequences 'fasta' is often 
      used.
    inputBinding:
      position: 1
      prefix: -r
  - id: split
    type:
      - 'null'
      - boolean
    doc: Return each record as a separate file named after the accession of the
      record. Only works if the return_type is 'gb' or 'gbwithparts'.
    inputBinding:
      position: 2
      prefix: -s
  - id: max_records
    type:
      - 'null'
      - int
    doc: The maximum number of records to return (default is to return all 
      matches satisfying the query).
    inputBinding:
      position: 2
      prefix: -m
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Provide progress messages.
    inputBinding:
      position: 2
      prefix: -v
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file (when split is not set)
    outputBinding:
      glob: "$(inputs.split ? [] : inputs.output)"
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Output directory with one file per record (when split is set)
    outputBinding:
      glob: "$(inputs.split ? inputs.output : [])"
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/cct:v20170919dfsg-1-deb_cv1
