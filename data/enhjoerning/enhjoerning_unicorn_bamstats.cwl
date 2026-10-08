cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - unicorn
  - bamstats
label: enhjoerning_unicorn_bamstats
doc: "Compute per bam statistics.\n\nTool homepage: https://github.com/GeoGenetics/unicorn"
inputs:
  - id: bam
    type: File
    doc: "Input BAM or SAM file"
    inputBinding:
      position: 101
      prefix: -b
      valueFrom: $(self.basename)
  - id: outstat
    type:
      - 'null'
      - string
    doc: "Output statistics file"
    inputBinding:
      position: 101
      prefix: --outstat
  - id: filelist
    type:
      - 'null'
      - File
    doc: "File containing input file paths. One per line."
    inputBinding:
      position: 101
      prefix: --filelist
  - id: printdists
    type:
      - 'null'
      - boolean
    doc: "Print distributions of read lengths, alignment lengths, etc. This will create a file <inputname>.dists.txt"
    inputBinding:
      position: 101
      prefix: --printdists
outputs:
  - id: stdout
    type: stdout
    doc: "Per BAM statistics (when --outstat is not given)"
  - id: out_stat
    type:
      - 'null'
      - File
    doc: Output statistics file
    outputBinding:
      glob: $(inputs.outstat)
  - id: dists
    type:
      - 'null'
      - type: array
        items: File
    doc: Distributions of read lengths, alignment lengths, etc. (--printdists)
    outputBinding:
      glob: '*.dist*.txt'
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.bam)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/enhjoerning:2.4.0--h577a1d6_0
stdout: enhjoerning_unicorn_bamstats.out
