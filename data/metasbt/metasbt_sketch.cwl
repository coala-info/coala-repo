cwlVersion: v1.2
class: CommandLineTool
baseCommand: sketch
label: metasbt_sketch
doc: "Sketch the input genomes.\n\nTool homepage: https://github.com/cumbof/MetaSBT"
inputs:
  - id: database
    type:
      - 'null'
      - string
    doc: The database name.
    default: MetaSBT
    inputBinding:
      position: 101
      prefix: --database
  - id: genome
    type: File
    doc: Path to the input genome.
    inputBinding:
      position: 101
      prefix: --genome
  - id: genomes
    type: File
    doc: Path to the file with a list of paths to the input genomes.
    inputBinding:
      position: 101
      prefix: --genomes
  - id: nproc
    type:
      - 'null'
      - int
    doc: Process the input genomes in parallel.
    default: 20
    inputBinding:
      position: 101
      prefix: --nproc
  - id: workdir
    type: Directory
    doc: Path to the working directory.
    inputBinding:
      position: 101
      prefix: --workdir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metasbt:0.1.5--pyhdfd78af_0
stdout: metasbt_sketch.out
