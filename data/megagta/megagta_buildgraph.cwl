cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sdbg_builder
  - read2sdbg
label: megagta_buildgraph
doc: "Builds a de Bruijn graph from sequencing reads.\n\nTool homepage: https://github.com/HKU-BAL/MegaGTA"
inputs:
  - id: assist_seq
    type:
      - 'null'
      - File
    doc: input assisting fast[aq] file (FILE_NAME.info should exist), can be 
      gzip'ed.
    inputBinding:
      position: 101
      prefix: --assist_seq
  - id: gpu_mem
    type:
      - 'null'
      - int
    doc: gpu memory to be used. 0 for auto detect.
    inputBinding:
      position: 101
      prefix: --gpu_mem
  - id: host_mem
    type:
      - 'null'
      - int
    doc: Max memory to be used. 90% of the free memory is recommended.
    inputBinding:
      position: 101
      prefix: --host_mem
  - id: kmer_k
    type:
      - 'null'
      - int
    doc: kmer size
    inputBinding:
      position: 101
      prefix: --kmer_k
  - id: mem_flag
    type:
      - 'null'
      - int
    doc: "memory options. 0: minimize memory usage; 1: automatically use moderate
      memory; other: use all available mem specified by '--host_mem'"
    inputBinding:
      position: 101
      prefix: --mem_flag
  - id: min_kmer_frequency
    type:
      - 'null'
      - int
    doc: min frequency to output an edge
    inputBinding:
      position: 101
      prefix: --min_kmer_frequency
  - id: need_mercy
    type:
      - 'null'
      - boolean
    doc: to add mercy edges.
    inputBinding:
      position: 101
      prefix: --need_mercy
  - id: num_cpu_threads
    type:
      - 'null'
      - int
    doc: number of CPU threads. At least 2.
    inputBinding:
      position: 101
      prefix: --num_cpu_threads
  - id: num_output_threads
    type:
      - 'null'
      - int
    doc: number of threads for output. Must be less than num_cpu_threads
    inputBinding:
      position: 101
      prefix: --num_output_threads
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: output prefix
    inputBinding:
      position: 101
      prefix: --output_prefix
  - id: read_lib_file
    type: File
    doc: input fast[aq] file, can be gzip'ed. "-" for stdin.
    inputBinding:
      position: 101
      prefix: --read_lib_file
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/megagta:0.1_alpha--0
stdout: megagta_buildgraph.out
