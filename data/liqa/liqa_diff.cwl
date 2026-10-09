cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - liqa
label: liqa_diff
doc: "Detect differential splicing genes between two conditions from lists of isoform expression estimate files.\n\nTool homepage: https://github.com/WGLab/LIQA"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.condition_1)
      - $(inputs.condition_2)
      - entryname: condition_1.list
        entry: |
          $(inputs.condition_1.map(function(f) { return f.path; }).join('\n') + '\n')
      - entryname: condition_2.list
        entry: |
          $(inputs.condition_2.map(function(f) { return f.path; }).join('\n') + '\n')
arguments:
  - position: 0
    prefix: -task
    valueFrom: diff
  - position: 1
    prefix: -condition_1
    valueFrom: condition_1.list
  - position: 2
    prefix: -condition_2
    valueFrom: condition_2.list
inputs:
  - id: condition_1
    type:
      type: array
      items: File
    doc: Isoform expression estimate files (liqa quantify output) of condition 1. They are listed by path in a list file passed to -condition_1.
  - id: condition_2
    type:
      type: array
      items: File
    doc: Isoform expression estimate files (liqa quantify output) of condition 2. They are listed by path in a list file passed to -condition_2.
  - id: out
    type: string
    doc: Output file for the gene-based test results (gene, P-value).
    inputBinding:
      position: 3
      prefix: -out
outputs:
  - id: test_results
    type: File
    doc: Gene-based differential splicing test results.
    outputBinding:
      glob: $(inputs.out)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/liqa:1.3.4--pyhdfd78af_0
stdout: liqa_diff.out
