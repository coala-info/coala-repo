```
##############################################################################
This file is from:

http://hgdownload.soe.ucsc.edu/admin/exe/macOSX.x86_64/README.txt

This directory contains applications for stand-alone use,
built on a Mac OSX 14.7 intel machine.  (Sonoma)
Darwin Kernel Version 23.6.0, gcc version:
Apple clang version 16.0.0 (clang-1600.0.26.4
Target: x86_64-apple-darwin23.6.0
Thread model: posix

kent source tree v495 March 2026.

For help on the bigBed and bigWig applications see:
http://genome.ucsc.edu/goldenPath/help/bigBed.html
http://genome.ucsc.edu/goldenPath/help/bigWig.html

View the file 'FOOTER.txt' to see the usage statement for
each of the applications.

The shared libraries used by these binaries are:  (from: otool -L <binary>)

/usr/lib/libc++.1.dylib (compatibility version 1.0.0, current version 1800.101.0)
/usr/lib/libSystem.B.dylib (compatibility version 1.0.0, current version 1351.0.0)
/usr/lib/libz.1.dylib (compatibility version 1.0.0, current version 1.2.12)

##############################################################################
Thank you to Bob Harris for permission to distribute a binary
version of the lastz and lastz_D programs, from:

   https://github.com/lastz/lastz

Version 1.04.00 as of April 2018:

-rwxrwxr-x 1 514360 Apr  6 11:24 lastz-1.04.00
-rwxrwxr-x 1 514360 Apr  6 11:24 lastz_D-1.04.00

$ gmd5sum lastz*
4aa388bf0743e48d45704dc9194d5888  lastz-1.04.00
bae26692e8a35313a1f149e37c8c7e6e  lastz_D-1.04.00

Reference:
Harris, R. Improved pairwise alignment of genomic DNA.
2007. PhD diss., The Pennsylvania State University (2007)

##############################################################################
This entire directory can by copied with the rsync command
into the local directory ./

rsync -aP rsync://hgdownload.soe.ucsc.edu/genome/admin/exe/macOSX.x86_64/ ./

Individual programs can by copied by adding their name, for example:

rsync -aP \
   rsync://hgdownload.soe.ucsc.edu/genome/admin/exe/macOSX.x86_64/faSize ./

##############################################################################
```

