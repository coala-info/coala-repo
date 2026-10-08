cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - expam
  - print
label: expam_print
doc: "Print current database parameters.\n\nTool homepage: https://github.com/seansolari/expam"
inputs:
  - id: database
    type: Directory
    doc: "Expam database directory (-db). It is staged writable in the work directory and returned as an output."
    inputBinding:
      position: 1
      prefix: -db
      valueFrom: $(self.basename)
outputs:
  - id: stdout
    type: stdout
    doc: Database parameters
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.database)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/expam:1.4.0.7--py39hbcbf7aa_0
    dockerOutputDirectory: /w
stdout: expam_print.txt
