[ ]
[ ]

[Skip to content](#capcruncher.api.filter)

CapCruncher Documentation

filter

Initializing search

[GitHub](https://github.com/sims-lab/CapCruncher "Go to repository")

CapCruncher Documentation

[GitHub](https://github.com/sims-lab/CapCruncher "Go to repository")

* [Home](../../../..)
* [Installation](../../../../installation/)
* [Pipeline](../../../../pipeline/)
* [Cluster Setup](../../../../cluster_config/)
* [Hints and Tips](../../../../tips/)
* [Plotting CapCruncher output](../../../../plotting/)
* [CLI Reference](../../../../cli/)
* [x]

  API Reference

  API Reference
  + [x]

    capcruncher

    capcruncher
    - [x]

      api

      api
      * [annotate](../annotate/)
      * [deduplicate](../deduplicate/)
      * [ ]

        filter

        [filter](./)

        Table of contents
        + [filter](#capcruncher.api.filter)
        + [CCSliceFilter](#capcruncher.api.filter.CCSliceFilter)

          - [capture\_site\_stats](#capcruncher.api.filter.CCSliceFilter.capture_site_stats)
          - [captures](#capcruncher.api.filter.CCSliceFilter.captures)
          - [cis\_or\_trans\_stats](#capcruncher.api.filter.CCSliceFilter.cis_or_trans_stats)
          - [frag\_stats](#capcruncher.api.filter.CCSliceFilter.frag_stats)
          - [fragments](#capcruncher.api.filter.CCSliceFilter.fragments)
          - [merged\_captures\_and\_reporters](#capcruncher.api.filter.CCSliceFilter.merged_captures_and_reporters)
          - [remove\_multi\_capture\_fragments](#capcruncher.api.filter.CCSliceFilter.remove_multi_capture_fragments)
          - [remove\_non\_reporter\_fragments](#capcruncher.api.filter.CCSliceFilter.remove_non_reporter_fragments)
          - [remove\_viewpoint\_adjacent\_restriction\_fragments](#capcruncher.api.filter.CCSliceFilter.remove_viewpoint_adjacent_restriction_fragments)
        + [SliceFilter](#capcruncher.api.filter.SliceFilter)

          - [filter\_stats](#capcruncher.api.filter.SliceFilter.filter_stats)
          - [filters](#capcruncher.api.filter.SliceFilter.filters)
          - [fragments](#capcruncher.api.filter.SliceFilter.fragments)
          - [read\_stats](#capcruncher.api.filter.SliceFilter.read_stats)
          - [reporters](#capcruncher.api.filter.SliceFilter.reporters)
          - [slice\_stats](#capcruncher.api.filter.SliceFilter.slice_stats)
          - [\_\_init\_\_](#capcruncher.api.filter.SliceFilter.__init__)
          - [filter\_slices](#capcruncher.api.filter.SliceFilter.filter_slices)
          - [get\_unfiltered\_slices](#capcruncher.api.filter.SliceFilter.get_unfiltered_slices)
          - [remove\_blacklisted\_slices](#capcruncher.api.filter.SliceFilter.remove_blacklisted_slices)
          - [remove\_duplicate\_re\_frags](#capcruncher.api.filter.SliceFilter.remove_duplicate_re_frags)
          - [remove\_duplicate\_slices](#capcruncher.api.filter.SliceFilter.remove_duplicate_slices)
          - [remove\_duplicate\_slices\_pe](#capcruncher.api.filter.SliceFilter.remove_duplicate_slices_pe)
          - [remove\_excluded\_slices](#capcruncher.api.filter.SliceFilter.remove_excluded_slices)
          - [remove\_orphan\_slices](#capcruncher.api.filter.SliceFilter.remove_orphan_slices)
          - [remove\_slices\_without\_re\_frag\_assigned](#capcruncher.api.filter.SliceFilter.remove_slices_without_re_frag_assigned)
          - [remove\_unmapped\_slices](#capcruncher.api.filter.SliceFilter.remove_unmapped_slices)
        + [TiledCSliceFilter](#capcruncher.api.filter.TiledCSliceFilter)

          - [captures](#capcruncher.api.filter.TiledCSliceFilter.captures)
          - [cis\_or\_trans\_stats](#capcruncher.api.filter.TiledCSliceFilter.cis_or_trans_stats)
          - [remove\_dual\_capture\_fragments](#capcruncher.api.filter.TiledCSliceFilter.remove_dual_capture_fragments)
          - [remove\_non\_capture\_fragments](#capcruncher.api.filter.TiledCSliceFilter.remove_non_capture_fragments)
          - [remove\_slices\_outside\_capture](#capcruncher.api.filter.TiledCSliceFilter.remove_slices_outside_capture)
        + [TriCSliceFilter](#capcruncher.api.filter.TriCSliceFilter)

          - [remove\_slices\_with\_one\_reporter](#capcruncher.api.filter.TriCSliceFilter.remove_slices_with_one_reporter)
      * [io](../io/)
      * [pileup](../pileup/)
      * [plotting](../plotting/)
      * [statistics](../statistics/)
      * [storage](../storage/)

Table of contents

* [filter](#capcruncher.api.filter)
* [CCSliceFilter](#capcruncher.api.filter.CCSliceFilter)

  + [capture\_site\_stats](#capcruncher.api.filter.CCSliceFilter.capture_site_stats)
  + [captures](#capcruncher.api.filter.CCSliceFilter.captures)
  + [cis\_or\_trans\_stats](#capcruncher.api.filter.CCSliceFilter.cis_or_trans_stats)
  + [frag\_stats](#capcruncher.api.filter.CCSliceFilter.frag_stats)
  + [fragments](#capcruncher.api.filter.CCSliceFilter.fragments)
  + [merged\_captures\_and\_reporters](#capcruncher.api.filter.CCSliceFilter.merged_captures_and_reporters)
  + [remove\_multi\_capture\_fragments](#capcruncher.api.filter.CCSliceFilter.remove_multi_capture_fragments)
  + [remove\_non\_reporter\_fragments](#capcruncher.api.filter.CCSliceFilter.remove_non_reporter_fragments)
  + [remove\_viewpoint\_adjacent\_restriction\_fragments](#capcruncher.api.filter.CCSliceFilter.remove_viewpoint_adjacent_restriction_fragments)
* [SliceFilter](#capcruncher.api.filter.SliceFilter)

  + [filter\_stats](#capcruncher.api.filter.SliceFilter.filter_stats)
  + [filters](#capcruncher.api.filter.SliceFilter.filters)
  + [fragments](#capcruncher.api.filter.SliceFilter.fragments)
  + [read\_stats](#capcruncher.api.filter.SliceFilter.read_stats)
  + [reporters](#capcruncher.api.filter.SliceFilter.reporters)
  + [slice\_stats](#capcruncher.api.filter.SliceFilter.slice_stats)
  + [\_\_init\_\_](#capcruncher.api.filter.SliceFilter.__init__)
  + [filter\_slices](#capcruncher.api.filter.SliceFilter.filter_slices)
  + [get\_unfiltered\_slices](#capcruncher.api.filter.SliceFilter.get_unfiltered_slices)
  + [remove\_blacklisted\_slices](#capcruncher.api.filter.SliceFilter.remove_blacklisted_slices)
  + [remove\_duplicate\_re\_frags](#capcruncher.api.filter.SliceFilter.remove_duplicate_re_frags)
  + [remove\_duplicate\_slices](#capcruncher.api.filter.SliceFilter.remove_duplicate_slices)
  + [remove\_duplicate\_slices\_pe](#capcruncher.api.filter.SliceFilter.remove_duplicate_slices_pe)
  + [remove\_excluded\_slices](#capcruncher.api.filter.SliceFilter.remove_excluded_slices)
  + [remove\_orphan\_slices](#capcruncher.api.filter.SliceFilter.remove_orphan_slices)
  + [remove\_slices\_without\_re\_frag\_assigned](#capcruncher.api.filter.SliceFilter.remove_slices_without_re_frag_assigned)
  + [remove\_unmapped\_slices](#capcruncher.api.filter.SliceFilter.remove_unmapped_slices)
* [TiledCSliceFilter](#capcruncher.api.filter.TiledCSliceFilter)

  + [captures](#capcruncher.api.filter.TiledCSliceFilter.captures)
  + [cis\_or\_trans\_stats](#capcruncher.api.filter.TiledCSliceFilter.cis_or_trans_stats)
  + [remove\_dual\_capture\_fragments](#capcruncher.api.filter.TiledCSliceFilter.remove_dual_capture_fragments)
  + [remove\_non\_capture\_fragments](#capcruncher.api.filter.TiledCSliceFilter.remove_non_capture_fragments)
  + [remove\_slices\_outside\_capture](#capcruncher.api.filter.TiledCSliceFilter.remove_slices_outside_capture)
* [TriCSliceFilter](#capcruncher.api.filter.TriCSliceFilter)

  + [remove\_slices\_with\_one\_reporter](#capcruncher.api.filter.TriCSliceFilter.remove_slices_with_one_reporter)

# filter

## `CCSliceFilter` [¶](#capcruncher.api.filter.CCSliceFilter "Permanent link")

Bases: `[SliceFilter](#capcruncher.api.filter.SliceFilter "SliceFilter (capcruncher.api.filter.SliceFilter)")`

Perform Capture-C slice filtering (inplace) and reporter identification.

SliceFilter tuned specifically for Capture-C data. This class has addtional methods
to remove common artifacts in Capture-C data i.e. multi-capture fragments,
non-reporter fragments, multi-capture reporters. The default filter order is as follows:

* remove\_unmapped\_slices
* remove\_orphan\_slices
* remove\_multi\_capture\_fragments
* remove\_excluded\_slices
* remove\_blacklisted\_slices
* remove\_non\_reporter\_fragments
* remove\_viewpoint\_adjacent\_restriction\_fragments
* remove\_slices\_without\_re\_frag\_assigned
* remove\_duplicate\_re\_frags
* remove\_duplicate\_slices
* remove\_duplicate\_slices\_pe
* remove\_non\_reporter\_fragments

See the individual methods for further details.

Attributes:

| Name | Type | Description |
| --- | --- | --- |
| `slices` | `DataFrame` | Annotated slices dataframe. |
| `[fragments](#capcruncher.api.filter.CCSliceFilter.fragments "fragments           property    (capcruncher.api.filter.CCSliceFilter.fragments)")` | `DataFrame` | Slices dataframe aggregated by parental read. |
| `[reporters](#capcruncher.api.filter.SliceFilter.reporters "reporters           property    (capcruncher.api.filter.CCSliceFilter.reporters)")` | `DataFrame` | Slices identified as reporters. |
| `filter_stages` | `dict` | Dictionary containg stages and a list of class methods (str) required to get to this stage. |
| `[slice_stats](#capcruncher.api.filter.SliceFilter.slice_stats "slice_stats           property    (capcruncher.api.filter.CCSliceFilter.slice_stats)")` | `DataFrame` | Provides slice level statistics. |
| `[read_stats](#capcruncher.api.filter.SliceFilter.read_stats "read_stats           property    (capcruncher.api.filter.CCSliceFilter.read_stats)")` | `DataFrame` | Provides statistics of slice filtering at the parental read level. |
| `[filter_stats](#capcruncher.api.filter.SliceFilter.filter_stats "filter_stats           property    (capcruncher.api.filter.CCSliceFilter.filter_stats)")` | `DataFrame` | Provides statistics of read filtering. |

Source code in `capcruncher/api/filter.py`

|  |  |
| --- | --- |
| ``` 441 442 443 444 445 446 447 448 449 450 451 452 453 454 455 456 457 458 459 460 461 462 463 464 465 466 467 468 469 470 471 472 473 474 475 476 477 478 479 480 481 482 483 484 485 486 487 488 489 490 491 492 493 494 495 496 497 498 499 500 501 502 503 504 505 506 507 508 509 510 511 512 513 514 515 516 517 518 519 520 521 522 523 524 525 526 527 528 529 530 531 532 533 534 535 536 537 538 539 540 541 542 543 544 545 546 547 548 549 550 551 552 553 554 555 556 557 558 559 560 561 562 563 564 565 566 567 568 569 570 571 572 573 574 575 576 577 578 579 580 581 582 583 584 585 586 587 588 589 590 591 592 593 594 595 596 597 598 599 600 601 602 603 604 605 606 607 608 609 610 611 612 613 614 615 616 617 618 619 620 621 622 623 624 625 626 627 628 629 630 631 632 633 634 635 636 637 638 639 640 641 642 643 644 645 646 647 648 649 650 651 652 653 654 655 656 657 658 659 660 661 662 663 664 665 666 667 668 669 670 671 672 673 674 675 676 677 678 679 680 681 682 683 684 685 686 687 688 689 690 691 692 693 694 695 696 697 698 699 700 701 702 703 704 705 706 707 708 709 710 711 712 713 714 715 716 717 718 719 720 721 722 723 724 725 726 727 728 729 730 731 732 733 734 735 736 737 738 739 740 741 742 743 744 745 746 747 748 749 750 751 752 753 754 755 756 757 758 759 760 761 762 763 764 765 766 767 768 769 770 771 772 773 774 775 776 777 778 779 780 781 782 783 784 785 786 787 788 789 790 ``` | ``` class CCSliceFilter(SliceFilter):     """     Perform Capture-C slice filtering (inplace) and reporter identification.      SliceFilter tuned specifically for Capture-C data. This class has addtional methods     to remove common artifacts in Capture-C data i.e. multi-capture fragments,     non-reporter fragments, multi-capture reporters. The default filter order is as follows:       - remove_unmapped_slices      - remove_orphan_slices      - remove_multi_capture_fragments      - remove_excluded_slices      - remove_blacklisted_slices      - remove_non_reporter_fragments      - remove_viewpoint_adjacent_restriction_fragments      - remove_slices_without_re_frag_assigned      - remove_duplicate_re_frags      - remove_duplicate_slices      - remove_duplicate_slices_pe      - remove_non_reporter_fragments      See the individual methods for further details.      Attributes:      slices (pd.DataFrame): Annotated slices dataframe.      fragments (pd.DataFrame): Slices dataframe aggregated by parental read.      reporters (pd.DataFrame): Slices identified as reporters.      filter_stages (dict): Dictionary containg stages and a list of class methods (str) required to get to this stage.      slice_stats (pd.DataFrame): Provides slice level statistics.      read_stats (pd.DataFrame): Provides statistics of slice filtering at the parental read level.      filter_stats (pd.DataFrame): Provides statistics of read filtering.      """      def __init__(self, slices, filter_stages=None, **sample_kwargs):         if not filter_stages:             filter_stages = {                 "pre-filtering": [                     "get_unfiltered_slices",                 ],                 "mapped": [                     "remove_unmapped_slices",                 ],                 "contains_single_capture": [                     "remove_orphan_slices",                     "remove_multi_capture_fragments",                 ],                 "contains_capture_and_reporter": [                     "remove_excluded_slices",                     "remove_blacklisted_slices",                     "remove_non_reporter_fragments",                     "remove_viewpoint_adjacent_restriction_fragments",                 ],                 "duplicate_filtered": [                     "remove_slices_without_re_frag_assigned",                     "remove_duplicate_re_frags",                     "remove_duplicate_slices",                     "remove_duplicate_slices_pe",                     "remove_non_reporter_fragments",                 ],             }          super(CCSliceFilter, self).__init__(slices, filter_stages, **sample_kwargs)      @property     def fragments(self) -> pd.DataFrame:         """         Summarises slices at the fragment level.          Uses pandas groupby to aggregate slices by their parental read name         (shared by all slices from the same fragment). Also determines the         number of reporter slices for each fragment.          Returns:          pd.DataFrame: Slices aggregated by parental read name.          """          df = (             self.slices.sort_values(["parent_read", "chrom", "start"])             .groupby("parent_read", as_index=False, sort=False)             .agg(                 unique_slices=("slice", "nunique"),                 pe=("pe", "first"),                 mapped=("mapped", "sum"),                 multimapped=("multimapped", "sum"),                 unique_capture_sites=("capture", "nunique"),                 capture_count=("capture_count", "sum"),                 unique_exclusions=("exclusion", "nunique"),                 exclusion_count=("exclusion_count", "sum"),                 unique_restriction_fragments=("restriction_fragment