cwlVersion: v1.2
class: CommandLineTool
baseCommand: AnnoSINE_v2
label: annosine2_AnnoSINE_v2
doc: "SINE Annotation Tool for Plant Genomes\n\nTool homepage: https://github.com/liaoherui/AnnoSINE"
inputs:
  - id: mode
    type: string
    doc: "Choose the running mode of the program.\n                        \t1--Homology-based
      method;\n                        \t2--Structure-based method;\n            \
      \            \t3--Hybrid of homology-based and structure-based method."
    inputBinding:
      position: 1
  - id: input_filename
    type: File
    doc: input genome assembly path
    inputBinding:
      position: 2
  - id: output_filename
    type: Directory
    doc: output files path
    inputBinding:
      position: 3
  - id: animal
    type:
      - 'null'
      - int
    doc: If set to 1, then Hmmer will search SINE using the animal hmm files 
      from Dfam. If set to 2, then Hmmer will search SINE using both the plant 
      and animal hmm files.
    inputBinding:
      position: 104
      prefix: --animal
  - id: automatically_continue
    type:
      - 'null'
      - int
    doc: If set to 1, then the program will skip finished steps and continue 
      unifinished steps for a previously processed output dir.
    inputBinding:
      position: 104
      prefix: --automatically_continue
  - id: blast_evalue
    type:
      - 'null'
      - float
    doc: Expectation value threshold for sequences alignment search
    inputBinding:
      position: 104
      prefix: --blast_evalue
  - id: boundary
    type:
      - 'null'
      - string
    doc: Output SINE seed boundaries based on TSD or MSA
    inputBinding:
      position: 104
      prefix: --boundary
  - id: copy_number
    type:
      - 'null'
      - int
    doc: Minimum threshold of the copy number for each element
    inputBinding:
      position: 104
      prefix: --copy_number
  - id: copy_number_factor
    type:
      - 'null'
      - float
    doc: Threshold of the copy number that determines the SINE boundary
    inputBinding:
      position: 104
      prefix: --copy_number_factor
  - id: figure
    type:
      - 'null'
      - string
    doc: Output the SINE seed MSA figures and copy number profiles (y/n). Please
      note that this step may take a long time to process.
    inputBinding:
      position: 104
      prefix: --figure
  - id: gap
    type:
      - 'null'
      - int
    doc: Maximum threshold of the truncated gap
    inputBinding:
      position: 104
      prefix: --gap
  - id: hmmer_evalue
    type:
      - 'null'
      - float
    doc: Expectation value threshold for saving hits of homology search
    inputBinding:
      position: 104
      prefix: --hmmer_evalue
  - id: irf_path
    type:
      - 'null'
      - string
    doc: Path to the irf program
    inputBinding:
      position: 104
      prefix: --irf_path
  - id: length_factor
    type:
      - 'null'
      - float
    doc: Threshold of the local alignment length relative to the the BLAST query
      length
    inputBinding:
      position: 104
      prefix: --length_factor
  - id: non_redundant
    type:
      - 'null'
      - string
    doc: Annotate SINE in the whole genome based on the non-redundant library 
      (y/n)
    inputBinding:
      position: 104
      prefix: --non_redundant
  - id: num_alignments
    type:
      - 'null'
      - int
    doc: --num_alignments value for blast alignments
    inputBinding:
      position: 104
      prefix: --num_alignments
  - id: repeatmasker_enable
    type:
      - 'null'
      - int
    doc: If set to 0, then will not run RepearMasker (Step 8 for the code).
    inputBinding:
      position: 104
      prefix: --RepeatMasker_enable
  - id: shift
    type:
      - 'null'
      - int
    doc: Maximum threshold of the boundary shift
    inputBinding:
      position: 104
      prefix: --shift
  - id: temp_dir
    type:
      - 'null'
      - Directory
    doc: The temp dir used by paf2blast6 script. If not set, will use /tmp 
      folder automatically.
    inputBinding:
      position: 104
      prefix: --temp_dir
  - id: threads
    type:
      - 'null'
      - int
    doc: Threads for each tool in AnnoSINE
    inputBinding:
      position: 104
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/annosine2:2.0.9--pyh7e72e81_0
stdout: annosine2_AnnoSINE_v2.out
