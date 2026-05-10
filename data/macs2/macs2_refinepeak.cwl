cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - macs2
  - refinepeak
label: macs2_refinepeak
doc: "Refine peak summits and give a score measuring the balance of Watson and Crick
  tags. MACS2 refinepeak is used to take a candidate peak list and alignment files
  to refine the peak summits.\n\nTool homepage: https://pypi.org/project/MACS2/"
inputs:
  - id: bed_file
    type: File
    doc: Candidate peak file in BED format. REQUIRED.
    inputBinding:
      position: 101
      prefix: -b
  - id: buffer_size
    type:
      - 'null'
      - int
    doc: Buffer size for incrementally increasing internal array size to store 
      reads alignment information.
    inputBinding:
      position: 101
      prefix: --buffer-size
  - id: cutoff
    type:
      - 'null'
      - int
    doc: 'Cutoff DEFAULT: 5'
    inputBinding:
      position: 101
      prefix: --cutoff
  - id: format
    type:
      - 'null'
      - string
    doc: Format of tag file, "AUTO", "BED" or "ELAND" or "ELANDMULTI" or 
      "ELANDEXPORT" or "SAM" or "BAM" or "BOWTIE". The default AUTO option will 
      let 'macs2 refinepeak' decide which format the file is.
    inputBinding:
      position: 101
      prefix: --format
  - id: ifile
    type:
      type: array
      items: File
    doc: ChIP-seq alignment file. If multiple files are given as '-t A B C', 
      then they will all be read and combined. Note that pair-end data is not 
      supposed to work with this command. REQUIRED.
    inputBinding:
      position: 101
      prefix: --ifile
  - id: window_size
    type:
      - 'null'
      - int
    doc: 'Scan window size on both side of the summit (default: 100bp)'
    inputBinding:
      position: 101
      prefix: --window-size
  - id: o_prefix_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `o_prefix_path`
    inputBinding:
      position: 102
      prefix: --o-prefix
  - id: ofile_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `ofile_path`
    inputBinding:
      position: 103
      prefix: --ofile
  - id: outdir_path
    type:
      - 'null'
      - string
    doc: If specified all output files will be written to that
    inputBinding:
      position: 104
      prefix: --outdir
outputs:
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: 'If specified all output files will be written to that directory. Default:
      the current working directory'
    outputBinding:
      glob: $(inputs.outdir_path)
  - id: ofile
    type:
      - 'null'
      - File
    doc: Output file name. Mutually exclusive with --o-prefix.
    outputBinding:
      glob: $(inputs.ofile_path)
  - id: o_prefix
    type:
      - 'null'
      - File
    doc: Output file prefix. Mutually exclusive with -o/--ofile.
    outputBinding:
      glob: $(inputs.o_prefix_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/macs2:2.2.9.1--py310h1fe012e_5
