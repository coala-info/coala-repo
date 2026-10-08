cwlVersion: v1.2
class: CommandLineTool
baseCommand: gmsc-mapper
label: gmsc-mapper
doc: "GMSC-mapper: map genome contigs, nucleotide genes or amino acid genes (small proteins) to the GMSC catalogue and annotate habitat, taxonomy, quality and domains.\n\nTool homepage: https://github.com/BigDataBiology/GMSC-mapper"
inputs:
  - id: genome_fasta
    type:
      - 'null'
      - File
    doc: Path to the input genome contig sequence FASTA file.
    inputBinding:
      position: 101
      prefix: --input
  - id: nt_input
    type:
      - 'null'
      - File
    doc: Path to the input nucleotide gene sequence FASTA file.
    inputBinding:
      position: 101
      prefix: --nt-genes
  - id: aa_input
    type:
      - 'null'
      - File
    doc: Path to the input amino acid sequence FASTA file.
    inputBinding:
      position: 101
      prefix: --aa-genes
  - id: output_path
    type: string
    doc: Output directory (will be created if non-existent)
    inputBinding:
      position: 102
      prefix: --output
  - id: tool
    type:
      - 'null'
      - string
    doc: Sequence alignment tool (diamond or mmseqs). Default diamond.
    inputBinding:
      position: 101
      prefix: --tool
  - id: sensitivity
    type:
      - 'null'
      - string
    doc: Sensitivity.
    inputBinding:
      position: 101
      prefix: --sensitivity
  - id: identity
    type:
      - 'null'
      - float
    doc: Minimum identity to report an alignment (range 0.0-1.0). Default 0.0.
    inputBinding:
      position: 101
      prefix: --id
  - id: coverage
    type:
      - 'null'
      - float
    doc: Minimum coverage to report an alignment (range 0.0-1.0). Default 0.9.
    inputBinding:
      position: 101
      prefix: --cov
  - id: evalue
    type:
      - 'null'
      - float
    doc: Maximum e-value to report alignments. Default 1e-05.
    inputBinding:
      position: 101
      prefix: --evalue
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of CPU threads. Default 1.
    inputBinding:
      position: 101
      prefix: --threads
  - id: filter
    type:
      - 'null'
      - boolean
    doc: Use this to filter <100 aa or <303 nt input sequences.
    inputBinding:
      position: 101
      prefix: --filter
  - id: no_habitat
    type:
      - 'null'
      - boolean
    doc: Use this if no need to annotate habitat
    inputBinding:
      position: 101
      prefix: --no-habitat
  - id: no_taxonomy
    type:
      - 'null'
      - boolean
    doc: Use this if no need to annotate taxonomy
    inputBinding:
      position: 101
      prefix: --no-taxonomy
  - id: no_quality
    type:
      - 'null'
      - boolean
    doc: Use this if no need to annotate quality
    inputBinding:
      position: 101
      prefix: --no-quality
  - id: no_domain
    type:
      - 'null'
      - boolean
    doc: Use this if no need to annotate domains
    inputBinding:
      position: 101
      prefix: --no-domain
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Disable alignment console output
    inputBinding:
      position: 101
      prefix: --quiet
  - id: dbdir
    type: Directory
    doc: Path to the GMSC database directory (diamond_targetdb.dmnd or mmseqs_targetdb, plus the annotation files unless disabled).
    inputBinding:
      position: 101
      prefix: --dbdir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output
    type:
      - 'null'
      - Directory
    doc: Output directory with the alignment table, summary and annotation files.
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gmsc-mapper:0.1.0--pyhdfd78af_0
stdout: gmsc-mapper.out
