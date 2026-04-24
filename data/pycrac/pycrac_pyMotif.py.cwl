cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyMotif.py
label: pycrac_pyMotif.py
doc: "pyMotif.py\n\nTool homepage: http://sandergranneman.bio.ed.ac.uk/Granneman_Lab/pyCRAC_software.html"
inputs:
  - id: annotation
    type:
      - 'null'
      - string
    doc: select which annotation (i.e. protein_coding, ncRNA, sRNA, 
      rRNA,snoRNA,snRNA, depending on the source of your GTF file) you would 
      like to focus your search on.
    inputBinding:
      position: 101
      prefix: --annotation
  - id: gtf
    type:
      - 'null'
      - File
    doc: type the path to the gtf annotation file that you want to use
    inputBinding:
      position: 101
      prefix: --gtf
  - id: input_file
    type:
      - 'null'
      - File
    doc: Provide the path to an interval gtf file. By default it expects data 
      from the standard input.
    inputBinding:
      position: 101
      prefix: --input_file
  - id: k_max
    type:
      - 'null'
      - int
    doc: this option allows you to set the longest k-mer length.
    inputBinding:
      position: 101
      prefix: --k_max
  - id: k_min
    type:
      - 'null'
      - int
    doc: this option allows you to set the shortest k-mer length.
    inputBinding:
      position: 101
      prefix: --k_min
  - id: numberofkmers
    type:
      - 'null'
      - int
    doc: choose the maximum number of enriched k-mer sequences you want to have 
      reported in output files.
    inputBinding:
      position: 101
      prefix: --numberofkmers
  - id: overlap
    type:
      - 'null'
      - int
    doc: sets the number of nucleotides a motif has to overlap with a genomic 
      feature before it is considered a hit.
    inputBinding:
      position: 101
      prefix: --overlap
  - id: range
    type:
      - 'null'
      - int
    doc: allows you to add regions flanking the genomic feature. If you set '-r 
      50' or '--range=50', then the program will add 50 nucleotides to each 
      feature on each side regardless of whether the GTF file has genes with 
      annotated UTRs.
    inputBinding:
      position: 101
      prefix: --range
  - id: tab
    type:
      - 'null'
      - File
    doc: type the path to the tab file that contains the genomic reference 
      sequence
    inputBinding:
      position: 101
      prefix: --tab
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: prints all the status messages to a file rather than the standard 
      output
    inputBinding:
      position: 101
      prefix: --verbose
  - id: zip
    type:
      - 'null'
      - File
    doc: use this option to compress all the output files in a single zip file
    inputBinding:
      position: 101
      prefix: --zip
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Use this flag to override the standard file names. Do NOT add an 
      extension.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pycrac:1.5.2--pyh7cba7a3_0
