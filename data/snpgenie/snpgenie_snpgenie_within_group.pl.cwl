cwlVersion: v1.2
class: CommandLineTool
baseCommand: snpgenie_within_group.pl
label: snpgenie_snpgenie_within_group.pl
doc: "SNPGenie within-group analysis: calculates dN/dS, piN/piS, and gene diversity
  for a single aligned FASTA file, with accompanying CDS annotations in a GTF file.\n\nTool
  homepage: https://github.com/chasewnelson/SNPGenie"
inputs:
  - id: fasta_file_name
    type: File
    doc: The (one) FASTA file containing aligned nucleotide sequences (a .fa or
      .fasta extension is required).
    inputBinding:
      position: 101
      prefix: --fasta_file_name
      valueFrom: $(self.basename)
  - id: gtf_file_name
    type: File
    doc: The (one) GTF file containing CDS information (a .gtf extension is required).
    inputBinding:
      position: 101
      prefix: --gtf_file_name
      valueFrom: $(self.basename)
  - id: num_bootstraps
    type:
      - 'null'
      - int
    doc: The number of bootstrap replicates to be performed for calculating the
      standard error of dN-dS. Default is 0.
    inputBinding:
      position: 101
      prefix: --num_bootstraps
  - id: procs_per_node
    type:
      - 'null'
      - int
    doc: The number of parallel processes to be invoked for processing codons and
      bootstraps. Default is 1.
    inputBinding:
      position: 101
      prefix: --procs_per_node
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: results
    type:
      type: array
      items: File
    doc: Result tables written to the working directory (codon, product and variant results)
    outputBinding:
      glob: within_group_*.txt
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.fasta_file_name)
      - $(inputs.gtf_file_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snpgenie:1.0--hdfd78af_1
stdout: snpgenie_snpgenie_within_group.pl.out
