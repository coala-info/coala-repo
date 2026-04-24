cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - votuderep
  - tabulate
label: votuderep_tabulate
doc: "Generate CSV file from a directory containing sequencing reads. Scans INPUT_DIR
  for paired-end sequencing reads and generates a CSV table mapping sample names to
  their R1 and R2 file paths. The command identifies read pairs by looking for forward/reverse
  tags in filenames, extracts sample names, and outputs a table suitable for downstream
  analysis tools.\n\nTool homepage: https://github.com/quadram-institute-bioscience/votuderep"
inputs:
  - id: input_dir
    type: Directory
    doc: Directory containing sequencing reads
    inputBinding:
      position: 1
  - id: absolute
    type:
      - 'null'
      - boolean
    doc: Use absolute paths in output
    inputBinding:
      position: 102
      prefix: --absolute
  - id: delimiter
    type:
      - 'null'
      - string
    doc: Field separator
    inputBinding:
      position: 102
      prefix: --delimiter
  - id: extension
    type:
      - 'null'
      - string
    doc: Only process files ending with this extension
    inputBinding:
      position: 102
      prefix: --extension
  - id: for_tag
    type:
      - 'null'
      - string
    doc: Identifier for forward reads
    inputBinding:
      position: 102
      prefix: --for-tag
  - id: rev_tag
    type:
      - 'null'
      - string
    doc: Identifier for reverse reads
    inputBinding:
      position: 102
      prefix: --rev-tag
  - id: strip
    type:
      - 'null'
      - type: array
        items: string
    doc: Remove this string from sample names (can be used multiple times)
    inputBinding:
      position: 102
      prefix: --strip
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output CSV file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/votuderep:0.6.0--pyhdfd78af_0
