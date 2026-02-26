cwlVersion: v1.2
class: CommandLineTool
baseCommand: enasearch_get_taxonomy_results
label: enasearch_get_taxonomy_results
doc: "Get taxonomy results for a given accession.\n\nTool homepage: http://bebatut.fr/enasearch/"
inputs:
  - id: type
    type: string
    doc: 'Type of object to retrieve taxonomy for. Possible values: noncoding_release,
      sequence_release, study, read_trace, coding_release, sample, read_run, read_study,
      read_experiment, analysis, sequence_update, coding_update, analysis_study, noncoding_update.'
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/enasearch:0.2.2--py27_0
stdout: enasearch_get_taxonomy_results.out
