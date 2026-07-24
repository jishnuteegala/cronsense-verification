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

Pending GitHub Actions next-run UI inspection.

## Acceptance Probes

Docs draft the grammar; the GHA validator arbitrates. Cronsense's draft rejects `@hourly`, a sixth seconds field, and `L`/`W`/`#` tokens. It accepts names in ranges and steps. The observations below were collected with `gh api repos/jishnuteegala/cronsense-verification/actions/workflows`, `gh run list`, each run API endpoint, its check-suite/check-runs endpoint, and `gh run view --log-failed`.

| Expression | Branch | Docs draft | Validator observation | Validator error / UI state |
| --- | --- | --- | --- | --- |
| `@hourly` | `probe/hourly` | rejected | Active workflow `319904423`; run `30128006457` completed with `failure` at `2026-07-24T21:31:13Z`. | No check runs or annotations; `gh run view --log-failed`: `failed to get run log: log not found`. UI-inspection pending. |
| `0 0 0 * * *` | `probe/seconds` | rejected | Active workflow `319904428`; run `30128007161` completed with `failure` at `2026-07-24T21:31:14Z`. | No check runs or annotations; `gh run view --log-failed`: `failed to get run log: log not found`. UI-inspection pending. |
| `0 0 L * *` | `probe/lw-hash` | rejected | Active workflow `319904431`; run `30128008284` completed with `failure` at `2026-07-24T21:31:15Z`. | No check runs or annotations; `gh run view --log-failed`: `failed to get run log: log not found`. UI-inspection pending. |
| `0 0 15W * *` | `probe/w` | rejected | Active workflow `319938429`; run `30131406337` completed with `failure` at `2026-07-24T22:35:40Z`. | No check runs or annotations; `gh run view --log-failed`: `failed to get run log: log not found`. UI-inspection pending. |
| `0 0 * * 1#2` | `probe/hash` | rejected | Active workflow `319938490`; run `30131412326` completed with `failure` at `2026-07-24T22:35:48Z`. | No check runs or annotations; `gh run view --log-failed`: `failed to get run log: log not found`. UI-inspection pending. |
| `0 0 * * MON-FRI/2` | `probe/name-range` | accepted | Push accepted, but the workflows API did not list `probe-name-range.yml` and `gh run list` returned no run. | No validator result exposed by API. UI-inspection pending. |

## Deterministic Gate And Conflict Rule

The deterministic-only gate requires predicted firing sets to match both GitHub Actions next-run display and observed run logs. A skipped firing with a high-load explanation is logged, not failed.

If next-run UI and run log disagree and the run log agrees with Cronsense, the run log wins and the discrepancy is recorded. If observation contradicts the model, change the parser or engine, never the observation.
