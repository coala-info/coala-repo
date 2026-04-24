cwlVersion: v1.2
class: CommandLineTool
baseCommand: dsh-compress-gfa2
label: dsh-bio_compress-gfa2
doc: "Compresses a GFA 2.0 file.\n\nTool homepage: https://github.com/heuermh/dishevelled-bio"
inputs:
  - id: input_gfa2_path
    type:
      - 'null'
      - File
    doc: input GFA 2.0 path, default stdin
    inputBinding:
      position: 101
      prefix: --input-gfa2-path
outputs:
  - id: output_gfa2_file
    type:
      - 'null'
      - File
    doc: output GFA 2.0 file, default stdout
    outputBinding:
      glob: $(inputs.output_gfa2_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
