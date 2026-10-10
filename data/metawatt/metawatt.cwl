cwlVersion: v1.2
class: CommandLineTool
baseCommand: metawatt
label: metawatt
doc: "Metawatt version 3.5.3\n\nTool homepage: https://github.com/edhelas/metawatt"
inputs:
  - id: check_dependencies
    type:
      - 'null'
      - boolean
    doc: check dependencies and exit
    inputBinding:
      position: 101
      prefix: --check-dependencies
  - id: cov_rel_weight
    type:
      - 'null'
      - float
    doc: relative weight of differential coverage scores versus tetranucleotide 
      scores
    inputBinding:
      position: 101
      prefix: --cov-rel-weight
  - id: explore
    type:
      - 'null'
      - Directory
    doc: opens graphical user interface to explore pipeline results
    inputBinding:
      position: 101
      prefix: --explore
  - id: run
    type:
      - 'null'
      - Directory
    doc: "runs metawatt pipeline on the command line; the project directory holds an
      input folder (assembly fasta with at least two contigs, fastq reads), an optional databases folder with an HMM profile file, and metawatt
      writes an output folder into it. The wrapper script changes directory, so the
      path is passed as an absolute path."
    inputBinding:
      position: 101
      prefix: --run
      valueFrom: $(runtime.outdir)/$(self.basename)
  - id: skip_database_update
    type:
      - 'null'
      - boolean
    doc: do not update databases
    inputBinding:
      position: 101
      prefix: --skip-database-update
  - id: temp_folder
    type:
      - 'null'
      - string
    doc: temp folder used
    inputBinding:
      position: 101
      prefix: --temp-folder
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads/processors
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: project_dir
    type:
      - 'null'
      - Directory
    doc: project directory after the run (input, output, metawatt-project.xml, logbook)
    outputBinding:
      glob: $(inputs.run.basename)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: "$(inputs.run ? [{entryname: inputs.run.basename, entry: inputs.run, writable: true}] : [])"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metawatt:3.5.3--boost1.64_0
stdout: metawatt.out
