cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mhpl8r
  - repetitive
label: microhapulator_mhpl8r_repetitive
doc: "Calculate number of reads that map to a marker sequence but map preferentially to another locus when aligned to the whole genome\n\nTool homepage: https://github.com/bioforensics/MicroHapulator/"
inputs:
  - id: out
    type: string
    doc: "write output to FILE; by default, output is written to the terminal (standard output)"
    default: "repetitive.csv"
    inputBinding:
      position: 1
      prefix: --out
  - id: base_qual
    type: ['null', int]
    doc: "minimum base quality (PHRED score) to be considered reliable for haplotype calling; by default B=10"
    inputBinding:
      position: 1
      prefix: --base-qual
  - id: markerbam
    type: File
    doc: "alignment file of reads aligned to marker sequences"
    secondaryFiles:
      - pattern: ".bai"
        required: false
      - pattern: "^.bai"
        required: false
    inputBinding:
      position: 2
  - id: refbam
    type: File
    doc: "alignment file in BAM format of reads aligned to hg38"
    secondaryFiles:
      - pattern: ".bai"
        required: false
      - pattern: "^.bai"
        required: false
    inputBinding:
      position: 3
  - id: tsv
    type: File
    doc: "marker definitions tsv including chromosome and full reference genome offset columns"
    inputBinding:
      position: 4
outputs:
  - id: output_file
    type: File
    doc: "Repetitive read counts per marker in CSV format"
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/microhapulator:0.8.4--pyhdfd78af_0
