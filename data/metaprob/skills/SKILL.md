---
name: metaprob
description: Metaprob is an embedded probabilistic programming language designed for generative modeling and meta-programming custom inference algorithms. Use when user asks to define generative models with execution traces, write custom inference procedures using reflective constructs, or perform complex causal reasoning.
homepage: https://github.com/probcomp/metaprob
metadata:
  docker_image: "quay.io/biocontainers/metaprob:2--boost1.61_1"
---

# metaprob

## Overview
Metaprob is an embedded probabilistic programming language (PPL) designed for both modeling and meta-programming. Unlike traditional PPLs that treat inference as a black box, Metaprob allows you to write custom inference algorithms in user-space code using reflective constructs. It represents models as generative procedures that produce execution traces, which can then be manipulated, constrained, or scored. It is particularly useful for "theory of mind" modeling and complex causal reasoning where standard "do" operators need to be extended.

## Core Programming Patterns

### Defining Generative Models
Models are defined using the `gen` macro. Use the `at` operator to name random choices, which is essential for tracing and intervention.

```clojure
(def my-model
  (gen [n]
    (let [p (at "probability" uniform 0 1)]
      (map (fn [i] (at i flip p)) (range n)))))
```

### Tracing and Inference
The primary way to execute a model and obtain its metadata is through `infer-and-score`. This invokes a tracing interpreter.

*   **Basic Execution**: `(infer-and-score :procedure my-model :inputs [5])`
*   **Reflective Constructs**: Use `at` and `apply-at` to manage stochastic choices. Older versions used `trace-at`; ensure you are using the updated syntax for addressable choices.

### Inference Meta-programming
Because inference algorithms in Metaprob are themselves generative code, you can:
1.  Trace an inference algorithm's own execution.
2.  Apply importance samplers with non-trivial weights.
3.  Write custom samplers that use partial traces to specify interventions.

## Project Integration and CLI

### Environment Setup
Metaprob supports both the JVM and JavaScript environments.
*   **JVM (Clojure)**: Use for enterprise pipelines and heavy computation.
*   **Browser/Node (ClojureScript)**: Use for interactive data analysis tools.

### Dependency Management
Add Metaprob to your project using `deps.edn` or `project.clj`.
*   **Leiningen**: Add `[probcomp/metaprob "version"]` to your `:dependencies`.
*   **Clojure CLI**: Add `probcomp/metaprob {:mvn/version "..."}` to your `:deps`.

### Running Tests and REPL
Since Metaprob is an embedded language, you interact with it primarily through the Clojure REPL or build tools:
*   **Start REPL**: `lein repl` or `clj`
*   **Run Tests**: `lein test`
*   **Docker**: If using the provided Dockerfile, use `docker-compose up` to spin up a pre-configured environment including Jupyter notebooks for interactive modeling.

## Expert Tips
*   **Address Space**: Always provide unique identifiers to the `at` macro (e.g., using loop indices or descriptive strings). This ensures that traces are correctly mapped during inference.
*   **Stability Warning**: Metaprob is a research prototype. Be prepared for breaking changes in the API, especially regarding how traces are structured and manipulated.
*   **Performance**: For categorical distributions with very small weights, be aware of potential out-of-bounds errors in the current implementation.
*   **Math Backend**: The library uses Apache Commons Math for underlying distributions; refer to its documentation if you need to extend the `metaprob.prelude` with new distributions.

## Reference documentation
- [Metaprob README](./references/github_com_probcomp_metaprob.md)
- [Metaprob Issues](./references/github_com_probcomp_metaprob_issues.md)
- [Metaprob Wiki](./references/github_com_probcomp_metaprob_wiki.md)