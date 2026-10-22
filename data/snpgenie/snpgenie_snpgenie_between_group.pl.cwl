cwlVersion: v1.2
class: CommandLineTool
baseCommand: snpgenie_between_group.pl
label: snpgenie_snpgenie_between_group.pl
doc: "SNPGenie between-group analysis: compares two or more groups (FASTA files in
  the working directory) of aligned sequences and calculates dN/dS with CDS annotations
  from a GTF file.\n\nTool homepage: https://github.com/chasewnelson/SNPGenie"
inputs:
  - id: gtf_file
    type: File
    doc: The (one) GTF file containing CDS information (a .gtf extension is required).
    inputBinding:
      position: 101
      prefix: --gtf_file
      valueFrom: $(self.basename)
  - id: fasta_files
    type:
      type: array
      items: File
    doc: Two or more FASTA files of aligned sequences, one per group. They are staged
      into the working directory, where the script reads every FASTA file.
  - id: num_bootstraps
    type:
      - 'null'
      - int
    doc: The number of bootstrap replicates to be performed. Default is 0.
    inputBinding:
      position: 101
      prefix: --num_bootstraps
  - id: procs_per_node
    type:
      - 'null'
      - int
    doc: The number of parallel processes to be invoked. Default is 1.
    inputBinding:
      position: 101
      prefix: --procs_per_node
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: stderr
    type: stderr
    doc: Standard error
  - id: results
    type:
      type: array
      items: File
    doc: Result tables written to the working directory
    outputBinding:
      glob: between_group_*.txt
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.gtf_file)
      - $(inputs.fasta_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snpgenie:1.0--hdfd78af_1
stdout: snpgenie_snpgenie_between_group.pl.out
stderr: snpgenie_snpgenie_between_group.pl.err
