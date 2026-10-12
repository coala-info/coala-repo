cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - PanACoTA
  - prepare
label: panacota_prepare
doc: "Prepare draft dataset: download genomes from NCBI RefSeq or GenBank, run quality control (L90, number of contigs) and filter genomes by Mash distance.

Tool homepage: https://github.com/gem-pasteur/PanACoTA"
inputs:
  - id: ncbi_species_taxid
    type:
      - 'null'
      - string
    doc: "Species taxid to download (NCBI 'species taxid'). A comma-separated list is possible (for example 573 for Klebsiella pneumoniae)."
    inputBinding:
      prefix: -T
  - id: ncbi_taxid
    type:
      - 'null'
      - string
    doc: "Taxid to download: a sub-species or a specific strain. A comma-separated list is possible."
    inputBinding:
      prefix: -t
  - id: strains
    type:
      - 'null'
      - string
    doc: "Strains to download: a comma-separated list of strain names, or the path to a file with one name per line."
    inputBinding:
      prefix: -S
  - id: ncbi_species_name
    type:
      - 'null'
      - string
    doc: "Species to download, the NCBI 'organism name', for example 'escherichia coli'. Also used to name output files."
    inputBinding:
      prefix: -g
  - id: ncbi_section
    type:
      - 'null'
      - string
    doc: "NCBI section to download: refseq (default) or genbank."
    inputBinding:
      prefix: -s
  - id: levels
    type:
      - 'null'
      - string
    doc: "Assembly levels of genomes to download (default: all): 'all', 'complete', 'chromosome', 'scaffold', 'contig', or a comma-separated list."
    inputBinding:
      prefix: --assembly_level
  - id: outdir
    type: string
    doc: "Directory where the results are saved. It gets a folder 'Database_init' with the fasta files sent to the control procedure and a folder 'refseq' with the downloaded files. Default in the tool: the NCBI species name."
    inputBinding:
      prefix: -o
  - id: tmp_dir
    type:
      - 'null'
      - string
    doc: "Directory for temporary files (default: outdir/tmp_files)."
    inputBinding:
      prefix: --tmp
  - id: cutn
    type:
      - 'null'
      - int
    doc: "Cut genomes into new contigs at this number of 'N' in a row (default 5; 0 for no cutting)."
    inputBinding:
      prefix: --cutn
  - id: l90
    type:
      - 'null'
      - int
    doc: "Maximum L90 allowed to keep a genome (default 100)."
    inputBinding:
      prefix: --l90
  - id: nbcont
    type:
      - 'null'
      - int
    doc: "Maximum number of contigs allowed to keep a genome (default 999)."
    inputBinding:
      prefix: --nbcont
  - id: min_dist
    type:
      - 'null'
      - float
    doc: "Lower limit of the Mash distance to the reference (default 1e-4)."
    inputBinding:
      prefix: --min_dist
  - id: max_dist
    type:
      - 'null'
      - float
    doc: "Upper limit of the Mash distance to the reference (default 0.06)."
    inputBinding:
      prefix: --max_dist
  - id: threads
    type:
      - 'null'
      - int
    doc: "Run N downloads in parallel (default 1). Use 0 for all cores."
    inputBinding:
      prefix: -p
  - id: norefseq
    type:
      - 'null'
      - boolean
    doc: "Skip the download and go directly to quality control and the Mash filter. Give the genome folder with db_dir."
    inputBinding:
      prefix: --norefseq
  - id: db_dir
    type:
      - 'null'
      - Directory
    doc: "Folder with already downloaded genome fasta files (default: outdir/Database_init)."
    inputBinding:
      prefix: -d
  - id: only_mash
    type:
      - 'null'
      - boolean
    doc: "Run only the Mash steps; read genome quality from the file given with info_file."
    inputBinding:
      prefix: -M
  - id: info_file
    type:
      - 'null'
      - File
    doc: "Quality control file with tab-separated columns 'to_annotate', 'gsize', 'nb_conts' and 'L90' (used with only_mash)."
    inputBinding:
      prefix: --info
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Increase verbosity in stdout/stderr and log files."
    inputBinding:
      prefix: --verbose
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: "Do not display anything to stdout/stderr. Log files are still created."
    inputBinding:
      prefix: --quiet
outputs:
  - id: out_dir
    type:
      - 'null'
      - Directory
    doc: "Output directory with the filtered genome list (LSTINFO-*.txt), discarded genome lists, Mash files and logs."
    outputBinding:
      glob: $(inputs.outdir)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/panacota:1.4.0--pyhdfd78af_0
stdout: panacota_prepare.out
