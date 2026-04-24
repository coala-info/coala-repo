cwlVersion: v1.2
class: Workflow
doc: >-
  A file was first uploaded. The file was parsed as a gene count matrix.
  Significantly over-expressed genes when compared to normal tissue in GTEx [1]
  were identified. IMP3 was chosen for further investigation. RNA-seq-like LINCS
  L1000 Signatures [2] which mimick or reverse the the expression of IMP3 were
  visualized. Drugs which down-regulate the expression of IMP3 were identified
  from the RNA-seq-like LINCS L1000 Chemical Perturbagens [2]. Genes which
  down-regulate the expression of IMP3 were identified from the RNA-seq-like
  LINCS L1000 CRISPR Knockouts [2]. Genes were filtered by IDG Understudied
  Proteins [3]. The gene was searched with the MetGENE tool providing pathways,
  reactions, metabolites, and studies from the Metabolomics Workbench [4]. IMP3
  was then searched in the Metabolomics Workbench [5] to identify associated
  metabolites. IMP3 was then searched in the Metabolomics Workbench [5] to
  identify relevant reactions. Regulatory elements were obtained from the Linked
  Data Hub [6]. The GlyGen database [7] was searched to identify a relevant set
  of protein products that originate from IMP3.


  1. Lonsdale, J. et al. The Genotype-Tissue Expression (GTEx) project. Nature
  Genetics vol. 45 580–585 (2013). doi:10.1038/ng.2653

  2. Evangelista, J. E. et al. SigCom LINCS: data and metadata search engine for
  a million gene expression signatures. Nucleic Acids Research vol. 50 W697–W709
  (2022). doi:10.1093/nar/gkac328

  3. IDG Understudied Proteins, https://druggablegenome.net/AboutIDGProteinList

  4. MetGENE, https://sc-cfdewebdev.sdsc.edu/MetGENE/metGene.php

  5. The Metabolomics Workbench, https://www.metabolomicsworkbench.org/

  6. Linked Data Hub, https://ldh.genome.network/cfde/ldh/

  7. York, W. S. et al. GlyGen: Computational and Informatics Resources for
  Glycoscience. Glycobiology vol. 30 72–73 (2019). doi:10.1093/glycob/cwz080
requirements: {}
inputs:
  step-1-data:
    label: Input File
    doc: Upload a Data File
    type: File
  step-4-data:
    label: Select One Gene
    doc: Select one Gene
    type: File
outputs:
  step-1-output:
    label: File URL
    doc: URL to a File
    type: File
    outputSource: step-1/output
  step-2-output:
    label: Gene Count Matrix
    doc: A gene count matrix file
    type: File
    outputSource: step-2/output
  step-3-output:
    label: Scored Genes
    doc: ZScores of Genes
    type: File
    outputSource: step-3/output
  step-4-output:
    label: Gene
    doc: Gene Term
    type: File
    outputSource: step-4/output
  step-5-output:
    label: LINCS L1000 Reverse Search Dashboard
    doc: A dashboard for performing L1000 Reverse Search queries for a given gene
    type: File
    outputSource: step-5/output
  step-6-output:
    label: Scored Drugs
    doc: ZScores of Drugs
    type: File
    outputSource: step-6/output
  step-7-output:
    label: Scored Genes
    doc: ZScores of Genes
    type: File
    outputSource: step-7/output
  step-8-output:
    label: Scored Genes
    doc: ZScores of Genes
    type: File
    outputSource: step-8/output
  step-9-output:
    label: MetGENE Summary
    doc: A dashboard for reviewing gene-centric information for a given gene from
      metabolomics
    type: File
    outputSource: step-9/output
  step-10-output:
    label: MetGENE metabolite table
    doc: MetGENE metabolite table
    type: File
    outputSource: step-10/output
  step-11-output:
    label: MetGENE Reaction Table
    doc: MetGENE Reaction Table
    type: File
    outputSource: step-11/output
  step-12-output:
    label: Regulatory Element Set
    doc: Set of Regulatory Elements
    type: File
    outputSource: step-12/output
  step-13-output:
    label: GlyGen Protein Products
    doc: Protein product records in GlyGen
    type: File
    outputSource: step-13/output
