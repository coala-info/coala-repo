cwlVersion: v1.2
class: CommandLineTool
baseCommand: igphyml
label: igphyml
doc: "IgPhyML 1.1.5 09022\n\nTool homepage: https://igphyml.readthedocs.io/en/latest/index.html"
inputs:
  - id: frequencies
    type:
      - 'null'
      - string
    doc: 'empirical: (GY default) the equilibrium codon frequencies are estimated
      by counting the occurence of bases or codons in the alignment. optimize : (HLP17
      default) codon frequencies are estimated using maximum likelihood'
    inputBinding:
      position: 101
      prefix: -f
  - id: frequency_model
    type:
      - 'null'
      - string
    doc: Which frequency model to use. frequency model = F1XCODONS | F1X4 | F3X4
      | CF3X4 (default)
    inputBinding:
      position: 101
      prefix: --fmodel
  - id: hotness
    type:
      - 'null'
      - string
    doc: Set number hot- and coldspot rates to estimate. May specify multiple 
      values according to --motifs option. 'e,e,e,e,e,e' is default.
    inputBinding:
      position: 101
      prefix: --hotness
  - id: hotness_param
    type:
      - 'null'
      - string
    doc: Set number hot- and coldspot rates to estimate. May specify multiple 
      values according to --motifs option. 'e,e,e,e,e,e' is default.
    inputBinding:
      position: 101
      prefix: --hotness
  - id: min_seq
    type:
      - 'null'
      - int
    doc: Minimum number of sequences (including germline) per lineage for 
      inclusion in analysis.
    inputBinding:
      position: 101
      prefix: --minSeq
  - id: model
    type: string
    doc: 'substitution model name. Codon based models: HLP (HLP19) | GY | HLP17 Use
      GY for quick tree construction. HLP for B cell specific features (see docs).'
    inputBinding:
      position: 101
      prefix: -m
  - id: motifs
    type:
      - 'null'
      - string
    doc: 'Specify hot- and coldspot motifs to be modeled. motifs = FCH (default) :
      Free coldspots and hotspots. Estimate separate rates for six canonical motifs.
      Otherwise, motifs specified by <motif>_<mutable position>:<index_in_hotness>.
      motifs = WRC_2:0 | GYW_0:0 | WA_1:0 | TW_0:0 | SYC_2:0 | GRS_0:0 : Model rate
      specific motif(s). e.g. motifs = WRC_2:0,GYW_0:0 symmetric WR C/G YW motifs.
      e.g. motifs = WRC_2:0,GYW_0:1 asymmetric WR C/G YW motifs. Must specify two
      values in --hotness.'
    inputBinding:
      position: 101
      prefix: --motifs
  - id: omega
    type:
      - 'null'
      - string
    doc: Set number/value of omegas to estimate. First value (0) corresponds to 
      FWRs, second (1) to CDRs. May specify multiple omegas if partition file(s)
      specified.
    inputBinding:
      position: 101
      prefix: --omega
  - id: optimize
    type:
      - 'null'
      - string
    doc: 'This option focuses on specific parameter optimisation. params = tlr : (default)
      tree topology (t), branch length (l) and rate parameters (r) are optimised.
      params = tl  : tree topology and branch length are optimised. params = lr  :
      branch length and rate parameters are optimised. params = l   : branch length
      are optimised. params = r   : rate parameters are optimised. params = n   :
      no parameter is optimised.'
    inputBinding:
      position: 101
      prefix: -o
  - id: partfile
    type:
      - 'null'
      - File
    doc: Partition file specifying CDRs/FWRs for sequence file.
    inputBinding:
      position: 101
      prefix: --partfile
  - id: repfile
    type:
      - 'null'
      - File
    doc: File specifying input files for repertoire analysis (see docs). Use 
      BuildTrees.py (https://changeo.readthedocs.io) to generate lineages file.
    inputBinding:
      position: 101
      prefix: --repfile
  - id: run_id
    type:
      - 'null'
      - string
    doc: Append the string ID_string at the end of each output file.
    inputBinding:
      position: 101
      prefix: --run_id
  - id: search
    type:
      - 'null'
      - string
    doc: Tree topology search operation option. Can be either NNI (default, 
      fast) or SPR (thorough, slow).
    inputBinding:
      position: 101
      prefix: -s
  - id: sequence_file
    type:
      - 'null'
      - File
    doc: Codon-aligned sequence file in FASTA or PHYLIP format.
    inputBinding:
      position: 101
      prefix: -i
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for parallelization. Default is 1.
    inputBinding:
      position: 101
      prefix: --threads
  - id: ts_tv_ratio
    type:
      - 'null'
      - string
    doc: Set the transition/transversion ratio.
    inputBinding:
      position: 101
      prefix: --omega
  - id: user_tree_file
    type:
      - 'null'
      - File
    doc: starting tree filename. The tree must be in Newick format.
    inputBinding:
      position: 101
      prefix: -u
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/igphyml:1.1.5--h7b50bb2_2
stdout: igphyml.out
