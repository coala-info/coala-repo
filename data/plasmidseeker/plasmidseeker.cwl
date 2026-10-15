cwlVersion: v1.2
class: CommandLineTool
baseCommand: plasmidseeker
label: plasmidseeker
doc: "Identification of known plasmids from bacterial whole-genome sequencing reads
  using k-mers.\n\nTool homepage: https://github.com/bioinfo-ut/PlasmidSeeker"
inputs:
  - id: database_dir
    type: Directory
    doc: Path to plasmid database directory
    inputBinding:
      position: 101
      prefix: -d
  - id: input_fastq
    type: File
    doc: Input fastq file
    inputBinding:
      position: 101
      prefix: -i
  - id: closest_bacteria
    type:
      - 'null'
      - File
    doc: Closest bacteria to isolate genome fna (required unless --ponly)
    inputBinding:
      position: 101
      prefix: -b
  - id: output_file
    type:
      - 'null'
      - string
    doc: Output file name (default plasmidseeker_result.txt)
    inputBinding:
      position: 101
      prefix: -o
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads used (default 32)
    inputBinding:
      position: 101
      prefix: -t
  - id: min_fraction
    type:
      - 'null'
      - int
    doc: Minimum threshold F - at least this fraction of unique k-mers that has
      to be found for a plasmid (default 80)
    inputBinding:
      position: 101
      prefix: -f
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print out more working process
    inputBinding:
      position: 101
      prefix: --verbose
  - id: ponly
    type:
      - 'null'
      - boolean
    doc: Assumes that reads contain only plasmid sequences (use for extracted
      plasmids)
    inputBinding:
      position: 101
      prefix: --ponly
outputs:
  - id: result
    type:
      - 'null'
      - File
    doc: Plasmid detection result table
    outputBinding:
      glob: |
        ${ return inputs.output_file ? inputs.output_file : 'plasmidseeker_result.txt'; }
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/plasmidseeker:v1.0dfsg-1-deb_cv1
