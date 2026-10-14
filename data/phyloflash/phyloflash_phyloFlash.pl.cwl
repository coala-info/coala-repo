cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phyloFlash.pl
label: phyloflash_phyloFlash.pl
doc: "A script to rapidly estimate the phylogenetic composition of an Illumina (meta)genomic dataset and reconstruct SSU rRNA genes: reads are mapped to a reference SSU rRNA database (SILVA), and full-length SSU rRNA sequences are reconstructed.\n\nTool homepage: https://hrgv.github.io/phyloFlash/"
inputs:
  - id: library_name
    type: string
    doc: "Library NAME to use for output file. The name must be one word comprising only letters, numbers and \"_\" or \"-\"."
    inputBinding:
      position: 1
      prefix: "-lib"
  - id: read1
    type: File
    doc: "Forward reads in FASTA or FASTQ formats. May be compressed with Gzip (.gz extension). If interleaved reads are provided, use the interleaved flag in addition."
    inputBinding:
      position: 2
      prefix: "-read1"
  - id: read2
    type:
      - 'null'
      - File
    doc: "File containing reverse reads. If this option is omitted, phyloFlash will run in experimental single-end mode."
    inputBinding:
      position: 3
      prefix: "-read2"
  - id: dbhome
    type:
      - 'null'
      - Directory
    doc: "Directory containing phyloFlash reference databases (made by phyloFlash_makedb.pl). If not specified, phyloFlash checks the PHYLOFLASH_DBHOME environment variable and some default places."
    inputBinding:
      position: 4
      prefix: "-dbhome"
  - id: cpus
    type:
      - 'null'
      - int
    doc: "Set the number of threads to use. Defaults to all available CPU cores."
    inputBinding:
      position: 5
      prefix: "-CPUs"
  - id: crlf
    type:
      - 'null'
      - boolean
    doc: "Use CRLF as line terminator in CSV output (to become RFC4180 compliant)."
    inputBinding:
      position: 5
      prefix: "-crlf"
  - id: decimalcomma
    type:
      - 'null'
      - boolean
    doc: "Use decimal comma instead of decimal point to fix locale problems. Default: Off"
    inputBinding:
      position: 5
      prefix: "-decimalcomma"
  - id: emirge
    type:
      - 'null'
      - boolean
    doc: "Turn on EMIRGE reconstruction of SSU sequences. Default: Off"
    inputBinding:
      position: 5
      prefix: "-emirge"
  - id: skip_spades
    type:
      - 'null'
      - boolean
    doc: "Turn off SPAdes assembly of SSU sequences. Default: No"
    inputBinding:
      position: 5
      prefix: "-skip_spades"
  - id: sortmerna
    type:
      - 'null'
      - boolean
    doc: "Use Sortmerna instead of BBmap to extract SSU rRNA reads. Default: No"
    inputBinding:
      position: 5
      prefix: "-sortmerna"
  - id: interleaved
    type:
      - 'null'
      - boolean
    doc: "Interleaved readfile with R1 and R2 in a single file at read1"
    inputBinding:
      position: 5
      prefix: "-interleaved"
  - id: readlength
    type:
      - 'null'
      - int
    doc: "Sets the expected readlength (50..500). Default: -1 (auto-detect)"
    inputBinding:
      position: 5
      prefix: "-readlength"
  - id: readlimit
    type:
      - 'null'
      - int
    doc: "Limits processing to the first N reads in each input file. Default: unlimited"
    inputBinding:
      position: 5
      prefix: "-readlimit"
  - id: amplimit
    type:
      - 'null'
      - int
    doc: "Sets the limit of SSU read pairs to switch from emirge.py to emirge_amplicon.py. Default: 500000"
    inputBinding:
      position: 5
      prefix: "-amplimit"
  - id: identity
    type:
      - 'null'
      - int
    doc: "Minimum allowed identity for BBmap read mapping process in % (50..98). Default: 70"
    inputBinding:
      position: 5
      prefix: "-id"
  - id: evalue_sortmerna
    type:
      - 'null'
      - string
    doc: "E-value cutoff to use for SortMeRNA (only with -sortmerna), in scientific exponent notation. Default: 1e-09"
    inputBinding:
      position: 5
      prefix: "-evalue_sortmerna"
  - id: clusterid
    type:
      - 'null'
      - int
    doc: "Identity threshold for clustering with vsearch in % (50..100). Default: 97"
    inputBinding:
      position: 5
      prefix: "-clusterid"
  - id: taxlevel
    type:
      - 'null'
      - int
    doc: "Level in the taxonomy string to summarize read counts per taxon (1 = Domain). Default: 4 (Order)"
    inputBinding:
      position: 5
      prefix: "-taxlevel"
  - id: tophit
    type:
      - 'null'
      - boolean
    doc: "Report taxonomic summary based on the best hit per read only. Default: No (use consensus)"
    inputBinding:
      position: 5
      prefix: "-tophit"
  - id: maxinsert
    type:
      - 'null'
      - int
    doc: "Maximum insert size allowed for paired end read mapping (0..1200). Default: 1200"
    inputBinding:
      position: 5
      prefix: "-maxinsert"
  - id: sc
    type:
      - 'null'
      - boolean
    doc: "Turn on single cell MDA data mode for SPAdes assembly of SSU sequences"
    inputBinding:
      position: 5
      prefix: "-sc"
  - id: trusted
    type:
      - 'null'
      - File
    doc: "User-supplied Fasta file of trusted contigs containing SSU rRNA sequences"
    inputBinding:
      position: 5
      prefix: "-trusted"
  - id: poscov
    type:
      - 'null'
      - boolean
    doc: "Use Nhmmer to find positional coverage of reads across Barrnap's HMM model of the 16S and 18S rRNA genes. Default: Off"
    inputBinding:
      position: 5
      prefix: "-poscov"
  - id: everything
    type:
      - 'null'
      - boolean
    doc: "Turn on all the optional analyses and output options. Equivalent to -emirge -poscov -treemap -zip -log"
    inputBinding:
      position: 5
      prefix: "-everything"
  - id: almosteverything
    type:
      - 'null'
      - boolean
    doc: "Like -everything except without running EMIRGE."
    inputBinding:
      position: 5
      prefix: "-almosteverything"
  - id: html
    type:
      - 'null'
      - boolean
    doc: "Generate output in HTML format. Default: On (turn off with -nohtml)"
    inputBinding:
      position: 5
      prefix: "-html"
  - id: nohtml
    type:
      - 'null'
      - boolean
    doc: "Do not generate output in HTML format"
    inputBinding:
      position: 5
      prefix: "-nohtml"
  - id: treemap
    type:
      - 'null'
      - boolean
    doc: "Draw interactive treemap of taxonomic classification in the html report (uses the Google Visualization API, needs an internet connection). Default: Off"
    inputBinding:
      position: 5
      prefix: "-treemap"
  - id: zip
    type:
      - 'null'
      - boolean
    doc: "Compress output into a tar.gz archive file. Default: Off"
    inputBinding:
      position: 5
      prefix: "-zip"
  - id: keeptmp
    type:
      - 'null'
      - boolean
    doc: "Keep temporary/intermediate files. Default: No"
    inputBinding:
      position: 5
      prefix: "-keeptmp"
  - id: log
    type:
      - 'null'
      - boolean
    doc: "Write status messages printed to STDERR also to a log file. Default: Off"
    inputBinding:
      position: 5
      prefix: "-log"
outputs:
  - id: results
    type:
      - 'null'
      - type: array
        items: File
    doc: "Result files (report, NTU abundance tables, SSU sequences, html report, archive)"
    outputBinding:
      glob: "$(inputs.library_name).*"
  - id: stdout
    type: stdout
    doc: "Standard output"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyloflash:3.4.2--hdfd78af_0
stdout: phyloflash_phyloFlash.pl.out
