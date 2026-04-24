cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - taxonkit
  - create-taxdump
label: taxonkit_create-taxdump
doc: "Create NCBI-style taxdump files for custom taxonomy, e.g., GTDB and ICTV\n\n\
  Tool homepage: https://github.com/shenwei356/taxonkit"
inputs:
  - id: data_dir
    type:
      - 'null'
      - Directory
    doc: directory containing nodes.dmp and names.dmp
    inputBinding:
      position: 101
      prefix: --data-dir
  - id: field_accession
    type:
      - 'null'
      - int
    doc: field index of assembly accession (genome ID), for outputting taxid.map
    inputBinding:
      position: 101
      prefix: --field-accession
  - id: field_accession_as_subspecies
    type:
      - 'null'
      - boolean
    doc: treate the accession as subspecies rank
    inputBinding:
      position: 101
      prefix: --field-accession-as-subspecies
  - id: field_accession_re
    type:
      - 'null'
      - string
    doc: regular expression to extract assembly accession
    inputBinding:
      position: 101
      prefix: --field-accession-re
  - id: force
    type:
      - 'null'
      - boolean
    doc: overwrite existing output directory
    inputBinding:
      position: 101
      prefix: --force
  - id: gtdb
    type:
      - 'null'
      - boolean
    doc: input files are GTDB taxonomy file
    inputBinding:
      position: 101
      prefix: --gtdb
  - id: gtdb_re_subs
    type:
      - 'null'
      - string
    doc: regular expression to extract assembly accession as the subspecies
    inputBinding:
      position: 101
      prefix: --gtdb-re-subs
  - id: line_buffered
    type:
      - 'null'
      - boolean
    doc: use line buffering on output, i.e., immediately writing to stdin/file 
      for every line of output
    inputBinding:
      position: 101
      prefix: --line-buffered
  - id: line_chunk_size
    type:
      - 'null'
      - int
    doc: number of lines to process for each thread, and 4 threads is enough.
    inputBinding:
      position: 101
      prefix: --line-chunk-size
  - id: null_strings
    type:
      - 'null'
      - string
    doc: null value of taxa
    inputBinding:
      position: 101
      prefix: --null
  - id: old_taxdump_dir
    type:
      - 'null'
      - string
    doc: taxdump directory of the previous version, for generating merged.dmp 
      and delnodes.dmp
    inputBinding:
      position: 101
      prefix: --old-taxdump-dir
  - id: out_dir
    type:
      - 'null'
      - Directory
    doc: output directory
    inputBinding:
      position: 101
      prefix: --out-dir
  - id: rank_names
    type:
      - 'null'
      - type: array
        items: string
    doc: names of all ranks, leave it empty to use the (lowercase) first row of 
      input as rank names
    inputBinding:
      position: 101
      prefix: --rank-names
  - id: threads
    type:
      - 'null'
      - int
    doc: number of CPUs. 4 is enough
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: print verbose information
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: out_file
    type:
      - 'null'
      - File
    doc: out file ("-" for stdout, suffix .gz for gzipped out)
    outputBinding:
      glob: $(inputs.out_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/taxonkit:0.20.0--h9ee0642_1
