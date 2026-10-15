cwlVersion: v1.2
class: CommandLineTool
baseCommand: [/usr/local/bin/share/physlr-1.0.4-0/bin/physlr, find-ntcard-mode]
label: physlr_find-ntcard-mode
doc: "Find the first mode after the minimum in an ntCard k-mer histogram (written by ntcard -o) and print it.\n\nTool homepage: https://github.com/BirolLab/physlr"
inputs:
  - id: histogram
    type: File
    doc: "k-mer histogram written by ntcard -o: a header line k, f, n followed by tab-separated k, frequency and count rows"
    inputBinding:
      position: 100
outputs:
  - id: result
    type: File
    doc: "Text file holding the k-mer frequency of the first mode"
    outputBinding:
      glob: physlr_find-ntcard-mode.tsv
stdout: physlr_find-ntcard-mode.tsv
requirements:
  - class: EnvVarRequirement
    envDef:
      - envName: PYTHONPATH
        envValue: /usr/local/bin/share/physlr-1.0.4-0
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/physlr:1.0.4--py39h2df963e_0
