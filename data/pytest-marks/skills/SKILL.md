---
name: pytest-marks
description: This tool enables the use of fixtures within pytest marks by resolving them lazily at test execution time. Use when user asks to use fixtures in parametrize decorators, reference fixtures by name in marks, or create dynamic test matrices using lazy fixture wrappers.
homepage: https://github.com/TvoroG/pytest-lazy-fixture
metadata:
  docker_image: "quay.io/biocontainers/pytest-marks:0.4--py27_0"
---

# pytest-marks

## Overview
The pytest-marks skill (utilizing the `pytest-lazy-fixture` plugin) enables the use of fixtures within pytest marks. Standard pytest behavior requires mark arguments to be static values because decorators are evaluated at import time, before fixtures are executed. This skill provides a workaround by allowing you to reference fixtures by name using a "lazy" wrapper, which resolves the fixture value only when the test is actually called. This is particularly powerful for complex test matrices where parameters are generated dynamically or depend on environment-specific setup.

## Installation
To enable this functionality, the plugin must be installed in your environment:
```bash
pip install pytest-lazy-fixture
```

## Core Usage Patterns

### Using Fixtures in Parametrize
The most common use case is passing a fixture as a value in a `@pytest.mark.parametrize` list.

```python
import pytest
from pytest_lazyfixture import lazy_fixture

@pytest.fixture
def sample_data():
    return {"key": "value"}

@pytest.mark.parametrize('arg1, arg2', [
    ('static_val', lazy_fixture('sample_data')),
])
def test_with_lazy_fixture(arg1, arg2):
    assert arg2["key"] == "value"
```

### Parametrized Fixtures as Inputs
You can reference fixtures that are themselves parametrized. Pytest will expand the test cases to cover all combinations of the lazy fixture's parameters.

```python
@pytest.fixture(params=[1, 2])
def dynamic_num(request):
    return request.param

@pytest.mark.parametrize('input_val', [
    lazy_fixture('dynamic_num'),
    3
])
def test_combinations(input_val):
    assert input_val in [1, 2, 3]
```

### Nesting Fixtures
You can use `lazy_fixture` to define a fixture that chooses between other fixtures based on parameters.

```python
@pytest.fixture(params=[lazy_fixture('fixture_a'), lazy_fixture('fixture_b')])
def composite_fixture(request):
    return request.param
```

## Expert Tips and Best Practices

- **String References**: Always pass the name of the fixture as a string to `lazy_fixture('')`.
- **Avoid Circular Dependencies**: Ensure that the fixture being called lazily does not depend on the test function or fixture currently being defined.
- **Test Discovery**: Be aware that using multiple lazy fixtures in a single parametrization can significantly increase the number of generated test cases. Use `pytest --collect-only` to verify the test suite structure.
- **Compatibility**: This pattern is specifically designed for `pytest.mark.parametrize` and `pytest.fixture(params=...)`. It may not behave as expected in custom marks unless the plugin's logic is explicitly supported.

## Reference documentation
- [GitHub - TvoroG/pytest-lazy-fixture](./references/github_com_TvoroG_pytest-lazy-fixture.md)
- [Tests and Examples](./references/github_com_TvoroG_pytest-lazy-fixture_tree_master_tests.md)