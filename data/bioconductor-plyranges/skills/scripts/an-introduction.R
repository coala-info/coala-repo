# Code example from 'an-introduction' vignette. See references/ for full tutorial.

## -----------------------------------------------------------------------------
suppressPackageStartupMessages(library(plyranges))
set.seed(100)
df <- data.frame(start=c(2:-1, 13:15),
                 width=c(0:3, 2:0))

# produces IRanges
rng <- df %>% as_iranges()
rng


## -----------------------------------------------------------------------------
# seqname is required for GRanges, metadata is automatically kept
grng <- df %>%
  transform(seqnames = sample(c("chr1", "chr2"), 7, replace = TRUE),
         strand = sample(c("+", "-"), 7, replace = TRUE),
         gc = runif(7)) %>%
  as_granges()

grng

## ----anchor_fig, echo = FALSE, out.width="400px", fig.align="center"----------
knitr::include_graphics("anchors.png", dpi = 150)

## -----------------------------------------------------------------------------
rng <- as_iranges(data.frame(start=c(1, 2, 3), end=c(5, 2, 8)))
grng <- as_granges(data.frame(start=c(1, 2, 3), end=c(5, 2, 8),
                          seqnames = "seq1",
                          strand = c("+", "*", "-")))
mutate(rng, width = 10)
mutate(anchor_start(rng), width = 10)
mutate(anchor_end(rng), width = 10)
mutate(anchor_center(rng), width = 10)
mutate(anchor_3p(grng), width = 10) # leave negative strand fixed
mutate(anchor_5p(grng), width = 10) # leave positive strand fixed

## -----------------------------------------------------------------------------
rng2 <- stretch(anchor_center(rng), 10)
rng2
stretch(anchor_end(rng2), 10)
stretch(anchor_start(rng2), 10)
stretch(anchor_3p(grng), 10)
stretch(anchor_5p(grng), 10)

## -----------------------------------------------------------------------------
shift_left(rng, 100)
shift_right(rng, 100)
shift_upstream(grng, 100)
shift_downstream(grng, 100)

## -----------------------------------------------------------------------------
grng <- data.frame(seqnames = sample(c("chr1", "chr2"), 7, replace = TRUE),
         strand = sample(c("+", "-"), 7, replace = TRUE),
         gc = runif(7),
         start = 1:7,
         width = 10) %>%
  as_granges()

grng_by_strand <- grng %>%
  group_by(strand)

grng_by_strand

## -----------------------------------------------------------------------------
grng %>% filter(gc < 0.3)
# filtering by group
grng_by_strand %>% filter(gc == max(gc))

## -----------------------------------------------------------------------------
ir0 <- data.frame(start = c(5,10, 15,20), width = 5) %>%
  as_iranges()
ir1 <- data.frame(start = 2:6, width = 3:7) %>%
  as_iranges()
ir0
ir1
ir0 %>% filter_by_overlaps(ir1)
ir0 %>% filter_by_non_overlaps(ir1)

## -----------------------------------------------------------------------------
ir1 <- ir1 %>%
  mutate(gc = runif(length(.)))

ir0 %>%
  group_by_overlaps(ir1) %>%
  summarise(gc = mean(gc))

## -----------------------------------------------------------------------------
query <- data.frame(seqnames = "chr1",
               strand = c("+", "-"),
               start = c(1, 9),
               end =  c(7, 10),
               key.a = letters[1:2]) %>%
  as_granges()

subject <- data.frame(seqnames = "chr1",
               strand = c("-", "+"),
               start = c(2, 6),
               end = c(4, 8),
               key.b = LETTERS[1:2]) %>%
  as_granges()

## ----olap, echo = FALSE, fig.cap = "Query and Subject Ranges", message = FALSE----
library(ggplot2)
query_df <- as.data.frame(query)[, -6]
query_df$key <- "Query"
subject_df <- as.data.frame(subject)[, -6]
subject_df$key <- "Subject"
melted_ranges <- rbind(query_df, subject_df)
ggplot(melted_ranges, aes(xmin = start, xmax = end, ymin = 1, ymax = 3)) +
  geom_rect() +
  facet_grid(key ~ .) +
  scale_x_continuous(breaks = seq(1, 10, by = 1)) +
  xlab("Position") +
  theme(axis.text.y = element_blank(),
        axis.ticks.y = element_blank(),
        axis.title.y = element_blank())

## ----olaps-diagram, echo = FALSE, out.width="600px"---------------------------
knitr::include_graphics("olaps.png")

## -----------------------------------------------------------------------------
intersect_rng <- join_overlap_intersect(query, subject)
intersect_rng

