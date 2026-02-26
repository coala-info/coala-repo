cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - jellyfish
  - stats
label: jellyfish_stats
doc: "Display some statistics about the k-mers in the hash:\n\nTool homepage: http://www.genome.umd.edu/jellyfish.html"
inputs:
  - id: db_path
    type: string
    doc: path to the k-mer hash database
    inputBinding:
      position: 1
  - id: lower_count
    type:
      - 'null'
      - int
    doc: Don't consider k-mer with count < lower-count
    default: 0
    inputBinding:
      position: 102
      prefix: --lower-count
  - id: upper_count
    type:
      - 'null'
      - int
    doc: Don't consider k-mer with count > upper-count
    default: 2^64
    inputBinding:
      position: 102
      prefix: --upper-count
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose
    default: false
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
