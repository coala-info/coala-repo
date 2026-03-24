# load packages
library(ExomeDepth)

args <- commandArgs(TRUE)

# parse arguments
inputList <- c(strsplit(args[1], " ")[[1]])
bamsList <- sort(inputList[grepl("*.bam$", inputList)])
mapppingFile <- inputList[grepl("*.csv$", inputList)]

bams <- read.csv(mapppingFile, header = TRUE, sep = ",") # mapping file
bed <- read.csv(args[2], sep = "\t")
refgen <- args[3]

# mapping
bamsMap <- bams[bams$file %in% bamsList,]
batch <- bamsMap$batch[[1]]

# set global variables
bamFiles <- as.vector(bamsMap$file)
baiFiles <- as.vector(bamsMap$index_file)

# prepare bed file (4th column is the annotation for each region)
bed <- bed[,1:4]
colnames(bed) <- c("chromosome", "start", "end", "name")

# get counts per bed region
message('\n[INFO] Creating counts matrix')
my.counts <- getBamCounts(bed.frame = bed, bam.files = bamFiles, include.chr = FALSE, min.mapq = 20, referenceFasta = refgen, index.files = baiFiles)
ExomeCount.dafr <- as(my.counts, "data.frame")

# prepare the main matrix of read count data
ExomeCount.mat <- as.matrix(ExomeCount.dafr[, grep(names(ExomeCount.dafr), pattern = '*.bam')])
nsamples <- ncol(ExomeCount.mat)

results <- data.frame(NULL) # to write results

# start looping over each sample
for (i in 1:nsamples) {

  sampname <- sapply(strsplit(bamsList[[i]], "[.]"), "[[", 1) # get sample name
  message(paste0("\n[INFO] Creating reference set for ", bamsList[[i]]))

  # Create the aggregate reference set for this sample
  my.choice <- select.reference.set(test.counts = ExomeCount.mat[,i],
                                    reference.counts = ExomeCount.mat[,-i],
                                    bin.length = (ExomeCount.dafr$end - ExomeCount.dafr$start)/1000,
                                    n.bins.reduced = 10000)

  my.reference.selected <- apply(X = ExomeCount.mat[, my.choice$reference.choice, drop = FALSE],
                                MAR = 1,
                                FUN = sum)

  message('\n[INFO] Computing correlation between sample and references...\n')
  my.test = ExomeCount.mat[, i, drop = FALSE]
  my.ref.counts = ExomeCount.mat[, my.choice$reference.choice, drop = FALSE]
  correlation = cor(my.test[,1], apply(my.ref.counts, 1, mean))
  message(paste("\n[INFO] Correlation between reference and tests count is", round(correlation,4)))

  message('\n[INFO] Creating the ExomeDepth object')
  all.exons <- new('ExomeDepth',
                  test = ExomeCount.mat[,i],
                  reference = my.reference.selected,
                  formula = 'cbind(test, reference) ~ 1')

  # Call the CNVs
  message('\n[INFO] Calling CNVs')
  all.exons <- CallCNVs(x = all.exons,
                        transition.probability = 10^-4,
                        chromosome = ExomeCount.dafr$space,
                        start = ExomeCount.dafr$start,
                        end = ExomeCount.dafr$end,
                        name = bed$name)

  all.exons@CNV.calls$sample_id <- sampname # set sample name
  results <- rbind(results, all.exons@CNV.calls)  # append to results

}
message('\n[INFO] Writting results')
output.file <- paste0("batch_", batch, ".exomeDepth.csv")
write.csv(file = output.file, x = results, row.names = FALSE)
