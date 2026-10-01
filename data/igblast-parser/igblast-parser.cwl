cwlVersion: v1.2
class: CommandLineTool
baseCommand: python
label: igblast-parser
doc: "Parses IGBLAST output.\n\nTool homepage: https://github.com/aerijman/igblast-parser"
inputs:
  - id: in_igblast_output
    type: File
    doc: IGBLAST output file
    inputBinding:
      position: 101
      prefix: --in
  - id: out_filename_prefix
    type: string
    doc: Output filename prefix
    inputBinding:
      position: 101
      prefix: --out
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: out_filename_prefix_files
    type:
      type: array
      items: File
    doc: Files written with the prefix given in out_filename_prefix
    outputBinding:
      glob: $(inputs.out_filename_prefix)*
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/igblast-parser:0.0.4--py39hf95cd2a_6
stdout: igblast-parser.out
