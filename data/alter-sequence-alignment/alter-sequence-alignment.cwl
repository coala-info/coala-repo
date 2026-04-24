cwlVersion: v1.2
class: CommandLineTool
baseCommand: alter-sequence-alignment
label: alter-sequence-alignment
doc: A tool for converting and manipulating sequence alignment files, including 
  collapsing sequences to haplotypes.
inputs:
  - id: collapse
    type:
      - 'null'
      - boolean
    doc: Collapse sequences to haplotypes.
    inputBinding:
      position: 101
      prefix: --collapse
  - id: collapse_gaps
    type:
      - 'null'
      - boolean
    doc: Treat gaps as missing data when collapsing.
    inputBinding:
      position: 101
      prefix: --collapseGaps
  - id: collapse_limit
    type:
      - 'null'
      - int
    doc: Connection limit (sequences differing at <= l sites will be collapsed) 
      (default is l=0).
    inputBinding:
      position: 101
      prefix: --collapseLimit
  - id: collapse_missing
    type:
      - 'null'
      - boolean
    doc: Count missing data as differences when collapsing.
    inputBinding:
      position: 101
      prefix: --collapseMissing
  - id: input
    type:
      - 'null'
      - File
    doc: Input file.
    inputBinding:
      position: 101
      prefix: --input
  - id: input_autodetect
    type:
      - 'null'
      - boolean
    doc: Autodetect format (other input options are omitted).
    inputBinding:
      position: 101
      prefix: --inputAutodetect
  - id: input_format
    type:
      - 'null'
      - string
    doc: Input format (ALN, FASTA, GDE, MEGA, MSF, NEXUS, PHYLIP or PIR).
    inputBinding:
      position: 101
      prefix: --inputFormat
  - id: input_os
    type:
      - 'null'
      - string
    doc: Input operating system (Linux, MacOS or Windows).
    inputBinding:
      position: 101
      prefix: --inputOS
  - id: input_program
    type:
      - 'null'
      - string
    doc: Input program (Clustal, MAFFT, MUSCLE, PROBCONS or TCoffee).
    inputBinding:
      position: 101
      prefix: --inputProgram
  - id: output_format
    type:
      - 'null'
      - string
    doc: Output format (ALN, FASTA, GDE, MEGA, MSF, NEXUS, PHYLIP or PIR).
    inputBinding:
      position: 101
      prefix: --outputFormat
  - id: output_lower_case
    type:
      - 'null'
      - boolean
    doc: Lowe case output.
    inputBinding:
      position: 101
      prefix: --outputLowerCase
  - id: output_match
    type:
      - 'null'
      - boolean
    doc: Output match characters.
    inputBinding:
      position: 101
      prefix: --outputMatch
  - id: output_os
    type:
      - 'null'
      - string
    doc: Output operating system (Linux, MacOS or Windows).
    inputBinding:
      position: 101
      prefix: --outputOS
  - id: output_program
    type:
      - 'null'
      - string
    doc: Output program (jModelTest, MrBayes, PAML, PAUP, PhyML, ProtTest, 
      RAxML, TCS, CodABC, BioEdit, MEGA, dnaSP, Se-Al, Mesquite, SplitsTree, 
      Clustal, MAFFT, MUSCLE, PROBCONS, TCoffee, Gblocks, SeaView, trimAl or 
      GENERAL)
    inputBinding:
      position: 101
      prefix: --outputProgram
  - id: output_residue_numbers
    type:
      - 'null'
      - boolean
    doc: Output residue numbers (only ALN format).
    inputBinding:
      position: 101
      prefix: --outputResidueNumbers
  - id: output_sequential
    type:
      - 'null'
      - boolean
    doc: Sequential output (only NEXUS and PHYLIP formats).
    inputBinding:
      position: 101
      prefix: --outputSequential
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output file.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/alter-sequence-alignment:v1.3.4-2-deb_cv1
