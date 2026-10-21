cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - Sat-BSA
  - -w
  - SVs_detection
label: sat-bsa_SVs_detection
doc: "Identify structural variants between samples by comparing the alignment depth of long reads on the assembled contigs.\n\nTool homepage: https://github.com/SegawaTenta/Sat-BSA"
inputs:
  - id: gtf_file
    type: File
    doc: Full path of gtf file (Input format 4).
    inputBinding:
      position: 1
      prefix: -g
  - id: compare_list
    type: File
    doc: Full path of compare list listing the compared samples (Input format 5).
    inputBinding:
      position: 2
      prefix: -c
  - id: reference_fasta
    type: File
    doc: Full path of fasta file used as reference genome.
    inputBinding:
      position: 3
      prefix: -r
  - id: promoter_size
    type:
      - 'null'
      - int
    doc: Defining promoter size applied for identifying SVs. Default is 0.
    inputBinding:
      position: 4
      prefix: -p
  - id: threads
    type:
      - 'null'
      - int
    doc: Thread number.
    inputBinding:
      position: 5
      prefix: -t
  - id: p_value
    type:
      - 'null'
      - float
    doc: Threshold for P-value from Fishers exact test. Default is 0.05.
    inputBinding:
      position: 6
      prefix: -v
  - id: min_indel_length
    type:
      - 'null'
      - int
    doc: The minimum length of insertion or deletion applied for analysis. Default is 5.
    inputBinding:
      position: 7
      prefix: -f
  - id: data_files
    type:
      type: array
      items: File
    doc: Files named in the list files (bam, fasta, fastq, reference, gtf). They are staged into the working directory /work, so list files must name them as /work/<file name>.
outputs:
  - id: result
    type:
      - 'null'
      - File
    doc: Detected SVs between the compared samples
    outputBinding:
      glob: filter_InDel_size_DNA_result.txt
  - id: comparison_dirs
    type:
      type: array
      items: Directory
    doc: One result directory per compared sample pair
    outputBinding:
      glob: '*_vs_*'
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.data_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sat-bsa:1.12--hdfd78af_1
    dockerOutputDirectory: /work
