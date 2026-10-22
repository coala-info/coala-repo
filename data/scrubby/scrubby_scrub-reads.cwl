cwlVersion: v1.2
class: CommandLineTool
baseCommand: [scrubby, scrub-reads]
label: scrubby_scrub-reads
doc: "Clean sequence reads by removing background taxa (Kraken2) or aligning reads (Minimap2)\n\nTool homepage: https://github.com/esteinig/scrubby"
inputs:
  - id: input
    type:
      type: array
      items: File
    doc: "Input filepath(s) (fa, fq, gz, bz). For paired Illumina give the two files consecutively (r1.fq r2.fq); read identifiers are assumed to be the same in both files without trailing /1 or /2."
    inputBinding:
      prefix: --input
  - id: output
    type:
      type: array
      items: string
    doc: "Output filepath(s) with reads removed or extracted (--extract). For paired Illumina give two files; the order of the pairs is the same as for --input."
    inputBinding:
      prefix: --output
  - id: extract
    type: ['null', boolean]
    doc: Extract reads instead of removing them.
    inputBinding:
      prefix: --extract
  - id: keep
    type: ['null', boolean]
    doc: Keep the working directory and intermediate files.
    inputBinding:
      prefix: --keep
  - id: compression_level
    type: ['null', int]
    doc: 'Compression level to use if compressing output, 1-9 (default: 6)'
    inputBinding:
      prefix: --compression-level
  - id: kraken_db
    type:
      type: array
      items: Directory
    doc: Kraken2 database directory path(s); several databases are run in the order given. The command line of this version requires it, also for a minimap2-only run.
    inputBinding:
      prefix: --kraken-db
  - id: kraken_taxa
    type:
      - 'null'
      - type: array
        items: string
    doc: Taxa and sub-taxa (Domain and below) to include from the Kraken2 report, as names or taxonomic identifiers.
    inputBinding:
      prefix: --kraken-taxa
  - id: kraken_taxa_direct
    type:
      - 'null'
      - type: array
        items: string
    doc: Taxa to include directly from reads classified with Kraken2, such as those above the Domain level (e.g. root).
    inputBinding:
      prefix: --kraken-taxa-direct
  - id: kraken_threads
    type: ['null', int]
    doc: 'Threads to use for Kraken2 (default: 4)'
    inputBinding:
      prefix: --kraken-threads
  - id: min_cov
    type: ['null', double]
    doc: 'Minimum query alignment coverage to deplete a read (default: 0)'
    inputBinding:
      prefix: --min-cov
  - id: min_len
    type: ['null', int]
    doc: 'Minimum query alignment length to deplete a read (default: 0)'
    inputBinding:
      prefix: --min-len
  - id: min_mapq
    type: ['null', int]
    doc: 'Minimum mapping quality to deplete a read (default: 0)'
    inputBinding:
      prefix: --min-mapq
  - id: minimap2_index
    type:
      - 'null'
      - type: array
        items: File
    doc: Reference sequence file(s) (.fasta) or index file(s) (.mmi) for minimap2; several references are run in the order given.
    inputBinding:
      prefix: --minimap2-index
  - id: minimap2_preset
    type: ['null', string]
    doc: 'Minimap2 preset: sr, map-ont, map-hifi or map-pb (default: sr)'
    inputBinding:
      prefix: --minimap2-preset
  - id: output_format
    type: ['null', string]
    doc: 'Output compression format: u (uncompressed), b (Bzip2), g (Gzip) or l (Lzma); default is inferred from the file name extension'
    inputBinding:
      prefix: --output-format
  - id: workdir
    type: ['null', string]
    doc: Name of the working directory for the intermediary files (default is Scrubby_{YYYYMMDDTHHMMSS})
    inputBinding:
      prefix: --workdir
outputs:
  - id: output_files
    type: File[]
    doc: Output file(s) with reads removed or extracted (--extract)
    outputBinding:
      glob: $(inputs.output)
  - id: workdir_dir
    type: ['null', Directory]
    doc: Working directory with intermediary files (kept with --keep and --workdir)
    outputBinding:
      glob: $(inputs.workdir)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scrubby:0.2.1--h715e4b3_0
