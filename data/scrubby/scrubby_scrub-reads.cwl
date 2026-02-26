cwlVersion: v1.2
class: CommandLineTool
baseCommand: scrubby scrub-reads
label: scrubby_scrub-reads
doc: "Clean sequence reads by removing background taxa (Kraken2) or aligning reads
  (Minimap2)\n\nTool homepage: https://github.com/esteinig/scrubby"
inputs:
  - id: compression_level
    type:
      - 'null'
      - int
    doc: Compression level to use if compressing output
    default: 6
    inputBinding:
      position: 101
      prefix: --compression-level
  - id: extract
    type:
      - 'null'
      - boolean
    doc: "Extract reads instead of removing them.\n            \n            This
      flag reverses the depletion and makes the command an extraction process of reads
      that would otherwise\n            be removed during depletion."
    inputBinding:
      position: 101
      prefix: --extract
  - id: input
    type:
      type: array
      items: File
    doc: "Input filepath(s) (fa, fq, gz, bz).\n            \n            For paired
      Illumina you may either pass this flag twice `-i r1.fq -i r2.fq` or give two
      files consecutively\n            `-i r1.fq r2.fq`. Read identifiers for paired-end
      Illumina reads are assumed to be the same in forward and\n            reverse
      read files (modern format) without trailing read orientations `/1` or `/2`."
    inputBinding:
      position: 101
      prefix: --input
  - id: keep
    type:
      - 'null'
      - boolean
    doc: "Keep the working directory and intermediate files.\n            \n     \
      \       This flag specifies that we want to keep the working directory and all
      intermediate files; otherwise the\n            working directory is deleted."
    inputBinding:
      position: 101
      prefix: --keep
  - id: kraken_db
    type:
      type: array
      items: Directory
    doc: "Kraken2 database directory path(s).\n            \n            Specify the
      path to the database directory to be used for classification with `Kraken2`.
      This only needs to\n            be specified if you would like to run the `Kraken2`
      analysis; otherwise `--kraken-report` and `--kraken-\n            read` can
      be used. Note that multiple databases can be specified with `--kraken-db` which
      will be\n            run and reads depleted/extracted in the order with which
      the database files were provided. You may either\n            pass this flag
      twice `-k db1/ -k db2/` or give two files consecutively `-k db1/ db2/`."
    inputBinding:
      position: 101
      prefix: --kraken-db
  - id: kraken_taxa
    type:
      - 'null'
      - type: array
        items: string
    doc: "Taxa and sub-taxa (Domain and below) to include from the report of `Kraken2`.\n\
      \            \n            You may specify multiple taxon names or taxonomic
      identifiers by passing this flag multiple times `-t\n            Archaea -t
      9606` or give taxa consecutively `-t Archaea 9606`. `Kraken2` reports are parsed
      and every\n            taxonomic level below the provided taxon level will be
      included. Only taxa or sub-taxa that have reads\n            directly assigned
      to them will be parsed. For example, when providing `Archaea` (Domain) all taxonomic\n\
      \            levels below the `Domain` level are included until the next level
      of the same rank or higher is encountered\n            in the report. This means
      that higher levels than `Domain` should be specified with `--kraken-taxa-direct`."
    inputBinding:
      position: 101
      prefix: --kraken-taxa
  - id: kraken_taxa_direct
    type:
      - 'null'
      - type: array
        items: string
    doc: "Taxa to include directly from reads classified with `Kraken2`.\n       \
      \     \n            Additional taxon names or taxonomic identifiers can be specified
      with this argument, such as those above the\n            `Domain` level. These
      are directly added to the list of taxa to include while parsing the report without\n\
      \            considering sub-taxa. For example, to retain `Viruses` one can
      specify the domains `-t Archaea -t Bacteria\n            -t Eukaryota` with
      `--kraken-taxa` and add `-d 'other sequences' -d 'cellular organsisms' -d root`
      with\n            `--kraken-taxa-direct`."
    inputBinding:
      position: 101
      prefix: --kraken-taxa-direct
  - id: kraken_threads
    type:
      - 'null'
      - int
    doc: "Threads to use for Kraken2.\n            \n            Specify the number
      of threads with which to run `Kraken2`."
    default: 4
    inputBinding:
      position: 101
      prefix: --kraken-threads
  - id: min_cov
    type:
      - 'null'
      - int
    doc: Minimum query alignment coverage to deplete a read
    default: 0
    inputBinding:
      position: 101
      prefix: --min-cov
  - id: min_len
    type:
      - 'null'
      - int
    doc: Minimum query alignment length to deplete a read
    default: 0
    inputBinding:
      position: 101
      prefix: --min-len
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: Minimum mapping quality to deplete a read
    default: 0
    inputBinding:
      position: 101
      prefix: --min-mapq
  - id: minimap2_index
    type:
      - 'null'
      - type: array
        items: File
    doc: "Reference sequence file(s) or index file(s) for `minimap2`.\n          \
      \  \n            Specify the index file (.mmi) or the reference sequence(s)
      (.fasta) for alignment with `minimap2`. Note that\n            multiple references
      can be specified with `--minimap2-index` which will be run and reads depleted/extracted\n\
      \            in the order with which the database files were provided. You may
      either pass this flag twice `-m idx1.mmi\n            -m idx2.mmi` or give two
      files consecutively `-m idx1.mmi idx2.mmi`."
    inputBinding:
      position: 101
      prefix: --minimap2-index
  - id: minimap2_preset
    type:
      - 'null'
      - string
    doc: "Minimap2 preset configuration - default is `sr`.\n            \n       \
      \     Specify the preset configuration for `minimap2` - the default is short
      reads!"
    default: sr
    inputBinding:
      position: 101
      prefix: --minimap2-preset
  - id: output_format
    type:
      - 'null'
      - string
    doc: "u: uncompressed; b: Bzip2; g: Gzip; l: Lzma\n            \n            Default
      is to attempt to infer the output compression format automatically from the
      filename extension\n            (gz|bz|bz2|lzma). This option is used to override
      that."
    inputBinding:
      position: 101
      prefix: --output-format
  - id: workdir
    type:
      - 'null'
      - Directory
    doc: "Working directory containing intermediary files.\n            \n       \
      \     Path to a working directory which contains the alignment and intermediary
      output files from the programs\n            called during scrubbing. By default
      is the working output directory is named with a timestamp in the format:\n \
      \           `Scrubby_{YYYYMMDDTHHMMSS}`."
    inputBinding:
      position: 101
      prefix: --workdir
outputs:
  - id: output
    type: File
    doc: "Output filepath(s) with reads removed or extracted (`--extract`).\n    \
      \        \n            For paired Illumina you may either pass this flag twice
      `-o r1.fq -o r2.fq` or give two files consecutively\n            `-o r1.fq r2.fq`.
      NOTE: The order of the pairs is assumed to be the same as that given for --input."
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scrubby:0.2.1--h715e4b3_0
