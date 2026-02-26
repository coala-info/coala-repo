cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mg-toolkit
  - bulk_download
label: mg-toolkit_bulk_download
doc: "Bulk download study or project data from MGnify.\n\nTool homepage: https://github.com/EBI-metagenomics/emg-toolkit"
inputs:
  - id: accession
    type: string
    doc: Provide the study/project accession of your interest, e.g. ERP001736, 
      SRP000319. The study must be publicly available in MGnify.
    inputBinding:
      position: 101
      prefix: --accession
  - id: pipeline
    type:
      - 'null'
      - string
    doc: Specify the version of the pipeline you are interested in (1.0, 2.0, 
      3.0, 4.0, 4.1, 5.0). Used to filter results by a particular version.
    inputBinding:
      position: 101
      prefix: --pipeline
  - id: result_group
    type:
      - 'null'
      - string
    doc: Provide a single result group if needed (e.g., statistics, 
      sequence_data, functional_analysis, etc.). Downloads all result groups if 
      not provided.
    inputBinding:
      position: 101
      prefix: --result_group
outputs:
  - id: output_path
    type:
      - 'null'
      - Directory
    doc: Location of the output directory, where the downloadable files are 
      written to.
    outputBinding:
      glob: $(inputs.output_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mg-toolkit:0.10.4--pyhdfd78af_0
