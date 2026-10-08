cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mhpl8r
  - type
label: microhapulator_mhpl8r_type
doc: "Perform haplotype calling\n\nTool homepage: https://github.com/bioforensics/MicroHapulator/"
inputs:
  - id: out
    type: string
    doc: "write output to FILE; by default, output is written to the terminal (standard output)"
    default: "type.json"
    inputBinding:
      position: 1
      prefix: --out
  - id: base_qual
    type: ['null', int]
    doc: "minimum base quality (PHRED score) to be considered reliable for haplotype calling; by default B=10"
    inputBinding:
      position: 1
      prefix: --base-qual
  - id: max_depth
    type: ['null', int]
    doc: "maximum permitted read depth; by default M=1000000"
    inputBinding:
      position: 1
      prefix: --max-depth
  - id: tsv
    type: File
    doc: "path of a TSV file containing marker metadata, specifically the offset of each SNP for every marker in the panel"
    inputBinding:
      position: 2
  - id: bam
    type: File
    doc: "path of a BAM file containing NGS reads aligned to marker reference sequences and sorted"
    secondaryFiles:
      - pattern: ".bai"
        required: false
      - pattern: "^.bai"
        required: false
    inputBinding:
      position: 3
outputs:
  - id: output_file
    type: File
    doc: "Typing result (haplotype counts per marker) in JSON format"
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/microhapulator:0.8.4--pyhdfd78af_0
