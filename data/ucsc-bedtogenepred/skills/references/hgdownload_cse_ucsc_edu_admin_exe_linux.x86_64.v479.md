```
This directory contains applications for stand-alone use,
built specifically for a Linux 64-bit machine.

For help on the bigBed and bigWig applications see:
http://genome.ucsc.edu/goldenPath/help/bigBed.html
http://genome.ucsc.edu/goldenPath/help/bigWig.html

View the file 'FOOTER.txt' to see the usage statement for
each of the applications.

##############################################################################
Thank you to Bob Harris for permission to distribute a binary
version of the lastz and lastz_D programs, from:

   https://github.com/lastz/lastz

Version 1.04.00 as of April 2018:

-rwxrwxr-x 1  625283 Apr  6 11:15 lastz-1.04.00
-rwxrwxr-x 1  628835 Apr  6 11:15 lastz_D-1.04.00

$ md5sum lastz*
429e61ffdf1612b7f0f0c8c2095609a7  lastz-1.04.00
4f9a558a65c3a07d0f992cd39b3a27e1  lastz_D-1.04.00

##############################################################################
This entire directory can by copied with the rsync command
into the local directory ./

rsync -aP rsync://hgdownload.soe.ucsc.edu/genome/admin/exe/linux.x86_64.v479/ ./

Individual programs can by copied by adding their name, for example:

rsync -aP \
   rsync://hgdownload.soe.ucsc.edu/genome/admin/exe/linux.x86_64.v479/faSize ./
```

