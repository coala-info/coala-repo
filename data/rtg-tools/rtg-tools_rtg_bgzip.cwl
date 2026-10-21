cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rtg
  - bgzip
label: rtg-tools_rtg_bgzip
doc: 'Compress a file with block gzip. Tool homepage: https://github.com/RealTimeGenomics/rtg-tools'
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.files)
        writable: true
inputs:
  - id: compression_level
    type:
      - 'null'
      - int
    doc: 'the compression level to use, between 1 (least but fast) and 9 (highest but slow) (Default is 5)'
    inputBinding:
      position: 101
      prefix: --compression-level
  - id: decompress
    type:
      - 'null'
      - boolean
    doc: 'decompress'
    inputBinding:
      position: 101
      prefix: --decompress
  - id: force
    type:
      - 'null'
      - boolean
    doc: 'force overwrite of existing output file'
    inputBinding:
      position: 101
      prefix: --force
  - id: no_terminate
    type:
      - 'null'
      - boolean
    doc: 'if set, do not add the block gzip termination block'
    inputBinding:
      position: 101
      prefix: --no-terminate
  - id: to_stdout
    type:
      - 'null'
      - boolean
    doc: 'write on standard output, keep original files unchanged. Implied when using standard input'
    inputBinding:
      position: 101
      prefix: --stdout
  - id: files
    type:
      type: array
      items: File
    doc: 'file to (de)compress'
    inputBinding:
      position: 200
      valueFrom: '${return self.map(function(f){return f.basename;});}'
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: compressed
    type:
      type: array
      items: File
    doc: Block-gzipped files (<name>.gz) or decompressed files
    outputBinding:
      glob: |
        ${ return inputs.files.map(function(f){ return inputs.decompress ? f.basename.replace(/\.gz$/, '') : f.basename + '.gz'; }); }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rtg-tools:3.13--hdfd78af_0
stdout: rtg-tools_rtg_bgzip.out
