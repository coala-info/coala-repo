# vg CWL Generation Report

## vg_autoindex

### Tool Description
Build indexes for vg

### Metadata
- **Docker Image**: quay.io/biocontainers/vg:1.70.0--h9ee0642_0
- **Homepage**: https://github.com/vgteam/vg
- **Package**: https://anaconda.org/channels/bioconda/packages/vg/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/vg/overview
- **Total Downloads**: 103.1K
- **Last updated**: 2025-11-24
- **GitHub**: https://github.com/vgteam/vg
- **Stars**: N/A
### Original Help Text
```text
vg: option '--h' is ambiguous; possibilities: '--hap-tx-gff' '--help'
usage: vg autoindex [options]
output:
  -p, --prefix PREFIX    prefix to use for all output [index]
  -w, --workflow NAME    workflow to produce indexes for (may repeat) [map]
                         {map, mpmap, rpvg, giraffe, sr-giraffe, lr-giraffe}
input data:
  -r, --ref-fasta FILE   FASTA file with the reference sequence (may repeat)
  -v, --vcf FILE         VCF file with sequence names matching -r (may repeat)
  -i, --ins-fasta FILE   FASTA file with sequences of INS variants from -v
  -g, --gfa FILE         GFA file to make a graph from
  -G, --gbz FILE         GBZ file to make indexes from
  -x, --tx-gff FILE      GTF/GFF file with transcript annotations (may repeat)
  -H, --hap-tx-gff FILE  GTF/GFF file with transcript annotations 
                         of a named haplotype (may repeat)
  -n, --no-guessing      do not guess that pre-existing files are indexes
                         i.e. force-regenerate any index not explicitly provided
configuration:
  -f, --gff-feature STR  GTF/GFF feature type (col. 3) to add to graph [exon]
  -a, --gff-tx-tag STR   GTF/GFF tag (in col. 9) for ID [transcript_id]
logging and computation:
  -T, --tmp-dir DIR      temporary directory to use for intermediate files
  -M, --target-mem MEM   target max memory usage (not exact, formatted INT[kMG])
                         [1/2 of available]
  -t, --threads NUM      number of threads [all available]
  -V, --verbosity NUM    log to stderr {0 = none, 1 = basic, 2 = debug}[1]
  -h, --help             print this help message to stderr and exit
```


## vg_construct

### Tool Description
Construct a variation graph from reference and variant calls or a multiple sequence alignment.

### Metadata
- **Docker Image**: quay.io/biocontainers/vg:1.70.0--h9ee0642_0
- **Homepage**: https://github.com/vgteam/vg
- **Package**: https://anaconda.org/channels/bioconda/packages/vg/overview
- **Validation**: PASS

### Original Help Text
```text
vg: option '--h' is ambiguous; possibilities: '--handle-sv' '--help'
usage: vg construct [options] >new.vg
options:
construct from a reference and variant calls:
  -r, --reference FILE   input FASTA reference (may repeat)
  -v, --vcf FILE         input VCF (may repeat)
  -n, --rename V=F       match contig V in the VCFs to contig F in the FASTAs
                         (may repeat)
  -a, --alt-paths        save paths for alts of variants by SHA1 hash
  -A, --alt-paths-plain  save paths for alts of variants by variant ID
                         if possible, otherwise SHA1
                         (IDs must be unique across all input VCFs)
  -R, --region REGION    specify a VCF contig name or 1-based inclusive region
                         (may repeat, if on different contigs)
  -C, --region-is-chrom  don't attempt to parse the regions (use when reference
                         sequence name could be parsed as a region)
  -z, --region-size N    variants per region to parallelize [1024]
  -t, --threads N        use N threads to construct graph [numCPUs]
  -S, --handle-sv        include structural variants in construction of graph.
  -I, --insertions FILE  a FASTA file containing insertion sequences 
                         (referred to in VCF) to add to graph.
  -f, --flat-alts        don't chop up alternate alleles from input VCF
  -l, --parse-max N      don't chop up alternate alleles from input VCF
                         longer than N [100]
  -i, --no-trim-indels   don't remove the 1bp ref base from indel alt alleles
  -N, --in-memory        construct entire graph in memory before outputting it
construct from a multiple sequence alignment:
  -M, --msa FILE         input multiple sequence alignment
  -F, --msa-format STR   format of the MSA file {fasta, clustal} [fasta]
  -d, --drop-msa-paths   don't add paths for the MSA sequences into the graph
shared construction options:
  -m, --node-max N       limit maximum allowable node sequence size [32]
                         nodes greater than this threshold will be divided
                         note: nodes larger than ~1024 bp can't be GCSA2-indexed
  -p, --progress         show progress
  -h, --help             print this help message to stderr and exit
```


## vg_rna

### Tool Description
Constructs a splicing graph from transcripts and a graph.

### Metadata
- **Docker Image**: quay.io/biocontainers/vg:1.70.0--h9ee0642_0
- **Homepage**: https://github.com/vgteam/vg
- **Package**: https://anaconda.org/channels/bioconda/packages/vg/overview
- **Validation**: PASS

