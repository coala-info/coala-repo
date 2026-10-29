cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - assembly.py
  - impute_from_reference
label: viral-ngs_assembly_impute_from_reference
doc: "This takes a de novo assembly, aligns against a reference genome, and imputes all missing positions (plus some of the chromosome ends) with the reference genome. This provides an assembly with the proper structure (but potentially wrong sequences in areas) from which we can perform further read-based refinement. Two steps: filter_short_seqs: We then toss out all assemblies that come out to < 15kb or < 95% unambiguous and fail otherwise. modify_contig: Finally, we trim off anything at the end that exceeds the length of the known reference assembly. We also replace all Ns and everything within 55bp of the chromosome ends with the reference sequence. This is clearly incorrect consensus sequence, but it allows downstream steps to map reads in parts of the genome that would otherwise be Ns, and we will correct all of the inferred positions with two steps of read-based refinement (below), and revert positions back to Ns where read support is lacking. FASTA indexing: output assembly is indexed for Picard, Samtools, Novoalign.\n\nTool homepage: https://github.com/broadinstitute/viral-ngs"
inputs:
  - id: in_fasta
    type: File
    doc: "Input assembly/contigs, FASTA format, already ordered, oriented and merged with inReference."
    inputBinding:
      position: 1
  - id: in_reference
    type: File
    doc: "Reference genome to impute with, FASTA format."
    inputBinding:
      position: 2
  - id: out_fasta
    type: string
    doc: "Output assembly, FASTA format."
    inputBinding:
      position: 3
  - id: new_name
    type:
      - 'null'
      - string
    doc: "rename output chromosome (default: do not rename)"
    inputBinding:
      position: 20
      prefix: --newName
  - id: min_length_fraction
    type:
      - 'null'
      - float
    doc: "minimum length for contig, as fraction of reference (default: 0.5)"
    inputBinding:
      position: 20
      prefix: --minLengthFraction
  - id: min_unambig
    type:
      - 'null'
      - float
    doc: "minimum percentage unambiguous bases for contig (default: 0.5)"
    inputBinding:
      position: 20
      prefix: --minUnambig
  - id: replace_length
    type:
      - 'null'
      - int
    doc: "length of ends to be replaced with reference (default: 0)"
    inputBinding:
      position: 20
      prefix: --replaceLength
  - id: aligner
    type:
      - 'null'
      - type: enum
        symbols:
          - muscle
          - mafft
          - mummer
    doc: "which method to use to align inFasta to inReference. \"muscle\" = MUSCLE, \"mafft\" = MAFFT, \"mummer\" = nucmer. [default: muscle]"
    inputBinding:
      position: 20
      prefix: --aligner
  - id: index
    type:
      - 'null'
      - boolean
    doc: "Index outFasta for Picard/GATK, Samtools, and Novoalign."
    inputBinding:
      position: 20
      prefix: --index
  - id: novoalign_license_path
    type:
      - 'null'
      - string
    doc: "A path to the novoalign.lic file. This overrides the NOVOALIGN_LICENSE_PATH environment variable. (default: None)"
    inputBinding:
      position: 20
      prefix: --NOVOALIGN_LICENSE_PATH
  - id: loglevel
    type:
      - 'null'
      - type: enum
        symbols:
          - DEBUG
          - INFO
          - WARNING
          - ERROR
          - CRITICAL
          - EXCEPTION
    doc: "Verboseness of output. [default: DEBUG]"
    inputBinding:
      position: 20
      prefix: --loglevel
  - id: tmp_dir
    type:
      - 'null'
      - string
    doc: "Base directory for temp files. [default: /tmp]"
    inputBinding:
      position: 20
      prefix: --tmp_dir
  - id: tmp_dir_keep
    type:
      - 'null'
      - boolean
    doc: "Keep the tmp_dir if an exception occurs while running. Default is to delete all temp files at the end, even if there's a failure."
    inputBinding:
      position: 20
      prefix: --tmp_dirKeep
outputs:
  - id: out_fasta_file
    type: File
    doc: "Output file written to out_fasta"
    outputBinding:
      glob: $(inputs.out_fasta)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
