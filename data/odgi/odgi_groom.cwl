cwlVersion: v1.2
class: CommandLineTool
baseCommand: odgi groom
label: odgi_groom
doc: "Harmonize node orientations.\n\nTool homepage: https://github.com/vgteam/odgi"
inputs:
  - id: input_graph
    type: File
    doc: Load the succinct variation graph in ODGI format from this *FILE*. The 
      file name usually ends with *.og*. It also accepts GFAv1, but the 
      on-the-fly conversion to the ODGI format requires additional time!
    inputBinding:
      position: 101
      prefix: --idx
  - id: progress
    type:
      - 'null'
      - boolean
    doc: Write the current progress to stderr.
    inputBinding:
      position: 101
      prefix: --progress
  - id: target_paths
    type:
      - 'null'
      - File
    doc: Read the paths that should be considered as target paths (references) 
      from this *FILE*. odgi groom tries to force a forward orientation of all 
      steps for the given paths. A path's rank determines it's weight for 
      decision making and is given by its position in the given *FILE*.
    inputBinding:
      position: 101
      prefix: --target-paths
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for parallel operations.
    inputBinding:
      position: 101
      prefix: --threads
  - id: use_dfs
    type:
      - 'null'
      - boolean
    doc: Use depth-first search for grooming.
    inputBinding:
      position: 101
      prefix: --use-dfs
outputs:
  - id: output_graph
    type: File
    doc: Write the groomed succinct variation graph in ODGI format to *FILE*. A 
      file ending with *.og* is recommended.
    outputBinding:
      glob: $(inputs.output_graph)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/odgi:0.9.4--h077b44d_0
