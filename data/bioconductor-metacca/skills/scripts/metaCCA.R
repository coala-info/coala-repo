# Code example from 'metaCCA' vignette. See references/ for full tutorial.

## ----mychunk1, cache=TRUE, eval=TRUE, hide=TRUE-------------------------------
library(metaCCA)
data( package = 'metaCCA' )

## ----mychunkN, cache=TRUE, eval=TRUE, hide=TRUE-------------------------------
# Number of individuals in study 1
print( N1 )

# Number of individuals in study 2
print( N2 )

## ----mychunk2, cache=TRUE, eval=TRUE, hide=TRUE-------------------------------
# Part of the S_XY data frame for study 1

print( head(S_XY_study1[,1:6]), digits = 3 )

## ----mychunk3, cache=TRUE, eval=TRUE, hide=TRUE-------------------------------
# Part of the S_XX data frame for study 1

print( head(S_XX_study1[,1:6]), digits = 3 )

## ----mychunk4, cache=TRUE, eval=TRUE, hide=TRUE-------------------------------
# Estimating phenotypic correlation structure of study 1
S_YY_study1 = estimateSyy( S_XY = S_XY_full_study1 )

# Estimating phenotypic correlation structure of study 2
S_YY_study2 = estimateSyy( S_XY = S_XY_full_study2 )

## ----mychunk5, cache=TRUE, eval=TRUE, hide=TRUE-------------------------------
print( head(S_YY_study1[,1:6]), digits = 3 )

## ----mychunk6, cache=TRUE, eval=TRUE, hide=TRUE-------------------------------
# Default single-SNP--multi-trait meta-analysis of 2 studies

# Association analysis according to metaCCA algorithm
metaCCA_res1 = metaCcaGp( nr_studies = 2,
                          S_XY = list( S_XY_study1, S_XY_study2 ),
                          std_info = c( 0, 0 ),
                          S_YY = list( S_YY_study1, S_YY_study2 ),
                          N = c( N1, N2) )

# Association analysis according to metaCCA+ algorithm
metaCCApl_res1 = metaCcaPlusGp( nr_studies = 2,
                                S_XY = list( S_XY_study1, S_XY_study2 ),
                                std_info = c( 0, 0 ),
                                S_YY = list( S_YY_study1, S_YY_study2 ),
                                N = c( N1, N2 ) )

## ----mychunk7, cache=TRUE, eval=TRUE, hide=TRUE-------------------------------
# Result of metaCCA
print( metaCCA_res1[1:2], digits = 2 )
print( metaCCA_res1[3], digits = 1 )

## ----mychunk72, cache=TRUE, eval=TRUE, hide=TRUE------------------------------
# Result of metaCCA+
print( metaCCApl_res1[1:2], digits = 2 )
print( metaCCApl_res1[3], digits = 1 )

## ----mychunk8, cache=TRUE, eval=TRUE, hide=TRUE-------------------------------
# Single-SNP--multi-trait meta-analysis of 2 studies
# and one selected SNP

# metaCCA
metaCCA_res2 = metaCcaGp( nr_studies = 2,
                          S_XY = list( S_XY_study1, S_XY_study2 ),
                          std_info = c( 0, 0 ),
                          S_YY = list( S_YY_study1, S_YY_study2 ),
                          N = c( N1, N2 ),
                          analysis_type = 1,
                          SNP_id = 'rs80' )

# Result of metaCCA
print( metaCCA_res2, digits = 2 )

## ----mychunk9, cache=TRUE, eval=TRUE, hide=TRUE-------------------------------
# metaCCA+
metaCCApl_res2 = metaCcaPlusGp( nr_studies = 2,
                                S_XY = list( S_XY_study1, S_XY_study2 ),
                                std_info = c( 0, 0 ),
                                S_YY = list( S_YY_study1, S_YY_study2 ),
                                N = c( N1, N2 ),
                                analysis_type = 1,
                                SNP_id = 'rs80' )

# Result of metaCCA+
print( metaCCApl_res2, digits = 2 )

## ----mychunk11, cache=TRUE, eval=TRUE, hide=TRUE------------------------------
# Multi-SNP--multi-trait meta-analysis of 2 studies

# metaCCA
metaCCA_res3 = metaCcaGp( nr_studies = 2,
                          S_XY = list( S_XY_study1, S_XY_study2 ),
                          std_info = c( 0, 0 ),
                          S_YY = list( S_YY_study1, S_YY_study2 ),
                          N = c( N1, N2 ),
                          analysis_type = 2,
                          SNP_id = c( 'rs10', 'rs80', 'rs140',
                                      'rs170', 'rs172' ),
                          S_XX = list( S_XX_study1, S_XX_study2 ) )

# Result of metaCCA
print( metaCCA_res3[1:2], digits = 2 )
print( metaCCA_res3[3], digits = 2, row.names = FALSE )
print( metaCCA_res3[4], digits = 2, row.names = FALSE )

## ----mychunk12, cache=TRUE, eval=TRUE, hide=TRUE------------------------------
# metaCCA+
metaCCApl_res3 = metaCcaPlusGp( nr_studies = 2,
                                S_XY = list( S_XY_study1, S_XY_study2 ),
                                std_info = c( 0, 0 ),
                                S_YY = list( S_YY_study1, S_YY_study2 ),
                                N = c( N1, N2 ),
                                analysis_type = 2,
                                SNP_id = c( 'rs10', 'rs80', 'rs140',
                                            'rs170', 'rs172' ),
                                S_XX = list( S_XX_study1, S_XX_study2 ))

# Result of metaCCA+
print( metaCCApl_res3[1:2], digits = 2 )
print( metaCCApl_res3[3], digits = 1, row.names = FALSE )
print( metaCCApl_res3[4], digits = 1, row.names = FALSE )

## ----mychunk13, cache=TRUE, eval=TRUE, hide=TRUE------------------------------
S_XX_common = S_XX_study1

## ----mychunk14, cache=TRUE, eval=TRUE, hide=TRUE------------------------------
# metaCCA
metaCCA_res4 = metaCcaGp( nr_studies = 2,
                          S_XY = list( S_XY_study1, S_XY_study2 ),
                          std_info = c( 0, 0 ),
                          S_YY = list( S_YY_study1, S_YY_study2 ),
                          N = c( N1, N2 ),
                          analysis_type = 2,
                          SNP_id = c( 'rs10', 'rs80', 'rs140',
                                      'rs170', 'rs172' ),
                          S_XX = list( S_XX_common, S_XX_common ) )

# Result of metaCCA
print( metaCCA_res4[1:2], digits = 2 )
print( metaCCA_res4[3], digits = 2, row.names = FALSE )
print( metaCCA_res4[4], digits = 2, row.names = FALSE )

## ----mychunk15, cache=TRUE, eval=TRUE, hide=TRUE------------------------------
# metaCCA+
metaCCApl_res4 = metaCcaPlusGp( nr_studies = 2,
                                S_XY = list( S_XY_study1, S_XY_study2 ),
                                std_info = c( 0, 0 ),
                                S_YY = list( S_YY_study1, S_YY_study2 ),
                                N = c( N1, N2 ),
                                analysis_type = 2,
                                SNP_id = c( 'rs10', 'rs80', 'rs140',
                                            'rs170', 'rs172' ),
                                S_XX = list( S_XX_common, S_XX_common ))

# Result of metaCCA+
print( metaCCApl_res4[1:2], digits = 2 )
print( metaCCApl_res4[3], digits = 1, row.names = FALSE )
print( metaCCApl_res4[4], digits = 1, row.names = FALSE )

