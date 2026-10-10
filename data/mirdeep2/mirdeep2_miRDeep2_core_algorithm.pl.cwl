cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - miRDeep2_core_algorithm.pl
label: mirdeep2_miRDeep2_core_algorithm.pl
doc: "Core algorithm of miRDeep: score potential miRNA precursors from read signatures (blastparsed/arf format) and RNAfold structures\n\nTool homepage: https://github.com/rajewsky-lab/mirdeep2"
inputs:
  - id: file_signature
    type: File
    doc: Signature file in arf format with the positions of reads aligned to potential precursors
    inputBinding:
      position: 1
  - id: file_structure
    type: File
    doc: RNAfold output file with sequence, structure and minimum free energy of the potential precursors
    inputBinding:
      position: 2
  - id: known_mirnas
    type:
      - 'null'
      - File
    doc: Fasta file with known mature miRNAs, used for conservation (seed) information
    inputBinding:
      position: 101
      prefix: -s
  - id: print_filtered
    type:
      - 'null'
      - boolean
    doc: Print the potential precursors that do not exceed the cut-off (default prints those that exceed it)
    inputBinding:
      position: 101
      prefix: -t
  - id: ids_only
    type:
      - 'null'
      - boolean
    doc: "Limited output: print only the ids of the potential precursors that exceed the cut-off"
    inputBinding:
      position: 101
      prefix: -u
  - id: cutoff
    type:
      - 'null'
      - float
    doc: Score cut-off (default 1)
    inputBinding:
      position: 101
      prefix: -v
  - id: sensitive_sanger
    type:
      - 'null'
      - boolean
    doc: Sensitive option for Sanger sequences obtained through conventional cloning
    inputBinding:
      position: 101
      prefix: -x
  - id: randfold_pvalues
    type:
      - 'null'
      - File
    doc: File with randfold p-values
    inputBinding:
      position: 101
      prefix: -y
  - id: drosha_processing
    type:
      - 'null'
      - boolean
    doc: Consider the number of base pairings in the lower stems (Drosha processing; not well tested)
    inputBinding:
      position: 101
      prefix: -z
  - id: column_width
    type:
      - 'null'
      - int
    doc: Width of the first output column (default 40)
    inputBinding:
      position: 101
      prefix: -l
outputs:
  - id: stdout
    type: stdout
    doc: Scored potential precursors in mrd format
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mirdeep2:2.0.1.3--hdfd78af_2
stdout: output.mrd
