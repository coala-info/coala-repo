cwlVersion: v1.2
class: CommandLineTool
baseCommand: HiLine
label: hiline_index-only
doc: "Create and save the alignment index of a reference genome only. HiLine is a
  chained command line: this wrapper runs `params` followed by `index-only`.\n\nTool
  homepage: https://github.com/wtsi-hpag/HiLine"
inputs:
  - id: reference
    type: File
    doc: Reference genome in (gzipped) FASTA format. It is staged in the working
      directory because HiLine writes the index beside it.
  - id: restriction_sites
    type: string
    doc: Restriction site specification, a comma-separated list of HiC kit names
      (Omni-C, Arima_v2, Arima, Dovetail, Phase, Qiagen), restriction enzyme
      names (for example DpnII, DNASE) or IUPAC site strings (for example ^GATC)
    inputBinding:
      position: 4
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use, must be at least 3. Default=4
    inputBinding:
      position: 2
      prefix: -t
  - id: minmapq
    type:
      - 'null'
      - int
    doc: Minimum mapping quality. Default=10
    inputBinding:
      position: 2
      prefix: -q
  - id: trim
    type:
      - 'null'
      - boolean
    doc: Run HiC read trimming, trim sections of reads that align past restriction
      sites. Default=trim
    inputBinding:
      position: 6
      prefix: --trim
  - id: no_trim
    type:
      - 'null'
      - boolean
    doc: Do not run HiC read trimming
    inputBinding:
      position: 6
      prefix: --no-trim
  - id: bwa1
    type:
      - 'null'
      - boolean
    doc: Use bwa mem. Default=False
    inputBinding:
      position: 6
      prefix: --bwa1
  - id: bwa2
    type:
      - 'null'
      - boolean
    doc: Use bwa-mem2. Default=True
    inputBinding:
      position: 6
      prefix: --bwa2
  - id: minimap2
    type:
      - 'null'
      - boolean
    doc: Use minimap2. Default=False
    inputBinding:
      position: 6
      prefix: --minimap2
outputs:
  - id: index_files
    type:
      type: array
      items: File
    doc: Alignment index files written beside the reference
    outputBinding:
      glob:
        - $(inputs.reference.basename).bwa*
        - $(inputs.reference.basename).mm*
        - $(inputs.reference.basename).minimap2*
  - id: reference_index_dir
    type:
      - 'null'
      - Directory
    doc: HiLine reference directory holding the digested fragment reference
    outputBinding:
      glob: '*.HiLine_Reference'
  - id: stdout
    type: stdout
    doc: Standard output
arguments:
  - position: 1
    valueFrom: params
  - position: 3
    valueFrom: $(inputs.reference.basename)
  - position: 5
    valueFrom: index-only
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.reference)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hiline:0.2.4--py39h8aee962_0
stdout: hiline_index-only.out
