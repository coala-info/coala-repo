cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sysc
  - build_s40
label: symbiontscreener_build_s40
doc: "Build randstrobe(2,10,30,30) lists from paternal and maternal NGS reads with jellyfish.\n\nTool homepage: https://github.com/BGI-Qingdao/Symbiont-Screener"
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
  - id: size
    type: ['null', string]
    doc: Initial hash table size for jellyfish (default 1GB)
    inputBinding:
      position: 1
      prefix: --size
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
  - id: step01_s40
    type: Directory
    doc: Build directory step01.s40
    outputBinding:
      glob: step01.s40
  - id: stdout
    type: stdout
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/symbiontscreener:1.0.0--h5ca1c30_2
stdout: symbiontscreener_build_s40.stdout.txt
