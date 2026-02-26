cwlVersion: v1.2
class: CommandLineTool
baseCommand: ervdetective
label: ervdetective
doc: "An efficient pipeline for identification and annotation of endogenous retroviruses.\n\
  \nTool homepage: https://github.com/ZhijianZhou01/ervdetective"
inputs:
  - id: env_length
    type:
      - 'null'
      - string
    doc: The threshold of length of ENV protein in HMMER search
    default: 250 aa
    inputBinding:
      position: 101
      prefix: --env
  - id: evalue_blast
    type:
      - 'null'
      - float
    doc: Specify threshold of e-value for BLAST search
    default: '1e-5'
    inputBinding:
      position: 101
      prefix: -eb
  - id: evalue_hmm
    type:
      - 'null'
      - float
    doc: Specify threshold of e-value using for HMMER search
    default: '1e-6'
    inputBinding:
      position: 101
      prefix: -ed
  - id: flank_length
    type:
      - 'null'
      - int
    doc: The length of extended flank sequence on either side of the blast 
      hit-site
    default: 15000
    inputBinding:
      position: 101
      prefix: -f
  - id: gag_length
    type:
      - 'null'
      - string
    doc: The threshold of length of GAG protein in HMMER search
    default: 250 aa
    inputBinding:
      position: 101
      prefix: --gag
  - id: host_genome
    type: File
    doc: The file-path of host genome sequence, the suffix is generally *.fna, 
      *.fas, *.fasta.
    inputBinding:
      position: 101
      prefix: -i
  - id: int_length
    type:
      - 'null'
      - string
    doc: The threshold of length of INT protein in HMMER search
    default: 150 aa
    inputBinding:
      position: 101
      prefix: --int
  - id: ltr_similarity
    type:
      - 'null'
      - float
    doc: Specify threshold(%) of the similarity of paired LTRs
    default: 80
    inputBinding:
      position: 101
      prefix: -s
  - id: max_dist_ltr
    type:
      - 'null'
      - int
    doc: The maximum interval of paired-LTRs start-positions
    default: 15000
    inputBinding:
      position: 101
      prefix: -d2
  - id: max_ltr_length
    type:
      - 'null'
      - int
    doc: Specify maximum length of LTR
    default: 1000
    inputBinding:
      position: 101
      prefix: -l2
  - id: max_tsd_length
    type:
      - 'null'
      - int
    doc: The maximum length for each TSD site
    default: 6
    inputBinding:
      position: 101
      prefix: -t2
  - id: min_dist_ltr
    type:
      - 'null'
      - int
    doc: The minimum interval of paired-LTRs start-positions
    default: 1000
    inputBinding:
      position: 101
      prefix: -d1
  - id: min_ltr_length
    type:
      - 'null'
      - int
    doc: Specify minimum length of LTR
    default: 100
    inputBinding:
      position: 101
      prefix: -l1
  - id: min_tsd_length
    type:
      - 'null'
      - int
    doc: The minimum length for each TSD site
    default: 4
    inputBinding:
      position: 101
      prefix: -t1
  - id: mismotif
    type:
      - 'null'
      - int
    doc: The maximum number of mismatches nucleotides in motif
    default: 1
    inputBinding:
      position: 101
      prefix: -mis
  - id: motif
    type:
      - 'null'
      - string
    doc: Specify start-motif (2 nucleotides) and end-motif (2 nucleotides)
    default: TGCA
    inputBinding:
      position: 101
      prefix: -motif
  - id: prefix
    type:
      - 'null'
      - string
    doc: The prefix of output file
    default: host
    inputBinding:
      position: 101
      prefix: -p
  - id: pro_length
    type:
      - 'null'
      - string
    doc: The threshold of length of PRO protein in HMMER search
    default: 50 aa
    inputBinding:
      position: 101
      prefix: --pro
  - id: rnaseh_length
    type:
      - 'null'
      - string
    doc: The threshold of length of RNaseH protein in HMMER search
    default: 65 aa
    inputBinding:
      position: 101
      prefix: --rh
  - id: rt_length
    type:
      - 'null'
      - string
    doc: The threshold of length of RT protein in HMMER search
    default: 150 aa
    inputBinding:
      position: 101
      prefix: --rt
  - id: threads
    type:
      - 'null'
      - int
    doc: Specify the number of threads used
    default: 1
    inputBinding:
      position: 101
      prefix: -n
outputs:
  - id: output_folder
    type:
      - 'null'
      - Directory
    doc: The path of output folder to store all the results.
    outputBinding:
      glob: $(inputs.output_folder)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ervdetective:1.0.9--pyhdfd78af_1
