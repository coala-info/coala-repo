[ ]
[ ]

[Skip to content](#snakesee.estimation.estimator)

snakesee

estimator

Initializing search

[GitHub](https://github.com/nh13/snakesee "Go to repository")

snakesee

[GitHub](https://github.com/nh13/snakesee "Go to repository")

* [snakesee](../../../index.html)
* [Snakesee Architecture](../../../architecture.html)
* [Installation](../../../installation.html)
* [Usage](../../../usage.html)
* [x]

  Reference

  Reference
  + [x]

    [snakesee](../index.html)

    snakesee
    - [cli](../cli.html)
    - [constants](../constants.html)
    - [x]

      [estimation](index.html)

      estimation
      * [data\_loader](data_loader.html)
      * [ ]

        estimator

        [estimator](estimator.html)

        Table of contents
        + [estimator](#snakesee.estimation.estimator)
        + [Classes](#snakesee.estimation.estimator-classes)

          - [TimeEstimator](#snakesee.estimation.estimator.TimeEstimator)

            * [Attributes](#snakesee.estimation.estimator.TimeEstimator-attributes)

              + [rule\_stats](#snakesee.estimation.estimator.TimeEstimator.rule_stats)
              + [thread\_stats](#snakesee.estimation.estimator.TimeEstimator.thread_stats)
              + [wildcard\_stats](#snakesee.estimation.estimator.TimeEstimator.wildcard_stats)
            * [Functions](#snakesee.estimation.estimator.TimeEstimator-functions)

              + [\_\_init\_\_](#snakesee.estimation.estimator.TimeEstimator.__init__)
              + [estimate\_remaining](#snakesee.estimation.estimator.TimeEstimator.estimate_remaining)
              + [get\_estimate\_for\_job](#snakesee.estimation.estimator.TimeEstimator.get_estimate_for_job)
              + [global\_mean\_duration](#snakesee.estimation.estimator.TimeEstimator.global_mean_duration)
              + [load\_from\_events](#snakesee.estimation.estimator.TimeEstimator.load_from_events)
              + [load\_from\_metadata](#snakesee.estimation.estimator.TimeEstimator.load_from_metadata)
        + [Functions](#snakesee.estimation.estimator-functions)
      * [pending\_inferrer](pending_inferrer.html)
      * [rule\_matcher](rule_matcher.html)
    - [estimator](../estimator.html)
    - [events](../events.html)
    - [exceptions](../exceptions.html)
    - [formatting](../formatting.html)
    - [log\_handler\_script](../log_handler_script.html)
    - [logging](../logging.html)
    - [models](../models.html)
    - [parameter\_validation](../parameter_validation.html)
    - [ ]

      [parser](../parser/index.html)

      parser
      * [core](../parser/core.html)
      * [failure\_tracker](../parser/failure_tracker.html)
      * [file\_position](../parser/file_position.html)
      * [job\_tracker](../parser/job_tracker.html)
      * [line\_parser](../parser/line_parser.html)
      * [log\_reader](../parser/log_reader.html)
      * [metadata](../parser/metadata.html)
      * [patterns](../parser/patterns.html)
      * [stats](../parser/stats.html)
      * [utils](../parser/utils.html)
    - [ ]

      [plugins](../plugins/index.html)

      plugins
      * [base](../plugins/base.html)
      * [bwa](../plugins/bwa.html)
      * [discovery](../plugins/discovery.html)
      * [fastp](../plugins/fastp.html)
      * [fgbio](../plugins/fgbio.html)
      * [loader](../plugins/loader.html)
      * [registry](../plugins/registry.html)
      * [samtools](../plugins/samtools.html)
      * [star](../plugins/star.html)
    - [profile](../profile.html)
    - [ ]

      [state](../state/index.html)

      state
      * [clock](../state/clock.html)
      * [config](../state/config.html)
      * [job\_registry](../state/job_registry.html)
      * [paths](../state/paths.html)
      * [rule\_registry](../state/rule_registry.html)
      * [workflow\_state](../state/workflow_state.html)
    - [state\_comparison](../state_comparison.html)
    - [ ]

      [tui](../tui/index.html)

      tui
      * [monitor](../tui/monitor.html)
    - [types](../types.html)
    - [utils](../utils.html)
    - [validation](../validation.html)
    - [variance](../variance.html)

Table of contents

* [estimator](#snakesee.estimation.estimator)
* [Classes](#snakesee.estimation.estimator-classes)

  + [TimeEstimator](#snakesee.estimation.estimator.TimeEstimator)

    - [Attributes](#snakesee.estimation.estimator.TimeEstimator-attributes)

      * [rule\_stats](#snakesee.estimation.estimator.TimeEstimator.rule_stats)
      * [thread\_stats](#snakesee.estimation.estimator.TimeEstimator.thread_stats)
      * [wildcard\_stats](#snakesee.estimation.estimator.TimeEstimator.wildcard_stats)
    - [Functions](#snakesee.estimation.estimator.TimeEstimator-functions)

      * [\_\_init\_\_](#snakesee.estimation.estimator.TimeEstimator.__init__)
      * [estimate\_remaining](#snakesee.estimation.estimator.TimeEstimator.estimate_remaining)
      * [get\_estimate\_for\_job](#snakesee.estimation.estimator.TimeEstimator.get_estimate_for_job)
      * [global\_mean\_duration](#snakesee.estimation.estimator.TimeEstimator.global_mean_duration)
      * [load\_from\_events](#snakesee.estimation.estimator.TimeEstimator.load_from_events)
      * [load\_from\_metadata](#snakesee.estimation.estimator.TimeEstimator.load_from_metadata)
* [Functions](#snakesee.estimation.estimator-functions)

# estimator

Time estimation for Snakemake workflow progress.

Note: The variance/confidence calculations in this module could potentially be
consolidated with snakesee.variance.VarianceCalculator for DRY-ness. Both modules
handle similar variance heuristics and confidence calculations. A future refactor
could delegate these calculations to shared helpers in VarianceCalculator.

## Classes[¶](#snakesee.estimation.estimator-classes "Permanent link")

### TimeEstimator [¶](#snakesee.estimation.estimator.TimeEstimator "Permanent link")

Estimates remaining workflow time from historical data.

Uses per-rule timing statistics from previous workflow runs to estimate
how long the remaining jobs will take. Falls back to simple linear
estimation when historical data is unavailable.

Attributes:

| Name | Type | Description |
| --- | --- | --- |
| `[rule_stats](index.html#snakesee.estimation.estimator.TimeEstimator.rule_stats "rule_stats            property       writable    (snakesee.estimation.estimator.TimeEstimator.rule_stats)")` | `dict[str, [RuleTimingStats](../index.html#snakesee.models.RuleTimingStats "RuleTimingStats            dataclass    (snakesee.models.RuleTimingStats)")]` | Dictionary mapping rule names to their timing statistics. |
| `[thread_stats](index.html#snakesee.estimation.estimator.TimeEstimator.thread_stats "thread_stats            property    (snakesee.estimation.estimator.TimeEstimator.thread_stats)")` | `dict[str, [ThreadTimingStats](../index.html#snakesee.models.ThreadTimingStats "ThreadTimingStats            dataclass    (snakesee.models.ThreadTimingStats)")]` | Dictionary mapping rule names to thread-conditioned timing stats. |
| `[wildcard_stats](index.html#snakesee.estimation.estimator.TimeEstimator.wildcard_stats "wildcard_stats            property    (snakesee.estimation.estimator.TimeEstimator.wildcard_stats)")` | `dict[str, dict[str, [WildcardTimingStats](../index.html#snakesee.models.WildcardTimingStats "WildcardTimingStats            dataclass    (snakesee.models.WildcardTimingStats)")]]` | Nested dict of wildcard-conditioned timing stats. |
| `use_wildcard_conditioning` |  | Whether to use wildcard-specific estimates. |
| `config` |  | Centralized estimation configuration. |

Source code in `snakesee/estimation/estimator.py`

|  |  |
| --- | --- |
| ``` 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127 128 129 130 131 132 133 134 135 136 137 138 139 140 141 142 143 144 145 146 147 148 149 150 151 152 153 154 155 156 157 158 159 160 161 162 163 164 165 166 167 168 169 170 171 172 173 174 175 176 177 178 179 180 181 182 183 184 185 186 187 188 189 190 191 192 193 194 195 196 197 198 199 200 201 202 203 204 205 206 207 208 209 210 211 212 213 214 215 216 217 218 219 220 221 222 223 224 225 226 227 228 229 230 231 232 233 234 235 236 237 238 239 240 241 242 243 244 245 246 247 248 249 250 251 252 253 254 255 256 257 258 259 260 261 262 263 264 265 266 267 268 269 270 271 272 273 274 275 276 277 278 279 280 281 282 283 284 285 286 287 288 289 290 291 292 293 294 295 296 297 298 299 300 301 302 303 304 305 306 307 308 309 310 311 312 313 314 315 316 317 318 319 320 321 322 323 324 325 326 327 328 329 330 331 332 333 334 335 336 337 338 339 340 341 342 343 344 345 346 347 348 349 350 351 352 353 354 355 356 357 358 359 360 361 362 363 364 365 366 367 368 369 370 371 372 373 374 375 376 377 378 379 380 381 382 383 384 385 386 387 388 389 390 391 392 393 394 395 396 397 398 399 400 401 402 403 404 405 406 407 408 409 410 411 412 413 414 415 416 417 418 419 420 421 422 423 424 425 426 427 428 429 430 431 432 433 434 435 436 437 438 439 440 441 442 443 444 445 446 447 448 449 450 451 452 453 454 455 456 457 458 459 460 461 462 463 464 465 466 467 468 469 470 471 472 473 474 475 476 477 478 479 480 481 482 483 484 485 486 487 488 489 490 491 492 493 494 495 496 497 498 499 500 501 502 503 504 505 506 507 508 509 510 511 512 513 514 515 516 517 518 519 520 521 522 523 524 525 526 527 528 529 530 531 532 533 534 535 536 537 538 539 540 541 542 543 544 545 546 547 548 549 550 551 552 553 554 555 556 557 558 559 560 561 562 563 564 565 566 567 568 569 570 571 572 573 574 575 576 577 578 579 580 581 582 583 584 585 586 587 588 589 590 591 592 593 594 595 596 597 598 599 600 601 602 603 604 605 606 607 608 609 610 611 612 613 614 615 616 617 618 619 620 621 622 623 624 625 626 627 628 629 630 631 632 633 634 635 636 637 638 639 640 641 642 643 644 645 646 647 648 649 650 651 652 653 654 655 656 657 658 659 660 661 662 663 664 665 666 667 668 669 670 671 672 673 674 675 676 677 678 679 680 681 682 683 684 685 686 687 688 689 690 691 692 693 694 695 696 697 698 699 700 701 702 703 704 705 706 707 708 709 710 711 712 713 714 715 716 717 718 719 720 721 722 723 724 725 726 727 728 729 730 731 732 733 734 735 736 737 738 739 740 741 742 743 744 745 746 747 748 749 750 751 752 753 754 755 756 757 758 759 760 761 762 763 764 765 766 767 768 769 770 771 772 773 774 775 776 777 778 779 780 781 782 783 784 785 786 787 788 789 790 791 792 793 794 795 796 797 798 799 800 801 802 803 804 805 806 807 808 809 810 811 812 813 814 815 816 817 818 819 820 821 822 823 824 825 826 827 828 829 830 831 832 833 834 835 836 837 838 839 840 841 842 843 844 845 846 847 848 849 850 851 852 853 854 855 856 857 858 859 860 861 862 863 864 865 866 867 868 869 870 871 872 873 874 875 876 877 878 879 880 881 882 883 884 885 886 887 888 889 890 891 892 893 894 ``` | ``` class TimeEstimator:     """     Estimates remaining workflow time from historical data.      Uses per-rule timing statistics from previous workflow runs to estimate     how long the remaining jobs will take. Falls back to simple linear     estimation when historical data is unavailable.      Attributes:         rule_stats: Dictionary mapping rule names to their timing statistics.         thread_stats: Dictionary mapping rule names to thread-conditioned timing stats.         wildcard_stats: Nested dict of wildcard-conditioned timing stats.         use_wildcard_conditioning: Whether to use wildcard-specific estimates.         config: Centralized estimation configuration.     """      def __init__(         self,         use_wildcard_conditioning: bool = False,         half_life_days: float | None = None,         weighting_strategy: WeightingStrategy | None = None,         half_life_logs: int | None = None,         config: EstimationConfig | None = None,         rule_registry: "RuleRegistry | None" = None,     ) -> None:         """         Initialize the estimator.          Args:             use_wildcard_conditioning: Whether to use wildcard-specific timing.             half_life_days: Half-life in days for time-based weighting.                            After this many days, a run's weight is halved.                            Only used when weighting_strategy="time".             weighting_strategy: Strategy for weighting historical data.                               "time" - decay based on wall-clock time (good for stable pipelines)                               "index" - decay based on run count (good for active development)             half_life_logs: Half-life in log count for index-based weighting.                            After this many runs, a run's weight is halved.                            Only used when weighting_strategy="index".             config: Centralized estimation configuration. If not provided, uses                    DEFAULT_CONFIG with any explicit parameters overriding it.             rule_registry: RuleRegistry for centralized statistics. If not provided,                           creates an internal registry.         """         from snakesee.state.rule_registry import RuleRegistry          # Use provided config or default         self.config = config if config is not None else DEFAULT_CONFIG          # Centralized registry - create internal one if not provided         self._rule_registry: RuleRegistry = rule_registry or RuleRegistry(config=self.config)          # Cache for global_mean_duration (invalidated when sample count or rule count changes)         self._global_mean_cache: float | None = None         self._global_mean_cache_sample_count: int = 0         self._global_mean_cache_rule_count: int = 0          self.current_rules: set[str] | None = None  # Rules in current workflow (for filtering)         self.code_hash_to_rules: dict[str, set[str]] = {}  # For renamed rule detection         self.expected_job_counts: dict[str, int] | None = None  # Expected counts from Job stats         self.use_wildcard_conditioning = use_wildcard_conditioning         self._wildcard_conditioning_explicit = use_wildcard_conditioning  # Track if explicitly set          # Use explicit params if provided, otherwise use config values         self.weighting_strategy: WeightingStrategy = (             weighting_strategy if weighting_strategy is not None else self.config.weighting_strategy         )         self.half_life_days = (             half_life_days if half_life_days is not None else self.config.half_life_days         )         self.half_life_logs = (             half_life_logs if half_life_logs is not None else self.config.half_life_logs         )          # Helper components         self._rule_matcher = RuleMatchingEngine(max_distance=self.config.fuzzy_match_max_distance)         self._pending_inferrer = PendingRuleInferrer()         self._data_loader: HistoricalDataLoader | None = None      @property     def rule_stats(se