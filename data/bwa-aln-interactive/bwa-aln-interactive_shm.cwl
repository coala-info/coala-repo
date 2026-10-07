cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bwa-aln-interactive
  - shm
label: bwa-aln-interactive_shm
doc: "Manage BWA indices in shared memory\n\nTool homepage: https://github.com/fulcrumgenomics/bwa-aln-interactive"
inputs:
  - id: idxbase
    type:
      - 'null'
      - File
    doc: The bwa index to load, given as its .bwt file (for example ref.fa.bwt from bwa
      index) or as the file named like the index prefix (for example ref.fa); the .amb,
      .ann, .bwt, .pac and .sa files must sit beside it
    secondaryFiles:
      - pattern: "${ var b = self.basename.replace(/\\.bwt$/, ''); var s = ['.amb', '.ann', '.pac', '.sa']; if (b === self.basename) { s.push('.bwt'); } return s.map(function (e) { return b + e; }); }"
        required: true
    inputBinding:
      position: 1
      valueFrom: $(self.path.replace(/\.bwt$/, ''))
  - id: destroy_indices
    type:
      - 'null'
      - boolean
    doc: destroy all indices in shared memory
    inputBinding:
      position: 102
      prefix: -d
  - id: list_indices
    type:
      - 'null'
      - boolean
    doc: list names of indices in shared memory
    inputBinding:
      position: 102
      prefix: -l
  - id: temp_file
    type:
      - 'null'
      - string
    doc: temporary file to reduce peak memory
    inputBinding:
      position: 102
      prefix: -f
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bwa-aln-interactive:0.7.18--h577a1d6_2
stdout: bwa-aln-interactive_shm.out
