cwlVersion: v1.2
class: CommandLineTool
baseCommand: gen_cov_file.sh
label: comebin_gen_cov_file.sh
doc: "Generates coverage files from reads and a metagenomic assembly.\n\nTool homepage:
  https://github.com/ziyewang/COMEBin"
inputs:
  - id: readsA_1
    type: File
    doc: First read file for replicate A (paired-end, read 1; name must end 
      with the forward suffix, default _1.fastq)
    inputBinding:
      position: 2
      valueFrom: $(self.basename)
  - id: readsA_2
    type: File
    doc: Second read file for replicate A (paired-end, read 2; name must end 
      with the reverse suffix, default _2.fastq)
    inputBinding:
      position: 3
      valueFrom: $(self.basename)
  - id: readsX
    type:
      - 'null'
      - type: array
        items: File
    doc: Additional read files for other replicates (paired-end, read 1 and read
      2)
    inputBinding:
      position: 4
      valueFrom: '${ return self ? self.map(function(f){ return f.basename; }) 
        : null; }'
  - id: assembly_file
    type: File
    doc: metagenomic assembly file
    inputBinding:
      position: 1
      prefix: -a
  - id: bam_dir
    type:
      - 'null'
      - string
    doc: directory for the bam files (default <output_dir>/work_files)
    inputBinding:
      position: 1
      prefix: -b
  - id: forward_suffix
    type:
      - 'null'
      - string
    doc: Forward read suffix for paired reads
    inputBinding:
      position: 1
      prefix: -f
  - id: interleaved
    type:
      - 'null'
      - boolean
    doc: the input read files contain interleaved paired-end reads
    inputBinding:
      position: 1
      prefix: --interleaved
  - id: min_contig_length
    type:
      - 'null'
      - int
    doc: minimum contig length to bin
    inputBinding:
      position: 1
      prefix: -l
  - id: ram_amount
    type:
      - 'null'
      - int
    doc: amount of RAM available
    inputBinding:
      position: 1
      prefix: -m
  - id: reverse_suffix
    type:
      - 'null'
      - string
    doc: Reverse read suffix for paired reads
    inputBinding:
      position: 1
      prefix: -r
  - id: single_end
    type:
      - 'null'
      - boolean
    doc: non-paired reads mode (provide *.fastq files)
    inputBinding:
      position: 1
      prefix: --single-end
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    inputBinding:
      position: 1
      prefix: -t
  - id: output_dir_path
    type: string
    doc: output directory (to save the coverage files)
    inputBinding:
      position: 1
      prefix: -o
outputs:
  - id: output_dir
    type: Directory
    doc: output directory (to save the coverage files)
    outputBinding:
      glob: $(inputs.output_dir_path)
  - id: bam_files
    type:
      type: array
      items: File
    doc: sorted BAM files of the reads aligned to the assembly
    outputBinding:
      glob: '$(inputs.bam_dir ? inputs.bam_dir : inputs.output_dir_path + "/work_files")/*.bam'
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.readsA_1)
      - $(inputs.readsA_2)
      - $(inputs.readsX)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/comebin:1.0.4--hdfd78af_1
