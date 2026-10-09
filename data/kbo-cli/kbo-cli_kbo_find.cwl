cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kbo
  - find
label: kbo-cli_kbo_find
doc: "Finds sequences in query files based on a reference or index.\n\nTool homepage:
  https://docs.rs/kbo"
inputs:
  - id: query_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Query file(s) with sequence data.
    inputBinding:
      position: 1
  - id: list_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Sequence files named in input_list; staged in the working directory so that the paths in the list resolve
  - id: dedup_batches
    type:
      - 'null'
      - boolean
    doc: Deduplicate k-mer batches to save some memory.
    inputBinding:
      position: 102
      prefix: --dedup-batches
  - id: detailed
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --detailed
  - id: index
    type:
      - 'null'
      - File
    doc: Prebuilt index file <prefix>.sbwt; <prefix>.lcs must sit beside it (excludes -r).
    secondaryFiles:
      - ^.lcs
    inputBinding:
      position: 102
      prefix: --index
      valueFrom: $(self.path.replace(/\.sbwt$/, ''))
  - id: input_list
    type:
      - 'null'
      - File
    doc: File with paths or tab separated name and path on each line.
    inputBinding:
      position: 102
      prefix: --input-list
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: k-mer size, larger values are slower and use more space.
    inputBinding:
      position: 102
      prefix: -k
  - id: max_error_prob
    type:
      - 'null'
      - float
    doc: Tolerance for errors in k-mer matching.
    inputBinding:
      position: 102
      prefix: --max-error-prob
  - id: max_gap_len
    type:
      - 'null'
      - int
    doc: Allow gaps of this length in the alignment.
    inputBinding:
      position: 102
      prefix: --max-gap-len
  - id: mem_gb
    type:
      - 'null'
      - int
    doc: Memory available when building on temp disk space (in gigabytes).
    inputBinding:
      position: 102
      prefix: --mem-gb
  - id: min_len
    type:
      - 'null'
      - int
    doc: Minimum alignment length to report.
    inputBinding:
      position: 102
      prefix: --min-len
  - id: prefix_precalc
    type:
      - 'null'
      - int
    doc: Length of precalculated prefixes included in the index.
    inputBinding:
      position: 102
      prefix: --prefix-precalc
  - id: reference_file
    type:
      - 'null'
      - File
    doc: File with target sequence data (excludes -i).
    inputBinding:
      position: 102
      prefix: --reference
  - id: temp_dir
    type:
      - 'null'
      - string
    doc: Build on temporary disk space at this path instead of in-memory.
    inputBinding:
      position: 102
      prefix: --temp-dir
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 102
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --verbose
  - id: output_file_path
    type:
      - 'null'
      - string
    doc: Write output to a file instead of printing.
    inputBinding:
      position: 103
      prefix: --output
outputs:
  - id: stdout
    type: stdout
    doc: Alignments table when no output file is given
  - id: output_file
    type:
      - 'null'
      - File
    doc: Write output to a file instead of printing.
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.list_files)
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kbo-cli:0.2.1--h4349ce8_0
stdout: kbo-cli_kbo_find.out
