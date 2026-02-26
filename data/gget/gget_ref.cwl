cwlVersion: v1.2
class: CommandLineTool
baseCommand: gget_ref
label: gget_ref
doc: "Fetch FTPs for reference genomes and annotations by species.\n\nTool homepage:
  https://github.com/pachterlab/gget"
inputs:
  - id: species
    type:
      - 'null'
      - string
    doc: "Species or database to be searched. Species should be passed in the format
      'genus_species', e.g. 'homo_sapiens'.\n                        Supported shortcuts:
      'human', 'mouse', 'human_grch37' (accesses the GRCh37 genome assembly)"
    inputBinding:
      position: 1
  - id: download
    type:
      - 'null'
      - boolean
    doc: Download FTPs to the directory specified by --out_dir using curl.
    inputBinding:
      position: 102
      prefix: --download
  - id: ftp
    type:
      - 'null'
      - boolean
    doc: Return only the FTP link(s).
    inputBinding:
      position: 102
      prefix: --ftp
  - id: list_iv_species
    type:
      - 'null'
      - boolean
    doc: "List all available invertebrate species from the Ensembl database.\n   \
      \                     (Combine with `--release` to get the available species
      from a specific Ensembl release.)"
    inputBinding:
      position: 102
      prefix: --list_iv_species
  - id: list_species
    type:
      - 'null'
      - boolean
    doc: "List all available vertebrate species from the Ensembl database.\n     \
      \                   (Combine with `--release` to get the available species from
      a specific Ensembl release.)"
    inputBinding:
      position: 102
      prefix: --list_species
  - id: out_dir
    type:
      - 'null'
      - Directory
    doc: Path to the directory the FTPs will be saved in, e.g. 
      path/to/directory.
    default: Current working directory.
    inputBinding:
      position: 102
      prefix: --out_dir
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Does not print progress information.
    inputBinding:
      position: 102
      prefix: --quiet
  - id: release
    type:
      - 'null'
      - int
    doc: 'Ensembl release the FTPs will be fetched from, e.g. 104 (default: latest
      Ensembl release).'
    default: latest Ensembl release
    inputBinding:
      position: 102
      prefix: --release
  - id: species_deprecated
    type:
      - 'null'
      - string
    doc: DEPRECATED - use positional argument instead. Species for which the 
      FTPs will be fetched, e.g. homo_sapiens.
    inputBinding:
      position: 102
      prefix: --species
  - id: which
    type:
      - 'null'
      - string
    doc: "Defines which results to return.\n                        Default: 'all'
      -> Returns all available results.\n                        Possible entries
      are one or a combination (as a comma-separated list) of the following:\n   \
      \                     'gtf' - Returns the annotation (GTF).\n              \
      \          'cdna' - Returns the trancriptome (cDNA).\n                     \
      \   'dna' - Returns the genome (DNA).\n                        'cds - Returns
      the coding sequences corresponding to Ensembl genes. (Does not contain UTR or
      intronic sequence.)\n                        'cdrna' - Returns transcript sequences
      corresponding to non-coding RNA genes (ncRNA).\n                        'pep'
      - Returns the protein translations of Ensembl genes.\n                     \
      \   Example: '-w dna,gtf' (default: all)"
    default: all
    inputBinding:
      position: 102
      prefix: --which
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: Path to the file the results will be saved in, e.g. 
      path/to/directory/results.json.
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gget:0.29.0--pyhdfd78af_0
