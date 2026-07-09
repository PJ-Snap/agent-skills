# Good and Bad Tests

## Good Tests

**Behavior-focused**: Test through real interfaces, not mocks of internal parts. Boundary dependencies (like databases and external APIs) should still be mocked.

```python
# GOOD: Tests observable behavior
def test_user_can_checkout_with_valid_cart():
    # Arrange
    cart = create_cart()
    cart.add(product)

    # Act
    result = checkout(cart, payment_method)

    # Assert
    assert result.status == "confirmed"
```

Characteristics:

- Tests behavior users/callers care about
- Name describes the behavior: `test_<who/what>_<expected outcome>_<condition>`
- Uses public API only
- Survives internal refactors
- Describes WHAT, not HOW
- One behavior per test (multiple asserts verifying the same behavior are fine)

## Bad Tests

**Implementation-detail tests**: Coupled to internal structure.

```python
# BAD: Tests implementation details
def test_checkout_calls_payment_service_process(mocker):
    # Arrange
    mock_payment = mocker.patch("app.payment_service")

    # Act
    checkout(cart, payment)

    # Assert
    mock_payment.process.assert_called_once_with(cart.total)
```

Red flags:

- Mocking internal collaborators
- Testing private methods
- Asserting on call counts/order
- Test breaks when refactoring without behavior change
- Test name describes HOW not WHAT
- Verifying through external means instead of interface

```python
# BAD: Bypasses interface to verify
def test_create_user_saves_to_database(db_session):
    # Act
    create_user(name="Alice")

    # Assert
    row = db_session.execute("SELECT * FROM users WHERE name = :n", {"n": "Alice"}).first()
    assert row is not None

# GOOD: Verifies through interface
def test_create_user_makes_user_retrievable():
    # Act
    user = create_user(name="Alice")

    # Assert
    retrieved = get_user(user.id)
    assert retrieved.name == "Alice"
```

## Refactor Litmus Test

If a test breaks after a refactor that didn't change behavior, the test is
coupled to implementation. Fix the test, not the refactor.

## Guardrails

- Place tests in `tests/` next to the code under test.
- Keep test bodies free of logic (no `if`, `for`, `while`) — conditional test logic hides which path actually ran and makes failures harder to diagnose.
- Follow `test_<who/what>_<expected outcome>_<condition>` naming.
- Use `@pytest.mark.parametrize` instead of duplicate tests or loops.
- Keep fixture chains shallow — three or more chained fixtures signals the setup is too complex for a unit test.
- Import all dependencies at the top of the test file — scattered imports inside test functions obscure what a test depends on and break when mocks patch at the wrong scope.
- Keep unit tests fast (0.1s guardrail): measure per-test wall-clock time from pytest output (e.g., with `--durations` in CI), fail CI when any unit test exceeds 0.1s, and when it does either refactor/add boundary mocks or reclassify it as integration/slow.
- For each new test block (or test class), include a short note: `Why this test survives refactoring: <one sentence>`.