### Original Help Text
```text
vg: option '--h' is ambiguous; possibilities: '--haplotypes' '--help'
usage: vg rna [options] graph.[vg|pg|hg|gbz] > splicing_graph.[vg|pg|hg]

General options:
  -t, --threads INT          number of compute threads to use [1]
  -p, --progress             show progress
  -h, --help                 print this help message to stderr and exit

Input options:
  -n, --transcripts FILE     transcript file(s) in gtf/gff format (may repeat)
  -m, --introns FILE         intron file(s) in bed format (may repeat)
  -y, --feature-type NAME    parse only this feature type in the GTF/GFF
                             (parses all if empty) [exon]
  -s, --transcript-tag NAME  use this attribute tag in the GTF/GFf file(s) as ID
                             to group exons and name paths [transcript_id]
  -l, --haplotypes FILE      project transcripts onto haplotypes in GBWT index
  -z, --gbz-format           input graph is GBZ format (has graph & GBWT index)

Construction options:
  -j, --use-hap-ref          use haplotype paths in GBWT index as references
                             (disables projection)
  -e, --proj-embed-paths     project transcripts onto embedded haplotype paths
  -c, --path-collapse TYPE   collapse identical transcript paths across
                             no|haplotype|all paths [haplotype]
  -k, --max-node-length INT  chop nodes longer than INT (disable with 0) [0]
  -d, --remove-non-gene      remove intergenic and intronic regions
                             (deletes all paths in the graph)
  -o, --do-not-sort          do not topological sort and compact the graph
DON'T FORGET TO EMBED PATHS:
  -r, --add-ref-paths        add reference transcripts as embedded paths
  -a, --add-hap-paths        add projected transcripts as embedded paths

Output options:
  -b, --write-gbwt FILE      write pantranscriptome transcript paths as GBWT
  -v, --write-hap-gbwt FILE  write input haplotypes as a GBWT
                             with node IDs matching the output graph
  -f, --write-fasta FILE     write pantranscriptome transcript sequences to here
  -i, --write-info FILE      write pantranscriptome transcript info table as TSV
  -q, --out-exclude-ref      exclude reference transcripts from pantranscriptome
  -g, --gbwt-bidirectional   use bidirectional paths in GBWT index construction
```


## vg_index

### Tool Description
Creates an index on the specified graph or graphs. All graphs indexed must already be in a joint ID space.

### Metadata
- **Docker Image**: quay.io/biocontainers/vg:1.70.0--h9ee0642_0
- **Homepage**: https://github.com/vgteam/vg
- **Package**: https://anaconda.org/channels/bioconda/packages/vg/overview
- **Validation**: PASS

### Original Help Text
```text
usage: vg index [options] <graph1.vg> [graph2.vg ...]
Creates an index on the specified graph or graphs. All graphs indexed must 
already be in a joint ID space.
general options:
  -h, --help                print this help message to stderr and exit
  -b, --temp-dir DIR        use DIR for temporary files
  -t, --threads N           number of threads to use
  -p, --progress            show progress
xg options:
  -x, --xg-name FILE        use this file to store a succinct, queryable version
                            of graph(s), or read for GCSA or distance indexing
  -L, --xg-alts             include alt paths in XG
gcsa options:
  -g, --gcsa-out FILE       output GCSA2 (FILE) & LCP (FILE.lcp) indexes
  -f, --mapping FILE        use this node mapping in GCSA2 construction
  -k, --kmer-size N         index kmers of size N in the graph [16]
  -X, --doubling-steps N    use N doubling steps for GCSA2 construction [4]
  -Z, --size-limit N        limit temp disk space usage to N GB [2048]
  -V, --verify-index        validate the GCSA2 index using the input kmers
                            (important for testing)
GAM indexing options:
  -l, --index-sorted-gam    input is sorted .gam format alignments,
                            store a GAI index of the sorted GAM in INPUT.gam.gai
vg in-place indexing options:
      --index-sorted-vg     input is ID-sorted .vg format graph chunks
                            store a VGI index of the sorted vg in INPUT.vg.vgi
snarl distance index options
  -j, --dist-name FILE      use this file to store a snarl-based distance index
      --snarl-limit N       don't store distances for snarls > N nodes [50000]
                            if 0 then don't store distances, only the snarl tree
      --no-nested-distance  only store distances along the top-level chain
  -w, --upweight-node N     upweight the node with ID N to push it to be part
                            of a top-level chain (may repeat)
```


## vg_map

### Tool Description
Align reads to a graph.

### Metadata
- **Docker Image**: quay.io/biocontainers/vg:1.70.0--h9ee0642_0
- **Homepage**: https://github.com/vgteam/vg
- **Package**: https://anaconda.org/channels/bioconda/packages/vg/overview
- **Validation**: PASS

