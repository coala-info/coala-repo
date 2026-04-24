cwlVersion: v1.2
class: CommandLineTool
baseCommand: diffsplice
label: flair_diffsplice
doc: "Differential splicing analysis using DRIMSeq, taking isoforms and count matrices
  as input.\n\nTool homepage: https://github.com/BrooksLabUCSC/flair"
inputs:
  - id: batch
    type:
      - 'null'
      - boolean
    doc: If specified with --test, DRIMSeq will perform batch correction
    inputBinding:
      position: 101
      prefix: --batch
  - id: condition_a
    type:
      - 'null'
      - string
    doc: Implies --test. Specify one condition corresponding to samples in the counts_matrix
      to be compared against condition2; by default, the first two unique conditions
      are used
    inputBinding:
      position: 101
      prefix: --conditionA
  - id: condition_b
    type:
      - 'null'
      - string
    doc: Specify another condition corresponding to samples in the counts_matrix to
      be compared against conditionA
    inputBinding:
      position: 101
      prefix: --conditionB
  - id: counts_matrix
    type: File
    doc: tab-delimited isoform count matrix from flair quantify module
    inputBinding:
      position: 101
      prefix: --counts_matrix
  - id: drim1
    type:
      - 'null'
      - int
    doc: The minimum number of samples that have coverage over an AS event inclusion/exclusion
      for DRIMSeq testing; events with too few samples are filtered out and not tested
      (6)
    inputBinding:
      position: 101
      prefix: --drim1
  - id: drim2
    type:
      - 'null'
      - int
    doc: The minimum number of samples expressing the inclusion of an AS event; events
      with too few samples are filtered out and not tested (3)
    inputBinding:
      position: 101
      prefix: --drim2
  - id: drim3
    type:
      - 'null'
      - int
    doc: The minimum number of reads covering an AS event inclusion/exclusion for
      DRIMSeq testing, events with too few samples are filtered out and not tested
      (15)
    inputBinding:
      position: 101
      prefix: --drim3
  - id: drim4
    type:
      - 'null'
      - int
    doc: The minimum number of reads covering an AS event inclusion for DRIMSeq testing,
      events with too few samples are filtered out and not tested (5)
    inputBinding:
      position: 101
      prefix: --drim4
  - id: isoforms
    type: File
    doc: isoforms in bed format
    inputBinding:
      position: 101
      prefix: --isoforms
  - id: out_dir_force
    type:
      - 'null'
      - boolean
    doc: Specify this argument to force overwriting of files in an existing output
      directory
    inputBinding:
      position: 101
      prefix: --out_dir_force
  - id: test
    type:
      - 'null'
      - boolean
    doc: Run DRIMSeq statistical testing
    inputBinding:
      position: 101
      prefix: --test
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads for parallel DRIMSeq (4)
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: out_dir
    type: Directory
    doc: Output directory for tables and plots.
    outputBinding:
      glob: $(inputs.out_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/flair:3.0.0--pyhdfd78af_0
