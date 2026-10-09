cwlVersion: v1.2
class: CommandLineTool
baseCommand: isaac-merge-references
label: isaac4_isaac-merge-references
doc: "Merge several Isaac sorted references into one reference directory.\n\nTool homepage: https://github.com/Illumina/Isaac4"
inputs:
  - id: input_files
    type:
      type: array
      items: File
      inputBinding:
        prefix: --input-file
    doc: Path to sorted-reference.xml to be merged. Multiple entries allowed.
    inputBinding:
      position: 101
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
    doc: Merged reference directory
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/isaac4:04.18.11.09--h07bff40_0
stdout: isaac4_isaac-merge-references.out
