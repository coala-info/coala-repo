cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bwa
  - shm
label: bwa_shm
doc: "Manage BWA indices in shared memory. Shared memory belongs to the container, so an index loaded here is gone when the tool exits.\n\nTool homepage: https://github.com/lh3/bwa"
inputs:
  - id: idxbase
    type:
      - 'null'
      - File
    doc: The bwa index to load into shared memory, given as its .bwt file (for example ref.fa.bwt from bwa_index) or
      as the file named like the index prefix (for example ref.fa); the .amb, .ann,
      .bwt, .pac and .sa files must sit beside it
    secondaryFiles:
      - pattern: "${ var b = self.basename.replace(/\\.bwt$/, ''); var s = ['.amb', '.ann', '.pac', '.sa']; if (b === self.basename) { s.push('.bwt'); } return s.map(function (e) { return b + e; }); }"
        required: true
    inputBinding:
      position: 201
      valueFrom: $(self.path.replace(/\.bwt$/, ''))
  - id: destroy
    type:
      - 'null'
      - boolean
    doc: destroy all indices in shared memory
    inputBinding:
      position: 102
      prefix: -d
  - id: list
    type:
      - 'null'
      - boolean
    doc: list names of indices in shared memory
    inputBinding:
      position: 102
      prefix: -l
  - id: tmp_file
    type:
      - 'null'
      - string
    doc: Name of a temporary file to reduce peak memory; any directory part is dropped
    inputBinding:
      position: 102
      prefix: -f
      valueFrom: $(self.split('/').pop())
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bwa:0.7.19--h577a1d6_1
stdout: bwa_shm.out
