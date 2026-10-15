cwlVersion: v1.2
class: CommandLineTool
baseCommand: [phyluce_align_move_align_by_conf_file]
label: phyluce_phyluce_align_move_align_by_conf_file
doc: "Move alignment files as denoted by config file (or do not move if using --opposite).\n\nTool homepage: https://github.com/faircloth-lab/phyluce"
inputs:
  - id: conf
    type: File
    doc: "The configuration file giving locus names."
    inputBinding:
      position: 1
      prefix: --conf
  - id: alignments
    type: Directory
    doc: "The input directory for the alignments."
    inputBinding:
      position: 2
      prefix: --alignments
  - id: output
    type: string
    doc: "The output directory for the alignments."
    inputBinding:
      position: 3
      prefix: --output
  - id: sections
    type:
      - 'null'
      - type: array
        items: string
    doc: "The sections of files to use as a filter (defaults to all)."
    inputBinding:
      position: 4
      prefix: --sections
  - id: opposite
    type: ['null', boolean]
    doc: "Move alignments based on what is NOT in the conf file."
    inputBinding:
      position: 5
      prefix: --opposite
  - id: extension
    type: ['null', string]
    doc: "The extension of the files to move (default: nex)."
    inputBinding:
      position: 6
      prefix: --extension
outputs:
  - id: output_dir
    type: Directory
    doc: "Directory of the selected alignment files."
    outputBinding:
      glob: "$(inputs.output)"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyluce:1.6.8--py_0
