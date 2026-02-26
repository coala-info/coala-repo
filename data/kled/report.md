# kled CWL Generation Report

## kled

### Tool Description
kled [Options] Bam1 [Bam2] [Bam3] ...

### Metadata
- **Docker Image**: quay.io/biocontainers/kled:1.2.10--h4f462e4_0
- **Homepage**: https://github.com/CoREse/kled
- **Package**: https://anaconda.org/channels/bioconda/packages/kled/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/kled/overview
- **Total Downloads**: 615
- **Last updated**: 2025-08-08
- **GitHub**: https://github.com/CoREse/kled
- **Stars**: N/A
### Original Help Text
```text
kled [Options] Bam1 [Bam2] [Bam3] ...
Options:
  -R FileName, --Ref=FileName     Indicate Reference Fasta File(required)
  -C ContigName                   Only call variants in Contig(s), can occur multiple times
  -S SampleName                   Sample name, if not given, kled will try to get it from the first bam file ("*").
  -t Number, --threads=Number     Number of threads. (8).
  -V , --verbosity=               Set the logging verbosity, <=0: info, 1: verbose, >=2: debug. (0).
  -h, --help                      Show this help and exit. (false).
  -v, --version                   Show version and exit. (false).
  --BC                            Calling contig by contig, cost less memory. (false).
  --CCS                           Use default parameters for CCS data (will overwrite previous cluster and filter parameters). (false).
  --CLR                           Use default parameters for CLR data (will overwrite previous cluster and filter parameters). (false).
  --DelClusterParas=Fixed,Rati
  o,MinLengthEndurance,LengthR
  atio[,NearRange,LengthDiff,L
  engthRatio2]                    Custom clustering parameters for deletions, if later 3 not given or NearRange=-1 use single layer clustering. Value * for defaults. ("").
  --DelClusterFixed=FixedDista
  nce                             Fixed distance clustering parameter for deletions. (50).
  --DelClusterRatio=DistanceRa
  tio                             Distance ratio clustering parameter for deletions. (1.500000).
  --DelClusterMinLengthEduranc
  e=MinLengthEndurance            Min length endurance clustering parameter for deletions. (10).
  --DelClusterLengthRatio=Lent
  hRatio                          Length ratio clustering parameter for deletions. (0.300000).
  --DelClusterNearRange=NearRa
  nge                             Near range clustering parameter for deletions. (-1).
  --DelClusterFixed2=FixedDist
  ance                            Fixed distance 2 clustering parameter for deletions. (10).
  --DelClusterLengthRatio2=Len
  thRatio                         Length ratio 2 clustering parameter for deletions. (0.500000).
  --InsClusterParas=Fixed,Rati
  o,MinLengthEndurance,LengthR
  atio[,NearRange,LengthDiff,L
  engthRatio2]                    Custom clustering parameters for insertions, if later 3 not given or NearRange=-1 use single layer clustering. Value * for defaults. ("").
  --InsClusterFixed=FixedDista
  nce                             Fixed distance clustering parameter for insertions. (150).
  --InsClusterRatio=DistanceRa
  tio                             Distance ratio clustering parameter for insertions. (0.500000).
  --InsClusterMinLengthEduranc
  e=MinLengthEndurance            Min length endurance clustering parameter for insertions. (20).
  --InsClusterLengthRatio=Lent
  hRatio                          Length ratio clustering parameter for insertions. (0.100000).
  --InsClusterNearRange=NearRa
  nge                             Near range clustering parameter for insertions. (-1).
  --InsClusterFixed2=FixedDist
  ance                            Fixed distance 2 clustering parameter for insertions. (50).
  --InsClusterLengthRatio2=Len
  thRatio                         Length ratio 2 clustering parameter for insertions. (0.300000).
  --DupClusterParas=Fixed,Rati
  o,MinLengthEndurance,LengthR
  atio[,NearRange,LengthDiff,L
  engthRatio2]                    Custom clustering parameters for duplications, if later 3 not given or NearRange=-1 use single layer clustering. Value * for defaults. ("").
  --DupClusterFixed=FixedDista
  nce                             Fixed distance clustering parameter for duplications. (0).
  --DupClusterRatio=DistanceRa
  tio                             Distance ratio clustering parameter for duplications. (0.200000).
  --DupClusterMinLengthEduranc
  e=MinLengthEndurance            Min length endurance clustering parameter for duplications. (0).
  --DupClusterLengthRatio=Lent
  hRatio                          Length ratio clustering parameter for duplications. (0.100000).
  --DupClusterNearRange=NearRa
  nge                             Near range clustering parameter for duplications. (-1).
  --DupClusterFixed2=FixedDist
  ance                            Fixed distance 2 clustering parameter for duplications. (500).
  --DupClusterLengthRatio2=Len
  thRatio                         Length ratio 2 clustering parameter for duplications. (0.100000).
  --InvClusterParas=Fixed,Rati
  o,MinLengthEndurance,LengthR
  atio[,NearRange,LengthDiff,L
  engthRatio2]                    Custom clustering parameters for inversions, if later 3 not given or NearRange=-1 use single layer clustering. Value * for defaults. ("").
  --InvClusterFixed=FixedDista
  nce                             Fixed distance clustering parameter for inversions. (100).
  --InvClusterRatio=DistanceRa
  tio                             Distance ratio clustering parameter for inversions. (0.100000).
  --InvClusterMinLengthEduranc
  e=MinLengthEndurance            Min length endurance clustering parameter for inversions. (0).
  --InvClusterLengthRatio=Lent
  hRatio                          Length ratio clustering parameter for inversions. (0.100000).
  --InvClusterNearRange=NearRa
  nge                             Near range clustering parameter for inversions. (-1).
  --InvClusterFixed2=FixedDist
  ance                            Fixed distance 2 clustering parameter for inversions. (100).
  --InvClusterLengthRatio2=Len
  thRatio                         Length ratio 2 clustering parameter for inversions. (0.500000).
  --DelFilterParas=Base1,Ratio
  1,SDScore1,Base2,Ratio2,SDSc
  ore2                            Custom filter parameters for deletions. Value * for defaults. ("").
  --InsFilterParas=Base1,Ratio
  1,SDScore1,Base2,Ratio2,SDSc
  ore2                            Custom filter parameters for insertions. Value * for defaults. ("").
  --DupFilterParas=Base1,Ratio
  1,SDScore1,Base2,Ratio2,SDSc
  ore2                            Custom filter parameters for duplications. Value * for defaults. ("").
  --InvFilterParas=Base1,Ratio
  1,SDScore1,Base2,Ratio2,SDSc
  ore2                            Custom filter parameters for inversions. Value * for defaults. ("").
  --NOF                           No filter, output all results. (false).
  --F2                            Output all results with ST>=2. (false).
  -m SVLEN                        Minimum SV length. (30).
  -q Quality                      Minimum mapping quality. (20).
  -l Length                       Minimum template length. (500).
  -d Distance                     Minimum max merge distance of signature merging during CIGAR signature collection for simple merge. (500).
  -D Distance                     Maximum max merge distance of signature merging during CIGAR signature collection for simple merge. (50000).
  -p Portion                      Max merge portion of signature merging during CIGAR signature collection for simple merge. (0.200000).
  -c Size                         Coverage window size. (100).
  -M Size                         Max cluster size, will resize to this value if a cluster is larger than this. (1000).
  --InsClipTolerance=Size         Insertion clip signature distance tolerance. (10).
  --InsMaxGapSize=Size            Insertion clip signature max gap size. (50000).
  --ClusteringBatchSize=Size      Batch size of multihreading when clustering. (10000).
  --CigarMerge=MergeType          CigarMergeType, 0 for Omni.B, 1 for simple, 2 for simple regional. (0).
  --OMaxE=Size                    Max edges(depth) for omni.b merge. This will grow complexity exponentially. (8).
  --OCountLimit=Size              Relevant alignments count limit for omni.b merge. (20).
  --OScoreBRatio=Ratio            ScoreB ratio for omni.b merge. (0.100000).
  --OmniA=ValueA                  A for omni.b merge. (800).
  --OmniB=ValueB                  B for omni.b merge. (800).
  --DelMinPosSTD=STD              Filter out clusters that have position stds > MinPosSTD, -1: don't filter. (-1).
  --InsMinPosSTD=STD              Filter out clusters that have position stds > MinPosSTD, -1: don't filter. (-1).
  --DupMinPosSTD=STD              Filter out clusters that have position stds > MinPosSTD, -1: don't filter. (-1).
  --InvMinPosSTD=STD              Filter out clusters that have position stds > MinPosSTD, -1: don't filter. (-1).
  --PSTD                          Always calculate Pos STD. (false).
  --FID                           Filter out insertions within duplication range that have large PSTD when number of duplication/number of insertion is large(>1/20). Implicates --PSTD. (true).
  --DelHPR=Ratio                  HPRatio for deletions (0.800000).
  --DelHomoR=Ratio                HomoRatio for deletions. (0.800000).
  --DelHomoM=Ratio                Homo Minus for deletions. (0.000000).
  --DelHomoMR=Ratio               Homo Minus Ratio for deletions. (0.200000).
  --DelNonHomoM=Ratio             Non Homo Minus for deletions. (0.000000).
  --DelNonHomoMR=Ratio            Non Homo Minus Ratio for deletions. (-0.050000).
  --DelLowHPP=Ratio               Low HP Plus for deletions. (0.000000).
  --DelLowHPPR=Ratio              Low HP Plus Ratio for deletions. (0.250000).
  --InsHPR=Ratio                  HPRatio for insertions (0.700000).
  --InsHomoR=Ratio                HomoRatio for insertions. (0.750000).
  --InsHomoM=Ratio                Homo Minus for insertions. (0.050000).
  --InsHomoMR=Ratio               Homo Minus Ratio for insertions. (0.250000).
  --InsNonHomoM=Ratio             Non Homo Minus for insertions. (0.000000).
  --InsNonHomoMR=Ratio            Non Homo Minus Ratio for insertions. (0.300000).
  --InsLowHPP=Ratio               Low HP Plus for insertions. (0.000000).
  --InsLowHPPR=Ratio              Low HP Plus Ratio for insertions. (0.250000).
  --DupHPR=Ratio                  HPRatio for duplications (0.200000).
  --DupHomoR=Ratio                HomoRatio for duplications. (0.900000).
  --DupHomoM=Ratio                Homo Minus for duplications. (0.000000).
  --DupHomoMR=Ratio               Homo Minus Ratio for duplications. (0.600000).
  --DupNonHomoM=Ratio             Non Homo Minus for duplications. (0.000000).
  --DupNonHomoMR=Ratio            Non Homo Minus Ratio for duplications. (0.000000).
  --DupLowHPP=Ratio               Low HP Plus for duplications. (0.000000).
  --DupLowHPPR=Ratio              Low HP Plus Ratio for duplications. (0.900000).
  --InvHPR=Ratio                  HPRatio for inversions (0.500000).
  --InvHomoR=Ratio                HomoRatio for inversions. (0.650000).
  --InvHomoM=Ratio                Homo Minus for inversions. (0.700000).
  --InvHomoMR=Ratio               Homo Minus Ratio for inversions. (0.200000).
  --InvNonHomoM=Ratio             Non Homo Minus for inversions. (0.000000).
  --InvNonHomoMR=Ratio            Non Homo Minus Ratio for inversions. (0.400000).
  --InvLowHPP=Ratio               Low HP Plus for inversions. (0.000000).
  --InvLowHPPR=Ratio              Low HP Plus Ratio for inversions. (0.000000).
  --DelHPSCR=Ratio                HP same compare ratio for deletions (0.800000).
  --DelHPDCR=Ratio                HP diff compare ratio for deletions (1.400000).
  --InsHPSCR=Ratio                HP same compare ratio for insertions (0.800000).
  --InsHPDCR=Ratio                HP diff compare ratio for insertions (1.500000).
  --DupHPSCR=Ratio                HP same compare ratio for duplications (0.400000).
  --DupHPDCR=Ratio                HP diff compare ratio for duplications (1.400000).
  --InvHPSCR=Ratio                HP same compare ratio for inversions (1.000000).
  --InvHPDCR=Ratio                HP diff compare ratio for inversions (1.300000).
```

