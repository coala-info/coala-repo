cwlVersion: v1.2
class: CommandLineTool
baseCommand: test
label: metasbt_test
doc: "Check for software dependencies and run unit tests.\n\nTool homepage: https://github.com/cumbof/MetaSBT"
inputs:
  - id: mags
    type: File
    doc: Path to the file with the list of paths to the metagenome-assembled 
      genomes.
    default: None
    inputBinding:
      position: 101
      prefix: --mags
  - id: references
    type: File
    doc: Path to the file with the list of paths to the reference genomes and 
      their taxonomies.
    default: None
    inputBinding:
      position: 101
      prefix: --references
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metasbt:0.1.5--pyhdfd78af_0
stdout: metasbt_test.out
