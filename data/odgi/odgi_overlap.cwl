cwlVersion: v1.2
class: CommandLineTool
baseCommand: odgi_overlap
label: odgi_overlap
doc: "Find the paths touched by given input paths.\n\nTool homepage: https://github.com/vgteam/odgi"
inputs:
  - id: bed_input_file
    type:
      - 'null'
      - File
    doc: A BED FILE of ranges in paths in the graph.
    inputBinding:
      position: 101
      prefix: --bed-input
  - id: input_file
    type: File
    doc: Load the succinct variation graph in ODGI format from this *FILE*. The 
      file name usually ends with *.og*. It also accepts GFAv1, but the 
      on-the-fly conversion to the ODGI format requires additional time!
    inputBinding:
      position: 101
      prefix: --input
  - id: path_name
    type:
      - 'null'
      - string
    doc: Perform the search of the given path STRING in the graph.
    inputBinding:
      position: 101
      prefix: --path
  - id: paths_file
    type:
      - 'null'
      - File
    doc: Report the search results only for the paths listed in FILE.
    inputBinding:
      position: 101
      prefix: --paths
  - id: progress
    type:
      - 'null'
      - boolean
    doc: Write the current progress to stderr.
    inputBinding:
      position: 101
      prefix: --progress
  - id: subset_paths_file
    type:
      - 'null'
      - File
    doc: Perform the search considering only the paths specified in the FILE. 
      The file must contain one path name per line and a subset of all paths can
      be specified.When searching the overlaps, only these paths will be 
      considered.
    inputBinding:
      position: 101
      prefix: --subset-paths
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for parallel operations.
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/odgi:0.9.4--h077b44d_0
stdout: odgi_overlap.out
