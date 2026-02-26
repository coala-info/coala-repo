cwlVersion: v1.2
class: CommandLineTool
baseCommand: ct2dot
label: rnastructure_ct2dot
doc: "Convert a CT structure file to dot-bracket format.\n\nTool homepage: http://rna.urmc.rochester.edu/RNAstructure.html"
inputs:
  - id: ct_file
    type: File
    doc: The name of a file containing the CT structure to convert. If the name 
      is a hyphen (-) the file will be read from standard input (STDIN).
    inputBinding:
      position: 1
  - id: structure_number
    type: string
    doc: The number, one-indexed, of the structure to convert in the CT file 
      (use -1 or "ALL" to convert all structures).
    inputBinding:
      position: 2
  - id: format
    type:
      - 'null'
      - string
    doc: "A number or name that indicates how subsequent sub-structures are formatted
      (relevant only when more than one structure is being written). Valid values
      are: (1) simple -- Susbequent structures (after the first one) are written with
      a Structure-Line '(((....)))' only -- (no title or sequence), (2) side -- A
      structure label is appended to the right side of each Structure-Line e.g. '(((....)))\
      \  ENERGY= -3.6  E.coli', (3) multi -- Susbequent structures are each written
      with a Title-Line '>TITLE' followed by a Structure-Line, (4) full -- All structures
      written with a full header, including a '>TITLE' line followed by a Sequence-Line
      and then a Structure-Line."
    default: multi
    inputBinding:
      position: 103
      prefix: --format
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Suppress unnecessary output. This option is implied when the output 
      file is '-' (STDOUT).
    inputBinding:
      position: 103
      prefix: --quiet
outputs:
  - id: bracket_file
    type: File
    doc: The name of a dot bracket file to which output will be written. If the 
      name is a hyphen (-), the converted file will be written to standard 
      output (STDOUT) instead of a file.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rnastructure:6.5--hde5307d_0
