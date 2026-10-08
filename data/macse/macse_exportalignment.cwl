cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - macse
  - -prog
  - exportAlignment
label: macse_exportalignment
doc: "allows to export a MACSE alignment and to compute some statistics, it can\n\nTool homepage: https://bioweb.supagro.inra.fr/macse/"
inputs:
  - id: align
    type: File
    doc: "input FASTA file containing aligned nucleotide sequences"
    inputBinding:
      position: 102
      prefix: -align
  - id: allow_NT
    type:
      - 'null'
      - string
    doc: "extra nucleotide characters to consider as N (example: -allow_NT \"#?\")"
    inputBinding:
      position: 102
      prefix: -allow_NT
  - id: ambi_OFF
    type:
      - 'null'
      - boolean
    doc: "disables ambiguities management (e.g. a 'TCN' codon will be translated into an unknown amino acid instead of a serine (S))"
    inputBinding:
      position: 102
      prefix: -ambi_OFF
  - id: canonize_ON
    type:
      - 'null'
      - boolean
    doc: "if used, MACSE will output modified NT sequences so that the same codon will be used for each instance of a given amino acid (useful to generate a consensus nucleotide sequence reflecting amino acid frequencies)"
    inputBinding:
      position: 102
      prefix: -canonize_ON
  - id: charForRemainingFS
    type:
      - 'null'
      - string
    doc: "if after replacement done at the codon level some '!' remain, this character will be used to replace them (default: no replacement, meaningful possibilities are 'N', '-', 'X' or '?') (default: !)"
    inputBinding:
      position: 102
      prefix: -charForRemainingFS
  - id: codonForExternalFS
    type:
      - 'null'
      - string
    doc: "codon which will replace external frameshift codons, i.e. used if the first or last codon contains a frameshift (default: no replacement, meaningful possibilities are \"NNN\" or \"---\")"
    inputBinding:
      position: 102
      prefix: -codonForExternalFS
  - id: codonForFinalStop
    type:
      - 'null'
      - string
    doc: "codon which will replace terminal stop codons, i.e. used if the last codon is a stop (default: no replacement, meaningful possibilities are \"NNN\" or \"---\")"
    inputBinding:
      position: 102
      prefix: -codonForFinalStop
  - id: codonForInternalFS
    type:
      - 'null'
      - string
    doc: "codon which will replace internal frameshifts (default: no replacement, meaningful possibilities are \"NNN\" or \"---\")"
    inputBinding:
      position: 102
      prefix: -codonForInternalFS
  - id: codonForInternalStop
    type:
      - 'null'
      - string
    doc: "codon which will replace internal stop codons (default: no replacement, meaningful possibilities are \"NNN\" or \"---\")"
    inputBinding:
      position: 102
      prefix: -codonForInternalStop
  - id: cons_threshold
    type:
      - 'null'
      - float
    doc: "if the most frequent amino acid of a site has a lower frequency than this threshold the consensus codon will be the unknown amino acid 'X' (values in [0-1]) (default: 0.6)"
    inputBinding:
      position: 102
      prefix: -cons_threshold
  - id: gc_def
    type:
      - 'null'
      - int
    doc: "default genetic code specified by its standard NCBI numbering (i.e. code used for sequences for which no specific code is provided in the gc_file (see genetic code list below)) (default: 1)"
    inputBinding:
      position: 102
      prefix: -gc_def
  - id: gc_file
    type:
      - 'null'
      - File
    doc: "tabular file containing on each line a sequence name and the standard NCBI numbering specifying its genetic code. Any of the following field separators could be used: space, tabulation, comma, semicolon."
    inputBinding:
      position: 102
      prefix: -gc_file
  - id: keep_gap_only_sites_ON
    type:
      - 'null'
      - boolean
    doc: "with this option gap only sites are not removed (mainly useful for parallelisation)"
    inputBinding:
      position: 102
      prefix: -keep_gap_only_sites_ON
  - id: name_cons_seq
    type:
      - 'null'
      - string
    doc: "name of the consensus sequence in the output FASTA files (default: consSeq)"
    inputBinding:
      position: 102
      prefix: -name_cons_seq
  - id: out_AA
    type: string
    default: "macse_AA.fasta"
    doc: "output FASTA file containing aligned amino acid sequences (output file name)"
    inputBinding:
      position: 102
      prefix: -out_AA
  - id: out_AA_consensus
    type: string
    default: "macse_AA_consensus.fasta"
    doc: "output FASTA file that will contain the consensus amino acid sequence, only real amino acids are considered, i.e. !, * and - are ignored (output file name)"
    inputBinding:
      position: 102
      prefix: -out_AA_consensus
  - id: out_NT
    type: string
    default: "macse_NT.fasta"
    doc: "output FASTA file containing aligned nucleotide sequences (output file name)"
    inputBinding:
      position: 102
      prefix: -out_NT
  - id: out_NT_consensus
    type: string
    default: "macse_NT_consensus.fasta"
    doc: "output FASTA file that will contain a nucleotide sequence so that its translation with the default genetic code results in the consensus amino acid sequence, there is no attempt to select the most frequent codon (output file name)"
    inputBinding:
      position: 102
      prefix: -out_NT_consensus
  - id: out_stat_per_seq
    type: string
    default: "macse_stat_per_seq.csv"
    doc: "output CSV file that will contain the number of insertions, deletions, stop codons (and more) within each sequence (output file name)"
    inputBinding:
      position: 102
      prefix: -out_stat_per_seq
  - id: out_stat_per_site
    type: string
    default: "macse_stat_per_site.csv"
    doc: "output CSV file that will contain, for each site, the frequency of each nucleotide (output file name)"
    inputBinding:
      position: 102
      prefix: -out_stat_per_site
outputs:
  - id: out_AA_file
    type:
      - 'null'
      - File
    doc: "output FASTA file containing aligned amino acid sequences"
    outputBinding:
      glob: $(inputs.out_AA)
  - id: out_AA_consensus_file
    type:
      - 'null'
      - File
    doc: "output FASTA file that will contain the consensus amino acid sequence, only real amino acids are considered, i.e. !, * and - are ignored"
    outputBinding:
      glob: $(inputs.out_AA_consensus)
  - id: out_NT_file
    type:
      - 'null'
      - File
    doc: "output FASTA file containing aligned nucleotide sequences"
    outputBinding:
      glob: $(inputs.out_NT)
  - id: out_NT_consensus_file
    type:
      - 'null'
      - File
    doc: "output FASTA file that will contain a nucleotide sequence so that its translation with the default genetic code results in the consensus amino acid sequence, there is no attempt to select the most frequent codon"
    outputBinding:
      glob: $(inputs.out_NT_consensus)
  - id: out_stat_per_seq_file
    type:
      - 'null'
      - File
    doc: "output CSV file that will contain the number of insertions, deletions, stop codons (and more) within each sequence"
    outputBinding:
      glob: $(inputs.out_stat_per_seq)
  - id: out_stat_per_site_file
    type:
      - 'null'
      - File
    doc: "output CSV file that will contain, for each site, the frequency of each nucleotide"
    outputBinding:
      glob: $(inputs.out_stat_per_site)
requirements:
  - class: InlineJavascriptRequirement
  - class: ResourceRequirement
    ramMin: 4096
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/macse:2.07--hdfd78af_0
