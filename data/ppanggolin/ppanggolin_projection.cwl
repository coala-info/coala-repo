cwlVersion: v1.2
class: CommandLineTool
baseCommand: ppanggolin projection
label: ppanggolin_projection
doc: "Project pangenome annotations onto input genomes.\n\nTool homepage: https://github.com/labgem/PPanGGOLiN"
inputs:
  - id: add_metadata
    type:
      - 'null'
      - boolean
    doc: Include metadata information in the output files if any have been added
      to pangenome elements (see ppanggolin metadata command).
    inputBinding:
      position: 101
      prefix: --add_metadata
  - id: add_sequences
    type:
      - 'null'
      - boolean
    doc: Include input genome DNA sequences in GFF and Proksee output.
    inputBinding:
      position: 101
      prefix: --add_sequences
  - id: anno
    type: File
    doc: Specify an annotation file in GFF/GBFF format for the genome you wish 
      to annotate. Alternatively, you can provide a tab-separated file listing 
      genome names alongside their respective annotation filepaths, with one 
      line per genome. If both an annotation file and a FASTA file are provided,
      the annotation file will take precedence.
    inputBinding:
      position: 101
      prefix: --anno
  - id: circular_contigs
    type:
      - 'null'
      - type: array
        items: string
    doc: Specify the contigs of the input genome that should be treated as 
      circular when providing a single FASTA or annotation file.
    inputBinding:
      position: 101
      prefix: --circular_contigs
  - id: compress
    type:
      - 'null'
      - boolean
    doc: Compress the files in .gz
    inputBinding:
      position: 101
      prefix: --compress
  - id: config
    type:
      - 'null'
      - File
    doc: Specify command arguments through a YAML configuration file.
    inputBinding:
      position: 101
      prefix: --config
  - id: coverage
    type:
      - 'null'
      - float
    doc: min coverage percentage threshold
    inputBinding:
      position: 101
      prefix: --coverage
  - id: cpu
    type:
      - 'null'
      - int
    doc: Number of available cpus
    inputBinding:
      position: 101
      prefix: --cpu
  - id: disable_prog_bar
    type:
      - 'null'
      - boolean
    doc: disables the progress bars
    inputBinding:
      position: 101
      prefix: --disable_prog_bar
  - id: dup_margin
    type:
      - 'null'
      - float
    doc: minimum ratio of genomes in which the family must have multiple genes 
      for it to be considered 'duplicated'. This metric is used to compute 
      completeness and duplication of the input genomes
    inputBinding:
      position: 101
      prefix: --dup_margin
  - id: fast
    type:
      - 'null'
      - boolean
    doc: Use representative sequences of gene families for input gene alignment.
      This option is faster but may be less sensitive. By default, all pangenome
      genes are used.
    inputBinding:
      position: 101
      prefix: --fast
  - id: fasta
    type: File
    doc: Specify a FASTA file containing the genomic sequences of the genome(s) 
      you wish to annotate, or provide a tab-separated file listing genome names
      alongside their respective FASTA filepaths, with one line per genome.
    inputBinding:
      position: 101
      prefix: --fasta
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force writing in output directory and in pangenome output file.
    inputBinding:
      position: 101
      prefix: --force
  - id: genome_name
    type:
      - 'null'
      - string
    doc: Specify the name of the genome whose genome you want to annotate when 
      providing a single FASTA or annotation file.
    inputBinding:
      position: 101
      prefix: --genome_name
  - id: gff
    type:
      - 'null'
      - boolean
    doc: Generate GFF files with projected pangenome annotations for each input 
      genome.
    inputBinding:
      position: 101
      prefix: --gff
  - id: graph_formats
    type:
      - 'null'
      - type: array
        items: string
    doc: Format of the output graph.
    inputBinding:
      position: 101
      prefix: --graph_formats
  - id: identity
    type:
      - 'null'
      - float
    doc: min identity percentage threshold
    inputBinding:
      position: 101
      prefix: --identity
  - id: keep_tmp
    type:
      - 'null'
      - boolean
    doc: Keeping temporary files (useful for debugging).
    inputBinding:
      position: 101
      prefix: --keep_tmp
  - id: log
    type:
      - 'null'
      - File
    doc: log output file
    inputBinding:
      position: 101
      prefix: --log
  - id: metadata_sep
    type:
      - 'null'
      - string
    doc: The separator used to join multiple metadata values for elements with 
      multiple metadata values from the same source. This character should not 
      appear in metadata values.
    inputBinding:
      position: 101
      prefix: --metadata_sep
  - id: metadata_sources
    type:
      - 'null'
      - type: array
        items: string
    doc: Which source of metadata should be written. By default all metadata 
      sources are included.
    inputBinding:
      position: 101
      prefix: --metadata_sources
  - id: no_defrag
    type:
      - 'null'
      - boolean
    doc: DO NOT Realign gene families to link fragments with their 
      non-fragmented gene family.
    default: false
    inputBinding:
      position: 101
      prefix: --no_defrag
  - id: pangenome
    type: File
    doc: The pangenome.h5 file
    inputBinding:
      position: 101
      prefix: --pangenome
  - id: proksee
    type:
      - 'null'
      - boolean
    doc: Generate JSON map files for PROKSEE with projected pangenome 
      annotations for each input genome.
    inputBinding:
      position: 101
      prefix: --proksee
  - id: soft_core
    type:
      - 'null'
      - float
    doc: Soft core threshold used when generating general statistics on the 
      projected genome. This threshold does not influence PPanGGOLiN's 
      partitioning. The value determines the minimum fraction of genomes that 
      must possess a gene family for it to be considered part of the soft core.
    inputBinding:
      position: 101
      prefix: --soft_core
  - id: spot_graph
    type:
      - 'null'
      - boolean
    doc: Write the spot graph to a file, with pairs of blocks of single copy 
      markers flanking RGPs as nodes. This graph can be used to visualize nodes 
      that have RGPs from the input genome.
    inputBinding:
      position: 101
      prefix: --spot_graph
  - id: table
    type:
      - 'null'
      - boolean
    doc: Generate a tsv file for each input genome with pangenome annotations.
    inputBinding:
      position: 101
      prefix: --table
  - id: tmpdir
    type:
      - 'null'
      - Directory
    doc: directory for storing temporary files
    inputBinding:
      position: 101
      prefix: --tmpdir
  - id: use_pseudo
    type:
      - 'null'
      - boolean
    doc: In the context of provided annotation, use this option to read 
      pseudogenes. (Default behavior is to ignore them)
    inputBinding:
      position: 101
      prefix: --use_pseudo
  - id: verbose
    type:
      - 'null'
      - int
    doc: Indicate verbose level (0 for warning and errors only, 1 for info, 2 
      for debug)
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output
    type:
      - 'null'
      - Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ppanggolin:2.2.6--py310h1fe012e_0
