cwlVersion: v1.2
class: CommandLineTool
baseCommand: TEsorter
label: tesorter_TEsorter
doc: "lineage-level classification of transposable elements using conserved protein
  domains.\n\nTool homepage: https://github.com/NBISweden/TEsorter"
inputs:
  - id: sequence
    type: File
    doc: input TE/LTR or genome sequences in fasta format
    inputBinding:
      position: 1
  - id: citation
    type:
      - 'null'
      - boolean
    doc: print the citation and exit
    inputBinding:
      position: 102
      prefix: --citation
  - id: db_hmm
    type:
      - 'null'
      - File
    doc: the database HMM file used (prior to `-db`)
    inputBinding:
      position: 102
      prefix: --db-hmm
  - id: disable_pass2
    type:
      - 'null'
      - boolean
    doc: do not further classify the unclassified sequences
    inputBinding:
      position: 102
      prefix: --disable-pass2
  - id: force_write_hmmscan
    type:
      - 'null'
      - boolean
    doc: if False, will use the existed hmmscan outfile and skip hmmscan
    inputBinding:
      position: 102
      prefix: --force-write-hmmscan
  - id: genome
    type:
      - 'null'
      - boolean
    doc: input is genome sequences
    inputBinding:
      position: 102
      prefix: --genome
  - id: hmm_database
    type:
      - 'null'
      - string
    doc: the database name used
    inputBinding:
      position: 102
      prefix: --hmm-database
  - id: mask
    type:
      - 'null'
      - type: array
        items: string
    doc: 'output masked sequences (soft: masking with lowercase; hard: masking with
      N)'
    inputBinding:
      position: 102
      prefix: -mask
  - id: max_evalue
    type:
      - 'null'
      - float
    doc: 'maxinum E-value for protein domains in HMMScan output (ranging: 0-10)'
    inputBinding:
      position: 102
      prefix: --max-evalue
  - id: min_coverage
    type:
      - 'null'
      - int
    doc: 'mininum coverage for protein domains in HMMScan output (ranging: 0-100)'
    inputBinding:
      position: 102
      prefix: --min-coverage
  - id: min_probability
    type:
      - 'null'
      - float
    doc: 'mininum posterior probability for protein domains in HMMScan output (ranging:
      0-1)'
    inputBinding:
      position: 102
      prefix: --min-probability
  - id: min_score
    type:
      - 'null'
      - float
    doc: 'mininum score for protein domains in HMMScan output (ranging: 0-2)'
    inputBinding:
      position: 102
      prefix: --min-score
  - id: no_cleanup
    type:
      - 'null'
      - boolean
    doc: do not clean up the temporary directory
    inputBinding:
      position: 102
      prefix: --no-cleanup
  - id: no_library
    type:
      - 'null'
      - boolean
    doc: do not generate a library file for RepeatMasker
    inputBinding:
      position: 102
      prefix: --no-library
  - id: no_reverse
    type:
      - 'null'
      - boolean
    doc: do not reverse complement sequences if they are detected in minus 
      strand
    inputBinding:
      position: 102
      prefix: --no-reverse
  - id: pass2_rule
    type:
      - 'null'
      - string
    doc: classifying rule [identity-coverage-length] in pass-2 based on 
      similarity
    inputBinding:
      position: 102
      prefix: --pass2-rule
  - id: prefix
    type:
      - 'null'
      - string
    doc: output prefix
    inputBinding:
      position: 102
      prefix: --prefix
  - id: processors
    type:
      - 'null'
      - int
    doc: processors to use
    inputBinding:
      position: 102
      prefix: --processors
  - id: seq_type
    type:
      - 'null'
      - string
    doc: "'nucl' for DNA or 'prot' for protein"
    inputBinding:
      position: 102
      prefix: --seq-type
  - id: tmp_dir
    type:
      - 'null'
      - Directory
    doc: directory for temporary files
    inputBinding:
      position: 102
      prefix: --tmp-dir
  - id: win_ovl
    type:
      - 'null'
      - int
    doc: overlap size of windows
    inputBinding:
      position: 102
      prefix: --win_ovl
  - id: win_size
    type:
      - 'null'
      - int
    doc: window size of chunking genome sequences
    inputBinding:
      position: 102
      prefix: --win_size
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tesorter:1.5.1--pyhdfd78af_0
stdout: tesorter_TEsorter.out
