cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - deblur
  - build-biom-table
label: deblur_build-biom-table
doc: "Generate a BIOM table from a directory of chimera removed fasta files\n\nTool
  homepage: https://github.com/biocore/deblur"
inputs:
  - id: seqs_fp
    type: Directory
    doc: the path to the directory containing the chimera removed fasta files
    inputBinding:
      position: 1
  - id: output_biom_fp
    type: string
    doc: the path where to save the output biom table files ('all.biom', 
      'reference-hit.biom', 'reference-non-hit.biom')
    inputBinding:
      position: 2
  - id: file_type_option
    type:
      - 'null'
      - string
    doc: ending of files to be added to the biom table
    inputBinding:
      position: 103
      prefix: --file_type
  - id: log_file
    type:
      - 'null'
      - string
    doc: log file name
    inputBinding:
      position: 103
      prefix: --log-file
  - id: log_level
    type:
      - 'null'
      - int
    doc: 'Level of messages for log file (range 1-debug to 5-critical [default: 2;
      1<=x<=5]'
    inputBinding:
      position: 103
      prefix: --log-level
  - id: min_reads
    type:
      - 'null'
      - int
    doc: In output biom table - keep only sequences appearing at least min-reads
      in all samples combined.
    inputBinding:
      position: 103
      prefix: --min-reads
outputs:
  - id: output_dir
    type: Directory
    doc: Directory with the BIOM table (all.biom) and its sequences (all.seq.fa)
    outputBinding:
      glob: $(inputs.output_biom_fp)
  - id: biom_table
    type: File
    doc: BIOM table of all samples
    outputBinding:
      glob: $(inputs.output_biom_fp)/all.biom
  - id: log
    type:
      - 'null'
      - File
    doc: Log file
    outputBinding:
      glob: "$(inputs.log_file ? inputs.log_file : 'deblur.log')"
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: "$({class: 'Directory', basename: inputs.output_biom_fp, listing: []})"
        writable: true
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deblur:1.1.1--pyhdfd78af_0
stdout: deblur_build-biom-table.out
