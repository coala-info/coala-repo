cwlVersion: v1.2
class: CommandLineTool
baseCommand: autometa-cami-format
label: autometa_autometa-cami-format
doc: "Format Autometa results to biobox format for compatibility with CAMI. All results tables must contain a 'contig' column and either 'taxid', or 'cluster' column.\n\nTool homepage: https://github.com/KwanLab/Autometa"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: sample_predictions
    type: File
    doc: "Path of autometa table containing relevant `results-type` columns"
    inputBinding:
      position: 1
      prefix: --sample-predictions
  - id: sample_id
    type: string
    doc: "CAMI Sample ID corresponding to `sample-predictions`"
    inputBinding:
      position: 1
      prefix: --sample-id
  - id: results_type
    type: string
    doc: "Type of results for formatter to convert (profiling, genome_binning, taxon_binning)"
    inputBinding:
      position: 1
      prefix: --results-type
  - id: bioboxes_version
    type:
      - 'null'
      - string
    doc: "bioboxes binning output format (default: 0.9.0)"
    inputBinding:
      position: 1
      prefix: --bioboxes-version
  - id: output
    type: string
    doc: "Path to write biobox formatted results"
    inputBinding:
      position: 1
      prefix: --output
outputs:
  - id: output_file
    type: File
    doc: "Biobox formatted results"
    outputBinding:
      glob: "$(inputs.output)"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/autometa:2.2.3--pyh7e72e81_0
