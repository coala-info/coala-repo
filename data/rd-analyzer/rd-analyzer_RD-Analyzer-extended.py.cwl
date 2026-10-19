cwlVersion: v1.2
class: CommandLineTool
baseCommand: RD-Analyzer-extended.py
label: rd-analyzer_RD-Analyzer-extended.py
doc: "RD-Analyzer-extended.py\n\nTool homepage: https://github.com/xiaeryu/RD-Analyzer"
inputs:
  - id: ref_fasta
    type: File
    doc: Reference FASTA file
    inputBinding:
      position: 1
  - id: fastq_1
    type: File
    doc: FASTQ file 1
    inputBinding:
      position: 2
  - id: fastq_2
    type:
      - 'null'
      - File
    doc: FASTQ file 2 (optional)
    inputBinding:
      position: 3
  - id: debug
    type:
      - 'null'
      - boolean
    doc: enable debug mode, keeping all intermediate files
    inputBinding:
      position: 104
      prefix: --debug
  - id: outdir
    type:
      - 'null'
      - string
    doc: output directory
    inputBinding:
      position: 104
      prefix: --outdir
  - id: output
    type:
      - 'null'
      - string
    doc: basename of output files
    inputBinding:
      position: 104
      prefix: --output
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: result
    type:
      - 'null'
      - File
    doc: Result table of the analysis (.result)
    outputBinding:
      glob: |
        ${
          var d = inputs.outdir ? inputs.outdir + "/" : "";
          var o = inputs.output ? inputs.output : "RD-Analyzer";
          return d + o + ".result";
        }
  - id: depth
    type:
      - 'null'
      - File
    doc: Per-position read depth over the RD regions (.depth)
    outputBinding:
      glob: |
        ${
          var d = inputs.outdir ? inputs.outdir + "/" : "";
          var o = inputs.output ? inputs.output : "RD-Analyzer";
          return d + o + ".depth";
        }
  - id: sorted_bam
    type:
      - 'null'
      - File
    doc: Sorted alignment, kept only in debug mode (.sort.bam)
    outputBinding:
      glob: |
        ${
          var d = inputs.outdir ? inputs.outdir + "/" : "";
          var o = inputs.output ? inputs.output : "RD-Analyzer";
          return d + o + ".sort.bam";
        }
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.ref_fasta)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rd-analyzer:1.01--hdfd78af_0
stdout: rd-analyzer_RD-Analyzer-extended.py.out
