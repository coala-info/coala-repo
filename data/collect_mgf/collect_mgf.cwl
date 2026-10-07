cwlVersion: v1.2
class: CommandLineTool
baseCommand: collect_mgf
label: collect_mgf
doc: "Collect MGF data from experiment directories and results files\n\nTool homepage:
  http://www.ms-utils.org/collect_mgf.c"
inputs:
  - id: expno_directory
    type: Directory
    doc: EXPNO directory (holds <EXPNO>/pdata/1/<dir name>_<EXPNO>_1.mgf); 
      staged in the working directory and passed by name, because the tool 
      also uses the name inside each MGF file name
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: dd_results_file
    type: File
    doc: dd_results file
    inputBinding:
      position: 2
  - id: start_expno_index
    type: int
    doc: start EXPNO index (even)
    inputBinding:
      position: 3
  - id: end_expno_index
    type: int
    doc: end EXPNO index (even)
    inputBinding:
      position: 4
  - id: output_file
    type: string
    doc: output file
    inputBinding:
      position: 5
outputs:
  - id: output_mgf
    type: File
    doc: combined MGF file
    outputBinding:
      glob: $(inputs.output_file)
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.expno_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/collect_mgf:1.0--h7b50bb2_7