steps:
  step-1:
    run: FileInput.cwl
    label: Input File
    doc: Upload a Data File
    in:
      data:
        source: step-1-data
      outputFilename:
    out:
      - output
  step-2:
    run: GeneCountMatrixFromFile.cwl
    label: Resolve a Gene Count Matrix from a File
    doc: Ensure a file contains a gene count matrix, load it into a standard format
    in:
      inputs.file:
        label: File URL
        source: step-1/output
      outputFilename:
    out:
      - output
  step-3:
    run: TargetRangerScreenTargets[GTEx_transcriptomics].cwl
    label: Screen for Targets against GTEx
    doc: Identify significantly overexpressed genes when compared to normal tissue
      in GTEx
    in:
      inputs.input:
        label: Gene Count Matrix
        source: step-2/output
      outputFilename:
    out:
      - output
  step-4:
    run: OneScoredT[Scored[Gene]].cwl
    label: Select One Gene
    doc: Select one Gene
    in:
      data:
        source: step-4-data
      inputs.scored:
        label: Scored Genes
        source: step-3/output
      outputFilename:
    out:
      - output
  step-5:
    run: LINCSL1000ReverseSearch.cwl
    label: LINCS L1000 Reverse Search
    doc: Identify RNA-seq-like LINCS L1000 Signatures which reverse the expression
      of the gene.
    in:
      inputs.gene:
        label: Gene
        source: step-4/output
      outputFilename:
    out:
      - output
  step-6:
    run: LINCSL1000ReverseSearchExtract[Drug, Down].cwl
    label: Extract Down Regulating Perturbagens
    doc: Identify RNA-seq-like LINCS L1000 Chemical Perturbagen Signatures which
      reverse the expression of the gene.
    in:
      inputs.search:
        label: LINCS L1000 Reverse Search Dashboard
        source: step-5/output
      outputFilename:
    out:
      - output
  step-7:
    run: LINCSL1000ReverseSearchExtract[Gene, Down].cwl
    label: Extract Down Regulating CRISPR KOs
    doc: Identify RNA-seq-like LINCS L1000 CRISPR KO Signatures which reverse the
      expression of the gene.
    in:
      inputs.search:
        label: LINCS L1000 Reverse Search Dashboard
        source: step-5/output
      outputFilename:
    out:
      - output
  step-8:
    run: IDGFilter[Scored[Gene], all].cwl
    label: Filter genes by Understudied Proteins
    doc: Based on IDG understudied proteins list
    in:
      inputs.input:
        label: Scored Genes
        source: step-7/output
      outputFilename:
    out:
      - output
  step-9:
    run: MetGeneSearch.cwl
    label: MetGENE Search
    doc: Identify gene-centric information from Metabolomics.
    in:
      inputs.gene:
        label: Gene
        source: step-4/output
      outputFilename:
    out:
      - output
  step-10:
    run: MetgeneMetabolites.cwl
    label: MetGENE Metabolites
    doc: Extract Metabolomics metabolites for the gene from MetGENE
    in:
      inputs.summary:
        label: MetGENE Summary
        source: step-9/output
      outputFilename:
    out:
      - output
  step-11:
    run: MetGeneRxns.cwl
    label: MetGENE Reactions
    doc: Extract Metabolomics reactions for the gene from MetGENE
    in:
      inputs.summary:
        label: MetGENE Summary
        source: step-9/output
      outputFilename:
    out:
      - output
  step-12:
    run: GetRegulatoryElementsForGeneInfoFromGene.cwl
    label: Resolve Regulatory Elements from LDH
    doc: Resolve regulatory elements from gene with Linked Data Hub
    in:
      inputs.gene:
        label: Gene
        source: step-4/output
      outputFilename:
    out:
      - output
  step-13:
    run: GlyGenProteinInformation.cwl
    label: Search GlyGen for Protein Products
    doc: Find protein product records in GlyGen for the gene
    in:
      inputs.gene:
        label: Gene
        source: step-4/output
      outputFilename:
    out:
      - output
