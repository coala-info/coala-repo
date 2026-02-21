# Code example from 'single' vignette. See references/ for full tutorial.

## -----------------------------------------------------------------------------
library(single)
pos_start <- 1
pos_end <- 10

refseq_fasta <- system.file("extdata", "ref_seq.fasta", package = "single")
ref_seq <- Biostrings::subseq(Biostrings::readDNAStringSet(refseq_fasta), pos_start,pos_end)


## -----------------------------------------------------------------------------
REF_READS <- system.file("extdata", "train_seqs_500.sorted.bam",package = "single")
train <- single_train(bamfile=REF_READS,
                      output="train",
                      refseq_fasta=refseq_fasta,
                      rates.matrix=mutation_rate,
                      mean.n.mutations=5.4,
                      pos_start=pos_start,
                      pos_end=pos_end,
                      verbose=FALSE,
                      save_partial=FALSE,
                      save_final= FALSE)
print(head(train))

## -----------------------------------------------------------------------------
LIB_READS <- system.file("extdata","test_sequences.sorted.bam",package ="single")
corrected_reads <- single_evaluate(bamfile = LIB_READS,
                single_fits = train,
                ref_seq = ref_seq,
                pos_start=pos_start,pos_end=pos_end,
                verbose=FALSE,
                gaps_weights = "minimum",
                save = FALSE)
corrected_reads

## -----------------------------------------------------------------------------
BC_TABLE = system.file("extdata", "Barcodes_table.txt",package = "single")
consensus <- single_consensus_byBarcode(barcodes_table = BC_TABLE,
                           sequences = corrected_reads,
                           verbose = FALSE)
consensus

## -----------------------------------------------------------------------------
counts_pnq <- pileup_by_QUAL(bam_file=REF_READS,
                    pos_start=pos_start,
                    pos_end=pos_end)
head(counts_pnq)

## -----------------------------------------------------------------------------
p_prior_errors <- p_prior_errors(counts_pnq=counts_pnq,
                                  save=FALSE)
p_prior_errors

## -----------------------------------------------------------------------------
p_prior_mutations <- p_prior_mutations(rates.matrix = mutation_rate,
                        mean.n.mut = 5,ref_seq = ref_seq,save = FALSE)
head(p_prior_mutations)

## -----------------------------------------------------------------------------
fits <- fit_logregr(counts_pnq = counts_pnq,ref_seq=ref_seq,
                    p_prior_errors = p_prior_errors,
                    p_prior_mutations = p_prior_mutations,
                    save=FALSE)
head(fits)

## -----------------------------------------------------------------------------
evaluated_fits <- evaluate_fits(pos_range = c(1,5),q_range = c(0,10),
                                data_fits = fits,ref_seq = ref_seq,
                                save=FALSE,verbose = FALSE)
head(evaluated_fits)

## -----------------------------------------------------------------------------
data_barcode = data.frame(
    nucleotide=unlist(sapply(as.character(corrected_reads),strsplit, split="")),
    p_SINGLe=unlist(1-as(Biostrings::quality(corrected_reads),"NumericList")),
    pos=rep(1:Biostrings::width(corrected_reads[1]),length(corrected_reads)))
consensus_seq <- weighted_consensus(df = data_barcode, cutoff_prob = 0.9)
consensus_seq
another_consensus_seq <- weighted_consensus(df = data_barcode, cutoff_prob = 0.999)
another_consensus_seq
list_mismatches(ref_seq[[1]],another_consensus_seq)

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

