cwlVersion: v1.2
class: CommandLineTool
baseCommand: mlst.py
label: mlst-cge_mlst.py
doc: "Performs Multi-Locus Sequence Typing (MLST) on input FASTA or FASTQ files.\n\
  \nTool homepage: https://bitbucket.org/genomicepidemiology/mlst"
inputs:
  - id: infile
    type:
      type: array
      items: File
    doc: FASTA or FASTQ files to do MLST on.
    inputBinding:
      position: 1
  - id: species
    type: string
    doc: species database used for MLST prediction
    inputBinding:
      position: 2
  - id: database
    type:
      - 'null'
      - Directory
    doc: Directory containing the databases.
    inputBinding:
      position: 103
      prefix: --database
  - id: depth
    type:
      - 'null'
      - int
    doc: The minimum required depth for a gene to be considered
    inputBinding:
      position: 103
      prefix: --depth
  - id: extented_output
    type:
      - 'null'
      - boolean
    doc: Give extented output with allignment files, template and query hits in 
      fasta and a tab seperated file with allele profile results
    inputBinding:
      position: 103
      prefix: --extented_output
  - id: matrix
    type:
      - 'null'
      - boolean
    doc: 'Gives the counts all all called bases at each position in each mapped template.
      Columns are: reference base, A count, C count, G count, T count, N count, -
      count.'
    inputBinding:
      position: 103
      prefix: --matrix
  - id: method_path
    type:
      - 'null'
      - string
    doc: Path to the method to use (kma or blastn) if assembled contigs are 
      inputted the path to executable blastn should be given, if fastq files are
      given path to executable kma should be given
    inputBinding:
      position: 103
      prefix: --method_path
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Output directory.
    inputBinding:
      position: 103
      prefix: --outdir
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Suppress verbose output.
    inputBinding:
      position: 103
      prefix: --quiet
  - id: tmp_dir
    type:
      - 'null'
      - Directory
    doc: Temporary directory for storage of the results from the external 
      software.
    inputBinding:
      position: 103
      prefix: --tmp_dir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mlst-cge:2.0.9--hdfd78af_0
stdout: mlst-cge_mlst.py.out
