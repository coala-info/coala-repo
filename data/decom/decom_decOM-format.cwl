cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - decOM-format
label: decom_decOM-format
doc: "Feature of decOM to compare and adapt the output format of FEAST and ST results\n\nTool
  homepage: https://github.com/CamilaDuitama/decOM"
inputs:
  - id: method
    type:
      type: enum
      symbols:
        - FEAST
        - ST
    doc: Method used to produce the output table you want to reformat (FEAST
      or ST)
    inputBinding:
      position: 101
      prefix: --method
  - id: mst_table
    type: File
    doc: Output table you are interested in reformatting. It should be a tab
      separated file (FEAST result, or SourceTracker mixing_proportions.txt
      with sources as rows and sinks as columns).
    inputBinding:
      position: 101
      prefix: --MST_table
  - id: map_file
    type: File
    doc: map.txt used by ST/FEAST (tab separated, with SourceSink and Env
      columns).
    inputBinding:
      position: 101
      prefix: --map
  - id: output_file
    type: string
    doc: Name of output file
    default: decOM_format.csv
    inputBinding:
      position: 101
      prefix: --output_file
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: formatted_table
    type: File
    doc: Reformatted table (comma separated) with the percentage of each source
      environment and the environment with the highest contribution
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/decom:0.0.32--pyhdfd78af_2
