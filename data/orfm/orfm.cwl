cwlVersion: v1.2
class: CommandLineTool
baseCommand: orfm
label: orfm
doc: "The <seq_file> can be a FASTA or FASTQ file, gzipped or uncompressed.\n\nTool
  homepage: https://github.com/wwood/OrfM"
inputs:
  - id: seq_file
    type: File
    doc: The <seq_file> can be a FASTA or FASTQ file, gzipped or uncompressed.
    inputBinding:
      position: 1
  - id: codon_table_id
    type:
      - 'null'
      - string
    doc: codon table for translation (see 
      http://www.ncbi.nlm.nih.gov/Taxonomy/taxonomyhome.html/index.cgi?chapter=tgencodes
      for details)
    inputBinding:
      position: 102
      prefix: -c
  - id: ignore_read_length
    type:
      - 'null'
      - int
    doc: ignore the sequence of the read beyond this, useful when comparing 
      reads from with different read lengths
    inputBinding:
      position: 102
      prefix: -l
  - id: min_orf_length
    type:
      - 'null'
      - int
    doc: minimum number of nucleotides (not amino acids) to call an ORF on
    inputBinding:
      position: 102
      prefix: -m
  - id: min_orfm_version
    type:
      - 'null'
      - string
    doc: do not run unless this version of OrfM is at least this version number 
      (e.g. 1.4.0)
    inputBinding:
      position: 102
      prefix: -r
  - id: only_orf_in_frame_with_stop
    type:
      - 'null'
      - boolean
    doc: only print those ORFs in the same frame as a stop codon
    inputBinding:
      position: 102
      prefix: -s
  - id: print_stop_codons
    type:
      - 'null'
      - boolean
    doc: print the actual stop codons at sequence ends if encoded
    inputBinding:
      position: 102
      prefix: -p
outputs:
  - id: transcript_output_file
    type:
      - 'null'
      - File
    doc: output nucleotide sequences of transcripts to this path
    outputBinding:
      glob: $(inputs.transcript_output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/orfm:1.4.0--h577a1d6_0
