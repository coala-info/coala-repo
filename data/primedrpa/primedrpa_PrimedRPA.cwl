cwlVersion: v1.2
class: CommandLineTool
baseCommand: PrimedRPA
label: primedrpa_PrimedRPA
doc: "Finding RPA Primer and Probe Sets\n\nTool homepage: https://github.com/MatthewHiggins2017/bioconda-PrimedRPA/"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.input_file)
        writable: true
inputs:
  - id: run_id
    type: string
    doc: "Desired Run ID"
    inputBinding:
      position: 1
      prefix: --RunID
  - id: prior_align
    type:
      - 'null'
      - File
    doc: "Optional: Path to Prior Alignment Summary File"
    inputBinding:
      position: 1
      prefix: --PriorAlign
  - id: prior_binding_site
    type:
      - 'null'
      - File
    doc: "Optional: Path to Prior Binding File"
    inputBinding:
      position: 1
      prefix: --PriorBindingSite
  - id: input_file
    type:
      - 'null'
      - File
    doc: "Path to Input File"
    inputBinding:
      position: 1
      prefix: --InputFile
  - id: input_file_type
    type:
      - 'null'
      - string
    doc: "Options [SS,MS,MAS]"
    inputBinding:
      position: 1
      prefix: --InputFileType
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
      - string
    doc: "Identity Anchor Required"
    inputBinding:
      position: 1
      prefix: --ConservedAnchor
  - id: primer_length
    type:
      - 'null'
      - string
    doc: "Desired Primer Length"
    inputBinding:
      position: 1
      prefix: --PrimerLength
  - id: probe_required
    type:
      - 'null'
      - string
    doc: "Options [NO,EXO,NFO]"
    inputBinding:
      position: 1
      prefix: --ProbeRequired
  - id: probe_length
    type:
      - 'null'
      - string
    doc: "Desired Probe Length"
    inputBinding:
      position: 1
      prefix: --ProbeLength
  - id: amplicon_size_limit
    type:
      - 'null'
      - int
    doc: "Amplicon Size Limit"
    inputBinding:
      position: 1
      prefix: --AmpliconSizeLimit
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
    doc: "Path To Background Fasta File (leave unset for no background check)"
    inputBinding:
      position: 1
      prefix: --BackgroundCheck
    secondaryFiles:
      - '.fai'
  - id: cross_reactivity_thresh
    type:
      - 'null'
      - int
    doc: "Max Cross Reactivity Threshold"
    inputBinding:
      position: 1
      prefix: --CrossReactivityThresh
  - id: hard_cross_react_filter
    type:
      - 'null'
      - string
    doc: "Hard Cross Reactivity Filter"
    inputBinding:
      position: 1
      prefix: --HardCrossReactFilter
  - id: max_sets
    type:
      - 'null'
      - int
    doc: "Default Set To 100"
    inputBinding:
      position: 1
      prefix: --MaxSets
  - id: threads
    type:
      - 'null'
      - int
    doc: "Default Set To 1"
    inputBinding:
      position: 1
      prefix: --Threads
  - id: background_search_sensitivity
    type:
      - 'null'
      - string
    doc: "Options [Basic or Advanced or Fast]"
    inputBinding:
      position: 1
      prefix: --BackgroundSearchSensitivity
  - id: evalue
    type:
      - 'null'
      - int
    doc: "Default Set To 1000"
    inputBinding:
      position: 1
      prefix: --Evalue
outputs:
  - id: output_files
    type:
      type: array
      items: File
    doc: Result tables written with the run ID as prefix
    outputBinding:
      glob: $(inputs.run_id)_*
  - id: aligned_fasta
    type:
      - 'null'
      - File
    doc: Clustal Omega alignment written when the input is not aligned
    outputBinding:
      glob: '*_Aligned.fasta'
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/primedrpa:1.0.3--pyhdfd78af_0
stdout: primedrpa_PrimedRPA.out