```
      Name                       Last modified      Size  Description

---

      Parent Directory                                -
      FOOTER.txt                 2025-03-27 14:28  329K
      addCols                    2025-03-27 12:41  6.3M
      ameme                      2025-03-27 12:42  7.2M
      autoDtd                    2025-03-27 12:41  6.3M
      autoSql                    2025-03-27 12:41  6.5M
      autoXml                    2025-03-27 12:41  6.4M
      ave                        2025-03-27 12:41  6.3M
      aveCols                    2025-03-27 12:41  6.3M
      axtChain                   2025-03-27 12:42  6.9M
      axtSort                    2025-03-27 12:42  6.3M
      axtSwap                    2025-03-27 12:42  6.3M
      axtToMaf                   2025-03-27 12:42  6.4M
      axtToPsl                   2025-03-27 12:42  6.6M
      bamToPsl                   2025-03-27 12:41  6.7M
      barChartMaxLimit           2025-03-26 18:35  1.0K
      bedClip                    2025-03-27 12:41  7.3M
      bedCommonRegions           2025-03-27 12:41  6.3M
      bedCoverage                2025-03-27 12:42   19M
      bedExtendRanges            2025-03-27 12:42   19M
      bedGeneParts               2025-03-27 12:41  7.1M
      bedGraphPack               2025-03-27 12:41  6.3M
      bedGraphToBigWig           2025-03-27 12:41  7.3M
      bedIntersect               2025-03-27 12:41  6.3M
      bedItemOverlapCount        2025-03-27 12:41   19M
      bedJoinTabOffset           2025-03-27 12:41  6.3M
      bedJoinTabOffset.py        2025-03-26 18:35  4.3K
      bedMergeAdjacent           2025-03-27 12:42  7.1M
      bedPartition               2025-03-27 12:42  7.1M
      bedPileUps                 2025-03-27 12:41  6.3M
      bedRemoveOverlap           2025-03-27 12:41  6.3M
      bedRestrictToPositions     2025-03-27 12:41  6.3M
      bedSort                    2025-03-27 12:41  7.1M
      bedToBigBed                2025-03-27 12:41  7.4M
      bedToExons                 2025-03-27 12:42  7.1M
      bedToGenePred              2025-03-27 12:41   19M
      bedToPsl                   2025-03-27 12:42  7.1M
      bedWeedOverlapping         2025-03-27 12:42  7.1M
      bigBedInfo                 2025-03-27 12:41  7.3M
      bigBedNamedItems           2025-03-27 12:41  7.3M
      bigBedSummary              2025-03-27 12:41  7.3M
      bigBedToBed                2025-03-27 12:41  7.3M
      bigChainBreaks             2025-03-27 12:42  7.3M
      bigChainToChain            2025-03-27 12:42   19M
      bigGenePredToGenePred      2025-03-27 12:42   19M
      bigGuessDb                 2025-03-26 18:35  9.1K
      bigHeat                    2025-03-26 18:35   17K
      bigMafToMaf                2025-03-27 12:42  7.3M
      bigPslToPsl                2025-03-27 12:42  7.3M
      bigWigAverageOverBed       2025-03-27 12:41  7.3M
      bigWigCat                  2025-03-27 12:41  7.4M
      bigWigCluster              2025-03-27 12:41  6.4M
      bigWigCorrelate            2025-03-27 12:41  7.3M
      bigWigInfo                 2025-03-27 12:41  6.4M
      bigWigMerge                2025-03-27 12:41  6.4M
      bigWigSummary              2025-03-27 12:41  6.4M
      bigWigToBedGraph           2025-03-27 12:41  6.4M
      bigWigToWig                2025-03-27 12:41  6.4M
      binFromRange               2025-03-27 12:42   19M
      blastToPsl                 2025-03-27 12:41  6.6M
      blastXmlToPsl              2025-03-27 12:41  6.9M
      blat/                      2025-03-27 15:22    -
      calc                       2025-03-27 12:41  6.3M
      catDir                     2025-03-27 12:41  6.3M
      catUncomment               2025-03-27 12:41  6.3M
      chainAntiRepeat            2025-03-27 12:42  6.5M
      chainBridge                2025-03-27 12:42  6.6M
      chainCleaner               2025-03-27 12:42  6.7M
      chainFilter                2025-03-27 12:42  6.3M
      chainMergeSort             2025-03-27 12:42  6.3M
      chainNet                   2025-03-27 12:42  6.4M
      chainPreNet                2025-03-27 12:42  6.3M
      chainScore                 2025-03-27 12:42  6.5M
      chainSort                  2025-03-27 12:42  6.3M
      chainSplit                 2025-03-27 12:42  6.3M
      chainStitchId              2025-03-27 12:42  6.3M
      chainSwap                  2025-03-27 12:42  6.3M
      chainToAxt                 2025-03-27 12:42  6.5M
      chainToBigChain            2025-03-27 12:42  6.4M
      chainToPsl                 2025-03-27 12:42  6.5M
      chainToPslBasic            2025-03-27 12:42  6.6M
      checkAgpAndFa              2025-03-27 12:41  6.5M
      checkCoverageGaps          2025-03-27 12:41   19M
      checkHgFindSpec            2025-03-27 12:41   19M
      checkTableCoords           2025-03-27 12:41   19M
      chopFaLines                2025-03-27 12:41  6.3M
      chromGraphFromBin          2025-03-27 12:42   19M
      chromGraphToBin            2025-03-27 12:42   19M
      chromToUcsc                2025-03-26 18:35   11K
      clusterGenes               2025-03-27 12:41   19M
      clusterMatrixToBarChartBed 2025-03-27 12:41  6.3M
      colTransform               2025-03-27 12:41  6.3M
      countChars                 2025-03-27 12:41  6.3M
      cpg_lh                     2025-03-27 12:41   34K
      crTreeIndexBed             2025-03-27 12:42  6.4M
      crTreeSearchBed            2025-03-27 12:42  6.4M
      dbDbToHubTxt               2025-03-27 12:42   19M
      dbSnoop                    2025-03-27 12:42   11M
      dbTrash                    2025-03-27 12:41   19M
      endsInLf                   2025-03-27 12:41  6.3M
      estOrient                  2025-03-27 12:41   19M
      expMatrixToBarchartBed     2025-03-26 18:35   16K
      faAlign                    2025-03-27 12:41  6.4M
      faCmp                      2025-03-27 12:41  6.3M
      faCount                    2025-03-27 12:41  6.3M
      faFilter                   2025-03-27 12:41  6.3M
      faFilterN                  2025-03-27 12:41  6.6M
      faFrag                     2025-03-27 12:41  6.3M
      faNoise                    2025-03-27 12:41  6.3M
      faOneRecord                2025-03-27 12:41  6.3M
      faPolyASizes               2025-03-27 12:41  6.3M
      faRandomize                2025-03-27 12:41  6.3M
      faRc                       2025-03-27 12:41  6.3M
      faSize                     2025-03-27 12:41  6.3M
      faSomeRecords              2025-03-27 12:41  6.3M
      faSplit                    2025-03-27 12:41  6.4M
      faToFastq                  2025-03-27 12:41  6.3M
      faToTab                    2025-03-27 12:41  6.3M
      faToTwoBit                 2025-03-27 12:41  6.4M
      faToVcf                    2025-03-27 12:42  6.4M
      faTrans                    2025-03-27 12:41  6.3M
      fastqStatsAndSubsample     2025-03-27 12:41  6.4M
      fastqToFa                  2025-03-27 12:41  6.3M
      featureBits                2025-03-27 12:41   19M
      fetchChromSizes            2025-03-27 12:42  3.0K
      findMotif                  2025-03-27 12:41  6.5M
      fixStepToBedGraph.pl       2025-03-27 12:42  1.4K
      fixTrackDb                 2025-03-27 12:42   19M
      gapToLift                  2025-03-27 12:42   19M
      gencodeVersionForGenes     2025-03-27 12:42  6.4M
      genePredCheck              2025-03-27 12:42   19M
      genePredFilter             2025-03-27 12:42   19M
      genePredHisto              2025-03-27 12:41   19M
      genePredSingleCover        2025-03-27 12:41   19M
      genePredToBed              2025-03-27 12:41   19M
      genePredToBigGenePred      2025-03-27 12:42   19M
      genePredToFakePsl          2025-03-27 12:41   19M
      genePredToGtf              2025-03-27 12:42   19M
      genePredToMafFrames        2025-03-27 12:41   19M
      genePredToProt             2025-03-27 12:42   19M
      gensub2                    2025-03-27 12:41  6.3M
      getRna                     2025-03-27 12:41   19M
      getRnaPred                 2025-03-27 12:41   19M
      gff3ToGenePred             2025-03-27 12:42   19M
      gff3ToPsl                  2025-03-27 12:42  6.7M
      gmtime                     2025-03-27 12:41   13K
      gtfToGenePred              2025-03-27 12:42   19M
      headRest                   2025-03-27 12:41  6.3M
      hgBbiDbLink                2025-03-27 12:42   10M
      hgFakeAgp                  2025-03-27 12:42  6.3M
      hgFindSpec                 2025-03-27 12:42   19M
      hgGcPercent                2025-03-27 12:42   19M
      hgGoldGapGl                2025-03-27 12:42   19M
      hgLoadBed                  2025-03-27 12:42   19M
      hgLoadChain                2025-03-27 12:42   19M
      hgLoadGap                  2025-03-27 12:42   19M
      hgLoadMaf                  2025-03-27 12:42   19M
      hgLoadMafSummary           2025-03-27 12:42   19M
      hgLoadNet                  2025-03-27 12:42   19M
      hgLoadOut                  2025-03-27 12:42   19M
      hgLoadOutJoined            2025-03-27 12:42   19M
      hgLoadSqlTab               2025-03-27 12:42   11M
      hgLoadWiggle               2025-03-27 12:42   19M
      hgSpeciesRna               2025-03-27 12:41   19M
      hgTrackDb                  2025-03-27 12:42   19M
      hgWiggle                   2025-03-27 12:42   19M
      hgsql                      2025-03-27 12:41   10M
      hgsqldump                  2025-03-27 12:41   10M
      hgvsToVcf                  2025-03-27 12:42   19M
      hicInfo                    2025-03-27 12:42   19M
      htmlCheck                  2025-03-27 12:41  6.3M
      hubCheck                   2025-03-27 12:42   19M
      hubClone                   2025-03-27 12:42   19M
      hubPublicCheck             2025-03-27 12:42   19M
      ixIxx                      2025-03-27 12:42  6.4M
      lastz-1.04.00              2025-03-27 15:08  611K
      lastz_D-1.04.00            2025-03-27 15:08  614K
      lavToAxt                   2025-03-27 12:42  6.5M
      lavToPsl                   2025-03-27 12:42  7.2M
      ldHgGene                   2025-03-27 12:42   19M
      liftOver                   2025-03-27 12:41   19M
      liftOverMerge              2025-03-27 12:41  7.1M
      liftUp                     2025-03-27 12:41   19M
      linesToRa                  2025-03-27 12:41  6.3M
      localtime                  2025-03-27 12:41   13K
      mafAddIRows                2025-03-27 12:42  6.4M
      mafAddQRows                2025-03-27 12:42  6.4M
      mafCoverage                2025-03-27 12:42   19M
      mafFetch                   2025-03-27 12:42   19M
      mafFilter                  2025-03-27 12:42  6.3M
      mafFrag                    2025-03-27 12:42   19M
      mafFrags                   2025-03-27 12:42   19M
      mafGene                    2025-03-27 12:42   19M
      mafMeFirst                 2025-03-27 12:42  6.3M
      mafNoAlign                 2025-03-27 12:42  6.3M
      mafOrder                   2025-03-27 12:42  6.3M
      mafRanges                  2025-03-27 12:42  6.3M
      mafSpeciesList             2025-03-27 12:42  6.3M
      mafSpeciesSubset           2025-03-27 12:41  6.3M
      mafSplit                   2025-03-27 12:42  7.2M
      mafSplitPos                2025-03-27 12:42   19M
      mafToAxt                   2025-03-27 12:42  6.4M
      mafToBigMaf                2025-03-27 12:42  6.3M
      mafToPsl                   2025-03-27 12:42  6.6M
      mafToSnpBed                2025-03-27 12:42   19M
      mafsInRegion               2025-03-27 12:41  7.1M
      makeTableList              2025-03-27 12:42   19M
      maskOutFa                  2025-03-27 12:41  7.2M
      matrixClusterColumns       2025-03-27 12:41  6.4M
      matrixMarketToTsv          2025-03-27 12:41  6.3M
      matrixNormalize            2025-03-27 12:41  6.3M
      matrixToBarChartBed        2025-03-27 12:41  6.3M
      mktime                     2025-03-27 12:41   14K
      mrnaToGene                 2025-03-27 12:41   19M
      netChainSubset             2025-03-27 12:42  6.3M
      netClass                   2025-03-27 12:42   19M
      netFilter                  2025-03-27 12:42  6.3M
      netSplit                   2025-03-27 12:42  6.3M
      netSyntenic                2025-03-27 12:42  6.3M
      netToAxt                   2025-03-27 12:42  6.5M
      netToBed                   2025-03-27 12:42  6.3M
      newProg                    2025-03-27 12:41  6.3M
      newPythonProg              2025-03-27 12:41  6.3M
      nibFrag                    2025-03-27 12:41  6.4M
      nibSize                    2025-03-27 12:41  6.3M
      oligoMatch                 2025-03-27 12:42  7.3M
      overlapSelect              2025-03-27 12:42   19M
      para                       2025-03-27 12:41  6.6M
      paraFetch                  2025-03-27 12:41  6.3M
      paraHub                    2025-03-27 12:41  6.6M
      paraHubStop                2025-03-27 12:41  6.4M
      paraNode                   2025-03-27 12:41  6.4M
      paraNodeStart              2025-03-27 12:41  6.3M
      paraNodeStatus             2025-03-27 12:41  6.4M
      paraNodeStop               2025-03-27 12:41  6.4M
      paraSync                   2025-03-27 12:41  6.3M
      paraTestJob                2025-03-27 12:41  6.3M
      parasol                    2025-03-27 12:41  6.5M
      positionalTblCheck         2025-03-27 12:42   19M
      pslCDnaFilter              2025-03-27 12:42   19M
      pslCat                     2025-03-27 12:42  6.5M
      pslCheck                   2025-03-27 12:42   19M
      pslDropOverlap             2025-03-27 12:42  6.5M
      pslFilter                  2025-03-27 12:42  6.5M
      pslHisto  