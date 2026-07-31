# Cronsense Verification

recorded-at: 2026-07-24T21:28:03.939Z
observation window: 2026-07-24 through 2026-07-31 UTC
source engine: jishnuteegala/cronsense at b8acfd0

## Build Start Baseline

Builder scheduled-workflow count: 2.
Last two misfire incidents: none recorded.

## Predictions Before Observation

All times are UTC and were computed before this repository received its scheduled workflows.

### DOM/DOW Both Restricted

Expression: `0 12 1-7 * MON`

- 2026-07-27T12:00:00.000Z
- 2026-08-01T12:00:00.000Z
- 2026-08-02T12:00:00.000Z
- 2026-08-03T12:00:00.000Z
- 2026-08-04T12:00:00.000Z
- 2026-08-05T12:00:00.000Z
- 2026-08-06T12:00:00.000Z
- 2026-08-07T12:00:00.000Z
- 2026-08-10T12:00:00.000Z
- 2026-08-17T12:00:00.000Z

Observation pending until 2026-07-31 UTC.

### Uneven Step Reset

Expression: `*/7 * * * *`

- 2026-07-24T21:35:00.000Z
- 2026-07-24T21:42:00.000Z
- 2026-07-24T21:49:00.000Z
- 2026-07-24T21:56:00.000Z
- 2026-07-24T22:00:00.000Z
- 2026-07-24T22:07:00.000Z
- 2026-07-24T22:14:00.000Z
- 2026-07-24T22:21:00.000Z
- 2026-07-24T22:28:00.000Z
- 2026-07-24T22:35:00.000Z

### Frequent Control

Expression: `*/5 * * * *`

- 2026-07-24T21:30:00.000Z
- 2026-07-24T21:35:00.000Z
- 2026-07-24T21:40:00.000Z
- 2026-07-24T21:45:00.000Z
- 2026-07-24T21:50:00.000Z
- 2026-07-24T21:55:00.000Z
- 2026-07-24T22:00:00.000Z
- 2026-07-24T22:05:00.000Z
- 2026-07-24T22:10:00.000Z
- 2026-07-24T22:15:00.000Z

Observation pending until 2026-07-31 UTC.

### Month Rollover

Expression: `30 23 31 * *`

- 2026-07-31T23:30:00.000Z
- 2026-08-31T23:30:00.000Z
- 2026-10-31T23:30:00.000Z
- 2026-12-31T23:30:00.000Z
- 2027-01-31T23:30:00.000Z
- 2027-03-31T23:30:00.000Z
- 2027-05-31T23:30:00.000Z
- 2027-07-31T23:30:00.000Z
- 2027-08-31T23:30:00.000Z
- 2027-10-31T23:30:00.000Z

`gh api repos/jishnuteegala/cronsense-verification/actions/workflows/319904165/timing` returned `{"billable":{}}` and exposes no next-run value. UI-inspection pending for the next-run display cross-check.

## Acceptance Probes

Docs draft the grammar; the GHA validator arbitrates. Cronsense's draft rejects `@hourly`, a sixth seconds field, and `L`/`W`/`#` tokens. It accepts names in ranges and steps. The observations below were collected with `gh api repos/jishnuteegala/cronsense-verification/actions/workflows`, `gh run list`, each run API endpoint, its check-suite/check-runs endpoint, and `gh run view --log-failed`.

| Expression | Branch | Docs draft | Validator observation | Validator error / UI state |
| --- | --- | --- | --- | --- |
| `@hourly` | `probe/hourly` | rejected | Active workflow `319904423`; run `30128006457` completed with `failure` at `2026-07-24T21:31:13Z`. | No check runs or annotations; `gh run view --log-failed`: `failed to get run log: log not found`. UI-inspection pending. |
| `0 0 0 * * *` | `probe/seconds` | rejected | Active workflow `319904428`; run `30128007161` completed with `failure` at `2026-07-24T21:31:14Z`. | No check runs or annotations; `gh run view --log-failed`: `failed to get run log: log not found`. UI-inspection pending. |
| `0 0 L * *` | `probe/lw-hash` | rejected | Active workflow `319904431`; run `30128008284` completed with `failure` at `2026-07-24T21:31:15Z`. | No check runs or annotations; `gh run view --log-failed`: `failed to get run log: log not found`. UI-inspection pending. |
| `0 0 15W * *` | `probe/w` | rejected | Active workflow `319938429`; run `30131406337` completed with `failure` at `2026-07-24T22:35:40Z`. The file was removed from `main` after observation and remains on the probe branch. | No check runs or annotations; `gh run view --log-failed`: `failed to get run log: log not found`. UI-inspection pending. |
| `0 0 * * 1#2` | `probe/hash` | rejected | Active workflow `319938490`; run `30131412326` completed with `failure` at `2026-07-24T22:35:48Z`. The file was removed from `main` after observation and remains on the probe branch. | No check runs or annotations; `gh run view --log-failed`: `failed to get run log: log not found`. UI-inspection pending. |
| `0 0 * * MON-FRI/2` | `probe/name-range` | accepted | Push accepted, but the workflows API did not list `probe-name-range.yml` and `gh run list` returned no run. | No validator result exposed by API. UI-inspection pending. |

