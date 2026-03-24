cwlVersion: v1.2
class: Workflow

requirements:
  - class: MultipleInputFeatureRequirement
  - class: ResourceRequirement
    coresMin: 20
    ramMin: 81920

inputs:
  cores: int
  outputMzML: Directory
  outputDB: Directory
  outputPSM: Directory
  outputPSMStats: Directory
  outputQuant: Directory
  outputProt: Directory
  outputAlignment: Directory
  outputAlignmentQuant: Directory
  outputAlignmentStats: Directory
  outputProtDeduced: Directory
  outputQuantAndProt: Directory
  outputLabeledProt: Directory
  inputMzML: Directory
  inputPeptideDB: File
  paramsMzML: File
  paramsDB: File
  paramsPSM: File
  paramsPSMStats: File
  paramsPSMBasedQuant: File
  paramsAlignmentBasedQuant: File
  paramsAlignmentBasedQuantStats: File
  paramsProt: File
  paramsLabeledProteinQuant: File

steps:
  MzMLToMzlite:
    run: ./proteomiqon-mzmltomzlite.cwl
    in:
      inputDirectory: inputMzML
      params: paramsMzML
      outputDirectory: outputMzML
      parallelismLevel: cores
    out: [dir]
  PeptideDB:
    run: ./proteomiqon-peptidedb.cwl
    in:
      inputFile: inputPeptideDB
      params: paramsDB
      outputDirectory: outputDB
    out: [db, dbFolder]
  PeptideSpectrumMatching:
    run: ./proteomiqon-peptidespectrummatching.cwl
    in:
      inputDirectory: MzMLToMzlite/dir
      database: PeptideDB/db
      params: paramsPSM
      outputDirectory: outputPSM
      parallelismLevel: cores
    out: [dir]
  PSMStatistics:
    run: ./proteomiqon-psmstatistics.cwl
    in:
      inputDirectory: PeptideSpectrumMatching/dir
      database: PeptideDB/db
      params: paramsPSMStats
      outputDirectory: outputPSMStats
      parallelismLevel: cores
    out: [dir]
  PSMBasedQuantification:
    run: ./proteomiqon-psmbasedquantification.cwl
    in:
      inputDirectoryI: MzMLToMzlite/dir
      inputDirectoryII: PSMStatistics/dir
      database: PeptideDB/db
      params: paramsPSMBasedQuant
      outputDirectory: outputQuant
      parallelismLevel: cores
    out: [dir]
  ProteinInference:
    run: ./proteomiqon-proteininference.cwl
    in:
      inputDirectory: PSMStatistics/dir
      database: PeptideDB/db
      params: paramsProt
      outputDirectory: outputProt
    out: [dir]
  QuantBasedAlignment:
    run: ./proteomiqon-quantbasedalignment.cwl
    in:
      inputTargets: PSMBasedQuantification/dir
      inputSources: PSMBasedQuantification/dir
      outputDirectory: outputAlignment
      parallelismLevel: cores
    out: [dir]
  AlignmentBasedQuantification:
    run: ./proteomiqon-alignmentbasedquantification.cwl
    in:
      instrumentOutput: MzMLToMzlite/dir
      alignedPeptides: QuantBasedAlignment/dir
      alignmentMetrics: QuantBasedAlignment/dir
      quantifiedPeptides: PSMBasedQuantification/dir
      database: PeptideDB/db
      outputDirectory: outputAlignmentQuant
      params: paramsAlignmentBasedQuant
      parallelismLevel: cores
    out: [dir]
  AlignmentBasedQuantStatistics:
    run: ./proteomiqon-alignmentbasedquantstatistics.cwl
    in:
      quantDirectory: PSMBasedQuantification/dir
      alignmentDirectory: QuantBasedAlignment/dir
      alignedQuantDirectory: AlignmentBasedQuantification/dir
      quantLearnDirectory: PSMBasedQuantification/dir
      alignmentLearnDirectory: QuantBasedAlignment/dir
      alignedQuantLearnDirectory: AlignmentBasedQuantification/dir
      outputDirectory: outputAlignmentStats
      params: paramsAlignmentBasedQuantStats
    out: [dir]
  AddDeducedPeptides:
    run: ./proteomiqon-adddeducedpeptides.cwl
    in:
      quantDirectory: AlignmentBasedQuantification/dir
      proteinDirectory: ProteinInference/dir
      outputDirectory: outputProtDeduced
    out: [dir]
  JoinQuantPepIonsWithProteins:
    run: ./proteomiqon-joinquantpepionswithproteins.cwl
    in:
      inputDirectoryQuant: AlignmentBasedQuantStatistics/dir
      inputDirectoryProt: AddDeducedPeptides/dir
      outputDirectory: outputQuantAndProt
      parallelismLevel: cores
    out: [dir]
  LabeledProteinQuantification:
    run: ./proteomiqon-labeledproteinquantification.cwl
    in:
      quantAndProtDirectory: JoinQuantPepIonsWithProteins/dir
      outputDirectory: outputLabeledProt
      params: paramsLabeledProteinQuant
    out: [dir]

outputs:
  db:
    type: Directory
    outputSource: PeptideDB/dbFolder
  mzml:
    type: Directory
    outputSource: MzMLToMzlite/dir
  psm:
    type: Directory
    outputSource: PeptideSpectrumMatching/dir
  psmstats:
    type: Directory
    outputSource: PSMStatistics/dir
  quant:
    type: Directory
    outputSource: PSMBasedQuantification/dir
  prot:
    type: Directory
    outputSource: ProteinInference/dir
  alignment:
    type: Directory
    outputSource: QuantBasedAlignment/dir
  alignmentQuant:
    type: Directory
    outputSource: AlignmentBasedQuantification/dir
  alignmentStats:
    type: Directory
    outputSource: AlignmentBasedQuantStatistics/dir
  protDeduced:
    type: Directory
    outputSource: AddDeducedPeptides/dir
  quantAndProt:
    type: Directory
    outputSource: JoinQuantPepIonsWithProteins/dir
  labeledProteins:
    type: Directory
    outputSource: LabeledProteinQuantification/dir