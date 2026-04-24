cwlVersion: v1.2
class: CommandLineTool
baseCommand: savont_classify
label: savont_classify
doc: "Classify ASVs against a reference database and generate taxonomy abundance table
  at species/genus level\n\nTool homepage: https://github.com/bluenote-1577/savont"
inputs:
  - id: emu_db
    type: File
    doc: Emu database path
    inputBinding:
      position: 101
      prefix: --emu-db
  - id: genus_threshold
    type:
      - 'null'
      - string
    doc: Minimum identity threshold for genus-level classification
    inputBinding:
      position: 101
      prefix: --genus-threshold
  - id: input_dir
    type: Directory
    doc: Directory containing clustering results
    inputBinding:
      position: 101
      prefix: --input-dir
  - id: log_level
    type:
      - 'null'
      - string
    doc: Logging verbosity level
    inputBinding:
      position: 101
      prefix: --log-level
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Output directory for classification results.
    inputBinding:
      position: 101
      prefix: --output-dir
  - id: silva_db
    type: File
    doc: SILVA database path
    inputBinding:
      position: 101
      prefix: --silva-db
  - id: species_threshold
    type:
      - 'null'
      - string
    doc: Minimum identity threshold for species-level classification
    inputBinding:
      position: 101
      prefix: --species-threshold
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for parallel processing
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/savont:0.3.2--h3ab6199_0
stdout: savont_classify.out
