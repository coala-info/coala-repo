cwlVersion: v1.2
class: CommandLineTool
baseCommand: COGreadblast
label: cogtriangles_COGreadblast
doc: "Processes and filters BLAST results for COG analysis, including options for
  handling non-contiguous blocks and reciprocal hits.\n\nTool homepage: https://ftp.ncbi.nih.gov/pub/wolf/COGs/COGsoft/"
inputs:
  - id: aggregate_mode
    type:
      - 'null'
      - boolean
    doc: append/aggregate mode (use if BLAST hits from one query do not form a 
      contiguous block in the BLAST output files)
    inputBinding:
      position: 101
      prefix: -a
  - id: converted_data_dir
    type:
      - 'null'
      - Directory
    doc: directory for converted data (must contain hash.csv)
    inputBinding:
      position: 101
      prefix: -d=
      separate: false
  - id: evalue_threshold
    type:
      - 'null'
      - float
    doc: e-value threshold for BLAST hits
    inputBinding:
      position: 101
      prefix: -e=
      separate: false
  - id: query_id_index
    type:
      - 'null'
      - int
    doc: index of the sequence ID field for the BLAST query
    inputBinding:
      position: 101
      prefix: -q=
      separate: false
  - id: self_blast_dir
    type:
      - 'null'
      - Directory
    doc: directory with the self-BLAST results
    inputBinding:
      position: 101
      prefix: -s=
      separate: false
  - id: symmetrize_hits
    type:
      - 'null'
      - boolean
    doc: symmetrize reciprocal hits (use when BLAST search has not been run in a
      fully symmetrical all-against-all manner)
    inputBinding:
      position: 101
      prefix: -r
  - id: target_id_index
    type:
      - 'null'
      - int
    doc: index of the sequence ID field for the BLAST target
    inputBinding:
      position: 101
      prefix: -t=
      separate: false
  - id: unfiltered_blast_dir
    type:
      - 'null'
      - Directory
    doc: directory with the unfiltered BLAST results
    inputBinding:
      position: 101
      prefix: -u=
      separate: false
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: verbose mode (mostly debugging output to STDOUT)
    inputBinding:
      position: 101
      prefix: -v
  - id: filtered_blast_dir_path
    type: string
    doc: "=dfilt\tdirectory with the filtered BLAST results (default ./blaf)"
    inputBinding:
      position: 102
      prefix: -f=
      separate: false
outputs:
  - id: filtered_blast_dir
    type:
      - 'null'
      - Directory
    doc: directory with the filtered BLAST results
    outputBinding:
      glob: $(inputs.filtered_blast_dir_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cogtriangles:2012.04--h9948957_4
