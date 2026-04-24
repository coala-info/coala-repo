cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seqforge
  - unique-headers
label: seqforge_unique-headers
doc: "Append source and a unique suffix to FASTA headers (supports --deterministic).\n\
  \nTool homepage: https://github.com/ERBringHorvath/SeqForge"
inputs:
  - id: deterministic
    type:
      - 'null'
      - boolean
    doc: Use a stable MD5-based suffix derived from the sequence and header 
      instead of a random alphanumeric code (default). Ensures reproducible IDs 
      across runs
    inputBinding:
      position: 101
      prefix: --deterministic
  - id: fasta_directory
    type: Directory
    doc: Path to FASTA file(s)
    inputBinding:
      position: 101
      prefix: --fasta-directory
  - id: in_place
    type:
      - 'null'
      - boolean
    doc: Modify input files in-place (uses temporary files for safety)
    inputBinding:
      position: 101
      prefix: --in-place
  - id: progress
    type:
      - 'null'
      - string
    doc: Progress reporting mode; passing only --progress is equivalent to 
      --progress bar '--verbose' prints a line per record, 'none' silences 
      output
    inputBinding:
      position: 101
      prefix: --progress
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Directory for output FASTA files (unless using --in-place)
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqforge:2.0.0--pyh7e72e81_0
