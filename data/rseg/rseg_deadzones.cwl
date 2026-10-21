cwlVersion: v1.2
class: CommandLineTool
baseCommand: deadzones
label: rseg_deadzones
doc: "Find unmappable regions (deadzones) of a genome from FASTA files, for use with RSEG.\n\nTool homepage: https://smithlabresearch.org/software/rseg/"
inputs:
  - id: fasta_chrom_files
    type:
      type: array
      items: File
    doc: One or more FASTA chromosome files
    inputBinding:
      position: 200
  - id: kmer
    type:
      - 'null'
      - int
    doc: Width of k-mers
    inputBinding:
      position: 102
      prefix: -kmer
  - id: prefix_length
    type:
      - 'null'
      - int
    doc: 'prefix length (default 5)'
    inputBinding:
      position: 102
      prefix: -prefix
  - id: suffix
    type:
      - 'null'
      - string
    doc: suffix of FASTA files (assumes -c indicates dir)
    inputBinding:
      position: 102
      prefix: -suffix
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: print more run information
    inputBinding:
      position: 102
      prefix: -verbose
  - id: output_path
    type:
      - 'null'
      - string
    doc: 'Name of output file (default: stdout)'
    inputBinding:
      position: 103
      prefix: -output
outputs:
  - id: stdout
    type: stdout
    doc: Standard output (the deadzones BED when no output file is given)
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output deadzones file
    outputBinding:
      glob: $(inputs.output_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rseg:0.4.9--he941832_1
stdout: rseg_deadzones.out
