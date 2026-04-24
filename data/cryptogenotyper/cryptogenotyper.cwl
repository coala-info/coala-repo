cwlVersion: v1.2
class: CommandLineTool
baseCommand: cryptogenotyper
label: cryptogenotyper
doc: "In silico type cryptosporidium from sanger reads in AB1 format\n\nTool homepage:
  https://github.com/phac-nml/CryptoGenotyper"
inputs:
  - id: databasefile
    type:
      - 'null'
      - File
    doc: Path to your custom, highly curated database of 18S or gp60 marker 
      reference sequences in FASTA format
    inputBinding:
      position: 101
      prefix: --databasefile
  - id: forwardprimername
    type:
      - 'null'
      - string
    doc: Name of the forward primer to identify forward read (e.g. gp60F, SSUF)
    inputBinding:
      position: 101
      prefix: --forwardprimername
  - id: input
    type: File
    doc: Path to SINGLE directory with AB1/FASTA forward and reverse files OR 
      path to a SINGLE AB1/FASTA file. Use -f and/or -r to filter inputs
    inputBinding:
      position: 101
      prefix: --input
  - id: marker
    type: string
    doc: Name of the marker. Currently gp60 and 18S markers are supported
    inputBinding:
      position: 101
      prefix: --marker
  - id: noheaderline
    type:
      - 'null'
      - boolean
    doc: Display header on tab-delimited file
    inputBinding:
      position: 101
      prefix: --noheaderline
  - id: outputprefix
    type:
      - 'null'
      - string
    doc: Output name prefix for the results (e.g. test results in 
      test_report.fa)
    inputBinding:
      position: 101
      prefix: --outputprefix
  - id: reverseprimername
    type:
      - 'null'
      - string
    doc: Name of the reverse primer to identify forward read (e.g. gp60R, SSUR)
    inputBinding:
      position: 101
      prefix: --reverseprimername
  - id: seqtype
    type:
      - 'null'
      - string
    doc: 'Input sequences type. Select one option out of these three: contig - both
      F and R sequences provided forward - forward only sequence provided reverse
      - reverse only sequence provided'
    inputBinding:
      position: 101
      prefix: --seqtype
  - id: suffix
    type:
      - 'null'
      - string
    doc: Optional suffix to filter filenames (e.g. only include files ending 
      with a specific pattern)
    inputBinding:
      position: 101
      prefix: --suffix
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Turn on verbose logging
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cryptogenotyper:1.5.0--pyhdfd78af_3
stdout: cryptogenotyper.out
