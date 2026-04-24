cwlVersion: v1.2
class: CommandLineTool
baseCommand: grafimo
label: grafimo_buildvg
doc: "GRAph-based Find of Individual Motif Occurrences. GRAFIMO scans genome variation
  graphs in VG format (Garrison et al., 2018) to find potential binding site occurrences
  of DNA motif(s).\n\nTool homepage: https://github.com/pinellolab/GRAFIMO"
inputs:
  - id: workflow
    type: string
    doc: 'Mandatory argument placed immediately after "grafimo". Only two values are
      accepted: "buildvg" and "findmotif". When called "grafimo buildvg", the software
      will compute the genome variation graph from input data (see "buildvg options"
      section below for more arguments). When called "grafimo findmotif", the software
      will scan the input VG(s) for potential occurrences of the input motif(s) (see
      "findmotif option" section below for more arguments).'
    inputBinding:
      position: 1
  - id: bedfile
    type:
      - 'null'
      - File
    doc: BED file containing the genomic regions to scan for occurrences of the 
      input motif(s).
    inputBinding:
      position: 102
      prefix: --bedfile
  - id: bgfile
    type:
      - 'null'
      - File
    doc: Background distribution file.
    inputBinding:
      position: 102
      prefix: --bgfile
  - id: chroms_build
    type:
      - 'null'
      - type: array
        items: string
    doc: Chromosomes for which construct the VG. By default GRAFIMO constructs 
      the VG for all chromsomes.
    inputBinding:
      position: 102
      prefix: --chroms-build
  - id: chroms_find
    type:
      - 'null'
      - type: array
        items: string
    doc: Scan only the specified chromosomes.
    inputBinding:
      position: 102
      prefix: --chroms-find
  - id: chroms_namemap_build
    type:
      - 'null'
      - File
    doc: Space or tab-separated file, containing original chromosome names in 
      the first columns and the names to use when storing corresponding VGs. By 
      default the VGs are named after the encoded chromosome (e.g. chr1.xg).
    inputBinding:
      position: 102
      prefix: --chroms-namemap-build
  - id: chroms_namemap_find
    type:
      - 'null'
      - File
    doc: Space or tab-separated file, containing original chromosome names in 
      the first columns and the names used to store the corresponding VGs. By 
      default GRAFIMO assumes that VGs are named after the encoded chromosome 
      (e.g. chr1.xg).
    inputBinding:
      position: 102
      prefix: --chroms-namemap-find
  - id: chroms_prefix_build
    type:
      - 'null'
      - string
    doc: 'Prefix to append in front of chromosome numbers. To name chromosome VGs
      with only their number (e.g. 1.xg), use "--chroms-prefix-build " ". Default:
      .'
    inputBinding:
      position: 102
      prefix: --chroms-prefix-build
  - id: chroms_prefix_find
    type:
      - 'null'
      - string
    doc: 'Prefix shared by all chromosomes. The prefix should be followed by the chromosome
      number. If chromosome VGs are stored only with their chromosome number (e.g.
      1.xg) use "--chroms-prefix-find" ". Default: .'
    inputBinding:
      position: 102
      prefix: --chroms-prefix-find
  - id: cores
    type:
      - 'null'
      - int
    doc: 'Number of CPU cores to use. Use 0 to auto-detect. Default: 0. To search
      motifs in a whole genome variation graph the default is 1 (avoid memory issues).'
    inputBinding:
      position: 102
      prefix: --cores
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Enable error traceback.
    inputBinding:
      position: 102
      prefix: --debug
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
  - id: motif
    type:
      - 'null'
      - type: array
        items: File
    doc: Motif Position Weight Matrix (MEME or JASPAR format).
    inputBinding:
      position: 102
      prefix: --motif
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
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Output directory.
    inputBinding:
      position: 102
      prefix: --out
  - id: pseudo
    type:
      - 'null'
      - float
    doc: Pseudocount value used during motif PWM processing.
    inputBinding:
      position: 102
      prefix: --pseudo
  - id: qvalueT
    type:
      - 'null'
      - boolean
    doc: Apply motif occurrence score statistical significance threshold on 
      q-values rather than on P-values.
    inputBinding:
      position: 102
      prefix: --qvalueT
  - id: recomb
    type:
      - 'null'
      - boolean
    doc: Consider all the possible recombinants sequences which could be 
      obtained from the genetic variants encoded in the VG. With this option the
      haplotypes encoded in the VG are ignored.
    inputBinding:
      position: 102
      prefix: --recomb
  - id: reference_genome
    type:
      - 'null'
      - File
    doc: Path to reference genome FASTA file.
    inputBinding:
      position: 102
      prefix: --linear-genome
  - id: reindex_build
    type:
      - 'null'
      - boolean
    doc: Reindex the VCF file with Tabix, even if a TBI index os already 
      available.
    inputBinding:
      position: 102
      prefix: --reindex
  - id: text_only
    type:
      - 'null'
      - boolean
    doc: Print results to stdout.
    inputBinding:
      position: 102
      prefix: --text-only
  - id: threshold
    type:
      - 'null'
      - float
    doc: Statistical significance threshold value. By default the threshold is 
      applied on P-values. To apply the threshold on q-values use the 
      "--qvalueT" options.
    inputBinding:
      position: 102
      prefix: --threshold
  - id: top_graphs
    type:
      - 'null'
      - int
    doc: Store the PNG image of the top "GRAPHS-NUM" regions of the VG (motif 
      occurrences sorted by increasing P-value).
    inputBinding:
      position: 102
      prefix: --top-graphs
  - id: vcf
    type:
      - 'null'
      - File
    doc: Path to VCF file. Note that the VCF should be compressed (e.g. 
      myvcf.vcf.gz).
    inputBinding:
      position: 102
      prefix: --vcf
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print additional information about GRAFIMO run.
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/grafimo:1.1.6--py310h79ef01b_0
stdout: grafimo_buildvg.out
