# Code example from 'CoRegNet' vignette. See references/ for full tutorial.

## ---- eval=FALSE---------------------------------------------------------
#          library(CoRegNet)
#          data(CIT_BLCA_EXP,HumanTF,CIT_BLCA_Subgroup)
#          dim(CIT_BLCA_EXP)
#          #showing 6 first TF in the gene expression dataset
#          head(intersect(rownames(CIT_BLCA_EXP),HumanTF))

## ---- eval=FALSE---------------------------------------------------------
#  	grn = hLICORN(CIT_BLCA_EXP, TFlist=HumanTF)

## ---- eval=FALSE---------------------------------------------------------
#  	influence = regulatorInfluence(grn,CIT_BLCA_EXP)

## ---- eval=FALSE---------------------------------------------------------
#  	coregs= coregulators(grn)

## ---- eval=FALSE---------------------------------------------------------
#  	display(grn,CIT_BLCA_EXP,influence,clinicalData=CIT_BLCA_Subgroup)

## ---- eval=FALSE---------------------------------------------------------
#      # An example of how to infer a co-regulation network
#      grn =hLICORN(CIT_BLCA_EXP, TFlist=HumanTF)
#      print(grn)

## ---- eval=FALSE---------------------------------------------------------
#      #Default discretization.
#      #Uses the standard deviation of the whole dataset to set a threshold.
#      disc1=discretizeExpressionData(CIT_BLCA_EXP)
#      table(disc1)
#      boxplot(as.matrix(CIT_BLCA_EXP)~disc1)
#  
#      #Discretization with a hard threshold
#      disc2=discretizeExpressionData(CIT_BLCA_EXP, threshold=1)
#      table(disc2)
#      boxplot(as.matrix(CIT_BLCA_EXP)~disc2)
#  
#      # more examples here
#      help(discretizeExpressionData)

## ---- eval=FALSE---------------------------------------------------------
#  # running only on the 200 first gene in the matrix for fast analysis
#      # Choosing to divide in 4 threads whenever possible
#      options("mc.cores"=4)
#      grn =hLICORN(head(CIT_BLCA_EXP,200), TFlist=HumanTF)
#      print(grn)
#      options("mc.cores"=2)
#      grn =hLICORN(head(CIT_BLCA_EXP,200), TFlist=HumanTF)
#      print(grn)

## ---- eval=FALSE---------------------------------------------------------
#      # ChIP data from the CHEA database
#      data(CHEA_sub)
#  
#      #ChIP data from the ENCODE project
#      data(ENCODE_sub)
#  
#      # Protein protein interactions between TF from the HIPPIE database
#      data(HIPPIE_sub)
#  
#      # Protein protein interactions between TF from the STRING database
#      data(STRING_sub)
#  
#      enrichedGRN = addEvidences(grn,CHEA_sub,ENCODE_sub)
#      enrichedGRN = addCooperativeEvidences(enrichedGRN,HIPPIE_sub,STRING_sub)

## ---- eval=FALSE---------------------------------------------------------
#      print(enrichedGRN)

## ---- eval=FALSE---------------------------------------------------------
#          # Default unsupervised refinement method
#      refinedGRN = refine(enrichedGRN)
#      print(refinedGRN)
#      # Example of supervised refinement with the CHEA chip data
#      refinedGRN = refine(enrichedGRN, integration="supervised",
#              referenceEvidence="CHEA_sub")
#      print(refinedGRN)

## ---- eval=FALSE---------------------------------------------------------
#      CITinf =regulatorInfluence(grn,CIT_BLCA_EXP)
#  

## ---- eval=FALSE---------------------------------------------------------
#      # Coregulators of a hLICORN  inferred network
#      head(coregulators(grn))

## ---- eval=FALSE---------------------------------------------------------
#      data(CIT_BLCA_CNV)
#      data(CIT_BLCA_Subgroup)

## ---- eval=FALSE---------------------------------------------------------
#      display(grn,expressionData=CIT_BLCA_EXP,TFA=CITinf)

## ---- eval=FALSE---------------------------------------------------------
#      # Visualizing additional regulatory or co-regulatory evidences in the network
#      display(enrichedGRN,expressionData=CIT_BLCA_EXP,TFA=CITinf)
#  
#  
#      # Visualizing sample classification using a named factor
#      display(grn,expressionData=CIT_BLCA_EXP,TFA=CITinf,clinicalData=CIT_BLCA_Subgroup)
#  
#      # Visualizing copy number alteration of regulators
#      data(CIT_BLCA_CNV)
#      display(grn,expressionData=CIT_BLCA_EXP,TFA=CITinf,clinicalData=CIT_BLCA_Subgroup,alterationData=CIT_BLCA_CNV)
#  

