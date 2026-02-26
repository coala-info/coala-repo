cwlVersion: v1.2
class: CommandLineTool
baseCommand: TD2.Predict
label: td2_TD2.Predict
doc: "Predicts ORFs from transcripts.\n\nTool homepage: https://github.com/Markusjsommer/TD2"
inputs:
  - id: all_good
    type:
      - 'null'
      - boolean
    doc: report all ORFs that pass PSAURON and/or length-based false discovery 
      filters, default=False
    default: false
    inputBinding:
      position: 101
      prefix: --all-good
  - id: complete_orfs_only
    type:
      - 'null'
      - boolean
    doc: discard all ORFs without both a stop and start codon, default=False
    default: false
    inputBinding:
      position: 101
      prefix: --complete-orfs-only
  - id: discard_encapsulated
    type:
      - 'null'
      - boolean
    doc: retain ORFs that are fully contained within larger ORFs, default=False
    default: false
    inputBinding:
      position: 101
      prefix: --discard-encapsulated
  - id: genetic_code
    type:
      - 'null'
      - int
    doc: genetic code a.k.a. translation table, NCBI integer codes, default=1
    default: 1
    inputBinding:
      position: 101
      prefix: -G
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: same output directory from LongOrfs
    inputBinding:
      position: 101
      prefix: -O
  - id: precise
    type:
      - 'null'
      - boolean
    doc: set --precise to enable precise mode. Equivalent to -P 0.9 and 
      --retain-long-orfs-fdr 0.005 for TD2.Predict, default=False
    default: false
    inputBinding:
      position: 101
      prefix: --precise
  - id: psauron_all_frame
    type:
      - 'null'
      - boolean
    doc: require ORF to have highest PSAURON score compared to all other reading
      frames, set this argument for less sensitive and more precise ORFs, can 
      dramatically increase compute time requirements, default=False
    default: false
    inputBinding:
      position: 101
      prefix: --psauron-all-frame
  - id: psauron_cutoff
    type:
      - 'null'
      - float
    doc: 'minimum in-frame PSAURON score required to report ORF assuming no homology
      hits, higher is less sensitive and more precise (range: [0,1]; default: 0.50)'
    default: 0.5
    inputBinding:
      position: 101
      prefix: -P
  - id: retain_blastp_hits
    type:
      - 'null'
      - File
    doc: blastp output in '-outfmt 6' format. Complete ORFs with a blastp match 
      will be retained in the final output.
    inputBinding:
      position: 101
      prefix: --retain-blastp_hits
  - id: retain_hmmer_hits
    type:
      - 'null'
      - File
    doc: domain table output file from running hmmer to search Pfam. Complete 
      ORFs with a Pfam domain hit will be retained in the final output.
    inputBinding:
      position: 101
      prefix: --retain-hmmer_hits
  - id: retain_long_orfs_fdr
    type:
      - 'null'
      - float
    doc: in "--retain-long-orfs-mode dynamic" mode, set the False Discovery Rate
      used to calculate dynamic threshold, default=0.10
    default: 0.1
    inputBinding:
      position: 101
      prefix: --retain-long-orfs-fdr
  - id: retain_long_orfs_length
    type:
      - 'null'
      - int
    doc: in "--retain-long-orfs-mode strict" mode, retain all ORFs found that 
      are equal or longer than these many nucleotides even if no other evidence 
      marks it as coding, default=100000
    default: 100000
    inputBinding:
      position: 101
      prefix: --retain-long-orfs-length
  - id: retain_long_orfs_mode
    type:
      - 'null'
      - string
    doc: "dynamic: retain ORFs longer than a threshold length determined by calculating
      the FDR for each transcript's GC percent; strict: retain ORFs with length above
      constant length"
    inputBinding:
      position: 101
      prefix: --retain-long-orfs-mode
  - id: retain_mmseqs_hits
    type:
      - 'null'
      - File
    doc: mmseqs output in '.m8' format. Complete ORFs with a MMseqs2 match will 
      be retained in the final output.
    inputBinding:
      position: 101
      prefix: --retain-mmseqs-hits
  - id: transcripts
    type: File
    doc: REQUIRED path to transcripts.fasta
    inputBinding:
      position: 101
      prefix: -t
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: verbose output with progress bars, default=False
    default: false
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/td2:1.0.7--pyhdfd78af_0
stdout: td2_TD2.Predict.out
