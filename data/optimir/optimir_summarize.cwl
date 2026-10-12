cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - optimir
  - summarize
label: optimir_summarize
doc: "Summarize optimir results\n\nTool homepage: https://github.com/FlorianThibord/OptimiR"
inputs:
  - id: dir
    type: Directory
    doc: Full path of the directory containing results
    inputBinding:
      position: 101
      prefix: --dir
      valueFrom: summary_run/$(self.basename)
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: summary_files
    type:
      type: array
      items: File
    doc: Summary abundance and annotation tables written next to the results directory
    outputBinding:
      glob:
        - summary_run/*.txt
        - summary_run/*.annot
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: summary_run/$(inputs.dir.basename)
        entry: $(inputs.dir)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/optimir:1.2--pyh5e36f6f_0
stdout: optimir_summarize.out
