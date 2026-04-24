cwlVersion: v1.2
class: CommandLineTool
baseCommand: jellyfish_histo
label: jellyfish_histo
doc: "Create an histogram of k-mer occurrences\n\nTool homepage: http://www.genome.umd.edu/jellyfish.html"
inputs:
  - id: input_db_path
    type: string
    doc: db:path
    inputBinding:
      position: 1
  - id: full_histogram
    type:
      - 'null'
      - boolean
    doc: Full histo. Don't skip count 0.
    inputBinding:
      position: 102
      prefix: --full
  - id: high_count
    type:
      - 'null'
      - int
    doc: High count value of histogram
    inputBinding:
      position: 102
      prefix: --high
  - id: increment
    type:
      - 'null'
      - int
    doc: Increment value for buckets
    inputBinding:
      position: 102
      prefix: --increment
  - id: low_count
    type:
      - 'null'
      - int
    doc: Low count value of histogram
    inputBinding:
      position: 102
      prefix: --low
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 102
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Output information
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/jellyfish:v2.2.10-2-deb_cv1
