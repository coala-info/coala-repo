cwlVersion: v1.2
class: CommandLineTool
baseCommand: zarp
label: zarp
doc: "Command-line argument parser class.\n\nTool homepage: https://github.com/zavolanlab/zarp-cli"
inputs:
  - id: references
    type:
      - 'null'
      - type: array
        items: string
    doc: references to individual sequencing libraries by local file path or 
      read archive identifiers OR paths to ZARP sample tables; seedocumentation 
      for details
    inputBinding:
      position: 1
  - id: adapter_3p
    type:
      - 'null'
      - string
    doc: adapter sequence to be truncated from the 3'-ends of reads; for 
      paired-end libraries, two sequences can be specified, separated by a 
      comma; these are used to truncate the the 3'-ends of first and second 
      mates, respectively
    inputBinding:
      position: 102
      prefix: --adapter-3p
  - id: adapter_5p
    type:
      - 'null'
      - string
    doc: adapter sequence to be truncated from the 5'-ends of reads; for 
      paired-end libraries, two sequences can be specified, separated by a 
      comma; these are used to truncate the the 5'-ends of first and second 
      mates, respectively
    inputBinding:
      position: 102
      prefix: --adapter-5p
  - id: adapter_poly_3p
    type:
      - 'null'
      - string
    doc: polynucleotide sequence to be truncated from the 3'-ends of reads, e.g.
      a stretch of A's; for paired-end libraries, two sequences can be 
      specified, separated by a comma; these are used to truncate the the 
      3'-ends of first and second mates, respectively
    inputBinding:
      position: 102
      prefix: --adapter-poly-3p
  - id: adapter_poly_5p
    type:
      - 'null'
      - string
    doc: polynucleotide sequence to be truncated from the 3'-ends of reads, e.g.
      a stretch of A's; for paired-end libraries, two sequences can be 
      specified, separated by a comma; these are used to truncate the the 
      5'-ends of first and second mates, respectively
    inputBinding:
      position: 102
      prefix: --adapter-poly-5p
  - id: annotations
    type:
      - 'null'
      - File
    doc: path to file annotating genes of the sample source; in GTF format
    inputBinding:
      position: 102
      prefix: --annotations
  - id: author
    type:
      - 'null'
      - string
    doc: your name
    inputBinding:
      position: 102
      prefix: --author
  - id: config_file
    type:
      - 'null'
      - File
    doc: override user-specific default configuration file
    inputBinding:
      position: 102
      prefix: --config-file
  - id: cores
    type:
      - 'null'
      - int
    doc: maximum number of cores that Snakemake is allowed to use; note that 
      this is different from the number of cores that may be used for each 
      individual workflow step/rule
    inputBinding:
      position: 102
      prefix: --cores
  - id: dependency_embedding
    type:
      - 'null'
      - string
    doc: strategy for embedding dependencies for the execution of individual 
      workflow steps/rules
    inputBinding:
      position: 102
      prefix: --dependency-embedding
  - id: description
    type:
      - 'null'
      - string
    doc: brief description of the workflow run
    inputBinding:
      position: 102
      prefix: --description
  - id: email
    type:
      - 'null'
      - string
    doc: your email address
    inputBinding:
      position: 102
      prefix: --email
  - id: execution_mode
    type:
      - 'null'
      - string
    doc: whether to trigger a full ZARP-cli run, a dry run (external tools are 
      not run, for testing),or prepare a ZARP run (input data creation only)
    inputBinding:
      position: 102
      prefix: --execution-mode
  - id: fragment_length_distribution_mean
    type:
      - 'null'
      - float
    doc: mean of fragment length distribution
    inputBinding:
      position: 102
      prefix: --fragment-length-distribution-mean
  - id: fragment_length_distribution_sd
    type:
      - 'null'
      - float
    doc: standard deviation of fragment length distribution
    inputBinding:
      position: 102
      prefix: --fragment-length-distribution-sd
  - id: genome_assemblies_map
    type:
      - 'null'
      - File
    doc: Path to genome assemblies mapping file
    inputBinding:
      position: 102
      prefix: --genome-assemblies-map
  - id: identifier
    type:
      - 'null'
      - string
    doc: run identifier; if not provided a random string will be generated
    inputBinding:
      position: 102
      prefix: --identifier
  - id: init
    type:
      - 'null'
      - boolean
    doc: add or edit user-specific default configuration and exit
    inputBinding:
      position: 102
      prefix: --init
  - id: logo
    type:
      - 'null'
      - string
    doc: path or URL pointing to your organization's logo
    inputBinding:
      position: 102
      prefix: --logo
  - id: profile
    type:
      - 'null'
      - File
    doc: Snakemake profile for ZARP workflow; refer to ZARP documentation for 
      details
    inputBinding:
      position: 102
      prefix: --profile
  - id: read_orientation
    type:
      - 'null'
      - string
    doc: orientation of reads in sequencing library; one of 'stranded_forward', 
      'stranded_reverse', 'unstranded', 'inward_stranded_forward', 
      'inward_stranded_reverse', 'inward_unstranded'; cf. 
      https://salmon.readthedocs.io/en/latest/library_type.html
    inputBinding:
      position: 102
      prefix: --read-orientation
  - id: reference_seqs
    type:
      - 'null'
      - File
    doc: path to file containing reference sequences of the sample source; in 
      FASTA format
    inputBinding:
      position: 102
      prefix: --reference-seqs
  - id: resources_version
    type:
      - 'null'
      - int
    doc: version of Ensembl genome resources to use when resources are not 
      explicitly provided; uses latest version by default
    inputBinding:
      position: 102
      prefix: --resources-version
  - id: rule_config
    type:
      - 'null'
      - File
    doc: ZARP rule configuration; refer to ZARP documentation for details
    inputBinding:
      position: 102
      prefix: --rule-config
  - id: salmon_kmer_size
    type:
      - 'null'
      - int
    doc: size of k-mers for building the Salmon index; the default value 
      typically works fine for reads of 75 bp or longer; consider using lower 
      values if dealing with shorter reads; Cf. 
      https://salmon.readthedocs.io/en/latest/salmon.html#preparing-transcriptome-indices-mapping-based-mode
    inputBinding:
      position: 102
      prefix: --salmon-kmer-size
  - id: source
    type:
      - 'null'
      - string
    doc: origin of the sample as either a NCBI taxonomy database identifier, 
      e.g, 9606 for humans, or the corresponding full name, e.g., 'Homo 
      sapiens'.
    inputBinding:
      position: 102
      prefix: --source
  - id: star_sjdb_overhang
    type:
      - 'null'
      - int
    doc: overhang length for splice junctions in STAR (parameter 
      `sjdbOverhang`); ideally the maximum read length minus 1. Lower values may
      result in decreased mapping accuracy, while higher values may result in 
      longer processing times. Cf. 
      https://github.com/alexdobin/STAR/blob/3ae0966bc604a944b1993f49aaeb597e809eb5c9/doc/STARmanual.pdf
    inputBinding:
      position: 102
      prefix: --star-sjdb-overhang
  - id: trim_polya
    type:
      - 'null'
      - boolean
    doc: remove poly-A tails from reads
    inputBinding:
      position: 102
      prefix: --trim-polya
  - id: url
    type:
      - 'null'
      - string
    doc: a relevant URL pointing to, e.g., your personal or organization's 
      websites
    inputBinding:
      position: 102
      prefix: --url
  - id: verbosity
    type:
      - 'null'
      - string
    doc: logging verbosity level
    inputBinding:
      position: 102
      prefix: --verbosity
  - id: working_directory
    type:
      - 'null'
      - Directory
    doc: directory in which the ZARP run is executed
    inputBinding:
      position: 102
      prefix: --working-directory
  - id: zarp_directory
    type:
      - 'null'
      - Directory
    doc: root directory of the ZARP repository
    inputBinding:
      position: 102
      prefix: --zarp-directory
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/zarp:1.0.0--pyhdfd78af_0
stdout: zarp.out