### Original Help Text
```text
vg: option '--h' is ambiguous; possibilities: '--hit-max' '--hts-input' '--hap-exp' '--help'
usage: vg map [options] -d idxbase -f in1.fq [-f in2.fq] >aln.gam
Align reads to a graph.

graph/index:
  -d, --base-name BASE             use indexes BASE.xg, BASE.gcsa, and BASE.gbwt
                                   (overrides all other inputs)
  -x, --xg-name FILE               use this XG index or graph [<graph>.vg.xg]
  -g, --gcsa-name FILE             use this GCSA2 index [<graph>.gcsa]
  -1, --gbwt-name FILE             use this GBWT haplotype index [<graph>.gbwt]
algorithm:
  -t, --threads N                  number of compute threads to use
  -k, --min-mem INT                minimum MEM length (if 0 estimate via -e) [0]
  -e, --mem-chance FLOAT           this fraction of -k length hits
                                   will be by chance [5e-4]
  -c, --hit-max N                  ignore MEMs who have >N hits in our index
                                   (0 for no limit) [2048]
  -Y, --max-mem INT                ignore MEMs longer than INT (unset if 0) [0]
  -r, --reseed-x FLOAT             look for internal seeds inside a seed
                                   longer than FLOAT*--min-seed [1.5]
  -u, --try-up-to INT              attempt to align up to the INT best candidate
                                   chains of seeds (1/2 for paired) [128]
  -l, --try-at-least INT           attempt to align at least the INT best
                                   candidate chains of seeds [1]
  -E, --approx-mq-cap INT          weight MQ by suffix tree based estimate
                                   when estimate less than FLOAT [0]
  -7, --id-mq-weight N             scale mapping quality by the alignment score
                                   identity to this power [2]
  -W, --min-chain INT              discard a chain if seeded bases are
                                   shorter than INT [0]
  -C, --drop-chain FLOAT           drop chains shorter than FLOAT fraction of
                                   the longest overlapping chain [0.45]
  -n, --mq-overlap FLOAT           scale MQ by count of alignments with FLOAT
                                   overlap in the query with the primary [0]
  -P, --min-ident FLOAT            accept alignment only if the alignment
                                   identity is >= FLOAT [0]
  -H, --max-target-x N             skip cluster subgraphs with
                                   length > N*read_length [100]
  -w, --band-width INT             band width for long read alignment [256]
  -O, --band-overlap INT           band overlap for long read alignment [{-w}/8]
  -J, --band-jump INT              the maximum number of bands of insertion we
                                   consider in the alignment chain model [128]
  -B, --band-multi INT             consider this many alignments of each band
                                   in banded alignment [16]
  -Z, --band-min-mq INT            treat bands with < INT MQ as unaligned [0]
  -I, --fragment STR               fragment length distribution specification
                                   STR=m:μ:σ:o:d [5000:0:0:0:1]
                                   max:mean:stdev:orientation (1=same/0=flip):
                                   direction (1=forward, 0=backward)
  -U, --fixed-frag-model           don't learn the pair fragment model online,
                                   use -I without update
  -p, --print-frag-model           suppress alignment output and print the
                                   fragment model on stdout as per -I format
  -4, --frag-calc INT              update the fragment model
                                   every INT perfect pairs [10]
  -3, --fragment-x FLOAT           calculate max fragment size as
                                   frag_mean+frag_sd*FLOAT [10]
  -0, --mate-rescues INT           attempt up to INT mate rescues per pair [64]
  -S, --unpaired-cost INT          penalty for an unpaired read pair [17]
  -8, --no-patch-aln               do not patch banded alignments by
                                   locally aligning unaligned regions
      --xdrop-alignment            use X-drop heuristic
                                   (much faster for long-read alignment)
      --max-gap-length INT         maximum gap length allowed in each contiguous
                                   alignment (for X-drop alignment) [40]
scoring:
  -q, --match INT                  use this match score [1]
  -z, --mismatch INT               use this mismatch penalty [4]
      --score-matrix FILE          use this 4x4 integer substitution scoring
                                   matrix (in the order ACGT)
  -o, --gap-open INT               use this gap open penalty [6]
  -y, --gap-extend INT             use this gap extension penalty [1]
  -L, --full-l-bonus INT           the full-length alignment bonus [5]
  -2, --drop-full-l-bonus          remove the full length bonus from the score
                                   before sorting and MQ calculation
  -a, --hap-exp FLOAT              the exponent for haplotype consistency
                                   likelihood in alignment score [1]
      --recombination-penalty NUM  use this log recombination penalty
                                   for GBWT haplotype scoring [20.7]
  -A, --qual-adjust                perform base quality adjusted alignments
                                   (requires base quality input)
preset:
  -m, --alignment-model STR        use a preset alignment scoring model, either
                                   "short" (default) or "long" (ONT/PacBio)
                                   "long" is equivalent to
                                   `-u 2 -L 63 -q 1 -z 2 -o 2 -y 1 -w 128 -O 32`
input:
  -s, --sequence STR               align a string to the graph in graph.vg
                                   using partial order alignment
  -V, --seq-name STR               name the sequence STR
                                   (for graph modification with new named paths)
  -T, --reads FILE                 take reads (one per line) from FILE,
                                   write alignments to stdout
  -b, --hts-input FILE             align reads from stdin htslib-compatible FILE
                                   (BAM/CRAM/SAM), alignments to stdout
  -G, --gam-input FILE             realign GAM input
  -f, --fastq FILE                 input FASTQ or (2-line format) FASTA, maybe
                                   compressed; two allowed, one for each mate
  -F, --fasta FILE                 align the sequences in a FASTA file that may
                                   have multiple lines per reference sequence
      --comments-as-tags           intepret comments in name lines as SAM-style
                                   tags and annotate alignments with them
  -i, --interleaved                FASTQ or GAM is interleaved paired-ended
  -N, --sample NAME                for --reads input, add this sample
  -R, --read-group NAME            for --reads input, add this read group
output:
  -j, --output-json                output JSON rather than an alignment stream
                                   (helpful for debugging)
  -%, --gaf                        output alignments in GAF format
  -5, --surject-to TYPE            surject the output into the graph's paths,
                                   writing TYPE {bam, sam, cram}
      --ref-paths FILE             ordered list of paths in graph, one per line
                                   or HTSlib .dict, for HTSLib @SQ headers
      --ref-name NAME              reference assembly in graph for HTSlib output
  -9, --buffer-size INT            buffer this many alignments together
                                   before outputting in GAM [512]
  -X, --compare                    realign -G GAM input, writing alignment with
                                   "correct" field set to overlap with input
  -v, --refpos-table               for efficient testing output a table of
                                   name, chr, pos, mq, score
  -K, --keep-secondary             produce alignments for secondary input
                                   alignments in addition to primary ones
  -M, --max-multimaps INT          produce up to INT alignments per read [1]
  -Q, --mq-max INT                 cap the mapping quality at INT [60]
      --exclude-unaligned          exclude reads with no alignment
  -D, --debug                      print debugging information to stderr
  -^, --log-time                   print runtime to stderr
  -h, --help                       print this help message to stderr and exit
```


