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
    doc: append/aggregate mode (use if BLAST hits from one query do not form a contiguous
      block in the BLAST output files)
    inputBinding:
      position: 101
      prefix: -a
  - id: converted_data_dir
    type:
      - 'null'
      - Directory
    doc: directory for converted data (must contain hash.csv)
    default: ./conv
    inputBinding:
      position: 101
      prefix: -d
  - id: evalue_threshold
    type:
      - 'null'
      - float
    doc: e-value threshold for BLAST hits
    default: 10.0
    inputBinding:
      position: 101
      prefix: -e
  - id: query_id_index
    type:
      - 'null'
      - int
    doc: index of the sequence ID field for the BLAST query
    default: 2
    inputBinding:
      position: 101
      prefix: -q
  - id: self_blast_dir
    type:
      - 'null'
      - Directory
    doc: directory with the self-BLAST results
    default: ./blan
    inputBinding:
      position: 101
      prefix: -s
  - id: symmetrize_hits
    type:
      - 'null'
      - boolean
    doc: symmetrize reciprocal hits (use when BLAST search has not been run in a fully
      symmetrical all-against-all manner)
    inputBinding:
      position: 101
      prefix: -r
  - id: target_id_index
    type:
      - 'null'
      - int
    doc: index of the sequence ID field for the BLAST target
    default: 2
    inputBinding:
      position: 101
      prefix: -t
  - id: unfiltered_blast_dir
    type:
      - 'null'
      - Directory
    doc: directory with the unfiltered BLAST results
    default: ./blan
    inputBinding:
      position: 101
      prefix: -u
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: verbose mode (mostly debugging output to STDOUT)
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: filtered_blast_dir
    type:
      - 'null'
      - Directory
    doc: directory with the filtered BLAST results
    outputBinding:
      glob: $(inputs.filtered_blast_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cogtriangles:2012.04--h9948957_4
