cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gaftools
  - find_path
label: gaftools_find_path
doc: "Find the genomic sequence of a given connected GFA path.\n\nTool homepage: https://github.com/marschall-lab/gaftools"
inputs:
  - id: gfa
    type: File
    doc: GFA file (can be bgzip-compressed)
    inputBinding:
      position: 1
  - id: fasta
    type:
      - 'null'
      - boolean
    doc: Flag to output the sequence as a FASTA file with the seqeunce named 
      seq_<node path>
    inputBinding:
      position: 102
      prefix: --fasta
  - id: keep_going
    type:
      - 'null'
      - boolean
    doc: Keep going after instead of stopping when a path does not exist
    inputBinding:
      position: 102
      prefix: --keep-going
  - id: path
    type:
      - 'null'
      - string
    doc: GFA node path to retrieve the sequence (e.g., ">s82312<s82313") with 
      the quotes
    inputBinding:
      position: 102
      prefix: --path
  - id: paths_file
    type:
      - 'null'
      - File
    doc: File containing the paths to retrieve the sequences for, each path on 
      new line
    inputBinding:
      position: 102
      prefix: --paths_file
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output file. If omitted, use standard output.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gaftools:1.3.1--pyhdfd78af_0
