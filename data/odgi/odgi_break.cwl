cwlVersion: v1.2
class: CommandLineTool
baseCommand: odgi break
label: odgi_break
doc: "Break cycles in the graph and drop its paths.\n\nTool homepage: https://github.com/vgteam/odgi"
inputs:
  - id: cycle_max_bp
    type:
      - 'null'
      - int
    doc: The maximum cycle length at which to break
    inputBinding:
      position: 101
      prefix: --cycle-max-bp
  - id: idx
    type: File
    doc: Load the succinct variation graph in ODGI format from this *FILE*. The 
      file name usually ends with *.og*. It also accepts GFAv1, but the 
      on-the-fly conversion to the ODGI format requires additional time!
    inputBinding:
      position: 101
      prefix: --idx
  - id: max_search_bp
    type:
      - 'null'
      - int
    doc: The maximum search space of each BFS given in number of base pairs
    inputBinding:
      position: 101
      prefix: --max-search-bp
  - id: progress
    type:
      - 'null'
      - boolean
    doc: Write the current progress to stderr.
    inputBinding:
      position: 101
      prefix: --progress
  - id: repeat_up_to
    type:
      - 'null'
      - int
    doc: Iterate cycle breaking up to N times, or stop if no new edges are 
      removed.
    inputBinding:
      position: 101
      prefix: --repeat-up-to
  - id: show
    type:
      - 'null'
      - boolean
    doc: print edges we would remove
    inputBinding:
      position: 101
      prefix: --show
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for parallel operations.
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: out
    type: File
    doc: Write the broken graph in ODGI format to FILE. A file ending of *.og* 
      is recommended.
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/odgi:0.9.4--h077b44d_0
