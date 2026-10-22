cwlVersion: v1.2
class: CommandLineTool
baseCommand: [python, -m, twobitreader]
label: twobitreader_extract
doc: "Reads a 2bit file and a BED file of regions (chrom, 0-based start, end not\n\
  included) from standard input, and writes the region sequences as FASTA to\n\
  standard output. Non-region lines are skipped with a warning.\n\nTool homepage:\
  \ https://github.com/benjschiller/twobitreader"
stdin: $(inputs.regions_bed.path)
stdout: $(inputs.output_fasta)
inputs:
  - id: twobit_file
    type: File
    doc: Input 2bit file
    inputBinding:
      position: 1
  - id: regions_bed
    type: File
    doc: Regions in BED format (chrom, start, end), read from standard input
  - id: output_fasta
    type: ['null', string]
    default: regions.fa
    doc: Name of the FASTA output file (standard output of the tool)
outputs:
  - id: regions_fasta
    type: File
    doc: FASTA sequences of the requested regions
    outputBinding:
      glob: $(inputs.output_fasta)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/twobitreader:3.1.7--py_0
