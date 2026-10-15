cwlVersion: v1.2
class: CommandLineTool
label: primedlamp_PrimedLAMP
doc: "LAMP primer design: finds loop-mediated isothermal amplification primer sets in an aligned set of target sequences.\n\nTool homepage: https://github.com/MatthewHiggins2017/bioconda-PrimedRPA"
requirements:
  - class: ShellCommandRequirement
arguments:
  - position: -2
    valueFrom: echo y |
    shellQuote: false
  - position: -1
    valueFrom: PrimedLAMP
inputs:
  - id: run_id
    type: string
    doc: "Desired Run ID"
    inputBinding:
      position: 1
      prefix: --RunID
  - id: input_file
    type:
      - 'null'
      - File
    doc: "Path to Target Input Fasta File (aligned, equal length sequences)"
    inputBinding:
      position: 1
      prefix: --InputFile
  - id: prior_alignment_summary
    type:
      - 'null'
      - File
    doc: "Path to Prior Generated Alignment Summary"
    inputBinding:
      position: 1
      prefix: --PriorAlignmentSummary
  - id: prior_oligo_sites
    type:
      - 'null'
      - File
    doc: "Path to Prior Generated Oligo Sites"
    inputBinding:
      position: 1
      prefix: --PriorOligoSites
  - id: identity_threshold
    type:
      - 'null'
      - float
    doc: "Desired Identity Threshold"
    inputBinding:
      position: 1
      prefix: --IdentityThreshold
  - id: conserved_anchor
    type:
      - 'null'
      - int
    doc: "Identity Anchor Required"
    inputBinding:
      position: 1
      prefix: --ConservedAnchor
  - id: primer_length
    type:
      - 'null'
      - string
    doc: "Desired Primer Length (e.g. 15-16)"
    inputBinding:
      position: 1
      prefix: --PrimerLength
  - id: nucleotide_repeat_limit
    type:
      - 'null'
      - int
    doc: "Nucleotide Repeat Limit (i.e 5 = AAAAA)"
    inputBinding:
      position: 1
      prefix: --NucleotideRepeatLimit
  - id: min_gc
    type:
      - 'null'
      - int
    doc: "Minimum GC Content"
    inputBinding:
      position: 1
      prefix: --MinGC
  - id: max_gc
    type:
      - 'null'
      - int
    doc: "Maximum GC Content"
    inputBinding:
      position: 1
      prefix: --MaxGC
  - id: dimerisation_thresh
    type:
      - 'null'
      - int
    doc: "Percentage Dimerisation Tolerated"
    inputBinding:
      position: 1
      prefix: --DimerisationThresh
  - id: background_check
    type:
      - 'null'
      - File
    doc: "Path To Background Fasta File (leave unset for no background check); needs a samtools .fai index beside it"
    inputBinding:
      position: 1
      prefix: --BackgroundCheck
    secondaryFiles:
      - '.fai'
  - id: blast_db_path
    type:
      - 'null'
      - string
    doc: "Path to BlastnDB"
    inputBinding:
      position: 1
      prefix: --BlastDBPath
  - id: cross_reactivity_thresh
    type:
      - 'null'
      - float
    doc: "Max Cross Reactivity Threshold"
    inputBinding:
      position: 1
      prefix: --CrossReactivityThresh
  - id: threads
    type:
      - 'null'
      - int
    doc: "Default Set To 1"
    inputBinding:
      position: 1
      prefix: --Threads
  - id: monovalent_salt_conc
    type:
      - 'null'
      - float
    doc: "Millimolar Concentration (10^-3)"
    inputBinding:
      position: 1
      prefix: --MonovalentSaltConc
  - id: divalent_salt_conc
    type:
      - 'null'
      - float
    doc: "Millimolar Concentration (10^-3)"
    inputBinding:
      position: 1
      prefix: --DivalentSaltConc
  - id: d_ntp_conc
    type:
      - 'null'
      - float
    doc: "Millimolar Concentration (10^-3)"
    inputBinding:
      position: 1
      prefix: --dNTPConc
  - id: oligo_conc
    type:
      - 'null'
      - string
    doc: "Micromolar Concentration (10^-6)"
    inputBinding:
      position: 1
      prefix: --OligoConc
  - id: oligo_conc_pair
    type:
      - 'null'
      - string
    doc: "Leave as Default"
    inputBinding:
      position: 1
      prefix: --OligoConcPair
  - id: degenerate
    type:
      - 'null'
      - string
    doc: "Allow degenerate bases (YES or NO)"
    inputBinding:
      position: 1
      prefix: --Degenerate
  - id: minimum_tm
    type:
      - 'null'
      - float
    doc: "Minimum melting temperature"
    inputBinding:
      position: 1
      prefix: --MinimumTm
  - id: maximum_tm
    type:
      - 'null'
      - float
    doc: "Maximum melting temperature"
    inputBinding:
      position: 1
      prefix: --MaximumTm
  - id: tm_difference_limit
    type:
      - 'null'
      - float
    doc: "Tm difference limit"
    inputBinding:
      position: 1
      prefix: --TmDifferenceLimit
  - id: minimum_terminal_delta_g
    type:
      - 'null'
      - float
    doc: "Minimum terminal delta G"
    inputBinding:
      position: 1
      prefix: --MinimumTerminalDeltaG
  - id: max_distance3to2
    type:
      - 'null'
      - float
    doc: "Maximum distance 3 to 2"
    inputBinding:
      position: 1
      prefix: --MaxDistance3to2
  - id: max_distance2to_l
    type:
      - 'null'
      - float
    doc: "Maximum distance 2 to L"
    inputBinding:
      position: 1
      prefix: --MaxDistance2toL
  - id: max_distance2to1
    type:
      - 'null'
      - float
    doc: "Maximum distance 2 to 1"
    inputBinding:
      position: 1
      prefix: --MaxDistance2to1
  - id: max_distance1to1
    type:
      - 'null'
      - float
    doc: "Maximum distance 1 to 1"
    inputBinding:
      position: 1
      prefix: --MaxDistance1to1
  - id: max_distance2to2
    type:
      - 'null'
      - float
    doc: "Maximum distance 2 to 2"
    inputBinding:
      position: 1
      prefix: --MaxDistance2to2
  - id: background_search_sensitivity
    type:
      - 'null'
      - string
    doc: "Options [Basic or Advanced or Fast]"
    inputBinding:
      position: 1
      prefix: --BackgroundSearchSensitivity
  - id: evalue_thresh
    type:
      - 'null'
      - int
    doc: "E-value threshold for the background search"
    inputBinding:
      position: 1
      prefix: --EvalueThresh
  - id: f3_set_limit
    type:
      - 'null'
      - int
    doc: "Set Limit with for identical F3 Primer"
    inputBinding:
      position: 1
      prefix: --F3SetLimit
  - id: loop_primers
    type:
      - 'null'
      - string
    doc: "Include Loop Primers (YES or NO)"
    inputBinding:
      position: 1
      prefix: --LoopPrimers
outputs:
  - id: output_files
    type:
      type: array
      items: File
    doc: Result tables written with the run ID as prefix
    outputBinding:
      glob: $(inputs.run_id)_*.csv
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/primedlamp:1.0.1--py_0
stdout: primedlamp_PrimedLAMP.out
