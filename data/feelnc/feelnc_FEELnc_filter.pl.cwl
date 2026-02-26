cwlVersion: v1.2
class: CommandLineTool
baseCommand: FEELnc_filter.pl
label: feelnc_FEELnc_filter.pl
doc: "Filter candidate lncRNA transcripts based on a GTF annotation file.\n\nTool
  homepage: https://github.com/tderrien/FEELnc"
inputs:
  - id: biex
    type:
      - 'null'
      - int
    doc: Discard biexonic transcripts having one exon size lower to this value
    default: 25
    inputBinding:
      position: 101
      prefix: --biex
  - id: biotype
    type:
      - 'null'
      - string
    doc: 'Only consider transcript(s) from the reference annotation having this(these)
      biotype(s) (e.g : -b transcript_biotype=protein_coding,pseudogene)'
    inputBinding:
      position: 101
      prefix: --biotype
  - id: infile
    type: File
    doc: Specify the GTF file to be filtered (such as a cufflinks 
      transcripts/merged .GTF file)
    inputBinding:
      position: 101
      prefix: --infile
  - id: linconly
    type:
      - 'null'
      - boolean
    doc: Keep only long intergenic/interveaning ncRNAs
    default: false
    inputBinding:
      position: 101
      prefix: --linconly
  - id: minfrac_over
    type:
      - 'null'
      - float
    doc: Minimal fraction out of the candidate lncRNA size to be considered for 
      overlap
    default: 0
    inputBinding:
      position: 101
      prefix: --minfrac_over
  - id: monoex
    type:
      - 'null'
      - int
    doc: 'Keep monoexonic transcript(s): mode to be selected from : -1 keep monoexonic
      antisense (for RNASeq stranded protocol), 1 keep all monoexonic, 0 remove all
      monoexonic'
    default: 0
    inputBinding:
      position: 101
      prefix: --monoex
  - id: mrnafile
    type: File
    doc: Specify the annotation GTF file to be filtered on based on sense exon 
      overlap (file of protein coding annotation)
    inputBinding:
      position: 101
      prefix: --mRNAfile
  - id: outlog
    type:
      - 'null'
      - File
    doc: Specify the log file of output
    inputBinding:
      position: 101
      prefix: --outlog
  - id: proc
    type:
      - 'null'
      - int
    doc: Number of thread for computing overlap
    default: 4
    inputBinding:
      position: 101
      prefix: --proc
  - id: size
    type:
      - 'null'
      - int
    doc: Keep transcript with a minimal size
    default: 200
    inputBinding:
      position: 101
      prefix: --size
  - id: verbosity
    type:
      - 'null'
      - int
    doc: Level of verbosity 0, 1 and 2
    default: 1
    inputBinding:
      position: 101
      prefix: --verbosity
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/feelnc:0.2--pl526_0
stdout: feelnc_FEELnc_filter.pl.out
