## 📂 Project Structure
- `mobile-app-tests/tests/`: Contains the `.robot` test suites.
- `mobile-app-tests/screens/`: Contains Page Objects and logic-based keywords.
- `shared/`: Contains global keywords for app lifecycle.

### iOS Execution
To execute tests on iOS devices, use the following commands:

Run all Regression tests:
` robot --variable PLATFORM:iOS --include regression mobile-app-tests/tests/one_tap_fuelling.robot`

Run specific Smoke test:
` robot --variable PLATFORM:iOS --include smoke mobile-app-tests/tests/one_tap_fuelling.robot`

Run a single Test Case by Tag:
` robot --variable PLATFORM:iOS --include FL-2135 mobile-app-tests/tests/one_tap_fuelling.robot`

### Android Execution
To execute tests on Android devices, simply change the PLATFORM variable:

Run all Regression tests:
`robot --variable PLATFORM:Android --include regression mobile-app-tests/tests/one_tap_fuelling.robot`

Run Negative scenarios:
`robot --variable PLATFORM:Android --include negative mobile-app-tests/tests/one_tap_fuelling.robot`

### Tagging System Documentation
- `smoke`: Critical path tests for quick verification.
- `regression`: Full feature validation.
- `negative`: Error handling and invalid input scenarios.
- `disabled`: Tests currently skipped to match production environment setup.