cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - excise_precursors_iterative_final.pl
label: mirdeep2_excise_precursors_iterative_final.pl
doc: "Excise potential miRNA precursor sequences from a genome, raising the read stack height until fewer than the maximum number of precursors remain\n\nTool homepage: https://github.com/rajewsky-lab/mirdeep2"
inputs:
  - id: genome
    type: File
    doc: Fasta file with the relevant genome
    inputBinding:
      position: 1
  - id: mappings
    type: File
    doc: Read mappings in arf format
    inputBinding:
      position: 2
  - id: precursors_file_name
    type: string
    doc: Name of the fasta file the excised precursors are written to
    inputBinding:
      position: 3
  - id: coords_file_name
    type: string
    doc: Name of the file the precursor genome coordinates are written to
    inputBinding:
      position: 4
  - id: max_precursors
    type: int
    doc: Maximum number of precursors to excise; a negative number keeps the lowest stack height
    inputBinding:
      position: 5
  - id: progress
    type:
      - 'null'
      - boolean
    doc: Output progress to screen
    inputBinding:
      position: 101
      prefix: -b
outputs:
  - id: precursors
    type: File
    doc: Excised precursor sequences in fasta format
    outputBinding:
      glob: $(inputs.precursors_file_name)
  - id: coords
    type: File
    doc: Precursor genome coordinates
    outputBinding:
      glob: $(inputs.coords_file_name)
  - id: stack_height
    type: File
    doc: Read stack height that was used
    outputBinding:
      glob: $(inputs.precursors_file_name)_stack
  - id: all_precursors
    type:
      - 'null'
      - File
    doc: Precursors for all stack heights (intermediate)
    outputBinding:
      glob: $(inputs.precursors_file_name)_all
  - id: all_coords
    type:
      - 'null'
      - File
    doc: Coordinates for all stack heights (intermediate)
    outputBinding:
      glob: $(inputs.coords_file_name)_all
  - id: stderr
    type: stderr
    doc: Number of precursors per stack height
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mirdeep2:2.0.1.3--hdfd78af_2
stderr: excise_iterative.err
