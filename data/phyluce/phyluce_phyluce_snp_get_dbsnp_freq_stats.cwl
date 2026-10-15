cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phyluce_snp_get_dbsnp_freq_stats
label: phyluce_phyluce_snp_get_dbsnp_freq_stats
doc: "Get the average contig length, by species, within a combined fasta\n\nTool homepage: https://github.com/faircloth-lab/phyluce"
inputs:
  - id: dbsnp
    type: File
    doc: "CSV input from dbSNP giving SNP positions within UCE"
    inputBinding:
      position: 1
      prefix: --dbsnp
  - id: xml
    type: File
    doc: "The XML file holiding locus data from dbSNP"
    inputBinding:
      position: 2
      prefix: --xml
  - id: output
    type:
      - 'null'
      - string
    doc: "The output file"
    inputBinding:
      position: 3
      prefix: --output
  - id: output2
    type:
      - 'null'
      - string
    doc: "The output file"
    inputBinding:
      position: 4
      prefix: --output2
  - id: dupefile
    type:
      - 'null'
      - File
    doc: "The path to a lastz file of lastz-against-self results"
    inputBinding:
      position: 5
      prefix: --dupefile
outputs:
  - id: freq_stats
    type:
      - 'null'
      - File
    doc: "The SNP frequency statistics (written to --output)."
    outputBinding:
      glob: "$(inputs.output)"
  - id: freq_table
    type:
      - 'null'
      - File
    doc: "The table of all SNPs with frequency (written to --output2)."
    outputBinding:
      glob: "$(inputs.output2)"
  - id: stdout_log
    type: File
    doc: "Standard output of the program (holds the statistics when --output is not set)."
    outputBinding:
      glob: "get_dbsnp_freq_stats.stdout.txt"
stdout: get_dbsnp_freq_stats.stdout.txt
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyluce:1.6.8--py_0
