cwlVersion: v1.2
class: CommandLineTool
baseCommand: bmge
label: bmge
doc: "BMGE (Block Mapping with Gapped Exoneration) is a tool for finding conserved blocks in multiple sequence alignments.\n\nTool homepage: https://bioweb.pasteur.fr/packages/pack@BMGE@1.12"
inputs:
  - id: infile
    type: File
    doc: input file in fasta or phylip sequential format
    inputBinding:
      position: 101
      prefix: -i
  - id: type
    type: string
    doc: 'sequence coding in the input file: AA, DNA, RNA or CODON'
    inputBinding:
      position: 101
      prefix: -t
  - id: matrix
    type: ['null', string]
    doc: 'BLOSUM<n> (AA or CODON; default: BLOSUM62), DNAPAM<n:r> or DNAPAM<n> (DNA or RNA; default: DNAPAM100:2), or ID / PAM0 (identity matrix) used to estimate the entropy-like value for each character'
    inputBinding:
      position: 101
      prefix: -m
  - id: gap_rate
    type: ['null', string]
    doc: 'maximum gap rate allowed per character (<rate_max>, 0 to 1; default: 0.2) or per sequence and character (<col_rate:row_rate>; default: 0:0.2)'
    inputBinding:
      position: 101
      prefix: -g
  - id: entropy
    type: ['null', string]
    doc: 'maximum entropy threshold (<thr_max>, 0 to 1; default: 0.5) or minimum and maximum entropy thresholds (<thr_min:thr_max>; default: 0:0.5)'
    inputBinding:
      position: 101
      prefix: -h
  - id: min_size
    type: ['null', int]
    doc: 'minimum length of selected region(s) (default: 5)'
    inputBinding:
      position: 101
      prefix: -b
  - id: window
    type: ['null', int]
    doc: 'sliding window size (must be odd; 1 means entropy-like values are not smoothed; default: 3)'
    inputBinding:
      position: 101
      prefix: -w
  - id: stationarity
    type: ['null', string]
    doc: 'NO or YES; if YES, performs a stationarity-based trimming of the multiple sequence alignment (default: NO)'
    inputBinding:
      position: 101
      prefix: -s
  - id: out_phylip
    type: ['null', string]
    doc: trimmed alignment in phylip sequential format (output file name)
    inputBinding:
      position: 101
      prefix: -o
  - id: out_phylip_p
    type: ['null', string]
    doc: trimmed alignment in phylip sequential format (-op) (output file name)
    inputBinding:
      position: 101
      prefix: -op
  - id: out_phylip_taxon
    type: ['null', string]
    doc: trimmed alignment in phylip format, NCBI-formatted names renamed onto their taxon name (output file name)
    inputBinding:
      position: 101
      prefix: -opp
  - id: out_phylip_taxon_acc
    type: ['null', string]
    doc: trimmed alignment in phylip format, names renamed onto 'taxon name'_____'accession number' (the default format) (output file name)
    inputBinding:
      position: 101
      prefix: -oppp
  - id: out_fasta
    type: ['null', string]
    doc: trimmed alignment in fasta format (output file name)
    inputBinding:
      position: 101
      prefix: -of
  - id: out_nexus
    type: ['null', string]
    doc: trimmed alignment in nexus format (output file name)
    inputBinding:
      position: 101
      prefix: -on
  - id: out_nexus_taxon
    type: ['null', string]
    doc: trimmed alignment in nexus format, NCBI-formatted names renamed onto their taxon name (output file name)
    inputBinding:
      position: 101
      prefix: -onn
  - id: out_nexus_taxon_acc
    type: ['null', string]
    doc: trimmed alignment in nexus format, names renamed onto 'taxon name'_____'accession number' (output file name)
    inputBinding:
      position: 101
      prefix: -onnn
  - id: out_html
    type: ['null', string]
    doc: trimmed alignment in html format (output file name)
    inputBinding:
      position: 101
      prefix: -oh
  - id: comp_phylip
    type: ['null', string]
    doc: complementary alignment (the removed characters) in phylip sequential format; in BMGE 1.12 the other complementary formats (-cf, -cn, -cp, ...) write empty files, so only -c is wrapped (output file name)
    inputBinding:
      position: 101
      prefix: -c
  - id: out_aa
    type: ['null', string]
    doc: trimmed alignment converted to Amino Acid-coding sequences (output file name)
    inputBinding:
      position: 101
      prefix: -oaa
  - id: out_dna
    type: ['null', string]
    doc: trimmed alignment converted to DNA-coding sequences (output file name)
    inputBinding:
      position: 101
      prefix: -odna
  - id: out_codon
    type: ['null', string]
    doc: trimmed alignment converted to codon-coding sequences (output file name)
    inputBinding:
      position: 101
      prefix: -oco
  - id: out_ry
    type: ['null', string]
    doc: trimmed alignment converted to RY-coding sequences (output file name)
    inputBinding:
      position: 101
      prefix: -ory
