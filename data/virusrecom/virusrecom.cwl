cwlVersion: v1.2
class: CommandLineTool
baseCommand: virusrecom
label: virusrecom
doc: "Detecting recombination of viral lineages (or subtypes) using information theory.\n\
  \nTool homepage: https://github.com/ZhijianZhou01/virusrecom"
inputs:
  - id: align_tool
    type:
      - 'null'
      - string
    doc: Program used for multiple sequence alignments (MSA). Supporting mafft, 
      muscle and clustalo, such as ‘-at mafft’.
    inputBinding:
      position: 101
      prefix: -at
  - id: alignment
    type:
      - 'null'
      - File
    doc: Aligned sequence file (*.fasta). Note, each sequence name requires 
      containing lineage mark.
    inputBinding:
      position: 101
      prefix: -a
  - id: block_size
    type:
      - 'null'
      - int
    doc: 'Specifies the maximum number of sites per sub-block, different sub-blocks
      in sequence file will be sequentially loaded to calculate WIC. Default: 40000
      sites.'
    inputBinding:
      position: 101
      prefix: --block
  - id: breakpoint
    type:
      - 'null'
      - boolean
    doc: 'Possible breakpoint scan of recombination. ‘-b y’ means yes, ‘-b n’ means
      no. Note: this option only takes effect when ‘-m p’ has been specified.'
    inputBinding:
      position: 101
      prefix: -b
  - id: breakwin
    type:
      - 'null'
      - int
    doc: 'The window size (default: 200) used for breakpoint scan, and step size is
      fixed at 1.'
    inputBinding:
      position: 101
      prefix: -bw
  - id: cumulative
    type:
      - 'null'
      - boolean
    doc: Simply using the max cumulative WIC of all sites to identify the major 
      parent. Off by default. If required, specify ‘-cu y’.
    inputBinding:
      position: 101
      prefix: -cu
  - id: engrave
    type:
      - 'null'
      - Directory
    doc: Write the file name to sequence names in batches. By specifying a 
      directory containing one or multiple sequence files (*.fasta).
    inputBinding:
      position: 101
      prefix: -e
  - id: export_name
    type:
      - 'null'
      - string
    doc: Export all sequence name of a *.fasta file.
    inputBinding:
      position: 101
      prefix: -en
  - id: gap
    type:
      - 'null'
      - string
    doc: Reserve sites containing gaps(-) in analyses? ‘-g y’ means to reserve, 
      and ‘-g n’ means to delete.
    inputBinding:
      position: 101
      prefix: -g
  - id: input_wic
    type:
      - 'null'
      - File
    doc: Using the already obtained WIC values of reference lineages directly by
      a *.csv input-file.
    inputBinding:
      position: 101
      prefix: -iwic
  - id: legend
    type:
      - 'null'
      - string
    doc: The location of the legend, the default is adaptive. '-le r' indicates 
      placed on the right.
    inputBinding:
      position: 101
      prefix: -le
  - id: mapping
    type:
      - 'null'
      - File
    doc: The table of sequence-to-lineage mapping.
    inputBinding:
      position: 101
      prefix: -map
  - id: max_region
    type:
      - 'null'
      - int
    doc: 'The maximum allowed recombination region. Note: if the ‘-m p’ method has
      been used, it refers the maximum number of polymorphic sites contained in a
      recombinant region.'
    inputBinding:
      position: 101
      prefix: -mr
  - id: method
    type:
      - 'null'
      - string
    doc: Method for site scanning. ‘-m p’ uses polymorphic sites only, ‘-m a’ 
      uses all the sites.
    inputBinding:
      position: 101
      prefix: -m
  - id: no_mwic_fig
    type:
      - 'null'
      - boolean
    doc: Do not draw the image of mWICs.
    inputBinding:
      position: 101
      prefix: --no_mwic_fig
  - id: no_wic_fig
    type:
      - 'null'
      - boolean
    doc: Do not draw the image of WICs.
    inputBinding:
      position: 101
      prefix: --no_wic_fig
  - id: only_wic
    type:
      - 'null'
      - boolean
    doc: Only calculate site WIC value. Off by default. If required, please 
      specify ‘-owic y’.
    inputBinding:
      position: 101
      prefix: -owic
  - id: percentage
    type:
      - 'null'
      - float
    doc: 'The cutoff threshold of proportion (cp, default: 0.9) used for searching
      recombination regions when mWIC/EIC >= cp, the maximum value of cp is 1.'
    inputBinding:
      position: 101
      prefix: -cp
  - id: query
    type:
      - 'null'
      - string
    doc: Name of query lineage (usually potential recombinant), such as ‘-q 
      xxxx’. Besides, ‘-q auto’ can scan all lineages as potential recombinant 
      in turn.
    inputBinding:
      position: 101
      prefix: -q
  - id: step
    type:
      - 'null'
      - int
    doc: 'Step size of the sliding window. Note: if the ‘-m p’ has been used, -s refers
      to the number of polymorphic sites per jump.'
    inputBinding:
      position: 101
      prefix: -s
  - id: thread
    type:
      - 'null'
      - int
    doc: 'Number of threads (or cores) for calculations, default: 4.'
    inputBinding:
      position: 101
      prefix: -t
  - id: unalignment
    type:
      - 'null'
      - File
    doc: Unaligned (non-alignment) sequence file (*.fasta). Note, each sequence 
      name requires containing lineage mark.
    inputBinding:
      position: 101
      prefix: -ua
  - id: window
    type:
      - 'null'
      - int
    doc: 'Number of nucleotides sites per sliding window. Note: if the ‘-m p’ has
      been used, -w refers to the number of polymorphic sites per windows.'
    inputBinding:
      position: 101
      prefix: -w
  - id: y_start
    type:
      - 'null'
      - float
    doc: 'Starting value (default: 0) of the Y-axis in plot diagram.'
    inputBinding:
      position: 101
      prefix: -y
outputs:
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Output directory to store all results.
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/virusrecom:1.4.0--pyhdfd78af_0
