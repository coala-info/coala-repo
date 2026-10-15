cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phyluce_snp_get_from_uce_alignments
label: phyluce_phyluce_snp_get_from_uce_alignments
doc: "Clean and trim raw Illumina read files\n\nTool homepage: https://github.com/faircloth-lab/phyluce"
inputs:
  - id: input
    type: Directory
    doc: "The directory containing all fasta-alignment files"
    inputBinding:
      position: 1
      prefix: --input
  - id: config
    type:
      - 'null'
      - File
    doc: "A configuration file containing all taxa names to be used for SNP extraction"
    inputBinding:
      position: 2
      prefix: --config
  - id: phased
    type:
      - 'null'
      - boolean
    doc: "Use flag if alignments contain phased sequences"
    inputBinding:
      position: 3
      prefix: --phased
  - id: missing
    type:
      - 'null'
      - boolean
    doc: "Use flag if you want to include missing data into the SNP alignment for a higher SNP yield"
    inputBinding:
      position: 4
      prefix: --missing
  - id: output
    type: string
    doc: "The output directory where results will be saved"
    inputBinding:
      position: 5
      prefix: --output
outputs:
  - id: output_dir
    type: Directory
    doc: "The output directory with snp.fasta and snp.nexus."
    outputBinding:
      glob: "$(inputs.output)"
  - id: stdout_log
    type: File
    doc: "Standard output of the program."
    outputBinding:
      glob: "get_from_uce_alignments.stdout.txt"
stdout: get_from_uce_alignments.stdout.txt
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyluce:1.6.8--py_0
