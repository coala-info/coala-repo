cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - grafimo
  - findmotif
label: grafimo_findmotif
doc: "Scan genome variation graphs (VG/XG format) for occurrences of DNA motifs given
  as position weight matrices (MEME or JASPAR format) in the genomic regions of a BED
  file. Results are a TSV report, an HTML report and a GFF3 file.\n\nTool homepage:
  https://github.com/pinellolab/GRAFIMO"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.outdir)
        entry: '$({"class": "Directory", "listing": []})'
        writable: true
inputs:
  - id: genome_graph
    type:
      - 'null'
      - File
    doc: Path to VG pangenome variation graph (VG or XG format).
    inputBinding:
      position: 102
      prefix: --genome-graph
  - id: genome_graph_dir
    type:
      - 'null'
      - Directory
    doc: Path to the directory containing the pangenome variation graphs to scan
      (VG or XG format)
    inputBinding:
      position: 102
      prefix: --genome-graph-dir
  - id: bedfile
    type: File
    doc: BED file containing the genomic regions to scan for occurrences of the input
      motif(s).
    inputBinding:
      position: 102
      prefix: --bedfile
  - id: motif
    type:
      type: array
      items: File
    doc: Motif Position Weight Matrix (MEME or JASPAR format).
    inputBinding:
      position: 102
      prefix: --motif
  - id: bgfile
    type:
      - 'null'
      - File
    doc: Background distribution file.
    inputBinding:
      position: 102
      prefix: --bgfile
  - id: pseudo
    type:
      - 'null'
      - float
    doc: Pseudocount value used during motif PWM processing.
    inputBinding:
      position: 102
      prefix: --pseudo
  - id: threshold
    type:
      - 'null'
      - float
    doc: 'Statistical significance threshold value. By default the threshold is applied
      on P-values. To apply the threshold on q-values use the "--qvalueT" options.
      Default: 0.0001.'
    inputBinding:
      position: 102
      prefix: --threshold
  - id: no_qvalue
    type:
      - 'null'
      - boolean
    doc: If used, GRAFIMO skips q-value computation.
    inputBinding:
      position: 102
      prefix: --no-qvalue
  - id: no_reverse
    type:
      - 'null'
      - boolean
    doc: If used, GRAFIMO scans only the forward strand.
    inputBinding:
      position: 102
      prefix: --no-reverse
  - id: text_only
    type:
      - 'null'
      - boolean
    doc: Print results to stdout.
    inputBinding:
      position: 102
      prefix: --text-only
  - id: chroms_find
    type:
      - 'null'
      - type: array
        items: string
    doc: Scan only the specified chromosomes.
    inputBinding:
      position: 102
      prefix: --chroms-find
  - id: chroms_prefix_find
    type:
      - 'null'
      - string
    doc: 'Prefix shared by all chromosomes. The prefix should be followed by the chromosome
      number. If chromosome VGs are stored only with their chromosome number (e.g.
      1.xg) use an empty string. Default: chr.'
    inputBinding:
      position: 102
      prefix: --chroms-prefix-find
  - id: chroms_namemap_find
    type:
      - 'null'
      - File
    doc: Space or tab-separated file, containing original chromosome names in the first
      columns and the names used to store the corresponding VGs. By default GRAFIMO
      assumes that VGs are named after the encoded chromosome (e.g. chr1.xg).
    inputBinding:
      position: 102
      prefix: --chroms-namemap-find
  - id: recomb
    type:
      - 'null'
      - boolean
    doc: Consider all the possible recombinants sequences which could be obtained from
      the genetic variants encoded in the VG. With this option the haplotypes encoded
      in the VG are ignored.
    inputBinding:
      position: 102
      prefix: --recomb
  - id: qvalue_t
    type:
      - 'null'
      - boolean
    doc: Apply motif occurrence score statistical significance threshold on q-values
      rather than on P-values.
    inputBinding:
      position: 102
      prefix: --qvalueT
  - id: top_graphs
    type:
      - 'null'
      - int
    doc: Store the PNG image of the top "GRAPHS-NUM" regions of the VG (motif occurrences
      sorted by increasing P-value).
    inputBinding:
      position: 102
      prefix: --top-graphs
  - id: outdir
    type: string
    default: grafimo_out
    doc: Output directory.
    inputBinding:
      position: 102
      prefix: --out
  - id: cores
    type:
      - 'null'
      - int
    doc: 'Number of CPU cores to use. Use 0 to auto-detect. Default: 0. To search motifs
      in a whole genome variation graph the default is 1 (avoid memory issues).'
    inputBinding:
      position: 102
      prefix: --cores
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print additional information about GRAFIMO run.
    inputBinding:
      position: 102
      prefix: --verbose
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Enable error traceback.
    inputBinding:
      position: 102
      prefix: --debug
outputs:
  - id: outdir_dir
    type: Directory
    doc: Directory with the TSV report, HTML report and GFF3 file
    outputBinding:
      glob: $(inputs.outdir)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/grafimo:1.1.6--py310h79ef01b_0
stdout: grafimo_findmotif.out
