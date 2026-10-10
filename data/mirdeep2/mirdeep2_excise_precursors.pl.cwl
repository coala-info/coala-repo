cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - excise_precursors.pl
label: mirdeep2_excise_precursors.pl
doc: "Excise potential miRNA precursor sequences from a genome using read mappings in arf format\n\nTool homepage: https://github.com/rajewsky-lab/mirdeep2"
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
  - id: coords_file_name
    type: string
    doc: Name of the file the precursor genome coordinates are written to
    inputBinding:
      position: 3
  - id: min_stack_height
    type:
      - 'null'
      - int
    doc: Only excise if the potential mature miRNA is represented by a number of reads equal to or higher than this integer (default 2)
    inputBinding:
      position: 101
      prefix: -a
  - id: progress
    type:
      - 'null'
      - boolean
    doc: Output progress to screen
    inputBinding:
      position: 102
      prefix: -b
outputs:
  - id: precursors
    type: stdout
    doc: Excised precursor sequences in fasta format
  - id: coords
    type: File
    doc: Precursor genome coordinates
    outputBinding:
      glob: $(inputs.coords_file_name)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mirdeep2:2.0.1.3--hdfd78af_2
stdout: precursors.fa
