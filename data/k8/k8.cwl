cwlVersion: v1.2
class: CommandLineTool
baseCommand: k8
label: k8
doc: "V8 JavaScript engine command-line tool\n\nTool homepage: https://github.com/attractivechaos/k8"
inputs:
  - id: abort_on_contradictory_flags
    type:
      - 'null'
      - boolean
    doc: Disallow flags or implications overriding each other.
    inputBinding:
      position: 101
      prefix: --abort-on-contradictory-flags
  - id: abort_on_uncaught_exception
    type:
      - 'null'
      - boolean
    doc: abort program (dump core) when an uncaught exception is thrown
    inputBinding:
      position: 101
      prefix: --abort-on-uncaught-exception
  - id: adjust_os_scheduling_parameters
    type:
      - 'null'
      - boolean
    doc: adjust OS specific scheduling params for the isolate
    inputBinding:
      position: 101
      prefix: --adjust-os-scheduling-parameters
  - id: allocation_buffer_parking
    type:
      - 'null'
      - boolean
    doc: allocation buffer parking
    inputBinding:
      position: 101
      prefix: --allocation-buffer-parking
  - id: allocation_site_pretenuring
    type:
      - 'null'
      - boolean
    doc: pretenure with allocation sites
    inputBinding:
      position: 101
      prefix: --allocation-site-pretenuring
  - id: allow_natives_for_differential_fuzzing
    type:
      - 'null'
      - boolean
    doc: allow only natives explicitly allowlisted for differential fuzzers
    inputBinding:
      position: 101
      prefix: --allow-natives-for-differential-fuzzing
  - id: allow_natives_syntax
    type:
      - 'null'
      - boolean
    doc: allow natives syntax
    inputBinding:
      position: 101
      prefix: --allow-natives-syntax
  - id: allow_overwriting_for_next_flag
    type:
      - 'null'
      - boolean
    doc: temporary disable flag contradiction to allow overwriting just the next
      flag
    inputBinding:
      position: 101
      prefix: --allow-overwriting-for-next-flag
  - id: allow_unsafe_function_constructor
    type:
      - 'null'
      - boolean
    doc: allow invoking the function constructor without security checks
    inputBinding:
      position: 101
      prefix: --allow-unsafe-function-constructor
  - id: always_opt
    type:
      - 'null'
      - boolean
    doc: always try to optimize functions
    inputBinding:
      position: 101
      prefix: --always-opt
  - id: always_osr
    type:
      - 'null'
      - boolean
    doc: always try to OSR functions
    inputBinding:
      position: 101
      prefix: --always-osr
  - id: always_sparkplug
    type:
      - 'null'
      - boolean
    doc: directly tier up to Sparkplug code
    inputBinding:
      position: 101
      prefix: --always-sparkplug
  - id: analyze_environment_liveness
    type:
      - 'null'
      - boolean
    doc: analyze liveness of environment slots and zap dead values
    inputBinding:
      position: 101
      prefix: --analyze-environment-liveness
  - id: arm_arch
    type:
      - 'null'
      - string
    doc: 'generate instructions for the selected ARM architecture if available: armv6,
      armv7, armv7+sudiv or armv8'
    inputBinding:
      position: 101
      prefix: --arm-arch
  - id: asm_wasm_lazy_compilation
    type:
      - 'null'
      - boolean
    doc: enable lazy compilation for asm-wasm modules
    inputBinding:
      position: 101
      prefix: --asm-wasm-lazy-compilation
  - id: assert_types
    type:
      - 'null'
      - boolean
    doc: generate runtime type assertions to test the typer
    inputBinding:
      position: 101
      prefix: --assert-types
  - id: async_stack_traces
    type:
      - 'null'
      - boolean
    doc: include async stack traces in Error.stack
    inputBinding:
      position: 101
      prefix: --async-stack-traces
  - id: baseline_batch_compilation
    type:
      - 'null'
      - boolean
    doc: batch compile Sparkplug code
    inputBinding:
      position: 101
      prefix: --baseline-batch-compilation
  - id: baseline_batch_compilation_threshold
    type:
      - 'null'
      - int
    doc: the estimated instruction size of a batch to trigger compilation
    inputBinding:
      position: 101
      prefix: --baseline-batch-compilation-threshold
  - id: builtin_subclassing
    type:
      - 'null'
      - boolean
    doc: subclassing support in built-in methods
    inputBinding:
      position: 101
      prefix: --builtin-subclassing
  - id: builtins_in_stack_traces
    type:
      - 'null'
      - boolean
    doc: show built-in functions in stack traces
    inputBinding:
      position: 101
      prefix: --builtins-in-stack-traces
  - id: bytecode_size_allowance_per_tick
    type:
      - 'null'
      - int
    doc: increases the number of ticks required for optimization by 
      bytecode.length/X
    inputBinding:
      position: 101
      prefix: --bytecode-size-allowance-per-tick
  - id: cache_prototype_transitions
    type:
      - 'null'
      - boolean
    doc: cache prototype transitions
    inputBinding:
      position: 101
      prefix: --cache-prototype-transitions
  - id: clear_exceptions_on_js_entry
    type:
      - 'null'
      - boolean
    doc: clear pending exceptions when entering JavaScript
    inputBinding:
      position: 101
      prefix: --clear-exceptions-on-js-entry
  - id: clear_free_memory
    type:
      - 'null'
      - boolean
    doc: initialize free memory with 0
    inputBinding:
      position: 101
      prefix: --clear-free-memory
  - id: compact
    type:
      - 'null'
      - boolean
    doc: Perform compaction on full GCs based on V8's default heuristics
    inputBinding:
      position: 101
      prefix: --compact
  - id: compact_code_space
    type:
      - 'null'
      - boolean
    doc: Perform code space compaction on full collections.
    inputBinding:
      position: 101
      prefix: --compact-code-space
  - id: compact_code_space_with_stack
    type:
      - 'null'
      - boolean
    doc: Perform code space compaction when finalizing a full GC with stack
    inputBinding:
      position: 101
      prefix: --compact-code-space-with-stack
  - id: compact_maps
    type:
      - 'null'
      - boolean
    doc: Perform compaction on maps on full collections.
    inputBinding:
      position: 101
      prefix: --compact-maps
  - id: compact_on_every_full_gc
    type:
      - 'null'
      - boolean
    doc: Perform compaction on every full GC
    inputBinding:
      position: 101
      prefix: --compact-on-every-full-gc
  - id: compact_with_stack
    type:
      - 'null'
      - boolean
    doc: Perform compaction when finalizing a full GC with stack
    inputBinding:
      position: 101
      prefix: --compact-with-stack
  - id: compilation_cache
    type:
      - 'null'
      - boolean
    doc: enable compilation cache
    inputBinding:
      position: 101
      prefix: --compilation-cache
  - id: concurrent_array_buffer_sweeping
    type:
      - 'null'
      - boolean
    doc: concurrently sweep array buffers
    inputBinding:
      position: 101
      prefix: --concurrent-array-buffer-sweeping
  - id: concurrent_cache_deserialization
    type:
      - 'null'
      - boolean
    doc: enable deserializing code caches on background
    inputBinding:
      position: 101
      prefix: --concurrent-cache-deserialization
  - id: concurrent_marking
    type:
      - 'null'
      - boolean
    doc: use concurrent marking
    inputBinding:
      position: 101
      prefix: --concurrent-marking
  - id: concurrent_osr
    type:
      - 'null'
      - boolean
    doc: enable concurrent OSR
    inputBinding:
      position: 101
      prefix: --concurrent-osr
  - id: concurrent_recompilation
    type:
      - 'null'
      - boolean
    doc: optimizing hot functions asynchronously on a separate thread
    inputBinding:
      position: 101
      prefix: --concurrent-recompilation
  - id: concurrent_recompilation_delay
    type:
      - 'null'
      - int
    doc: artificial compilation delay in ms
    inputBinding:
      position: 101
      prefix: --concurrent-recompilation-delay
  - id: concurrent_recompilation_queue_length
    type:
      - 'null'
      - int
    doc: the length of the concurrent compilation queue
    inputBinding:
      position: 101
      prefix: --concurrent-recompilation-queue-length
  - id: concurrent_sparkplug
    type:
      - 'null'
      - boolean
    doc: compile Sparkplug code in a background thread
    inputBinding:
      position: 101
      prefix: --concurrent-sparkplug
  - id: concurrent_sparkplug_max_threads
    type:
      - 'null'
      - string
    doc: max number of threads that concurrent Sparkplug can use (0 for 
      unbounded)
    inputBinding:
      position: 101
      prefix: --concurrent-sparkplug-max-threads
  - id: concurrent_sweeping
    type:
      - 'null'
      - boolean
    doc: use concurrent sweeping
    inputBinding:
      position: 101
      prefix: --concurrent-sweeping
  - id: correctness_fuzzer_suppressions
    type:
      - 'null'
      - boolean
    doc: 'Suppress certain unspecified behaviors to ease correctness fuzzing: Abort
      program when the stack overflows or a string exceeds maximum length (as opposed
      to throwing RangeError). Use a fixed suppression string for error messages.'
    inputBinding:
      position: 101
      prefix: --correctness-fuzzer-suppressions
  - id: cpu_profiler_sampling_interval
    type:
      - 'null'
      - int
    doc: CPU profiler sampling interval in microseconds
    inputBinding:
      position: 101
      prefix: --cpu-profiler-sampling-interval
  - id: crash_on_aborted_evacuation
    type:
      - 'null'
      - boolean
    doc: crash when evacuation of page fails
    inputBinding:
      position: 101
      prefix: --crash-on-aborted-evacuation
  - id: csa_trap_on_node
    type:
      - 'null'
      - string
    doc: 'trigger break point when a node with given id is created in given stub.
      The format is: StubName,NodeId'
    inputBinding:
      position: 101
      prefix: --csa-trap-on-node
  - id: default_to_experimental_regexp_engine
    type:
      - 'null'
      - boolean
    doc: run regexps with the experimental engine where possible
    inputBinding:
      position: 101
      prefix: --default-to-experimental-regexp-engine
  - id: deopt_every_n_times
    type:
      - 'null'
      - int
    doc: deoptimize every n times a deopt point is passed
    inputBinding:
      position: 101
      prefix: --deopt-every-n-times
  - id: detailed_error_stack_trace
    type:
      - 'null'
      - boolean
    doc: includes arguments for each function call in the error stack frames 
      array
    inputBinding:
      position: 101
      prefix: --detailed-error-stack-trace
  - id: detailed_line_info
    type:
      - 'null'
      - boolean
    doc: Always generate detailed line information for CPU profiling.
    inputBinding:
      position: 101
      prefix: --detailed-line-info
  - id: detect_ineffective_gcs_near_heap_limit
    type:
      - 'null'
      - boolean
    doc: trigger out-of-memory failure to avoid GC storm near heap limit
    inputBinding:
      position: 101
      prefix: --detect-ineffective-gcs-near-heap-limit
  - id: disable_abortjs
    type:
      - 'null'
      - boolean
    doc: disables AbortJS runtime function
    inputBinding:
      position: 101
      prefix: --disable-abortjs
  - id: disable_old_api_accessors
    type:
      - 'null'
      - boolean
    doc: Disable old-style API accessors whose setters trigger through the 
      prototype chain
    inputBinding:
      position: 101
      prefix: --disable-old-api-accessors
  - id: disallow_code_generation_from_strings
    type:
      - 'null'
      - boolean
    doc: disallow eval and friends
    inputBinding:
      position: 101
      prefix: --disallow-code-generation-from-strings
  - id: dump_wasm_module_path
    type:
      - 'null'
      - string
    doc: directory to dump wasm modules to
    inputBinding:
      position: 101
      prefix: --dump-wasm-module-path
  - id: embedded_src
    type:
      - 'null'
      - string
    doc: Path for the generated embedded data file. (mksnapshot only)
    inputBinding:
      position: 101
      prefix: --embedded-src
  - id: embedded_variant
    type:
      - 'null'
      - string
    doc: Label to disambiguate symbols in embedded data file. (mksnapshot only)
    inputBinding:
      position: 101
      prefix: --embedded-variant
  - id: embedder_instance_types
    type:
      - 'null'
      - boolean
    doc: enable type checks based on instance types provided by the embedder
    inputBinding:
      position: 101
      prefix: --embedder-instance-types
  - id: enable_32dregs
    type:
      - 'null'
      - string
    doc: deprecated (use --arm_arch instead)
    inputBinding:
      position: 101
      prefix: --enable-32dregs
  - id: enable_armv7
    type:
      - 'null'
      - string
    doc: deprecated (use --arm_arch instead)
    inputBinding:
      position: 101
      prefix: --enable-armv7
  - id: enable_armv8
    type:
      - 'null'
      - string
    doc: deprecated (use --arm_arch instead)
    inputBinding:
      position: 101
      prefix: --enable-armv8
  - id: enable_avx
    type:
      - 'null'
      - boolean
    doc: enable use of AVX instructions if available
    inputBinding:
      position: 101
      prefix: --enable-avx
  - id: enable_avx2
    type:
      - 'null'
      - boolean
    doc: enable use of AVX2 instructions if available
    inputBinding:
      position: 101
      prefix: --enable-avx2
  - id: enable_bmi1
    type:
      - 'null'
      - boolean
    doc: enable use of BMI1 instructions if available
    inputBinding:
      position: 101
      prefix: --enable-bmi1
  - id: enable_bmi2
    type:
      - 'null'
      - boolean
    doc: enable use of BMI2 instructions if available
    inputBinding:
      position: 101
      prefix: --enable-bmi2
  - id: enable_experimental_regexp_engine
    type:
      - 'null'
      - boolean
    doc: recognize regexps with 'l' flag, run them on experimental engine
    inputBinding:
      position: 101
      prefix: --enable-experimental-regexp-engine
  - id: enable_experimental_regexp_engine_on_excessive_backtracks
    type:
      - 'null'
      - boolean
    doc: fall back to a breadth-first regexp engine on excessive backtracking
    inputBinding:
      position: 101
      prefix: --enable-experimental-regexp-engine-on-excessive-backtracks
  - id: enable_fma3
    type:
      - 'null'
      - boolean
    doc: enable use of FMA3 instructions if available
    inputBinding:
      position: 101
      prefix: --enable-fma3
  - id: enable_lazy_source_positions
    type:
      - 'null'
      - boolean
    doc: skip generating source positions during initial compile but regenerate 
      when actually required
    inputBinding:
      position: 101
      prefix: --enable-lazy-source-positions
  - id: enable_lzcnt
    type:
      - 'null'
      - boolean
    doc: enable use of LZCNT instruction if available
    inputBinding:
      position: 101
      prefix: --enable-lzcnt
  - id: enable_mega_dom_ic
    type:
      - 'null'
      - boolean
    doc: use MegaDOM IC state for API objects
    inputBinding:
      position: 101
      prefix: --enable-mega-dom-ic
  - id: enable_neon
    type:
      - 'null'
      - string
    doc: deprecated (use --arm_arch instead)
    inputBinding:
      position: 101
      prefix: --enable-neon
  - id: enable_popcnt
    type:
      - 'null'
      - boolean
    doc: enable use of POPCNT instruction if available
    inputBinding:
      position: 101
      prefix: --enable-popcnt
  - id: enable_regexp_unaligned_accesses
    type:
      - 'null'
      - boolean
    doc: enable unaligned accesses for the regexp engine
    inputBinding:
      position: 101
      prefix: --enable-regexp-unaligned-accesses
  - id: enable_sahf
    type:
      - 'null'
      - boolean
    doc: enable use of SAHF instruction if available (X64 only)
    inputBinding:
      position: 101
      prefix: --enable-sahf
  - id: enable_sharedarraybuffer_per_context
    type:
      - 'null'
      - boolean
    doc: enable the SharedArrayBuffer constructor per context
    inputBinding:
      position: 101
      prefix: --enable-sharedarraybuffer-per-context
  - id: enable_source_at_csa_bind
    type:
      - 'null'
      - boolean
    doc: Include source information in the binary at CSA bind locations.
    inputBinding:
      position: 101
      prefix: --enable-source-at-csa-bind
  - id: enable_sse3
    type:
      - 'null'
      - boolean
    doc: enable use of SSE3 instructions if available
    inputBinding:
      position: 101
      prefix: --enable-sse3
  - id: enable_sse4_1
    type:
      - 'null'
      - boolean
    doc: enable use of SSE4.1 instructions if available
    inputBinding:
      position: 101
      prefix: --enable-sse4-1
  - id: enable_sse4_2
    type:
      - 'null'
      - boolean
    doc: enable use of SSE4.2 instructions if available
    inputBinding:
      position: 101
      prefix: --enable-sse4-2
  - id: enable_ssse3
    type:
      - 'null'
      - boolean
    doc: enable use of SSSE3 instructions if available
    inputBinding:
      position: 101
      prefix: --enable-ssse3
  - id: enable_sudiv
    type:
      - 'null'
      - string
    doc: deprecated (use --arm_arch instead)
    inputBinding:
      position: 101
      prefix: --enable-sudiv
  - id: enable_system_instrumentation
    type:
      - 'null'
      - boolean
    doc: Enable platform-specific profiling.
    inputBinding:
      position: 101
      prefix: --enable-system-instrumentation
  - id: enable_vfp3
    type:
      - 'null'
      - string
    doc: deprecated (use --arm_arch instead)
    inputBinding:
      position: 101
      prefix: --enable-vfp3
  - id: ephemeron_fixpoint_iterations
    type:
      - 'null'
      - int
    doc: number of fixpoint iterations it takes to switch to linear ephemeron 
      algorithm
    inputBinding:
      position: 101
      prefix: --ephemeron-fixpoint-iterations
  - id: experimental_async_stack_tagging_api
    type:
      - 'null'
      - boolean
    doc: enable experimental async stacks tagging API
    inputBinding:
      position: 101
      prefix: --experimental-async-stack-tagging-api
  - id: experimental_flush_embedded_blob_icache
    type:
      - 'null'
      - boolean
    doc: Used in an experiment to evaluate icache flushing on certain CPUs
    inputBinding:
      position: 101
      prefix: --experimental-flush-embedded-blob-icache
  - id: experimental_stack_trace_frames
    type:
      - 'null'
      - boolean
    doc: enable experimental frames (API/Builtins) and stack trace layout
    inputBinding:
      position: 101
      prefix: --experimental-stack-trace-frames
  - id: experimental_wasm_allow_huge_modules
    type:
      - 'null'
      - boolean
    doc: allow wasm modules bigger than 1GB, but below ~2GB
    inputBinding:
      position: 101
      prefix: --experimental-wasm-allow-huge-modules
  - id: experimental_wasm_assume_ref_cast_succeeds
    type:
      - 'null'
      - boolean
    doc: enable prototype assume ref.cast always succeeds and skip the related 
      type check (unsafe) for wasm
    inputBinding:
      position: 101
      prefix: --experimental-wasm-assume-ref-cast-succeeds
  - id: experimental_wasm_branch_hinting
    type:
      - 'null'
      - boolean
    doc: enable prototype branch hinting for wasm
    inputBinding:
      position: 101
      prefix: --experimental-wasm-branch-hinting
  - id: experimental_wasm_compilation_hints
    type:
      - 'null'
      - boolean
    doc: enable prototype compilation hints section for wasm
    inputBinding:
      position: 101
      prefix: --experimental-wasm-compilation-hints
  - id: experimental_wasm_eh
    type:
      - 'null'
      - boolean
    doc: enable prototype exception handling opcodes for wasm
    inputBinding:
      position: 101
      prefix: --experimental-wasm-eh
  - id: experimental_wasm_extended_const
    type:
      - 'null'
      - boolean
    doc: enable prototype extended constant expressions for wasm
    inputBinding:
      position: 101
      prefix: --experimental-wasm-extended-const
  - id: experimental_wasm_gc
    type:
      - 'null'
      - boolean
    doc: enable prototype garbage collection for wasm
    inputBinding:
      position: 101
      prefix: --experimental-wasm-gc
  - id: experimental_wasm_memory64
    type:
      - 'null'
      - boolean
    doc: enable prototype memory64 for wasm
    inputBinding:
      position: 101
      prefix: --experimental-wasm-memory64
  - id: experimental_wasm_nn_locals
    type:
      - 'null'
      - boolean
    doc: enable prototype allow non-defaultable/non-nullable locals, validated 
      with 'until end of block' semantics for wasm
    inputBinding:
      position: 101
      prefix: --experimental-wasm-nn-locals
  - id: experimental_wasm_relaxed_simd
    type:
      - 'null'
      - boolean
    doc: enable prototype relaxed simd for wasm
    inputBinding:
      position: 101
      prefix: --experimental-wasm-relaxed-simd
  - id: experimental_wasm_return_call
    type:
      - 'null'
      - boolean
    doc: enable prototype return call opcodes for wasm
    inputBinding:
      position: 101
      prefix: --experimental-wasm-return-call
  - id: experimental_wasm_simd
    type:
      - 'null'
      - boolean
    doc: enable prototype SIMD opcodes for wasm
    inputBinding:
      position: 101
      prefix: --experimental-wasm-simd
  - id: experimental_wasm_skip_bounds_checks
    type:
      - 'null'
      - boolean
    doc: enable prototype skip array bounds checks (unsafe) for wasm
    inputBinding:
      position: 101
      prefix: --experimental-wasm-skip-bounds-checks
  - id: experimental_wasm_skip_null_checks
    type:
      - 'null'
      - boolean
    doc: enable prototype skip null checks for call.ref and array and struct 
      operations (unsafe) for wasm
    inputBinding:
      position: 101
      prefix: --experimental-wasm-skip-null-checks
  - id: experimental_wasm_stack_switching
    type:
      - 'null'
      - boolean
    doc: enable prototype stack switching for wasm
    inputBinding:
      position: 101
      prefix: --experimental-wasm-stack-switching
  - id: experimental_wasm_threads
    type:
      - 'null'
      - boolean
    doc: enable prototype thread opcodes for wasm
    inputBinding:
      position: 101
      prefix: --experimental-wasm-threads
  - id: experimental_wasm_type_reflection
    type:
      - 'null'
      - boolean
    doc: enable prototype wasm type reflection in JS for wasm
    inputBinding:
      position: 101
      prefix: --experimental-wasm-type-reflection
  - id: experimental_wasm_typed_funcref
    type:
      - 'null'
      - boolean
    doc: enable prototype typed function references for wasm
    inputBinding:
      position: 101
      prefix: --experimental-wasm-typed-funcref
  - id: experimental_wasm_unsafe_nn_locals
    type:
      - 'null'
      - boolean
    doc: enable prototype allow non-defaultable/non-nullable locals, no 
      validation for wasm
    inputBinding:
      position: 101
      prefix: --experimental-wasm-unsafe-nn-locals
  - id: experimental_web_snapshots
    type:
      - 'null'
      - boolean
    doc: interpret scripts as web snapshots if they start with a magic number
    inputBinding:
      position: 101
      prefix: --experimental-web-snapshots
  - id: expose_async_hooks
    type:
      - 'null'
      - boolean
    doc: expose async_hooks object
    inputBinding:
      position: 101
      prefix: --expose-async-hooks
  - id: expose_cputracemark_as
    type:
      - 'null'
      - string
    doc: expose cputracemark extension under the specified name
    inputBinding:
      position: 101
      prefix: --expose-cputracemark-as
  - id: expose_externalize_string
    type:
      - 'null'
      - boolean
    doc: expose externalize string extension
    inputBinding:
      position: 101
      prefix: --expose-externalize-string
  - id: expose_gc
    type:
      - 'null'
      - boolean
    doc: expose gc extension
    inputBinding:
      position: 101
      prefix: --expose-gc
  - id: expose_gc_as
    type:
      - 'null'
      - string
    doc: expose gc extension under the specified name
    inputBinding:
      position: 101
      prefix: --expose-gc-as
  - id: expose_ignition_statistics
    type:
      - 'null'
      - boolean
    doc: expose ignition-statistics extension (requires building with 
      v8_enable_ignition_dispatch_counting)
    inputBinding:
      position: 101
      prefix: --expose-ignition-statistics
  - id: expose_inspector_scripts
    type:
      - 'null'
      - boolean
    doc: expose injected-script-source.js for debugging
    inputBinding:
      position: 101
      prefix: --expose-inspector-scripts
  - id: expose_statistics
    type:
      - 'null'
      - boolean
    doc: expose statistics extension
    inputBinding:
      position: 101
      prefix: --expose-statistics
  - id: expose_trigger_failure
    type:
      - 'null'
      - boolean
    doc: expose trigger-failure extension
    inputBinding:
      position: 101
      prefix: --expose-trigger-failure
  - id: expose_wasm
    type:
      - 'null'
      - boolean
    doc: expose wasm interface to JavaScript
    inputBinding:
      position: 101
      prefix: --expose-wasm
  - id: fast_promotion_new_space
    type:
      - 'null'
      - boolean
    doc: fast promote new space on high survival rates
    inputBinding:
      position: 101
      prefix: --fast-promotion-new-space
  - id: feedback_normalization
    type:
      - 'null'
      - boolean
    doc: feed back normalization to constructors
    inputBinding:
      position: 101
      prefix: --feedback-normalization
  - id: flush_baseline_code
    type:
      - 'null'
      - boolean
    doc: flush of baseline code when it has not been executed recently
    inputBinding:
      position: 101
      prefix: --flush-baseline-code
  - id: flush_bytecode
    type:
      - 'null'
      - boolean
    doc: flush of bytecode when it has not been executed recently
    inputBinding:
      position: 101
      prefix: --flush-bytecode
  - id: force_long_branches
    type:
      - 'null'
      - boolean
    doc: force all emitted branches to be in long mode (MIPS/PPC only)
    inputBinding:
      position: 101
      prefix: --force-long-branches
  - id: force_marking_deque_overflows
    type:
      - 'null'
      - boolean
    doc: force overflows of marking deque by reducing it's size to 64 words
    inputBinding:
      position: 101
      prefix: --force-marking-deque-overflows
  - id: force_slow_path
    type:
      - 'null'
      - boolean
    doc: always take the slow path for builtins
    inputBinding:
      position: 101
      prefix: --force-slow-path
  - id: future
    type:
      - 'null'
      - boolean
    doc: Implies all staged features that we want to ship in the not-too-far 
      future
    inputBinding:
      position: 101
      prefix: --future
  - id: fuzzer_gc_analysis
    type:
      - 'null'
      - boolean
    doc: prints number of allocations and enables analysis mode for gc fuzz 
      testing, e.g. --stress-marking, --stress-scavenge
    inputBinding:
      position: 101
      prefix: --fuzzer-gc-analysis
  - id: fuzzer_random_seed
    type:
      - 'null'
      - int
    doc: Default seed for initializing fuzzer random generator (0, the default, 
      means to use v8's random number generator seed).
    inputBinding:
      position: 101
      prefix: --fuzzer-random-seed
  - id: fuzzing
    type:
      - 'null'
      - boolean
    doc: Fuzzers use this flag to signal that they are ... fuzzing. This causes 
      intrinsics to fail silently (e.g. return undefined) on invalid usage.
    inputBinding:
      position: 101
      prefix: --fuzzing
  - id: gc_experiment_less_compaction
    type:
      - 'null'
      - boolean
    doc: less compaction in non-memory reducing mode
    inputBinding:
      position: 101
      prefix: --gc-experiment-less-compaction
  - id: gc_fake_mmap
    type:
      - 'null'
      - string
    doc: Specify the name of the file for fake gc mmap used in ll_prof
    inputBinding:
      position: 101
      prefix: --gc-fake-mmap
  - id: gc_global
    type:
      - 'null'
      - boolean
    doc: always perform global GCs
    inputBinding:
      position: 101
      prefix: --gc-global
  - id: gc_interval
    type:
      - 'null'
      - int
    doc: garbage collect after <n> allocations
    inputBinding:
      position: 101
      prefix: --gc-interval
  - id: gc_stats
    type:
      - 'null'
      - int
    doc: Used by tracing internally to enable gc statistics
    inputBinding:
      position: 101
      prefix: --gc-stats
  - id: global_gc_scheduling
    type:
      - 'null'
      - boolean
    doc: enable GC scheduling based on global memory
    inputBinding:
      position: 101
      prefix: --global-gc-scheduling
  - id: hard_abort
    type:
      - 'null'
      - boolean
    doc: abort by crashing
    inputBinding:
      position: 101
      prefix: --hard-abort
  - id: harmony
    type:
      - 'null'
      - boolean
    doc: enable all completed harmony features
    inputBinding:
      position: 101
      prefix: --harmony
  - id: harmony_array_find_last
    type:
      - 'null'
      - boolean
    doc: enable "harmony array find last helpers"
    inputBinding:
      position: 101
      prefix: --harmony-array-find-last
  - id: harmony_array_grouping
    type:
      - 'null'
      - boolean
    doc: enable "harmony array grouping"
    inputBinding:
      position: 101
      prefix: --harmony-array-grouping
  - id: harmony_atomics
    type:
      - 'null'
      - boolean
    doc: enable "harmony atomics"
    inputBinding:
      position: 101
      prefix: --harmony-atomics
  - id: harmony_class_static_blocks
    type:
      - 'null'
      - boolean
    doc: enable "harmony static initializer blocks"
    inputBinding:
      position: 101
      prefix: --harmony-class-static-blocks
  - id: harmony_error_cause
    type:
      - 'null'
      - boolean
    doc: enable "harmony error cause property"
    inputBinding:
      position: 101
      prefix: --harmony-error-cause
  - id: harmony_import_assertions
    type:
      - 'null'
      - boolean
    doc: enable "harmony import assertions" (in progress)
    inputBinding:
      position: 101
      prefix: --harmony-import-assertions
  - id: harmony_intl_best_fit_matcher
    type:
      - 'null'
      - boolean
    doc: enable "Intl BestFitMatcher"
    inputBinding:
      position: 101
      prefix: --harmony-intl-best-fit-matcher
  - id: harmony_intl_number_format_v3
    type:
      - 'null'
      - boolean
    doc: enable "Intl.NumberFormat v3" (in progress)
    inputBinding:
      position: 101
      prefix: --harmony-intl-number-format-v3
  - id: harmony_object_has_own
    type:
      - 'null'
      - boolean
    doc: enable "harmony Object.hasOwn"
    inputBinding:
      position: 101
      prefix: --harmony-object-has-own
  - id: harmony_private_brand_checks
    type:
      - 'null'
      - boolean
    doc: enable "harmony private brand checks"
    inputBinding:
      position: 101
      prefix: --harmony-private-brand-checks
  - id: harmony_rab_gsab
    type:
      - 'null'
      - boolean
    doc: enable "harmony ResizableArrayBuffer / GrowableSharedArrayBuffer" (in 
      progress)
    inputBinding:
      position: 101
      prefix: --harmony-rab-gsab
  - id: harmony_relative_indexing_methods
    type:
      - 'null'
      - boolean
    doc: enable "harmony relative indexing methods"
    inputBinding:
      position: 101
      prefix: --harmony-relative-indexing-methods
  - id: harmony_shadow_realm
    type:
      - 'null'
      - boolean
    doc: enable "harmony ShadowRealm" (in progress)
    inputBinding:
      position: 101
      prefix: --harmony-shadow-realm
  - id: harmony_sharedarraybuffer
    type:
      - 'null'
      - boolean
    doc: enable "harmony sharedarraybuffer"
    inputBinding:
      position: 101
      prefix: --harmony-sharedarraybuffer
  - id: harmony_shipping
    type:
      - 'null'
      - boolean
    doc: enable all shipped harmony features
    inputBinding:
      position: 101
      prefix: --harmony-shipping
  - id: harmony_struct
    type:
      - 'null'
      - boolean
    doc: enable "harmony structs and shared structs" (in progress)
    inputBinding:
      position: 101
      prefix: --harmony-struct
  - id: harmony_temporal
    type:
      - 'null'
      - boolean
    doc: enable "Temporal" (in progress)
    inputBinding:
      position: 101
      prefix: --harmony-temporal
  - id: harmony_weak_refs_with_cleanup_some
    type:
      - 'null'
      - boolean
    doc: enable "harmony weak references with 
      FinalizationRegistry.prototype.cleanupSome" (in progress)
    inputBinding:
      position: 101
      prefix: --harmony-weak-refs-with-cleanup-some
  - id: hash_seed
    type:
      - 'null'
      - string
    doc: Fixed seed to use to hash property keys (0 means random)(with snapshots
      this option cannot override the baked-in seed)
    inputBinding:
      position: 101
      prefix: --hash-seed
  - id: heap_growing_percent
    type:
      - 'null'
      - int
    doc: specifies heap growing factor as (1 + heap_growing_percent/100)
    inputBinding:
      position: 101
      prefix: --heap-growing-percent
  - id: heap_profiler_show_hidden_objects
    type:
      - 'null'
      - boolean
    doc: use 'native' rather than 'hidden' node type in snapshot
    inputBinding:
      position: 101
      prefix: --heap-profiler-show-hidden-objects
  - id: heap_profiler_trace_objects
    type:
      - 'null'
      - boolean
    doc: Dump heap object allocations/movements/size_updates
    inputBinding:
      position: 101
      prefix: --heap-profiler-trace-objects
  - id: heap_profiler_use_embedder_graph
    type:
      - 'null'
      - boolean
    doc: Use the new EmbedderGraph API to get embedder nodes
    inputBinding:
      position: 101
      prefix: --heap-profiler-use-embedder-graph
  - id: heap_snapshot_string_limit
    type:
      - 'null'
      - int
    doc: truncate strings to this length in the heap snapshot
    inputBinding:
      position: 101
      prefix: --heap-snapshot-string-limit
  - id: histogram_interval
    type:
      - 'null'
      - int
    doc: time interval in ms for aggregating memory histograms
    inputBinding:
      position: 101
      prefix: --histogram-interval
  - id: huge_max_old_generation_size
    type:
      - 'null'
      - boolean
    doc: Increase max size of the old space to 4 GB for x64 systems withthe 
      physical memory bigger than 16 GB
    inputBinding:
      position: 101
      prefix: --huge-max-old-generation-size
  - id: icu_timezone_data
    type:
      - 'null'
      - boolean
    doc: get information about timezones from ICU
    inputBinding:
      position: 101
      prefix: --icu-timezone-data
  - id: ignition_elide_noneffectful_bytecodes
    type:
      - 'null'
      - boolean
    doc: elide bytecodes which won't have any external effect
    inputBinding:
      position: 101
      prefix: --ignition-elide-noneffectful-bytecodes
  - id: ignition_filter_expression_positions
    type:
      - 'null'
      - boolean
    doc: filter expression positions before the bytecode pipeline
    inputBinding:
      position: 101
      prefix: --ignition-filter-expression-positions
  - id: ignition_reo
    type:
      - 'null'
      - boolean
    doc: use ignition register equivalence optimizer
    inputBinding:
      position: 101
      prefix: --ignition-reo
  - id: ignition_share_named_property_feedback
    type:
      - 'null'
      - boolean
    doc: share feedback slots when loading the same named property from the same
      object
    inputBinding:
      position: 101
      prefix: --ignition-share-named-property-feedback
  - id: incremental_marking
    type:
      - 'null'
      - boolean
    doc: use incremental marking
    inputBinding:
      position: 101
      prefix: --incremental-marking
  - id: incremental_marking_hard_trigger
    type:
      - 'null'
      - int
    doc: 'threshold for starting incremental marking immediately in percent of available
      space: limit - size'
    inputBinding:
      position: 101
      prefix: --incremental-marking-hard-trigger
  - id: incremental_marking_soft_trigger
    type:
      - 'null'
      - int
    doc: 'threshold for starting incremental marking via a task in percent of available
      space: limit - size'
    inputBinding:
      position: 101
      prefix: --incremental-marking-soft-trigger
  - id: incremental_marking_task
    type:
      - 'null'
      - boolean
    doc: use tasks for incremental marking
    inputBinding:
      position: 101
      prefix: --incremental-marking-task
  - id: incremental_marking_wrappers
    type:
      - 'null'
      - boolean
    doc: use incremental marking for marking wrappers
    inputBinding:
      position: 101
      prefix: --incremental-marking-wrappers
  - id: initial_heap_size
    type:
      - 'null'
      - string
    doc: initial size of the heap (in Mbytes)
    inputBinding:
      position: 101
      prefix: --initial-heap-size
  - id: initial_old_space_size
    type:
      - 'null'
      - string
    doc: initial old space size (in Mbytes)
    inputBinding:
      position: 101
      prefix: --initial-old-space-size
  - id: inline_new
    type:
      - 'null'
      - boolean
    doc: use fast inline allocation
    inputBinding:
      position: 101
      prefix: --inline-new
  - id: interpreted_frames_native_stack
    type:
      - 'null'
      - boolean
    doc: Show interpreted frames on the native stack (useful for external 
      profilers).
    inputBinding:
      position: 101
      prefix: --interpreted-frames-native-stack
  - id: interrupt_budget
    type:
      - 'null'
      - int
    doc: interrupt budget which should be used for the profiler counter
    inputBinding:
      position: 101
      prefix: --interrupt-budget
  - id: interrupt_budget_factor_for_feedback_allocation
    type:
      - 'null'
      - int
    doc: The interrupt budget factor (applied to bytecode size) for allocating 
      feedback vectors, used when bytecode size is known
    inputBinding:
      position: 101
      prefix: --interrupt-budget-factor-for-feedback-allocation
  - id: interrupt_budget_for_feedback_allocation
    type:
      - 'null'
      - int
    doc: The fixed interrupt budget (in bytecode size) for allocating feedback 
      vectors
    inputBinding:
      position: 101
      prefix: --interrupt-budget-for-feedback-allocation
  - id: interrupt_budget_for_maglev
    type:
      - 'null'
      - int
    doc: interrupt budget which should be used for the profiler counter
    inputBinding:
      position: 101
      prefix: --interrupt-budget-for-maglev
  - id: isolate_script_cache_ageing
    type:
      - 'null'
      - boolean
    doc: enable ageing of the isolate script cache.
    inputBinding:
      position: 101
      prefix: --isolate-script-cache-ageing
  - id: jitless
    type:
      - 'null'
      - boolean
    doc: Disable runtime allocation of executable memory.
    inputBinding:
      position: 101
      prefix: --jitless
  - id: lazy
    type:
      - 'null'
      - boolean
    doc: use lazy compilation
    inputBinding:
      position: 101
      prefix: --lazy
  - id: lazy_compile_dispatcher
    type:
      - 'null'
      - boolean
    doc: enable compiler dispatcher
    inputBinding:
      position: 101
      prefix: --lazy-compile-dispatcher
  - id: lazy_compile_dispatcher_max_threads
    type:
      - 'null'
      - string
    doc: max threads for compiler dispatcher (0 for unbounded)
    inputBinding:
      position: 101
      prefix: --lazy-compile-dispatcher-max-threads
  - id: lazy_eval
    type:
      - 'null'
      - boolean
    doc: use lazy compilation during eval
    inputBinding:
      position: 101
      prefix: --lazy-eval
  - id: lazy_feedback_allocation
    type:
      - 'null'
      - boolean
    doc: Allocate feedback vectors lazily
    inputBinding:
      position: 101
      prefix: --lazy-feedback-allocation
  - id: lazy_new_space_shrinking
    type:
      - 'null'
      - boolean
    doc: Enables the lazy new space shrinking strategy
    inputBinding:
      position: 101
      prefix: --lazy-new-space-shrinking
  - id: lazy_streaming
    type:
      - 'null'
      - boolean
    doc: use lazy compilation during streaming compilation
    inputBinding:
      position: 101
      prefix: --lazy-streaming
  - id: liftoff
    type:
      - 'null'
      - boolean
    doc: enable Liftoff, the baseline compiler for WebAssembly
    inputBinding:
      position: 101
      prefix: --liftoff
  - id: liftoff_only
    type:
      - 'null'
      - boolean
    doc: disallow TurboFan compilation for WebAssembly (for testing)
    inputBinding:
      position: 101
      prefix: --liftoff-only
  - id: lite_mode
    type:
      - 'null'
      - boolean
    doc: enables trade-off of performance for memory savings
    inputBinding:
      position: 101
      prefix: --lite-mode
  - id: ll_prof
    type:
      - 'null'
      - boolean
    doc: Enable low-level linux profiler.
    inputBinding:
      position: 101
      prefix: --ll-prof
  - id: log
    type:
      - 'null'
      - boolean
    doc: Minimal logging (no API, code, GC, suspect, or handles samples).
    inputBinding:
      position: 101
      prefix: --log
  - id: log_all
    type:
      - 'null'
      - boolean
    doc: Log all events to the log file.
    inputBinding:
      position: 101
      prefix: --log-all
  - id: log_code
    type:
      - 'null'
      - boolean
    doc: Log code events to the log file without profiling.
    inputBinding:
      position: 101
      prefix: --log-code
  - id: log_code_disassemble
    type:
      - 'null'
      - boolean
    doc: Log all disassembled code to the log file.
    inputBinding:
      position: 101
      prefix: --log-code-disassemble
  - id: log_colour
    type:
      - 'null'
      - boolean
    doc: When logging, try to use coloured output.
    inputBinding:
      position: 101
      prefix: --log-colour
  - id: log_deopt
    type:
      - 'null'
      - boolean
    doc: log deoptimization
    inputBinding:
      position: 101
      prefix: --log-deopt
  - id: log_function_events
    type:
      - 'null'
      - boolean
    doc: Log function events (parse, compile, execute) separately.
    inputBinding:
      position: 101
      prefix: --log-function-events
  - id: log_ic
    type:
      - 'null'
      - boolean
    doc: Log inline cache state transitions for tools/ic-processor
    inputBinding:
      position: 101
      prefix: --log-ic
  - id: log_internal_timer_events
    type:
      - 'null'
      - boolean
    doc: Time internal events.
    inputBinding:
      position: 101
      prefix: --log-internal-timer-events
  - id: log_maps
    type:
      - 'null'
      - boolean
    doc: Log map creation
    inputBinding:
      position: 101
      prefix: --log-maps
  - id: log_maps_details
    type:
      - 'null'
      - boolean
    doc: Also log map details
    inputBinding:
      position: 101
      prefix: --log-maps-details
  - id: log_source_code
    type:
      - 'null'
      - boolean
    doc: Log source code.
    inputBinding:
      position: 101
      prefix: --log-source-code
  - id: logfile
    type:
      - 'null'
      - string
    doc: Specify the name of the log file, use '-' for console, '+' for a 
      temporary file.
    inputBinding:
      position: 101
      prefix: --logfile
  - id: logfile_per_isolate
    type:
      - 'null'
      - boolean
    doc: Separate log files for each isolate.
    inputBinding:
      position: 101
      prefix: --logfile-per-isolate
  - id: maglev_break_on_entry
    type:
      - 'null'
      - boolean
    doc: insert an int3 on maglev entries
    inputBinding:
      position: 101
      prefix: --maglev-break-on-entry
  - id: maglev_filter
    type:
      - 'null'
      - string
    doc: optimization filter for the maglev compiler
    inputBinding:
      position: 101
      prefix: --maglev-filter
  - id: manual_evacuation_candidates_selection
    type:
      - 'null'
      - boolean
    doc: Test mode only flag. It allows an unit test to select evacuation 
      candidates pages (requires --stress_compaction).
    inputBinding:
      position: 101
      prefix: --manual-evacuation-candidates-selection
  - id: map_counters
    type:
      - 'null'
      - string
    doc: Map counters to a file
    inputBinding:
      position: 101
      prefix: --map-counters
  - id: max_bytecode_size_for_early_opt
    type:
      - 'null'
      - int
    doc: Maximum bytecode length for a function to be optimized on the first 
      tick
    inputBinding:
      position: 101
      prefix: --max-bytecode-size-for-early-opt
  - id: max_heap_size
    type:
      - 'null'
      - string
    doc: max size of the heap (in Mbytes) both max_semi_space_size and 
      max_old_space_size take precedence. All three flags cannot be specified at
      the same time.
    inputBinding:
      position: 101
      prefix: --max-heap-size
  - id: max_inlined_bytecode_size
    type:
      - 'null'
      - int
    doc: maximum size of bytecode for a single inlining
    inputBinding:
      position: 101
      prefix: --max-inlined-bytecode-size
  - id: max_inlined_bytecode_size_absolute
    type:
      - 'null'
      - int
    doc: maximum absolute size of bytecode considered for inlining
    inputBinding:
      position: 101
      prefix: --max-inlined-bytecode-size-absolute
  - id: max_inlined_bytecode_size_cumulative
    type:
      - 'null'
      - int
    doc: maximum cumulative size of bytecode considered for inlining
    inputBinding:
      position: 101
      prefix: --max-inlined-bytecode-size-cumulative
  - id: max_inlined_bytecode_size_small
    type:
      - 'null'
      - int
    doc: maximum size of bytecode considered for small function inlining
    inputBinding:
      position: 101
      prefix: --max-inlined-bytecode-size-small
  - id: max_lazy
    type:
      - 'null'
      - boolean
    doc: ignore eager compilation hints
    inputBinding:
      position: 101
      prefix: --max-lazy
  - id: max_old_space_size
    type:
      - 'null'
      - string
    doc: max size of the old space (in Mbytes)
    inputBinding:
      position: 101
      prefix: --max-old-space-size
  - id: max_optimized_bytecode_size
    type:
      - 'null'
      - int
    doc: maximum bytecode size to be considered for optimization; too high 
      values may cause the compiler to hit (release) assertions
    inputBinding:
      position: 101
      prefix: --max-optimized-bytecode-size
  - id: max_semi_space_size
    type:
      - 'null'
      - string
    doc: max size of a semi-space (in MBytes), the new space consists of two 
      semi-spaces
    inputBinding:
      position: 101
      prefix: --max-semi-space-size
  - id: max_serializer_nesting
    type:
      - 'null'
      - int
    doc: maximum levels for nesting child serializers
    inputBinding:
      position: 101
      prefix: --max-serializer-nesting
  - id: max_stack_trace_source_length
    type:
      - 'null'
      - int
    doc: maximum length of function source code printed in a stack trace.
    inputBinding:
      position: 101
      prefix: --max-stack-trace-source-length
  - id: max_valid_polymorphic_map_count
    type:
      - 'null'
      - int
    doc: maximum number of valid maps to track in POLYMORPHIC state
    inputBinding:
      position: 101
      prefix: --max-valid-polymorphic-map-count
  - id: mcpu
    type:
      - 'null'
      - string
    doc: enable optimization for specific cpu
    inputBinding:
      position: 101
      prefix: --mcpu
  - id: memory_reducer
    type:
      - 'null'
      - boolean
    doc: use memory reducer
    inputBinding:
      position: 101
      prefix: --memory-reducer
  - id: memory_reducer_for_small_heaps
    type:
      - 'null'
      - boolean
    doc: use memory reducer for small heaps
    inputBinding:
      position: 101
      prefix: --memory-reducer-for-small-heaps
  - id: min_inlining_frequency
    type:
      - 'null'
      - float
    doc: minimum frequency for inlining
    inputBinding:
      position: 101
      prefix: --min-inlining-frequency
  - id: min_semi_space_size
    type:
      - 'null'
      - string
    doc: min size of a semi-space (in MBytes), the new space consists of two 
      semi-spaces
    inputBinding:
      position: 101
      prefix: --min-semi-space-size
  - id: minor_mc
    type:
      - 'null'
      - boolean
    doc: perform young generation mark compact GCs
    inputBinding:
      position: 101
      prefix: --minor-mc
  - id: minor_mc_sweeping
    type:
      - 'null'
      - boolean
    doc: perform sweeping in young generation mark compact GCs
    inputBinding:
      position: 101
      prefix: --minor-mc-sweeping
  - id: minor_mc_trace_fragmentation
    type:
      - 'null'
      - boolean
    doc: trace fragmentation after marking
    inputBinding:
      position: 101
      prefix: --minor-mc-trace-fragmentation
  - id: mock_arraybuffer_allocator
    type:
      - 'null'
      - boolean
    doc: Use a mock ArrayBuffer allocator for testing.
    inputBinding:
      position: 101
      prefix: --mock-arraybuffer-allocator
  - id: mock_arraybuffer_allocator_limit
    type:
      - 'null'
      - string
    doc: Memory limit for mock ArrayBuffer allocator used to simulate OOM for 
      testing.
    inputBinding:
      position: 101
      prefix: --mock-arraybuffer-allocator-limit
  - id: move_object_start
    type:
      - 'null'
      - boolean
    doc: enable moving of object starts
    inputBinding:
      position: 101
      prefix: --move-object-start
  - id: multi_mapped_mock_allocator
    type:
      - 'null'
      - boolean
    doc: Use a multi-mapped mock ArrayBuffer allocator for testing.
    inputBinding:
      position: 101
      prefix: --multi-mapped-mock-allocator
  - id: native_code_counters
    type:
      - 'null'
      - boolean
    doc: generate extra code for manipulating stats counters
    inputBinding:
      position: 101
      prefix: --native-code-counters
  - id: opt
    type:
      - 'null'
      - boolean
    doc: use adaptive optimizations
    inputBinding:
      position: 101
      prefix: --opt
  - id: optimize_for_size
    type:
      - 'null'
      - boolean
    doc: Enables optimizations which favor memory size over execution speed
    inputBinding:
      position: 101
      prefix: --optimize-for-size
  - id: page_promotion
    type:
      - 'null'
      - boolean
    doc: promote pages based on utilization
    inputBinding:
      position: 101
      prefix: --page-promotion
  - id: page_promotion_threshold
    type:
      - 'null'
      - int
    doc: min percentage of live bytes on a page to enable fast evacuation
    inputBinding:
      position: 101
      prefix: --page-promotion-threshold
  - id: parallel_compaction
    type:
      - 'null'
      - boolean
    doc: use parallel compaction
    inputBinding:
      position: 101
      prefix: --parallel-compaction
  - id: parallel_compile_tasks_for_eager_toplevel
    type:
      - 'null'
      - boolean
    doc: spawn parallel compile tasks for eagerly compiled, top-level functions
    inputBinding:
      position: 101
      prefix: --parallel-compile-tasks-for-eager-toplevel
  - id: parallel_compile_tasks_for_lazy
    type:
      - 'null'
      - boolean
    doc: spawn parallel compile tasks for all lazily compiled functions
    inputBinding:
      position: 101
      prefix: --parallel-compile-tasks-for-lazy
  - id: parallel_marking
    type:
      - 'null'
      - boolean
    doc: use parallel marking in atomic pause
    inputBinding:
      position: 101
      prefix: --parallel-marking
  - id: parallel_pointer_update
    type:
      - 'null'
      - boolean
    doc: use parallel pointer update during compaction
    inputBinding:
      position: 101
      prefix: --parallel-pointer-update
  - id: parallel_scavenge
    type:
      - 'null'
      - boolean
    doc: parallel scavenge
    inputBinding:
      position: 101
      prefix: --parallel-scavenge
  - id: parse_only
    type:
      - 'null'
      - boolean
    doc: only parse the sources
    inputBinding:
      position: 101
      prefix: --parse-only
  - id: partial_constant_pool
    type:
      - 'null'
      - boolean
    doc: enable use of partial constant pools (X64 only)
    inputBinding:
      position: 101
      prefix: --partial-constant-pool
  - id: perf_basic_prof
    type:
      - 'null'
      - boolean
    doc: Enable perf linux profiler (basic support).
    inputBinding:
      position: 101
      prefix: --perf-basic-prof
  - id: perf_basic_prof_only_functions
    type:
      - 'null'
      - boolean
    doc: Only report function code ranges to perf (i.e. no stubs).
    inputBinding:
      position: 101
      prefix: --perf-basic-prof-only-functions
  - id: perf_prof
    type:
      - 'null'
      - boolean
    doc: Enable perf linux profiler (experimental annotate support).
    inputBinding:
      position: 101
      prefix: --perf-prof
  - id: perf_prof_annotate_wasm
    type:
      - 'null'
      - boolean
    doc: Used with --perf-prof, load wasm source map and provide annotate 
      support (experimental).
    inputBinding:
      position: 101
      prefix: --perf-prof-annotate-wasm
  - id: perf_prof_delete_file
    type:
      - 'null'
      - boolean
    doc: Remove the perf file right after creating it (for testing only).
    inputBinding:
      position: 101
      prefix: --perf-prof-delete-file
  - id: perf_prof_unwinding_info
    type:
      - 'null'
      - boolean
    doc: Enable unwinding info for perf linux profiler (experimental).
    inputBinding:
      position: 101
      prefix: --perf-prof-unwinding-info
  - id: polymorphic_inlining
    type:
      - 'null'
      - boolean
    doc: polymorphic inlining
    inputBinding:
      position: 101
      prefix: --polymorphic-inlining
  - id: predictable
    type:
      - 'null'
      - boolean
    doc: enable predictable mode
    inputBinding:
      position: 101
      prefix: --predictable
  - id: predictable_gc_schedule
    type:
      - 'null'
      - boolean
    doc: Predictable garbage collection schedule. Fixes heap growing, idle, and 
      memory reducing behavior.
    inputBinding:
      position: 101
      prefix: --predictable-gc-schedule
  - id: prepare_always_opt
    type:
      - 'null'
      - boolean
    doc: prepare for turning on always opt
    inputBinding:
      position: 101
      prefix: --prepare-always-opt
  - id: print_all_code
    type:
      - 'null'
      - boolean
    doc: enable all flags related to printing code
    inputBinding:
      position: 101
      prefix: --print-all-code
  - id: print_all_exceptions
    type:
      - 'null'
      - boolean
    doc: print exception object and stack trace on each thrown exception
    inputBinding:
      position: 101
      prefix: --print-all-exceptions
  - id: print_builtin_code
    type:
      - 'null'
      - boolean
    doc: print generated code for builtins
    inputBinding:
      position: 101
      prefix: --print-builtin-code
  - id: print_builtin_code_filter
    type:
      - 'null'
      - string
    doc: filter for printing builtin code
    inputBinding:
      position: 101
      prefix: --print-builtin-code-filter
  - id: print_builtin_size
    type:
      - 'null'
      - boolean
    doc: print code size for builtins
    inputBinding:
      position: 101
      prefix: --print-builtin-size
  - id: print_bytecode
    type:
      - 'null'
      - boolean
    doc: print bytecode generated by ignition interpreter
    inputBinding:
      position: 101
      prefix: --print-bytecode
  - id: print_bytecode_filter
    type:
      - 'null'
      - string
    doc: filter for selecting which functions to print bytecode
    inputBinding:
      position: 101
      prefix: --print-bytecode-filter
  - id: print_code
    type:
      - 'null'
      - boolean
    doc: print generated code
    inputBinding:
      position: 101
      prefix: --print-code
  - id: print_code_verbose
    type:
      - 'null'
      - boolean
    doc: print more information for code
    inputBinding:
      position: 101
      prefix: --print-code-verbose
  - id: print_deopt_stress
    type:
      - 'null'
      - boolean
    doc: print number of possible deopt points
    inputBinding:
      position: 101
      prefix: --print-deopt-stress
  - id: print_flag_values
    type:
      - 'null'
      - boolean
    doc: Print all flag values of V8
    inputBinding:
      position: 101
      prefix: --print-flag-values
  - id: print_maglev_code
    type:
      - 'null'
      - boolean
    doc: print maglev code
    inputBinding:
      position: 101
      prefix: --print-maglev-code
  - id: print_maglev_graph
    type:
      - 'null'
      - boolean
    doc: print maglev graph
    inputBinding:
      position: 101
      prefix: --print-maglev-graph
  - id: print_opt_code
    type:
      - 'null'
      - boolean
    doc: print optimized code
    inputBinding:
      position: 101
      prefix: --print-opt-code
  - id: print_opt_code_filter
    type:
      - 'null'
      - string
    doc: filter for printing optimized code
    inputBinding:
      position: 101
      prefix: --print-opt-code-filter
  - id: print_opt_source
    type:
      - 'null'
      - boolean
    doc: print source code of optimized and inlined functions
    inputBinding:
      position: 101
      prefix: --print-opt-source
  - id: print_regexp_bytecode
    type:
      - 'null'
      - boolean
    doc: print generated regexp bytecode
    inputBinding:
      position: 101
      prefix: --print-regexp-bytecode
  - id: print_regexp_code
    type:
      - 'null'
      - boolean
    doc: print generated regexp code
    inputBinding:
      position: 101
      prefix: --print-regexp-code
  - id: print_wasm_code
    type:
      - 'null'
      - boolean
    doc: print WebAssembly code
    inputBinding:
      position: 101
      prefix: --print-wasm-code
  - id: print_wasm_code_function_index
    type:
      - 'null'
      - int
    doc: print WebAssembly code for function at index
    inputBinding:
      position: 101
      prefix: --print-wasm-code-function-index
  - id: print_wasm_stub_code
    type:
      - 'null'
      - boolean
    doc: print WebAssembly stub code
    inputBinding:
      position: 101
      prefix: --print-wasm-stub-code
  - id: prof
    type:
      - 'null'
      - boolean
    doc: Log statistical profiling information (implies --log-code).
    inputBinding:
      position: 101
      prefix: --prof
  - id: prof_browser_mode
    type:
      - 'null'
      - boolean
    doc: Used with --prof, turns on browser-compatible mode for profiling.
    inputBinding:
      position: 101
      prefix: --prof-browser-mode
  - id: prof_cpp
    type:
      - 'null'
      - boolean
    doc: Like --prof, but ignore generated code.
    inputBinding:
      position: 101
      prefix: --prof-cpp
  - id: prof_sampling_interval
    type:
      - 'null'
      - int
    doc: Interval for --prof samples (in microseconds).
    inputBinding:
      position: 101
      prefix: --prof-sampling-interval
  - id: profile_deserialization
    type:
      - 'null'
      - boolean
    doc: Print the time it takes to deserialize the snapshot.
    inputBinding:
      position: 101
      prefix: --profile-deserialization
  - id: random_gc_interval
    type:
      - 'null'
      - int
    doc: Collect garbage after random(0, X) allocations. It overrides 
      gc_interval.
    inputBinding:
      position: 101
      prefix: --random-gc-interval
  - id: random_seed
    type:
      - 'null'
      - int
    doc: Default seed for initializing random generator (0, the default, means 
      to use system random).
    inputBinding:
      position: 101
      prefix: --random-seed
  - id: randomize_all_allocations
    type:
      - 'null'
      - boolean
    doc: randomize virtual memory reservations by ignoring any hints passed when
      allocating pages
    inputBinding:
      position: 101
      prefix: --randomize-all-allocations
  - id: rcs
    type:
      - 'null'
      - boolean
    doc: report runtime call counts and times
    inputBinding:
      position: 101
      prefix: --rcs
  - id: rcs_cpu_time
    type:
      - 'null'
      - boolean
    doc: report runtime times in cpu time (the default is wall time)
    inputBinding:
      position: 101
      prefix: --rcs-cpu-time
  - id: reclaim_unmodified_wrappers
    type:
      - 'null'
      - boolean
    doc: reclaim otherwise unreachable unmodified wrapper objects when possible
    inputBinding:
      position: 101
      prefix: --reclaim-unmodified-wrappers
  - id: redirect_code_traces
    type:
      - 'null'
      - boolean
    doc: output deopt information and disassembly into file code-<pid>-<isolate 
      id>.asm
    inputBinding:
      position: 101
      prefix: --redirect-code-traces
  - id: redirect_code_traces_to
    type:
      - 'null'
      - string
    doc: output deopt information and disassembly into the given file
    inputBinding:
      position: 101
      prefix: --redirect-code-traces-to
  - id: regexp_backtracks_before_fallback
    type:
      - 'null'
      - string
    doc: number of backtracks during regexp execution before fall back to 
      experimental engine if 
      enable_experimental_regexp_engine_on_excessive_backtracks is set
    inputBinding:
      position: 101
      prefix: --regexp-backtracks-before-fallback
  - id: regexp_interpret_all
    type:
      - 'null'
      - boolean
    doc: interpret all regexp code
    inputBinding:
      position: 101
      prefix: --regexp-interpret-all
  - id: regexp_optimization
    type:
      - 'null'
      - boolean
    doc: generate optimized regexp code
    inputBinding:
      position: 101
      prefix: --regexp-optimization
  - id: regexp_peephole_optimization
    type:
      - 'null'
      - boolean
    doc: enable peephole optimization for regexp bytecode
    inputBinding:
      position: 101
      prefix: --regexp-peephole-optimization
  - id: regexp_tier_up
    type:
      - 'null'
      - boolean
    doc: enable regexp interpreter and tier up to the compiler after the number 
      of executions set by the tier up ticks flag
    inputBinding:
      position: 101
      prefix: --regexp-tier-up
  - id: regexp_tier_up_ticks
    type:
      - 'null'
      - int
    doc: set the number of executions for the regexp interpreter before 
      tiering-up to the compiler
    inputBinding:
      position: 101
      prefix: --regexp-tier-up-ticks
  - id: rehash_snapshot
    type:
      - 'null'
      - boolean
    doc: rehash strings from the snapshot to override the baked-in seed
    inputBinding:
      position: 101
      prefix: --rehash-snapshot
  - id: reserve_inline_budget_scale_factor
    type:
      - 'null'
      - float
    doc: scale factor of bytecode size used to calculate the inlining budget
    inputBinding:
      position: 101
      prefix: --reserve-inline-budget-scale-factor
  - id: retain_maps_for_n_gc
    type:
      - 'null'
      - int
    doc: keeps maps alive for <n> old space garbage collections
    inputBinding:
      position: 101
      prefix: --retain-maps-for-n-gc
  - id: runtime_call_stats
    type:
      - 'null'
      - boolean
    doc: report runtime call counts and times
    inputBinding:
      position: 101
      prefix: --runtime-call-stats
  - id: sampling_heap_profiler_suppress_randomness
    type:
      - 'null'
      - boolean
    doc: Use constant sample intervals to eliminate test flakiness
    inputBinding:
      position: 101
      prefix: --sampling-heap-profiler-suppress-randomness
  - id: scavenge_separate_stack_scanning
    type:
      - 'null'
      - boolean
    doc: use a separate phase for stack scanning in scavenge
    inputBinding:
      position: 101
      prefix: --scavenge-separate-stack-scanning
  - id: scavenge_task
    type:
      - 'null'
      - boolean
    doc: schedule scavenge tasks
    inputBinding:
      position: 101
      prefix: --scavenge-task
  - id: scavenge_task_trigger
    type:
      - 'null'
      - int
    doc: scavenge task trigger in percent of the current heap limit
    inputBinding:
      position: 101
      prefix: --scavenge-task-trigger
  - id: script_delay
    type:
      - 'null'
      - float
    doc: busy wait [ms] on every Script::Run
    inputBinding:
      position: 101
      prefix: --script-delay
  - id: script_delay_fraction
    type:
      - 'null'
      - float
    doc: busy wait after each Script::Run by the given fraction of the run's 
      duration
    inputBinding:
      position: 101
      prefix: --script-delay-fraction
  - id: script_delay_once
    type:
      - 'null'
      - float
    doc: busy wait [ms] on the first Script::Run
    inputBinding:
      position: 101
      prefix: --script-delay-once
  - id: script_streaming
    type:
      - 'null'
      - boolean
    doc: enable parsing on background
    inputBinding:
      position: 101
      prefix: --script-streaming
  - id: semi_space_growth_factor
    type:
      - 'null'
      - int
    doc: factor by which to grow the new space
    inputBinding:
      position: 101
      prefix: --semi-space-growth-factor
  - id: separate_gc_phases
    type:
      - 'null'
      - boolean
    doc: yound and full garbage collection phases are not overlapping
    inputBinding:
      position: 101
      prefix: --separate-gc-phases
  - id: serialization_statistics
    type:
      - 'null'
      - boolean
    doc: Collect statistics on serialized objects.
    inputBinding:
      position: 101
      prefix: --serialization-statistics
  - id: shared_string_table
    type:
      - 'null'
      - boolean
    doc: internalize strings into shared table
    inputBinding:
      position: 101
      prefix: --shared-string-table
  - id: short_builtin_calls
    type:
      - 'null'
      - boolean
    doc: Put embedded builtins code into the code range for shorter builtin 
      calls/jumps if system has >=4GB memory
    inputBinding:
      position: 101
      prefix: --short-builtin-calls
  - id: sim_arm64_optional_features
    type:
      - 'null'
      - string
    doc: 'enable optional features on the simulator for testing: none or all'
    inputBinding:
      position: 101
      prefix: --sim-arm64-optional-features
  - id: single_threaded
    type:
      - 'null'
      - boolean
    doc: disable the use of background tasks
    inputBinding:
      position: 101
      prefix: --single-threaded
  - id: single_threaded_gc
    type:
      - 'null'
      - boolean
    doc: disable the use of background gc tasks
    inputBinding:
      position: 101
      prefix: --single-threaded-gc
  - id: slow_histograms
    type:
      - 'null'
      - boolean
    doc: Enable slow histograms with more overhead.
    inputBinding:
      position: 101
      prefix: --slow-histograms
  - id: sparkplug
    type:
      - 'null'
      - boolean
    doc: enable Sparkplug baseline compiler
    inputBinding:
      position: 101
      prefix: --sparkplug
  - id: sparkplug_filter
    type:
      - 'null'
      - string
    doc: filter for Sparkplug baseline compiler
    inputBinding:
      position: 101
      prefix: --sparkplug-filter
  - id: sparkplug_needs_short_builtins
    type:
      - 'null'
      - boolean
    doc: only enable Sparkplug baseline compiler when --short-builtin-calls are 
      also enabled
    inputBinding:
      position: 101
      prefix: --sparkplug-needs-short-builtins
  - id: stack_size
    type:
      - 'null'
      - int
    doc: default size of stack region v8 is allowed to use (in kBytes)
    inputBinding:
      position: 101
      prefix: --stack-size
  - id: stack_trace_limit
    type:
      - 'null'
      - int
    doc: number of stack frames to capture
    inputBinding:
      position: 101
      prefix: --stack-trace-limit
  - id: stack_trace_on_illegal
    type:
      - 'null'
      - boolean
    doc: print stack trace when an illegal exception is thrown
    inputBinding:
      position: 101
      prefix: --stack-trace-on-illegal
  - id: startup_blob
    type:
      - 'null'
      - string
    doc: Write V8 startup blob file. (mksnapshot only)
    inputBinding:
      position: 101
      prefix: --startup-blob
  - id: startup_src
    type:
      - 'null'
      - string
    doc: Write V8 startup as C++ src. (mksnapshot only)
    inputBinding:
      position: 101
      prefix: --startup-src
  - id: stress_background_compile
    type:
      - 'null'
      - boolean
    doc: stress test parsing on background
    inputBinding:
      position: 101
      prefix: --stress-background-compile
  - id: stress_compaction
    type:
      - 'null'
      - boolean
    doc: Stress GC compaction to flush out bugs (implies 
      --force_marking_deque_overflows)
    inputBinding:
      position: 101
      prefix: --stress-compaction
  - id: stress_compaction_random
    type:
      - 'null'
      - boolean
    doc: Stress GC compaction by selecting random percent of pages as evacuation
      candidates. Overrides stress_compaction.
    inputBinding:
      position: 101
      prefix: --stress-compaction-random
  - id: stress_concurrent_allocation
    type:
      - 'null'
      - boolean
    doc: start background threads that allocate memory
    inputBinding:
      position: 101
      prefix: --stress-concurrent-allocation
  - id: stress_concurrent_inlining
    type:
      - 'null'
      - boolean
    doc: create additional concurrent optimization jobs but throw away result
    inputBinding:
      position: 101
      prefix: --stress-concurrent-inlining
  - id: stress_concurrent_inlining_attach_code
    type:
      - 'null'
      - boolean
    doc: create additional concurrent optimization jobs
    inputBinding:
      position: 101
      prefix: --stress-concurrent-inlining-attach-code
  - id: stress_flush_code
    type:
      - 'null'
      - boolean
    doc: stress code flushing
    inputBinding:
      position: 101
      prefix: --stress-flush-code
  - id: stress_gc_during_compilation
    type:
      - 'null'
      - boolean
    doc: simulate GC/compiler thread race related to https://crbug.com/v8/8520
    inputBinding:
      position: 101
      prefix: --stress-gc-during-compilation
  - id: stress_incremental_marking
    type:
      - 'null'
      - boolean
    doc: force incremental marking for small heaps and run it more often
    inputBinding:
      position: 101
      prefix: --stress-incremental-marking
  - id: stress_inline
    type:
      - 'null'
      - boolean
    doc: set high thresholds for inlining to inline as much as possible
    inputBinding:
      position: 101
      prefix: --stress-inline
  - id: stress_lazy_source_positions
    type:
      - 'null'
      - boolean
    doc: collect lazy source positions immediately after lazy compile
    inputBinding:
      position: 101
      prefix: --stress-lazy-source-positions
  - id: stress_marking
    type:
      - 'null'
      - int
    doc: force marking at random points between 0 and X (inclusive) percent of 
      the regular marking start limit
    inputBinding:
      position: 101
      prefix: --stress-marking
  - id: stress_per_context_marking_worklist
    type:
      - 'null'
      - boolean
    doc: Use per-context worklist for marking
    inputBinding:
      position: 101
      prefix: --stress-per-context-marking-worklist
  - id: stress_runs
    type:
      - 'null'
      - int
    doc: number of stress runs
    inputBinding:
      position: 101
      prefix: --stress-runs
  - id: stress_sampling_allocation_profiler
    type:
      - 'null'
      - int
    doc: Enables sampling allocation profiler with X as a sample interval
    inputBinding:
      position: 101
      prefix: --stress-sampling-allocation-profiler
  - id: stress_scavenge
    type:
      - 'null'
      - int
    doc: force scavenge at random points between 0 and X (inclusive) percent of 
      the new space capacity
    inputBinding:
      position: 101
      prefix: --stress-scavenge
  - id: stress_snapshot
    type:
      - 'null'
      - boolean
    doc: disables sharing of the read-only heap for testing
    inputBinding:
      position: 101
      prefix: --stress-snapshot
  - id: stress_turbo_late_spilling
    type:
      - 'null'
      - boolean
    doc: optimize placement of all spill instructions, not just loop-top phis
    inputBinding:
      position: 101
      prefix: --stress-turbo-late-spilling
  - id: stress_validate_asm
    type:
      - 'null'
      - boolean
    doc: try to validate everything as asm.js
    inputBinding:
      position: 101
      prefix: --stress-validate-asm
  - id: stress_wasm_code_gc
    type:
      - 'null'
      - boolean
    doc: stress test garbage collection of wasm code
    inputBinding:
      position: 101
      prefix: --stress-wasm-code-gc
  - id: super_ic
    type:
      - 'null'
      - boolean
    doc: use an IC for super property loads
    inputBinding:
      position: 101
      prefix: --super-ic
  - id: suppress_asm_messages
    type:
      - 'null'
      - boolean
    doc: don't emit asm.js related messages (for golden file testing)
    inputBinding:
      position: 101
      prefix: --suppress-asm-messages
  - id: switch_table_min_cases
    type:
      - 'null'
      - int
    doc: the number of Smi integer cases present in the switch statement before 
      using the jump table optimization
    inputBinding:
      position: 101
      prefix: --switch-table-min-cases
  - id: switch_table_spread_threshold
    type:
      - 'null'
      - int
    doc: allow the jump table used for switch statements to span a range of 
      integers roughly equal to this number times the number of clauses in the 
      switch
    inputBinding:
      position: 101
      prefix: --switch-table-spread-threshold
  - id: target_arch
    type:
      - 'null'
      - string
    doc: The mksnapshot target arch. (mksnapshot only)
    inputBinding:
      position: 101
      prefix: --target-arch
  - id: target_is_simulator
    type:
      - 'null'
      - boolean
    doc: Instruct mksnapshot that the target is meant to run in the simulator 
      and it can generate simulator-specific instructions. (mksnapshot only)
    inputBinding:
      position: 101
      prefix: --target-is-simulator
  - id: target_os
    type:
      - 'null'
      - string
    doc: The mksnapshot target os. (mksnapshot only)
    inputBinding:
      position: 101
      prefix: --target-os
  - id: test_small_max_function_context_stub_size
    type:
      - 'null'
      - boolean
    doc: enable testing the function context size overflow path by making the 
      maximum size smaller
    inputBinding:
      position: 101
      prefix: --test-small-max-function-context-stub-size
  - id: testing_bool_flag
    type:
      - 'null'
      - boolean
    doc: testing_bool_flag
    inputBinding:
      position: 101
      prefix: --testing-bool-flag
  - id: testing_d8_test_runner
    type:
      - 'null'
      - boolean
    doc: test runner turns on this flag to enable a check that the function was 
      prepared for optimization before marking it for optimization
    inputBinding:
      position: 101
      prefix: --testing-d8-test-runner
  - id: testing_float_flag
    type:
      - 'null'
      - float
    doc: float-flag
    inputBinding:
      position: 101
      prefix: --testing-float-flag
  - id: testing_int_flag
    type:
      - 'null'
      - int
    doc: testing_int_flag
    inputBinding:
      position: 101
      prefix: --testing-int-flag
  - id: testing_maybe_bool_flag
    type:
      - 'null'
      - string
    doc: testing_maybe_bool_flag
    inputBinding:
      position: 101
      prefix: --testing-maybe-bool-flag
  - id: testing_prng_seed
    type:
      - 'null'
      - int
    doc: Seed used for threading test randomness
    inputBinding:
      position: 101
      prefix: --testing-prng-seed
  - id: testing_string_flag
    type:
      - 'null'
      - string
    doc: string-flag
    inputBinding:
      position: 101
      prefix: --testing-string-flag
  - id: text_is_readable
    type:
      - 'null'
      - boolean
    doc: Whether the .text section of binary can be read
    inputBinding:
      position: 101
      prefix: --text-is-readable
  - id: ticks_before_optimization
    type:
      - 'null'
      - int
    doc: the number of times we have to go through the interrupt budget before 
      considering this function for optimization
    inputBinding:
      position: 101
      prefix: --ticks-before-optimization
  - id: trace
    type:
      - 'null'
      - boolean
    doc: trace javascript function calls
    inputBinding:
      position: 101
      prefix: --trace
  - id: trace_all_uses
    type:
      - 'null'
      - boolean
    doc: trace all use positions
    inputBinding:
      position: 101
      prefix: --trace-all-uses
  - id: trace_allocation_stack_interval
    type:
      - 'null'
      - int
    doc: print stack trace after <n> free-list allocations
    inputBinding:
      position: 101
      prefix: --trace-allocation-stack-interval
  - id: trace_allocations_origins
    type:
      - 'null'
      - boolean
    doc: Show statistics about the origins of allocations. Combine with 
      --no-inline-new to track allocations from generated code
    inputBinding:
      position: 101
      prefix: --trace-allocations-origins
  - id: trace_asm_parser
    type:
      - 'null'
      - boolean
    doc: verbose logging of asm.js parse failures
    inputBinding:
      position: 101
      prefix: --trace-asm-parser
  - id: trace_asm_scanner
    type:
      - 'null'
      - boolean
    doc: print tokens encountered by asm.js scanner
    inputBinding:
      position: 101
      prefix: --trace-asm-scanner
  - id: trace_asm_time
    type:
      - 'null'
      - boolean
    doc: print asm.js timing info to the console
    inputBinding:
      position: 101
      prefix: --trace-asm-time
  - id: trace_baseline
    type:
      - 'null'
      - boolean
    doc: trace baseline compilation
    inputBinding:
      position: 101
      prefix: --trace-baseline
  - id: trace_baseline_batch_compilation
    type:
      - 'null'
      - boolean
    doc: trace baseline batch compilation
    inputBinding:
      position: 101
      prefix: --trace-baseline-batch-compilation
  - id: trace_baseline_concurrent_compilation
    type:
      - 'null'
      - boolean
    doc: trace baseline concurrent compilation
    inputBinding:
      position: 101
      prefix: --trace-baseline-concurrent-compilation
  - id: trace_block_coverage
    type:
      - 'null'
      - boolean
    doc: trace collected block coverage information
    inputBinding:
      position: 101
      prefix: --trace-block-coverage
  - id: trace_compilation_dependencies
    type:
      - 'null'
      - boolean
    doc: trace code dependencies
    inputBinding:
      position: 101
      prefix: --trace-compilation-dependencies
  - id: trace_compiler_dispatcher
    type:
      - 'null'
      - boolean
    doc: trace compiler dispatcher activity
    inputBinding:
      position: 101
      prefix: --trace-compiler-dispatcher
  - id: trace_concurrent_marking
    type:
      - 'null'
      - boolean
    doc: trace concurrent marking
    inputBinding:
      position: 101
      prefix: --trace-concurrent-marking
  - id: trace_concurrent_recompilation
    type:
      - 'null'
      - boolean
    doc: track concurrent recompilation
    inputBinding:
      position: 101
      prefix: --trace-concurrent-recompilation
  - id: trace_creation_allocation_sites
    type:
      - 'null'
      - boolean
    doc: trace the creation of allocation sites
    inputBinding:
      position: 101
      prefix: --trace-creation-allocation-sites
  - id: trace_deopt
    type:
      - 'null'
      - boolean
    doc: trace deoptimization
    inputBinding:
      position: 101
      prefix: --trace-deopt
  - id: trace_deopt_verbose
    type:
      - 'null'
      - boolean
    doc: extra verbose deoptimization tracing
    inputBinding:
      position: 101
      prefix: --trace-deopt-verbose
  - id: trace_detached_contexts
    type:
      - 'null'
      - boolean
    doc: trace native contexts that are expected to be garbage collected
    inputBinding:
      position: 101
      prefix: --trace-detached-contexts
  - id: trace_duplicate_threshold_kb
    type:
      - 'null'
      - int
    doc: print duplicate objects in the heap if their size is more than given 
      threshold
    inputBinding:
      position: 101
      prefix: --trace-duplicate-threshold-kb
  - id: trace_elements_transitions
    type:
      - 'null'
      - boolean
    doc: trace elements transitions
    inputBinding:
      position: 101
      prefix: --trace-elements-transitions
  - id: trace_environment_liveness
    type:
      - 'null'
      - boolean
    doc: trace liveness of local variable slots
    inputBinding:
      position: 101
      prefix: --trace-environment-liveness
  - id: trace_evacuation
    type:
      - 'null'
      - boolean
    doc: report evacuation statistics
    inputBinding:
      position: 101
      prefix: --trace-evacuation
  - id: trace_evacuation_candidates
    type:
      - 'null'
      - boolean
    doc: Show statistics about the pages evacuation by the compaction
    inputBinding:
      position: 101
      prefix: --trace-evacuation-candidates
  - id: trace_experimental_regexp_engine
    type:
      - 'null'
      - boolean
    doc: trace execution of experimental regexp engine
    inputBinding:
      position: 101
      prefix: --trace-experimental-regexp-engine
  - id: trace_file_names
    type:
      - 'null'
      - boolean
    doc: include file names in trace-opt/trace-deopt output
    inputBinding:
      position: 101
      prefix: --trace-file-names
  - id: trace_flush_bytecode
    type:
      - 'null'
      - boolean
    doc: trace bytecode flushing
    inputBinding:
      position: 101
      prefix: --trace-flush-bytecode
  - id: trace_for_in_enumerate
    type:
      - 'null'
      - boolean
    doc: Trace for-in enumerate slow-paths
    inputBinding:
      position: 101
      prefix: --trace-for-in-enumerate
  - id: trace_fragmentation
    type:
      - 'null'
      - boolean
    doc: report fragmentation for old space
    inputBinding:
      position: 101
      prefix: --trace-fragmentation
  - id: trace_fragmentation_verbose
    type:
      - 'null'
      - boolean
    doc: report fragmentation for old space (detailed)
    inputBinding:
      position: 101
      prefix: --trace-fragmentation-verbose
  - id: trace_gc
    type:
      - 'null'
      - boolean
    doc: print one trace line following each garbage collection
    inputBinding:
      position: 101
      prefix: --trace-gc
  - id: trace_gc_freelists
    type:
      - 'null'
      - boolean
    doc: prints details of each freelist before and after each major garbage 
      collection
    inputBinding:
      position: 101
      prefix: --trace-gc-freelists
  - id: trace_gc_freelists_verbose
    type:
      - 'null'
      - boolean
    doc: prints details of freelists of each page before and after each major 
      garbage collection
    inputBinding:
      position: 101
      prefix: --trace-gc-freelists-verbose
  - id: trace_gc_heap_layout
    type:
      - 'null'
      - boolean
    doc: print layout of pages in heap before and after gc
    inputBinding:
      position: 101
      prefix: --trace-gc-heap-layout
  - id: trace_gc_heap_layout_ignore_minor_gc
    type:
      - 'null'
      - boolean
    doc: do not print trace line before and after minor-gc
    inputBinding:
      position: 101
      prefix: --trace-gc-heap-layout-ignore-minor-gc
  - id: trace_gc_ignore_scavenger
    type:
      - 'null'
      - boolean
    doc: do not print trace line after scavenger collection
    inputBinding:
      position: 101
      prefix: --trace-gc-ignore-scavenger
  - id: trace_gc_nvp
    type:
      - 'null'
      - boolean
    doc: print one detailed trace line in name=value format after each garbage 
      collection
    inputBinding:
      position: 101
      prefix: --trace-gc-nvp
  - id: trace_gc_object_stats
    type:
      - 'null'
      - boolean
    doc: trace object counts and memory usage
    inputBinding:
      position: 101
      prefix: --trace-gc-object-stats
  - id: trace_gc_verbose
    type:
      - 'null'
      - boolean
    doc: print more details following each garbage collection
    inputBinding:
      position: 101
      prefix: --trace-gc-verbose
  - id: trace_generalization
    type:
      - 'null'
      - boolean
    doc: trace map generalization
    inputBinding:
      position: 101
      prefix: --trace-generalization
  - id: trace_heap_broker
    type:
      - 'null'
      - boolean
    doc: trace the heap broker (reports on missing data only)
    inputBinding:
      position: 101
      prefix: --trace-heap-broker
  - id: trace_heap_broker_memory
    type:
      - 'null'
      - boolean
    doc: trace the heap broker memory (refs analysis and zone numbers)
    inputBinding:
      position: 101
      prefix: --trace-heap-broker-memory
  - id: trace_heap_broker_verbose
    type:
      - 'null'
      - boolean
    doc: trace the heap broker verbosely (all reports)
    inputBinding:
      position: 101
      prefix: --trace-heap-broker-verbose
  - id: trace_idle_notification
    type:
      - 'null'
      - boolean
    doc: print one trace line following each idle notification
    inputBinding:
      position: 101
      prefix: --trace-idle-notification
  - id: trace_idle_notification_verbose
    type:
      - 'null'
      - boolean
    doc: prints the heap state used by the idle notification
    inputBinding:
      position: 101
      prefix: --trace-idle-notification-verbose
  - id: trace_ignition_codegen
    type:
      - 'null'
      - boolean
    doc: trace the codegen of ignition interpreter bytecode handlers
    inputBinding:
      position: 101
      prefix: --trace-ignition-codegen
  - id: trace_ignition_dispatches_output_file
    type:
      - 'null'
      - string
    doc: write the bytecode handler dispatch table to the specified file (d8 
      only) (requires building with v8_enable_ignition_dispatch_counting)
    inputBinding:
      position: 101
      prefix: --trace-ignition-dispatches-output-file
  - id: trace_incremental_marking
    type:
      - 'null'
      - boolean
    doc: trace progress of the incremental marking
    inputBinding:
      position: 101
      prefix: --trace-incremental-marking
  - id: trace_maglev_regalloc
    type:
      - 'null'
      - boolean
    doc: trace maglev register allocation
    inputBinding:
      position: 101
      prefix: --trace-maglev-regalloc
  - id: trace_migration
    type:
      - 'null'
      - boolean
    doc: trace object migration
    inputBinding:
      position: 101
      prefix: --trace-migration
  - id: trace_minor_mc_parallel_marking
    type:
      - 'null'
      - boolean
    doc: trace parallel marking for the young generation
    inputBinding:
      position: 101
      prefix: --trace-minor-mc-parallel-marking
  - id: trace_mutator_utilization
    type:
      - 'null'
      - boolean
    doc: print mutator utilization, allocation speed, gc speed
    inputBinding:
      position: 101
      prefix: --trace-mutator-utilization
  - id: trace_opt
    type:
      - 'null'
      - boolean
    doc: trace optimized compilation
    inputBinding:
      position: 101
      prefix: --trace-opt
  - id: trace_opt_stats
    type:
      - 'null'
      - boolean
    doc: trace optimized compilation statistics
    inputBinding:
      position: 101
      prefix: --trace-opt-stats
  - id: trace_opt_verbose
    type:
      - 'null'
      - boolean
    doc: extra verbose optimized compilation tracing
    inputBinding:
      position: 101
      prefix: --trace-opt-verbose
  - id: trace_osr
    type:
      - 'null'
      - boolean
    doc: trace on-stack replacement
    inputBinding:
      position: 101
      prefix: --trace-osr
  - id: trace_parallel_scavenge
    type:
      - 'null'
      - boolean
    doc: trace parallel scavenge
    inputBinding:
      position: 101
      prefix: --trace-parallel-scavenge
  - id: trace_pending_allocations
    type:
      - 'null'
      - boolean
    doc: trace calls to Heap::IsAllocationPending that return true
    inputBinding:
      position: 101
      prefix: --trace-pending-allocations
  - id: trace_pretenuring
    type:
      - 'null'
      - boolean
    doc: trace pretenuring decisions of HAllocate instructions
    inputBinding:
      position: 101
      prefix: --trace-pretenuring
  - id: trace_pretenuring_statistics
    type:
      - 'null'
      - boolean
    doc: trace allocation site pretenuring statistics
    inputBinding:
      position: 101
      prefix: --trace-pretenuring-statistics
  - id: trace_protector_invalidation
    type:
      - 'null'
      - boolean
    doc: trace protector cell invalidations
    inputBinding:
      position: 101
      prefix: --trace-protector-invalidation
  - id: trace_prototype_users
    type:
      - 'null'
      - boolean
    doc: Trace updates to prototype user tracking
    inputBinding:
      position: 101
      prefix: --trace-prototype-users
  - id: trace_rail
    type:
      - 'null'
      - boolean
    doc: trace RAIL mode
    inputBinding:
      position: 101
      prefix: --trace-rail
  - id: trace_regexp_assembler
    type:
      - 'null'
      - boolean
    doc: trace regexp macro assembler calls.
    inputBinding:
      position: 101
      prefix: --trace-regexp-assembler
  - id: trace_regexp_bytecodes
    type:
      - 'null'
      - boolean
    doc: trace regexp bytecode execution
    inputBinding:
      position: 101
      prefix: --trace-regexp-bytecodes
  - id: trace_regexp_graph
    type:
      - 'null'
      - boolean
    doc: trace the regexp graph
    inputBinding:
      position: 101
      prefix: --trace-regexp-graph
  - id: trace_regexp_parser
    type:
      - 'null'
      - boolean
    doc: trace regexp parsing
    inputBinding:
      position: 101
      prefix: --trace-regexp-parser
  - id: trace_regexp_peephole_optimization
    type:
      - 'null'
      - boolean
    doc: trace regexp bytecode peephole optimization
    inputBinding:
      position: 101
      prefix: --trace-regexp-peephole-optimization
  - id: trace_regexp_tier_up
    type:
      - 'null'
      - boolean
    doc: trace regexp tiering up execution
    inputBinding:
      position: 101
      prefix: --trace-regexp-tier-up
  - id: trace_representation
    type:
      - 'null'
      - boolean
    doc: trace representation types
    inputBinding:
      position: 101
      prefix: --trace-representation
  - id: trace_serializer
    type:
      - 'null'
      - boolean
    doc: print code serializer trace
    inputBinding:
      position: 101
      prefix: --trace-serializer
  - id: trace_side_effect_free_debug_evaluate
    type:
      - 'null'
      - boolean
    doc: print debug messages for side-effect-free debug-evaluate for testing
    inputBinding:
      position: 101
      prefix: --trace-side-effect-free-debug-evaluate
  - id: trace_store_elimination
    type:
      - 'null'
      - boolean
    doc: trace store elimination
    inputBinding:
      position: 101
      prefix: --trace-store-elimination
  - id: trace_stress_marking
    type:
      - 'null'
      - boolean
    doc: trace stress marking progress
    inputBinding:
      position: 101
      prefix: --trace-stress-marking
  - id: trace_stress_scavenge
    type:
      - 'null'
      - boolean
    doc: trace stress scavenge progress
    inputBinding:
      position: 101
      prefix: --trace-stress-scavenge
  - id: trace_temporal
    type:
      - 'null'
      - boolean
    doc: trace temporal code
    inputBinding:
      position: 101
      prefix: --trace-temporal
  - id: trace_track_allocation_sites
    type:
      - 'null'
      - boolean
    doc: trace the tracking of allocation sites
    inputBinding:
      position: 101
      prefix: --trace-track-allocation-sites
  - id: trace_turbo
    type:
      - 'null'
      - boolean
    doc: trace generated TurboFan IR
    inputBinding:
      position: 101
      prefix: --trace-turbo
  - id: trace_turbo_alloc
    type:
      - 'null'
      - boolean
    doc: trace TurboFan's register allocator
    inputBinding:
      position: 101
      prefix: --trace-turbo-alloc
  - id: trace_turbo_ceq
    type:
      - 'null'
      - boolean
    doc: trace TurboFan's control equivalence
    inputBinding:
      position: 101
      prefix: --trace-turbo-ceq
  - id: trace_turbo_cfg_file
    type:
      - 'null'
      - string
    doc: trace turbo cfg graph (for C1 visualizer) to a given file name
    inputBinding:
      position: 101
      prefix: --trace-turbo-cfg-file
  - id: trace_turbo_filter
    type:
      - 'null'
      - string
    doc: filter for tracing turbofan compilation
    inputBinding:
      position: 101
      prefix: --trace-turbo-filter
  - id: trace_turbo_graph
    type:
      - 'null'
      - boolean
    doc: trace generated TurboFan graphs
    inputBinding:
      position: 101
      prefix: --trace-turbo-graph
  - id: trace_turbo_inlining
    type:
      - 'null'
      - boolean
    doc: trace TurboFan inlining
    inputBinding:
      position: 101
      prefix: --trace-turbo-inlining
  - id: trace_turbo_jt
    type:
      - 'null'
      - boolean
    doc: trace TurboFan's jump threading
    inputBinding:
      position: 101
      prefix: --trace-turbo-jt
  - id: trace_turbo_load_elimination
    type:
      - 'null'
      - boolean
    doc: trace TurboFan load elimination
    inputBinding:
      position: 101
      prefix: --trace-turbo-load-elimination
  - id: trace_turbo_loop
    type:
      - 'null'
      - boolean
    doc: trace TurboFan's loop optimizations
    inputBinding:
      position: 101
      prefix: --trace-turbo-loop
  - id: trace_turbo_path
    type:
      - 'null'
      - string
    doc: directory to dump generated TurboFan IR to
    inputBinding:
      position: 101
      prefix: --trace-turbo-path
  - id: trace_turbo_reduction
    type:
      - 'null'
      - boolean
    doc: trace TurboFan's various reducers
    inputBinding:
      position: 101
      prefix: --trace-turbo-reduction
  - id: trace_turbo_scheduled
    type:
      - 'null'
      - boolean
    doc: trace TurboFan IR with schedule
    inputBinding:
      position: 101
      prefix: --trace-turbo-scheduled
  - id: trace_turbo_scheduler
    type:
      - 'null'
      - boolean
    doc: trace TurboFan's scheduler
    inputBinding:
      position: 101
      prefix: --trace-turbo-scheduler
  - id: trace_turbo_stack_accesses
    type:
      - 'null'
      - boolean
    doc: trace stack load/store counters for optimized code in run-time (x64 
      only)
    inputBinding:
      position: 101
      prefix: --trace-turbo-stack-accesses
  - id: trace_turbo_trimming
    type:
      - 'null'
      - boolean
    doc: trace TurboFan's graph trimmer
    inputBinding:
      position: 101
      prefix: --trace-turbo-trimming
  - id: trace_turbo_types
    type:
      - 'null'
      - boolean
    doc: trace TurboFan's types
    inputBinding:
      position: 101
      prefix: --trace-turbo-types
  - id: trace_unmapper
    type:
      - 'null'
      - boolean
    doc: Trace the unmapping
    inputBinding:
      position: 101
      prefix: --trace-unmapper
  - id: trace_verify_csa
    type:
      - 'null'
      - boolean
    doc: trace code stubs verification
    inputBinding:
      position: 101
      prefix: --trace-verify-csa
  - id: trace_wasm
    type:
      - 'null'
      - boolean
    doc: trace wasm function calls
    inputBinding:
      position: 101
      prefix: --trace-wasm
  - id: trace_wasm_code_gc
    type:
      - 'null'
      - boolean
    doc: trace garbage collection of wasm code
    inputBinding:
      position: 101
      prefix: --trace-wasm-code-gc
  - id: trace_wasm_compilation_times
    type:
      - 'null'
      - boolean
    doc: print how long it took to compile each wasm function
    inputBinding:
      position: 101
      prefix: --trace-wasm-compilation-times
  - id: trace_wasm_inlining
    type:
      - 'null'
      - boolean
    doc: trace wasm inlining
    inputBinding:
      position: 101
      prefix: --trace-wasm-inlining
  - id: trace_wasm_memory
    type:
      - 'null'
      - boolean
    doc: print all memory updates performed in wasm code
    inputBinding:
      position: 101
      prefix: --trace-wasm-memory
  - id: trace_wasm_speculative_inlining
    type:
      - 'null'
      - boolean
    doc: trace wasm speculative inlining
    inputBinding:
      position: 101
      prefix: --trace-wasm-speculative-inlining
  - id: trace_web_snapshot
    type:
      - 'null'
      - boolean
    doc: trace web snapshot deserialization
    inputBinding:
      position: 101
      prefix: --trace-web-snapshot
  - id: trace_zone_stats
    type:
      - 'null'
      - boolean
    doc: trace zone memory usage
    inputBinding:
      position: 101
      prefix: --trace-zone-stats
  - id: trace_zone_type_stats
    type:
      - 'null'
      - boolean
    doc: trace per-type zone memory usage
    inputBinding:
      position: 101
      prefix: --trace-zone-type-stats
  - id: track_detached_contexts
    type:
      - 'null'
      - boolean
    doc: track native contexts that are expected to be garbage collected
    inputBinding:
      position: 101
      prefix: --track-detached-contexts
  - id: track_field_types
    type:
      - 'null'
      - boolean
    doc: track field types
    inputBinding:
      position: 101
      prefix: --track-field-types
  - id: track_gc_object_stats
    type:
      - 'null'
      - boolean
    doc: track object counts and memory usage
    inputBinding:
      position: 101
      prefix: --track-gc-object-stats
  - id: track_retaining_path
    type:
      - 'null'
      - boolean
    doc: enable support for tracking retaining path
    inputBinding:
      position: 101
      prefix: --track-retaining-path
  - id: turbo_allocation_folding
    type:
      - 'null'
      - boolean
    doc: TurboFan allocation folding
    inputBinding:
      position: 101
      prefix: --turbo-allocation-folding
  - id: turbo_cf_optimization
    type:
      - 'null'
      - boolean
    doc: optimize control flow in TurboFan
    inputBinding:
      position: 101
      prefix: --turbo-cf-optimization
  - id: turbo_collect_feedback_in_generic_lowering
    type:
      - 'null'
      - boolean
    doc: enable experimental feedback collection in generic lowering.
    inputBinding:
      position: 101
      prefix: --turbo-collect-feedback-in-generic-lowering
  - id: turbo_compress_translation_arrays
    type:
      - 'null'
      - boolean
    doc: compress translation arrays (experimental)
    inputBinding:
      position: 101
      prefix: --turbo-compress-translation-arrays
  - id: turbo_escape
    type:
      - 'null'
      - boolean
    doc: enable escape analysis
    inputBinding:
      position: 101
      prefix: --turbo-escape
  - id: turbo_fast_api_calls
    type:
      - 'null'
      - boolean
    doc: enable fast API calls from TurboFan
    inputBinding:
      position: 101
      prefix: --turbo-fast-api-calls
  - id: turbo_filter
    type:
      - 'null'
      - string
    doc: optimization filter for TurboFan compiler
    inputBinding:
      position: 101
      prefix: --turbo-filter
  - id: turbo_force_mid_tier_regalloc
    type:
      - 'null'
      - boolean
    doc: always use the mid-tier register allocator (for testing)
    inputBinding:
      position: 101
      prefix: --turbo-force-mid-tier-regalloc
  - id: turbo_inline_array_builtins
    type:
      - 'null'
      - boolean
    doc: inline array builtins in TurboFan code
    inputBinding:
      position: 101
      prefix: --turbo-inline-array-builtins
  - id: turbo_inline_js_wasm_calls
    type:
      - 'null'
      - boolean
    doc: inline JS->Wasm calls
    inputBinding:
      position: 101
      prefix: --turbo-inline-js-wasm-calls
  - id: turbo_inlining
    type:
      - 'null'
      - boolean
    doc: enable inlining in TurboFan
    inputBinding:
      position: 101
      prefix: --turbo-inlining
  - id: turbo_instruction_scheduling
    type:
      - 'null'
      - boolean
    doc: enable instruction scheduling in TurboFan
    inputBinding:
      position: 101
      prefix: --turbo-instruction-scheduling
  - id: turbo_jt
    type:
      - 'null'
      - boolean
    doc: enable jump threading in TurboFan
    inputBinding:
      position: 101
      prefix: --turbo-jt
  - id: turbo_load_elimination
    type:
      - 'null'
      - boolean
    doc: enable load elimination in TurboFan
    inputBinding:
      position: 101
      prefix: --turbo-load-elimination
  - id: turbo_loop_peeling
    type:
      - 'null'
      - boolean
    doc: TurboFan loop peeling
    inputBinding:
      position: 101
      prefix: --turbo-loop-peeling
  - id: turbo_loop_rotation
    type:
      - 'null'
      - boolean
    doc: TurboFan loop rotation
    inputBinding:
      position: 101
      prefix: --turbo-loop-rotation
  - id: turbo_loop_variable
    type:
      - 'null'
      - boolean
    doc: TurboFan loop variable optimization
    inputBinding:
      position: 101
      prefix: --turbo-loop-variable
  - id: turbo_move_optimization
    type:
      - 'null'
      - boolean
    doc: optimize gap moves in TurboFan
    inputBinding:
      position: 101
      prefix: --turbo-move-optimization
  - id: turbo_optimize_apply
    type:
      - 'null'
      - boolean
    doc: optimize Function.prototype.apply
    inputBinding:
      position: 101
      prefix: --turbo-optimize-apply
  - id: turbo_profiling
    type:
      - 'null'
      - boolean
    doc: enable basic block profiling in TurboFan
    inputBinding:
      position: 101
      prefix: --turbo-profiling
  - id: turbo_profiling_log_builtins
    type:
      - 'null'
      - boolean
    doc: emit data about basic block usage in builtins to v8.log (requires that 
      V8 was built with v8_enable_builtins_profiling=true)
    inputBinding:
      position: 101
      prefix: --turbo-profiling-log-builtins
  - id: turbo_profiling_log_file
    type:
      - 'null'
      - string
    doc: Path of the input file containing basic block counters for builtins. 
      (mksnapshot only)
    inputBinding:
      position: 101
      prefix: --turbo-profiling-log-file
  - id: turbo_profiling_verbose
    type:
      - 'null'
      - boolean
    doc: enable basic block profiling in TurboFan, and include each function's 
      schedule and disassembly in the output
    inputBinding:
      position: 101
      prefix: --turbo-profiling-verbose
  - id: turbo_rewrite_far_jumps
    type:
      - 'null'
      - boolean
    doc: rewrite far to near jumps (ia32,x64)
    inputBinding:
      position: 101
      prefix: --turbo-rewrite-far-jumps
  - id: turbo_sp_frame_access
    type:
      - 'null'
      - boolean
    doc: use stack pointer-relative access to frame wherever possible
    inputBinding:
      position: 101
      prefix: --turbo-sp-frame-access
  - id: turbo_splitting
    type:
      - 'null'
      - boolean
    doc: split nodes during scheduling in TurboFan
    inputBinding:
      position: 101
      prefix: --turbo-splitting
  - id: turbo_stats
    type:
      - 'null'
      - boolean
    doc: print TurboFan statistics
    inputBinding:
      position: 101
      prefix: --turbo-stats
  - id: turbo_stats_nvp
    type:
      - 'null'
      - boolean
    doc: print TurboFan statistics in machine-readable format
    inputBinding:
      position: 101
      prefix: --turbo-stats-nvp
  - id: turbo_stats_wasm
    type:
      - 'null'
      - boolean
    doc: print TurboFan statistics of wasm compilations
    inputBinding:
      position: 101
      prefix: --turbo-stats-wasm
  - id: turbo_store_elimination
    type:
      - 'null'
      - boolean
    doc: enable store-store elimination in TurboFan
    inputBinding:
      position: 101
      prefix: --turbo-store-elimination
  - id: turbo_stress_instruction_scheduling
    type:
      - 'null'
      - boolean
    doc: randomly schedule instructions to stress dependency tracking
    inputBinding:
      position: 101
      prefix: --turbo-stress-instruction-scheduling
  - id: turbo_use_mid_tier_regalloc_for_huge_functions
    type:
      - 'null'
      - boolean
    doc: fall back to the mid-tier register allocator for huge functions
    inputBinding:
      position: 101
      prefix: --turbo-use-mid-tier-regalloc-for-huge-functions
  - id: turbo_verify
    type:
      - 'null'
      - boolean
    doc: verify TurboFan graphs at each phase
    inputBinding:
      position: 101
      prefix: --turbo-verify
  - id: turbo_verify_allocation
    type:
      - 'null'
      - boolean
    doc: verify register allocation in TurboFan
    inputBinding:
      position: 101
      prefix: --turbo-verify-allocation
  - id: turbo_verify_machine_graph
    type:
      - 'null'
      - string
    doc: verify TurboFan machine graph before instruction selection
    inputBinding:
      position: 101
      prefix: --turbo-verify-machine-graph
  - id: unbox_double_arrays
    type:
      - 'null'
      - boolean
    doc: automatically unbox arrays of doubles
    inputBinding:
      position: 101
      prefix: --unbox-double-arrays
  - id: use_external_strings
    type:
      - 'null'
      - boolean
    doc: Use external strings for source code
    inputBinding:
      position: 101
      prefix: --use-external-strings
  - id: use_full_record_write_builtin
    type:
      - 'null'
      - boolean
    doc: Force use of full version of RecordWrite builtin.
    inputBinding:
      position: 101
      prefix: --use-full-record-write-builtin
  - id: use_ic
    type:
      - 'null'
      - boolean
    doc: use inline caching
    inputBinding:
      position: 101
      prefix: --use-ic
  - id: use_idle_notification
    type:
      - 'null'
      - boolean
    doc: Use idle notification to reduce memory footprint.
    inputBinding:
      position: 101
      prefix: --use-idle-notification
  - id: use_map_space
    type:
      - 'null'
      - boolean
    doc: Use separate space for maps.
    inputBinding:
      position: 101
      prefix: --use-map-space
  - id: use_marking_progress_bar
    type:
      - 'null'
      - boolean
    doc: Use a progress bar to scan large objects in increments when incremental
      marking is active.
    inputBinding:
      position: 101
      prefix: --use-marking-progress-bar
  - id: use_osr
    type:
      - 'null'
      - boolean
    doc: use on-stack replacement
    inputBinding:
      position: 101
      prefix: --use-osr
  - id: use_strict
    type:
      - 'null'
      - boolean
    doc: enforce strict mode
    inputBinding:
      position: 101
      prefix: --use-strict
  - id: v8_os_page_size
    type:
      - 'null'
      - int
    doc: override OS page size (in KBytes)
    inputBinding:
      position: 101
      prefix: --v8-os-page-size
  - id: validate_asm
    type:
      - 'null'
      - boolean
    doc: validate asm.js modules before compiling
    inputBinding:
      position: 101
      prefix: --validate-asm
  - id: verify_simplified_lowering
    type:
      - 'null'
      - boolean
    doc: verify graph generated by simplified lowering
    inputBinding:
      position: 101
      prefix: --verify-simplified-lowering
  - id: verify_snapshot_checksum
    type:
      - 'null'
      - boolean
    doc: Verify snapshot checksums when deserializing snapshots. Enable checksum
      creation and verification for code caches.
    inputBinding:
      position: 101
      prefix: --verify-snapshot-checksum
  - id: vtune_prof_annotate_wasm
    type:
      - 'null'
      - boolean
    doc: Used when v8_enable_vtunejit is enabled, load wasm source map and 
      provide annotate support (experimental).
    inputBinding:
      position: 101
      prefix: --vtune-prof-annotate-wasm
  - id: wasm_async_compilation
    type:
      - 'null'
      - boolean
    doc: enable actual asynchronous compilation for WebAssembly.compile
    inputBinding:
      position: 101
      prefix: --wasm-async-compilation
  - id: wasm_bounds_checks
    type:
      - 'null'
      - boolean
    doc: enable bounds checks (disable for performance testing only)
    inputBinding:
      position: 101
      prefix: --wasm-bounds-checks
  - id: wasm_caching_threshold
    type:
      - 'null'
      - int
    doc: the amount of wasm top tier code that triggers the next caching event
    inputBinding:
      position: 101
      prefix: --wasm-caching-threshold
  - id: wasm_code_gc
    type:
      - 'null'
      - boolean
    doc: enable garbage collection of wasm code
    inputBinding:
      position: 101
      prefix: --wasm-code-gc
  - id: wasm_debug_mask_for_testing
    type:
      - 'null'
      - int
    doc: bitmask of functions to compile for debugging, only applies if the tier
      is Liftoff
    inputBinding:
      position: 101
      prefix: --wasm-debug-mask-for-testing
  - id: wasm_dynamic_tiering
    type:
      - 'null'
      - boolean
    doc: enable dynamic tier up to the optimizing compiler
    inputBinding:
      position: 101
      prefix: --wasm-dynamic-tiering
  - id: wasm_enforce_bounds_checks
    type:
      - 'null'
      - boolean
    doc: enforce explicit bounds check even if the trap handler is available
    inputBinding:
      position: 101
      prefix: --wasm-enforce-bounds-checks
  - id: wasm_fuzzer_gen_test
    type:
      - 'null'
      - boolean
    doc: generate a test case when running a wasm fuzzer
    inputBinding:
      position: 101
      prefix: --wasm-fuzzer-gen-test
  - id: wasm_gc_js_interop
    type:
      - 'null'
      - boolean
    doc: experimental WasmGC-JS interop
    inputBinding:
      position: 101
      prefix: --wasm-gc-js-interop
  - id: wasm_generic_wrapper
    type:
      - 'null'
      - boolean
    doc: allow use of the generic js-to-wasm wrapper instead of per-signature 
      wrappers
    inputBinding:
      position: 101
      prefix: --wasm-generic-wrapper
  - id: wasm_inlining
    type:
      - 'null'
      - boolean
    doc: enable inlining of wasm functions into wasm functions (experimental)
    inputBinding:
      position: 101
      prefix: --wasm-inlining
  - id: wasm_inlining_budget_factor
    type:
      - 'null'
      - string
    doc: maximum allowed size to inline a function is given by {n / caller size}
    inputBinding:
      position: 101
      prefix: --wasm-inlining-budget-factor
  - id: wasm_inlining_max_size
    type:
      - 'null'
      - string
    doc: maximum size of a function that can be inlined, in TF nodes
    inputBinding:
      position: 101
      prefix: --wasm-inlining-max-size
  - id: wasm_lazy_compilation
    type:
      - 'null'
      - boolean
    doc: enable lazy compilation for all wasm modules
    inputBinding:
      position: 101
      prefix: --wasm-lazy-compilation
  - id: wasm_lazy_validation
    type:
      - 'null'
      - boolean
    doc: enable lazy validation for lazily compiled wasm functions
    inputBinding:
      position: 101
      prefix: --wasm-lazy-validation
  - id: wasm_loop_peeling
    type:
      - 'null'
      - boolean
    doc: enable loop peeling for wasm functions
    inputBinding:
      position: 101
      prefix: --wasm-loop-peeling
  - id: wasm_loop_unrolling
    type:
      - 'null'
      - boolean
    doc: enable loop unrolling for wasm functions
    inputBinding:
      position: 101
      prefix: --wasm-loop-unrolling
  - id: wasm_math_intrinsics
    type:
      - 'null'
      - boolean
    doc: intrinsify some Math imports into wasm
    inputBinding:
      position: 101
      prefix: --wasm-math-intrinsics
  - id: wasm_max_code_space
    type:
      - 'null'
      - string
    doc: maximum committed code space for wasm (in MB)
    inputBinding:
      position: 101
      prefix: --wasm-max-code-space
  - id: wasm_max_initial_code_space_reservation
    type:
      - 'null'
      - int
    doc: maximum size of the initial wasm code space reservation (in MB)
    inputBinding:
      position: 101
      prefix: --wasm-max-initial-code-space-reservation
  - id: wasm_max_mem_pages
    type:
      - 'null'
      - string
    doc: maximum number of 64KiB memory pages per wasm memory
    inputBinding:
      position: 101
      prefix: --wasm-max-mem-pages
  - id: wasm_max_table_size
    type:
      - 'null'
      - string
    doc: maximum table size of a wasm instance
    inputBinding:
      position: 101
      prefix: --wasm-max-table-size
  - id: wasm_memory_protection_keys
    type:
      - 'null'
      - boolean
    doc: protect wasm code memory with PKU if available (takes precedence over 
      --wasm-write-protect-code-memory)
    inputBinding:
      position: 101
      prefix: --wasm-memory-protection-keys
  - id: wasm_num_compilation_tasks
    type:
      - 'null'
      - int
    doc: maximum number of parallel compilation tasks for wasm
    inputBinding:
      position: 101
      prefix: --wasm-num-compilation-tasks
  - id: wasm_opt
    type:
      - 'null'
      - boolean
    doc: enable wasm optimization
    inputBinding:
      position: 101
      prefix: --wasm-opt
  - id: wasm_simd_ssse3_codegen
    type:
      - 'null'
      - boolean
    doc: allow wasm SIMD SSSE3 codegen
    inputBinding:
      position: 101
      prefix: --wasm-simd-ssse3-codegen
  - id: wasm_speculative_inlining
    type:
      - 'null'
      - boolean
    doc: enable speculative inlining of call_ref targets (experimental)
    inputBinding:
      position: 101
      prefix: --wasm-speculative-inlining
  - id: wasm_stack_checks
    type:
      - 'null'
      - boolean
    doc: enable stack checks (disable for performance testing only)
    inputBinding:
      position: 101
      prefix: --wasm-stack-checks
  - id: wasm_staging
    type:
      - 'null'
      - boolean
    doc: enable staged wasm features
    inputBinding:
      position: 101
      prefix: --wasm-staging
  - id: wasm_test_streaming
    type:
      - 'null'
      - boolean
    doc: use streaming compilation instead of async compilation for tests
    inputBinding:
      position: 101
      prefix: --wasm-test-streaming
  - id: wasm_tier_mask_for_testing
    type:
      - 'null'
      - int
    doc: bitmask of functions to compile with TurboFan instead of Liftoff
    inputBinding:
      position: 101
      prefix: --wasm-tier-mask-for-testing
  - id: wasm_tier_up
    type:
      - 'null'
      - boolean
    doc: enable tier up to the optimizing compiler (requires --liftoff to have 
      an effect)
    inputBinding:
      position: 101
      prefix: --wasm-tier-up
  - id: wasm_tier_up_filter
    type:
      - 'null'
      - int
    doc: only tier-up function with this index
    inputBinding:
      position: 101
      prefix: --wasm-tier-up-filter
  - id: wasm_tiering_budget
    type:
      - 'null'
      - int
    doc: budget for dynamic tiering (rough approximation of bytes executed)
    inputBinding:
      position: 101
      prefix: --wasm-tiering-budget
  - id: wasm_type_canonicalization
    type:
      - 'null'
      - boolean
    doc: apply isorecursive canonicalization on wasm types
    inputBinding:
      position: 101
      prefix: --wasm-type-canonicalization
  - id: wasm_write_protect_code_memory
    type:
      - 'null'
      - boolean
    doc: write protect code memory on the wasm native heap with mprotect
    inputBinding:
      position: 101
      prefix: --wasm-write-protect-code-memory
  - id: win64_unwinding_info
    type:
      - 'null'
      - boolean
    doc: Enable unwinding info for Windows/x64
    inputBinding:
      position: 101
      prefix: --win64-unwinding-info
  - id: write_code_using_rwx
    type:
      - 'null'
      - boolean
    doc: flip permissions to rwx to write page instead of rw
    inputBinding:
      position: 101
      prefix: --write-code-using-rwx
  - id: write_protect_code_memory
    type:
      - 'null'
      - boolean
    doc: write protect code memory
    inputBinding:
      position: 101
      prefix: --write-protect-code-memory
  - id: zone_stats_tolerance
    type:
      - 'null'
      - string
    doc: report a tick only when allocated zone memory changes by this amount
    inputBinding:
      position: 101
      prefix: --zone-stats-tolerance
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/k8:1.2--he8db53b_6
stdout: k8.out
