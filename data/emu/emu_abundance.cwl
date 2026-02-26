cwlVersion: v1.2
class: CommandLineTool
baseCommand: emu abundance
label: emu_abundance
doc: "Calculate species abundance from sequence data.\n\nTool homepage: https://gitlab.com/treangenlab/emu"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: filepath to input nt sequence file
    inputBinding:
      position: 1
  - id: K
    type:
      - 'null'
      - string
    doc: minibatch size for minimap2 mapping [500M]
    default: 500M
    inputBinding:
      position: 102
      prefix: --K
  - id: N
    type:
      - 'null'
      - int
    doc: minimap max number of secondary alignments per read [50]
    default: 50
    inputBinding:
      position: 102
      prefix: --N
  - id: db
    type:
      - 'null'
      - Directory
    doc: 'path to emu database containing: names_df.tsv, nodes_df.tsv, species_taxid.fasta,
      unqiue_taxids.tsv [$EMU_DATABASE_DIR]'
    default: $EMU_DATABASE_DIR
    inputBinding:
      position: 102
      prefix: --db
  - id: keep_counts
    type:
      - 'null'
      - boolean
    doc: include estimated read counts in output
    inputBinding:
      position: 102
      prefix: --keep-counts
  - id: keep_files
    type:
      - 'null'
      - boolean
    doc: keep working files in output-dir
    inputBinding:
      position: 102
      prefix: --keep-files
  - id: keep_read_assignments
    type:
      - 'null'
      - boolean
    doc: output file of read assignment distribution
    inputBinding:
      position: 102
      prefix: --keep-read-assignments
  - id: max_align_len
    type:
      - 'null'
      - int
    doc: Maximum aligned query length (excludes soft/hard clipping) [2000]
    default: 2000
    inputBinding:
      position: 102
      prefix: --max-align-len
  - id: min_abundance
    type:
      - 'null'
      - float
    doc: min species abundance in results [0.0001]
    default: 0.0001
    inputBinding:
      position: 102
      prefix: --min-abundance
  - id: min_align_len
    type:
      - 'null'
      - int
    doc: Minimum aligned query length (excludes soft/hard clipping [0]
    default: 0
    inputBinding:
      position: 102
      prefix: --min-align-len
  - id: min_pid
    type:
      - 'null'
      - string
    doc: Minimum percent identity (PID) based on NM tag [0%]
    default: 0%
    inputBinding:
      position: 102
      prefix: --min-pid
  - id: mm2_forward_only
    type:
      - 'null'
      - boolean
    doc: force minimap2 to consider the forward transcript strand only
    inputBinding:
      position: 102
      prefix: --mm2-forward-only
  - id: output_basename
    type:
      - 'null'
      - string
    doc: basename for all emu output files [{input_file}]
    default: '{input_file}'
    inputBinding:
      position: 102
      prefix: --output-basename
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: output directory name [./results]
    default: ./results
    inputBinding:
      position: 102
      prefix: --output-dir
  - id: output_unclassified
    type:
      - 'null'
      - boolean
    doc: output unclassified sequences
    inputBinding:
      position: 102
      prefix: --output-unclassified
  - id: threads
    type:
      - 'null'
      - int
    doc: threads utilized by minimap [3]
    default: 3
    inputBinding:
      position: 102
      prefix: --threads
  - id: type
    type:
      - 'null'
      - string
    doc: 'short-read: sr, Pac-Bio:map-pb, ONT:map-ont, ... [map-ont]'
    default: map-ont
    inputBinding:
      position: 102
      prefix: --type
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/emu:3.6.1--hdfd78af_0
stdout: emu_abundance.out