## vg_giraffe

### Tool Description
Fast haplotype-aware read mapper.

### Metadata
- **Docker Image**: quay.io/biocontainers/vg:1.70.0--h9ee0642_0
- **Homepage**: https://github.com/vgteam/vg
- **Package**: https://anaconda.org/channels/bioconda/packages/vg/overview
- **Validation**: PASS

### Original Help Text
```text
vg: option '--h' is ambiguous; possibilities: '--help' '--haplotype-name' '--hit-cap' '--hard-hit-cap'
usage:
  vg giraffe -Z graph.gbz [-d graph.dist [-m graph.withzip.min -z graph.zipcodes]] <input options> [other options] > output.gam
  vg giraffe -Z graph.gbz --haplotype-name graph.hapl --kff-name sample.kff <input options> [other options] > output.gam

Fast haplotype-aware read mapper.

basic options:
  -Z, --gbz-name FILE           map to this GBZ graph
  -m, --minimizer-name FILE     use this minimizer index
  -z, --zipcode-name FILE       use these additional distance hints
  -d, --dist-name FILE          cluster using this distance index
  -p, --progress                show progress
  -t, --threads N               number of mapping threads to use
  -b, --parameter-preset NAME   set computational parameters [default]
                                (chaining-sr / default / fast / hifi / r10 / srold)
  -h, --help                    print full help with all available options
input options:
  -G, --gam-in FILE             read and realign these GAM-format reads
  -f, --fastq-in FILE           read and align these FASTQ/FASTA-format reads
                                (two are allowed, one for each mate)
  -i, --interleaved             GAM/FASTQ/FASTA input is interleaved pairs,
                                for paired-end alignment
      --comments-as-tags        treat comments in name lines as SAM-style tags
                                and annotate alignments with them
haplotype sampling:
      --haplotype-name FILE     sample from haplotype information in FILE
      --kff-name FILE           sample according to kmer counts in FILE
      --index-basename STR      name prefix for generated graph/index files
                                (default: from graph name)
      --set-reference STR       include this sample as a reference
                                in the personalized graph (may repeat)
alternate graphs:
  -x, --xg-name FILE            map to this graph (if no -Z / -g),
                                or use this graph for HTSLib output
  -g, --graph-name FILE         map to this GBWTGraph (if no -Z)
  -H, --gbwt-name FILE          use this GBWT index (when mapping to -x / -g)
output options:
  -N, --sample NAME             add this sample name
  -R, --read-group NAME         add this read group
  -o, --output-format NAME      output the alignments in NAME format [gam]
                                {gam / gaf / json / tsv / SAM / BAM / CRAM} 
      --ref-paths FILE          ordered list of paths in the graph, one per line
                                or HTSlib .dict, for HTSLib @SQ headers
      --ref-name NAME           name of reference in the graph for HTSlib output
      --named-coordinates       make GAM/GAF output in named-segment (GFA) space
  -P, --prune-low-cplx          prune short and low complexity anchors
                                during linear format realignment
      --add-graph-aln           annotate linear formats with graph alignment
                                in the GR tag as a cs-style difference string
      --supplementary           report supplementary alignments in HTSlib output
  -n, --discard                 discard all output alignments (for profiling)
      --output-basename NAME    write output to a GAM file with the given prefix
                                for each setting combination
      --report-name FILE        write a TSV of output file and mapping speed
      --show-work               log how the mapper comes to its conclusions
                                about mapping locations (use one read at a time)
Giraffe parameters:
  -E, --rec-mode                activate giraffe recombination-aware mode
  -A, --rescue-algorithm NAME   use this rescue algorithm [dozeu]
                                {none / dozeu / gssw}
      --fragment-mean FLOAT     force fragment length distribution to have this
                                mean (requires --fragment-stdev)
      --fragment-stdev FLOAT    force fragment length distribution to have this
                                standard deviation (requires --fragment-mean)
      --set-refpos              set refpos field on reads
                                to reference path positions they visit
      --track-provenance        track how internal intermediate alignment
                                candidates were arrived at
      --track-correctness       track if internal intermediate alignment
                                candidates are correct
                                (implies --track-provenance)
      --track-position          coarsely track linear reference positions of
                                good intermediate alignment candidates
                                (implies --track-provenance)
program options:
  --watchdog-timeout INT                             complain after INT seconds working on a read or read pair [10]
  --log-reads                                        log each read being mapped
  -B, --batch-size INT                               complain after INT seconds working on a read or read pair [512]
scoring options:
  --match INT                                        use this match score [1]
  --mismatch INT                                     use this mismatch penalty [4]
  --gap-open INT                                     use this gap open penalty [6]
  --gap-extend INT                                   use this gap extension penalty [1]
  --full-l-bonus INT                                 the full-length alignment bonus [5]
result options:
  -M, --max-multimaps INT                            produce up to INT alignments for each read [1]
computational parameters:
  -c, --hit-cap INT                                  use all minimizers with at most INT hits [10]
  -C, --hard-hit-cap INT                             ignore all minimizers with more than INT hits [500]
  -F, --score-fraction FLOAT                         select minimizers between hit caps until score is FLOAT of total [0.9]
  -U, --max-min INT                                  use at most INT minimizers, 0 for no limit [500]
  --min-coverage-flank INT                           when trying to cover the read with minimizers, count INT towards the coverage of each minimizer on each side [250]
  --num-bp-per-min INT                               use maximum of number minimizers calculated by READ_LENGTH / INT and --max-min [1000]
  --downsample-window-length INT                     maximum window length for downsampling [18446744073709551615]
  --downsample-window-count INT                      downsample minimizers with windows of length read_length/INT, 0 for no downsampling [0]
  -D, --distance-limit INT                           cluster using this distance limit [200]
  -e, --max-extensions INT                           extend up to INT clusters [800]
  -a, --max-alignments INT                           align up to INT extensions [8]
  -s, --cluster-score FLOAT                          only extend clusters if they are within INT of the best score [50]
  -S, --pad-cluster-score FLOAT                      also extend clusters within INT of above threshold to get a second-best cluster [20]
  -u, --cluster-coverage FLOAT                       only extend clusters if they are within FLOAT of the best read coverage [0.3]
  --max-extension-mismatches INT                     maximum number of mismatches to pass through in a gapless extension [4]
  -v, --extension-score INT                          only align extensions if their score is within INT of the best score [1]
  -w, --extension-set FLOAT                          only align extension sets if their score is within INT of the best score [20]
  -O, --no-dp                                        disable all gapped alignment
  -r, --rescue-attempts INT                          attempt up to INT rescues per read in a pair [15]
  -L, --max-fragment-length INT                      assume that fragment lengths should be smaller than INT when estimating the fragment length distribution [2000]
  --exclude-overlapping-min                          exclude overlapping minimizers
  --paired-distance-limit FLOAT                      cluster pairs of read using a distance limit FLOAT standard deviations greater than the mean [2]
  --rescue-subgraph-size FLOAT                       search for rescued alignments FLOAT standard deviations greater than the mean [4]
  --rescue-seed-limit INT                            attempt rescue with at most INT seeds [100]
  --explored-cap                                     use explored minimizer layout cap on mapping quality
  --mapq-score-window INT                            window to rescale score to for mapping quality, or 0 if not used [0]
  --mapq-score-scale FLOAT                           scale scores for mapping quality [1]
long-read/chaining parameters:
  --align-from-chains                                chain up extensions to create alignments, instead of doing each separately
  --zipcode-tree-score-threshold FLOAT               only fragment trees if they are within INT of the best score [50]
  --pad-zipcode-tree-score-threshold FLOAT           also fragment trees within INT of above threshold to get a second-best cluster [20]
  --zipcode-tree-coverage-threshold FLOAT            only fragment trees if they are within FLOAT of the best read coverage [0.3]
  --zipcode-tree-scale FLOAT                         at what fraction of the read length should zipcode trees be split up [2]
  --min-to-fragment INT                              minimum number of fragmenting problems to run [4]
  --max-to-fragment INT                              maximum number of fragmenting problems to run [10]
  --max-direct-chain INT                             take up to this many fragments per zipcode tree and turn them into chains instead of chaining. If this is 0, do chaining. [0]
  --gapless-extension-limit INT                      do gapless extension to seeds in a tree before fragmenting if the read length is less than this [0]
  --fragment-max-graph-lookback-bases INT            maximum distance to look back in the graph when making fragments [300]
  --fragment-max-graph-lookback-bases-per-base FLOAT maximum distance to look back in the graph when making fragments, per base [0.03]
  --fragment-max-read-lookback-bases INT             maximum distance to look back in the read when making fragments [18446744073709551615]
  --fragment-max-read-lookback-bases-per-base FLOAT  maximum distance to look back in the read when making fragments, per base [1]
  --max-fragments INT                                how many fragments should we try to make when fragmenting something [18446744073709551615]
  --fragment-max-indel-bases INT                     maximum indel length in a transition when making fragments [2000]
  --fragment-max-indel-bases-per-base FLOAT          maximum indel length in a transition when making fragments, per read base [0.2]
  --fragment-gap-scale FLOAT                         scale for gap scores when fragmenting [1]
  --fragment-points-per-possible-match FLOAT         points to award non-indel connecting bases when fragmenting [0]
  --fragment-score-fraction FLOAT                    minimum fraction of best fragment score to retain a fragment [0.1]
  --fragment-max-min-score FLOAT                     maximum for fragment score threshold based on the score of the best fragment [1.79769e+308]
  --fragment-min-score FLOAT                         minimum score to retain a fragment [60]
  --fragment-set-score-threshold FLOAT               only chain fragments in a tree if their overall score is within this many points of the best tree [0]
  --min-chaining-problems INT                        ignore score threshold to get this many chaining problems [1]
  --max-chaining-problems INT                        do no more than this many chaining problems [2147483647]
  --max-graph-lookback-bases INT                     maximum distance to look back in the graph when chaining [3000]
  --max-graph-lookback-bases-per-base FLOAT          maximum distance to look back in the graph when chaining, per read base [0.3]
  --max-read-lookback-bases INT                      maximum distance to look back in the read when chaining [18446744073709551615]
  --max-read-lookback-bases-per-base FLOAT           maximum distance to look back in the read when chaining, per read base [1]
  --max-indel-bases INT                              maximum indel length in a transition when chaining [2000]
  --max-indel-bases-per-base FLOAT                   maximum indel length in a transition when chaining, per read base [0.2]
  --item-bonus INT                                   bonus for taking each item when fragmenting or chaining [0]
  --item-scale FLOAT                                 scale for items' scores when fragmenting or chaining [1]
  --gap-scale FLOAT                                  scale for gap scores when chaining [1]
  --rec-penalty-chain INT                            penalty for a recombination when chaining, requires -E (ALPHA) [0]
  --rec-penalty-fragment INT                         penalty for a recombination when fragmenting, requires -E (ALPHA) [0]
  --points-per-possible-match FLOAT                  points to award non-indel connecting bases when chaining [0]
  --chain-score-threshold FLOAT                      only align chains if their score is within this many points of the best score [100]
  --min-chains INT                                   ignore score threshold to get this many chains aligned [4]
  --min-chain-score-per-base FLOAT                   do not align chains with less than this score per read base [0.01]
  --max-min-chain-score INT                          accept chains with this score or more regardless of read length [200]
  --max-skipped-bases INT                            when skipping seeds in a chain for alignment, allow a gap of at most INT in the graph [0]
  --max-chains-per-tree INT                          align up to this many chains from each tree [1]
  --max-chain-connection INT                         maximum distance across which to connect seeds with WFAExtender when aligning a chain [100]
  --max-tail-length INT                              maximum length of a tail to align with WFAExtender when aligning a chain [100]
  --max-dp-cells INT                                 maximum number of alignment cells to allow in a tail or BGA connection [18446744073709551615]
  --max-tail-gap INT                                 maximum number of gap bases to allow in a Dozeu tail [18446744073709551615]
  --max-middle-gap INT                               maximum number of gap bases to allow in a middle connection [18446744073709551615]
  --max-tail-dp-length INT                           maximum number of bases in a tail to do DP for, to avoid score overflow [30000]
  --max-middle-dp-length INT                         maximum number of bases in a middle connection to do DP for, before making it a tail [2147483647]
  --wfa-max-mismatches INT                           maximum mismatches (or equivalent-scoring gaps) to allow in the shortest WFA connection or tail [2]
  --wfa-max-mismatches-per-base FLOAT                maximum additional mismatches (or equivalent-scoring gaps) to allow per involved read base in WFA connections or tails [0.1]
  --wfa-max-max-mismatches INT                       maximum mismatches (or equivalent-scoring gaps) to allow in the longest WFA connection or tail [20]
  --wfa-distance INT                                 band distance to allow in the shortest WFA connection or tail [10]
  --wfa-distance-per-base FLOAT                      band distance to allow per involved read base in WFA connections or tails [0.1]
  --wfa-max-distance INT                             band distance to allow in the longest WFA connection or tail [200]
  --softclip-penalty FLOAT                           penalize candidate alignment scores this many points per softclipped base [0]
  --sort-by-chain-score                              order alignment candidates by chain score instead of base-level score
  --min-unique-node-fraction FLOAT                   minimum fraction of an alignment that must be from distinct oriented nodes for the alignment to be distinct [0]
```


