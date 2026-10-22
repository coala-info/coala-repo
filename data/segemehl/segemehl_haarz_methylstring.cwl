cwlVersion: v1.2
class: CommandLineTool
baseCommand: [haarz, methylstring]
label: segemehl_haarz_methylstring
doc: "haarz methylstring: get SAM file with methylation string annotation\n\nTool homepage: http://www.bioinf.uni-leipzig.de/Software/segemehl/"
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
  - id: annotationfiles
    type:
      - 'null'
      - type: array
        items: File
    doc: "List of path/filename(s) of BED or GFF file(s)"
    inputBinding:
      position: 1
      prefix: --annotationfiles
  - id: attributes
    type: ['null', string]
    doc: "Attributes that shall be selected for overlap annotation"
    inputBinding:
      position: 1
      prefix: --attributes
  - id: offsets
    type: ['null', string]
    doc: "Offsets for the annotation"
    inputBinding:
      position: 1
      prefix: --offsets
  - id: output
    type: ['null', string]
    doc: "Output file (will be sorted)"
    inputBinding:
      position: 1
      prefix: --output
  - id: uniqueonly
    type: ['null', boolean]
    doc: "Only use uniquely mapped reads (help text: generate a bam output)"
    inputBinding:
      position: 1
      prefix: --uniqueonly
  - id: threads
    type: ['null', int]
    doc: "Start n threads (default 10)"
    inputBinding:
      position: 1
      prefix: --threads
outputs:
  - id: methylstring_sam
    type: ['null', File]
    doc: SAM file with methylation string annotation
    outputBinding:
      glob: $(inputs.output)
  - id: stdout
    type: stdout
    doc: Standard output (SAM when no output file is given)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/segemehl:v0.3.4-1-deb_cv1
stdout: segemehl_haarz_methylstring.out
