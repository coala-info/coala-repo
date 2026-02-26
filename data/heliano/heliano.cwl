cwlVersion: v1.2
class: CommandLineTool
baseCommand: heliano
label: heliano
doc: "heliano can detect and classify different variants of Helitron-like elements:
  HLE1 and HLE2.\n\nTool homepage: https://github.com/Zhenlisme/heliano"
inputs:
  - id: dis_denovo
    type:
      - 'null'
      - boolean
    doc: If you use this parameter, you refuse to search for LTS/RTS de novo, 
      instead you will only use the LTS/RTS information described in the 
      terminal sequence file.
    inputBinding:
      position: 101
      prefix: --dis_denovo
  - id: distance_domain
    type:
      - 'null'
      - int
    doc: The distance between HUH and Helicase domain
    default: 2500
    inputBinding:
      position: 101
      prefix: --distance_domain
  - id: distance_ts
    type:
      - 'null'
      - int
    doc: The maximum distance between LTS and RTS. If not specified, HELIANO 
      will set it as two times window size plus the maximum ORF length.
    inputBinding:
      position: 101
      prefix: --distance_ts
  - id: flank_sim
    type:
      - 'null'
      - float
    doc: The cut-off to define false positive LTS/RTS. The lower the value, the 
      more strigent.
    default: 0.5
    inputBinding:
      position: 101
      prefix: --flank_sim
  - id: genome
    type: File
    doc: The genome file in fasta format.
    inputBinding:
      position: 101
      prefix: --genome
  - id: is1
    type:
      - 'null'
      - int
    doc: 'Set the insertion site of autonomous HLE1 as A and T. 0: no, 1: yes (default).'
    default: 1
    inputBinding:
      position: 101
      prefix: --IS1
  - id: is2
    type:
      - 'null'
      - int
    doc: 'Set the insertion site of autonomous HLE2 as T and T. 0: no, 1: yes (default).'
    default: 1
    inputBinding:
      position: 101
      prefix: --IS2
  - id: multi_ts
    type:
      - 'null'
      - boolean
    doc: To allow an auto HLE to have multiple terminal sequences. If you enable
      this, you might find nonauto HLEs coming from the same auto HLE have 
      different terminal sequences.
    inputBinding:
      position: 101
      prefix: --multi_ts
  - id: nearest
    type:
      - 'null'
      - boolean
    doc: If you use this parameter, you will use the reciprocal-nearest LTS-RTS 
      pairs as final candidates. By default, HELIANO will try to use the 
      reciprocal-farthest pairs.
    inputBinding:
      position: 101
      prefix: --nearest
  - id: pair_helitron
    type:
      - 'null'
      - int
    doc: "For HLE1, its 5' and 3' terminal signal pairs should come from the same
      autonomous helitorn or not. 0: no, 1: yes (default)."
    default: 1
    inputBinding:
      position: 101
      prefix: --pair_helitron
  - id: process
    type:
      - 'null'
      - int
    doc: Maximum number of threads to be used.
    inputBinding:
      position: 101
      prefix: --process
  - id: pvalue
    type:
      - 'null'
      - float
    doc: The p-value for fisher's exact test.
    default: '1e-5'
    inputBinding:
      position: 101
      prefix: --pvalue
  - id: score
    type:
      - 'null'
      - int
    doc: The minimum bitscore of blastn for searching for homologous sequences 
      of terminal signals. From 30 to 55
    default: 32
    inputBinding:
      position: 101
      prefix: --score
  - id: simtir
    type:
      - 'null'
      - int
    doc: Set the simarity between short inverted repeats(TIRs) of HLE2.
    default: 100
    inputBinding:
      position: 101
      prefix: --simtir
  - id: table
    type:
      - 'null'
      - int
    doc: 'Code to use for the open reading fram prediction. 0: Standard (default);
      1: Ciliate Macronuclear and Dasycladacean; 2: Blepharisma Macronuclear; 3: Scenedesmus
      obliquus'
    default: 0
    inputBinding:
      position: 101
      prefix: --table
  - id: terminal_sequence
    type:
      - 'null'
      - File
    doc: The terminal sequence file. You can find it in the output of previous 
      run (named as pairlist.tbl).
    inputBinding:
      position: 101
      prefix: --terminal_sequence
  - id: window
    type:
      - 'null'
      - int
    doc: To check terminal signals within a given window bp upstream and 
      downstream of ORF ends.
    default: 10 kb
    inputBinding:
      position: 101
      prefix: --window
outputs:
  - id: opdir
    type: Directory
    doc: The output directory.
    outputBinding:
      glob: $(inputs.opdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/heliano:1.3.1--hdfd78af_0