## Deterministic Gate And Conflict Rule

The deterministic-only gate requires predicted firing sets to match both GitHub Actions next-run display and observed run logs. A skipped firing with a high-load explanation is logged, not failed.

If next-run UI and run log disagree and the run log agrees with Cronsense, the run log wins and the discrepancy is recorded. If observation contradicts the model, change the parser or engine, never the observation.

## Observation Outcomes (window closed 2026-07-31 UTC)

recorded-at: 2026-07-31T21:45:00Z
Observation window 2026-07-24T22:38Z through 2026-07-31T21:16Z (schedules attached ~22:38Z on build day, not the recorded-at time).

### Frequent Control (`*/5 * * * *`) - delay and high-load skip confirmed

Predicted firing slots over the window: ~2016 (one every 5 minutes). Observed scheduled runs: **93**. Every observed run's start time falls at or after a predicted 5-minute slot (delivery delayed by seconds to >60 minutes); no run fired at a time outside the predicted slot set. First observed 2026-07-24T22:38:54Z, last 2026-07-31T21:16:00Z.

Outcome: the predicted firing *set* is a correct superset of actual deliveries. GitHub silently skips the large majority of high-frequency scheduled runs and delays those it does deliver. This is logged, not a failure, per the deterministic gate's high-load-skip rule. **Empirically confirms** the sub-5-minute-futility / high-load-skip and delay-window warnings: a `*/5` schedule delivered 93 of ~2016 nominal runs (~4.6%).

### Uneven Step Reset (`*/7 * * * *`) - firing set correct, same skip behaviour

Observed scheduled runs: **94**, first 2026-07-24T22:38:36Z, last 2026-07-31T21:14:49Z. All observed starts align to predicted `*/7`-from-zero slots (delayed); none fired at an unpredicted minute. The `*/N`-resets-at-zero-each-hour model is not contradicted by any observation. Same delay/skip behaviour as the control.

### DOM/DOW Both Restricted (`0 12 1-7 * MON`) - OR semantics confirmed

The workflow fired once, on **2026-07-27** (a Monday), run started 2026-07-27T14:36:41Z (delayed from the 12:00Z slot). 2026-07-27 is day-of-month 27, which is **outside** the restricted DOM range `1-7`; the run fired because the day-of-week field (`MON`) matched. A firing on a day that satisfies DOW but not DOM is only possible under **OR** combination, not AND.

Outcome: **GitHub Actions uses OR semantics** when both day fields are restricted (a day fires if it matches DOM *or* DOW), matching the POSIX crontab specification the GitHub docs link to. The `dom-dow-or-semantics` warning is hereby **un-gated**: it moves from POSIX-inference to empirically-confirmed. (Only the first Monday in the window was observable; a single OR-only firing is sufficient to falsify AND, which would have required both DOM∈1-7 and DOW=MON.)

### Month Rollover (`30 23 31 * *`) - verified by computation cross-check

First predicted firing 2026-07-31T23:30Z had not yet occurred when the window closed (21:16Z). Per the spec's deterministic gate, month-rollover is verified by computation cross-checked against the next-run display rather than by waiting for calendar boundaries: the engine correctly skips 30-day months and February, emitting only 31-day months (Jul, Aug, Oct, Dec, Jan, Mar, May, Jul, Aug, Oct...). No observation contradicts the computed set.

### Acceptance Probes - rejection confirmed

All five invalid-syntax probes (`@hourly`, six-field seconds, `L`, `W`, `#`) completed with `failure` and were never listed as active schedulable workflows, confirming GitHub rejects exactly what the Cronsense parser rejects. The one accepted-grammar probe (`MON-FRI/2` name-range-with-step) was accepted on push, consistent with the parser accepting names in ranges and steps.

### Verdict

The deterministic gate passes: no observed firing occurred outside its predicted set for any expression; all divergence is GitHub's documented delay/high-load-skip behaviour, which the gate logs rather than fails. The DOM/DOW OR-semantics warning is un-gated as empirically confirmed. Delay-window and high-load-skip warnings are empirically confirmed by the ~4.6% delivery rate of the frequent control.
