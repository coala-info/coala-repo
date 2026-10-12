cwlVersion: v1.2
class: CommandLineTool
baseCommand: orthofisher
label: orthofisher
doc: "orthofisher conducts high-throughput automated sequence similarity searches
  across proteomes and creates fasta files of all significant hits.\n\nTool homepage:
  https://github.com/JLSteenwyk/orthofisher.git"
inputs:
  - id: bitscore_threshold
    type:
      - 'null'
      - float
    doc: fraction of a bitscore to be considered similar to top hit
    inputBinding:
      position: 101
      prefix: --bitscore
  - id: cpu_workers
    type:
      - 'null'
      - int
    doc: CPU workers for multithreading
    inputBinding:
      position: 101
      prefix: --cpu
  - id: evalue_threshold
    type:
      - 'null'
      - float
    doc: e-value threshold used when conducting sequence similarity searches
    inputBinding:
      position: 101
      prefix: --evalue
  - id: fasta_file_list
    type: File
    doc: "A one or two column tab delimited file that points to the location of fasta
      files that will be searched using HMMs in the first column.\n      Typically,
      these are protein fasta files from the entire genome/transcriptome of an organism.
      The second column of the file specifies\n      the identifier for the organism.
      If there is no second column, the gene identifier will be used."
    inputBinding:
      position: 101
      prefix: --fasta
  - id: hmms_file_list
    type: File
    doc: A single column file with the location of HMMs that you wish to 
      identify or fish out of a given proteome.
    inputBinding:
      position: 101
      prefix: --hmm
  - id: output_directory_name
    type: string
    default: orthofisher_output
    doc: name of the outputted directory
    inputBinding:
      position: 101
      prefix: --output_dir
  - id: fasta_files
    type:
      type: array
      items: File
    doc: The fasta files named in the fasta list; staged into the working directory so the listed names resolve
  - id: hmm_files
    type:
      type: array
      items: File
    doc: The HMM files named in the HMM list; staged into the working directory so the listed names resolve
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_directory
    type: Directory
    doc: Directory with the fasta files of hits and the summary tables
    outputBinding:
      glob: $(inputs.output_directory_name)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.fasta_files)
      - $(inputs.hmm_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/orthofisher:1.1.1--pyhdfd78af_0
stdout: orthofisher.out
