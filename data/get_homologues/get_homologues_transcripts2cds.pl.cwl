cwlVersion: v1.2
class: CommandLineTool
baseCommand: transcripts2cds.pl
label: get_homologues_transcripts2cds.pl
doc: "Extracts coding sequences (CDS) encoded in input transcripts, using TransDecoder ORF prediction and blastx or diamond hits against a protein FASTA database.\n\nTool homepage: https://github.com/eead-csic-compbio/get_homologues"
inputs:
  - id: plus_strand_only
    type:
      - 'null'
      - boolean
    doc: check only 'plus' strand (default both strands)
    inputBinding:
      position: 1
      prefix: -p
  - id: min_cds_length
    type:
      - 'null'
      - int
    doc: min length for CDS in amino acid residues (default=50)
    inputBinding:
      position: 1
      prefix: -l
  - id: genetic_code
    type:
      - 'null'
      - int
    doc: genetic code to use during translation (default=1, example -g 11)
    inputBinding:
      position: 1
      prefix: -g
  - id: protein_database
    type:
      - 'null'
      - File
    doc: run blastx against selected protein FASTA database file (default=swissprot, example -d /path/to/sequences.faa)
    inputBinding:
      position: 1
      prefix: -d
  - id: max_evalue
    type:
      - 'null'
      - float
    doc: max E-value during blastx search (default=1e-05)
    inputBinding:
      position: 1
      prefix: -E
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads for blastx/diamond jobs (default=2)
    inputBinding:
      position: 1
      prefix: -n
  - id: use_diamond
    type:
      - 'null'
      - boolean
    doc: use diamond instead of blastx (much faster for many sequences)
    inputBinding:
      position: 1
      prefix: -X
  - id: transcript_fasta
    type:
      type: array
      items: File
    doc: input FASTA file(s) with transcript nucleotide sequences
    inputBinding:
      position: 10
outputs:
  - id: cds_nucleotides
    type:
      type: array
      items: File
    doc: Nucleotide FASTA files with the extracted coding sequences.
    outputBinding:
      glob: '*.cds.fna'
  - id: cds_proteins
    type:
      type: array
      items: File
    doc: Protein FASTA files with the translated coding sequences.
    outputBinding:
      glob: '*.cds.faa'
  - id: transcripts
    type:
      type: array
      items: File
    doc: Nucleotide FASTA files with the transcripts that have a CDS.
    outputBinding:
      glob: '*.transcript.fna'
  - id: no_orf_transcripts
    type:
      type: array
      items: File
    doc: Nucleotide FASTA files with the transcripts without a CDS.
    outputBinding:
      glob: '*.noORF.fna'
  - id: stdout
    type: stdout
    doc: Standard output
stdout: get_homologues_transcripts2cds.pl.out
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/get_homologues:3.8.1--hdfd78af_0
