cwlVersion: v1.2
class: CommandLineTool
baseCommand: round_statistics.py
label: getorganelle_round_statistics.py
doc: "Map the reads of each extending round (from get_organelle_from_reads.py --out-per-round) to a reference fasta and report the covered fraction per round.\n\nTool homepage: http://github.com/Kinggerm/GetOrganelle"
inputs:
  - id: fasta
    type:
      - File
    doc: "Input fasta file."
    inputBinding:
      position: 101
      prefix: "-f"
  - id: output_per_round_dir
    type:
      - Directory
    doc: "Output per round directory (the intermediate_reads folder)."
    inputBinding:
      position: 101
      prefix: "-d"
  - id: initial_mapped
    type:
      - File
    doc: "Seed fastq."
    inputBinding:
      position: 101
      prefix: "-i"
  - id: output_base
    type:
      - string
    doc: "Output folder."
    inputBinding:
      position: 101
      prefix: "-o"
  - id: round
    type:
      - 'null'
      - int
    doc: "Rounds to check. Default: automatic stop!"
    inputBinding:
      position: 101
      prefix: "-R"
  - id: threads
    type:
      - 'null'
      - int
    doc: "Threads."
    inputBinding:
      position: 101
      prefix: "-t"
  - id: which_bowtie2
    type:
      - 'null'
      - string
    doc: "Assign the path to Bowtie2 binary files if not added to the path. Default: try GetOrganelleDep/linux/bowtie2 first, then $PATH"
    inputBinding:
      position: 101
      prefix: "--which-bowtie2"
  - id: random_seed
    type:
      - 'null'
      - int
    doc: "Seed for random generator for bowtie2. Default: 12345"
    inputBinding:
      position: 101
      prefix: "--random-seed"
  - id: threshold
    type:
      - 'null'
      - string
    doc: "Sites with coverage above the threshold would be marked as covered. Default: 0,10"
    inputBinding:
      position: 101
      prefix: "--threshold"
  - id: continue_mode
    type:
      - 'null'
      - boolean
    doc: "Continue mode."
    inputBinding:
      position: 101
      prefix: "--continue"
  - id: keep_temp
    type:
      - 'null'
      - boolean
    doc: "Keep the temporary files."
    inputBinding:
      position: 101
      prefix: "--keep-temp"
  - id: draw
    type:
      - 'null'
      - boolean
    doc: "Draw density plot using matplotlib, which should be installed."
    inputBinding:
      position: 101
      prefix: "--draw"
  - id: max_coverage_tick
    type:
      - 'null'
      - int
    doc: "Maximum coverage tick of the plot."
    inputBinding:
      position: 101
      prefix: "--max-coverage-tick"
  - id: debug
    type:
      - 'null'
      - string
    doc: "Debug mode."
    inputBinding:
      position: 101
      prefix: "--debug"
outputs:
  - id: output_dir
    type:
      - Directory
    doc: "Output folder."
    outputBinding:
      glob: "$(inputs.output_base)"
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/getorganelle:1.7.7.1--pyhdfd78af_0
stdout: getorganelle_round_statistics.py.out
