cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sysc
  - build_k21
label: symbiontscreener_build_k21
doc: "Build paternal-only, maternal-only and shared k-mer lists from paternal and maternal NGS reads with meryl.\n\nTool homepage: https://github.com/BGI-Qingdao/Symbiont-Screener"
inputs:
  - id: paternal
    type:
      type: array
      items: File
      inputBinding:
        prefix: --paternal
    doc: Paternal NGS reads file (FASTA/FASTQ; gzip allowed if the name ends in .gz). Repeat for several files.
    inputBinding:
      position: 1
  - id: maternal
    type:
      type: array
      items: File
      inputBinding:
        prefix: --maternal
    doc: Maternal NGS reads file (FASTA/FASTQ; gzip allowed if the name ends in .gz). Repeat for several files.
    inputBinding:
      position: 1
  - id: thread
    type: ['null', int]
    doc: Thread number (default 8)
    inputBinding:
      position: 1
      prefix: --thread
  - id: memory
    type: ['null', int]
    doc: Memory in GB used by meryl (default 50)
    inputBinding:
      position: 1
      prefix: --memory
  - id: mer
    type: ['null', int]
    doc: Mer size (default 21)
    inputBinding:
      position: 1
      prefix: --mer
  - id: auto_bounds
    type: ['null', int]
    doc: Set 0 or 1 to calculate lower and upper count bounds from the k-mer analysis (default 1)
    inputBinding:
      position: 1
      prefix: --auto_bounds
  - id: m_lower
    type: ['null', int]
    doc: Maternal k-mer table ignores k-mers with count below this value (default 0)
    inputBinding:
      position: 1
      prefix: --m-lower
  - id: m_upper
    type: ['null', int]
    doc: Maternal k-mer table ignores k-mers with count above this value (default 0)
    inputBinding:
      position: 1
      prefix: --m-upper
  - id: p_lower
    type: ['null', int]
    doc: Paternal k-mer table ignores k-mers with count below this value (default 0)
    inputBinding:
      position: 1
      prefix: --p-lower
  - id: p_upper
    type: ['null', int]
    doc: Paternal k-mer table ignores k-mers with count above this value (default 0)
    inputBinding:
      position: 1
      prefix: --p-upper
outputs:
  - id: step01_k21
    type: Directory
    doc: Build directory step01.k21
    outputBinding:
      glob: step01.k21
  - id: stdout
    type: stdout
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/symbiontscreener:1.0.0--h5ca1c30_2
stdout: symbiontscreener_build_k21.stdout.txt
