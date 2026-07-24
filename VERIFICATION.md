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

Docs draft the grammar; the GHA validator arbitrates. Probe branches pushed without transport rejection are listed below. `gh api repos/.../actions/workflows` registered all listed files as active workflows, including the invalid candidates. This only establishes push acceptance and registration; UI inspection and any deferred validation result remain pending.

| Expression | Branch | Push/API result | UI validation |
| --- | --- | --- | --- |
| `@hourly` | `probe/hourly` | accepted; workflow registered | pending |
| `0 0 0 * * *` | `probe/seconds` | accepted; workflow registered | pending |
| `0 0 L * *` | `probe/lw-hash` | accepted; workflow registered | pending |
| `0 0 * * MON-FRI/2` | `probe/name-range` | accepted; not listed by workflows API | pending |

## Deterministic Gate And Conflict Rule

The deterministic-only gate requires predicted firing sets to match both GitHub Actions next-run display and observed run logs. A skipped firing with a high-load explanation is logged, not failed.

If next-run UI and run log disagree and the run log agrees with Cronsense, the run log wins and the discrepancy is recorded. If observation contradicts the model, change the parser or engine, never the observation.
