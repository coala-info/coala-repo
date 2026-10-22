cwlVersion: v1.2
class: CommandLineTool
baseCommand: [haarz, callmethyl]
label: segemehl_haarz_callmethyl
doc: "haarz callmethyl: generate methylation vcf from bam\n\nTool homepage: http://www.bioinf.uni-leipzig.de/Software/segemehl/"
inputs:
  - id: database
    type:
      type: array
      items: File
    secondaryFiles:
      - .fai
    doc: "List of path/filename(s) of fasta database sequence(s)"
    inputBinding:
      position: 1
      prefix: --database
  - id: bam
    type: File
    secondaryFiles:
      - .bai
    doc: "Sorted and indexed bam file (index must sit beside it)"
    inputBinding:
      position: 1
      prefix: --bam
  - id: threads
    type: ['null', int]
    doc: "Start n threads (default 10)"
    inputBinding:
      position: 1
      prefix: --threads
  - id: output
    type: ['null', string]
    doc: "Output file (will be sorted)"
    inputBinding:
      position: 1
      prefix: --output
  - id: uniqueonly
    type: ['null', boolean]
    doc: "Only use uniquely mapped reads"
    inputBinding:
      position: 1
      prefix: --uniqueonly
outputs:
  - id: methylation_vcf
    type: ['null', File]
    doc: Methylation VCF
    outputBinding:
      glob: $(inputs.output)
  - id: stdout
    type: stdout
    doc: Standard output (SAM when no output file is given)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/segemehl:v0.3.4-1-deb_cv1
stdout: segemehl_haarz_callmethyl.out
