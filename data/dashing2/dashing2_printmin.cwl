cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dashing2
  - printmin
label: dashing2_printmin
doc: "Prints the minimizer sequences stored in a file written by dashing2 sketch
  --seq (-o), as a table or as FASTA.\n\nTool homepage: https://github.com/dnbaker/dashing2"
inputs:
  - id: input_file
    type: File
    doc: Minimizer sequence file written by dashing2 sketch --seq -o <file>
    inputBinding:
      position: 1
  - id: emit_fasta
    type:
      - 'null'
      - boolean
    doc: 'emit fasta. Default - emits tabular result.'
    inputBinding:
      position: 102
      prefix: -f
  - id: output
    type:
      - 'null'
      - string
    doc: Write to file instead of stdout.
    inputBinding:
      position: 102
      prefix: -o
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_file
    type:
      - 'null'
      - File
    doc: Minimizer sequences written with -o
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dashing2:2.1.20--he9e5f93_0
stdout: dashing2_printmin.out
