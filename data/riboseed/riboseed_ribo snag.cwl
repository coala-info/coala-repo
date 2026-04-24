cwlVersion: v1.2
class: CommandLineTool
baseCommand: ribo snag
label: riboseed_ribo snag
doc: "Use to extract regions of interest based on supplied Locus tags and evaluate
  the extracted regions\n\nTool homepage: https://github.com/nickp60/riboSeed"
inputs:
  - id: genbank_genome
    type: File
    doc: Genbank file (WITH SEQUENCE)
    inputBinding:
      position: 1
  - id: clustered_loci
    type: string
    doc: output from riboSelect
    inputBinding:
      position: 2
  - id: barrnap_exe
    type:
      - 'null'
      - File
    doc: Path to barrnap executable
    inputBinding:
      position: 103
      prefix: --barrnap_exe
  - id: clobber
    type:
      - 'null'
      - boolean
    doc: overwrite previous output files
    inputBinding:
      position: 103
      prefix: --clobber
  - id: flanking_length
    type:
      - 'null'
      - int
    doc: length of flanking regions, in bp
    inputBinding:
      position: 103
      prefix: --flanking_length
  - id: just_extract
    type:
      - 'null'
      - boolean
    doc: Dont bother making an MSA, calculating Shannon Entropy, BLASTing, 
      generating plots etc; just extract the regions
    inputBinding:
      position: 103
      prefix: --just_extract
  - id: kingdom
    type:
      - 'null'
      - string
    doc: kingdom for barrnap
    inputBinding:
      position: 103
      prefix: --kingdom
  - id: linear
    type:
      - 'null'
      - boolean
    doc: if the genome is not circular, and an region of interest (including 
      flanking bits) extends past chromosome end, this extends the sequence past
      chromosome origin forward by 5kb
    inputBinding:
      position: 103
      prefix: --linear
  - id: mafft_exe
    type:
      - 'null'
      - File
    doc: Path to MAFFT executable
    inputBinding:
      position: 103
      prefix: --mafft_exe
  - id: makeblastdb_exe
    type:
      - 'null'
      - File
    doc: Path to makeblastdb executable
    inputBinding:
      position: 103
      prefix: --makeblastdb_exe
  - id: msa_kmers
    type:
      - 'null'
      - boolean
    doc: calculate kmer similarity based on aligned sequences instead of raw 
      sequences
    inputBinding:
      position: 103
      prefix: --msa_kmers
  - id: msa_tool
    type:
      - 'null'
      - string
    doc: Path to PRANK executable
    inputBinding:
      position: 103
      prefix: --msa_tool
  - id: name
    type:
      - 'null'
      - string
    doc: rename the contigs with this prefix
    inputBinding:
      position: 103
      prefix: --name
  - id: no_revcomp
    type:
      - 'null'
      - boolean
    doc: default returns reverse complimented seq if majority of regions on 
      reverse strand. if --no_revcomp, this is overwridden
    inputBinding:
      position: 103
      prefix: --no_revcomp
  - id: output_directory
    type: Directory
    doc: output directory
    inputBinding:
      position: 103
      prefix: --output
  - id: padding
    type:
      - 'null'
      - int
    doc: if treating as circular, this controls the length of sequence added to 
      the 5' and 3' ends to allow for selecting regions that cross the 
      chromosome's origin
    inputBinding:
      position: 103
      prefix: --padding
  - id: prank_exe
    type:
      - 'null'
      - File
    doc: Path to PRANK executable
    inputBinding:
      position: 103
      prefix: --prank_exe
  - id: seq_name
    type:
      - 'null'
      - string
    doc: 'name of genome; default: inferred from file name, as many casesinvolve multiple
      contigs, etc, making inference from record intractable'
    inputBinding:
      position: 103
      prefix: --seq_name
  - id: skip_blast
    type:
      - 'null'
      - boolean
    doc: Skip running BLAST Comparisons
    inputBinding:
      position: 103
      prefix: --skip_blast
  - id: skip_kmers
    type:
      - 'null'
      - boolean
    doc: Just plot entropy if MSA
    inputBinding:
      position: 103
      prefix: --skip_kmers
  - id: title
    type:
      - 'null'
      - string
    doc: 'String for plot title; uses matplotlib math processing for italics (you
      know, the LaTeX $..$ syntax): https://matplotlib.org/users/mathtext.html'
    inputBinding:
      position: 103
      prefix: --title
  - id: verbosity
    type:
      - 'null'
      - int
    doc: 1 = debug(), 2 = info(), 3 = warning(), 4 = error() and 5 = critical()
    inputBinding:
      position: 103
      prefix: --verbosity
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/riboseed:0.4.90--py_0
stdout: riboseed_ribo snag.out
