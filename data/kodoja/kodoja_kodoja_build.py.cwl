cwlVersion: v1.2
class: CommandLineTool
baseCommand: kodoja_build.py
label: kodoja_kodoja_build.py
doc: "Kodoja Build creates a database for use with Kodoja Search.\n\nTool homepage:
  https://github.com/abaizan/kodoja/"
inputs:
  - id: all_viruses
    type:
      - 'null'
      - boolean
    doc: Build databases with all viruses (not plant specific)
    inputBinding:
      position: 101
      prefix: --all_viruses
  - id: db_tag
    type:
      - 'null'
      - string
    doc: Suffix for databases
    inputBinding:
      position: 101
      prefix: --db_tag
  - id: download_parallel
    type:
      - 'null'
      - int
    doc: Parallel genome download
    inputBinding:
      position: 101
      prefix: --download_parallel
  - id: extra_files
    type:
      - 'null'
      - type: array
        items: File
    doc: List of extra files added to "extra" dir
    inputBinding:
      position: 101
      prefix: --extra_files
  - id: extra_taxids
    type:
      - 'null'
      - type: array
        items: string
    doc: List of taxID of extra files
    inputBinding:
      position: 101
      prefix: --extra_taxids
  - id: host_taxid
    type:
      - 'null'
      - string
    doc: Host tax ID
    inputBinding:
      position: 101
      prefix: --host_taxid
  - id: kraken_kmer
    type:
      - 'null'
      - int
    doc: Kraken kmer size
    inputBinding:
      position: 101
      prefix: --kraken_kmer
  - id: kraken_minimizer
    type:
      - 'null'
      - int
    doc: Kraken minimizer size
    inputBinding:
      position: 101
      prefix: --kraken_minimizer
  - id: kraken_tax
    type:
      - 'null'
      - Directory
    doc: Taxonomy directory (the files of a kraken taxonomy folder). It is staged writable at <output_dir>/krakenDB[_<db_tag>]/taxonomy, where kodoja_build.py finds and fills it, because --kraken_tax would only make a symlink to the input folder. Without it kodoja_build.py downloads the NCBI taxonomy.
  - id: no_download
    type:
      - 'null'
      - boolean
    doc: Genomes have already been downloaded
    inputBinding:
      position: 101
      prefix: --no_download
  - id: output_dir
    type: string
    doc: Output directory path, required
    inputBinding:
      position: 101
      prefix: --output_dir
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_dir_dir
    type:
      - 'null'
      - Directory
    doc: Output directory path, required
    outputBinding:
      glob: $(inputs.output_dir)
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
  - class: InitialWorkDirRequirement
    listing:
      - |
        ${
          if (!inputs.kraken_tax) { return []; }
          var db = inputs.output_dir + "/krakenDB" + (inputs.db_tag ? "_" + inputs.db_tag : "") + "/taxonomy";
          return [{"entryname": db, "entry": inputs.kraken_tax, "writable": true}];
        }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kodoja:0.0.10--0
stdout: kodoja_kodoja_build.py.out
