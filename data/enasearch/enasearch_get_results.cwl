cwlVersion: v1.2
class: CommandLineTool
baseCommand: enasearch_get_results
label: enasearch_get_results
doc: "Get results from ENA.\n\nTool homepage: http://bebatut.fr/enasearch/"
inputs:
  - id: result_type
    type: string
    doc: 'Type of result to retrieve. Available types: noncoding_release, assembly,
      sequence_release, wgs_set, study, taxon, coding_release, sample, environmental,
      read_run, read_study, read_experiment, analysis, sequence_update, coding_update,
      tsa_set, analysis_study, noncoding_update'
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/enasearch:0.2.2--py27_0
stdout: enasearch_get_results.out
