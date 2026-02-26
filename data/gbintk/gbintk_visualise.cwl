cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gbintk
  - visualise
label: gbintk_visualise
doc: "Visualise binning and refinement results\n\nTool homepage: https://github.com/metagentools/gbintk"
inputs:
  - id: assembler
    type: string
    doc: name of the assembler used (SPAdes, MEGAHIT or Flye)
    inputBinding:
      position: 101
      prefix: --assembler
  - id: contigs
    type: File
    doc: path to the contigs file
    inputBinding:
      position: 101
      prefix: --contigs
  - id: delimiter
    type:
      - 'null'
      - string
    doc: delimiter for input/output results. Supports a comma and a tab.
    default: comma
    inputBinding:
      position: 101
      prefix: --delimiter
  - id: dpi
    type:
      - 'null'
      - int
    doc: dpi value
    default: 300
    inputBinding:
      position: 101
      prefix: --dpi
  - id: final
    type: Directory
    doc: path to the final binning result
    inputBinding:
      position: 101
      prefix: --final
  - id: graph
    type: File
    doc: path to the assembly graph file
    inputBinding:
      position: 101
      prefix: --graph
  - id: height
    type:
      - 'null'
      - int
    doc: height of the image in pixels
    default: 2000
    inputBinding:
      position: 101
      prefix: --height
  - id: imgtype
    type:
      - 'null'
      - string
    doc: type of the image (png, eps, pdf, svg)
    default: png
    inputBinding:
      position: 101
      prefix: --imgtype
  - id: initial
    type: Directory
    doc: path to the initial binning result
    inputBinding:
      position: 101
      prefix: --initial
  - id: lsize
    type:
      - 'null'
      - int
    doc: size of the vertex labels
    default: 8
    inputBinding:
      position: 101
      prefix: --lsize
  - id: margin
    type:
      - 'null'
      - int
    doc: margin of the figure
    default: 50
    inputBinding:
      position: 101
      prefix: --margin
  - id: paths
    type:
      - 'null'
      - File
    doc: path to the contigs.paths (metaSPAdes) or assembly.info (metaFlye) file
    inputBinding:
      position: 101
      prefix: --paths
  - id: prefix
    type:
      - 'null'
      - string
    doc: prefix for the output file
    default: '""'
    inputBinding:
      position: 101
      prefix: --prefix
  - id: vsize
    type:
      - 'null'
      - int
    doc: size of the vertices
    default: 50
    inputBinding:
      position: 101
      prefix: --vsize
  - id: width
    type:
      - 'null'
      - int
    doc: width of the image in pixels
    default: 2000
    inputBinding:
      position: 101
      prefix: --width
outputs:
  - id: output
    type: Directory
    doc: path to the output folder
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gbintk:1.0.3--py310h9ee0642_0
