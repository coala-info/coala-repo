cwlVersion: v1.2
class: CommandLineTool
baseCommand: gdi
label: genomics-data-index_gdi_load_kmer
doc: "Index kmers (sourmash sketches) of genomes listed in an input file.\n\nThe tool needs a project folder made by \"gdi init\". It is passed as project_dir.\n\nTool homepage: https://github.com/apetkau/genomics-data-index"
arguments:
  - position: 3
    valueFrom: load
  - position: 4
    valueFrom: kmer
inputs:
  - id: project_dir
    type: Directory
    doc: "project folder made by gdi init (global option --project-dir)"
    inputBinding:
      position: 1
      prefix: --project-dir
      valueFrom: $(self.basename)
  - id: ncores
    type:
      - 'null'
      - int
    doc: "Number of cores for any parallel processing"
    inputBinding:
      position: 1
      prefix: --ncores
  - id: log_level
    type:
      - 'null'
      - string
    doc: "Sets the log level (TRACE, DEBUG, INFO, WARNING, ERROR, CRITICAL)"
    inputBinding:
      position: 1
      prefix: --log-level
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: "Kmer size for indexing. Default: 31"
    inputBinding:
      position: 10
      prefix: --kmer-size
  - id: kmer_fofns
    type: File
    doc: "Tab-separated file with the columns Sample and Files (comma-separated genome files)"
    inputBinding:
      position: 100
  - id: data_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Files named in the input file (staged in the working directory so the relative names resolve)"
outputs:
  - id: stdout
    type: stdout
    doc: "Standard output"
  - id: project_dir_out
    type:
      - 'null'
      - Directory
    doc: "The project folder with the new data"
    outputBinding:
      glob: $(inputs.project_dir.basename)
requirements:
  - class: InlineJavascriptRequirement
  - class: EnvVarRequirement
    envDef:
      - envName: USER
        envValue: gdi
      - envName: QT_QPA_PLATFORM
        envValue: offscreen
  - class: InitialWorkDirRequirement
    listing: |
      ${
        var l = [{"entry": inputs.project_dir, "writable": true}];
        (inputs.data_files || []).forEach(function(f) { l.push(f); });
        return l;
      }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genomics-data-index:0.9.2--pyhdfd78af_0
stdout: genomics-data-index_gdi_load_kmer.out
