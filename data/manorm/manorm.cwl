cwlVersion: v1.2
class: CommandLineTool
baseCommand: manorm
label: manorm
doc: "MAnorm -- A robust model for quantitative comparison of ChIP-seq data sets\n\
  \nTool homepage: https://github.com/shao-lab/MAnorm"
inputs:
  - id: m_cutoff
    type:
      - 'null'
      - float
    doc: Absolute M-value (log2-ratio) cutoff to define the biased (differential
      binding) peaks.
    default: 1.0
    inputBinding:
      position: 101
      prefix: --m-cutoff
  - id: n_random
    type:
      - 'null'
      - int
    doc: Number of random simulations to test the enrichment of peak overlap 
      between the specified samples. Set to 0 to disable the testing.
    default: 0
    inputBinding:
      position: 101
      prefix: --n-random
  - id: name1
    type:
      - 'null'
      - string
    doc: Name of sample 1. If not specified, the peak file name will be used.
    inputBinding:
      position: 101
      prefix: --name1
  - id: name2
    type:
      - 'null'
      - string
    doc: Name of sample 2. If not specified, the peak file name will be used.
    inputBinding:
      position: 101
      prefix: --name2
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Output directory.
    default: Current working directory
    inputBinding:
      position: 101
      prefix: --output-dir
  - id: p_cutoff
    type:
      - 'null'
      - float
    doc: P-value cutoff to define the biased peaks.
    default: 0.01
    inputBinding:
      position: 101
      prefix: --p-cutoff
  - id: paired_end
    type:
      - 'null'
      - boolean
    doc: Paired-end mode. The middle point of each read pair is used to 
      represent the genomic locus of the DNA fragment. If specified, `--s1` and 
      `--s2` will be ignored.
    inputBinding:
      position: 101
      prefix: --pe
  - id: peak1
    type: File
    doc: Peak file of sample 1.
    inputBinding:
      position: 101
      prefix: --peak1
  - id: peak2
    type: File
    doc: Peak file of sample 2.
    inputBinding:
      position: 101
      prefix: --peak2
  - id: peak_format
    type:
      - 'null'
      - string
    doc: Format of the peak files. Support ['bed', 'bed3-summit', 'macs', 
      'macs2', 'narrowpeak', 'broadpeak'].
    default: bed
    inputBinding:
      position: 101
      prefix: --peak-format
  - id: read1
    type: File
    doc: Read file of sample 1.
    inputBinding:
      position: 101
      prefix: --read1
  - id: read2
    type: File
    doc: Read file of sample 2.
    inputBinding:
      position: 101
      prefix: --read2
  - id: read_format
    type:
      - 'null'
      - string
    doc: Format of the read files. Support ['bed', 'bedpe', 'sam', 'bam'].
    default: bed
    inputBinding:
      position: 101
      prefix: --read-format
  - id: shiftsize1
    type:
      - 'null'
      - int
    doc: Single-end reads shift size for sample 1. Reads are shifted by `N` bp 
      towards 3' direction and the 5' end of each shifted read is used to 
      represent the genomic locus of the DNA fragment. Set to 0.5 * fragment 
      size of the ChIP-seq library.
    default: 100
    inputBinding:
      position: 101
      prefix: --shiftsize1
  - id: shiftsize2
    type:
      - 'null'
      - int
    doc: Single-end reads shift size for sample 2.
    default: 100
    inputBinding:
      position: 101
      prefix: --shiftsize2
  - id: summit_distance
    type:
      - 'null'
      - string
    doc: 'Summit-to-summit distance cutoff for overlapping common peaks. Common peaks
      with summit distance beyond the cutoff are excluded in model fitting. Default:
      `window size` / 4'
    inputBinding:
      position: 101
      prefix: --summit-dis
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose log messages.
    inputBinding:
      position: 101
      prefix: --verbose
  - id: window_size
    type:
      - 'null'
      - int
    doc: Window size to count reads and calculate read densities. Set to 2000 is
      recommended for sharp histone marks like H3K4me3 or H3K27ac and 1000 for 
      TFs or DNase-seq.
    default: 2000
    inputBinding:
      position: 101
      prefix: --window-size
  - id: write_all
    type:
      - 'null'
      - boolean
    doc: Write two extra output files containing the results of the original 
      (unmerged) peaks.
    inputBinding:
      position: 101
      prefix: --wa
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/manorm:1.3.0--py_0
stdout: manorm.out
