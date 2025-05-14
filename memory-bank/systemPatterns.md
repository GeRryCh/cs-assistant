# System Patterns

This section documents the core architecture, design patterns, and component relationships.

## 1. Modular Layering
- **CLI Layer** (`src/main.py`):  
  - Handles argument parsing, command dispatch (`create-config`, `solve`), and environment setup.
  - Implements command handlers for each specific command.
  - Uses a spinner for user feedback during API calls.
- **Configuration Layer** (`src/config.py`, `config.schema.json`):  
  - Strongly-typed `Config` classes built with Python `dataclasses`.
  - `code_implementations` is now a direct list of strings in `SolveConfig` and `config.schema.json`.
  - Two construction paths: JSON file (`Config.from_json`) and CLI args (`Config.from_args`).  
  - JSON Schema ensures user-provided configuration matches expected structure.  
- **API Client Layer** (`src/api_clients.py`):
  - Adapters for OpenAI, Google Gemini, and Anthropic.  
  - Unified interface returning raw JSON strings for downstream parsing.
  - Each adapter includes proper error handling and structured error responses.
- **Solver Layer** (`src/solve.py`):  
  - `IssueSolver` orchestrates prompt construction, API calls, JSON parsing, and file output.  
  - Single-responsibility methods (`_build_system_prompt`, `_build_user_prompt`, etc.)  
  - Field-specific processors (`_process_verbal_algorithm`, `_process_code_implementations`, etc.)
  - Sanitization utility for safe filenames.  
- **LLM Config Layer** (`src/llm_config.py`):
  - Defines model providers via ModelProvider enum.
  - LLMConfig dataclass encapsulates model configuration and provider determination.
- **Utility Layer** (`src/spinner.py`, `src/constants.py`):  
  - CLI feedback (spinner, colored output).  
  - Shared constants (ANSI color codes).

## 2. Key Design Patterns
- **Builder Pattern**:  
  - Incremental assembly of system and user prompts based on selected fields.  
  - Used in `_build_system_prompt` and `_build_user_prompt` methods.
- **Factory Method**:  
  - `Config.from_json` and `Config.from_args` select proper instantiation path.  
- **Strategy Pattern**:  
  - API caller selection via `self.api_callers` mapping by `ModelProvider`.  
- **Template Method**:  
  - In `IssueSolver.solve()`, high-level algorithm: prompt → call → parse → dispatch to field processors.  
- **Separation of Concerns**:  
  - Parsing & validation isolated in `Config`.  
  - I/O and file creation isolated in solver methods.  
  - Networking and API details isolated in `api_clients.py`.
  - Model provider determination isolated in `llm_config.py`.

## 3. Component Relationships
```
main → Config → IssueSolver → api_clients → external LLM APIs
   ↘ Config ← LLMConfig
      ↘ Spinner → console
      ↘ Path & filesystem → cs-assistant-output
```

## 4. Critical Execution Paths
1. **create-config**  
   `main` → `_load_environment_variables` → `Config()` → file write  
2. **solve**  
   `main` → `resolve_config` → `IssueSolver.solve`  
   → `_build_system_prompt` & `_build_user_prompt`  
   → `api_clients.call_*_api` → JSON cleaning/parsing  
   → `_process_*` methods → output files
