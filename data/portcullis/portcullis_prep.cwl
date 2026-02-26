cwlVersion: v1.2
class: CommandLineTool
baseCommand: portcullis prep
label: portcullis_prep
doc: "Prepares a genome and bam file(s) ready for junction analysis. This involves
  ensuring the bam file is sorted and indexed and the genome file is indexed.\n\n\
  Tool homepage: https://github.com/maplesond/portcullis"
inputs:
  - id: genome_file
    type: File
    doc: Genome file
    inputBinding:
      position: 1
  - id: bam_files
    type:
      type: array
      items: File
    doc: BAM file(s)
    inputBinding:
      position: 2
  - id: copy
    type:
      - 'null'
      - boolean
    doc: Whether to copy files from input data to prepared data where possible, 
      otherwise will use symlinks. Will require more time and disk space to 
      prepare input but is potentially more robust.
    inputBinding:
      position: 103
      prefix: --copy
  - id: force
    type:
      - 'null'
      - boolean
    doc: Whether or not to clean the output directory before processing, thereby
      forcing full preparation of the genome and bam files. By default 
      portcullis will only do what it thinks it needs to.
    inputBinding:
      position: 103
      prefix: --force
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Output directory for prepared files.
    default: portcullis_prep
    inputBinding:
      position: 103
      prefix: --output
  - id: threads
    type:
      - 'null'
      - int
    doc: The number of threads to used to sort the BAM file (if required).
    default: 1
    inputBinding:
      position: 103
      prefix: --threads
  - id: use_csi
    type:
      - 'null'
      - boolean
    doc: Whether to use CSI indexing rather than BAI indexing. CSI has the 
      advantage that it supports very long target sequences (probably not an 
      issue unless you are working on huge genomes). BAI has the advantage that 
      it is more widely supported (useful for viewing in genome browsers).
    inputBinding:
      position: 103
      prefix: --use_csi
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print extra information
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/portcullis:1.2.4--py39hc87ae8a_4
stdout: portcullis_prep.out
