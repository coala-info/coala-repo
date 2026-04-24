cwlVersion: v1.2
class: CommandLineTool
baseCommand: eviann.sh
label: eviann_eviann.sh
doc: "EviAnn: A tool for genome annotation using RNA-seq, protein, and transcript
  evidence.\n\nTool homepage: https://github.com/alekseyzimin/EviAnn_release"
inputs:
  - id: assembled_transcripts
    type:
      - 'null'
      - File
    doc: fasta file with assembled transcripts from related species
    inputBinding:
      position: 101
      prefix: -e
  - id: cds_gff
    type:
      - 'null'
      - File
    doc: GFF file with CDS sequences for THIS genome to be used in annotations
    inputBinding:
      position: 101
      prefix: -c
  - id: debug
    type:
      - 'null'
      - boolean
    doc: keep intermediate output files
    inputBinding:
      position: 101
      prefix: --debug
  - id: extra_features
    type:
      - 'null'
      - File
    doc: extra features to add from an external GFF file
    inputBinding:
      position: 101
      prefix: --extra
  - id: functional
    type:
      - 'null'
      - boolean
    doc: perform functional annotation
    inputBinding:
      position: 101
      prefix: --functional
  - id: genome_fasta
    type: File
    doc: 'MANDATORY: genome fasta file'
    inputBinding:
      position: 101
      prefix: -g
  - id: lncrna_min_tpm
    type:
      - 'null'
      - float
    doc: minimum TPM to include non-coding transcript into the annotation as 
      lncRNA
    inputBinding:
      position: 101
      prefix: --lncrnamintpm
  - id: max_intron_size
    type:
      - 'null'
      - int
    doc: max intron size; overrides automatically estimated value
    inputBinding:
      position: 101
      prefix: -m
  - id: min_prot
    type:
      - 'null'
      - int
    doc: minimum protein length (in amino-acids) for ab initio ORF detection 
      without homology evidence
    inputBinding:
      position: 101
      prefix: --min_prot
  - id: mito_contigs
    type:
      - 'null'
      - File
    doc: file with the list of input contigs to be treated as mitochondrial with
      different genetic code
    inputBinding:
      position: 101
      prefix: --mito_contigs
  - id: partial
    type:
      - 'null'
      - boolean
    doc: include transcripts with partial (missing start or stop codon) CDS in 
      the output
    inputBinding:
      position: 101
      prefix: --partial
  - id: ploidy
    type:
      - 'null'
      - int
    doc: set ploidy for the genome, used in estimating the maximum intron size
    inputBinding:
      position: 101
      prefix: -d
  - id: protein_sequences
    type:
      - 'null'
      - File
    doc: fasta file with protein sequences from (preferably multiple) related 
      species
    inputBinding:
      position: 101
      prefix: -p
  - id: reads_list
    type:
      - 'null'
      - File
    doc: file containing list of filenames of reads from transcriptome 
      sequencing experiments
    inputBinding:
      position: 101
      prefix: -r
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    inputBinding:
      position: 101
      prefix: -t
  - id: uniprot_database
    type:
      - 'null'
      - File
    doc: fasta file with UniProt-SwissProt proteins to use in functional 
      annotation
    inputBinding:
      position: 101
      prefix: -s
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: verbose run
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/eviann:2.0.5--pl5321haf24da9_1
stdout: eviann_eviann.sh.out
