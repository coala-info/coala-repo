cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tf_result_explanations
label: dastk_tf_result_explanations
doc: "Find known relations (from public pathway knowledge) between the TFs with a
  significant change in activity in DAStk differential MD score results and write a
  report.\n\nTool homepage: https://github.com/Dowell-Lab/DAStk"
inputs:
  - id: p_value
    type:
      - 'null'
      - float
    doc: P-value cutoff to determine which TFs to include from DAStk's output
      (default=0.05).
    inputBinding:
      position: 101
      prefix: --p-value
  - id: dastk_results
    type: File
    doc: Results file from DAStk (*differential_md_scores.txt) used to find
      relations between the most significant TF changes in activity.
    inputBinding:
      position: 101
      prefix: --dastk-results
  - id: output_filename
    type: string
    doc: Output filename for the report.
    inputBinding:
      position: 101
      prefix: --output
  - id: uninteresting_nodes
    type:
      - 'null'
      - File
    doc: File listing ontology concept URIs to ignore during the pathway
      searches. One URI per line, optionally followed by a TAB and a
      description.
    inputBinding:
      position: 101
      prefix: --uninteresting-nodes
  - id: extra_concepts
    type:
      - 'null'
      - File
    doc: File listing extra ontology concepts to include in the pathway
      searches. Two TAB-separated columns, the ontology URI and a label for the
      report.
    inputBinding:
      position: 101
      prefix: --extra-concepts
outputs:
  - id: stdout
    type: stdout
    doc: Standard output (warnings)
  - id: report
    type: File
    doc: Report of the relations between the significant TFs
    outputBinding:
      glob: $(inputs.output_filename)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dastk:1.0.1--pyh7cba7a3_0
stdout: dastk_tf_result_explanations.out
