cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mrpast
  - arginfer
label: mrpast_arginfer
doc: "Infer ARG trees from VCF files.\n\nTool homepage: https://aprilweilab.github.io/"
inputs:
  - id: vcf_prefix
    type: string
    doc: The prefix of VCF file(s) to process. Generates a glob 
      "<vcf_prefix>*.vcf"
    inputBinding:
      position: 1
  - id: arg_prefix
    type: string
    doc: The prefix to use when writing the resulting ARGs to disk (.trees 
      files)
    inputBinding:
      position: 2
  - id: pop_map
    type: File
    doc: The file containing the population map (*.popmap.json)
    inputBinding:
      position: 3
  - id: ancestral
    type:
      - 'null'
      - File
    doc: The ancestral FASTA file (input). Assumes the positions start counting 
      at 1.
    inputBinding:
      position: 104
      prefix: --ancestral
  - id: dry_run
    type:
      - 'null'
      - boolean
    doc: Just emit the arguments that would be used when running SINGER.
    inputBinding:
      position: 104
      prefix: --dry-run
  - id: jobs
    type:
      - 'null'
      - int
    doc: Number of jobs (threads) to use. Defaults to 1.
    default: 1
    inputBinding:
      position: 104
      prefix: --jobs
  - id: mut_rate
    type:
      - 'null'
      - float
    doc: Expected mutation rate.
    default: '1.2e-08'
    inputBinding:
      position: 104
      prefix: --mut-rate
  - id: ne_override
    type:
      - 'null'
      - string
    doc: Provide an override for the auto-calculated (diploid) effective 
      population size.
    inputBinding:
      position: 104
      prefix: --ne-override
  - id: recomb_rate
    type:
      - 'null'
      - string
    doc: Expected recombination rate, or recombination map filename.
    default: '1e-08'
    inputBinding:
      position: 104
      prefix: --recomb-rate
  - id: samples
    type:
      - 'null'
      - int
    doc: How many ARGS to sample.
    default: 10
    inputBinding:
      position: 104
      prefix: --samples
  - id: seed
    type:
      - 'null'
      - int
    doc: Set the random seed.
    inputBinding:
      position: 104
      prefix: --seed
  - id: thin
    type:
      - 'null'
      - int
    doc: How many MC/MC iterations between samples. Default depends on the 
      inference tool.
    inputBinding:
      position: 104
      prefix: --thin
  - id: tool
    type:
      - 'null'
      - string
    doc: 'Which ARG inference tool to run: "tsinfer" (default), "relate", or "singer"'
    default: tsinfer
    inputBinding:
      position: 104
      prefix: --tool
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output, including timing information.
    inputBinding:
      position: 104
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrpast:0.2--py312h8f4af18_0
stdout: mrpast_arginfer.out
