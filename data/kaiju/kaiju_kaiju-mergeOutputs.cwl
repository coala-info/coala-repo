cwlVersion: v1.2
class: CommandLineTool
baseCommand: kaiju-mergeOutputs
label: kaiju_kaiju-mergeOutputs
doc: "Merge two kaiju outputs (for example a protein-level and a nucleotide-level run) into one classification, resolving conflicts per read. Both input files must be sorted by read name (second column).\n\nTool homepage: https://github.com/bioinformatics-centre/kaiju"
inputs:
  - id: input_file
    type: File
    doc: "Name of first input file"
    inputBinding:
      position: 1
      prefix: -i
  - id: input_file2
    type: File
    doc: "Name of second input file"
    inputBinding:
      position: 2
      prefix: -j
  - id: output_file_path
    type:
      - 'null'
      - string
    doc: "Name of output file."
    inputBinding:
      position: 3
      prefix: -o
  - id: conflict_mode
    type:
      - 'null'
      - string
    doc: "Conflict resolution mode, must be 1, 2, lca, or lowest (default: lca)"
    inputBinding:
      position: 4
      prefix: -c
  - id: nodes_file
    type:
      - 'null'
      - File
    doc: "Name of nodes.dmp file, only required when -c is set to lca"
    inputBinding:
      position: 5
      prefix: -t
  - id: use_score
    type:
      - 'null'
      - boolean
    doc: "Use 4th column with classification score to give precedence to taxon with better score."
    inputBinding:
      position: 6
      prefix: -s
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Enable verbose output, which will print a summary in the end."
    inputBinding:
      position: 7
      prefix: -v
  - id: debug
    type:
      - 'null'
      - boolean
    doc: "Enable debug output."
    inputBinding:
      position: 8
      prefix: -d
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: "Classification output (tab separated), when -o is given"
    outputBinding:
      glob: $(inputs.output_file_path)
  - id: stdout
    type: stdout
    doc: Standard output (the result when no output file is given)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kaiju:1.10.1--h5ca1c30_3
stdout: kaiju_kaiju-mergeOutputs.out
