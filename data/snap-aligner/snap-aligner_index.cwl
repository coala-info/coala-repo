cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - snap-aligner
  - index
label: snap-aligner_index
doc: "Build an index for the SNAP aligner.\n\nTool homepage: http://snap.cs.berkeley.edu/"
inputs:
  - id: input_fa
    type: File
    doc: Input FASTA file
    inputBinding:
      position: 1
  - id: output_dir
    type: Directory
    doc: Output directory for the index
    inputBinding:
      position: 2
  - id: alt_contig_file
    type:
      - 'null'
      - type: array
        items: File
    doc: Specify the name of a file with a list of alt contig names, one per 
      line. You may specify this as often as you'd like
    inputBinding:
      position: 103
      prefix: -altContigFile
  - id: alt_contig_name
    type:
      - 'null'
      - type: array
        items: string
    doc: Specify the (case independent) name of an alt to mark a contig. You can
      supply this parameter as often as you'd like
    inputBinding:
      position: 103
      prefix: -altContigName
  - id: alt_liftover_file
    type:
      - 'null'
      - File
    doc: Specify the file containing ALT-to-REF mappings (SAM format). e.g., 
      hs38DH.fa.alt from bwa-kit
    inputBinding:
      position: 103
      prefix: -altLiftoverFile
  - id: auto_alt_contigs
    type:
      - 'null'
      - boolean
    doc: Don't automatically mark ALT contigs. Otherwise, any contig whose name 
      ends in '_alt' (regardless of captialization) or starts with HLA- will be 
      marked ALT.
    inputBinding:
      position: 103
      prefix: -AutoAlt-
  - id: build_histogram
    type:
      - 'null'
      - File
    doc: Build a histogram of seed popularity. Specify the histogram file name 
      directly after -H without leaving a space.
    inputBinding:
      position: 103
      prefix: -H
  - id: build_larger_index
    type:
      - 'null'
      - boolean
    doc: Build a larger index that's a little faster, particularly for runs with
      quick/inaccurate parameters.
    inputBinding:
      position: 103
      prefix: -large
  - id: chromosome_terminators
    type:
      - 'null'
      - string
    doc: Specify characters to use as chromosome name terminators in the FASTA 
      header line; these characters and anything after are not part of the 
      chromosome name.
    inputBinding:
      position: 103
      prefix: -B
  - id: compute_exact_hash_sizes
    type:
      - 'null'
      - boolean
    doc: Compute hash table sizes exactly. This will slow down index build, but 
      usually will result in smaller indices.
    inputBinding:
      position: 103
      prefix: -exact
  - id: hash_table_slack
    type:
      - 'null'
      - float
    doc: Hash table slack
    default: 0.3
    inputBinding:
      position: 103
      prefix: -h
  - id: include_space_tab_in_names
    type:
      - 'null'
      - boolean
    doc: Indicates that space and tab characters should be included in 
      chromosome names.
    inputBinding:
      position: 103
      prefix: -bSpace-
  - id: key_size
    type:
      - 'null'
      - int
    doc: The number of bytes to use for the hash table key. Larger values 
      increase SNAP's memory footprint, but allow larger seeds.
    inputBinding:
      position: 103
      prefix: -keysize
  - id: location_size
    type:
      - 'null'
      - int
    doc: The size of the genome locations stored in the index. This can be from 
      4 to 8 bytes.
    inputBinding:
      position: 103
      prefix: -locationSize
  - id: max_alt_contig_size
    type:
      - 'null'
      - int
    doc: Specify a size at or below which all contigs are automatically marked 
      ALT, unless overridden by name using the args below
    inputBinding:
      position: 103
      prefix: -maxAltContigSize
  - id: non_alt_contig_file
    type:
      - 'null'
      - type: array
        items: File
    doc: Specify the name of a file that contains a list of contigs (one per 
      line) that will not be marked ALT regardless of size
    inputBinding:
      position: 103
      prefix: -nonAltContigFile
  - id: non_alt_contig_name
    type:
      - 'null'
      - type: array
        items: string
    doc: Specify the name of a contig that's not an alt, regardless of its size
    inputBinding:
      position: 103
      prefix: -nonAltContigName
  - id: padding_between_chromosomes
    type:
      - 'null'
      - int
    doc: Specify the number of Ns to put as padding between chromosomes.
    default: 2000
    inputBinding:
      position: 103
      prefix: -p
  - id: quiet_mode
    type:
      - 'null'
      - boolean
    doc: "Quiet mode: don't print status messages (other than the welcome message
      which is printed prior to parsing args). Error messages are still printed."
    inputBinding:
      position: 103
      prefix: -q
  - id: seed_size
    type:
      - 'null'
      - int
    doc: Seed size
    default: 24
    inputBinding:
      position: 103
      prefix: -s
  - id: space_tab_terminators
    type:
      - 'null'
      - boolean
    doc: Indicates that the space and tab characters are terminators for 
      chromosome names (see -B above). This may be used in addition to other 
      terminators specified by -B.
    inputBinding:
      position: 103
      prefix: -bSpace
  - id: super_quiet_mode
    type:
      - 'null'
      - boolean
    doc: "Super quiet mode: don't print status or error messages"
    inputBinding:
      position: 103
      prefix: -qq
  - id: threads
    type:
      - 'null'
      - int
    doc: Specify the maximum number of threads to use. Default is the number of 
      cores.
    inputBinding:
      position: 103
      prefix: -t
  - id: use_temp_file_for_memory
    type:
      - 'null'
      - boolean
    doc: Use a temp file to work better in smaller memory.
    inputBinding:
      position: 103
      prefix: -sm
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snap-aligner:2.0.5--h077b44d_2
stdout: snap-aligner_index.out
