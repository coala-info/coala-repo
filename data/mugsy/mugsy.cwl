cwlVersion: v1.2
class: CommandLineTool
baseCommand: mugsy
label: mugsy
doc: "a multiple whole genome aligner\n\nTool homepage: https://github.com/margyle/MugsyDev"
inputs:
  - id: input_genomes
    type:
      type: array
      items: File
    doc: Input is one or more (multi)FASTA files, one per genome. Each file 
      should contain all the sequences for a single organism/species. The 
      filename is used as the genome name.
    inputBinding:
      position: 1
  - id: allow_nested_lcbs
    type:
      - 'null'
      - boolean
    doc: Places each multi-genome anchor in exactly one LCB; the longest 
      spanning LCB
    default: false
    inputBinding:
      position: 102
      prefix: --allownestedlcbs
  - id: debug_level
    type:
      - 'null'
      - int
    doc: debug level. > 2 verbose
    inputBinding:
      position: 102
      prefix: --debug
  - id: detect_duplications
    type:
      - 'null'
      - int
    doc: Detect and report duplications. 0 - Skip.
    default: 0
    inputBinding:
      position: 102
      prefix: -duplications
  - id: full_pairwise_nucmer_search
    type:
      - 'null'
      - boolean
    doc: Run a complete all pairs Nucmer search with each sequence as a 
      reference and query (n^2-1 total searches). Default is one direction only 
      (n^2-1/2 searches).
    inputBinding:
      position: 102
      prefix: --fullsearch
  - id: max_distance_for_chaining
    type:
      - 'null'
      - int
    doc: maximum distance along a single sequence (bp) for chaining anchors into
      locally colinear blocks (LCBs). This is used by the segmentation step 
      synchain-mugsy.
    default: 1000
    inputBinding:
      position: 102
      prefix: --distance
  - id: min_span_aligned_region
    type:
      - 'null'
      - int
    doc: minimum span of an aligned region in a colinear block (bp). This is 
      used by the segmentation step synchain-mugsy.
    default: 30
    inputBinding:
      position: 102
      prefix: --minlength
  - id: nucmer_options
    type:
      - 'null'
      - string
    doc: options passed through to the Nucmer package. Eg. -nucmeropts "-l 15" 
      sets the minimum MUM length in NUCmer to 15. See the Nucmer documentation 
      at http://mummer.sf.net for more information.
    default: -l 15
    inputBinding:
      position: 102
      prefix: -nucmeropts
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: directory used to store output and temporary files. Must be a absolute 
      path
    inputBinding:
      position: 102
      prefix: --directory
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: prefix for output files
    inputBinding:
      position: 102
      prefix: -p
  - id: plot_genome_dot_plots
    type:
      - 'null'
      - boolean
    doc: output genome dot plots in GNUplot format. Overlays LCBS onto pairwise 
      plots from mummerplot. Display of draft genomes in these plots is not 
      supported.
    inputBinding:
      position: 102
      prefix: --plot
  - id: refine_alignment
    type:
      - 'null'
      - string
    doc: 'run an second iteration of Mugsy on each LCB to refine the alignment using
      either Mugsy (--refine mugsy), FSA (--refine fsa), Pecan (--refine pecan), MLAGAN
      (--refine mlagan). Requires necessary tools are in your path: fsa: fsa pecan:
      muscle,exonerate, in the path. classpath set for bp.pecan.Pecan. mlagan: mlagan.sh'
    inputBinding:
      position: 102
      prefix: --refine
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mugsy:1.2.3--hdfd78af_4
stdout: mugsy.out
