# Project 02 — Test Pass (Calculator)

> **Difficulty:** easy to medium
> **Loop concepts used:** Concept 5 — *conditional loop*; Concept 11 — *maker-checker*

This project is a tiny exercise in building a **maker-checker loop** with a
**conditional stop**. The point is not the calculator — it is the *loop* that
fixes the calculator.

## The idea

1. **Seed the repo with a few small failing tests.** Here,
   `test_calculator.py` has 5 assertions.
2. **Let the maker work.** The maker (an agent / you) edits `calculator.py`
   trying to satisfy the tests.
3. **Let the checker decide — not the maker.** The checker is the *test
   runner* (`pytest`). The maker is **not** allowed to declare victory; the
   command's exit code is the only source of truth.
4. **Run the loop conditionally** (Concept 5): keep fixing and re-running
   **while** the tests fail.
5. **Cap the loop** at, say, 6 tries so it cannot spin forever.

```
        +-------------------+
        |  edit calculator  |   <-- MAKER
        +-------------------+
                  |
                  v
        +-------------------+
        |  run pytest       |   <-- CHECKER (decides, not the maker)
        +-------------------+
                  |
          +-------+--------+
          |                |
       tests fail       tests pass
          |                |
   +------+       +--------+--------+
   |              |  STOP (done)    |
   v              +-----------------+
 try count < 6?
   |         yes --> STOP (hit cap)
   +--> loop again
```

## What this repo actually is

- `calculator.py` — five deliberately-wrong arithmetic functions that a maker
  must correct (`add`, `subtract`, `multiply`, `divide`, `square`).
- `test_calculator.py` — five small tests. They start red.
- `README.md` — this file.

The lesson: **the loop stops because the checker said pass, not because it
ran out of tries.** If it kept hitting the 6-try cap, that is a signal the
stop condition (or the maker's instructions) needed work — not a "success."


**command of clude code**   
```
/goal Fix the failing tests in test_calculator.py. Run pytest after each fix and keep working until all tests pass, maximum 6 tries.

```

## Outcome of this run

The maker fixed all five functions in a single try; `pytest` reported
`5 passed`, so the loop stopped on the checker's signal rather than the cap.

```
test_calculator.py::test_add PASSED
test_calculator.py::test_subtract PASSED
test_calculator.py::test_multiply PASSED
test_calculator.py::test_divide PASSED
test_calculator.py::test_square PASSED

============================== 5 passed ===============================
```

## How to reproduce the loop

From inside `Project_02_Test_Pass/`:

```bash
python -m pytest test_calculator.py -v
```

- Exit code `0` → tests pass → the conditional loop ends (success).
- Exit code non-zero → tests fail → maker edits again, re-runs, until the cap.

## Requirements

- Python 3
- [pytest](https://docs.pytest.org/)