```
      Name                       Last modified      Size  Description

---

      Parent Directory                                -
      FOOTER.txt                 2026-03-20 17:20  338K
      addCols                    2026-03-20 16:05  5.6M
      ameme                      2026-03-20 16:07  7.9M
      autoDtd                    2026-03-20 16:06  5.6M
      autoSql                    2026-03-20 16:06  5.6M
      autoXml                    2026-03-20 16:06  5.6M
      ave                        2026-03-20 16:05  5.6M
      aveCols                    2026-03-20 16:05  5.6M
      axtChain                   2026-03-20 16:06  5.8M
      axtSort                    2026-03-20 16:06  5.6M
      axtSwap                    2026-03-20 16:06  5.6M
      axtToMaf                   2026-03-20 16:06  5.6M
      axtToPsl                   2026-03-20 16:06  5.7M
      bamToPsl                   2026-03-20 16:05  5.7M
      barChartMaxLimit           2026-03-20 13:15  1.0K
      bedClip                    2026-03-20 16:05  8.0M
      bedCommonRegions           2026-03-20 16:05  5.6M
      bedCoverage                2026-03-20 16:06   10M
      bedExtendRanges            2026-03-20 16:07   10M
      bedGeneParts               2026-03-20 16:05  8.0M
      bedGraphPack               2026-03-20 16:05  5.6M
      bedGraphToBigWig           2026-03-20 16:05  8.0M
      bedIntersect               2026-03-20 16:06  5.6M
      bedItemOverlapCount        2026-03-20 16:06   10M
      bedJoinTabOffset           2026-03-20 16:05  5.6M
      bedJoinTabOffset.py        2026-03-20 13:15  4.3K
      bedMergeAdjacent           2026-03-20 16:07  8.0M
      bedPartition               2026-03-20 16:07  8.0M
      bedPileUps                 2026-03-20 16:05  5.6M
      bedRemoveOverlap           2026-03-20 16:05  5.6M
      bedRestrictToPositions     2026-03-20 16:05  5.6M
      bedSort                    2026-03-20 16:06  7.9M
      bedToBigBed                2026-03-20 16:05  8.0M
      bedToExons                 2026-03-20 16:06  8.0M
      bedToGenePred              2026-03-20 16:06   10M
      bedToPsl                   2026-03-20 16:07  8.0M
      bedWeedOverlapping         2026-03-20 16:07  8.0M
      bigBedInfo                 2026-03-20 16:05  8.0M
      bigBedNamedItems           2026-03-20 16:05  8.0M
      bigBedSummary              2026-03-20 16:05  8.0M
      bigBedToBed                2026-03-20 16:05  8.0M
      bigChainBreaks             2026-03-20 16:07  8.0M
      bigChainToChain            2026-03-20 16:07   10M
      bigGenePredToGenePred      2026-03-20 16:07   10M
      bigGuessDb                 2026-03-20 13:15  9.1K
      bigHeat                    2026-03-20 13:15   17K
      bigMafToMaf                2026-03-20 16:07  8.0M
      bigPslToPsl                2026-03-20 16:07  8.0M
      bigWigAverageOverBed       2026-03-20 16:05  8.0M
      bigWigCat                  2026-03-20 16:05  8.0M
      bigWigCluster              2026-03-20 16:05  5.6M
      bigWigCorrelate            2026-03-20 16:05  8.0M
      bigWigInfo                 2026-03-20 16:05  5.6M
      bigWigMerge                2026-03-20 16:05  5.6M
      bigWigSummary              2026-03-20 16:05  5.6M
      bigWigToBedGraph           2026-03-20 16:05  8.0M
      bigWigToWig                2026-03-20 16:05  8.0M
      binFromRange               2026-03-20 16:07   10M
      blastToPsl                 2026-03-20 16:06  5.7M
      blastXmlToPsl              2026-03-20 16:06  5.8M
      blat/                      2026-03-20 16:17    -
      calc                       2026-03-20 16:05  5.6M
      catDir                     2026-03-20 16:05  5.6M
      catUncomment               2026-03-20 16:05  5.6M
      chainAntiRepeat            2026-03-20 16:06  5.6M
      chainBridge                2026-03-20 16:06  5.7M
      chainCleaner               2026-03-20 16:06  5.7M
      chainFilter                2026-03-20 16:06  5.6M
      chainMergeSort             2026-03-20 16:06  5.6M
      chainNet                   2026-03-20 16:06  5.6M
      chainPreNet                2026-03-20 16:06  5.6M
      chainScore                 2026-03-20 16:06  5.7M
      chainSort                  2026-03-20 16:06  5.6M
      chainSplit                 2026-03-20 16:06  5.6M
      chainStitchId              2026-03-20 16:06  5.6M
      chainSwap                  2026-03-20 16:06  5.6M
      chainToAxt                 2026-03-20 16:06  5.7M
      chainToBigChain            2026-03-20 16:07  5.6M
      chainToPsl                 2026-03-20 16:06  5.6M
      chainToPslBasic            2026-03-20 16:06  5.7M
      checkAgpAndFa              2026-03-20 16:06  5.7M
      checkCoverageGaps          2026-03-20 16:06   10M
      checkHgFindSpec            2026-03-20 16:06   10M
      checkTableCoords           2026-03-20 16:06   10M
      chopFaLines                2026-03-20 16:05  5.6M
      chromGraphFromBin          2026-03-20 16:07   10M
      chromGraphToBin            2026-03-20 16:07   10M
      chromToUcsc                2026-03-20 13:15   11K
      clusterGenes               2026-03-20 16:06   10M
      clusterMatrixToBarChartBed 2026-03-20 16:05  5.6M
      colTransform               2026-03-20 16:05  5.6M
      countChars                 2026-03-20 16:05  5.6M
      cpg_lh                     2026-03-20 16:05   18K
      crTreeIndexBed             2026-03-20 16:07  5.6M
      crTreeSearchBed            2026-03-20 16:07  5.6M
      dbDbToHubTxt               2026-03-20 16:07   10M
      dbSnoop                    2026-03-20 16:07  5.9M
      dbTrash                    2026-03-20 16:06   10M
      endsInLf                   2026-03-20 16:05  5.6M
      estOrient                  2026-03-20 16:06   10M
      expMatrixToBarchartBed     2026-03-20 13:15   16K
      faAlign                    2026-03-20 16:05  5.6M
      faCmp                      2026-03-20 16:05  5.6M
      faCount                    2026-03-20 16:05  5.6M
      faFilter                   2026-03-20 16:05  5.6M
      faFilterN                  2026-03-20 16:05  5.7M
      faFrag                     2026-03-20 16:05  5.6M
      faNoise                    2026-03-20 16:05  5.6M
      faOneRecord                2026-03-20 16:05  5.6M
      faPolyASizes               2026-03-20 16:05  5.6M
      faRandomize                2026-03-20 16:05  5.6M
      faRc                       2026-03-20 16:05  5.6M
      faSize                     2026-03-20 16:05  5.6M
      faSomeRecords              2026-03-20 16:05  5.6M
      faSplit                    2026-03-20 16:05  5.6M
      faToFastq                  2026-03-20 16:05  5.6M
      faToTab                    2026-03-20 16:05  5.6M
      faToTwoBit                 2026-03-20 16:05  5.6M
      faToVcf                    2026-03-20 16:07  5.6M
      faTrans                    2026-03-20 16:05  5.6M
      fastqStatsAndSubsample     2026-03-20 16:05  5.6M
      fastqToFa                  2026-03-20 16:05  5.6M
      featureBits                2026-03-20 16:06   10M
      fetchChromSizes            2026-03-20 13:15  3.0K
      findMotif                  2026-03-20 16:05  5.6M
      fixStepToBedGraph.pl       2026-03-20 16:07  1.4K
      fixTrackDb                 2026-03-20 16:07   10M
      gapToLift                  2026-03-20 16:07   10M
      gencodeVersionForGenes     2026-03-20 16:07  5.6M
      genePredCheck              2026-03-20 16:06   10M
      genePredCompare            2026-03-20 13:15  6.6K
      genePredFilter             2026-03-20 16:07   10M
      genePredHisto              2026-03-20 16:06   10M
      genePredSingleCover        2026-03-20 16:06   10M
      genePredToBed              2026-03-20 16:06   10M
      genePredToBigGenePred      2026-03-20 16:07   10M
      genePredToFakePsl          2026-03-20 16:06   10M
      genePredToGtf              2026-03-20 16:06   10M
      genePredToMafFrames        2026-03-20 16:06   10M
      genePredToProt             2026-03-20 16:07   10M
      gensub2                    2026-03-20 16:06  5.6M
      getRna                     2026-03-20 16:06   10M
      getRnaPred                 2026-03-20 16:06   10M
      gff3ToGenePred             2026-03-20 16:07   10M
      gff3ToPsl                  2026-03-20 16:07  5.7M
      gmtime                     2026-03-20 16:06  8.8K
      gtfToGenePred              2026-03-20 16:07   10M
      headRest                   2026-03-20 16:05  5.6M
      hgBbiDbLink                2026-03-20 16:07  5.9M
      hgFakeAgp                  2026-03-20 16:07  5.6M
      hgFindSpec                 2026-03-20 16:07   10M
      hgGcPercent                2026-03-20 16:07   10M
      hgGoldGapGl                2026-03-20 16:07   10M
      hgLoadBed                  2026-03-20 16:07   10M
      hgLoadChain                2026-03-20 16:07   10M
      hgLoadGap                  2026-03-20 16:07   10M
      hgLoadMaf                  2026-03-20 16:07   10M
      hgLoadMafSummary           2026-03-20 16:07   10M
      hgLoadNet                  2026-03-20 16:07   10M
      hgLoadOut                  2026-03-20 16:07   10M
      hgLoadOutJoined            2026-03-20 16:07   10M
      hgLoadSqlTab               2026-03-20 16:07  5.9M
      hgLoadWiggle               2026-03-20 16:07   10M
      hgSpeciesRna               2026-03-20 16:06   10M
      hgTrackDb                  2026-03-20 16:07   10M
      hgWiggle                   2026-03-20 16:07   10M
      hgsql                      2026-03-20 16:06  5.9M
      hgsqldump                  2026-03-20 16:06  5.9M
      hgvsToVcf                  2026-03-20 16:07   10M
      hicInfo                    2026-03-20 16:07   10M
      htmlCheck                  2026-03-20 16:05  5.6M
      hubCheck                   2026-03-20 16:07   10M
      hubClone                   2026-03-20 16:07   10M
      hubPublicCheck             2026-03-20 16:07   10M
      ixIxx                      2026-03-20 16:07  5.6M
      lastz-1.04.00              2018-04-06 11:24  502K
      lastz_D-1.04.00            2018-04-06 11:24  502K
      lavToAxt                   2026-03-20 16:06  5.7M
      lavToPsl                   2026-03-20 16:06  8.0M
      ldHgGene                   2026-03-20 16:07   10M
      liftOver                   2026-03-20 16:06   10M
      liftOverMerge              2026-03-20 16:06  8.0M
      liftUp                     2026-03-20 16:06   10M
      linesToRa                  2026-03-20 16:06  5.6M
      localtime                  2026-03-20 16:06  8.9K
      mafAddIRows                2026-03-20 16:06  5.6M
      mafAddQRows                2026-03-20 16:06  5.6M
      mafCoverage                2026-03-20 16:06   10M
      mafFetch                   2026-03-20 16:06   10M
      mafFilter                  2026-03-20 16:07  5.6M
      mafFrag                    2026-03-20 16:07   10M
      mafFrags                   2026-03-20 16:07   10M
      mafGene                    2026-03-20 16:07   10M
      mafMeFirst                 2026-03-20 16:07  5.6M
      mafNoAlign                 2026-03-20 16:06  5.6M
      mafOrder                   2026-03-20 16:07  5.6M
      mafRanges                  2026-03-20 16:06  5.6M
      mafSpeciesList             2026-03-20 16:07  5.6M
      mafSpeciesSubset           2026-03-20 16:06  5.6M
      mafSplit                   2026-03-20 16:07  8.0M
      mafSplitPos                2026-03-20 16:07   10M
      mafToAxt                   2026-03-20 16:06  5.6M
      mafToBigMaf                2026-03-20 16:07  5.6M
      mafToPsl                   2026-03-20 16:06  5.7M
      mafToSnpBed                2026-03-20 16:06   10M
      mafsInRegion               2026-03-20 16:06  8.0M
      makeTableList              2026-03-20 16:07   10M
      maskOutFa                  2026-03-20 16:06  8.0M
      matrixClusterColumns       2026-03-20 16:05  5.6M
      matrixMarketToTsv          2026-03-20 16:05  5.6M
      matrixNormalize            2026-03-20 16:05  5.6M
      matrixToBarChartBed        2026-03-20 16:05  5.6M
      mktime                     2026-03-20 16:06  8.9K
      mrnaToGene                 2026-03-20 16:06   10M
      netChainSubset             2026-03-20 16:06  5.6M
      netClass                   2026-03-20 16:06   10M
      netFilter                  2026-03-20 16:06  5.6M
      netSplit                   2026-03-20 16:06  5.6M
      netSyntenic                2026-03-20 16:06  5.6M
      netToAxt                   2026-03-20 16:06  5.7M
      netToBed                   2026-03-20 16:06  5.6M
      newProg                    2026-03-20 16:05  5.6M
      newPythonProg              2026-03-20 16:05  5.6M
      nibFrag                    2026-03-20 16:06  5.6M
      nibSize                    2026-03-20 16:06  5.6M
      oligoMatch                 2026-03-20 16:07  8.0M
      overlapSelect              2026-03-20 16:07   10M
      para                       2026-03-20 16:06  