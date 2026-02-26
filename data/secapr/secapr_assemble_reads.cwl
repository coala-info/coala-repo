cwlVersion: v1.2
class: CommandLineTool
baseCommand: secapr assemble_reads
label: secapr_assemble_reads
doc: "Assemble trimmed Illumina read files (fastq)\n\nTool homepage: https://github.com/AntonelliLab/seqcap_processor"
inputs:
  - id: contig_length
    type:
      - 'null'
      - int
    doc: Set the minimum contig length for the assembly. Contigs that are 
      shorter than this threshold will be discarded.
    inputBinding:
      position: 101
      prefix: --contig_length
  - id: cores
    type:
      - 'null'
      - int
    doc: For parallel processing you can set the number of cores you want to run
      the assembly on.
    inputBinding:
      position: 101
      prefix: --cores
  - id: input
    type: Directory
    doc: Call the folder that contains the cleaned fastq read files. The fastq 
      files should be organized in a separate subfolder for each sample (default
      output of secapr clean_reads function).
    inputBinding:
      position: 101
      prefix: --input
  - id: kmer
    type:
      - 'null'
      - string
    doc: Set the kmer value. Provide a list of kmers for Spades, e.g. "--kmer 
      21,33,55". Default is 21,33,55,77,99,127. Note that Spades only accepts 
      uneven kmer values.
    default: 21,33,55,77,99,127
    inputBinding:
      position: 101
      prefix: --kmer
  - id: max_memory
    type:
      - 'null'
      - int
    doc: Set the maximum memory to be used during assembly in GB. This can be 
      necessary when working with computing nodes with limited memory or to 
      avoid over-allocation of computing resources on clusters which can in some
      cases cause your assembly to be stopped or interrupted.
    inputBinding:
      position: 101
      prefix: --max_memory
outputs:
  - id: output
    type: Directory
    doc: The output directory where results will be saved
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/secapr:2.2.8--pyh5e36f6f_0
