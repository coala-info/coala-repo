cwlVersion: v1.2
class: CommandLineTool
baseCommand: isaac-sort-reference
label: isaac4_isaac-sort-reference
doc: "Sort a reference FASTA and build the Isaac reference directory (sorted-reference.xml, k-mer index) needed by isaac-align.\n\nTool homepage: https://github.com/Illumina/Isaac4"
inputs:
  - id: genome_file
    type: File
    doc: Path to fasta file containing the reference contigs
    inputBinding:
      position: 101
      prefix: --genome-file
  - id: dry_run
    type:
      - 'null'
      - boolean
    doc: Don't actually run any commands; just print them
    inputBinding:
      position: 101
      prefix: --dry-run
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Avoid excessive logging
    inputBinding:
      position: 101
      prefix: --quiet
  - id: target
    type:
      - 'null'
      - string
    doc: 'Individual target to make (default: all)'
    inputBinding:
      position: 101
      prefix: --target
  - id: output_directory
    type: string
    doc: Location where the results are stored
    inputBinding:
      position: 102
      prefix: --output-directory
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_directory_dir
    type: Directory
    doc: Sorted reference directory containing sorted-reference.xml
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/isaac4:04.18.11.09--h07bff40_0
stdout: isaac4_isaac-sort-reference.out
