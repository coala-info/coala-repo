cwlVersion: v1.2
class: CommandLineTool
baseCommand: translatorx
label: translatorx_translatorx.pl
doc: "TranslatorX aligns nucleotide sequences guided by their amino acid translation: it translates the sequences, aligns the proteins, and back-translates the alignment to codons.\n\nTool homepage: http://pc16141.mncn.csic.es/"
inputs:
  - id: nt_file
    type: File
    doc: the file containing the nucleotide sequences in FASTA format (Required)
    inputBinding:
      prefix: -i
  - id: output
    type:
      - 'null'
      - string
    default: translatorx_res
    doc: 'output file prefix (Optional). Default: "translatorx_res".'
    inputBinding:
      prefix: -o
  - id: aa_file
    type:
      - 'null'
      - File
    doc: file containing the amino acid sequence alignment (Optional)
    inputBinding:
      prefix: -a
  - id: program
    type:
      - 'null'
      - string
    doc: "program to build the multiple alignment (Optional). Available options are: M/C/F/P, standing for Muscle, Clustalw, Prank, and maFft. Default: Muscle"
    inputBinding:
      prefix: -p
  - id: genetic_code
    type:
      - 'null'
      - int
    doc: "genetic code to translate the sequences (Optional), as an NCBI table number (1 Standard, 2 Vertebrate Mitochondrial, 3 Yeast Mitochondrial, 4 Mold/Protozoan Mitochondrial, 5 Invertebrate Mitochondrial, 6 Ciliate Nuclear, 9 Echinoderm/Flatworm Mitochondrial, 10 Euplotid Nuclear, 11 Bacterial and Plant Plastid, and others). Default: 1 (Standard code)"
    inputBinding:
      prefix: -c
  - id: genetic_codes_file
    type:
      - 'null'
      - File
    doc: "file containing alternative genetic codes for each taxon. (Optional) File format: Taxon<TAB>genetic_code[number]"
    inputBinding:
      prefix: -j
  - id: gblocks_params
    type:
      - 'null'
      - string
    doc: 'parameters for GBlocks (Optional). Example: "-b2 x -b3 x -b4 x..."'
    inputBinding:
      prefix: -g
  - id: guess_reading_frame
    type:
      - 'null'
      - string
    doc: "F/T. Guess reading frame (Optional)[default F]"
    inputBinding:
      prefix: -t
outputs:
  - id: result_files
    type:
      type: array
      items: File
    doc: Alignments (nucleotide and amino acid), HTML report and log written with the output prefix
    outputBinding:
      glob: $(inputs.output)*
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/translatorx:1.1--pl5.22.0_0
