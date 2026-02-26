cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seqforge
  - makedb
label: seqforge_makedb
doc: "Create a BLAST database from a FASTA file.\n\nTool homepage: https://github.com/ERBringHorvath/SeqForge"
inputs:
  - id: fasta_directory
    type: Directory
    doc: Path to FASTA files.
    inputBinding:
      position: 101
      prefix: --fasta-directory
  - id: keep_temp_files
    type:
      - 'null'
      - boolean
    doc: Keep extracted temporary files for debugging
    inputBinding:
      position: 101
      prefix: --keep-temp-files
  - id: progress
    type:
      - 'null'
      - string
    doc: Progress reporting mode passing only --progress is equivalent to 
      --progress bar 'verbose' prints a line per item, 'none' silences output
    inputBinding:
      position: 101
      prefix: --progress
  - id: sanitize
    type:
      - 'null'
      - boolean
    doc: Permanently remove special characters from FASTA file(s)
    inputBinding:
      position: 101
      prefix: --sanitize
  - id: temp_dir
    type:
      - 'null'
      - Directory
    doc: Specify temporary directory
    default: /tmp/
    inputBinding:
      position: 101
      prefix: --temp-dir
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of cores to dedicate for multi-processing
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output_dir
    type: Directory
    doc: Name for the output database.
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqforge:2.0.0--pyh7e72e81_0