## vg_mpmap

### Tool Description
Multipath align reads to a graph.

### Metadata
- **Docker Image**: quay.io/biocontainers/vg:1.70.0--h9ee0642_0
- **Homepage**: https://github.com/vgteam/vg
- **Package**: https://anaconda.org/channels/bioconda/packages/vg/overview
- **Validation**: PASS

### Original Help Text
```text
vg: option '--h' is ambiguous; possibilities: '--help' '--hit-max' '--hard-hit-mult'
usage: vg mpmap [options] -x graph.xg -g index.gcsa [-f reads1.fq [-f reads2.fq] | -G reads.gam] > aln.gamp
Multipath align reads to a graph.

basic options:
  -h, --help                print this help message to stderr and exit
graph/index:
  -x, --graph-name FILE     graph (required; XG recommended but other formats
                            are acceptable: see `vg convert`)
  -g, --gcsa-name FILE      use this GCSA2 (FILE) & LCP (FILE.lcp) index pair
                            for MEMs (required; see `vg index`)
  -d, --dist-name FILE      use this snarl distance index for clustering
                            (recommended, see `vg index`)
  -s, --snarls FILE         align to alternate paths in these snarls
                            (unnecessary if providing -d, see `vg snarls`)
input:
  -f, --fastq FILE          input FASTQ (possibly gzipped), can be given twice
                            for paired ends (for stdin use -)
  -i, --interleaved         input contains interleaved paired ends
  -C, --comments-as-tags    intepret comments in name lines as SAM-style tags
                            and annotate alignments with them
algorithm presets:
  -n, --nt-type TYPE        sequence type preset: 'DNA' for genomic data,
                            'RNA' for transcriptomic data [RNA]
  -l, --read-length TYPE    read length preset: {very-short, short, long}
                            (approx. <50bp, 50-500bp, and >500bp) [short]
  -e, --error-rate TYPE     error rate preset: {low, high}
                            (approx. PHRED >20 and <20) [low]
output:
  -F, --output-fmt TYPE     format to output alignments in:
                            'GAMP' for multipath alignments,
                            'GAM'/'GAF' for single-path alignments,
                            'SAM'/'BAM'/'CRAM' for linear reference alignments
                            (may also require -S) [GAMP]
  -S, --ref-paths FILE      paths in graph are 1) one per line in a text file
                            or 2) in an HTSlib .dict, to treat as
                            reference sequences for HTSlib formats (see -F)
                            [all reference paths, all generic paths]
      --ref-name NAME       reference assembly in graph to use for
                            HTSlib formats (see -F) [all references]
  -N, --sample NAME         add this sample name to output
  -R, --read-group NAME     add this read group to output
  -p, --suppress-progress   do not report progress to stderr
computational parameters:
  -t, --threads INT         number of compute threads to use [all available]

advanced options:
algorithm:
  -X, --not-spliced         do not form spliced alignments, even with -n RNA
  -M, --max-multimaps INT   report up to INT mappings per read [10 RNA / 1 DNA]
  -a, --agglomerate-alns    combine separate multipath alignments into
                            one (possibly disconnected) alignment
  -r, --intron-distr FILE   intron length distribution
                            (from scripts/intron_length_distribution.py)
  -Q, --mq-max INT          cap mapping quality estimates at this much [60]
  -b, --frag-sample INT     look for INT unambiguous mappings to
                            estimate the fragment length distribution [1000]
  -I, --frag-mean FLOAT     mean for pre-determined fragment length distribution
                            (also requires -D)
  -D, --frag-stddev FLOAT   standard deviation for pre-determined fragment
                            length distribution (also requires -I)
  -G, --gam-input FILE      input GAM (for stdin, use -)
  -u, --map-attempts INT    perform up to INT mappings per read (0 for no limit)
                            [24 paired / 64 unpaired]
  -c, --hit-max INT         use at most this many hits for any match seeds
                            (0 for no limit) [1024 DNA / 100 RNA]
scoring:
  -A, --no-qual-adjust      do not perform base quality adjusted alignments
                            even when base qualities are available
  -q, --match INT           use INT match score [1]
  -z, --mismatch INT        use INT mismatch penalty [4 low error, 1 high error]
  -o, --gap-open INT        use INT gap open penalty [6 low error, 1 high error]
  -y, --gap-extend INT      use INT gap extension penalty [1]
  -L, --full-l-bonus INT    add INT score to alignments that align each
                            end of the read [mismatch+1 short, 0 long]
  -w, --score-matrix FILE   use this 4x4 integer substitution scoring matrix
                            (in the order ACGT)
  -m, --remove-bonuses      remove full length alignment bonus in reported score
```


