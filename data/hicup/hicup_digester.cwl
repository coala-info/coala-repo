cwlVersion: v1.2
class: CommandLineTool
baseCommand: hicup_digester
label: hicup_digester
doc: 'The ''hicup_digester'' script creates a reference genome, cut with a specified
  restriction enzyme. HiCUP Digester identifies the cut sites in FASTA files and prints
  the results to file for subsequent processing by HiCUP Filter.


  Tool homepage: http://www.bioinformatics.babraham.ac.uk/projects/hicup/'
inputs:
  - id: fasta_files
    type:
      type: array
      items: File
    doc: Genome FASTA files to digest
    inputBinding:
      position: 2
  - id: arima
    type:
      - 'null'
      - boolean
    doc: 'Set the --re1 option to that used by the Arima protocol: ^GATC,DpnII:G^ANTC,Arima'
    inputBinding:
      position: 103
      prefix: --arima
  - id: re1
    type:
      - 'null'
      - string
    doc: Restriction enzyme used to digest the genome (the enzyme that forms the ligation
      junction), e.g. A^GATCT,BglII. Several enzymes are separated with ':', e.g.
      A^GATCT,BglII:A^AGCTT,HindIII:^GATC,DpnII
    inputBinding:
      position: 103
      prefix: --re1
  - id: re2
    type:
      - 'null'
      - string
    doc: Restriction enzyme used instead of sonication to shorten di-tags. This restriction
      site does NOT form a Hi-C ligation junction, e.g. AG^CT,AluI
    inputBinding:
      position: 103
      prefix: --re2
  - id: config
    type:
      - 'null'
      - File
    doc: Specify the configuration file
    inputBinding:
      position: 103
      prefix: --config
  - id: genome
    type:
      - 'null'
      - string
    doc: Name of the genome to be digested (not the path to the genome file or files,
      but the genome name to include in the output file)
    inputBinding:
      position: 103
      prefix: --genome
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Suppress all progress reports
    inputBinding:
      position: 103
      prefix: --quiet
  - id: zip_output
    type:
      - 'null'
      - boolean
    doc: Print the results to a gzip file
    inputBinding:
      position: 103
      prefix: --zip
  - id: output_directory_path
    type: string
    default: hicup_out
    doc: Directory to write output files
    inputBinding:
      position: 104
      prefix: --outdir
outputs:
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Directory with all output files
    outputBinding:
      glob: $(inputs.output_directory_path)
  - id: digest_file
    type:
      - 'null'
      - type: array
        items: File
    doc: Genome digest file (Digest_<genome>_<enzyme>_...txt)
    outputBinding:
      glob: $(inputs.output_directory_path)/Digest_*
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.output_directory_path)
        entry: '$({class: "Directory", listing: []})'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hicup:0.9.2--hdfd78af_1
