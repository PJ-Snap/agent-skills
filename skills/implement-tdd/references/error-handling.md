# Error Handling Consistency

Use this only when a task introduces or modifies error handling behavior.

## Core Rules

- Keep one clear owner per error path:
  - Utility/service layer raises typed exceptions or returns typed failure values.
  - Handler/boundary layer logs and maps failures to user-visible outcomes.
- Log once at the boundary where context is best; avoid duplicate logs for the same
  failure.
- Use structured logging helpers already used in the codebase (for example
  `log_exception`) instead of ad-hoc `logger.error(..., exc_info=True)` in new code.
- Never log raw secrets or sensitive tokens; sanitize exception messages and extras.
- Replace bare `except Exception:` with `except Exception as e:` when logging or
  re-raising.
- Re-raise when the caller must decide recovery; only swallow exceptions when the
  flow is intentionally best-effort.

## Decision Guide

1. Is this a recoverable domain/validation failure?
   - Return a typed/domain error result or raise a specific exception.
2. Is this an unexpected system/runtime failure?
   - Log with action context, preserve traceback, then map to a safe user message.
3. Is this best-effort background/telemetry behavior?
   - Catch narrowly, log at warning/error level, continue without breaking primary flow.

## Consistency Checklist

- Action text is explicit and stable (for example `"save view"`).
- User-facing messages stay generic and non-sensitive.
- Retry metadata/state is included where retry logic exists.
- Tests cover at least one failure path and verify mapped behavior.
