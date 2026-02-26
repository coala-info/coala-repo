cwlVersion: v1.2
class: CommandLineTool
baseCommand: odgi explode
label: odgi_explode
doc: "Breaks a graph into connected components storing each component in its own file.\n\
  \nTool homepage: https://github.com/vgteam/odgi"
inputs:
  - id: biggest
    type:
      - 'null'
      - int
    doc: 'Specify the number of the biggest connected components to write, sorted
      by decreasing size (default: disabled, for writing them all).'
    inputBinding:
      position: 101
      prefix: --biggest
  - id: idx
    type: File
    doc: Load the succinct variation graph in ODGI format from this *FILE*. The 
      file name usually ends with *.og*. It also accepts GFAv1, but the 
      on-the-fly conversion to the ODGI format requires additional time!
    inputBinding:
      position: 101
      prefix: --idx
  - id: optimize
    type:
      - 'null'
      - boolean
    doc: Compact the node ID space in each connected component.
    inputBinding:
      position: 101
      prefix: --optimize
  - id: prefix
    type:
      - 'null'
      - string
    doc: 'Write each connected component to a file with the given STRING prefix. The
      file for the component number `i` will be named `STRING.i.EXTENSION` (default:
      `component.i.og` or `component.i.gfa`).'
    inputBinding:
      position: 101
      prefix: --prefix
  - id: progress
    type:
      - 'null'
      - boolean
    doc: Print information about the components and the progress to stderr.
    inputBinding:
      position: 101
      prefix: --progress
  - id: sorting_criteria
    type:
      - 'null'
      - string
    doc: 'Specify how to sort the connected components by size: p) Path mass (total
      number of path bases) (default). l) Graph length (number of node bases). n)
      Number of nodes. P) Longest path.'
    inputBinding:
      position: 101
      prefix: --sorting-criteria
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for parallel operations.
    inputBinding:
      position: 101
      prefix: --threads
  - id: to_gfa
    type:
      - 'null'
      - boolean
    doc: Write each connected component to a file in GFAv1 format.
    inputBinding:
      position: 101
      prefix: --to-gfa
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/odgi:0.9.4--h077b44d_0
stdout: odgi_explode.out
