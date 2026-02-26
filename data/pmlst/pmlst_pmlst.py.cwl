cwlVersion: v1.2
class: CommandLineTool
baseCommand: pmlst.py
label: pmlst_pmlst.py
doc: "Perform pMLST prediction on FASTA or FASTQ files.\n\nTool homepage: https://bitbucket.org/genomicepidemiology/pmlst"
inputs:
  - id: infile
    type:
      type: array
      items: File
    doc: FASTA or FASTQ files to do pMLST on.
    inputBinding:
      position: 1
  - id: database
    type:
      - 'null'
      - Directory
    doc: Directory containing the databases.
    inputBinding:
      position: 102
      prefix: --database
  - id: extented_output
    type:
      - 'null'
      - boolean
    doc: Give extented output with allignment files, template and query hits in 
      fasta and a tab seperated file with allele profile results
    inputBinding:
      position: 102
      prefix: --extented_output
  - id: method_path
    type:
      - 'null'
      - string
    doc: Path to the method to use (kma or blastn) if assembled contigs are 
      inputted the path to executable blastn should be given, if fastq files are
      given path to executable kma should be given
    inputBinding:
      position: 102
      prefix: --method_path
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Output directory.
    inputBinding:
      position: 102
      prefix: --outdir
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: quiet
    inputBinding:
      position: 102
      prefix: --quiet
  - id: scheme
    type: string
    doc: scheme database used for pMLST prediction
    inputBinding:
      position: 102
      prefix: --scheme
  - id: tmp_dir
    type:
      - 'null'
      - Directory
    doc: Temporary directory for storage of the results from the external 
      software.
    inputBinding:
      position: 102
      prefix: --tmp_dir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pmlst:2.0.3--hdfd78af_0
stdout: pmlst_pmlst.py.out
