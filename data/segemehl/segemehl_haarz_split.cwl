cwlVersion: v1.2
class: CommandLineTool
baseCommand: [haarz, split]
label: segemehl_haarz_split
doc: "haarz split: summarize and annotate segemehl split info\n\nTool homepage: http://www.bioinf.uni-leipzig.de/Software/segemehl/"
inputs:
  - id: files
    type:
      type: array
      items: File
    doc: "List of path/filename(s) of bed files with split info"
    inputBinding:
      position: 1
      prefix: --files
  - id: minsplit
    type: ['null', int]
    doc: "Minimum total split number (all samples) of junction (default 5)"
    inputBinding:
      position: 1
      prefix: --minsplit
  - id: minqual
    type: ['null', float]
    doc: "Minimum median quality of junction (default 25)"
    inputBinding:
      position: 1
      prefix: --minqual
  - id: annotationfiles
    type:
      - 'null'
      - type: array
        items: File
    doc: "List of path/filename(s) of GFF file(s)"
    inputBinding:
      position: 1
      prefix: --annotationfiles
  - id: ovlmode
    type: ['null', string]
    doc: "Annotation mode LARGEST, SMALLEST or ALL"
    inputBinding:
      position: 1
      prefix: --ovlmode
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
outputs:
  - id: stdout
    type: stdout
    doc: Standard output (SAM when no output file is given)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/segemehl:v0.3.4-1-deb_cv1
stdout: segemehl_haarz_split.out
