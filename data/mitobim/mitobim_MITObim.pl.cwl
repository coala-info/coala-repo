cwlVersion: v1.2
class: CommandLineTool
baseCommand: MITObim.pl
label: mitobim_MITObim.pl
doc: "MITObim - mitochondrial baiting and iterative mapping\n\nTool homepage: https://github.com/chrishah/MITObim"
inputs:
  - id: clean
    type:
      - 'null'
      - boolean
    doc: 'retain only the last 2 iteration directories (default: no)'
    inputBinding:
      position: 101
      prefix: --clean
  - id: denovo
    type:
      - 'null'
      - boolean
    doc: runs MIRA in denovo mode
    inputBinding:
      position: 101
      prefix: --denovo
  - id: end_iteration
    type:
      - 'null'
      - int
    doc: iteration to end with (default=startiteration, i.e. if not specified 
      otherwise stop after 1 iteration)
    inputBinding:
      position: 101
      prefix: -end
  - id: kbait
    type:
      - 'null'
      - int
    doc: set kmer for baiting stringency
    inputBinding:
      position: 101
      prefix: --kbait
  - id: maf_file
    type:
      - 'null'
      - File
    doc: extracts reference from maf file created by previous MITObim 
      iteration/MIRA assembly (resume)
    inputBinding:
      position: 101
      prefix: -maf
  - id: min_cov
    type:
      - 'null'
      - int
    doc: 'minimum average coverage of contigs to be retained (default: 0 - off)'
    inputBinding:
      position: 101
      prefix: --min_cov
  - id: min_len
    type:
      - 'null'
      - int
    doc: 'minimum length of contig to be retained as backbone (default: 0 - off)'
    inputBinding:
      position: 101
      prefix: --min_len
  - id: mirapath
    type:
      - 'null'
      - string
    doc: full path to MIRA binaries (only needed if MIRA is not in PATH)
    inputBinding:
      position: 101
      prefix: --mirapath
  - id: mismatch
    type:
      - 'null'
      - int
    doc: 'number of allowed mismatches in mapping - only for illumina data (default:
      15% of avg. read length)'
    inputBinding:
      position: 101
      prefix: --mismatch
  - id: nfs_warn_only
    type:
      - 'null'
      - boolean
    doc: allow MIRA to run on NFS mount without aborting -  warn only (expert 
      option - see MIRA documentation 'check_nfs')
    inputBinding:
      position: 101
      prefix: --NFS_warn_only
  - id: pair
    type:
      - 'null'
      - boolean
    doc: 'extend readpool to contain full read pairs, even if only one member was
      baited (relies on /1 and /2 header convention for read pairs) (default: no).'
    inputBinding:
      position: 101
      prefix: --pair
  - id: platform
    type:
      - 'null'
      - string
    doc: "specify sequencing platform (default: 'solexa'; other options: 'iontor',
      '454', 'pacbio')"
    inputBinding:
      position: 101
      prefix: --platform
  - id: quick_reference
    type:
      - 'null'
      - File
    doc: reference sequence to be used as bait in fasta format
    inputBinding:
      position: 101
      prefix: -quick
  - id: readpool
    type:
      - 'null'
      - File
    doc: readpool in fastq format (*.gz is also allowed). read pairs need to be 
      interleaved for full functionality of the '-pair' option below.
    inputBinding:
      position: 101
      prefix: -readpool
  - id: redirect_tmp
    type:
      - 'null'
      - Directory
    doc: redirect temporary output to this location (useful in case you are 
      running MITObim on an NFS mount)
    inputBinding:
      position: 101
      prefix: --redirect_tmp
  - id: reference_id
    type:
      - 'null'
      - string
    doc: referenceID. If resuming, use the same as in previous iteration/initial
      MIRA assembly.
    inputBinding:
      position: 101
      prefix: -ref
  - id: sample_id
    type:
      - 'null'
      - string
    doc: sampleID (please don't use '.' in the sampleID). If resuming, the 
      sampleID needs to be identical to that of the previous iteration / MIRA 
      assembly.
    inputBinding:
      position: 101
      prefix: -sample
  - id: split
    type:
      - 'null'
      - boolean
    doc: 'split reference at positions with more than 5N (default: no)'
    inputBinding:
      position: 101
      prefix: --split
  - id: start_iteration
    type:
      - 'null'
      - int
    doc: iteration to start with (default=0, when using '-quick' reference)
    inputBinding:
      position: 101
      prefix: -start
  - id: trimoverhang
    type:
      - 'null'
      - boolean
    doc: "trim overhang up- and downstream of reference, i.e. don't extend the bait,
      just re-assemble (default: no)"
    inputBinding:
      position: 101
      prefix: --trimoverhang
  - id: trimreads
    type:
      - 'null'
      - boolean
    doc: 'trim data (default: no; we recommend to trim beforehand and feed MITObim
      with pre trimmed data)'
    inputBinding:
      position: 101
      prefix: --trimreads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: 'show detailed output of MIRA modules (default: no)'
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mitobim:1.9.1--hdfd78af_1
stdout: mitobim_MITObim.pl.out
