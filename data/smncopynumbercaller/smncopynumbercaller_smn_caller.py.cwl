cwlVersion: v1.2
class: CommandLineTool
baseCommand: smn_caller.py
label: smncopynumbercaller_smn_caller.py
doc: "Call Copy number of full-length SMN1, full-length SMN2 and SMN* (Exon7-8 deletion)
  from a WGS bam file.\n\nThe tool reads a manifest of absolute BAM/CRAM paths. This wrapper writes
  the manifest (manifest.txt) from the bams input, so the paths are valid inside the container.\n\nTool
  homepage: https://github.com/Illumina/SMNCopyNumberCaller"
inputs:
  - id: bams
    type:
      type: array
      items: File
    secondaryFiles:
      - pattern: .bai
        required: false
      - pattern: .crai
        required: false
    doc: Input BAM/CRAM files (with their index files); listed in the manifest
      written by this wrapper
  - id: countFilePath
    type:
      - 'null'
      - File
    doc: Optional path to count files
    inputBinding:
      position: 101
      prefix: --countFilePath
  - id: genome
    type: string
    doc: Reference genome, select from 19, 37, or 38
    inputBinding:
      position: 101
      prefix: --genome
  - id: outDir
    type: string
    doc: Output directory
    inputBinding:
      position: 101
      prefix: --outDir
  - id: prefix
    type: string
    doc: Prefix to output file
    inputBinding:
      position: 101
      prefix: --prefix
  - id: reference
    type:
      - 'null'
      - File
    secondaryFiles:
      - .fai
    doc: Optional path to reference fasta file for CRAM
    inputBinding:
      position: 101
      prefix: --reference
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use. Default is 1
    inputBinding:
      position: 101
      prefix: --threads
arguments:
  - position: 100
    prefix: --manifest
    valueFrom: manifest.txt
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: smn_tsv
    type:
      - 'null'
      - File
    doc: Copy number calls (tsv) written to outDir
    outputBinding:
      glob: $(inputs.outDir)/$(inputs.prefix).tsv
  - id: smn_json
    type:
      - 'null'
      - File
    doc: Copy number calls (json) written to outDir
    outputBinding:
      glob: $(inputs.outDir)/$(inputs.prefix).json
  - id: outDir_dir
    type:
      - 'null'
      - Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.outDir)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: manifest.txt
        entry: "$(inputs.bams.map(function(f) { return f.path; }).join('\\n') + '\\n')"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smncopynumbercaller:1.1.2--py312h7e72e81_1
stdout: smncopynumbercaller_smn_caller.py.out