## vg_augment

### Tool Description
Embed GAM alignments into a graph to facilitate variant calling

### Metadata
- **Docker Image**: quay.io/biocontainers/vg:1.70.0--h9ee0642_0
- **Homepage**: https://github.com/vgteam/vg
- **Package**: https://anaconda.org/channels/bioconda/packages/vg/overview
- **Validation**: PASS

### Original Help Text
```text
usage: vg augment [options] <graph.vg> [alignment.gam] > augmented_graph.vg
Embed GAM alignments into a graph to facilitate variant calling

general options:
  -i, --include-paths        merge paths implied by alignments into the graph
  -S, --keep-softclips       include softclips from alignments (cut by default)
  -B, --label-paths          use alignments only to label graph, not augment
  -Z, --translation FILE     save translations from augmented back to base graph
  -A, --alignment-out FILE   save augmented GAM reads
  -F, --gaf                  expect (and write) GAF instead of GAM
  -s, --subgraph             graph is a subgraph of the one used to create GAM.
                             ignore alignments with missing nodes
  -m, --min-coverage N       minimum coverage of a breakpoint required for it
                             to be added to the graph
  -c, --expected-cov N       expected coverage, used for memory tuning [128]
  -q, --min-baseq N          ignore edits with mean base quality < N
  -Q, --min-mapq N           ignore alignments with mapping quality < N
  -N, --max-n FLOAT          maximum fraction of N bases in an edit
                             for it to be included [0.25]
  -E, --edges-only           only edges implied by reads, ignoring edits
  -h, --help                 print this help message to stderr and exit
  -p, --progress             show progress
  -v, --verbose              print info and warnings about VCF generation
  -t, --threads N            number of threads (for 1st pass with -m or -q)
loci file options:
  -l, --include-loci FILE    merge all alleles in loci into the graph
  -L, --include-gt FILE      merge only alleles in called genotypes into graph
```


