cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cnvkit.py
  - autobin
label: cnvkit_autobin
doc: "Quickly calculate reasonable bin sizes from BAM read counts.\n\nTool homepage: https://github.com/etal/cnvkit"
inputs:
  - id: bams
    type:
      type: array
      items: File
    secondaryFiles:
      - pattern: .bai
        required: false
    doc: "Sample BAM file(s) to test for target coverage"
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
  - id: method
    type:
      - 'null'
      - string
    doc: "Sequencing protocol: hybridization capture ('hybrid'), targeted amplicon sequencing ('amplicon'), or whole genome sequencing ('wgs'). Determines whether and how to use antitarget bins. [Default: hybrid] (choices: hybrid, amplicon, wgs)"
    inputBinding:
      position: 101
      prefix: --method
  - id: access
    type:
      - 'null'
      - File
    doc: "Sequencing-accessible genomic regions, or exons to use as possible targets (e.g. output of refFlat2bed.py)"
    inputBinding:
      position: 101
      prefix: --access
  - id: targets
    type:
      - 'null'
      - File
    doc: "Potentially targeted genomic regions, e.g. all possible exons for the reference genome. Format: BED, interval list, etc."
    inputBinding:
      position: 101
      prefix: --targets
  - id: bp_per_bin
    type:
      - 'null'
      - float
    doc: "Desired average number of sequencing read bases mapped to each bin. [Default: 100000.0]"
    inputBinding:
      position: 101
      prefix: --bp-per-bin
  - id: target_max_size
    type:
      - 'null'
      - int
    doc: "Maximum size of target bins. [Default: 20000]"
    inputBinding:
      position: 101
      prefix: --target-max-size
  - id: target_min_size
    type:
      - 'null'
      - int
    doc: "Minimum size of target bins. [Default: 20]"
    inputBinding:
      position: 101
      prefix: --target-min-size
  - id: antitarget_max_size
    type:
      - 'null'
      - int
    doc: "Maximum size of antitarget bins. [Default: 500000]"
    inputBinding:
      position: 101
      prefix: --antitarget-max-size
  - id: antitarget_min_size
    type:
      - 'null'
      - int
    doc: "Minimum size of antitarget bins. [Default: 500]"
    inputBinding:
      position: 101
      prefix: --antitarget-min-size
  - id: annotate
    type:
      - 'null'
      - File
    doc: "Use gene models from this file to assign names to the target regions. Format: UCSC refFlat.txt or ensFlat.txt file (preferred), or BED, interval list, GFF, or similar."
    inputBinding:
      position: 101
      prefix: --annotate
  - id: short_names
    type:
      - 'null'
      - boolean
    doc: "Reduce multi-accession bait labels to be short and consistent."
    inputBinding:
      position: 101
      prefix: --short-names
  - id: target_output_bed
    type:
      - 'null'
      - string
    doc: "Filename for target BED output. If not specified, constructed from the input file basename."
    inputBinding:
      position: 101
      prefix: --target-output-bed
  - id: antitarget_output_bed
    type:
      - 'null'
      - string
    doc: "Filename for antitarget BED output. If not specified, constructed from the input file basename."
    inputBinding:
      position: 101
      prefix: --antitarget-output-bed
outputs:
  - id: target_output_bed_out
    type:
      - 'null'
      - File
    doc: "Filename for target BED output. If not specified, constructed from the input file basename."
    outputBinding:
      glob: $(inputs.target_output_bed)
  - id: antitarget_output_bed_out
    type:
      - 'null'
      - File
    doc: "Filename for antitarget BED output. If not specified, constructed from the input file basename."
    outputBinding:
      glob: $(inputs.antitarget_output_bed)
  - id: bed_files
    type:
      type: array
      items: File
    doc: "Target and antitarget BED files written by autobin"
    outputBinding:
      glob: "*.bed"
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cnvkit:0.9.12--pyhdfd78af_1
stdout: cnvkit_autobin.out
