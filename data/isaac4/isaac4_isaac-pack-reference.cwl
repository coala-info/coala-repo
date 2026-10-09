cwlVersion: v1.2
class: CommandLineTool
baseCommand: isaac-pack-reference
label: isaac4_isaac-pack-reference
doc: "Pack an Isaac sorted reference directory into a tar.gz archive.\n\nTool homepage: https://github.com/Illumina/Isaac4"
inputs:
  - id: reference_genome
    type: File
    doc: Path to sorted-reference.xml
    inputBinding:
      position: 101
      prefix: --reference-genome
  - id: dry_run
    type:
      - 'null'
      - boolean
    doc: Don't actually run any commands; just print them
    inputBinding:
      position: 101
      prefix: --dry-run
  - id: jobs
    type:
      - 'null'
      - int
    doc: 'Maximum number of parallel operations (default: 20)'
    inputBinding:
      position: 101
      prefix: --jobs
  - id: output_file
    type: string
    doc: Archive path
    inputBinding:
      position: 102
      prefix: --output-file
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: archive
    type: File
    doc: Packed reference archive
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/isaac4:04.18.11.09--h07bff40_0
stdout: isaac4_isaac-pack-reference.out
