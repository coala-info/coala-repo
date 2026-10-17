cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pyani
  - index
label: pyani_index
doc: "Index a directory of genome FASTA files: write labels, classes and checksum files.\n\nTool homepage: https://github.com/widdowquinn/pyani"
inputs:
  - id: indir
    type: Directory
    doc: "input directory (a writable copy is used; labels, classes and md5 files are written into it)"
    inputBinding:
      position: 1
      prefix: -i
      valueFrom: $(self.basename)
  - id: logfile
    type:
      - 'null'
      - string
    doc: "logfile location"
    inputBinding:
      position: 10
      prefix: -l
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "report verbose progress to log"
    inputBinding:
      position: 10
      prefix: -v
  - id: debug
    type:
      - 'null'
      - boolean
    doc: "report debug messages to log"
    inputBinding:
      position: 10
      prefix: --debug
  - id: disable_tqdm
    type:
      - 'null'
      - boolean
    doc: "Turn off tqdm progress bar"
    inputBinding:
      position: 10
      prefix: --disable_tqdm
  - id: labelfname
    type:
      - 'null'
      - string
    doc: "Filename for labels file (default: labels.txt)"
    inputBinding:
      position: 10
      prefix: --labels
  - id: classfname
    type:
      - 'null'
      - string
    doc: "Filename for classes file (default: classes.txt)"
    inputBinding:
      position: 10
      prefix: --classes
outputs:
  - id: indexed_dir
    type: Directory
    doc: Input directory with the labels, classes and checksum files added
    outputBinding:
      glob: $(inputs.indir.basename)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.indir)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyani:0.2.13.1--pyhdc42f0e_0
