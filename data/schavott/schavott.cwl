cwlVersion: v1.2
class: CommandLineTool
baseCommand: schavott
label: schavott
doc: "Scaffold genomes in real time\n\nTool homepage: http://github.com/emilhaegglund/schavott"
inputs:
  - id: contig_file
    type:
      - 'null'
      - File
    doc: Path to contig file (Only for scaffolding)
    inputBinding:
      position: 101
      prefix: --contig_file
  - id: intensity
    type:
      - 'null'
      - int
    doc: "How often the scaffolding process should run. If run\n mode is set to reads,
      scaffolding will run every i:th\n read. If run mode is time, scaffolding will
      run every\n i:th second."
    default: 100 reads
    inputBinding:
      position: 101
      prefix: --intensity
  - id: min_quality
    type:
      - 'null'
      - int
    doc: Minimum quality for reads from MinION to use.
    inputBinding:
      position: 101
      prefix: --min_quality
  - id: min_read_length
    type:
      - 'null'
      - int
    doc: Minimum read length from MinION to use.
    inputBinding:
      position: 101
      prefix: --min_read_length
  - id: output
    type:
      - 'null'
      - string
    doc: Set output filename.
    default: schavott
    inputBinding:
      position: 101
      prefix: --output
  - id: plot
    type:
      - 'null'
      - boolean
    doc: Plot result in web-browser
    inputBinding:
      position: 101
      prefix: --plot
  - id: read_type
    type:
      - 'null'
      - string
    doc: "Select input type: fastq, fast5 or fasta, this is also\nthe search pattern
      for shavott (*.read_type)"
    inputBinding:
      position: 101
      prefix: --read_type
  - id: run_mode
    type:
      - 'null'
      - string
    doc: Run scaffolding or assembly
    inputBinding:
      position: 101
      prefix: --run_mode
  - id: scaffolder
    type:
      - 'null'
      - string
    doc: Which scaffolder to use.
    inputBinding:
      position: 101
      prefix: --scaffolder
  - id: skip
    type:
      - 'null'
      - int
    doc: Skips the first j read of the sequencing
    inputBinding:
      position: 101
      prefix: --skip
  - id: sspace_path
    type:
      - 'null'
      - string
    doc: Path to SSPACE (Only for scaffolding)
    inputBinding:
      position: 101
      prefix: --sspace_path
  - id: trigger_mode
    type:
      - 'null'
      - string
    doc: Use timer or read count.
    default: reads
    inputBinding:
      position: 101
      prefix: --trigger_mode
  - id: watch
    type: Directory
    doc: Directory to watch for fast5 files
    inputBinding:
      position: 101
      prefix: --watch
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/schavott:0.5.0--py35_0
stdout: schavott.out
