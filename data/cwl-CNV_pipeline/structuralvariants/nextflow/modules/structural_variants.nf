process STRUCTURAL_VARIANTS {
  tag { "structural variants" }
  container 'quay.io/biocontainers/bioconductor-structuralvariantannotation:1.6.0--r40_0'

  input:
    path input

  output:
    path "*.gridss.raw.bed"

  script:
  """
  #!/usr/bin/env Rscript

  library(stringr)
  library(VariantAnnotation)
  library(StructuralVariantAnnotation)

  vcfFile <- '${input}'
  bedFile <- gsub('.vcf.gz', '.bed', vcfFile)

  simpleEventType <- function(gr) {
  return(
      ifelse(seqnames(gr) != seqnames(partner(gr)), "Translocation",
              ifelse(gr\$insLen >= abs(gr\$svLen) * 0.7, "Insertion",
                  ifelse(strand(gr) == strand(partner(gr)), "Inversion",
                          ifelse(xor(start(gr) < start(partner(gr)), strand(gr) == "-"), "DEL",
                                  "DUP")))))
  }
  options(scipen=999)
  full_vcf <- readVcf(vcfFile)
  gr <- breakpointRanges(full_vcf)
  bedpe <- data.frame(
  chrom1=seqnames(gr),
  start1=start(gr) - 1,
  end1=end(gr),
  chrom2=seqnames(partner(gr)),
  start2=start(partner(gr)) - 1,
  end2=end(partner(gr)),
  type=simpleEventType(gr),
  svLen=gr\$svLen,
  insLen=gr\$insLen,
  name=names(gr),
  score=gr\$QUAL,
  strand1=strand(gr),
  strand2=strand(partner(gr))
  )

  bedpe <- bedpe[str_detect(bedpe\$name, "gridss.+o"),]
  write.table(bedpe, bedFile, quote=FALSE, sep='\\t', row.names=FALSE, col.names=FALSE)
  """
}
