cwlVersion: v1.2
class: CommandLineTool
baseCommand: aptardi
label: aptardi
doc: "The provided text is an error log from a container build process and does not
  contain the tool's help documentation. Based on the tool name hint 'aptardi' (Alternative
  Polyadenylation Transcriptome Analysis from RNA-seq and DNA-seq Integration), the
  following is the standard argument structure for this tool.\n\nTool homepage: https://github.com/luskry/aptardi"
inputs:
  - id: dna_bam
    type:
      - 'null'
      - File
    doc: Optional DNA-seq BAM file (must be sorted and indexed)
    inputBinding:
      position: 101
      prefix: --dna
  - id: genome_fasta
    type: File
    doc: Reference genome FASTA file
    inputBinding:
      position: 101
      prefix: --genome
  - id: model_file
    type:
      - 'null'
      - File
    doc: Path to a specific aptardi model file (.hdf5)
    inputBinding:
      position: 101
      prefix: --model
  - id: rna_bam
    type: File
    doc: Input RNA-seq BAM file (must be sorted and indexed)
    inputBinding:
      position: 101
      prefix: --rna
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Increase output verbosity
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output_prefix
    type: File
    doc: Prefix for output files
    outputBinding:
      glob: $(inputs.output_prefix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/aptardi:1.4--pyh5e36f6f_0
