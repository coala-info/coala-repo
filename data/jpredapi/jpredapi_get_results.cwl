cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - jpredapi
  - get_results
label: jpredapi_get_results
doc: "Retrieves the results of a JPred API job.\n\nTool homepage: https://github.com/MoseleyBioinformaticsLab/jpredapi"
inputs:
  - id: extract
    type:
      - 'null'
      - boolean
    doc: Extract results tar.gz archive.
    inputBinding:
      position: 101
      prefix: --extract
  - id: jobid
    type: string
    doc: Job id
    inputBinding:
      position: 101
      prefix: --jobid
  - id: jpred4_address
    type:
      - 'null'
      - string
    doc: Address of Jpred4 server
    default: http://www.compbio.dundee.ac.uk/jpred4
    inputBinding:
      position: 101
      prefix: --jpred4
  - id: max_attempts
    type:
      - 'null'
      - int
    doc: Maximum number of attempts to check job status
    default: 10
    inputBinding:
      position: 101
      prefix: --attempts
  - id: rest_address
    type:
      - 'null'
      - string
    doc: REST address of server
    default: http://www.compbio.dundee.ac.uk/jpred4/cgi-bin/rest
    inputBinding:
      position: 101
      prefix: --rest
  - id: silent
    type:
      - 'null'
      - boolean
    doc: Do not print messages.
    inputBinding:
      position: 101
      prefix: --silent
  - id: wait_interval
    type:
      - 'null'
      - int
    doc: Wait interval before retrying to check job status in seconds
    default: 60
    inputBinding:
      position: 101
      prefix: --wait
outputs:
  - id: results_path
    type:
      - 'null'
      - Directory
    doc: Path to directory where to save archive with results
    outputBinding:
      glob: $(inputs.results_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jpredapi:1.5.6--py_0
