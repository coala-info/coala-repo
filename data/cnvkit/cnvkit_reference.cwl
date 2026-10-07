cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cnvkit.py
  - reference
label: cnvkit_reference
doc: "Compile a coverage reference from the given files (normal samples).\n\nTool homepage: https://github.com/etal/cnvkit"
inputs:
  - id: references
    type:
      type: array
      items: File
    doc: "Normal-sample target or antitarget .cnn files, or the directory that contains them."
    inputBinding:
      position: 1
  - id: fasta
    type:
      - 'null'
      - File
    secondaryFiles:
      - pattern: .fai
        required: false
    doc: "Reference genome, FASTA format (e.g. UCSC hg19.fa)"
    inputBinding:
      position: 101
      prefix: --fasta
  - id: output
    type: string
    doc: "Output file name."
    inputBinding:
      position: 101
      prefix: --output
  - id: cluster
    type:
      - 'null'
      - boolean
    doc: "Calculate and store summary stats for clustered subsets of the normal samples with similar coverage profiles."
    inputBinding:
      position: 101
      prefix: --cluster
  - id: min_cluster_size
    type:
      - 'null'
      - int
    doc: "Minimum cluster size to keep in reference profiles. [Default: 4]"
    inputBinding:
      position: 101
      prefix: --min-cluster-size
  - id: sample_sex
    type:
      - 'null'
      - string
    doc: "Specify the chromosomal sex of all given samples as male or female. (Default: guess each sample from coverage of X and Y chromosomes). (choices: m, y, male, Male, f, x, female, Female)"
    inputBinding:
      position: 101
      prefix: --sample-sex
  - id: male_reference
    type:
      - 'null'
      - boolean
    doc: "Create a male reference: shift female samples' chrX log-coverage by -1, so the reference chrX average is -1. Otherwise, shift male samples' chrX by +1, so the reference chrX average is 0."
    inputBinding:
      position: 101
      prefix: --male-reference
  - id: diploid_parx_genome
    type:
      - 'null'
      - string
    doc: "Considers the given human genome's PAR of chromosome X as autosomal. Example: 'grch38'"
    inputBinding:
      position: 101
      prefix: --diploid-parx-genome
  - id: targets
    type:
      - 'null'
      - File
    doc: "Target intervals (.bed or .list)"
    inputBinding:
      position: 101
      prefix: --targets
  - id: antitargets
    type:
      - 'null'
      - File
    doc: "Antitarget intervals (.bed or .list)"
    inputBinding:
      position: 101
      prefix: --antitargets
  - id: no_gc
    type:
      - 'null'
      - boolean
    doc: "Skip GC correction."
    inputBinding:
      position: 101
      prefix: --no-gc
  - id: no_edge
    type:
      - 'null'
      - boolean
    doc: "Skip edge-effect correction."
    inputBinding:
      position: 101
      prefix: --no-edge
  - id: no_rmask
    type:
      - 'null'
      - boolean
    doc: "Skip RepeatMasker correction."
    inputBinding:
      position: 101
      prefix: --no-rmask
outputs:
  - id: output_out
    type:
      - 'null'
      - File
    doc: "Output file name."
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cnvkit:0.9.12--pyhdfd78af_1
