# Technology Context

This section outlines the technologies, dependencies, and development setup for CS Assistant.

## Languages and Runtime
- Python 3.8+  
- Uses standard library modules: `argparse`, `json`, `pathlib`, `re`, `dataclasses`, `typing`, `os`, `sys`

## Dependencies
- LLM Providers
  - `openai` (OpenAI Python SDK)  
  - `google-generativeai` (Google Gemini client)  
  - `anthropic` (Anthropic Claude client)  
- Environment and Configuration  
  - `python-dotenv` for loading `.csarc` file  
- Testing  
  - `pytest` for unit tests  
- User Interface
  - ANSI color codes for terminal output formatting
  - Custom spinner implementation for visual feedback during API calls

## Configuration Patterns
- JSON Schema (`config.schema.json`) enforces shape of `config.json`.
  - The `code_implementations` field within `solve` is now a direct array of strings, rather than a nested object.
- `Config` dataclasses enable strongly-typed, immutable configuration.
  - `SolveConfig.code_implementations` is now `Optional[List[str]]`.
- Two config instantiation paths:
  1. `Config.from_json` parses and validates JSON file  
  2. `Config.from_args` builds from CLI flags

## Project Structure
```
/
├── src/
│   ├── main.py           # CLI entry point
│   ├── config.py         # Dataclass definitions and JSON parsing
│   ├── llm_config.py     # Model provider enum and helpers
│   ├── api_clients.py    # Wrappers for each LLM API
│   ├── solve.py          # Core IssueSolver implementation
│   ├── spinner.py        # Console spinner utility
│   └── constants.py      # ANSI color codes and other constants
├── tests/
│   ├── __init__.py       # Package marker
│   └── test_api_clients.py  # Unit tests for API client wrappers
├── memory-bank/          # Project documentation & context
├── config.schema.json    # JSON schema for user config
├── pyproject.toml        # Build and packaging configuration
├── requirements.txt      # Runtime dependencies
└── cs-assistant-output/  # Generated solutions (read-only)
```

## Development Setup
1. Clone repository  
2. Create virtual environment:
   ```bash
   python3 -m venv venv
   source venv/bin/activate
   ```
3. Install dependencies:
   ```bash
   pip install -r requirements.txt
   ```
4. Run tests:
   ```bash
   pytest
   ```
5. Create default config:
   ```bash
   python3 -m src.main create-config
   ```
6. Configure API keys in `~/.config/cs_assistant/.csarc`

## API Integration
- OpenAI: Uses the `openai` Python library with JSON response format
- Google: Uses `google.generativeai` with response MIME type configuration
- Anthropic: Uses the `anthropic` library with tool use for structured output
- All API clients include error handling and return structured JSON responses

## Testing Strategy
- Unit tests for API clients focus on connectivity verification
- API test models chosen for cost-effectiveness and reliability
- Future test expansion needed for solver functionality