## ----intersect-join, echo = FALSE, fig.cap="Intersect Join"-------------------
intersect_df <- as.data.frame(intersect_rng)[, -c(6,7)]
intersect_df$key <- "Intersect Join"
melted_ranges <- rbind(query_df, subject_df, intersect_df)
melted_ranges$key <- factor(melted_ranges$key,
                              levels = c("Query", "Subject", "Intersect Join"))
ggplot(melted_ranges, aes(xmin = start, xmax = end, ymin = 1, ymax = 3)) +
  geom_rect() +
  facet_grid(key ~ .) +
  scale_x_continuous(breaks = seq(1, 10, by = 1)) +
  xlab("Position") +
  theme(axis.text.y = element_blank(),
        axis.ticks.y = element_blank(),
        axis.title.y = element_blank())

## -----------------------------------------------------------------------------
inner_rng <- join_overlap_inner(query, subject)
inner_rng

## ----inner-join, echo = FALSE, fig.cap = "Inner Join", message = FALSE--------
inner_df <- as.data.frame(inner_rng)[, -c(6,7)]
inner_df$ymin <- c(1,4)
inner_df$ymax <- c(3,6)
inner_df$key <- "Inner Join"
melted_ranges <- rbind(query_df, subject_df)
melted_ranges$ymin <- 1
melted_ranges$ymax <- 3
melted_ranges <- rbind(melted_ranges, inner_df)
melted_ranges$key <- factor(melted_ranges$key,
                              levels = c("Query", "Subject", "Inner Join"))

ggplot(melted_ranges, aes(xmin = start, xmax = end, ymin = ymin, ymax = ymax)) +
  geom_rect() +
  facet_grid(key ~ ., scales = "free_y") +
  scale_x_continuous(breaks = seq(1, 10, by = 1)) +
  xlab("Position") +
  theme(axis.text.y = element_blank(),
        axis.ticks.y = element_blank(),
        axis.title.y = element_blank())

## -----------------------------------------------------------------------------
find_overlaps(query, subject)

## -----------------------------------------------------------------------------
left_rng <- join_overlap_left(query, subject)
left_rng

## ----olap-left, echo = FALSE, fig.cap = "Left Join", message = FALSE----------
left_df <- as.data.frame(left_rng)[, -c(6,7)]
left_df$ymin <- c(1,4, 1)
left_df$ymax <- c(3,6, 3)
left_df$key <- "Left Join"
melted_ranges <- rbind(query_df, subject_df)
melted_ranges$ymin <- 1
melted_ranges$ymax <- 3
melted_ranges <- rbind(melted_ranges, left_df)
melted_ranges$key <- factor(melted_ranges$key,
                              levels = c("Query", "Subject", "Left Join"))

ggplot(melted_ranges,
       aes(xmin = start, xmax = end, ymin = ymin, ymax = ymax)) +
  geom_rect() +
  facet_grid(key ~ ., scales = "free_y") +
  scale_x_continuous(breaks = seq(1, 10, by = 1)) +
  xlab("Position") +
  theme(axis.text.y = element_blank(),
        axis.ticks.y = element_blank(),
        axis.title.y = element_blank())

## ----neigbours, echo = FALSE, out.width="600px"-------------------------------
knitr::include_graphics("neighbours.png")

## -----------------------------------------------------------------------------
join_nearest(ir0, ir1)
join_follow(ir0, ir1)
join_precede(ir0, ir1) # nothing precedes returns empty `Ranges`
join_precede(ir1, ir0)

## ----ex1----------------------------------------------------------------------
intensities <- data.frame(seqnames = "VI",
                          start = c(3320:3321,3330:3331,3341:3342),
                          width = 1) %>%
  as_granges()

intensities

genes <- data.frame(seqnames = "VI",
                    start = c(3322, 3030),
                    end = c(3846, 3338),
                    gene_id=c("YFL064C", "YFL065C")) %>%
  as_granges()

genes

## -----------------------------------------------------------------------------
olap <- join_overlap_inner(intensities, genes) %>%
  select(gene_id)
olap

## -----------------------------------------------------------------------------
olap %>%
  group_by(start) %>%
  summarise(n = n())

## -----------------------------------------------------------------------------
grp_by_olap <- ir0 %>%
  group_by_overlaps(ir1)
grp_by_olap
grp_by_olap %>%
  mutate(n_overlaps = n())

## -----------------------------------------------------------------------------
ir0 %>%
  mutate(n_overlaps = count_overlaps(., ir1))

## -----------------------------------------------------------------------------
sessionInfo()