## vg_pack

### Tool Description
Compresses alignments into coverage packs.

### Metadata
- **Docker Image**: quay.io/biocontainers/vg:1.70.0--h9ee0642_0
- **Homepage**: https://github.com/vgteam/vg
- **Package**: https://anaconda.org/channels/bioconda/packages/vg/overview
- **Validation**: PASS

### Original Help Text
```text
usage: vg pack [options]
options:
  -x, --xg FILE          use this basis graph (does not have to be xg format)
  -o, --packs-out FILE   write compressed coverage packs to this output file
  -i, --packs-in FILE    begin by summing coverage packs from each provided FILE
  -g, --gam FILE         read alignments from this GAM file ('-' for stdin)
  -a, --gaf FILE         read alignments from this GAF file ('-' for stdin)
  -d, --as-table         write table on stdout representing packs
  -D, --as-edge-table    write table on stdout representing edge coverage
  -u, --as-qual-table    write table on stdout representing average node mapqs
  -e, --with-edits       record and write edits
                         rather than only recording graph-matching coverage
  -b, --bin-size N       number of sequence bases per CSA bin [inf]
  -n, --node ID          write table for only specified node(s)
  -N, --node-list FILE   white space or line delimited list of nodes to collect
  -Q, --min-mapq N       ignore reads with MAPQ < N
                         and positions with base quality < N [0]
  -c, --expected-cov N   expected coverage.  used only for memory tuning [128]
  -s, --trim-ends N      ignore the first and last N bases of each read
  -t, --threads N        use N threads [numCPUs]
  -h, --help             print this help message to stderr and exit
```


