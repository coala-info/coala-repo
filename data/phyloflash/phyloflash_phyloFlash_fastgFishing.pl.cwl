cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phyloFlash_fastgFishing.pl
label: phyloflash_phyloFlash_fastgFishing.pl
doc: "Finds contig clusters with SSU rRNA genes in an assembly graph (Fastg) from MEGAHIT or SPAdes.\n\nTool homepage: https://hrgv.github.io/phyloFlash/"
inputs:
  - id: fastg
    type: File
    doc: "Input Fastg file from Megahit or Spades."
    inputBinding:
      position: 1
      prefix: "--fastg"
  - id: fasta
    type: File
    doc: "Input Fasta file, to convert Fastg sequence identifiers to corresponding Fasta sequence IDs (the *.contigs.fa file for MEGAHIT; scaffolds or contigs file for SPAdes)."
    inputBinding:
      position: 1
      prefix: "--fasta"
  - id: paths
    type:
      - 'null'
      - File
    doc: "Input Paths file, to convert EDGE to NODE identifiers, if using SPAdes assembler."
    inputBinding:
      position: 1
      prefix: "--paths"
  - id: assembler
    type:
      - 'null'
      - string
    doc: "Assembler used. Either \"megahit\" or \"spades\". Default: megahit"
    inputBinding:
      position: 1
      prefix: "--assembler"
  - id: compare_ssu
    type:
      - 'null'
      - File
    doc: "Fasta file of SSU sequences from a targeted assembly of this library, to compare with the sequences extracted by barrnap."
    inputBinding:
      position: 1
      prefix: "--compare-ssu"
  - id: compare_zip
    type:
      - 'null'
      - File
    doc: "phyloFlash tar.gz archive with a targeted SSU assembly of this library, to compare with the sequences extracted by barrnap."
    inputBinding:
      position: 1
      prefix: "--compare-zip"
  - id: out
    type:
      - 'null'
      - string
    doc: "Output file name prefix. Default: 'test'"
    default: "test"
    inputBinding:
      position: 1
      prefix: "--out"
  - id: clusteronly
    type:
      - 'null'
      - boolean
    doc: "Do not search for SSU rRNA sequences, instead only report all connected contig clusters above length threshold. Default: Off"
    inputBinding:
      position: 1
      prefix: "--clusteronly"
  - id: cutoff
    type:
      - 'null'
      - int
    doc: "Minimum total sequence length of contig cluster to be reported. Default: 100000"
    inputBinding:
      position: 1
      prefix: "--cutoff"
  - id: min_ssu_frac
    type:
      - 'null'
      - float
    doc: "Minimum fraction of SSU sequence to report (parameter passed to the '--reject' option in Barrnap). Default: 0.2"
    inputBinding:
      position: 1
      prefix: "--min-SSU-frac"
  - id: outfasta
    type:
      - 'null'
      - boolean
    doc: "Output Fasta files for clusters with total length above cutoff. Default: No"
    inputBinding:
      position: 1
      prefix: "--outfasta"
  - id: cpus
    type:
      - 'null'
      - int
    doc: "Number of CPUs to use for Barrnap rRNA prediction. Default: 8"
    inputBinding:
      position: 1
      prefix: "--CPUs"
outputs:
  - id: results
    type:
      - 'null'
      - type: array
        items: File
    doc: "Files written with the output prefix"
    outputBinding:
      glob: "$(inputs.out)*"
  - id: stdout
    type: stdout
    doc: "Standard output"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyloflash:3.4.2--hdfd78af_0
stdout: phyloflash_phyloFlash_fastgFishing.pl.out