outputs:
  - id: stdout
    type: stdout
    doc: Run log; the trimmed alignment in phylip format when no output file option is set
  - id: out_phylip
    type: ['null', File]
    doc: trimmed alignment in phylip sequential format
    outputBinding:
      glob: $(inputs.out_phylip)
  - id: out_phylip_p
    type: ['null', File]
    doc: trimmed alignment in phylip sequential format (-op)
    outputBinding:
      glob: $(inputs.out_phylip_p)
  - id: out_phylip_taxon
    type: ['null', File]
    doc: trimmed alignment in phylip format, NCBI-formatted names renamed onto their taxon name
    outputBinding:
      glob: $(inputs.out_phylip_taxon)
  - id: out_phylip_taxon_acc
    type: ['null', File]
    doc: trimmed alignment in phylip format, names renamed onto 'taxon name'_____'accession number' (the default format)
    outputBinding:
      glob: $(inputs.out_phylip_taxon_acc)
  - id: out_fasta
    type: ['null', File]
    doc: trimmed alignment in fasta format
    outputBinding:
      glob: $(inputs.out_fasta)
  - id: out_nexus
    type: ['null', File]
    doc: trimmed alignment in nexus format
    outputBinding:
      glob: $(inputs.out_nexus)
  - id: out_nexus_taxon
    type: ['null', File]
    doc: trimmed alignment in nexus format, NCBI-formatted names renamed onto their taxon name
    outputBinding:
      glob: $(inputs.out_nexus_taxon)
  - id: out_nexus_taxon_acc
    type: ['null', File]
    doc: trimmed alignment in nexus format, names renamed onto 'taxon name'_____'accession number'
    outputBinding:
      glob: $(inputs.out_nexus_taxon_acc)
  - id: out_html
    type: ['null', File]
    doc: trimmed alignment in html format
    outputBinding:
      glob: $(inputs.out_html)
  - id: comp_phylip
    type: ['null', File]
    doc: complementary alignment (the removed characters) in phylip sequential format; in BMGE 1.12 the other complementary formats (-cf, -cn, -cp, ...) write empty files, so only -c is wrapped
    outputBinding:
      glob: $(inputs.comp_phylip)
  - id: out_aa
    type: ['null', File]
    doc: trimmed alignment converted to Amino Acid-coding sequences
    outputBinding:
      glob: $(inputs.out_aa)
  - id: out_dna
    type: ['null', File]
    doc: trimmed alignment converted to DNA-coding sequences
    outputBinding:
      glob: $(inputs.out_dna)
  - id: out_codon
    type: ['null', File]
    doc: trimmed alignment converted to codon-coding sequences
    outputBinding:
      glob: $(inputs.out_codon)
  - id: out_ry
    type: ['null', File]
    doc: trimmed alignment converted to RY-coding sequences
    outputBinding:
      glob: $(inputs.out_ry)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bmge:1.12--0
stdout: bmge.out
