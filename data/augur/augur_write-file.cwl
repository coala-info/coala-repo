cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - augur
  - write-file
label: augur_write-file
doc: "Write a file like Augur (input from stdin), with transparent compression 
  chosen from the output file name and universal newlines.\n\nTool homepage: https://github.com/nextstrain/augur"
inputs:
  - id: input_file
    type: File
    doc: File whose content is passed on standard input.
  - id: output_path
    type: string
    doc: Path of the file to write (.gz, .bz2, .xz or .zst selects 
      compression).
    inputBinding:
      position: 1
outputs:
  - id: output
    type: File
    doc: The written file.
    outputBinding:
      glob: $(inputs.output_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/augur:33.0.0--pyhdfd78af_0
stdin: $(inputs.input_file.path)
