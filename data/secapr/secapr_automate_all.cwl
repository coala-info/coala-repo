cwlVersion: v1.2
class: CommandLineTool
baseCommand: secapr automate_all
label: secapr_automate_all
doc: "This script automates the complete secapr pipeline, producing MSAs (allele,
  contig and BAM-consensus) from FASTQ files\n\nTool homepage: https://github.com/AntonelliLab/seqcap_processor"
inputs:
  - id: assembler
    type:
      - 'null'
      - string
    doc: The assembler to use for de-novo assembly (default=spades).
    default: spades
    inputBinding:
      position: 101
      prefix: --assembler
  - id: cores
    type:
      - 'null'
      - int
    doc: Number of computational cores for parallelization of computation.
    inputBinding:
      position: 101
      prefix: --cores
  - id: input
    type: Directory
    doc: The directory containing cleaned fastq files
    inputBinding:
      position: 101
      prefix: --input
  - id: reference
    type: File
    doc: Provide a reference library (FASTA) containing sequences for the genes 
      of interest (required to find contigs matching targeted regions).
    inputBinding:
      position: 101
      prefix: --reference
  - id: setting
    type:
      - 'null'
      - string
    doc: The setting you want to run SECAPR on. "relaxed" uses very 
      non-restrictive default values (use when samples are expected to differ 
      considerably from provided reference or are covering wide evolutionary 
      range, e.g. different families or orders). "conservative" is very 
      restrictive and can be used when samples are closely related and match 
      provided reference very well.
    inputBinding:
      position: 101
      prefix: --setting
outputs:
  - id: output
    type: Directory
    doc: The output directory where all intermediate and final data files will 
      be stored
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/secapr:2.2.8--pyh5e36f6f_0
