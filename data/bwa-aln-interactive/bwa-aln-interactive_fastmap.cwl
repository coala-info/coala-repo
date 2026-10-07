cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bwa-aln-interactive
  - fastmap
label: bwa-aln-interactive_fastmap
doc: "Fastmap identifies Super Maximal Exact Matches (SMEMs) in sequences using a
  BWA index.\n\nTool homepage: https://github.com/fulcrumgenomics/bwa-aln-interactive"
inputs:
  - id: idxbase
    type: File
    doc: The bwa index, given as its .bwt file (for example ref.fa.bwt from bwa index) or
      as the file named like the index prefix (for example ref.fa); the .amb, .ann,
      .bwt, .pac and .sa files must sit beside it
    secondaryFiles:
      - pattern: "${ var b = self.basename.replace(/\\.bwt$/, ''); var s = ['.amb', '.ann', '.pac', '.sa']; if (b === self.basename) { s.push('.bwt'); } return s.map(function (e) { return b + e; }); }"
        required: true
    inputBinding:
      position: 1
      valueFrom: $(self.path.replace(/\.bwt$/, ''))
  - id: in_fq
    type: File
    doc: Input fastq file
    inputBinding:
      position: 2
  - id: max_interval_size
    type:
      - 'null'
      - int
    doc: max interval size to find coordiantes
    inputBinding:
      position: 103
      prefix: -w
  - id: max_mem_length
    type:
      - 'null'
      - int
    doc: max MEM length
    inputBinding:
      position: 103
      prefix: -L
  - id: min_smem_interval
    type:
      - 'null'
      - int
    doc: min SMEM interval size
    inputBinding:
      position: 103
      prefix: -i
  - id: min_smem_length
    type:
      - 'null'
      - int
    doc: min SMEM length to output
    inputBinding:
      position: 103
      prefix: -l
  - id: stop_mem_threshold
    type:
      - 'null'
      - int
    doc: stop if MEM is longer than -l with a size less than INT
    inputBinding:
      position: 103
      prefix: -I
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bwa-aln-interactive:0.7.18--h577a1d6_2
stdout: bwa-aln-interactive_fastmap.out
