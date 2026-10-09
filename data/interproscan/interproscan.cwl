cwlVersion: v1.2
class: CommandLineTool
baseCommand: interproscan.sh
label: interproscan
doc: "InterProScan is a batch tool to scan sequences (protein and nucleic acid) against
  InterPro's signatures.\n\nTool homepage: https://github.com/ebi-pf-team/interproscan"
inputs:
  - id: applications
    type:
      - 'null'
      - type: array
        items: string
    doc: Comma-separated list of analysis applications to run. Default is all.
    inputBinding:
      position: 101
      prefix: --applications
      itemSeparator: ','
  - id: cpu
    type:
      - 'null'
      - int
    doc: Number of processors to use.
    inputBinding:
      position: 101
      prefix: --cpu
  - id: disable_precalc
    type:
      - 'null'
      - boolean
    doc: Disable use of the InterProScan lookup service.
    inputBinding:
      position: 101
      prefix: --disable-precalc
  - id: formats
    type:
      - 'null'
      - type: array
        items: string
    doc: Case-insensitive, comma-separated list of output formats (e.g., TSV, 
      XML, GFF3, JSON, SVG, HTML).
    inputBinding:
      position: 101
      prefix: --formats
      itemSeparator: ','
  - id: goterms
    type:
      - 'null'
      - boolean
    doc: Switch on lookup of Gene Ontology (GO) terms.
    inputBinding:
      position: 101
      prefix: --goterms
  - id: input
    type: File
    doc: Input data. Sequence file or directory of sequence files.
    inputBinding:
      position: 101
      prefix: --input
  - id: iprlookup
    type:
      - 'null'
      - boolean
    doc: Switch on lookup of corresponding InterPro annotation.
    inputBinding:
      position: 101
      prefix: --iprlookup
  - id: pathways
    type:
      - 'null'
      - boolean
    doc: Switch on lookup of pathway information.
    inputBinding:
      position: 101
      prefix: --pathways
  - id: temp_directory
    type:
      - 'null'
      - string
    doc: Temporary file directory (relative path). The default location is temp/.
    inputBinding:
      position: 101
      prefix: --tempdir
  - id: outfile_path
    type:
      - 'null'
      - string
    doc: Explicit output file name (relative path). Mutually exclusive with --output-dir and --output-file-base; requires a single output format (--formats). Overwrites any existing file.
    inputBinding:
      position: 102
      prefix: --outfile
  - id: output_file_base_path
    type:
      - 'null'
      - string
    doc: Base output filename; the file extension for each output format is appended automatically. Mutually exclusive with --output-dir and --outfile. By default the input file name is used.
    inputBinding:
      position: 103
      prefix: --output-file-base
  - id: clusterrunid
    type:
      - 'null'
      - string
    doc: 'Switch to specify the Project name for this i5 run.'
    inputBinding:
      position: 101
      prefix: --clusterrunid
  - id: disable_residue_annot
    type:
      - 'null'
      - boolean
    doc: 'Excludes sites from the XML, JSON output.'
    inputBinding:
      position: 101
      prefix: --disable-residue-annot
  - id: enable_tsv_residue_annot
    type:
      - 'null'
      - boolean
    doc: 'Includes sites in TSV output.'
    inputBinding:
      position: 101
      prefix: --enable-tsv-residue-annot
  - id: excl_applications
    type:
      - 'null'
      - type: array
        items: string
    doc: Comma separated list of analyses you want to exclude.
    inputBinding:
      position: 101
      prefix: --excl-applications
      itemSeparator: ','
  - id: incl_dep_applications
    type:
      - 'null'
      - type: array
        items: string
    doc: Comma separated list of deprecated analyses that you want included. If this option is not set, deprecated analyses will not run.
    inputBinding:
      position: 101
      prefix: --incl-dep-applications
      itemSeparator: ','
  - id: minsize
    type:
      - 'null'
      - int
    doc: 'Minimum nucleotide size of ORF to report. Only considered if n is specified as a sequence type. A too short value may make the analysis take a very long time.'
    inputBinding:
      position: 101
      prefix: --minsize
  - id: mode
    type:
      - 'null'
      - string
    doc: 'The mode in which InterProScan is being run, the default mode is standalone. Must be one of: master, worker, distributed_worker, highmem_worker, standalone, distributed_master, cluster, singleseq, installer, empty_installer, convert, monitor.'
    inputBinding:
      position: 101
      prefix: --mode
  - id: output_tsv_version
    type:
      - 'null'
      - boolean
    doc: 'Includes a TSV version file along with any TSV output (when TSV output requested).'
    inputBinding:
      position: 101
      prefix: --output-tsv-version
  - id: seqtype
    type:
      - 'null'
      - string
    doc: 'The type of the input sequences (dna/rna (n) or protein (p)). The default sequence type is protein.'
    inputBinding:
      position: 101
      prefix: --seqtype
  - id: userdir
    type:
      - 'null'
      - string
    doc: 'The base directory for results (if absolute paths not specified).'
    inputBinding:
      position: 101
      prefix: --userdir
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: 'Display more verbose log output.'
    inputBinding:
      position: 101
      prefix: --verbose
  - id: verbose_level
    type:
      - 'null'
      - int
    doc: 'Display verbose log output at level specified.'
    inputBinding:
      position: 101
      prefix: --verbose-level
  - id: output_dir_path
    type:
      - 'null'
      - string
    doc: 'Output directory. Mutually exclusive with --outfile and --output-file-base. The output filenames are the same as the input filename, with the extension for each output format appended automatically.'
    inputBinding:
      position: 101
      prefix: --output-dir
outputs:
  - id: output_file_base
    type:
      - 'null'
      - type: array
        items: File
    doc: Optional output file base name. If not provided, the input file name is
      used.
    outputBinding:
      glob: $(inputs.output_file_base_path)*
  - id: outfile
    type:
      - 'null'
      - File
    doc: Explicit output file name. Only valid if a single output format is 
      specified.
    outputBinding:
      glob: $(inputs.outfile_path)
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Output directory (when --output-dir is used)
    outputBinding:
      glob: $(inputs.output_dir_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: '$(inputs.output_dir_path ? {"class": "Directory", "basename": inputs.output_dir_path, "listing": []} : null)'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/interproscan:5.59-91.0
