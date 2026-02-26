cwlVersion: v1.2
class: CommandLineTool
baseCommand: PrimedRPA
label: primedrpa_PrimedRPA
doc: "Finding RPA Primer and Probe Sets\n\nTool homepage: https://github.com/MatthewHiggins2017/bioconda-PrimedRPA/"
inputs:
  - id: amplicon_size_limit
    type:
      - 'null'
      - int
    doc: Amplicon Size Limit
    inputBinding:
      position: 101
      prefix: --AmpliconSizeLimit
  - id: background_check
    type:
      - 'null'
      - string
    doc: Options [NO, Path To Background Fasta File]
    inputBinding:
      position: 101
      prefix: --BackgroundCheck
  - id: background_search_sensitivity
    type:
      - 'null'
      - string
    doc: Options [Basic or Advanced or Fast]
    inputBinding:
      position: 101
      prefix: --BackgroundSearchSensitivity
  - id: conserved_anchor
    type:
      - 'null'
      - float
    doc: Identity Anchor Required
    inputBinding:
      position: 101
      prefix: --ConservedAnchor
  - id: cross_reactivity_thresh
    type:
      - 'null'
      - float
    doc: Max Cross Reactivity Threshold
    inputBinding:
      position: 101
      prefix: --CrossReactivityThresh
  - id: dimerisation_thresh
    type:
      - 'null'
      - float
    doc: Percentage Dimerisation Tolerated
    inputBinding:
      position: 101
      prefix: --DimerisationThresh
  - id: evalue
    type:
      - 'null'
      - int
    doc: Default Set To 1000
    default: 1000
    inputBinding:
      position: 101
      prefix: --Evalue
  - id: hard_cross_react_filter
    type:
      - 'null'
      - float
    doc: Hard Cross Reactivity Filter
    inputBinding:
      position: 101
      prefix: --HardCrossReactFilter
  - id: identity_threshold
    type:
      - 'null'
      - float
    doc: Desired Identity Threshold
    inputBinding:
      position: 101
      prefix: --IdentityThreshold
  - id: input_file
    type: File
    doc: Path to Input File
    inputBinding:
      position: 101
      prefix: --InputFile
  - id: input_file_type
    type:
      - 'null'
      - string
    doc: Options [SS,MS,MAS]
    inputBinding:
      position: 101
      prefix: --InputFileType
  - id: max_gc
    type:
      - 'null'
      - float
    doc: Maximum GC Content
    inputBinding:
      position: 101
      prefix: --MaxGC
  - id: max_sets
    type:
      - 'null'
      - int
    doc: Default Set To 100
    default: 100
    inputBinding:
      position: 101
      prefix: --MaxSets
  - id: min_gc
    type:
      - 'null'
      - float
    doc: Minimum GC Content
    inputBinding:
      position: 101
      prefix: --MinGC
  - id: nucleotide_repeat_limit
    type:
      - 'null'
      - int
    doc: Nucleotide Repeat Limit (i.e 5 = AAAAA)
    inputBinding:
      position: 101
      prefix: --NucleotideRepeatLimit
  - id: primer_length
    type:
      - 'null'
      - int
    doc: Desired Primer Length
    inputBinding:
      position: 101
      prefix: --PrimerLength
  - id: prior_align
    type:
      - 'null'
      - File
    doc: 'Optional: Path to Prior Binding File'
    inputBinding:
      position: 101
      prefix: --PriorAlign
  - id: prior_binding_site
    type:
      - 'null'
      - File
    doc: 'Optional: Path to Prior Binding File'
    inputBinding:
      position: 101
      prefix: --PriorBindingSite
  - id: probe_length
    type:
      - 'null'
      - int
    doc: Desired Probe Length
    inputBinding:
      position: 101
      prefix: --ProbeLength
  - id: probe_required
    type:
      - 'null'
      - string
    doc: Options [NO,EXO,NFO]
    inputBinding:
      position: 101
      prefix: --ProbeRequired
  - id: run_id
    type: string
    doc: Desired Run ID
    inputBinding:
      position: 101
      prefix: --RunID
  - id: threads
    type:
      - 'null'
      - int
    doc: Default Set To 1
    default: 1
    inputBinding:
      position: 101
      prefix: --Threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/primedrpa:1.0.3--pyhdfd78af_0
stdout: primedrpa_PrimedRPA.out
