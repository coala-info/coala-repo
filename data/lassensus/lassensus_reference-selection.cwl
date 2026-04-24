cwlVersion: v1.2
class: CommandLineTool
baseCommand: lassensus reference-selection
label: lassensus_reference-selection
doc: "Selects the best reference genome from a directory of input FASTQ files based
  on various criteria.\n\nTool homepage: https://github.com/DaanJansen94/lassensus"
inputs:
  - id: completeness
    type:
      - 'null'
      - int
    doc: Minimum sequence completeness (1-100 percent)
    inputBinding:
      position: 101
      prefix: --completeness
  - id: genome
    type:
      - 'null'
      - string
    doc: Genome completeness filter (1=Complete, 2=Partial, 3=None)
    inputBinding:
      position: 101
      prefix: --genome
  - id: host
    type:
      - 'null'
      - string
    doc: Host filter (1=Human, 2=Rodent, 3=Both, 4=None)
    inputBinding:
      position: 101
      prefix: --host
  - id: input_dir
    type: Directory
    doc: Directory containing input FASTQ files
    inputBinding:
      position: 101
      prefix: --input_dir
  - id: metadata
    type:
      - 'null'
      - string
    doc: Metadata filter (1=Location, 2=Date, 3=Both, 4=None)
    inputBinding:
      position: 101
      prefix: --metadata
  - id: min_identity
    type:
      - 'null'
      - float
    doc: Minimum identity threshold for reference selection
    inputBinding:
      position: 101
      prefix: --min_identity
  - id: ref_reads
    type:
      - 'null'
      - int
    doc: 'Number of reads to rarefy for reference selection step (default: 10,000).
      This is separate from --max_reads used in consensus generation.'
    inputBinding:
      position: 101
      prefix: --ref_reads
outputs:
  - id: output_dir
    type: Directory
    doc: Directory for pipeline output
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lassensus:0.0.5--pyhdfd78af_0
