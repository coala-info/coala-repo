cwlVersion: v1.2
class: CommandLineTool
baseCommand: ExpansionHunter
label: expansionhunter_ExpansionHunter
doc: "A tool for estimating sizes of tandem repeat expansions from sequencing data.\n\
  \nTool homepage: https://github.com/Illumina/ExpansionHunter"
inputs:
  - id: aligner
    type:
      - 'null'
      - string
    doc: Specify which aligner to use (dag-aligner or path-aligner)
    inputBinding:
      position: 101
      prefix: --aligner
  - id: analysis_mode
    type:
      - 'null'
      - string
    doc: Specify which analysis workflow to use (seeking or streaming)
    inputBinding:
      position: 101
      prefix: --analysis-mode
  - id: region_extension_length
    type:
      - 'null'
      - int
    doc: How far from on/off-target regions to search for informative reads
    inputBinding:
      position: 101
      prefix: --region-extension-length
  - id: log_level
    type:
      - 'null'
      - string
    doc: Log level (trace, debug, info, warn, error)
    inputBinding:
      position: 101
      prefix: --log-level
  - id: reads
    type: File
    secondaryFiles:
      - pattern: .bai
        required: false
      - pattern: .crai
        required: false
    doc: BAM or CRAM file containing reads
    inputBinding:
      position: 101
      prefix: --reads
  - id: reference
    type: File
    secondaryFiles:
      - .fai
    doc: FASTA file containing the reference genome
    inputBinding:
      position: 101
      prefix: --reference
  - id: sex
    type:
      - 'null'
      - string
    doc: Sex of the sample; must be either male or female
    inputBinding:
      position: 101
      prefix: --sex
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 101
      prefix: --threads
  - id: variant_catalog
    type: File
    doc: JSON file containing descriptions of variants to genotype
    inputBinding:
      position: 101
      prefix: --variant-catalog
  - id: output_prefix_path
    type: string
    doc: Output or path parameter `output_prefix_path`
    inputBinding:
      position: 102
      prefix: --output-prefix
outputs:
  - id: output_prefix
    type:
      type: array
      items: File
    doc: Prefix for the output files
    outputBinding:
      glob: $(inputs.output_prefix_path)*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/expansionhunter:5.0.0--hc26b3af_5
