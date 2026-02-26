cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seqforge
  - extract
label: seqforge_extract
doc: "Extract sequences based on SeqForge Query results.\n\nTool homepage: https://github.com/ERBringHorvath/SeqForge"
inputs:
  - id: csv_path
    type: File
    doc: Path to BLAST results files.
    inputBinding:
      position: 101
      prefix: --csv-path
  - id: down
    type:
      - 'null'
      - int
    doc: Extract additional basepairs downstream of aligned sequence
    inputBinding:
      position: 101
      prefix: --down
  - id: evalue
    type:
      - 'null'
      - float
    doc: Minimum e-value threshold for sequence extraction.
    inputBinding:
      position: 101
      prefix: --evalue
  - id: fasta_directory
    type: Directory
    doc: Path to reference FASTA assemblies.
    inputBinding:
      position: 101
      prefix: --fasta-directory
  - id: keep_temp_files
    type:
      - 'null'
      - boolean
    doc: Keep extracted temporary files for debugging (only with archive 
      submission)
    inputBinding:
      position: 101
      prefix: --keep-temp-files
  - id: min_cov
    type:
      - 'null'
      - float
    doc: Minimum query coverage threshold for sequence extraction.
    inputBinding:
      position: 101
      prefix: --min-cov
  - id: min_perc
    type:
      - 'null'
      - float
    doc: Minimum percent identity threshold for sequence extraction.
    inputBinding:
      position: 101
      prefix: --min-perc
  - id: temp_dir
    type:
      - 'null'
      - Directory
    doc: Specify a temporary directory (default = /tmp/)
    default: /tmp/
    inputBinding:
      position: 101
      prefix: --temp-dir
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of cores to dedicate.
    inputBinding:
      position: 101
      prefix: --threads
  - id: translate
    type:
      - 'null'
      - boolean
    doc: Translate extracted nucleotide sequence using the standard genetic 
      code.
    inputBinding:
      position: 101
      prefix: --translate
  - id: up
    type:
      - 'null'
      - int
    doc: Extract additional basepairs upstream of aligned sequence
    inputBinding:
      position: 101
      prefix: --up
outputs:
  - id: output_fasta
    type: File
    doc: Output FASTA file name.
    outputBinding:
      glob: $(inputs.output_fasta)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqforge:2.0.0--pyh7e72e81_0
