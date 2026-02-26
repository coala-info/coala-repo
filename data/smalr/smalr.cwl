cwlVersion: v1.2
class: CommandLineTool
baseCommand: smalr
label: smalr
doc: "This program will take a native aligned_reads.cmph5 and compare each molecule's
  kinetics profile with a matching WGA aligned_reads.cmp.h5. There are two protocols
  available for use within the pipeline, SMsn and SMp. The single argument for both
  protocols is an inputs_file containing paths to the relevant files.\n\nTool homepage:
  https://github.com/silviazuffi/smalr_online"
inputs:
  - id: inputs_file
    type: string
    doc: An inputs_file containing paths to the relevant files.
    inputBinding:
      position: 1
  - id: align
    type:
      - 'null'
      - boolean
    doc: '[DEPRECATED; not supported for BAM input] Align native reads to reference
      to avoid real SNP positions. Only use when expecting sequence heterogeneity
      in sample (i.e. mtDNA).'
    default: false
    inputBinding:
      position: 102
      prefix: --align
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Increase verbosity of logging
    inputBinding:
      position: 102
      prefix: --debug
  - id: downstream_skip
    type:
      - 'null'
      - int
    doc: Number of bases 3' of a CCS-detected, molecule-level SNP to skip in 
      analysis (only when using --align)
    default: 10
    inputBinding:
      position: 102
      prefix: --downstreamSkip
  - id: info
    type:
      - 'null'
      - boolean
    doc: Add basic logging
    inputBinding:
      position: 102
      prefix: --info
  - id: left_anchor
    type:
      - 'null'
      - int
    doc: Number of left bp to exclude around subread-level alignment errors
    default: 1
    inputBinding:
      position: 102
      prefix: --leftAnchor
  - id: log_file
    type:
      - 'null'
      - string
    doc: Write logging to file
    default: log.out
    inputBinding:
      position: 102
      prefix: --logFile
  - id: min_acc
    type:
      - 'null'
      - float
    doc: Minimum accuracy of a subread to analyze
    default: 0.8
    inputBinding:
      position: 102
      prefix: --minAcc
  - id: min_subread_len
    type:
      - 'null'
      - int
    doc: Minimum length of a subread to analyze
    default: 100
    inputBinding:
      position: 102
      prefix: --minSubreadLen
  - id: mod_pos
    type: int
    doc: The modified position in the motif to be analyzed (e.g. for Gm6ATC, 
      mod_pos=2)
    inputBinding:
      position: 102
      prefix: --mod_pos
  - id: motif
    type: string
    doc: The sequence motif to be analyzed
    inputBinding:
      position: 102
      prefix: --motif
  - id: nat_procs
    type:
      - 'null'
      - int
    doc: Number of processors to use for native molecule analysis
    inputBinding:
      position: 102
      prefix: --natProcs
  - id: native_cov_thresh
    type:
      - 'null'
      - int
    doc: Per mol/strand coverage threshold below which to ignore molecules
    default: 10
    inputBinding:
      position: 102
      prefix: --nativeCovThresh
  - id: out
    type:
      - 'null'
      - string
    doc: Filename to output SMsn/SMp results
    inputBinding:
      position: 102
      prefix: --out
  - id: procs
    type:
      - 'null'
      - int
    doc: Number of processors to use
    default: 4
    inputBinding:
      position: 102
      prefix: --procs
  - id: right_anchor
    type:
      - 'null'
      - int
    doc: Number of right bp to exclude around subread-level alignment errors
    default: 1
    inputBinding:
      position: 102
      prefix: --rightAnchor
  - id: sm_p
    type:
      - 'null'
      - boolean
    doc: Use long-library epigenetic phasing protocol (pool IPDs from each 
      subread).
    default: false
    inputBinding:
      position: 102
      prefix: --SMp
  - id: sm_sn
    type:
      - 'null'
      - boolean
    doc: Use short-library, single-nucleotide detection protocol.
    default: false
    inputBinding:
      position: 102
      prefix: --SMsn
  - id: upstream_skip
    type:
      - 'null'
      - int
    doc: Number of bases 5' of a CCS-detected, molecule-level SNP to skip in 
      analysis (only when using --align)
    default: 10
    inputBinding:
      position: 102
      prefix: --upstreamSkip
  - id: use_zmw
    type:
      - 'null'
      - boolean
    doc: Index molecules using ZMW/movie ID's instead of molecule IDs (if all 
      alignments all have unique molecule IDs)
    default: false
    inputBinding:
      position: 102
      prefix: --useZMW
  - id: wga_cov_thresh
    type:
      - 'null'
      - int
    doc: Aggregate WGA coverage threshold below which to skip analysis at that 
      position
    default: 10
    inputBinding:
      position: 102
      prefix: --wgaCovThresh
  - id: write_vars
    type:
      - 'null'
      - string
    doc: Write mol-specific variant calls to this filename (only when using 
      --align)
    inputBinding:
      position: 102
      prefix: --write_vars
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/smalr:v1.1dfsg-2-deb_cv1
stdout: smalr.out
