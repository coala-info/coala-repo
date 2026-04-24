cwlVersion: v1.2
class: CommandLineTool
baseCommand: mace.py
label: mace_mace.py
doc: "Model based Analysis of ChIP Exo\n\nTool homepage: http://chipexo.sourceforge.net"
inputs:
  - id: chromsize
    type:
      - 'null'
      - File
    doc: 'Chromosome size file. Tab or space separated text file with 2 columns: first
      column contains chromosome name, second column contains chromosome size. Example:chr1
      249250621 <NewLine> chr2        243199373 <NewLine> chr3        198022430 <NewLine>
      ...'
    inputBinding:
      position: 101
      prefix: --chromSize
  - id: forward_bw
    type:
      - 'null'
      - File
    doc: BigWig format file containing coverage calcualted from reads mapped to 
      *forward* strand.
    inputBinding:
      position: 101
      prefix: --forward
  - id: fuzzy_size
    type:
      - 'null'
      - int
    doc: Peaks located closely within this window will be merged. (bp)
    inputBinding:
      position: 101
      prefix: --fz-window
  - id: max_distance
    type:
      - 'null'
      - int
    doc: Maximum distance allowed for border pairing.
    inputBinding:
      position: 101
      prefix: --max-dist
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: "Prefix of output files. NOTE: if 'prefix.border.bed' exists and was non-empty,
      peak calling step will be skipped! So if you want to rerun mace.py from scratch,
      use different 'prefix' or delete old 'prefix.border.bed' before starting."
    inputBinding:
      position: 101
      prefix: --out-prefix
  - id: pvalue_cutoff
    type:
      - 'null'
      - float
    doc: Pvalue cutoff for border detection and subsequent border pairing.
    inputBinding:
      position: 101
      prefix: --pvalue
  - id: reverse_bw
    type:
      - 'null'
      - File
    doc: BigWig format file containing coverage calcualted from reads mapped to 
      *reverse* strand.
    inputBinding:
      position: 101
      prefix: --reverse
  - id: signal_fold
    type:
      - 'null'
      - float
    doc: Minmum coverage signal used to build model (i.e. estimate optimal peak 
      pair size).
    inputBinding:
      position: 101
      prefix: --fold
  - id: window_size
    type:
      - 'null'
      - int
    doc: Background window size used to determine background signal level. (bp)
    inputBinding:
      position: 101
      prefix: --bg-window
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mace:1.2--py27h99da42f_0
stdout: mace_mace.py.out
