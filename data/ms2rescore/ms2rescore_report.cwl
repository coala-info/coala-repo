cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ms2rescore-report
label: ms2rescore_report
doc: "Generate the MS2Rescore HTML report from existing MS2Rescore output files
  (<prefix>.psms.tsv, <prefix>.full-config.json and related files).\n\nTool homepage:
  https://compomics.github.io/projects/ms2rescore/"
inputs:
  - id: output_prefix
    type: string
    doc: Output prefix (path and stem) of a finished MS2Rescore run.
    inputBinding:
      position: 1
  - id: ms2rescore_files
    type: File[]
    doc: The MS2Rescore result files that share the output prefix (for example
      <prefix>.psms.tsv, <prefix>.full-config.json, <prefix>.feature_names.tsv),
      staged in the working directory.
outputs:
  - id: report
    type:
      type: array
      items: File
    doc: The HTML report written as <prefix>.report.html.
    outputBinding:
      glob: $(inputs.output_prefix).report.html
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.ms2rescore_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ms2rescore:3.2.1--pyhdfd78af_0
