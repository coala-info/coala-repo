cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - stringMLST.py
  - --buildDB
label: stringmlst_buildDB
doc: "Build a k-mer database for an MLST typing scheme (loci multi-FASTA files and a profile definition file listed in a config file).\n\nTool homepage: https://github.com/jordanlab/stringMLST"
inputs:
  - id: config
    type: File
    doc: Config file in the format described above (tab delimited; a [loci] section
      with locus and multi-FASTA file, and a [profile] section). All files follow the
      structure followed by pubmlst.
    inputBinding:
      position: 1
      prefix: --config
  - id: scheme_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Locus multi-FASTA files and profile file named in the config file; staged
      in the working directory so the names in the config resolve
  - id: kmer_length
    type:
      - 'null'
      - int
    doc: Kmer size for which the db has to be formed (Default k = 35). The tool works
      best with kmer length in between 35 and 66 for read lengths of 55 to 150 bp.
    inputBinding:
      position: 2
      prefix: -k
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix for db and log files to be created (Default = kmer)
    inputBinding:
      position: 3
      prefix: --prefix
  - id: build_log
    type:
      - 'null'
      - string
    doc: File location to write build log
    inputBinding:
      position: 4
      prefix: -a
outputs:
  - id: db_files
    type:
      type: array
      items: File
    doc: Database files created with the prefix (k-mer table, weight and profile files)
    outputBinding:
      glob: "$((inputs.prefix || 'kmer') + '*')"
  - id: log_file
    type:
      - 'null'
      - File
    doc: Build log
    outputBinding:
      glob: $(inputs.build_log)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.scheme_files || [])
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/stringmlst:0.6.3--py_0
