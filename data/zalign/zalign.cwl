cwlVersion: v1.2
class: CommandLineTool
baseCommand: zalign
label: zalign
doc: "zalign 0.9.1 (C) 2006-2009 zAlign Team\n\nTool homepage: https://github.com/Zuehlke/ZAlign"
inputs:
  - id: file1
    type: File
    doc: First input file
    inputBinding:
      position: 1
  - id: file2
    type: File
    doc: Second input file
    inputBinding:
      position: 2
  - id: hblk
    type:
      - 'null'
      - int
    doc: (mpialign only) number of horizontal subdivisions made by each node to 
      its alignment submatrix; since this value defines block width, a good 
      choice should allow two full matrix lines to fit the processor's cache 
      pages, improving algorithm performance
    inputBinding:
      position: 103
      prefix: -H
  - id: scores
    type:
      - 'null'
      - string
    doc: specify a comma-separated list of scores to be used while calculating 
      aligment matrices throughout the program. The list must be in the format 
      "-sMATCH,MISMATCH,GAP_OPEN,GAP_EXTENSION" (without quotes), and is parsed 
      in this PRECISE order; no spaces are allowed between values. If there are 
      any unspecified parameters, these are set to default values and a warning 
      message is issued; exceeding parameters are discarded
    inputBinding:
      position: 103
      prefix: -s
  - id: split
    type:
      - 'null'
      - int
    doc: (mpialign only) number of parts in which to split the alignment matrix;
      after this step a cyclic block model is applied, subdividing each part 
      equally between all available nodes
    inputBinding:
      position: 103
      prefix: -S
  - id: vblk
    type:
      - 'null'
      - int
    doc: (mpialign only) number of vertical subdivisions made by each node to 
      its alignment submatrix; this value directly affects the amount of 
      internode communication and is used ONLY if 'split' is set to 1, otherwise
      it is set to the number of available nodes
    inputBinding:
      position: 103
      prefix: -V
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/zalign:v0.9.1-4-deb_cv1
stdout: zalign.out
