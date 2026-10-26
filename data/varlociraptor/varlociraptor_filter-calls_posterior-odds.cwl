cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - varlociraptor
  - filter-calls
  - posterior-odds
label: varlociraptor_filter-calls_posterior-odds
doc: 'Filter variant calls by posterior odds of given events against the rest of events.
  Calls are taken from standard input, filtered calls are printed to standard output.


  Tool homepage: https://varlociraptor.github.io'
inputs:
  - id: calls
    type: File
    doc: Varlociraptor calls in BCF format (standard input).
  - id: events
    type:
      - 'null'
      - type: array
        items: string
    doc: Events to consider.
    inputBinding:
      position: 100
      prefix: --events
  - id: odds
    type:
      - 'null'
      - string
    doc: 'Kass-Raftery score to filter against: none, barely, positive, strong, very-strong'
    inputBinding:
      position: 100
      prefix: --odds
outputs:
  - id: filtered_calls
    type: stdout
    doc: Filtered calls in BCF format
stdin: $(inputs.calls.path)
stdout: calls.filtered.bcf
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/varlociraptor:8.9.5--h24073b4_0
