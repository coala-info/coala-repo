cwlVersion: v1.2
class: CommandLineTool
baseCommand: odgi stepindex
label: odgi_stepindex
doc: "Generate a step index from a given graph. If no output file is provided via
  *-o, --out*, the index will be directly written to *INPUT_GRAPH.stpidx*.\n\nTool
  homepage: https://github.com/vgteam/odgi"
inputs:
  - id: input_graph
    type: File
    doc: Load the succinct variation graph in ODGI format from this *FILE*. The 
      file name usually ends with *.og*. It also accepts GFAv1, but the 
      on-the-fly conversion to the ODGI format requires additional time!
    inputBinding:
      position: 101
      prefix: --input
  - id: progress
    type:
      - 'null'
      - boolean
    doc: Write the current progress to stderr.
    inputBinding:
      position: 101
      prefix: --progress
  - id: step_index_sample_rate
    type:
      - 'null'
      - int
    doc: The sample rate when building the step index. We index a node only if 
      mod(node_id, step-index-sample-rate) == 0! Number must be dividable by 2 
      or 0 to disable sampling.
    inputBinding:
      position: 101
      prefix: --step-index-sample-rate
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for parallel operations.
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Write the created step index to the specified file. A file ending with 
      *.stpidx* is recommended.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/odgi:0.9.4--h077b44d_0
