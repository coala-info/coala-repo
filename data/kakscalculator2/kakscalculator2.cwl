cwlVersion: v1.2
class: CommandLineTool
baseCommand: KaKs_Calculator
label: kakscalculator2
doc: "KaKs_Calculator adopts model selection and model averaging to calculate nonsynonymous
  (Ka) and synonymous (Ks) substitution rates.\n\nTool homepage: https://github.com/kullrich/kakscalculator2"
inputs:
  - id: genetic_code
    type:
      - 'null'
      - int
    doc: 'Genetic code table (default 1: Standard Code; 2: Vertebrate Mitochondrial, 3: Yeast Mitochondrial, 4: Mold Mitochondrial, 5: Invertebrate Mitochondrial, 6: Ciliate, Dasycladacean and Hexamita, 9: Echinoderm and Flatworm Mitochondrial, 10: Euplotid Nuclear, 11: Bacterial and Plant Plastid, 12: Alternative Yeast Nuclear, 13: Ascidian Mitochondrial, 14: Alternative Flatworm Mitochondrial, 15: Blepharisma Nuclear, 16: Chlorophycean Mitochondrial, 21: Trematode Mitochondrial, 22: Scenedesmus obliquus mitochondrial, 23: Thraustochytrium Mitochondrial)'
    inputBinding:
      position: 101
      prefix: -c
  - id: input_file
    type: File
    doc: Axt file name for calculating Ka & Ks.
    inputBinding:
      position: 101
      prefix: -i
  - id: method
    type:
      - 'null'
      - string
    doc: 'Methods for estimating Ka and Ks (default MA): NG, LWL, LPB, MLWL, MLPB, GY, YN, MYN,
      MS (model selection according to the AICc), MA (model averaging), GNG, GLWL, GLPB, GMLWL, GMLPB, GYN, GMYN'
    inputBinding:
      position: 101
      prefix: -m
  - id: output_file_path
    type: string
    doc: Output file name for saving results.
    inputBinding:
      position: 101
      prefix: -o
outputs:
  - id: output_file
    type: File
    doc: Results table (Ka, Ks, Ka/Ks and more)
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kakscalculator2:2.0.1--h9948957_6
