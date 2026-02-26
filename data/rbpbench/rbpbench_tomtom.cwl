cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rbpbench
  - tomtom
label: rbpbench_tomtom
doc: "Search for motifs similar to --in in a database.\n\nTool homepage: https://github.com/michauhl/RBPBench"
inputs:
  - id: custom_db
    type:
      - 'null'
      - File
    doc: Provide custom motif database MEME/DREME XML file containing sequence 
      motifs to search against. By default internal database is used, define 
      which with --motif-db
    inputBinding:
      position: 101
      prefix: --custom-db
  - id: fe_mode
    type:
      - 'null'
      - int
    doc: Define whether to calculate function enrichment on RBP or single motif 
      level. 1) RBP level 2) single motif level
    default: 1
    inputBinding:
      position: 101
      prefix: --fe-mode
  - id: fe_pval
    type:
      - 'null'
      - float
    doc: RBP function enrichment p-value threshold
    default: 0.5
    inputBinding:
      position: 101
      prefix: --fe-pval
  - id: input_file
    type: string
    doc: Provide MEME XML style file path or (regular expression) sequence to 
      search for similar motifs in database. Currently only square bracket 
      containing regexes are supported
    inputBinding:
      position: 101
      prefix: --in
  - id: motif_db
    type:
      - 'null'
      - int
    doc: 'Built-in motif database used so search for motifs similar to --in. 1: human
      RBP motifs (257 RBPs, 599 motifs, "catrapid_omics_v2.1_human_6plus_ext"), 2:
      human RBP motifs + 23 ucRBP motifs (277 RBPs, 622 motifs, "catrapid_omics_v2.1_human_6plus_ext_ucrbps"),
      3: human RBP motifs from Ray et al. 2013 (80 RBPs, 102 motifs, "ray2013_human_rbps_rnacompete")'
    default: 1
    inputBinding:
      position: 101
      prefix: --motif-db
  - id: regex_mode
    type:
      - 'null'
      - int
    doc: 'If --in is regex/sequence with format e.g. AC[AT]A, define whether to split
      regex into single motifs (ACAA, ACTA), or to make one motif out of it. 1: convert
      to one motif. 2: convert to multiple single motifs'
    default: 1
    inputBinding:
      position: 101
      prefix: --regex-mode
  - id: tomtom_bfile
    type:
      - 'null'
      - File
    doc: 'Provide TOMTOM nucleotide frequencies (TOMTOM option: -bfile) file (default:
      use internal frequencies file, define which with --tomtom-ntf-mode)'
    inputBinding:
      position: 101
      prefix: --tomtom-bfile
  - id: tomtom_evalue
    type:
      - 'null'
      - boolean
    doc: 'Use E-value threshold instead of q-value (TOMTOM option: -evalue)'
    inputBinding:
      position: 101
      prefix: --tomtom-evalue
  - id: tomtom_m
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Use only query motifs with a specified ID, may be repeated (TOMTOM option:
      -m) file'
    inputBinding:
      position: 101
      prefix: --tomtom-m
  - id: tomtom_min_overlap
    type:
      - 'null'
      - int
    doc: 'Minimum overlap between query and target (TOMTOM option: -min-overlap)'
    default: 1
    inputBinding:
      position: 101
      prefix: --tomtom-min-overlap
  - id: tomtom_ntf_mode
    type:
      - 'null'
      - int
    doc: 'Set which internal nucleotide frequencies to use for TOMTOM. 1: use frequencies
      from human ENSEMBL transcripts (excluding introns, with A most prominent) 2:
      use frequencies from human ENSEMBL transcripts (including introns, resulting
      in lower G+C and T most prominent) 3: use uniform frequencies (same for every
      nucleotide)'
    default: 1
    inputBinding:
      position: 101
      prefix: --tomtom-ntf-mode
  - id: tomtom_thresh
    type:
      - 'null'
      - float
    doc: 'TOMTOM q-value threshold (TOMTOM option: -thresh)'
    default: 0.5
    inputBinding:
      position: 101
      prefix: --tomtom-thresh
outputs:
  - id: output_folder
    type: Directory
    doc: Results output folder
    outputBinding:
      glob: $(inputs.output_folder)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rbpbench:1.1.0--pyhdfd78af_0
