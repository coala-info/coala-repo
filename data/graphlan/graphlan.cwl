cwlVersion: v1.2
class: CommandLineTool
baseCommand: graphlan
label: graphlan
doc: "GraPhlAn 1.1.3 (5 June 2018) AUTHORS: Nicola Segata (nsegata@hsph.harvard.edu)\n\
  \nTool homepage: https://bitbucket.org/nsegata/graphlan/wiki/Home"
inputs:
  - id: input_tree
    type: File
    doc: the input tree in PhyloXML format
    inputBinding:
      position: 1
  - id: avoid_reordering
    type:
      - 'null'
      - boolean
    doc: specify whether the tree will be reorder or not (default the tree will 
      be reordered)
    inputBinding:
      position: 102
      prefix: --avoid_reordering
  - id: dpi
    type:
      - 'null'
      - int
    doc: the dpi of the output image for non vectorial formats
    inputBinding:
      position: 102
      prefix: --dpi
  - id: external_legends
    type:
      - 'null'
      - boolean
    doc: specify whether the two external legends should be put in separate file
      or keep them along with the image (default behavior)
    inputBinding:
      position: 102
      prefix: --external_legends
  - id: format
    type:
      - 'null'
      - string
    doc: set the format of the output image (default none meaning that the 
      format is guessed from the output file extension)
    default: none
    inputBinding:
      position: 102
      prefix: --format
  - id: pad
    type:
      - 'null'
      - float
    doc: the distance between the most external graphical element and the border
      of the image
    inputBinding:
      position: 102
      prefix: --pad
  - id: positions
    type:
      - 'null'
      - boolean
    doc: set whether the absolute position of the points should be reported on 
      the standard output. The two cohordinates are r and theta
    inputBinding:
      position: 102
      prefix: --positions
  - id: size
    type:
      - 'null'
      - float
    doc: the size of the output image (in inches, default 7.0)
    default: 7.0
    inputBinding:
      position: 102
      prefix: --size
  - id: warnings
    type:
      - 'null'
      - boolean
    doc: set whether warning messages should be reported or not (default 1)
    default: 1
    inputBinding:
      position: 102
      prefix: --warnings
outputs:
  - id: output_image
    type: File
    doc: 'the output image, the format is guessed from the extension unless --format
      is given. Available file formats are: png, pdf, ps, eps, svg'
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/graphlan:v1.1.3-1-deb_cv1
