cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - demultiplexer2
  - demultiplex
label: demultiplexer2_demultiplex
doc: "Demultiplexes sequencing reads based on primer and tagging schemes.\n\nTool
  homepage: https://github.com/DominikBuchner/demultiplexer2"
inputs:
  - id: primerset_path
    type: File
    doc: Path to the primerset to be used for demultiplexing.
    inputBinding:
      position: 101
      prefix: --primerset_path
  - id: tagging_scheme_path
    type: File
    doc: Path to the tagging scheme to be used for demultiplexing.
    inputBinding:
      position: 101
      prefix: --tagging_scheme_path
outputs:
  - id: output_dir
    type: Directory
    doc: Directory to write the demultiplexed files to.
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/demultiplexer2:1.1.6--pyhdfd78af_0
