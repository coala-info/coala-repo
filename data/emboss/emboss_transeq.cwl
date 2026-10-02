cwlVersion: v1.2
class: CommandLineTool
baseCommand: transeq
label: emboss_transeq
doc: Translate nucleic acid sequences
inputs:
  - id: sequence
    type: File
    doc: Nucleotide sequence(s) filename and optional format, or reference 
      (input USA)
    inputBinding:
      position: 101
      prefix: -sequence
  - id: outseq
    type: string
    doc: Protein sequence set(s) filename and optional format (output USA)
    inputBinding:
      position: 101
      prefix: -outseq
  - id: frame
    type:
      - 'null'
      - string
    doc: 'Frame(s) to translate (Values: 1 (1); 2 (2); 3 (3); F (Forward three frames);
      -1 (-1); -2 (-2); -3 (-3); R (Reverse three frames); 6 (All six frames))'
    inputBinding:
      position: 101
      prefix: -frame=
      separate: false
  - id: table
    type:
      - 'null'
      - string
    doc: 'Code to use (Values: 0 (Standard); 1 (Standard (with alternative initiation
      codons)); 2 (Vertebrate Mitochondrial); 3 (Yeast Mitochondrial); 4 (Mold, Protozoan,
      Coelenterate Mitochondrial and Mycoplasma/Spiroplasma); 5 (Invertebrate Mitochondrial);
      6 (Ciliate Macronuclear and Dasycladacean); 9 (Echinoderm Mitochondrial); 10
      (Euplotid Nuclear); 11 (Bacterial); 12 (Alternative Yeast Nuclear); 13 (Ascidian
      Mitochondrial); 14 (Flatworm Mitochondrial); 15 (Blepharisma Macronuclear);
      16 (Chlorophycean Mitochondrial); 21 (Trematode Mitochondrial); 22 (Scenedesmus
      obliquus); 23 (Thraustochytrium Mitochondrial))'
    inputBinding:
      position: 101
      prefix: -table
  - id: regions
    type:
      - 'null'
      - string
    doc: Regions to translate. If this is left blank, then the complete sequence
      is translated. A set of regions is specified by a set of pairs of 
      positions.
    inputBinding:
      position: 101
      prefix: -regions
  - id: trim
    type:
      - 'null'
      - boolean
    doc: This removes all 'X' and '*' characters from the right end of the 
      translation.
    inputBinding:
      position: 101
      prefix: -trim
  - id: clean
    type:
      - 'null'
      - boolean
    doc: This changes all STOP codon positions from the '*' character to 'X' (an
      unknown residue).
    inputBinding:
      position: 101
      prefix: -clean
  - id: alternative
    type:
      - 'null'
      - boolean
    doc: The default definition of frame '-1' is the reverse-complement of the 
      set of codons used in frame 1. If you prefer to define frame '-1' as using
      the set of codons starting with the last codon of the sequence, then set 
      this to be true.
    inputBinding:
      position: 101
      prefix: -alternative
  - id: nomethionine
    type:
      - 'null'
      - boolean
    doc: START codons at the beginning of protein products will usually code for
      Methionine, despite what the codon will code for when it is internal to a 
      protein. This qualifier sets all such START codons to code for Methionine 
      by default (use -nomethionine to turn off).
    inputBinding:
      position: 101
      prefix: -nomethionine
outputs:
  - id: output_outseq
    type: File
    doc: Protein sequence set(s) filename and optional format (output USA)
    outputBinding:
      glob: $(inputs.outseq)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/emboss:6.6.0--h0f19ade_14
s:url: http://emboss.open-bio.org/
$namespaces:
  s: https://schema.org/
