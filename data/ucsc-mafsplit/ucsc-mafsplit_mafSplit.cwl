cwlVersion: v1.2
class: CommandLineTool
baseCommand: mafSplit
label: ucsc-mafsplit_mafSplit
doc: "Split multiple alignment files\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: splits_bed
    type: File
    doc: BED file specifying splits
    inputBinding:
      position: 1
  - id: out_root
    type: string
    doc: Root name for output files
    inputBinding:
      position: 2
  - id: input_maf_files
    type:
      type: array
      items: File
    doc: Input MAF file(s)
    inputBinding:
      position: 3
  - id: by_target
    type:
      - 'null'
      - boolean
    doc: Make one file per target sequence. (splits.bed input is ignored).
    inputBinding:
      position: 104
      prefix: -byTarget
  - id: out_dir_depth
    type:
      - 'null'
      - int
    doc: For use only with -byTarget. Create N levels of output directory under 
      current dir. This helps prevent NFS problems with a large number of file 
      in a directory. Using -outDirDepth=3 would produce ./1/2/3/outRoot123.maf.
    inputBinding:
      position: 104
      prefix: -outDirDepth
  - id: use_full_sequence_name
    type:
      - 'null'
      - boolean
    doc: For use only with -byTarget. Instead of auto-incrementing an integer to
      determine output filename, use the target sequence name to tack onto 
      outRoot.
    inputBinding:
      position: 104
      prefix: -useFullSequenceName
  - id: use_hashed_name
    type:
      - 'null'
      - int
    doc: 'For use only with -byTarget. Instead of auto-incrementing an integer or
      requiring a unique number in the sequence name, use a hash function on the sequence
      name to compute an N-bit number. This limits the max #filenames to 2^N and ensures
      that even if different subsets of sequences appear in different pairwise mafs,
      the split file names will be consistent (due to hash function). This option
      is useful when a "scaffold-based" assembly has more than one sequence name pattern,
      e.g. both chroms and scaffolds.'
    inputBinding:
      position: 104
      prefix: -useHashedName
  - id: use_sequence_name
    type:
      - 'null'
      - boolean
    doc: For use only with -byTarget. Instead of auto-incrementing an integer to
      determine output filename, expect each target sequence name to end with a 
      unique number and use that number as the integer to tack onto outRoot.
    inputBinding:
      position: 104
      prefix: -useSequenceName
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-mafsplit:482--h0b57e2e_0
stdout: ucsc-mafsplit_mafSplit.out
