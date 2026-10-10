cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sparse
  - extract
label: meta-sparse_sparse_extract
doc: "Extract species-specific reads associated with particular references from a SPARSE read-mapping result.\n\nTool homepage: https://github.com/zheminzhou/SPARSE"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.workspace)
        writable: true
inputs:
  - id: workspace
    type: Directory
    doc: "SPARSE workspace folder produced by sparse predict; staged writable"
    inputBinding:
      position: 1
      prefix: --workspace
      valueFrom: $(self.basename)
  - id: ref_id
    type: string
    doc: "Comma delimited reference indexes to extract"
    inputBinding:
      position: 2
      prefix: --ref_id
  - id: ratio
    type: 
      - 'null'
      - float
    doc: "The minimum probability to report. Default: 0.5"
    inputBinding:
      position: 3
      prefix: --ratio
outputs:
  - id: workspace_out
    type: Directory
    doc: "Workspace folder with the extracted read files"
    outputBinding:
      glob: $(inputs.workspace.basename)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/meta-sparse:0.1.12--py27h24bf2e0_0
stdout: meta-sparse_sparse_extract.out