## vg_call

### Tool Description
Call variants or genotype known variants

### Metadata
- **Docker Image**: quay.io/biocontainers/vg:1.70.0--h9ee0642_0
- **Homepage**: https://github.com/vgteam/vg
- **Package**: https://anaconda.org/channels/bioconda/packages/vg/overview
- **Validation**: PASS

### Original Help Text
```text
vg: option '--h' is ambiguous; possibilities: '--het-bias' '--help'
usage: vg call [options] <graph> > output.vcf
Call variants or genotype known variants

support calling options:
  -k, --pack FILE           supports created from vg pack for given input graph
  -m, --min-support M,N     min allele (M) and site (N) support to call [2,4]
  -e, --baseline-error X,Y  baseline error rates for Poisson model for small (X)
                            and large (Y) variants [0.005,0.01]
  -B, --bias-mode           use old ratio-based genotyping algorithm
                            as opposed to probablistic model
  -b, --het-bias M,N        homozygous alt/ref allele must have >= M/N times
                            more support than the next best allele [6,6]
GAF options:
  -G, --gaf                 output GAF genotypes instead of VCF
  -T, --traversals          output all candidate traversals in GAF
                            without doing any genotyping
  -M, --trav-padding N      extend each flank of traversals (from -T) with
                            reference path by N bases if possible
general options:
  -v, --vcf FILE            VCF file to genotype (must have been used
                            to construct input graph with -a)
  -a, --genotype-snarls     genotype every snarl, including reference calls
                            (use to compare multiple samples)
  -A, --all-snarls          genotype all snarls, including nested child snarls
                            (like deconstruct -a)
  -c, --min-length N        genotype only snarls with
                            at least one traversal of length >= N
  -C, --max-length N        genotype only snarls where
                            all traversals have length <= N
  -f, --ref-fasta FILE      reference FASTA
                            (required if VCF has symbolic deletions/inversions)
  -i, --ins-fasta FILE      insertions (required if VCF has symbolic insertions)
  -s, --sample NAME         sample name [SAMPLE]
  -r, --snarls FILE         snarls (from vg snarls) to avoid recomputing.
  -g, --gbwt FILE           only call genotypes present in given GBWT index
  -z, --gbz                 only call genotypes present in GBZ index
                            (applies only if input graph is GBZ)
  -N, --translation FILE    node ID translation (from vg gbwt --translation)
                            to apply to snarl names in output
  -O, --gbz-translation     use the ID translation from the input GBZ to
                            apply snarl names to snarl names/AT fields in output
  -p, --ref-path NAME       reference path to call on (may repeat; default all)
  -S, --ref-sample NAME     call on all paths with this sample
                            (cannot use with -p)
  -o, --ref-offset N        offset in reference path (may repeat; 1 per path)
  -l, --ref-length N        override reference length for output VCF contig
  -d, --ploidy N            ploidy of sample. {1, 2} [2]
  -R, --ploidy-regex RULES  use this comma-separated list of colon-delimited
                            REGEX:PLOIDY rules to assign ploidies to contigs
                            not visited by the selected samples, or to all
                            contigs simulated from if no samples are used.
                            Unmatched contigs get ploidy 2 (or that from -d).
  -n, --nested              activate nested calling mode (experimental)
  -I, --chains              call chains instead of snarls (experimental)
      --progress            show progress
  -t, --threads N           number of threads to use
  -h, --help                print this help message to stderr and exit
```

